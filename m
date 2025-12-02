Return-Path: <netdev+bounces-243140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7D5C99EC3
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 03:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C793A502B
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A966244685;
	Tue,  2 Dec 2025 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8oxVEEw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B718A6DB
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764644070; cv=none; b=pDyoGaFS1yoOi4gVYCb2thrif6iarnZ2nHL7/tp6Y3zvF8ViTv3H7fgEHlHmn4usHQ9MqVEItOh7j+gOGcVv1dwYxWlyyh7dNCSBhXyRk4lComkuwgwyvH2psJxbemYnxplXmKufM7E2goq8xN9L9sVmIN3+sp9wkytIgv9hqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764644070; c=relaxed/simple;
	bh=SjsHcrcR84GXyUGn6wceuAOJ+tCgCTDc0Nyf9HRtDx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0R9dJqm5nFC15EnIjy+IN1BIb549Bf2Eo1/CZ1r2YtethDf1o7yxTI9bm5jzHU0fUeO2g67n4LXy3euvCpAkwoUbdLkfI4hdgsxNORmVt4MOrmyZVSITRANvjk6qTCbzqQU3Z7wc8o0fjm/XCIOqkHxdj+qzfeEod+IjdKjWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8oxVEEw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4edf1be4434so33037811cf.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 18:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764644067; x=1765248867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3FBb66LhC69xzR90g1eNdryay2txh0Eg4xYtWgJK8o=;
        b=e8oxVEEwWI5aKluYLjZW5LSCb0D+5qunTiiP4N//ZbCnzMVR10bP5h1LD4986AfyhU
         8t0VBXsSTKgFNEYxzov72MzF06FJ3nZXdZ1s5VvFWOjIfRJY5DaRjjbwaawSJ/Kbog69
         jlj8Y2yVKMMEXg6yjyemBtcmXpz7cErlhRFi1+f+9VvXotCNU9+xYj5vkk9VMAXU2vE+
         Lh08u0acyXKeQZNtg25slQZR0AQ4ctcHEYtzejRdQErDRPj9mrugTK8Fdgh4N9QT2OwH
         ihaIxsFOcVyb55CHPWIVYdmVWWNoo2bKKLpkkNVETDDoJTExAsuLG21NLf9vauvG0RsD
         wF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764644067; x=1765248867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3FBb66LhC69xzR90g1eNdryay2txh0Eg4xYtWgJK8o=;
        b=XJofDxUhstotUMlsNsr8mASKyE2swVXNq9uXQJw7wdRhiZFnaXZG4M4vV8Hmdt53f0
         EeSiXSCaAgMFNqojiyI3dKNpxBuZaReX/ufFH+QFHxaXlMmJL80qvRE3KXDRBR17lgwK
         OJsKi/Pykciq+b7FBtmr0fyhv1QA8xQhY+/BZiE1E/M8eWnupWuYYH/aY0Vgq3XpKn4t
         eaI9bVBnoTL4FUv6Tt9MrUhFbnzx+oOwUPiGVUlnMNEnxgbpzqnXv8fFY8yGMwQPDRj6
         SD3oP56DkeG/X40jE0ehG4uhf5spXg79R+YdgkYf1me831TXf0L6MMKxIcg9qWoc7Zzs
         oBuQ==
X-Gm-Message-State: AOJu0YwWWDj/z/APd2KNIKTgF+2WpmSMq/4+qMwU60LqB64bDr8hMFZ1
	1GdKSXt4SgJBP6zmAPgzUo3oDGytVqNWscJller9T9SRL89YbS/B7sxp+bm9z2m2
X-Gm-Gg: ASbGncu4FQLsL/8feCwIeZFFIzp4J4/1Iu4zgh02mzJba/AIijsMe60csFUkQ2+C55+
	9hn63ETi1nSh3cM0NNGz9pmXgYhXZ53MsePp9scS6O+3tQSwWhU+KqS/hTsrzQ9wXyiUYfHeNVr
	LdCs5Z6N8Uwn+n3ci1pB6qjEHxl8a8GDs68+MoJoY6RfFm73Fq/uk/fpHZrhpXts9MGh8Cpu6Ce
	ZzaFaMCYNdskg0rxM7y/2yP9YrsM+kGDU8iQc68k9gYnvXlSRh2+EymMH22J8WLbuTPvU4ZlPxb
	FPW3+Pc9C1OE4TH3pu1bpKimmiLI86lm/y0YsKHSrMchQf+qKFVE1eruvqXJmDeNM86ddfvFFXs
	6POTjE9524H3xTPypen+3BOktVsMFwvTIrZGTgs3J0TdUzMBlyXyGqr6PFoYQsfJxwElDNGC14D
	n6saAcGnyj7ZE+pNZT0VyLHEaCd/DXIcDklzIZXrqL7hiUc+abr1/Dd5R2oWFZh6Ljok923spe/
	RM=
X-Google-Smtp-Source: AGHT+IF1Y26tarkgHugZ4zAMvf/99cbk/6HuQ3PbtQTRf5s5WQrWhUrkganAuIBkyYpvOL7fPVmVdQ==
X-Received: by 2002:a05:622a:295:b0:4ed:b448:b19f with SMTP id d75a77b69052e-4efbdad012amr355218281cf.51.1764644067186;
        Mon, 01 Dec 2025 18:54:27 -0800 (PST)
Received: from localhost.localdomain (h69-131-24-92.cntcnh.broadband.dynamic.tds.net. [69.131.24.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd344a188sm88508641cf.33.2025.12.01.18.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:54:26 -0800 (PST)
From: Jie Zhang <jzhang918@gmail.com>
X-Google-Original-From: Jie Zhang <jie.zhang@analog.com>
To: netdev@vger.kernel.org
Cc: Jie Zhang <jzhang918@gmail.com>,
	Jie Zhang <jie.zhang@analog.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: fix oops when split header is enabled
Date: Mon,  1 Dec 2025 21:54:16 -0500
Message-ID: <20251202025421.4560-1-jie.zhang@analog.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For GMAC4, when split header is enabled, in some rare cases, the
hardware does not fill buf2 of the first descriptor with payload.
Thus we cannot assume buf2 is always fully filled if it is not
the last descriptor. Otherwise, the length of buf2 of the second
descriptor will be calculated wrong and cause an oops:

Unable to handle kernel paging request at virtual address ffff00019246bfc0
Mem abort info:
  ESR = 0x0000000096000145
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000145, ISS2 = 0x00000000
  CM = 1, WnR = 1, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000090d8b000
[ffff00019246bfc0] pgd=180000009dfff403, p4d=180000009dfff403, pud=0000000000000000
Internal error: Oops: 0000000096000145 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 157 Comm: iperf3 Not tainted 6.18.0-rc6 #1 PREEMPT
Hardware name: ADI 64-bit SC598 SOM EZ Kit (DT)
pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dcache_inval_poc+0x28/0x58
lr : arch_sync_dma_for_cpu+0x28/0x34
sp : ffff800080dcbc40
x29: ffff800080dcbc40 x28: 0000000000000008 x27: ffff000091c50980
x26: ffff000091c50980 x25: 0000000000000000 x24: ffff000092a5fb00
x23: ffff000092768f28 x22: 000000009246c000 x21: 0000000000000002
x20: 00000000ffffffdc x19: ffff000091844c10 x18: 0000000000000000
x17: ffff80001d308000 x16: ffff800080dc8000 x15: ffff0000929fb034
x14: 70f709157374dd21 x13: ffff000092812ec0 x12: 0000000000000000
x11: 000000000000dd86 x10: 0000000000000040 x9 : 0000000000000600
x8 : ffff000092a5fbac x7 : 0000000000000001 x6 : 0000000000004240
x5 : 000000009246c000 x4 : ffff000091844c10 x3 : 000000000000003f
x2 : 0000000000000040 x1 : ffff00019246bfc0 x0 : ffff00009246c000
Call trace:
 dcache_inval_poc+0x28/0x58 (P)
 dma_direct_sync_single_for_cpu+0x38/0x6c
 __dma_sync_single_for_cpu+0x34/0x6c
 stmmac_napi_poll_rx+0x8f0/0xb60
 __napi_poll.constprop.0+0x30/0x144
 net_rx_action+0x160/0x274
 handle_softirqs+0x1b8/0x1fc
 __do_softirq+0x10/0x18
 ____do_softirq+0xc/0x14
 call_on_irq_stack+0x30/0x48
 do_softirq_own_stack+0x18/0x20
 __irq_exit_rcu+0x64/0xe8
 irq_exit_rcu+0xc/0x14
 el1_interrupt+0x3c/0x58
 el1h_64_irq_handler+0x14/0x1c
 el1h_64_irq+0x6c/0x70
 __arch_copy_to_user+0xbc/0x240 (P)
 simple_copy_to_iter+0x28/0x30
 __skb_datagram_iter+0x1bc/0x268
 skb_copy_datagram_iter+0x1c/0x24
 tcp_recvmsg_locked+0x3ec/0x778
 tcp_recvmsg+0x10c/0x194
 inet_recvmsg+0x64/0xa0
 sock_recvmsg_nosec+0x1c/0x24
 sock_read_iter+0x8c/0xdc
 vfs_read+0x144/0x1a0
 ksys_read+0x74/0xdc
 __arm64_sys_read+0x14/0x1c
 invoke_syscall+0x60/0xe4
 el0_svc_common.constprop.0+0xb0/0xcc
 do_el0_svc+0x18/0x20
 el0_svc+0x80/0xc8
 el0t_64_sync_handler+0x58/0x134
 el0t_64_sync+0x170/0x174
Code: d1000443 ea03003f 8a230021 54000040 (d50b7e21)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception in interrupt
Kernel Offset: disabled
CPU features: 0x080000,00008000,08006281,0400520b
Memory Limit: none
---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

To fix this, the PL bit-field in RDES3 register is used for all
descriptors, whether it is the last descriptor or not.

Signed-off-by: Jie Zhang <jie.zhang@analog.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b90ecd3a55e..848b1769c573 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4878,13 +4878,27 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 	if (!priv->sph)
 		return 0;
 
-	/* Not last descriptor */
-	if (status & rx_not_ls)
+	/* For GMAC4, when split header is enabled, in some rare cases, the
+	 * hardware does not fill buf2 of the first descriptor with payload.
+	 * Thus we cannot assume buf2 is always fully filled if it is not
+	 * the last descriptor. Otherwise, the length of buf2 of the second
+	 * descriptor will be calculated wrong and cause an oops.
+	 *
+	 * If this is the last descriptor, 'plen' is the length of the
+	 * received packet that was transferred to system memory.
+	 * Otherwise, it is the accumulated number of bytes that have been
+	 * transferred for the current packet.
+	 *
+	 * Thus 'plen - len' always gives the correct length of buf2.
+	 */
+
+	/* Not GMAC4 and not last descriptor */
+	if (!priv->plat->has_gmac4 && (status & rx_not_ls))
 		return priv->dma_conf.dma_buf_sz;
 
+	/* GMAC4 or last descriptor */
 	plen = stmmac_get_rx_frame_len(priv, p, coe);
 
-	/* Last descriptor */
 	return plen - len;
 }
 
-- 
2.47.3


