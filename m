Return-Path: <netdev+bounces-73621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F585D640
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2FB246B3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFDF405CF;
	Wed, 21 Feb 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8CR2GbL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DBF3FB02
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513170; cv=none; b=sbj94OxpYG3/CDAYjmbxBiot3kv5snmbxudGP9zr34uMQWvVfI4yAO1vEYqZRckaOHj6KFWbOcD2FwDDLB84JXF/5HUmUSabc+b6dOomI6/UrVfPHKLM+n5pLcOKy7eedJWzMetvJ15nfxl5iSVbXJRgqvclvT7Db4vR+s1yuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513170; c=relaxed/simple;
	bh=KL6zIfxA8UbGHp3cFvLTH5QrnRNaflo/TBiJpGstEZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VRabcARNWvPFsn4gw++82xtSGYHVMpOv1OY/G/zxYJxhlnja0wmjgDbZo7G8YoiLsHcmOrpsWEww79eMeUSUM2JHSxda2qzcM50VCqJo+4AhJQHF6QX9OEnJ5I2iibaxg7RjJWFGUpIpONPc6J6tfFnCWhTzOZzebsH/7PdyBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8CR2GbL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso10903037276.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513167; x=1709117967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jU7IAurJymOu1zEpYkBpuSxYXYY6DJhRH0ySesdj3Sw=;
        b=d8CR2GbLWsrua45EZlJcqECtHa1EluS8zL0oola/6WYvF0qnmW1Ul+cQ/nsIfMnHxJ
         qkYqhK+1PKifbCk03gdxirtaNDpjpYQsnbS8c/rFp4kRPIEdDjM1ZbuVS3M+p8dFeN34
         +0BrW95IELDgYkyF7pmRKZdroffq6A6YfwTCl7DVUvGA/4BQVadxA6OZereKbKOw8inO
         1Ia3ecCG8x7ep4/epLx3clKImLfrO0ExmZav1NAPvN/tIT14u6L94odYcgee8ZUBC/ZT
         vacLXjVJvPxdhlOSyhvu4Kb8mt8wJumNi0d4rEPHCWgsW+yLjwqj66sVyWdT1vAyWEzM
         OiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513167; x=1709117967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU7IAurJymOu1zEpYkBpuSxYXYY6DJhRH0ySesdj3Sw=;
        b=adkQjB1z14Q3ZZ/LTx1fG48atFYWHKgDgftcL+ciBFEC0WhSY+yRsoqlyU3IaBh8JE
         sGrTBTMSvU6mkafuWXAPxJ8PBBNOpoQKln6c7tgc9he6hn5sTK5/qL35KZ7NQi9lI0cS
         LVtIF5ACBGLQPq2JK/NwE3fDBRhyej4C+suYocYjftGLAVYBJSzqpsJ1iy+ClSRc8FoR
         XlvDllQBpQwHfbvrdUZJuYzQOWiEWOPfsGahj8uPXLKI3YDXgRC14Hns9G3p3spmKRAT
         io3RR8qO1G9Hq5umsc9UqZ1ns9toRMm9BTh9Zn+4Zm2Y6ZRPFwapceJz4rBOS3OY5ovv
         xO8Q==
X-Gm-Message-State: AOJu0Yw7opPb5MNy2S86mQiFlAxQc6jII1gKFkUvtMpdQy4VNOuHjTXp
	9RMfTIHVMTjpgdEyGjM2z08PZMwopdFkcVKQR4/puv3uZ3sfJ6bLtAginnI1IDBNTUwEg6PXAHc
	JhCUMxCtQPg==
X-Google-Smtp-Source: AGHT+IFb+DRNG03AP96NXW6cAtWznt80/j7oO3u/5BOuo0jvmObP3bNuAt1GCdu6NKoFP5e6FV1Ai6C/Qj1oTA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18d4:b0:dcd:2f2d:7a0f with SMTP
 id ck20-20020a05690218d400b00dcd2f2d7a0fmr622416ybb.9.1708513167442; Wed, 21
 Feb 2024 02:59:27 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:08 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-7-edumazet@google.com>
Subject: [PATCH net-next 06/13] netlink: hold nlk->cb_mutex longer in __netlink_dump_start()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__netlink_dump_start() releases nlk->cb_mutex right before
calling netlink_dump() which grabs it again.

This seems dangerous, even if KASAN did not bother yet.

Add a @lock_taken parameter to netlink_dump() to let it
grab the mutex if called from netlink_recvmsg() only.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netlink/af_netlink.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9c962347cf859f16fc76e4d8a2fd22cdb3d142d6..94f3860526bfaa5793e8b3917250ec0e751687b5 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -130,7 +130,7 @@ static const char *const nlk_cb_mutex_key_strings[MAX_LINKS + 1] = {
 	"nlk_cb_mutex-MAX_LINKS"
 };
 
-static int netlink_dump(struct sock *sk);
+static int netlink_dump(struct sock *sk, bool lock_taken);
 
 /* nl_table locking explained:
  * Lookup and traversal are protected with an RCU read-side lock. Insertion
@@ -1987,7 +1987,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	if (READ_ONCE(nlk->cb_running) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
-		ret = netlink_dump(sk);
+		ret = netlink_dump(sk, false);
 		if (ret) {
 			WRITE_ONCE(sk->sk_err, -ret);
 			sk_error_report(sk);
@@ -2196,7 +2196,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	return 0;
 }
 
-static int netlink_dump(struct sock *sk)
+static int netlink_dump(struct sock *sk, bool lock_taken)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct netlink_ext_ack extack = {};
@@ -2208,7 +2208,8 @@ static int netlink_dump(struct sock *sk)
 	int alloc_min_size;
 	int alloc_size;
 
-	mutex_lock(nlk->cb_mutex);
+	if (!lock_taken)
+		mutex_lock(nlk->cb_mutex);
 	if (!nlk->cb_running) {
 		err = -EINVAL;
 		goto errout_skb;
@@ -2365,9 +2366,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	WRITE_ONCE(nlk->cb_running, true);
 	nlk->dump_done_errno = INT_MAX;
 
-	mutex_unlock(nlk->cb_mutex);
-
-	ret = netlink_dump(sk);
+	ret = netlink_dump(sk, true);
 
 	sock_put(sk);
 
-- 
2.44.0.rc0.258.g7320e95886-goog


