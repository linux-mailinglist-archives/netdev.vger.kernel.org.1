Return-Path: <netdev+bounces-42299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27717CE19F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEDD1C20D7A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2CC3B78B;
	Wed, 18 Oct 2023 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8vH//zg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5BBE62
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACB7C433C7;
	Wed, 18 Oct 2023 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697644096;
	bh=JdMJ8//57g6EuQRyejekxR37eWJ667og6tFzCb1Tjs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8vH//zgJ/qM/m5pTeog8op6aIaWM1UQqur/ZlNj31f6oDIn+1U665lyxWQWnfrX/
	 erSrELGyjH6u6iJVVqXg8AFwgQgWklm6j7CoAbsTpgs2pjez0isA2Bhpity5dxj7lm
	 PRy5qa1BSCoQvs9I9NHepcrAmtccpGnNGPb6e32pcRlWcCtMCa2Ca2lhfOLzW1lU2q
	 H2l+mSMXGvqywRI0HERl9Gp3l11ZNZmlkWgat8ntmd6//i3hrCDGovHvNr9UJJVQ7g
	 35ampbKogDsLycZRwpxpveWdtTzdcuK82jm0vZ7mVYOHwQzPDF6yyuhLmXUMxXYavi
	 VFMcfd5WX+zYw==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	mhocko@suse.com,
	stephen@networkplumber.org
Subject: [RFC PATCH net-next 3/4] net-sysfs: prevent uncleared queues from being re-added
Date: Wed, 18 Oct 2023 17:47:45 +0200
Message-ID: <20231018154804.420823-4-atenart@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018154804.420823-1-atenart@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the (upcoming) removal of the rtnl_trylock/restart_syscall logic
and because of how Tx/Rx queues are implemented (and their
requirements), it might happen that a queue is re-added before having
the chance to be cleared. In such rare case, do not complete the queue
addition operation.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/core/net-sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index a9f712ef9925..75fb92c44291 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1160,6 +1160,20 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
 	struct kobject *kobj = &queue->kobj;
 	int error = 0;
 
+	/* Rx queues are cleared in rx_queue_release to allow later
+	 * re-registration. This is triggered when their kobj refcount is
+	 * dropped.
+	 *
+	 * If a queue is removed while both a read (or write) operation and a
+	 * the re-addition of the same queue are pending (waiting on rntl_lock)
+	 * it might happen that the re-addition will execute before the read,
+	 * making the initial removal to never happen (queue's kobj refcount
+	 * won't drop enough because of the pending read). In such rare case,
+	 * return to allow the removal operation to complete.
+	 */
+	if (unlikely(kobj->state_initialized))
+		return -EAGAIN;
+
 	/* Kobject_put later will trigger rx_queue_release call which
 	 * decreases dev refcount: Take that reference here
 	 */
@@ -1775,6 +1789,20 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 	struct kobject *kobj = &queue->kobj;
 	int error = 0;
 
+	/* Tx queues are cleared in netdev_queue_release to allow later
+	 * re-registration. This is triggered when their kobj refcount is
+	 * dropped.
+	 *
+	 * If a queue is removed while both a read (or write) operation and a
+	 * the re-addition of the same queue are pending (waiting on rntl_lock)
+	 * it might happen that the re-addition will execute before the read,
+	 * making the initial removal to never happen (queue's kobj refcount
+	 * won't drop enough because of the pending read). In such rare case,
+	 * return to allow the removal operation to complete.
+	 */
+	if (unlikely(kobj->state_initialized))
+		return -EAGAIN;
+
 	/* Kobject_put later will trigger netdev_queue_release call
 	 * which decreases dev refcount: Take that reference here
 	 */
-- 
2.41.0


