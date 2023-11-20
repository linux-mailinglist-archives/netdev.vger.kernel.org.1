Return-Path: <netdev+bounces-49354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23567F1CD4
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447CA1F25CE1
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3CF1D55C;
	Mon, 20 Nov 2023 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1llMaYw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9573218D
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FE2C433C7;
	Mon, 20 Nov 2023 18:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700505707;
	bh=DSOS1vwUDRF0TUtlBg7e0ExA1++SWXq9vwHM/XFkhMc=;
	h=From:To:Cc:Subject:Date:From;
	b=c1llMaYwFQeEE4t0No6cyQyrMkfPd6paEa2yMwFSA9FAOI/vwDxxT6TvGag540QbX
	 m419Kb0Q9WctEII0zznZR3LuCESE/fv8o4XzVFJpxK94ZkN4hC+q2WzLIHcgtGqWDA
	 nMym6TEnb2leHiiYDbODH+95HKqESIJUU5AkstNOi8eQO0wzF9iSDlqdZu3AQMeNN2
	 vWRGMyVrjxSIehJFM1SEHxbpH3DRC5skuaxYb2gRQyGK3UenvwviTere710l6tBgkv
	 9xhxeF4OBk1BlwKwoV8e7hlwB9ShIEkUXwGQxukKQzVhCIWKbLVAfqLJNtfvRZrCdO
	 2ujnJ56NNR6ag==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [PATCH net-next] net: do not send a MOVE event when netdev changes netns
Date: Mon, 20 Nov 2023 10:41:40 -0800
Message-ID: <20231120184140.578375-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
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
 net/core/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index af53f6d838ce..0bdc6bf758f3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11181,17 +11181,19 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
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
2.42.0


