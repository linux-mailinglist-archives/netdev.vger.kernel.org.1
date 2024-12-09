Return-Path: <netdev+bounces-150018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9839E890F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 02:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D5316524F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 01:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E64156CA;
	Mon,  9 Dec 2024 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hrceb4Md"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9D2F3B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733709326; cv=none; b=Rmz1CWl0C94Xm7CnT3TVCxDHE8agXprh8K7IPe0L6Mdm54cVK3T3qBOVH1rCBi1lhCm0QEh3n2owVlK+1C3Jw+OZdiweYnFQv9geap46DkdP8xDtaJBM8G+kJPnM4CHBP5GkT5E18aS/lkM4JftVZOnXtKbJHUT1Tf0zx6Llows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733709326; c=relaxed/simple;
	bh=cAvKHDyOy7PuthKQ07j3EXvBEqKRNayG3yrriAIFqhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R503rAZKbDVoWZknCMyXe5GEwa9h6hkYBSfp+CtoiJQVQlMBqkWTBHT4Kvr8o+mLd708FQ8bvSv+FOxP1k/qkwKaQ1HiQRxLOHmwaFe9HP5pZjn31/3ZWIiF/jSJVeoyxdkSJCTc7J1Ntq7Yq2URSznkJ1ZijmLeFUoZRerabD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hrceb4Md; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2162c0f6a39so10193465ad.0
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 17:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733709324; x=1734314124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuYjkXWcLoHR4Ox4e7f57WhVcZzf2YoyBCCTs7rM5Rk=;
        b=Hrceb4Md60CAXykhywzQjwsXgJjTqTFxvl0mVlydzMcxLJixzaxxm+zb5hwZV4LGu7
         BCOW/rFa20BalDIThwoff69Z+/K10rWoVJDJw1s/dzTLW3K4OZlUZivDq029htqDsGNA
         HGb5aaH+L0YMXKvBxX+jrtHKWdLFHDVp0FOjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733709324; x=1734314124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuYjkXWcLoHR4Ox4e7f57WhVcZzf2YoyBCCTs7rM5Rk=;
        b=Rq8vjovRzoYlEc5OiPb6/6e3vicKLS7AF/bSE48+64+VfTaTsiVMwGSONzzvKjnbcH
         IjM9Ah6Ei4yzO9d99Baih+WJyG4w7WcjXCjrf67ajT3Nx4uh/PygegOSj/6AAHFirWRO
         7KEFEru/SFucW0KM+9eexs0/I7eSkaXSMsNxYzIAA0AmcGMVotMhMJ1UvhcDUS7rrOiw
         RF0d8uVJ+kwxyi0x5MNbeoq06Vu6nquVaDyLgRQDRK9vV2fzoBlMJXOKB0iOgGt/cC8S
         S8rKX71DXLAMzP+IwFx6e2EyOLknA2nVyBL8xflZlLTrCMHXYeqKsBcYBGtgDuF6imT7
         xn0w==
X-Gm-Message-State: AOJu0Yza8YwHKjkkgMdNJP+NO8RAVvNpkFNETnoAcP4w/b9mj6WgjyvX
	+16c8b4L+jatTuESiP90aMvFhnOitR+VL6YhOXaqE+nQdAjywWlryXzBR6mtUQ==
X-Gm-Gg: ASbGncvh8xWslL9XZs7VCmTCYHvoi/S5WzLJjItVklt23EghvWny6zd2SuDr8CotM2s
	Jnsb+XpMAg9oANqAp6oCLFA1gicWREYxgPIXMyC5jt7r1Edwm8xjc79SQtffYlneV1zN/zJ3s1w
	sc47x2yC3yuEIox+bCIUy2QYgflG3PXuTVrdKM/Bh+AXgP9FbdCa7GOnytVV/A037nCvvVfqtBZ
	qM96ajJ5IODUAAMxIhbrk1Q0oQ6wkTaUHgdh6FdRwY0KYcblH00sV0NpxVQ5FNInQw87Sj1pS1n
	RIg0YTTwB5s9+Y3l/0jEA7rOcA==
X-Google-Smtp-Source: AGHT+IGKu0PznZ/f/eOIR0ELyv2KbcZlzQ3uk3Af9G9Ec1/IxTkOHNJf3gYhUk5XxWvuJoAueFpRHQ==
X-Received: by 2002:a17:903:188:b0:215:9ed9:9315 with SMTP id d9443c01a7336-215f3c56b81mr254465895ad.3.1733709324438;
        Sun, 08 Dec 2024 17:55:24 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd313f0ffbsm3565565a12.82.2024.12.08.17.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 17:55:24 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net] bnxt_en: Fix aggregation ID mask to prevent oops on 5760X chips
Date: Sun,  8 Dec 2024 17:54:48 -0800
Message-ID: <20241209015448.1937766-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 5760X (P7) chip's HW GRO/LRO interface is very similar to that of
the previous generation (5750X or P5).  However, the aggregation ID
fields in the completion structures on P7 have been redefined from
16 bits to 12 bits.  The freed up 4 bits are redefined for part of the
metadata such as the VLAN ID.  The aggregation ID mask was not modified
when adding support for P7 chips.  Including the extra 4 bits for the
aggregation ID can potentially cause the driver to store or fetch the
packet header of GRO/LRO packets in the wrong TPA buffer.  It may hit
the BUG() condition in __skb_pull() because the SKB contains no valid
packet header:

kernel BUG at include/linux/skbuff.h:2766!
Oops: invalid opcode: 0000 1 PREEMPT SMP NOPTI
CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Kdump: loaded Tainted: G           OE      6.12.0-rc2+ #7
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: Dell Inc. PowerEdge R760/0VRV9X, BIOS 1.0.1 12/27/2022
RIP: 0010:eth_type_trans+0xda/0x140
Code: 80 00 00 00 eb c1 8b 47 70 2b 47 74 48 8b 97 d0 00 00 00 83 f8 01 7e 1b 48 85 d2 74 06 66 83 3a ff 74 09 b8 00 04 00 00 eb a5 <0f> 0b b8 00 01 00 00 eb 9c 48 85 ff 74 eb 31 f6 b9 02 00 00 00 48
RSP: 0018:ff615003803fcc28 EFLAGS: 00010283
RAX: 00000000000022d2 RBX: 0000000000000003 RCX: ff2e8c25da334040
RDX: 0000000000000040 RSI: ff2e8c25c1ce8000 RDI: ff2e8c25869f9000
RBP: ff2e8c258c31c000 R08: ff2e8c25da334000 R09: 0000000000000001
R10: ff2e8c25da3342c0 R11: ff2e8c25c1ce89c0 R12: ff2e8c258e0990b0
R13: ff2e8c25bb120000 R14: ff2e8c25c1ce89c0 R15: ff2e8c25869f9000
FS:  0000000000000000(0000) GS:ff2e8c34be300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f05317e4c8 CR3: 000000108bac6006 CR4: 0000000000773ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 ? die+0x33/0x90
 ? do_trap+0xd9/0x100
 ? eth_type_trans+0xda/0x140
 ? do_error_trap+0x65/0x80
 ? eth_type_trans+0xda/0x140
 ? exc_invalid_op+0x4e/0x70
 ? eth_type_trans+0xda/0x140
 ? asm_exc_invalid_op+0x16/0x20
 ? eth_type_trans+0xda/0x140
 bnxt_tpa_end+0x10b/0x6b0 [bnxt_en]
 ? bnxt_tpa_start+0x195/0x320 [bnxt_en]
 bnxt_rx_pkt+0x902/0xd90 [bnxt_en]
 ? __bnxt_tx_int.constprop.0+0x89/0x300 [bnxt_en]
 ? kmem_cache_free+0x343/0x440
 ? __bnxt_tx_int.constprop.0+0x24f/0x300 [bnxt_en]
 __bnxt_poll_work+0x193/0x370 [bnxt_en]
 bnxt_poll_p5+0x9a/0x300 [bnxt_en]
 ? try_to_wake_up+0x209/0x670
 __napi_poll+0x29/0x1b0

Fix it by redefining the aggregation ID mask for P5_PLUS chips to be
12 bits.  This will work because the maximum aggregation ID is less
than 4096 on all P5_PLUS chips.

Fixes: 13d2d3d381ee ("bnxt_en: Add new P7 hardware interface definitions")
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index c9f1cb7e3740..7df7a2233307 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -381,7 +381,7 @@ struct rx_agg_cmp {
 	u32 rx_agg_cmp_opaque;
 	__le32 rx_agg_cmp_v;
 	#define RX_AGG_CMP_V					(1 << 0)
-	#define RX_AGG_CMP_AGG_ID				(0xffff << 16)
+	#define RX_AGG_CMP_AGG_ID				(0x0fff << 16)
 	 #define RX_AGG_CMP_AGG_ID_SHIFT			 16
 	__le32 rx_agg_cmp_unused;
 };
@@ -419,7 +419,7 @@ struct rx_tpa_start_cmp {
 	 #define RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT	 7
 	#define RX_TPA_START_CMP_AGG_ID				(0x7f << 25)
 	 #define RX_TPA_START_CMP_AGG_ID_SHIFT			 25
-	#define RX_TPA_START_CMP_AGG_ID_P5			(0xffff << 16)
+	#define RX_TPA_START_CMP_AGG_ID_P5			(0x0fff << 16)
 	 #define RX_TPA_START_CMP_AGG_ID_SHIFT_P5		 16
 	#define RX_TPA_START_CMP_METADATA1			(0xf << 28)
 	 #define RX_TPA_START_CMP_METADATA1_SHIFT		 28
@@ -543,7 +543,7 @@ struct rx_tpa_end_cmp {
 	 #define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT		 16
 	#define RX_TPA_END_CMP_AGG_ID				(0x7f << 25)
 	 #define RX_TPA_END_CMP_AGG_ID_SHIFT			 25
-	#define RX_TPA_END_CMP_AGG_ID_P5			(0xffff << 16)
+	#define RX_TPA_END_CMP_AGG_ID_P5			(0x0fff << 16)
 	 #define RX_TPA_END_CMP_AGG_ID_SHIFT_P5			 16
 
 	__le32 rx_tpa_end_cmp_tsdelta;
-- 
2.30.1


