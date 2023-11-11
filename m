Return-Path: <netdev+bounces-47170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F07E881B
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 03:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76671B20B73
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918AD3C29;
	Sat, 11 Nov 2023 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYCUOqka"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7123C16
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 02:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0870C433C7;
	Sat, 11 Nov 2023 02:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699668807;
	bh=fXnXbitxTtpKPlWt+QUPo/mebXC5xgI/Lqfvg7L3HSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYCUOqkaCkE3Yfe6l6Y4x2Wp1h/xdyuQXW2aBNJjUdaH9J8F/zKaP91S76MWnPQl4
	 eb4R93e37pACnRAM+iwFLyVwk89VLIEQAQOrVtvQwssLhKfyw+dCY745FhGQxXfbXM
	 LtgW4LKw76flzuYhpK7v+CVqp5gtNLq30w9dYQK+n3vcDcM5+GgrSJwR77Az0evjFL
	 EtN0MW2Osr8u/6UEuK0JPHo2hwMXcFPEKrUXXSPk/OQHiJ33Wzz+WbqKDSMaJCQpry
	 /brYgpLgO6ooNq6oyIQjTO5b1GbdrzKVC6dpw+vdWaxzeO9jEEcgPV5cgQvOaaWG1R
	 obk1thq9DL3fQ==
From: Jakub Kicinski <kuba@kernel.org>
To: gregkh@linuxfoundation.org,
	dxld@darkboxed.org
Cc: netdev@vger.kernel.org,
	richard@nod.at,
	pabeni@redhat.com,
	edumazet@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next] net: do not send a MOVE event when netdev changes netns
Date: Fri, 10 Nov 2023 18:13:24 -0800
Message-ID: <20231111021324.1702591-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016184514.5dda6518@kernel.org>
References: <20231016184514.5dda6518@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Networking supports changing netdevice's netns and name
at the same time. This allows avoiding name conflicts
and having to rename the interface in multiple steps.
E.g. netns1={eth0, eth1}, netns2={eth1} - we want
to move netns1:eth1 to netns2 and call it eth0 there.
If we can't rename "in flight" we'd need to (1) rename
eth1 -> $tmp, (2) change netns, (3) rename $tmp -> eth0.

To rename the underlying struct device we have to call
device_rename(). The rename()'s MOVE event, however, doesn't
"belong" to either the old or the new namespace.
If there are conflicts on both sides it's actually impossible
to issue a real MOVE (old name -> new name) without confusing
user space. And Daniel reports that such confusions do in fact
happen for systemd, in real life.

Since we already issue explicit REMOVE and ADD events
manually - suppress the MOVE event completely. Move
the ADD after the rename, so that the REMOVE uses
the old name, and the ADD the new one.

If there is no rename this changes the picture as follows:

Before:

old ns | KERNEL[213.399289] remove   /devices/virtual/net/eth0 (net)
new ns | KERNEL[213.401302] add      /devices/virtual/net/eth0 (net)
new ns | KERNEL[213.401397] move     /devices/virtual/net/eth0 (net)

After:

old ns | KERNEL[266.774257] remove   /devices/virtual/net/eth0 (net)
new ns | KERNEL[266.774509] add      /devices/virtual/net/eth0 (net)

If there is a rename and a conflict (using the exact eth0/eth1
example explained above) we get this:

Before:

old ns | KERNEL[224.316833] remove   /devices/virtual/net/eth1 (net)
new ns | KERNEL[224.318551] add      /devices/virtual/net/eth1 (net)
new ns | KERNEL[224.319662] move     /devices/virtual/net/eth0 (net)

After:

old ns | KERNEL[333.033166] remove   /devices/virtual/net/eth1 (net)
new ns | KERNEL[333.035098] add      /devices/virtual/net/eth0 (net)

Note that "in flight" rename is only performed when needed.
If there is no conflict for old name in the target netns -
the rename will be performed separately by dev_change_name(),
as if the rename was a different command, and there will still
be a MOVE event for the rename:

Before:

old ns | KERNEL[194.416429] remove   /devices/virtual/net/eth0 (net)
new ns | KERNEL[194.418809] add      /devices/virtual/net/eth0 (net)
new ns | KERNEL[194.418869] move     /devices/virtual/net/eth0 (net)
new ns | KERNEL[194.420866] move     /devices/virtual/net/eth1 (net)

After:

old ns | KERNEL[71.917520] remove   /devices/virtual/net/eth0 (net)
new ns | KERNEL[71.919155] add      /devices/virtual/net/eth0 (net)
new ns | KERNEL[71.920729] move     /devices/virtual/net/eth1 (net)

If deleting the MOVE event breaks some user space we should insert
an explicit kobject_uevent(MOVE) after the ADD, like this:

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11192,6 +11192,12 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
 	netdev_adjacent_add_links(dev);

+	/* User space wants an explicit MOVE event, issue one unless
+	 * dev_change_name() will get called later and issue one.
+	 */
+	if (!pat || new_name[0])
+		kobject_uevent(&dev->dev.kobj, KOBJ_MOVE);
+
 	/* Adapt owner in case owning user namespace of target network
 	 * namespace is different from the original one.
 	 */

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Daniel Gröber <dxld@darkboxed.org>
Link: https://lore.kernel.org/all/20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
WDYT?
---
 net/core/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..a26200cbf687 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11179,17 +11179,19 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	dev_net_set(dev, net);
 	dev->ifindex = new_ifindex;
 
-	/* Send a netdev-add uevent to the new namespace */
-	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
-	netdev_adjacent_add_links(dev);
-
 	if (new_name[0]) /* Rename the netdev to prepared name */
 		strscpy(dev->name, new_name, IFNAMSIZ);
 
 	/* Fixup kobjects */
+	dev_set_uevent_suppress(&dev->dev, 1);
 	err = device_rename(&dev->dev, dev->name);
+	dev_set_uevent_suppress(&dev->dev, 0);
 	WARN_ON(err);
 
+	/* Send a netdev-add uevent to the new namespace */
+	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
+	netdev_adjacent_add_links(dev);
+
 	/* Adapt owner in case owning user namespace of target network
 	 * namespace is different from the original one.
 	 */
-- 
2.41.0


