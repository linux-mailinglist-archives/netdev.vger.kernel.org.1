Return-Path: <netdev+bounces-246160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D12CE0376
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 01:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C86730285E8
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 00:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF4185B48;
	Sun, 28 Dec 2025 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6CjO9ps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7E3BB40
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766881362; cv=none; b=RsxtujXW9lKgysaDYu0TzU3Nl9CBvM1nrFlftxJEqVXhXOzvE3rXQHlcEsKaQEs1Pf1pRrRXuS/wkW8+fWUcWaBys3ZXhpTCB1o4dt2cJ/hjv2/EDFvNQmPprL43oBnZORqV4p7Fdx9Kh7iUJZBE2cxEmMxKW2bp3Tgl0KK3CZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766881362; c=relaxed/simple;
	bh=/SKKvgsLGniObPBxFPopatBIfoDqwwrSrjjCxZm4YGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJ4YSKNjyh8HCXvx/+0pFQHFH96O28kwRVivFdk9SxDQbZ0OgSNSBbV7W+JO/vTAlmSbeEDcHi7cNlG1xL/JKUKMAhTYcEwhp8EZfU6f/jzj7uVWT0NPc+hIWuyDDKfpEdD2BTIiYnZScxh5A9X9DOMN+I4fkeIdw+iJjzvlXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6CjO9ps; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a2ea96930cso93882775ad.2
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 16:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766881359; x=1767486159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYFmtcwmaCGVVXH0ahGN7yObA268AiZf0dtJQGnUA9A=;
        b=h6CjO9psXMbdO/pvswD2o1U6++jYc47JNxyWrwmCP6/RJ4J//c+Rl5NYsGfLzAuZUM
         CE1QQrNDTHsViNSHpT7PYO1E691OAAF/Gv9dMb5hyIJYMVo0OmXXXsUohNn2epigkNSH
         j8qoNxCfdGK7vJA4A4gQIG6fqeAJ7usnVxyoQ4BLlCjTs3BwRQiRXx5nP3egJ0IMGyEN
         qluTE12HdmNo4GUsB0FRdPmhKCrkeGrSCH4DFpgY9UORQzdaYSkQ8hotBNPyf2kzLeXJ
         4JnYXS1KTqDoucPVraJchYvsJkg8oW6LXoU6nohECRS9GSUweq7nDk6hpL3RRYqm1AUd
         8IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766881359; x=1767486159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYFmtcwmaCGVVXH0ahGN7yObA268AiZf0dtJQGnUA9A=;
        b=KIgZj3NozVWSVv2NBHYJNTX0/x59NlNVz5+LjXkt3M7nRmC2DidpI0bC1zl0kAB9uH
         eVF1pfhzsayb4nNPnmHDnwcbL39d0tz5bvVZ17X5s38ddqGxw1aiiKd/GOn/O5fFu9wK
         bNfA/qiX++Twp5FLjTEQeVmLdQpy2f9Yf+ThIBlSCLbEuwVLpNH/xzjHycv+0lwpI/qc
         vgzMsMyGPrB1n+veFTrnE0vgSARu0BbI7xTBxWyx6AG2zSG1fVB1LY7KqwG8o2NYyMEy
         eszucuS2PpeNkF24+KO1Bx8jmR/SBzPjEVEzq6vECLiUi8/rXktdOkTns5iBBOhin/9+
         E19w==
X-Gm-Message-State: AOJu0Yx2fo2pZWuzxtZyhepsCNdl73rDRGoFA6297LMbYCUqZ7LTjHS0
	2pMcaXyX0uzOGemvVONsNU7brjaGTITpjGqc2Wi51rzTRXL3AI1hgmh8ekPIWA==
X-Gm-Gg: AY/fxX6uCnymKSSBv5x3KXAgV5QoaztGUgSwkytl3rj1qq9u6JZQDDk1yHoEz+OUAnN
	lL1kEzo08JztK9BLKbu94XmeB4GbuCTwOk+lkw31+7ocqh2/Fm6U2MDnd5w3AG3Y/Qn/HVkpQRL
	mTXAnqXjhxVOrQe56ys9/h9OvXKiRlNF1GAfu30oxVHea0KhMLwIaZTOLEXpuQ4MLeEYqtXPRTi
	WswaYdHc+a0vSD6yYV7CPNoiGacIyF0v0UhKb2331AeeP8VvYp3/t9oejh+j0lepwSaWszvp5fC
	01MDiadV0yOOhbpElZnl0lih8MX88bhvg6Q06/k7t//JIS5fBk3Xcr/ExmG5hVe2pXy1YWILnVO
	sIrEzrQoZCcpd6YIV4u5NHkaTEH3HTITBSFK5wEAqw+ltUZMuuM9vw+24t26CX2tbJZ0Zw/wIDt
	cKcQt4v1x9U1Wo9Ukn
X-Google-Smtp-Source: AGHT+IEabNDQ1jAtV42QIGgfCGa/E7vYNR4IeTg911qnY+ht3AZp8OXR0jF9A3A0OYifKUGPpVJ2cw==
X-Received: by 2002:a17:902:e884:b0:298:1288:e873 with SMTP id d9443c01a7336-2a2f2a3eb0fmr250994455ad.56.1766881359451;
        Sat, 27 Dec 2025 16:22:39 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:70f5:5037:d004:a56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm236533535ad.100.2025.12.27.16.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 16:22:38 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v5 1/4] skmsg: rename sk_msg_alloc() to sk_msg_expand()
Date: Sat, 27 Dec 2025 16:22:16 -0800
Message-Id: <20251228002219.1183459-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
References: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

The name sk_msg_alloc is misleading, that function does not allocate
sk_msg at all, it simply refills sock page frags. Rename it to
sk_msg_expand() to better reflect what it actually does.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 net/core/skmsg.c      | 6 +++---
 net/ipv4/tcp_bpf.c    | 2 +-
 net/tls/tls_sw.c      | 6 +++---
 net/xfrm/espintcp.c   | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 49847888c287..84ec69568bb7 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -121,8 +121,8 @@ struct sk_psock {
 	struct rcu_work			rwork;
 };
 
-int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
-		 int elem_first_coalesce);
+int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
+		  int elem_first_coalesce);
 int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 		 u32 off, u32 len);
 void sk_msg_trim(struct sock *sk, struct sk_msg *msg, int len);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2ac7731e1e0a..0812e01e3171 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -24,8 +24,8 @@ static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 	return false;
 }
 
-int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
-		 int elem_first_coalesce)
+int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
+		  int elem_first_coalesce)
 {
 	struct page_frag *pfrag = sk_page_frag(sk);
 	u32 osize = msg->sg.size;
@@ -82,7 +82,7 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 	sk_msg_trim(sk, msg, osize);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(sk_msg_alloc);
+EXPORT_SYMBOL_GPL(sk_msg_expand);
 
 int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 		 u32 off, u32 len)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a268e1595b22..a0a385e07094 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -533,7 +533,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		}
 
 		osize = msg_tx->sg.size;
-		err = sk_msg_alloc(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
+		err = sk_msg_expand(sk, msg_tx, msg_tx->sg.size + copy, msg_tx->sg.end - 1);
 		if (err) {
 			if (err != -ENOSPC)
 				goto wait_for_memory;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2..451d620d5888 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -324,7 +324,7 @@ static int tls_alloc_encrypted_msg(struct sock *sk, int len)
 	struct tls_rec *rec = ctx->open_rec;
 	struct sk_msg *msg_en = &rec->msg_encrypted;
 
-	return sk_msg_alloc(sk, msg_en, len, 0);
+	return sk_msg_expand(sk, msg_en, len, 0);
 }
 
 static int tls_clone_plaintext_msg(struct sock *sk, int required)
@@ -619,8 +619,8 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	new = tls_get_rec(sk);
 	if (!new)
 		return -ENOMEM;
-	ret = sk_msg_alloc(sk, &new->msg_encrypted, msg_opl->sg.size +
-			   tx_overhead_size, 0);
+	ret = sk_msg_expand(sk, &new->msg_encrypted, msg_opl->sg.size +
+			    tx_overhead_size, 0);
 	if (ret < 0) {
 		tls_free_rec(sk, new);
 		return ret;
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index bf744ac9d5a7..06287bae8f9f 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -353,7 +353,7 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	sk_msg_init(&emsg->skmsg);
 	while (1) {
 		/* only -ENOMEM is possible since we don't coalesce */
-		err = sk_msg_alloc(sk, &emsg->skmsg, msglen, 0);
+		err = sk_msg_expand(sk, &emsg->skmsg, msglen, 0);
 		if (!err)
 			break;
 
-- 
2.34.1


