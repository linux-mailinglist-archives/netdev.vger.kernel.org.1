Return-Path: <netdev+bounces-108498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A2923FA9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A352528B47C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DCE1B580F;
	Tue,  2 Jul 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN1KX9xu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F81B4C51
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928562; cv=none; b=A66XlyqJ3dniO2gd2aBOiekcADHo95Mxn5keMz+gAAUkJL4/7DNgMH+bA+sRe+of9rWVcaypYGs2ruwEHCk1U5o1E7CYt1oQN+x4YpVKIMtOWXbCjYwS3fEiBwxnhnJ3Pdrx7fA0lf1UgRMm98+2Y7jpkVZ7wgeBsE6CDFt0DwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928562; c=relaxed/simple;
	bh=Y2Qu0TIJwKQDeoiTu4uTBHFv2uTrpIw73oRA4Oe8AXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f377Jx+W0GL73URiSj2QXFA2lJto33uWgRInUO7gcEeObQJQZpd9xKAKkoet6vxFmLAWfbuwrJYaWnXllMZT50dJ3AsLJz/p662njAFW3bwQWABC805buDKzEY+O31l1146zMWdGFyvdvQltlP7xnmWjq2CbE+k59Z5XtY755fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN1KX9xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F2C4AF0C;
	Tue,  2 Jul 2024 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719928561;
	bh=Y2Qu0TIJwKQDeoiTu4uTBHFv2uTrpIw73oRA4Oe8AXI=;
	h=From:Date:Subject:To:Cc:From;
	b=ZN1KX9xuGLC5omBA15agB1FQzoqj5Ira9tugDRP3V5rXfuHysdrjlUCwPx04AI5dT
	 t4G1Ljo1dQHcbasBrVURtOuIgmcSYCZMnhmQfv0xfx7toRaCcxJX3T2evwfRd8ot8c
	 qAW0vubkt6q/L2rscU0/XKh/O/O4a36BY3e2yT9FbyZ29YZ/5Nkeo9plAO7woGZYl9
	 zW2Vr8cJBzi5ddjJ/M/bqrtZVSKGRdJH+ioj2I48FLp5KhzO99UDW4z+Xp9Km0mIdY
	 HfivqbiyHZFq3Q/5cQmc4sH9JczM3bakEbsSWcqJ0bYztH8NOwm/QqIjEAK14m+ov9
	 gPQuqlCcpi1fA==
From: 'Simon Horman' <horms@kernel.org>
Date: Tue, 02 Jul 2024 14:55:55 +0100
Subject: [PATCH net v6] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-bond-oob-v6-1-2dfdba195c19@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOoGhGYC/2WMTQ7CIBBGr9LMWsxQKYgr72FclDK2RAMNNETT9
 O4SNmpcfj/vrZAoOkpwalaIlF1ywZcgdw0MU+9HYs6WDC22AgXXzARvWQiGcXEc0OhOoh2g3Od
 IN/esqgt4WuBaysmlJcRX1WdRp39TFowzqa3lvZTWtHi+U/T02Ic4VkvuPqQ84BfZFVJZpbUk7
 FGpH3LbtjdlsmjG4AAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, 
 Andy Gospodarek <andy@greyhouse.net>, 
 Ding Tianhong <dingtianhong@huawei.com>, Hangbin Liu <liuhangbin@gmail.com>, 
 Sam Sun <samsun1006219@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

From: Sam Sun <samsun1006219@gmail.com>

In function bond_option_arp_ip_targets_set(), if newval->string is an
empty string, newval->string+1 will point to the byte after the
string, causing an out-of-bound read.

BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc1/0x5e0 mm/kasan/report.c:475
 kasan_report+0xbe/0xf0 mm/kasan/report.c:588
 strlen+0x7d/0xa0 lib/string.c:418
 __fortify_strlen include/linux/fortify-string.h:210 [inline]
 in4_pton+0xa3/0x3f0 net/core/utils.c:130
 bond_option_arp_ip_targets_set+0xc2/0x910
drivers/net/bonding/bond_options.c:1201
 __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
 __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
 bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
 bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:156
 dev_attr_store+0x54/0x80 drivers/base/core.c:2366
 sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x96a/0xd80 fs/read_write.c:584
 ksys_write+0x122/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
---[ end trace ]---

Fix it by adding a check of string length before using it.

Fixes: f9de11a16594 ("bonding: add ip checks when store ip target")
Signed-off-by: Yue Sun <samsun1006219@gmail.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v6 (Simon):
- Update check to strlen(...) < 1, as suggested by Jakub
- Not accumulating tags due to above change,
  which is material given the size of this patch
- Link to v5: https://lore.kernel.org/r/20240630-bond-oob-v5-1-7d7996e0a077@kernel.org

Changes in v5 (Simon):
- Remove stray 'I4' from netdev_err() string. Thanks to Hangbin Liu.
- Sorry for the long delay between v4 and v5, this completely slipped my
  mind.
- Link to v4: https://lore.kernel.org/r/20240419-bond-oob-v4-1-69dd1a66db20@kernel.org

Changes in v4 (Simon):
- Correct  whitespace mangled patch; posting as requested by Sam Sun
- Link to v3: https://lore.kernel.org/r/CAEkJfYOnsLLiCrtgOpq2Upr+_W0dViYVHU8YdjJOi-mxD8H9oQ@mail.gmail.com

Changes in v3 (Sam Sun):
- According to Hangbin's opinion, change Fixes tag from 4fb0ef585eb2
  ("bonding: convert arp_ip_target to use the new option API") to
  f9de11a16594 ("bonding: add ip checks when store ip target").
- Link to v2: https://lore.kernel.org/r/CAEkJfYMdDQKY1C-wBZLiaJ=dCqfM9r=rykwwf+J-XHsFp7D9Ag@mail.gmail.com/

Changes in v2 (Sam Sun):
- According to Jay and Hangbin's opinion, remove target address in
  netdev_err message since target is not initialized in error path and
  will not provide useful information.
- Link to v1: https://lore.kernel.org/r/CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q8kAq+74J=R+4HkngWw@mail.gmail.com/
---
 drivers/net/bonding/bond_options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 0cacd7027e35..bc80fb6397dc 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1214,9 +1214,9 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 	__be32 target;
 
 	if (newval->string) {
-		if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
-			netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
-				   &target);
+		if (strlen(newval->string) < 1 ||
+		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
+			netdev_err(bond->dev, "invalid ARP target specified\n");
 			return ret;
 		}
 		if (newval->string[0] == '+')


