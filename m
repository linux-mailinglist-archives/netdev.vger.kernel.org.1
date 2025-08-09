Return-Path: <netdev+bounces-212315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F6B1F29A
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 08:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5977AB91A
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B6A245038;
	Sat,  9 Aug 2025 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stegemann.de header.i=@stegemann.de header.b="UTROeoPN"
X-Original-To: netdev@vger.kernel.org
Received: from dd41718.kasserver.com (dd41718.kasserver.com [85.13.145.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D21D432D;
	Sat,  9 Aug 2025 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.145.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754721928; cv=none; b=M5gcRoXxd6W5D2f4P//zYko9ZbhDTSS7GDWjo8envemWgNHYAI7tUgCojO2On0WxQjT9yYFz3A/DOZRvOwLfDN/dduFiUTxgHY3GOow0SrMSXilbtM1s3V10QqyXKq2LfWeb0p8mmPhP+lWVxhacFNWJ/qALmqHrhrnbNal5rs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754721928; c=relaxed/simple;
	bh=zvx995jZvhgpw8Zwg3xEmNPHpXPuVOefVTjpESQ6GRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7ST82aRzX4eL3P65HOfvbz1uOo8RU7fjqyIqfIy58DNiqxn1OOPwhLvkm1GEu0UFp6cBl6vWDEBSmyNRMzWc0zIQXLiGLotCZ9IW3+jiGO/3/JhZpJQwqBGlMWqZiy/j16RRRqKfcbvxdRtneXz16L8LvHfsxK7Wvbt+v9yYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stegemann.de; spf=pass smtp.mailfrom=stegemann.de; dkim=pass (2048-bit key) header.d=stegemann.de header.i=@stegemann.de header.b=UTROeoPN; arc=none smtp.client-ip=85.13.145.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stegemann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stegemann.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stegemann.de;
	s=kas202307141421; t=1754721419;
	bh=Bir3wHohf1pjvDnOTZ+u3N0JcfX4O2/ic9Nnk3OTI5E=;
	h=From:To:Cc:Subject:Date:From;
	b=UTROeoPNRVJO237G02ghc80x1KYzBs/kuZO4reW9Z3OpcLBIzOenG9tNY4ajg0R6d
	 /nvAUmStAGN6n1bdzrkWQkWM/82JxKBPmquxBn5hzPqw+aW5WihecdjSWQbnR9vlEx
	 0lijWxzOge5kYziJKM5u29/Vu3Z13yIzGjnpuIoJAQDaVkuRZ7mNFUeEtXrg2dl7/M
	 sZbA/PVZH9t/5P6VeOSiVw9mM95KDMl32Hun5NDdfvaVxCkVw+partGmFvlkzqrNQN
	 9vE+lBHOqC/W5HHrKaNMIDYi3BpN1oWdwkeN1mB0FXhXShVn1UW9nfPEm0021aQOZ2
	 dE+pYLJcbsVAA==
Received: from DESKTOP-I55TJV0.localdomain (p5b2eae0a.dip0.t-ipconnect.de [91.46.174.10])
	by dd41718.kasserver.com (Postfix) with ESMTPSA id 5DD6055E0014;
	Sat,  9 Aug 2025 08:36:59 +0200 (CEST)
From: Sven Stegemann <sven@stegemann.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sven Stegemann <sven@stegemann.de>,
	syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com,
	syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
Subject: [PATCH net-next] net: kcm: Fix race condition in kcm_unattach()
Date: Sat,  9 Aug 2025 08:36:19 +0200
Message-ID: <20250809063622.117420-1-sven@stegemann.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam: Yes

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


