Return-Path: <netdev+bounces-231278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F2BF6EF4
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FCF188F936
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EEE2877C3;
	Tue, 21 Oct 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIDvNYxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC937FC1D
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055173; cv=none; b=EZc2XRxDNhkvW6Bj6WCR2MHHOkSg00r4C1yLM888xIcEPz+T4qrp3zuOXjyhXCcI+D3hho5T3SJEum/jos2TDyanwLp5B9TqZdjXknmn1fUGAZwyZMY+rxoY2UakmfLo8MgPe51i9yyOBCK1nyL5TGr3LUE2C03f5drw7KfYbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055173; c=relaxed/simple;
	bh=3XhhH4/jyMpPT4oeTmLnPHmQsgC4Kd2ny5xmSbeV8ps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=drWqa9eq241fJH3ua93VtPV4V8V2qraqJJ7zsdhQwTuXLv4gW/oWxbB/YE1RYheHBgA6K3E60X9KnX4CQanBSBTMDYNFJv5KelX5ap8WfeUM6KZhZf0eab1jm74GAq/bqVHZtdF/obw7xeOH5/Qlhk0U5I9a3YXAAA4hOB4nWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIDvNYxZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so3542439a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761055171; x=1761659971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcpAYRHMkS8n+FuMohyJKKkGBJjWuaNLlbwPCUXcR5g=;
        b=eIDvNYxZi9y6jw5OSAsuFTGz0JAXo5TsPohAwQK98Wg5n3bmDtkCUqfZhfi2jcz9sv
         1bS7RJ4vAliTnmpV9OUGNPYXOaIAwydiclNPipljwyohjGNfvK21VWmsTJmxLc8Karma
         GgElsQi8XNxywALfVTCrXcxrq4HlnHCgnEwx0VMcviZkVR9d3l8+B/NMi9uX1iOemlm3
         hyaTb1wGo8HK5/fN5ToWReBpnNoFq8JxwSrXnq08Z+70BfP+U9l3VbiTfMiXNhq1xEBb
         Pv8pBEZWgLtiPiIORMgOPSf4jIAFQlI0rQ/3ItjUHCaIyEaArllAzFQ4n+N5VnFWgv/N
         ha+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055171; x=1761659971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcpAYRHMkS8n+FuMohyJKKkGBJjWuaNLlbwPCUXcR5g=;
        b=C8z3VvERFTNZD6lK/rHpHnI47OwNoyaT1rx6hFA+/pPMeS6jzBVX7+HNf1m2OVW3bN
         Eninb/2AcmCiILZry2fQWzuAA+0xPQOuUQzIe9n4XemP179Bn2FrXBHQnc6e75abXm7f
         MYmut0gDVsuiJ+5ovGszfFkwlYFi01T8niFXRxsyZBQy1uvWMFaPnK++iDgkwZp31goh
         DSaKCb2PHn98Bwnj9rzr/0E+2gxG72jt9+02hsqNkq0Xtx0WDf1KOQ4sqZJkiAkKhesR
         nne2kkOk4V2LTkUHEOe6IVXtGtgE4dTTHP59Trp9d852b8ItNG1K+waoA6U31zbJ5guh
         5lIA==
X-Gm-Message-State: AOJu0YxaD5aKZbQP1v//3WPYYDaNTSlCuN6w36HxZuOJ7NEgAYcqGz7M
	GjPLgFTj0Tjm5EnQcpsktzx2NipRj0UszKx/6dPzZ/+XvS3Yg4aLV7pYAoZBsb36sNI=
X-Gm-Gg: ASbGncukQS6CtxXyOuUjy3TR9lVbJyhcHCKDO7oL/Cfnn339r/eC04DCuu3Kd40/U/S
	BlGX1ttyXiByvCWcdNo6kN2byXZaDnKp8l9Yd1CeY7GFvLSbswYRwH5m29WiheKmA8YMeiUhTKf
	35rJOvmOBplmQ4A+O9jHD+mENyBk6fGVq46DtrT8+66Pqr2upwVTMwnWbosVGXQ3r6HRtx4n6ZL
	CVXZbIrlf7CKvbYfB3BIlNqvaaoKpajHfrYfGj6ZvSsB+2blNf9nyw07q3bw4EmCtMVo1rI9szQ
	evG4vZsQXrRJbt8C36Zbu7neRmGL8UOBoGlC9wUP7ssv7iLLG40FzgNMGJExlhZmojcexZq340i
	HwJjLcSu6+UlDxUaLDwICJIyVxlPvHbie8ASI/HI4qgkejxv6Ec/Mz2mffNPgCLprRcQdqdObQr
	HU11Vk4iSXqjo3nA==
X-Google-Smtp-Source: AGHT+IGHiXh97Xz8tV9HCK26wV+oleZR3TH7RUU2ZoZsfglQmsumeCvjC+HaVLEbCITVaEaACJVPYA==
X-Received: by 2002:a17:902:fc4b:b0:290:8d7b:4047 with SMTP id d9443c01a7336-290c9cbc4c9mr196770065ad.21.1761055170754;
        Tue, 21 Oct 2025 06:59:30 -0700 (PDT)
Received: from 192.168.1.4 ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec14e9sm111463525ad.9.2025.10.21.06.59.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Oct 2025 06:59:30 -0700 (PDT)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net] i40e: xsk: advance next_to_clean on status descriptors
Date: Tue, 21 Oct 2025 20:59:13 +0700
Message-Id: <20251021135913.5253-1-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever a status descriptor is received, i40e processes and skips over
it, correctly updating next_to_process but forgetting to update
next_to_clean. In the next iteration this accidentally causes the
creation of an invalid multi-buffer xdp_buff where the first fragment
is the status descriptor.

If then a skb is constructed from such an invalid buffer - because the
eBPF program returns XDP_PASS - a panic occurs:

[ 5866.367317] BUG: unable to handle page fault for address: ffd31c37eab1c980
[ 5866.375050] #PF: supervisor read access in kernel mode
[ 5866.380825] #PF: error_code(0x0000) - not-present page
[ 5866.386602] PGD 0
[ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI
[ 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted 6.17.0-custom #1 PREEMPT(voluntary)
[ 5866.403740] Hardware name: Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025
[ 5866.412339] RIP: 0010:memcpy+0x8/0x10
[ 5866.416454] Code: cc cc 90 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[ 5866.437538] RSP: 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286
[ 5866.443415] RAX: ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1
[ 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI: ff2dd26dbd8f0000
[ 5866.459454] RBP: ff428d9ec0bb0d40 R08: 0000000000000000 R09: 0000000000000000
[ 5866.467470] R10: 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8
[ 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15: ff2dd26548548b80
[ 5866.483509] FS:  0000000000000000(0000) GS:ff2dd2c363592000(0000) knlGS:0000000000000000
[ 5866.492600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5866.499060] CR2: ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0
[ 5866.507079] PKRU: 55555554
[ 5866.510125] Call Trace:
[ 5866.512867]  <IRQ>
[ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e]
[ 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e]
[ 5866.526022]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.531408]  ? raise_softirq+0x24/0x70
[ 5866.535623]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800
[ 5866.551493]  __napi_poll+0x30/0x230
[ 5866.555423]  net_rx_action+0x20b/0x3f0
[ 5866.559643]  handle_softirqs+0xe4/0x340
[ 5866.563962]  __irq_exit_rcu+0x10e/0x130
[ 5866.568283]  irq_exit_rcu+0xe/0x20
[ 5866.572110]  common_interrupt+0xb6/0xe0
[ 5866.576425]  </IRQ>
[ 5866.578791]  <TASK>

Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..02f0bc2dbbf6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -441,13 +441,17 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		dma_rmb();
 
 		if (i40e_rx_is_programming_status(qword)) {
+			u16 ntp = next_to_process++;
+
 			i40e_clean_programming_status(rx_ring,
 						      rx_desc->raw.qword[0],
 						      qword);
 			bi = *i40e_rx_bi(rx_ring, next_to_process);
 			xsk_buff_free(bi);
-			if (++next_to_process == count)
+			if (next_to_process == count)
 				next_to_process = 0;
+			if (next_to_clean == ntp)
+				next_to_clean = next_to_process;
 			continue;
 		}
 

base-commit: 49d34f3dd8519581030547eb7543a62f9ab5fa08
-- 
2.43.0


