Return-Path: <netdev+bounces-268726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJS3IJSsuWmEMAIAu9opvQ
	(envelope-from <netdev+bounces-268726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:33:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA39F2B192A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 465E73093456
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ABC342517;
	Tue, 17 Mar 2026 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWLr0bS1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6C33FE27
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776017; cv=none; b=YPwECfn9eQXlAv/NzTpF3pa3nI7hXA/Bb5LKJ5gGfJWI/6RWaCB10TEXNL6q1u60HlAe2/iwl03WuVYH9gVaZldpRWEcy+rcYir7cBqPtlPzdrI7MvwMW2+bqJe4ntE5PJTsnPvQPnjEnTn2OUQGTMMJxsXDrlyB0pva/H0N718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776017; c=relaxed/simple;
	bh=1w5mBrG4E7fVBBHMJEtrWa7YPEjrNOaytymj5XbhXbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JF4aJWRy2/JnlsDcOhJCUehgdyFS5K6BsznTa88pK06K6tTogNxzQxQaZ6lScIzf0TkOohWAi8vt3XuGkqvB5zQIEI47dwOgx8LQ/BGu2/PzwEc7ERekSB7r0I4gf29eXp0EJNrr6ckUyOHYw+zsFpo+HXa2FJscSMCVqP0zRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWLr0bS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2839C4CEF7;
	Tue, 17 Mar 2026 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773776017;
	bh=1w5mBrG4E7fVBBHMJEtrWa7YPEjrNOaytymj5XbhXbU=;
	h=From:To:Cc:Subject:Date:From;
	b=LWLr0bS1xznPFNDN4vFWfVJPvYvk2yfJRlnxEHbAZSmTpB96c0zq4jc7CzuhSllrm
	 ofp1YL6Z0Dq6oslZh6Fro6eq9Kj1ec1bXPrnm6DDxoJxhl5+JwhszEB2P5c+yppbCG
	 xU8tphUTDTbAXTnLJN5NJ/Zpm30Cy99An85d6B+veRJmk+iKagm3tAss8UBBd/J9o4
	 WttBN09TBjY7KWiYAPEYLMmmpe4zM1ZQkSJGuSw+Iy68BV9PoWQnoALFYcy71TJ5CK
	 LDDTBkvov3Ba1breToeFkMWU65EjmYt2VjOFfZJgRBYHthyUSrUYbzqfNCdKaIw8G1
	 vlSeMLsr7rYxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ian.ray@gehealthcare.com,
	ilane@ti.com,
	linville@tuxdriver.com
Subject: [PATCH net] nfc: nci: fix circular locking dependency in nci_close_device
Date: Tue, 17 Mar 2026 12:33:34 -0700
Message-ID: <20260317193334.988609-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268726-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxdriver.com:email,ti.com:email]
X-Rspamd-Queue-Id: DA39F2B192A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nci_close_device() flushes rx_wq and tx_wq while holding req_lock.
This causes a circular locking dependency because nci_rx_work()
running on rx_wq can end up taking req_lock too:

  nci_rx_work -> nci_rx_data_packet -> nci_data_exchange_complete
    -> __sk_destruct -> rawsock_destruct -> nfc_deactivate_target
    -> nci_deactivate_target -> nci_request -> mutex_lock(&ndev->req_lock)

Move the flush of rx_wq after req_lock has been released.
This should safe (I think) because NCI_UP has already been cleared
and the transport is closed, so the work will see it and return
-ENETDOWN.

NIPA has been hitting this running the nci selftest with a debug
kernel on roughly 4% of the runs.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ian.ray@gehealthcare.com
CC: ilane@ti.com
CC: linville@tuxdriver.com
---
 net/nfc/nci/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 43d871525dbc..5f46c4b5720f 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -579,8 +579,7 @@ static int nci_close_device(struct nci_dev *ndev)
 	skb_queue_purge(&ndev->rx_q);
 	skb_queue_purge(&ndev->tx_q);
 
-	/* Flush RX and TX wq */
-	flush_workqueue(ndev->rx_wq);
+	/* Flush TX wq, RX wq flush can't be under the lock */
 	flush_workqueue(ndev->tx_wq);
 
 	/* Reset device */
@@ -592,13 +591,13 @@ static int nci_close_device(struct nci_dev *ndev)
 		      msecs_to_jiffies(NCI_RESET_TIMEOUT));
 
 	/* After this point our queues are empty
-	 * and no works are scheduled.
+	 * rx work may be running but will see that NCI_UP was cleared
 	 */
 	ndev->ops->close(ndev);
 
 	clear_bit(NCI_INIT, &ndev->flags);
 
-	/* Flush cmd wq */
+	/* Flush cmd and tx wq */
 	flush_workqueue(ndev->cmd_wq);
 
 	timer_delete_sync(&ndev->cmd_timer);
@@ -613,6 +612,9 @@ static int nci_close_device(struct nci_dev *ndev)
 
 	mutex_unlock(&ndev->req_lock);
 
+	/* rx_work may take req_lock via nci_deactivate_target */
+	flush_workqueue(ndev->rx_wq);
+
 	return 0;
 }
 
-- 
2.53.0


