Return-Path: <netdev+bounces-214105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3ABB284B0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE7A1CC3B56
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A4304BB7;
	Fri, 15 Aug 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P1UTvyhO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A0304BA0
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277744; cv=none; b=nxju+eO3zG7NfxQupJlXxKnwSuPWTB6ZPcErBDgekoyah1pXRq+3dYGhqeRWLZnqY+LVknVJHIr3t5qI7dMLoK++QPGoqaM266Zi1x8zFrw1E3ow1n6YWPPVVCNhJoAsmbao4df3cPlOpFv8uIBdO0WC/5Kw0kkAITnLu/kNdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277744; c=relaxed/simple;
	bh=QfHu6tLXuJd+/WBauDhvCbTwtQ3bApCc3J/DQz1ip5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZyWWzfTqyr7HBi/79ev5bSHsLNmyF4qKxbojx3s5bhgaxTO0TALvTtu5eOmL+pnkplJNpWORiX6h84W9zyyTaqDzMui3YI7xOmlfTu4hhMrF2rhTTsgA7TLDhe4BxXPC6EZBBKguxuO6vEDnBlt56bO24pP40fAiqjhnqFuR+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P1UTvyhO; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70a88db0416so21009766d6.0
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755277742; x=1755882542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMrtEazDsbydoQH8MWp4czd/N5VoXBjQsVIKAzhRZv0=;
        b=P1UTvyhOWfB90FYUCsNvdr2W686ELNuVaiUs9Qtbw+8pBH/U0eT32xp5wlonu5Q9Z2
         7hdQTRdlYAn5HNJtiwdwwBukgbmGJHNVa0X5i3tsDK+94eoxdPOV76DEZIuwPA2RqtoJ
         dVJh/6PYmzc2wxvSSA25y6NFXBCcKGc2k/H7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755277742; x=1755882542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMrtEazDsbydoQH8MWp4czd/N5VoXBjQsVIKAzhRZv0=;
        b=ojHxAJH6r95CURC2HvA4TuPaa8br5CYo+SaRFXRwP3yQDYboeLsL1VybJ235Ir1f3C
         BWZyiTHCPMkSLEXWQ5que+H3kQef/FsXtk2hJ8Be75ZL+8IfZW5TUVXu0GuYZWFngREE
         jIoamY71ognLFKzpzgAynWKLrcYCwac2ry+LG5zcNinapu0YYXY8Kep9qzFmsAAGwK5l
         HslhAcwlBMtDRVDYTt+HeFSE9Vq8nKOZk8XhEy87T2zXLKpsRQIWMgzMvbLafhMLgUk4
         bpZ8+UwDuo+E5i3gPUcVPeglKX/jnjr6YtH76oIxzVIhYVHFF7J6ydSfXfBDB29QV/r1
         5uQw==
X-Gm-Message-State: AOJu0YyjFXviua9ofHeX2NB4eacw4CjrCWORP5HYYR93A1EHxe7XKdRx
	TFGT0KeJwFWESUSsbouR5WD3dgj+0bWSU/wbDmJW+LPx/WW4U4sNEeoSo4yNvp3xUQ==
X-Gm-Gg: ASbGnctc3qQ4L24h+FlwuxePTaJJhI8RBHOcqezGgXeVfVXU1tnJPv0L0wZ952r404i
	+oaXLsqv1CZ6Z56PlCufthu+BhDXZ+9ZV7bc0OGB0jPlZnpQevmYPkpLuYC+9w+B02XGHukjHrp
	WJqMZoHJaPKTthWgauIDlW7wRJ5cvZCHJssC3ZesNa5u7RL4eHyVDEITwpz6ztHeSOJhfQ5qh75
	S6nzWQuSZ/pA10yoyVQyiTYetSbb+VAh/TWKnBk3WW/6mghoo0tqjSOidkvmLGFiBA/0PMtwZ2T
	JZd55JNoU0RTLSsbWpFoPX7FEi4ztHKIvfJGJH1qqAHT7U7SP+s3G7JNlBLDpjmVNHEwQGwIwMq
	GiXxaPYk57iPQOU+aR7nXMQ5H0hoEsG3AtKuEeuUW/RVG5RgkhwNTMHgna2ZXlS7dJpV5HzVQrc
	gcQQ==
X-Google-Smtp-Source: AGHT+IGuywqulvjWjCVtEh43+8ZYgrbIlqh01GFBCrQltfE7N5bVM31U/YknzhBLEvd1MFsi5O6l6w==
X-Received: by 2002:a05:6214:21a2:b0:707:bba:40d4 with SMTP id 6a1803df08f44-70ba7aa5a49mr31765606d6.11.1755277741923;
        Fri, 15 Aug 2025 10:09:01 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f221sm10725436d6.12.2025.08.15.10.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:09:01 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	sdf@fomichev.me
Subject: [PATCH net] bnxt_en: Fix lockdep warning during rmmod
Date: Fri, 15 Aug 2025 10:08:23 -0700
Message-ID: <20250815170823.4062508-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit under the Fixes tag added a netdev_assert_locked() in
bnxt_free_ntp_fltrs().  The lock should be held during normal run-time
but the assert will be triggered (see below) during bnxt_remove_one()
which should not need the lock.  The netdev is already unregistered by
then.  Fix it by only calling netdev_assert_locked() if the netdev is
registered.

WARNING: CPU: 5 PID: 2241 at ./include/net/netdev_lock.h:17 bnxt_free_ntp_fltrs+0xf8/0x100 [bnxt_en]
Modules linked in: rpcrdma rdma_cm iw_cm ib_cm configfs ib_core bnxt_en(-) bridge stp llc x86_pkg_temp_thermal xfs tg3 [last unloaded: bnxt_re]
CPU: 5 UID: 0 PID: 2241 Comm: rmmod Tainted: G S      W           6.16.0 #2 PREEMPT(voluntary)
Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
RIP: 0010:bnxt_free_ntp_fltrs+0xf8/0x100 [bnxt_en]
Code: 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 8b 47 60 be ff ff ff ff 48 8d b8 28 0c 00 00 e8 d0 cf 41 c3 85 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffa92082387da0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff9e5b593d8000 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff83dc9a70 RDI: ffffffff83e1a1cf
RBP: ffff9e5b593d8c80 R08: 0000000000000000 R09: ffffffff8373a2b3
R10: 000000008100009f R11: 0000000000000001 R12: 0000000000000001
R13: ffffffffc01c4478 R14: dead000000000122 R15: dead000000000100
FS:  00007f3a8a52c740(0000) GS:ffff9e631ad1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bb289419c8 CR3: 000000011274e001 CR4: 00000000003706f0
Call Trace:
 <TASK>
 bnxt_remove_one+0x57/0x180 [bnxt_en]
 pci_device_remove+0x39/0xc0
 device_release_driver_internal+0xa5/0x130
 driver_detach+0x42/0x90
 bus_remove_driver+0x61/0xc0
 pci_unregister_driver+0x38/0x90
 bnxt_exit+0xc/0x7d0 [bnxt_en]

Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2800a90fba1f..a208c2a73cd6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5332,7 +5332,8 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
 {
 	int i;
 
-	netdev_assert_locked(bp->dev);
+	if (bp->dev->reg_state == NETREG_REGISTERED)
+		netdev_assert_locked(bp->dev);
 
 	/* Under netdev instance lock and all our NAPIs have been disabled.
 	 * It's safe to delete the hash table.
-- 
2.30.1


