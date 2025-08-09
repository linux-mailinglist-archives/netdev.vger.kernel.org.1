Return-Path: <netdev+bounces-212317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7328CB1F2FD
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D7D1896A7A
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 07:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926D275B1C;
	Sat,  9 Aug 2025 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="MU5h6wvj"
X-Original-To: netdev@vger.kernel.org
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF4277007
	for <netdev@vger.kernel.org>; Sat,  9 Aug 2025 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754726216; cv=none; b=Ov1IIBrnXAdY3KsnZ8YvCCfSjSHqkd/JT6Ro2yda7FJjdDo+GyNrZifJdOGozP3MAiBu1kyjtJJZRJ2W17uefLmr6DgmrKDexUFBvBmDFXAQsluajEIMv6jAVBsq1CrOHt1Yb3zoZM3B50UiClTbYsV0lvuibM2WJ9JAph6TCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754726216; c=relaxed/simple;
	bh=uuklXaB89/RelzjEfc/Nf9G7GymsN0EHfc0xQxRAR1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZR4O/2OmGAtlzPFSUt7vTWHWCClMg77uWOjzT6oygSP/fXgJQAS/95RdZrKhsIabib+Tu7YocJX4mGf8ur7aGcHpvINbC6vdJ0J4pm+TIUazjhCCM2G6DbmJJFt67S+hXNtsvwRLY5vs7x41cqc7/8DDpn6x7YHUsPk1EXM3fsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=MU5h6wvj; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754726211;
	bh=xA0ufTu4b9JidthMu1hk511KlawhVgdPtp8X2wyCYhg=;
	h=From:Subject:Date:Message-ID;
	b=MU5h6wvjHx6GXiDE1+WiPVzDxqjT7CgKSGGU2YZdqjEZtQ2mEVHxeTLDNLZtJ7aVh
	 4qwiPzB5mZkL5+ZpPnQ24pmb0i9YEU1IYptsoIeTrQOJ0WjruBirCK9fPAZc0NS4MX
	 qCGzcp3PBwFeFOF1a249Ek4sgBiQBKixrDDYJnNI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 6896FF39000056D4; Sat, 9 Aug 2025 15:56:43 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 642086292026
X-SMAIL-UIID: 267C2C7299CB44F9B59F5BF106BA01D5-20250809-155643-1
From: Hillf Danton <hdanton@sina.com>
To: Sven Stegemann <sven@stegemann.de>
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] net: kcm: Fix race condition in kcm_unattach()
Date: Sat,  9 Aug 2025 15:56:30 +0800
Message-ID: <20250809075631.4090-1-hdanton@sina.com>
In-Reply-To: <20250809063622.117420-1-sven@stegemann.de>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test upstream master

syzbot found a race condition when kcm_unattach(psock)
and kcm_release(kcm) are executed at the same time.

kcm_unattach is missing a check of the flag
kcm->tx_stopped before calling queue_work().

If the kcm has a reserved psock, kcm_unattach() might get executed
between cancel_work_sync() and unreserve_psock() in kcm_release(),
requeuing kcm->tx_work right before kcm gets freed in kcm_done().

Remove kcm->tx_stopped and replace it by the less
error-prone disable_work().

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Reported-by: syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e62c9db591c30e174662
Reported-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
Signed-off-by: Sven Stegemann <sven@stegemann.de>
---
 include/net/kcm.h | 1 -
 net/kcm/kcmsock.c | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/net/kcm.h b/include/net/kcm.h
index 441e993be634..d9c35e71ecea 100644
--- a/include/net/kcm.h
+++ b/include/net/kcm.h
@@ -71,7 +71,6 @@ struct kcm_sock {
 	struct list_head wait_psock_list;
 	struct sk_buff *seq_skb;
 	struct mutex tx_mutex;
-	u32 tx_stopped : 1;
 
 	/* Don't use bit fields here, these are set under different locks */
 	bool tx_wait;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index a4971e6fa943..2f66b5279f2a 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -430,7 +430,7 @@ static void psock_write_space(struct sock *sk)
 
 	/* Check if the socket is reserved so someone is waiting for sending. */
 	kcm = psock->tx_kcm;
-	if (kcm && !unlikely(kcm->tx_stopped))
+	if (kcm)
 		queue_work(kcm_wq, &kcm->tx_work);
 
 	spin_unlock_bh(&mux->lock);
@@ -1693,12 +1693,6 @@ static int kcm_release(struct socket *sock)
 	 */
 	__skb_queue_purge(&sk->sk_write_queue);
 
-	/* Set tx_stopped. This is checked when psock is bound to a kcm and we
-	 * get a writespace callback. This prevents further work being queued
-	 * from the callback (unbinding the psock occurs after canceling work.
-	 */
-	kcm->tx_stopped = 1;
-
 	release_sock(sk);
 
 	spin_lock_bh(&mux->lock);
@@ -1714,6 +1708,7 @@ static int kcm_release(struct socket *sock)
 	/* Cancel work. After this point there should be no outside references
 	 * to the kcm socket.
 	 */
+	disable_work(&kcm->tx_work);
 	cancel_work_sync(&kcm->tx_work);
 
 	lock_sock(sk);
-- 
2.50.1

