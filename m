Return-Path: <netdev+bounces-162653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F2A277C5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA003A8179
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31195214816;
	Tue,  4 Feb 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3LvySR5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04C215F7F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688610; cv=none; b=lsys5ZNbgjiH0aDAcNynkDKJzcE4FErrIW6s5bcpPOY42TpR1wWq2+RMVYRbKgT6wn4k5goiQlcy5Jk5Tb/KVFp9QpRzI0CK3KPdNGWzX7uePED1epUKEFeAjtnsBlseMSVxh3tcn+jB5fBLOyMIJR3nODjuirgcugKhS5UMxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688610; c=relaxed/simple;
	bh=3ZOgvzHKMTrSFkUJLNF+1BSosb6cxiOcGtYwe4u70mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCQ9q+ujb/mcw2UMzb5Iutmkg5uaNEXY2wGKIW2HbGR6Gmeg4nrik/w/v/Cp10w8nbB77P/JpqqF8o1vyYAr2a6+hmefWOS4CPiWHFJASQzMwb+b4czVAHhiG2wdn9aH/jpEoft+p6FzlyQwMmj2hAyvy9As0lUFbyopHlA7lTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3LvySR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A067C4CEE2;
	Tue,  4 Feb 2025 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738688609;
	bh=3ZOgvzHKMTrSFkUJLNF+1BSosb6cxiOcGtYwe4u70mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3LvySR54uJi/DA/UN6kDyCAuM1+SDqeDj2eQH66i/1jQtPa7rtnGX57ZqIb9O3A4
	 GWH4yppiR1e8suP4giS7mHlYp+VgxoE0QB4BT19ZGJAAfZPftFq9IDfhpj46lDGPze
	 5ZV9TUS5qhn2qWIj7S+3Xg7djdsHLVrxNoC7TLnXpylnVLEL7Vr3WnS17daYHCXMH1
	 Kni6yGBr3zIf/qQyIBF+34peWs47ZjCH1PldOyzFKa2P14ZmiGs6dShDrKrOdAcDUD
	 n896zHR3zywScLlyiNxZC8XJPk0rLyv4CRy1xaI0V4Cg3Ihz+bT+3mOp9ftKCYcGQm
	 1Y8Q3LQ8llcTA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	stephen@networkplumber.org,
	gregkh@linuxfoundation.org,
	maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net-sysfs: prevent uncleared queues from being re-added
Date: Tue,  4 Feb 2025 18:03:12 +0100
Message-ID: <20250204170314.146022-4-atenart@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204170314.146022-1-atenart@kernel.org>
References: <20250204170314.146022-1-atenart@kernel.org>
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
 net/core/net-sysfs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0b7ee260613d..027af27517fa 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1210,6 +1210,22 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
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
+	if (unlikely(kobj->state_initialized)) {
+		netdev_warn_once(dev, "Cannot re-add rx queues before their removal completed");
+		return -EAGAIN;
+	}
+
 	/* Kobject_put later will trigger rx_queue_release call which
 	 * decreases dev refcount: Take that reference here
 	 */
@@ -1898,6 +1914,22 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
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
+	if (unlikely(kobj->state_initialized)) {
+		netdev_warn_once(dev, "Cannot re-add tx queues before their removal completed");
+		return -EAGAIN;
+	}
+
 	/* Kobject_put later will trigger netdev_queue_release call
 	 * which decreases dev refcount: Take that reference here
 	 */
-- 
2.48.1


