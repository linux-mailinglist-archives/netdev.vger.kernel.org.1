Return-Path: <netdev+bounces-164660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97151A2EA22
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0AE188BC5E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640F31E9904;
	Mon, 10 Feb 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTCP2TDs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA231E5B99
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184767; cv=none; b=P2Mei2wZ8MwVDbiLtCttjiHn57w6V3Cv0Zjd39ipAPZeZ91CgYFTklEUPnDqBi6egx8bMnF2OJyINAVXdFp3cs67vhyGbDfgfHz6rN25ujOQvrfRR1Cpk7YYPic5Gc0mHErc74ihIBgwY6zisJR2T3nFKJtcVDhHZsOsdOu/EMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184767; c=relaxed/simple;
	bh=+FIl5KiLrOz/AYh8h5sR9DrZ4kQKWVhqpOczG0vEFEo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PXgtsOsLcuXGzkxzfyVS93/pHbseKU+XSgEBgzD481FPM6RTshG1GzKLdyKfdXcKyiAXwta5gTfXZMKFBBY76lQg3cm/KezWe3EInjNCckjjIVnqd17J7G9mxcFJ9K0m5EEWTUCBqoKOEiUf8QKMI8vs7tcS1g8sQXw3eHPWRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTCP2TDs; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4717d47db8dso26873701cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739184764; x=1739789564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WeJcKNr6jgdLfZaGespPeMN/bSBvq77tlk53+UyZfro=;
        b=fTCP2TDsz6qz7zvB2t7fQOuw2z6uQ5Y4NJPBdBx6v0E65d+DzFUSF1HALcsKAbmvVl
         sZKTAvOvoVCY2tUrQhotn4Wf7ry4zs9GYuuLYy/gIiB3dJa2CqjGCbg84XIdvb4vIm35
         7jPgahs1PaeunLjgt6FCOdBQNLHK4ZVED/ksywKP7xAd1dVpKcR1k04WloiD7CWzO0TV
         ZCfHafnes/0JOzKjptgIiQPYnbZ5OG0wlWWLCzUiB6UnEDcKyRpSK9++3LFq07Yruslu
         UsmzmGlDOSm4+mWUU7m6dv/44Qpd+eK+MsU6s43+LLSV9U7QtVDRYphmaravuH7bWMpm
         N5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739184764; x=1739789564;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WeJcKNr6jgdLfZaGespPeMN/bSBvq77tlk53+UyZfro=;
        b=wprqwxKQ27rNp1fFNYeEb5XPLIKU5a6Bq9M/phVBo89+MhuCjjflDt+LpXx2bC7ikC
         l1/MNFEg2R7IHFY6pLeB8RQ2KQIQjGWAkp2HqeqLUC6/7x6anLK5sU0Rwu/oDTISsukB
         2Fjb9etllXfJy0n7WPCIz11ipdC5VDVBVSklrzII7cEu1DGiD6TM99WLDd8b7cM7+9Vq
         VNtQ6l7yAD9VcTJYw203N9G4PzgyOHFdesp+2/Yo0DmFwUtdoFoHpxGyYo0uTm+vblG5
         cBFJeJtXX2k0cUnC9fiuDoSHGc0u1aWp4NQ4xnWXqNvlcv1ZpPyncNGqrp2rcWyrRjC3
         p7Uw==
X-Gm-Message-State: AOJu0YxBYE8QRBbfevmTofViXTud9nR9SgSBZHiThDKUCf8I9ulgjzfD
	BaadKalyCrEMT1lxyd5ZbRqTaWPTV9ncnNeSip0eQTRKgz2OMO4y8sCBULEqRjetfhAcqE740FB
	f4RiB/lUS5Q==
X-Google-Smtp-Source: AGHT+IF+sTuHB/64tpV9Y2aXT5bP5+2RZR+cUL/lU4sNGCpHDaCVnkDGvaAyMxH0XiEgs6+oB015iANBmIHKjA==
X-Received: from qtbge5.prod.google.com ([2002:a05:622a:5c85:b0:471:8b12:7ce0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:244c:b0:471:86c8:c93a with SMTP id d75a77b69052e-47186c8dc59mr94311381cf.19.1739184764531;
 Mon, 10 Feb 2025 02:52:44 -0800 (PST)
Date: Mon, 10 Feb 2025 10:52:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210105242.883482-1-edumazet@google.com>
Subject: [PATCH net] vxlan: check vxlan_vnigroup_init() return value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+6a9624592218c2c5e7aa@syzkaller.appspotmail.com, 
	Roopa Prabhu <roopa@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

vxlan_init() must check vxlan_vnigroup_init() success
otherwise a crash happens later, spotted by syzbot.

Oops: general protection fault, probably for non-canonical address 0xdffffc000000002c: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000160-0x0000000000000167]
CPU: 0 UID: 0 PID: 7313 Comm: syz-executor147 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:vxlan_vnigroup_uninit+0x89/0x500 drivers/net/vxlan/vxlan_vnifilter.c:912
Code: 00 48 8b 44 24 08 4c 8b b0 98 41 00 00 49 8d 86 60 01 00 00 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 04 00 00 49 8b 86 60 01 00 00 48 ba 00 00 00
RSP: 0018:ffffc9000cc1eea8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8672effb
RDX: 000000000000002c RSI: ffffffff8672ecb9 RDI: ffff8880461b4f18
RBP: ffff8880461b4ef4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000020000
R13: ffff8880461b0d80 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fecfa95d6c0(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fecfa95cfb8 CR3: 000000004472c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  vxlan_uninit+0x1ab/0x200 drivers/net/vxlan/vxlan_core.c:2942
  unregister_netdevice_many_notify+0x12d6/0x1f30 net/core/dev.c:11824
  unregister_netdevice_many net/core/dev.c:11866 [inline]
  unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11736
  register_netdevice+0x1829/0x1eb0 net/core/dev.c:10901
  __vxlan_dev_create+0x7c6/0xa30 drivers/net/vxlan/vxlan_core.c:3981
  vxlan_newlink+0xd1/0x130 drivers/net/vxlan/vxlan_core.c:4407
  rtnl_newlink_create net/core/rtnetlink.c:3795 [inline]
  __rtnl_newlink net/core/rtnetlink.c:3906 [inline]

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: syzbot+6a9624592218c2c5e7aa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67a9d9b4.050a0220.110943.002d.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 05c10acb2a57edef3d012b49fe9b964c6c3e818d..92516189e792f842f172c3fb7b16515204acc19d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2898,8 +2898,11 @@ static int vxlan_init(struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	int err;
 
-	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
-		vxlan_vnigroup_init(vxlan);
+	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
+		err = vxlan_vnigroup_init(vxlan);
+		if (err)
+			return err;
+	}
 
 	err = gro_cells_init(&vxlan->gro_cells, dev);
 	if (err)
-- 
2.48.1.502.g6dc24dfdaf-goog


