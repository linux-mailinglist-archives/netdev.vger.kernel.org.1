Return-Path: <netdev+bounces-64839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E298373AE
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694B11C26A6D
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1554121B;
	Mon, 22 Jan 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SJKKwEB4"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3A405D6
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955171; cv=none; b=P/CSSL4hgtIzyCqFbZy8N/w3tYYUhvapyHN5GdvZuufPq/p28wJAT9C/Yp0wQl2LDh9t+Y66zx286e9PGOitI+Qubp9ST3xaQX3xxjGw2coAdv0ceza4VcL3FqwgeImZeiZuRbrcxJ0i4QTfvhh/fxAdh9cNbKYQuOpDJtjLH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955171; c=relaxed/simple;
	bh=qGN6Ziz8rvCWp2KqLPuWtYHZmOo5YiPgo5bhs15JoFc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=cqh61WSdxB8F5Cz+LSld9rWmDO/BvqSKzItuN46p1d6MxKR8D/iag6qt8KhqZ9Gw1MXJsmeIRXA/4ZspG44EttlFWTa9uvxlq9JHFSxYHhduQNLyLEG7yeDlak51BCbZB+3QsSdQPDFOY45Kh/EbWN+YMRhDOJthZBb6suuxLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SJKKwEB4; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705955158; bh=l0/P4rRU3UEdK16E0nbOyv3fklYIK2Sjo9EJhSL/TQg=;
	h=From:To:Cc:Subject:Date;
	b=SJKKwEB4X9kiA0WFTWoXYDe/OQH8x2vQ3wggPSTLNZ+G6CLVplYeoakDAfkoXKKZY
	 2Y9nwI69EHgyMTkdWEXvKmp8RRTazBbtAuKNTuvxBo13TyHVCN2QXGRAdj8/XmbuXp
	 kyHgMo4RBscB3q99IBpNMeG+uxrFbHeb3qDwM9Is=
Received: from localhost.localdomain ([153.3.156.163])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 6300D832; Tue, 23 Jan 2024 04:24:48 +0800
X-QQ-mid: xmsmtpt1705955088tel7i0phg
Message-ID: <tencent_F35C58B90E47D014455212BC7110EDBB2106@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3NPpgpduqaUFHb3MHHtVkMIDImbt1ObVlJCedMe9X6JspgZTjokk
	 mUgfI/T2DJ9dFU8ZIRsBLhNQNxRVZ/31AHK7g7VPBPcyUFO8C6VZjUWRgwCCME1is46NRqqLr1nL
	 EL+XRBNkxAs3mfXMMt6oJEoXVSlnDNFno5sAnOMGKq1bxWNz2o8meogyachNoTpJbH7QQkovkuNG
	 oPQM6f9PhMwoHG+dHa3Ak8kuDO6X4fIFx8LSCoKKLqTaXKgRYgty3b4EVYXQGteY9fgHIX76tAXu
	 P8fDwRBOTqdyB+0FqSNO/3S7K/UOly5zsB/dLAEstcOkI/GLRJ8iTnMYW465sZiQOzir7d9fGDVU
	 qJVyOCEjEDpqOeBPUm7N/WBsBcLXqcge/zXdtPacHdzUOsZJbhLNAiYKcgkmHWzIP3qL+bFbORLu
	 ILMVzLxLF+HCaCSmq3RLCo3QqCpEXFMRREHk4Ld1Cp5OHmCI3EmYd6nfvHHa4MAwRSwB3hmb7lnW
	 fDAb/upwdeys1e7zFuMuqqLMoczwk5HzEtSQsvkho+1yiiEQAqUrSUc7PnX29pPB51OxEoDKhcRI
	 yADEMe8mzI9UKi+G8mvzSgan8GpvLIHzwhdd/XM5/kJG92E6hcyjFRR5DEn97sLoPhsD3oCj7NiQ
	 RiJnmnf1d89uITVwpQVc1/YGqc6EODReRd8ao0qRdzvWjXi20ErHnV2Gk8Q6H5f2umALOWvbEqQm
	 /7MBtWL0918IqlzY3sUDPBBDPhATRwa+b8MWAGwkhhZrk4z6wtwNTp7MIUliHZlY9StcrJnzlakR
	 VMqPPI0ivm6+G0IVtPcj7Fc0OaIB0sDBTFm4L6VFaFP0kWn1wilYn5Gd3jlo32s6BnA22tkerJnH
	 5DKh1SS+txVLxR7+Wkb2OUGF8iIPH8PsQ+AqwktZMkr9oFUfOezK0OGg+nEQMngbgzalfkM1VIHT
	 ftnz7Z+hnLWecXL4R1wlcNdx8rx6KCoNjksaYe89X5KyLwD/SXeFKBXmpw/mtIxrj/wbMQ0fBkOT
	 EQ1efyTpbpWDTxTPDHkOtqOQSWEV7grLi7XOJkfFEtnlfOBYJQNOJOGkdWFv0yrP/LVEGjcsWpDs
	 U3ri/hEBNHEDh+sUMG+E6Mph6s/+YGuF50bfK6
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: linke li <lilinke99@qq.com>
To: netdev@vger.kernel.org
Cc: linke li <lilinke99@qq.com>
Subject: [PATCH] net: use READ_ONCE() to read in concurrent environment
Date: Tue, 23 Jan 2024 04:24:46 +0800
X-OQ-MSGID: <20240122202446.44239-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function sk_stream_wait_memory(), reads of sk->sk_err and sk->sk_shutdown
is protected using READ_ONCE() in line 145, 146.
145: 		ret = sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
146: 				    (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||

But reads in line 133 are not protected. This may cause unexpected error
when other threads change sk->sk_err and sk->sk_shutdown. Function
sk_stream_wait_connect() has same problem.

There is patch similar to this. https://github.com/torvalds/linux/commit/c1c0ce31b2420d5c173228a2132a492ede03d81f
This patch find two read of same variable while one is protected, another
is not. And READ_ONCE() is added to protect.

Signed-off-by: linke li <lilinke99@qq.com>
---
 net/core/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index b16dfa568a2d..7e67a2bf4480 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -63,7 +63,7 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
 		int err = sock_error(sk);
 		if (err)
 			return err;
-		if ((1 << sk->sk_state) & ~(TCPF_SYN_SENT | TCPF_SYN_RECV))
+		if ((1 << READ_ONCE(sk->sk_state)) & ~(TCPF_SYN_SENT | TCPF_SYN_RECV))
 			return -EPIPE;
 		if (!*timeo_p)
 			return -EAGAIN;
@@ -130,7 +130,7 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 	while (1) {
 		sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
-		if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
+		if (READ_ONCE(sk->sk_err) || (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN))
 			goto do_error;
 		if (!*timeo_p)
 			goto do_eagain;
-- 
2.39.3 (Apple Git-145)


