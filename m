Return-Path: <netdev+bounces-245451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9E2CCDC6F
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 23:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB08D300CD6C
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 22:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39912E7BA3;
	Thu, 18 Dec 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P6ktwkNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9D2D97AA
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096494; cv=none; b=ZqhJbfW1oiv6IxgEo3/db3G9b9Iei89RBTbxZApI5n97wW2UNNiz32kh0cRS3q+BVwW+EbomkXBvrdvLJuMfVSv7Qy0eAIQ4yYA6IZGjnfddeVAOXOD+nh9NVqmb9iV4vyxZsQPoCMhM17/ot4DHD0DZsLg5JgVj/uTQcgnGpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096494; c=relaxed/simple;
	bh=3WEOOBTimDyvI1edV6ZuvzqFIskxf4gd81QTKphek3k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SzGZccDJp7yruOf+f/oUrb+kyV9NKhkF1y19f6kZPbSZ811SHlHjqq244SAGdi3sqPY2yLFlkyp8D77C1dnivyUdr44cCFs2MkWDeRMZmy8aNFoKHNqsKclO3nMoL6INtIr+MZPI30xDqRKlyUvtzDZBFg/D915un8CLKNSnTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P6ktwkNQ; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7c750b10e14so419920a34.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 14:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766096490; x=1766701290; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQWK63y9E1OcVkpznLAWrv5TZ9nCwP1KJH375ok1pZM=;
        b=P6ktwkNQ5QsM48RTmHDrxzCHHEtEoGLeSvpArvAfVLXorUvMfspyhQQ4EPoD3jvCeN
         AaHeJ2ohMSWy2i/R6NilLjwzYi7dUhJO0Okwb1fruks9HTK9xmnHntsIQHBOPFhu72cO
         ybP8XGr/kE2lOFcTMiY7wxA/P2r980lDZk/dymy5xtapohUeNXjA+EBHlWjzLcOE0Z1T
         PHayrMUZRYBD03wzbN0c9xXICROZbECdzEGOX5cOOwyfedv06KrbYj8urOITrHOD37qF
         ls4rCupjaj18UlV+YG/z7eu7vEcQimC5OkBrfdH1kVGUAnjzFER7HriBL9vkJVKTgDJU
         ExgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766096490; x=1766701290;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQWK63y9E1OcVkpznLAWrv5TZ9nCwP1KJH375ok1pZM=;
        b=mFVDCC7IQAcJJLqYcT5LLfFJxFPDBj8Xscd2nQuFmhwgGg3bLh8PkYNd2vFuuawJma
         KSlLqq2/oyPv6aOf+8eWPeVc64Z/WvDw4Fu47jMxakileUy0s7dLm7CklQT60FhbH3b5
         31w/ZfWn/sops90Gdpa2uFojwT0sy9OLmAG1nE5/fbOOxYWhnUAs4IfWuENiaFPkR524
         lRQYVQNdIh0qIWE3lYqCU4MeC+kvoW5ZXJLjnM9RyIhTIG5LQ5Ebu+/E2kTAtPe95Kw5
         2GA1bauiCMzvJ98Cl+CyvCaqG429MFjliyiDzMSetblPxD+EIR8O6W1xqnICU8V0G6p2
         D1WQ==
X-Gm-Message-State: AOJu0YxupJVGgcIfFHeYmAFsUII82Kh0dWKLM9cXKfpqr2cS2+H6mjt7
	RYxL78oR2dUu2my+jh2wEI6OKp32fnFFuxTlR4NSguR2Na9uhPQnwqEr+ojXfhKOY4x0+UNXV+R
	sSg0AMN3e4g==
X-Gm-Gg: AY/fxX5Oq+oFd7VmWwqcVwhnG+3+eROg+MuHWYFulyDPRcn9xQx056JkhGmc1PxFASF
	AlL5ed+6VTaTDX4fRH7chpadQ9IMI7Nwa2nDoKShwVpOHwbxryjSuFsDwSdB/y0Q4c+diDSAWYX
	KGjofb2hKfJCBs7M+SxNqPUs/TQIJ/nXb5wQuZEYJ5vM2dfeClkd80reTw650nai9dzNeKGRJEL
	rAKd8VBsPjCNh11XIha+usylI4lLHblItq4qGEK90n+JWMPTOR3wdZ9K8oiUjZcnqhc8Zbgipfr
	y7H/se57FDaCHGVDY4RpzliMWJ1vr+NNlHv2M0R/zdnY+UvmgdKNbV2lzjs+JdtFml8Di5BUuyU
	ILDotZDDI636BqCqoS6BYAWfi4nfUtUsE9ITE9EAbBJRIGicBsj8CKMth6GbVH4JnODVl1+/io3
	ZtYIWcteUG
X-Google-Smtp-Source: AGHT+IEQ438WpetCan+wwE5um9TfPU1PFj1eNW/mV2nLvViqOs/wgUL+95TMY8z7MDOjWeTHk/fGZw==
X-Received: by 2002:a05:6830:4c08:b0:7c7:65f4:1120 with SMTP id 46e09a7af769-7cc66a6f068mr519653a34.23.1766096490504;
        Thu, 18 Dec 2025 14:21:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ebe98sm472901a34.21.2025.12.18.14.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 14:21:29 -0800 (PST)
Message-ID: <07adc0c2-2c3b-4d08-8af1-1c466a40b6a8@kernel.dk>
Date: Thu, 18 Dec 2025 15:21:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev <netdev@vger.kernel.org>
Cc: io-uring <io-uring@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Julian Orth <ju.orth@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] af_unix: don't post cmsg for SO_INQ unless explicitly
 asked for
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but it
posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
incorrect, as ->msg_get_inq is just the caller asking for the remainder
to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
original commit states that this is done to make sockets
io_uring-friendly", but it's actually incorrect as io_uring doesn't use
cmsg headers internally at all, and it's actively wrong as this means
that cmsg's are always posted if someone does recvmsg via io_uring.

Fix that up by only posting a cmsg if u->recvmsg_inq is set.

Additionally, mirror how TCP handles inquiry handling in that it should
only be done for a successful return. This makes the logic for the two
identical.

Cc: stable@vger.kernel.org
Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
Reported-by: Julian Orth <ju.orth@gmail.com>
Link: https://github.com/axboe/liburing/issues/1509
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

V2:
- Unify logic with tcp
- Squash the two patches into one

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 55cdebfa0da0..a7ca74653d94 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2904,6 +2904,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	unsigned int last_len;
 	struct unix_sock *u;
 	int copied = 0;
+	bool do_cmsg;
 	int err = 0;
 	long timeo;
 	int target;
@@ -2929,6 +2930,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	u = unix_sk(sk);
 
+	do_cmsg = READ_ONCE(u->recvmsg_inq);
+	if (do_cmsg)
+		msg->msg_get_inq = 1;
 redo:
 	/* Lock the socket to prevent queue disordering
 	 * while sleeps in memcpy_tomsg
@@ -3088,10 +3092,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	if (msg) {
 		scm_recv_unix(sock, msg, &scm, flags);
 
-		if (READ_ONCE(u->recvmsg_inq) || msg->msg_get_inq) {
+		if (msg->msg_get_inq && (copied ?: err) >= 0) {
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



