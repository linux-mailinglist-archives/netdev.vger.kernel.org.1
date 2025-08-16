Return-Path: <netdev+bounces-214323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A030BB2901D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9541B639E9
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 18:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C91FDE14;
	Sat, 16 Aug 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QX85cYjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA701FECA1
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755369622; cv=none; b=q1qFM4FawHBKzELmwcMSHYSUOpX/jTPhxFgTGOSLq691/IupO84aQHPjuopBeORc8rk6qGGdMk3INM9mCfLZGxtzSsgeR6DpVDserHuUXRa7fg+jnL0dOBcXpzIhAZzms+KrKORG0qiL5W5oVwtzcTULMROoBcbm8hLLSSrWPdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755369622; c=relaxed/simple;
	bh=z08Jr7P8hu2oefHrkDq/WIQ//YpY6UYZlwy1aevr608=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7X6ma0SEkZ5LmEyPT3HR4YiqxLEFBHdjUNcgweGxvdMFXFeeZcJEE+es5wJ3tzx1Rmnv/68sBhoP7mcOxUDDuv+NaQJm4tpzvBGu2XgIPsHMxqFwhpupjctwpRC+Av0izPtejIIbsvhxCnQ9x8FFzgn+hDAHSn7o30VTSmXckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QX85cYjh; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a927d4aaaso25549276d6.1
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755369620; x=1755974420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mbcwx98lB/QEoiQ9FRWT/djaHQYjYPeHTVxWkrP/sRE=;
        b=QX85cYjhl+iYQl2U/+YdM5Y4rOlfxxIAyCHZVlKUsgP1Mnk0Wtx21Gmyey/k0bqHkB
         FR0FnGy5ThK121GOZFVZaGVimLK3dNN6HELXcJEg1ci/ddXUfElSpQzlyUYs5phUBZCk
         o9PRQUZ5MeXeM9zohrcABQ38fno02xVzrbDh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755369620; x=1755974420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mbcwx98lB/QEoiQ9FRWT/djaHQYjYPeHTVxWkrP/sRE=;
        b=HoNUAFM8XwvCYPhSQVam2/R2+VBRdQWjAxS6fzqneBpG9y4zu4I5ySKeZzZ8YwLlDm
         B5Ozv6VcLrv0ganGEXsaDrtSVUzmISDx/aKNkV/Damrr6x29PVhh/XdCQoQBEYahTaar
         RCEP8o6gZLdOoVXSUHAKo/RXRE/Tv4QqLXsMxh0Oj/jzeRuWoaIp+iIlC6e6//Le+866
         /2yZPWF/opLevtxD0C1f15L3aimAMKwY7Hltyedp2HWaM/yBDGGlmFxiZ5SMupAehwiu
         zDKm8QUYJMsRNtPWyIMAo8u8/wCdhvTyjx7kcsZXNWn4g1LMs+XdiP8X/LD2wiK+s22T
         y+Hw==
X-Gm-Message-State: AOJu0YxUJ8hNDSGLAfrduq9GeF5CfN2MDK5z0tO7/MbTGSta8kLvK5jv
	jKRMYHgoEh6j6Rg4RvVquS/Y9kSkXhYvf77qH1SSflv5zmwWEK5FtAXS049ra0q1mw==
X-Gm-Gg: ASbGncsCtfYYjCWEekDXb6RP0pEURS5F+V8FtOUYSyw6t+bmYa7MQIC4gKqQuc7QsZZ
	hl+Ky3YVKczvHovGWzWWel4ZNzSFsRrBzSIZaXoS5kRm1zKgRVtkyihi39DPJqAQbWRNkxrmQKa
	ArPR32BVjTnGw1SqgpfdpvHySFG+GOQ4ksnRy95oBa4Fe5HHWJuuVsixN3/mi4XsN6DfyJxb8aU
	BOHD+B37c34aE2Aj2VxiBs/N11YxFW9G1Hh3DFBGmk6RXrX5gwgr1b8JxKIP1EI+p0/cKj64+/q
	I/PuC2WGqIWPhVbMOs7iovS3iRPJkHKsSWOESyYo/beKKgsQoXViw0e+OF+UShn53B/qD79QBEW
	1KkaiHD/NPXfXfUiNHOMeYyOIoFpAAoXQSd/PUXW6VL9ssZ4K/AXCjeuwaVhMlG1gtlIuuuNXiA
	==
X-Google-Smtp-Source: AGHT+IG3llcDftK3ZYrLazYpPnWCXyxAj7AuxN3wfesQ1EzqkLMlLzJ1Fb9qRIJ0kepc+WywtgqhRg==
X-Received: by 2002:a05:6214:2304:b0:707:3829:d491 with SMTP id 6a1803df08f44-70ba7847556mr83929346d6.0.1755369619647;
        Sat, 16 Aug 2025 11:40:19 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9301703sm26552936d6.49.2025.08.16.11.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:40:19 -0700 (PDT)
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
Subject: [PATCH net v2] bnxt_en: Fix lockdep warning during rmmod
Date: Sat, 16 Aug 2025 11:38:50 -0700
Message-ID: <20250816183850.4125033-1-michael.chan@broadcom.com>
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
then.  Fix it by calling netdev_assert_locked_or_invisible() which will
not assert if the netdev is unregistered.

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
v2: Use netdev_assert_locked_or_invisible()

v1: https://lore.kernel.org/netdev/20250815170823.4062508-1-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2800a90fba1f..207a8bb36ae5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5332,7 +5332,7 @@ static void bnxt_free_ntp_fltrs(struct bnxt *bp, bool all)
 {
 	int i;
 
-	netdev_assert_locked(bp->dev);
+	netdev_assert_locked_or_invisible(bp->dev);
 
 	/* Under netdev instance lock and all our NAPIs have been disabled.
 	 * It's safe to delete the hash table.
-- 
2.30.1


