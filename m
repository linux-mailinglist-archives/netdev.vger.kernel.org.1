Return-Path: <netdev+bounces-245269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF683CCA128
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 03:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA31E3016BAA
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C02741C6;
	Thu, 18 Dec 2025 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MErVgrfq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139262F657C
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024354; cv=none; b=hOIQ56UcNVpJHEiz8wdrE0tbmKEg3rzAs1A4Ug1JdIByZLGWl6xzV0q4NkE51bLPsPIEwDBJ4/pMRPW1AGpA/HWZnRLdXR+nhrjfneJ9U9QftPXz1Hkm+HcaM7XFUanqjLm/OBW8xkMsZnjJdnku9v5DLPe9D6Rw42CkYM5qQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024354; c=relaxed/simple;
	bh=B2uc005GpL8q8ai+eEMsIAxk4TSez58qjlYe8cqdycQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=pn4ljW78kxAo2HsEzVT/3Q8vpcY40c65DaDDhLbO8tzsrecWd1yyvaR1GG6YEfKmEqMo/3/bRDDEixGCLqnDnYKKKKDWMpWFgRyFLyny93DK9Tr3GSrI36hNtC1g3JmMtSfl90Ce9oelmrpODPIhLNU8br2ejooWHm1iOnukteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MErVgrfq; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-6597046fc87so44078eaf.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766024351; x=1766629151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IbfBBdCc/I5EHKIRpc9KvniVEJwYrfz+MeqT54O8YU=;
        b=MErVgrfqFN1qRsZmwk/kaPdDIwCj6gthBkoQG/ra3lzAvu6kyKAqtArv35VHtplEda
         AbDsz3xWfFYEE8+r1G7qUFIccQT0BhM6jgA8PBrse5sRjQ2dWmGBjBRO6qgrhVltFrHA
         Fu9L3zJAmLoIBEFMHy4jNghzenMPLFp8A56CUo3hGQTLKnpy5gm9UGCmFxa+76Hzunp5
         IN65ejHUPSFzCySc1qZtUwg2A1N7srLqeHYdn4GBSSE4gpxYb29R7c7ys39RCQpjEfrG
         By9anAirbmHjqN3GV4+XK16uYieRoXJZd3TUbDusYAqJeouJXil+/utX1bPfJYATDmiH
         fMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766024351; x=1766629151;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1IbfBBdCc/I5EHKIRpc9KvniVEJwYrfz+MeqT54O8YU=;
        b=Bp43luHHtzJz7LE+e+ggMgfunVnPxQNZo/iyndOIxkJaLaZ51RwMnk1f5BjerPiGEM
         KNfHGh96F1UAWgfwCZGQsd/eTy05aiexDmez4Q6sq9Ip+Tz/oSlLzPEXsN7LN4XF+cqm
         6HO9lmGqnNyetZnJeSc/kWlmdWt0kZN6f4LbSyMce8mHljB3Q2Br0r/FDPkZEkY/40UZ
         v2xSyogrL7ro+xjXKtiK2Lsj40qPgK6BslTXxn7YAR+vG52cQRtMU9dvODVbGLoovXC9
         drBuczza30EzSYZALkIPT1hpkrKnbIJC7JTO5HkOX7TGsAjOjstY7YyXRYP2rNudroTr
         d5UQ==
X-Gm-Message-State: AOJu0YzwrdFKiiZS+aPl3uAJcrN1b3v8s3WK0ybSW2IdYh08uX8JZyW+
	q+Ip1IbmaUSnQ8qUwrUmuBVpJ/VYo/CX1yuvUpTStJYlJsBrFMy4N/8FoVHoPJ0cwzcnz4Q0uj0
	yFBoZPborfA==
X-Gm-Gg: AY/fxX7oxb//ZTqp2nWyFk9GnYkeDHqpEY9gZgvsJBMLXeRINS0Jtk19rkRFcL4CmwO
	K6lD1wickFAurNRvfgjK4JRRiRiXElThMQ3GuSXKYXsbxtKC+IrbVrvXyXZlM6O2YHOSm3uqsVp
	JtZzYZS2ZV9aq3GLveO5Lyn+ur/LuggvEFcv3nADMHovm+VYv/I+cslWWzbcMWRuWj89crCXUSW
	YR+ISO1oy9aBZiSuxQt/7ZPqB0sWOCWp+g2/DFV3ljpcLzNxfA3qFdmlCThO/+QmgG9onYpmiH4
	NGyaYOxV78N6ODXNnV6NfuaxvWKHSPh8ikKx95VW5Sy0ojWJgHlugVxRNmc3rixl5ZEKJVuEdpd
	8R9DRvum9w/YzhZPaTbihl5C9ITbGuQXm/N7H5LCFqNQP6BcSv++xS8RJq9DxS7Ax+OqYDOpO9Q
	NXFuiRxYyY
X-Google-Smtp-Source: AGHT+IE02v70C6yjy4rnCwdW5GLNxvKluZloWR13Gs8tjKXpOkFy0GoVyIWmp4KX9R8akbQ+1spL7g==
X-Received: by 2002:a05:6820:22a5:b0:65d:30d:eaf3 with SMTP id 006d021491bc7-65d030dee1bmr93942eaf.42.1766024350627;
        Wed, 17 Dec 2025 18:19:10 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17d5cac0sm768580fac.6.2025.12.17.18.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 18:19:09 -0800 (PST)
Message-ID: <ca5fe77f-f7a8-4886-b874-0e7063622ab7@kernel.dk>
Date: Wed, 17 Dec 2025 19:19:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev <netdev@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] af_unix: don't post cmsg for SO_INQ unless explicitly asked
 for
Cc: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but
it posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
incorrect, as ->msg_get_inq is just the caller asking for the remainder
to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
original commit states that this is done to make sockets
io_uring-friendly", but it's actually incorrect as io_uring doesn't
use cmsg headers internally at all, and it's actively wrong as this
means that cmsg's are always posted if someone does recvmsg via
io_uring.

Fix that up by only posting cmsg if u->recvmsg_inq is set.

Cc: stable@vger.kernel.org
Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 55cdebfa0da0..110d716087b5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3086,12 +3086,16 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	mutex_unlock(&u->iolock);
 	if (msg) {
+		bool do_cmsg;
+
 		scm_recv_unix(sock, msg, &scm, flags);
 
-		if (READ_ONCE(u->recvmsg_inq) || msg->msg_get_inq) {
+		do_cmsg = READ_ONCE(u->recvmsg_inq);
+		if (do_cmsg || msg->msg_get_inq) {
 			msg->msg_inq = READ_ONCE(u->inq_len);
-			put_cmsg(msg, SOL_SOCKET, SCM_INQ,
-				 sizeof(msg->msg_inq), &msg->msg_inq);
+			if (do_cmsg)
+				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
+					 sizeof(msg->msg_inq), &msg->msg_inq);
 		}
 	} else {
 		scm_destroy(&scm);

-- 
Jens Axboe


