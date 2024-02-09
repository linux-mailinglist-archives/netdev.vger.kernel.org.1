Return-Path: <netdev+bounces-70694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C928500EB
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52455282932
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30B38FA9;
	Fri,  9 Feb 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="EtYT+320"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407711CAF
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522985; cv=none; b=mKQZilH6Jh5B6gUcI6ohtycWtnaNH+lEmBUVyZxQoR0WC9DaX5XBGnWC2BVoiQUv6C2Y6wWxDtwr/ccYYuNOGlvsiSnvJb1Her7lawVU1Bu9dWbznMvn5xIUj6L8bHytY3XBbwN1jPQZbMDpfF26uyPTue+9cnHyuhFL5cAMpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522985; c=relaxed/simple;
	bh=TfX4V+/UlUdvWzbJrrKPVwlSzutnyiFGEOg7ASjnSMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXMevO24+/y0yDlI/NUTiI5LOnRp4fGr8DZwbLEJNCRkaqmLcTOUofzpfaGG8yM4WBVhstwbKJ1OE47bYKq9bcKZee42+Cng/Sk6moO6r2wNxGSVTfZORQxJrT83suGvAlH+bnWIPLmiIM3rLRMr7KV1VDHpr0thsietXbHe7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=EtYT+320; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d71cb97937so15096145ad.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 15:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707522982; x=1708127782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kecyRCBPP8cHunv6tkqoi9TAbGIbv60BfFWzKZvwYs=;
        b=EtYT+320SjJJpfoQ/iFIIWC6M+XjGTWbRwq7WcTuH91fH5qjeRjqMUaaYCGHbTC+3k
         jc/OMQAB1E5RcWabrpNA1u32p50E60h/k9sZDekbD508UKlTmf8UqGqtuEVPjbQyYYpG
         bWUA0KkKjwY4+fC7D357MYX8zwF2ROKmSLAB3VU1ho1Ob519fS5T1rZqkGTnP+3RA5ej
         WZMopzKXeVimyeCSvbGuN4fF0ZsdhV1RQuc5e6PaVv3LLt1J+LFHSPFEl7UoNYIkdT2h
         1Zp07byiwian2fx41BC2lsS5MsPtCmXbLYTmvkvJefrMS/aybRjF0/OPqp0ePqG4ZcMd
         uZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707522982; x=1708127782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kecyRCBPP8cHunv6tkqoi9TAbGIbv60BfFWzKZvwYs=;
        b=WIgRb/lPXQGt2EdPGAg/DXTEn5qN38+wyuDySBE+o1S2gNsNqZaJjfnJe5OFeO0tzo
         5On2wnynhRCfw1GAyVNMN1w3LjazPN5+w6SyUIft320yhN8cBUo7OTmioW7B1Wa9C8bZ
         Sz+cDy91IAExF9nfRRcAqZJy1V82DMRI5OA33X11R9bRUoSBh1cFUuje9/TK2quzdCA8
         X9M4/UoIy3QlEBGW+l66Xmw5BhDL6T78xPdLidn7KHu2C11XOSzzGSzJ1DHAVtlXFSZl
         X5+z+y11L3vcwCV3PgPWOIOc75qOSHj2Y+n41B6UzeEL2lBBM+UXMdtFlxNTshUYx9Jp
         VGhQ==
X-Gm-Message-State: AOJu0YzsEETHLzEpOR6qoUEtr/knYCSlVYyeZP0+kNe08Y2puVp/LCjh
	J/ObskkQhvxLuWsogGtwG2ePpZffmTU/KVI89rnZZK2m7QWV9Kij/e/Q3DyfEpaaARQQ6St7VM3
	B
X-Google-Smtp-Source: AGHT+IEZXRBSITbmZu5eDIUCucQeyTvi1AI4Xym2Mk5SNkXPVbcQCl7R48801VAihACHHWvuoZHXLw==
X-Received: by 2002:a17:902:6545:b0:1da:1b60:2209 with SMTP id d5-20020a170902654500b001da1b602209mr769112pln.44.1707522982440;
        Fri, 09 Feb 2024 15:56:22 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b001d9a1d7a525sm2018420plh.273.2024.02.09.15.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:56:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/2] tc: print unknown action on stderr
Date: Fri,  9 Feb 2024 15:55:57 -0800
Message-ID: <20240209235612.404888-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209235612.404888-1-stephen@networkplumber.org>
References: <20240209235612.404888-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an error, and should not go to stdout.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_action.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/m_action.c b/tc/m_action.c
index 16474c56118c..f180ba09778c 100644
--- a/tc/m_action.c
+++ b/tc/m_action.c
@@ -62,7 +62,7 @@ static void act_usage(void)
 static int print_noaopt(struct action_util *au, FILE *f, struct rtattr *opt)
 {
 	if (opt && RTA_PAYLOAD(opt))
-		fprintf(f, "[Unknown action, optlen=%u] ",
+		fprintf(stderr, "[Unknown action, optlen=%u] ",
 			(unsigned int) RTA_PAYLOAD(opt));
 	return 0;
 }
-- 
2.43.0


