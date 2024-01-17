Return-Path: <netdev+bounces-64082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9283102D
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 00:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C8D2811B4
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 23:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9034728DD4;
	Wed, 17 Jan 2024 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VFlpH74Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5AA28DA2
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535136; cv=none; b=VfNedOx+SA3lkIYzrJkBonDlHmGxBPaiMGwLkWN/i/EXiORkJtby6uGd8BjUb77Ximlw6JURMpEq+xPXUPnmyhNAwcGCV8GVZHFBaCFDYcUUJiECer4SjtxkrX57ZCGE5pzV5BL+L/vecoiFU3+bu4ovUN+inIqdwJAOhL0m/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535136; c=relaxed/simple;
	bh=zp7H9c8z1rESVzD4ZqlJ/sqjzc2ISHCFJnIZnfWRr0c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvevLKCKsvNIJHMaM1cyopyZYL3EOSzWX3qZQw7kvLVLtjUxg8ceCLIdRgT6uwgm6Q8z9z/9bFXkqnh5USgGFOf2pdfDr16wGUkSHi5X5oHg8xyYVQNvsVq0JzMmNG7N12c7dEhYo1UHlK7I9Gk3QhMpZkRf8hfESQz9CNbFGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VFlpH74Q; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7831389c7daso991828885a.2
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 15:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705535134; x=1706139934; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UUTVefFt4p9qYBGlAqt24JblMI31cmEW6S8V0jBbKs=;
        b=VFlpH74QGvJ36a5Drzv4jH89xsRdyC4KatAl4fZUGH7Eq3NudokDgFhgb6AxtW3n7z
         Go+iVnYwoG/EKT/fEJsvS1UmctIeq56XJp1MO20Hau9npvLNNcTKcK6ayCCqf2CE+aun
         0zwH8BmTK1QbJyu4EDDP/RB2RQEWFASNbba78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705535134; x=1706139934;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UUTVefFt4p9qYBGlAqt24JblMI31cmEW6S8V0jBbKs=;
        b=oXjobV7Bley9fCJOirxkDbIJj5bvV2+mw1gjhwMxJc2eOFp7toY0R3rb0+9LX28iMJ
         ap229LQHd7WqTdluxS+O0up+Ir81HTpmIZmFYwHcy1p95bQt3v6AoAFxgH4om7XaBzVR
         FUNaoSdmhHknxfYhfnorWrr5JlXU2H3NiD8uhqcLev+4Q4XDDIrR5x3VqgdJY8PziThW
         d2I3F2AQDMLc/PSE6PAAOrfx1XhWVXTk8MRai8kvdbtkaHgbDe/fxI59p3MiziX8myJX
         U0L9p3J/jDgan9sbpKVbh0UI+QnmwIKL5VlgJHKrtr62TBlai9BNpRTySxgHpvK7c0k5
         pxUA==
X-Gm-Message-State: AOJu0Yzn07s71BEPOQH724gh0xSDDlrD3zgELZWU7lSegpM0SzV/1vSh
	5aw5pMM+2Jn5xazOcTVoBvzhrbbz7j//
X-Google-Smtp-Source: AGHT+IEN09gpjgjZDYQkRvfXmkSacx0mxBVgX/nDv6CEZ/xcsN6IKolEpNIPCWLsRTj/uq8K6CJHFQ==
X-Received: by 2002:ae9:e007:0:b0:783:4d8:d178 with SMTP id m7-20020ae9e007000000b0078304d8d178mr10537889qkk.119.1705535133454;
        Wed, 17 Jan 2024 15:45:33 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a126800b0077d78c5b575sm4851105qkl.111.2024.01.17.15.45.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2024 15:45:33 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH net 5/5] bnxt_en: Fix possible crash after creating sw mqprio TCs
Date: Wed, 17 Jan 2024 15:45:15 -0800
Message-Id: <20240117234515.226944-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240117234515.226944-1-michael.chan@broadcom.com>
References: <20240117234515.226944-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d06129060f2cd705"

--000000000000d06129060f2cd705
Content-Transfer-Encoding: 8bit

The driver relies on netdev_get_num_tc() to get the number of HW
offloaded mqprio TCs to allocate and free TX rings.  This won't
work and can potentially crash the system if software mqprio or
taprio TCs have been setup.  netdev_get_num_tc() will return the
number of software TCs and it may cause the driver to allocate or
free more TX rings that it should.  Fix it by adding a bp->num_tc
field to store the number of HW offload mqprio TCs for the device.
Use bp->num_tc instead of netdev_get_num_tc().

This fixes a crash like this:

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 42b8404067 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 120 PID: 8661 Comm: ifconfig Kdump: loaded Tainted: G           OE     5.18.16 #1
Hardware name: Lenovo ThinkSystem SR650 V3/SB27A92818, BIOS ESE114N-2.12 04/25/2023
RIP: 0010:bnxt_hwrm_cp_ring_alloc_p5+0x10/0x90 [bnxt_en]
Code: 41 5c 41 5d 41 5e c3 cc cc cc cc 41 8b 44 24 08 66 89 03 eb c6 e8 b0 f1 7d db 0f 1f 44 00 00 41 56 41 55 41 54 55 48 89 fd 53 <48> 8b 06 48 89 f3 48 81 c6 28 01 00 00 0f b6 96 13 ff ff ff 44 8b
RSP: 0018:ff65907660d1fa88 EFLAGS: 00010202
RAX: 0000000000000010 RBX: ff4dde1d907e4980 RCX: f400000000000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ff4dde1d907e4980
RBP: ff4dde1d907e4980 R08: 000000000000000f R09: 0000000000000000
R10: ff4dde5f02671800 R11: 0000000000000008 R12: 0000000088888889
R13: 0500000000000000 R14: 00f0000000000000 R15: ff4dde5f02671800
FS:  00007f4b126b5740(0000) GS:ff4dde9bff600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000416f9c6002 CR4: 0000000000771ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 bnxt_hwrm_ring_alloc+0x204/0x770 [bnxt_en]
 bnxt_init_chip+0x4d/0x680 [bnxt_en]
 ? bnxt_poll+0x1a0/0x1a0 [bnxt_en]
 __bnxt_open_nic+0xd2/0x740 [bnxt_en]
 bnxt_open+0x10b/0x220 [bnxt_en]
 ? raw_notifier_call_chain+0x41/0x60
 __dev_open+0xf3/0x1b0
 __dev_change_flags+0x1db/0x250
 dev_change_flags+0x21/0x60
 devinet_ioctl+0x590/0x720
 ? avc_has_extended_perms+0x1b7/0x420
 ? _copy_from_user+0x3a/0x60
 inet_ioctl+0x189/0x1c0
 ? wp_page_copy+0x45a/0x6e0
 sock_do_ioctl+0x42/0xf0
 ? ioctl_has_perm.constprop.0.isra.0+0xbd/0x120
 sock_ioctl+0x1ce/0x2e0
 __x64_sys_ioctl+0x87/0xc0
 do_syscall_64+0x59/0x90
 ? syscall_exit_work+0x103/0x130
 ? syscall_exit_to_user_mode+0x12/0x30
 ? do_syscall_64+0x69/0x90
 ? exc_page_fault+0x62/0x150

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 19 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0f5004872a46..39845d556baf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3817,7 +3817,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 {
 	bool sh = !!(bp->flags & BNXT_FLAG_SHARED_RINGS);
 	int i, j, rc, ulp_base_vec, ulp_msix;
-	int tcs = netdev_get_num_tc(bp->dev);
+	int tcs = bp->num_tc;
 
 	if (!tcs)
 		tcs = 1;
@@ -9946,7 +9946,7 @@ static int __bnxt_num_tx_to_cp(struct bnxt *bp, int tx, int tx_sets, int tx_xdp)
 
 int bnxt_num_tx_to_cp(struct bnxt *bp, int tx)
 {
-	int tcs = netdev_get_num_tc(bp->dev);
+	int tcs = bp->num_tc;
 
 	if (!tcs)
 		tcs = 1;
@@ -9955,7 +9955,7 @@ int bnxt_num_tx_to_cp(struct bnxt *bp, int tx)
 
 static int bnxt_num_cp_to_tx(struct bnxt *bp, int tx_cp)
 {
-	int tcs = netdev_get_num_tc(bp->dev);
+	int tcs = bp->num_tc;
 
 	return (tx_cp - bp->tx_nr_rings_xdp) * tcs +
 	       bp->tx_nr_rings_xdp;
@@ -9985,7 +9985,7 @@ static void bnxt_setup_msix(struct bnxt *bp)
 	struct net_device *dev = bp->dev;
 	int tcs, i;
 
-	tcs = netdev_get_num_tc(dev);
+	tcs = bp->num_tc;
 	if (tcs) {
 		int i, off, count;
 
@@ -10017,8 +10017,10 @@ static void bnxt_setup_inta(struct bnxt *bp)
 {
 	const int len = sizeof(bp->irq_tbl[0].name);
 
-	if (netdev_get_num_tc(bp->dev))
+	if (bp->num_tc) {
 		netdev_reset_tc(bp->dev);
+		bp->num_tc = 0;
+	}
 
 	snprintf(bp->irq_tbl[0].name, len, "%s-%s-%d", bp->dev->name, "TxRx",
 		 0);
@@ -10244,8 +10246,8 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 {
-	int tcs = netdev_get_num_tc(bp->dev);
 	bool irq_cleared = false;
+	int tcs = bp->num_tc;
 	int rc;
 
 	if (!bnxt_need_reserve_rings(bp))
@@ -10271,6 +10273,7 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 		    bp->tx_nr_rings - bp->tx_nr_rings_xdp)) {
 		netdev_err(bp->dev, "tx ring reservation failure\n");
 		netdev_reset_tc(bp->dev);
+		bp->num_tc = 0;
 		if (bp->tx_nr_rings_xdp)
 			bp->tx_nr_rings_per_tc = bp->tx_nr_rings_xdp;
 		else
@@ -13800,7 +13803,7 @@ int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 		return -EINVAL;
 	}
 
-	if (netdev_get_num_tc(dev) == tc)
+	if (bp->num_tc == tc)
 		return 0;
 
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
@@ -13818,9 +13821,11 @@ int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 	if (tc) {
 		bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tc;
 		netdev_set_num_tc(dev, tc);
+		bp->num_tc = tc;
 	} else {
 		bp->tx_nr_rings = bp->tx_nr_rings_per_tc;
 		netdev_reset_tc(dev);
+		bp->num_tc = 0;
 	}
 	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
 	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b8ef1717cb65..47338b48ca20 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2225,6 +2225,7 @@ struct bnxt {
 	u8			tc_to_qidx[BNXT_MAX_QUEUE];
 	u8			q_ids[BNXT_MAX_QUEUE];
 	u8			max_q;
+	u8			num_tc;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index 63e067038385..0dbb880a7aa0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -228,7 +228,7 @@ static int bnxt_queue_remap(struct bnxt *bp, unsigned int lltc_mask)
 		}
 	}
 	if (bp->ieee_ets) {
-		int tc = netdev_get_num_tc(bp->dev);
+		int tc = bp->num_tc;
 
 		if (!tc)
 			tc = 1;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 1f6e0cd84f2e..dc4ca706b0e2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -884,7 +884,7 @@ static void bnxt_get_channels(struct net_device *dev,
 	if (max_tx_sch_inputs)
 		max_tx_rings = min_t(int, max_tx_rings, max_tx_sch_inputs);
 
-	tcs = netdev_get_num_tc(dev);
+	tcs = bp->num_tc;
 	tx_grps = max(tcs, 1);
 	if (bp->tx_nr_rings_xdp)
 		tx_grps++;
@@ -944,7 +944,7 @@ static int bnxt_set_channels(struct net_device *dev,
 	if (channel->combined_count)
 		sh = true;
 
-	tcs = netdev_get_num_tc(dev);
+	tcs = bp->num_tc;
 
 	req_tx_rings = sh ? channel->combined_count : channel->tx_count;
 	req_rx_rings = sh ? channel->combined_count : channel->rx_count;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index c2b25fc623ec..4079538bc310 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -407,7 +407,7 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	if (prog)
 		tx_xdp = bp->rx_nr_rings;
 
-	tc = netdev_get_num_tc(dev);
+	tc = bp->num_tc;
 	if (!tc)
 		tc = 1;
 	rc = bnxt_check_rings(bp, bp->tx_nr_rings_per_tc, bp->rx_nr_rings,
-- 
2.30.1


--000000000000d06129060f2cd705
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGiKuOjEJ18kAFou7VZMbDz99eq0Ira5
F8+ywfawMgLrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEx
NzIzNDUzNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB1gUY4gfFD5vyieH8Eu2+D759jFKiSemcmy6/w+kUYtnCAqlvR
/Nhq2I/rQ2WTsA0kSVEKJuPItJeCsbwCyc9qpGHlHoF0veKEFlmlXlGGvPL+esOdH0Zd+OIJoXjb
iG0UWxLD3B9JAWTtWQUo9LzWOcPP2O9jnDsnprBXNEfFaG83nsSze0TpG7PbPxYHU2hcHwOOHxn8
eaIR4HFuSt6HuRTCMq42z3gmE+n3KZYH5lTXjEu6Mt7oywrkgJYe7aNIwgRvYFl/JhogEEZhSY/6
X7rGcffaaP+hz5LdoO4gAxr36dnxnVfh8IXMPnYQchecX/kiqDm/AckI+vn5qTv5
--000000000000d06129060f2cd705--

