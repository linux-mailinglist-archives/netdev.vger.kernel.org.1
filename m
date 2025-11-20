Return-Path: <netdev+bounces-240381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01469C740E4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 017D62BEC6
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26CF337BAC;
	Thu, 20 Nov 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3i59l/r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE0337B96
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643387; cv=none; b=p7U4KL1AMASH/vcSJHgagpuouEkYll3DoCPMG6TQzXJAh8fP72mL02Ued5j5a5PqCYjOF6r/aYBb+zcdnj92xHdKMXPXnz/Voc/Whay/XBF3FY9EagrZCowkijL+FY4edjOO0hYBQLDwKV5qdFae/YnzrgQuMQa9I2+wIZPwowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643387; c=relaxed/simple;
	bh=pGZrNRY0M4sDQsxJo1THaYnZteKnSAPL17HRBh+c/RE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ULfa1ij2uQ6KtrKRpNyME6nKCJMGPVlvwzBeJ2jmPokkBRnLQNje7gntGdBttsYzkgLxuC9qwTYVlSXP9l4yv73Jul+PCo489pkIt9uW90LQeTqkj0FVy5J4aghPDLoGPt1uBszvXRBxz3y6ecaVpI6kCvBuBf6trT6c8w2xknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3i59l/r; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so713238b3a.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763643385; x=1764248185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlgtCRNk8JjCTXwMmpQaIRJDDDuMEDSfzE9Xaxa/a9c=;
        b=j3i59l/r5193PjV+bZKwdeOdKa1ty67yukWBwbAk9uFnjtNBhqbNepip2p6GADlbko
         fg8Bi0pSfNIJ7uteCZlFVMV8IPYI3npvSglL+gdbJGDRrK3CBZj4ZWTU8CebVdlu6c1I
         dFoAqkGxur7Eu8RIVTRUjclfK+vryJPLN8sS8STbiPtBNs9ObE6+r9TaDo0U2nu7sVxE
         Tk1tPepvBUjDD2JMqUPbOZp3JRrpPNiNxFJ0L4fHmJR/rtpBEizk08rVJAc8+HD08fH5
         yghrDY4XFhyWb/QDd8StA6uojKnGmEadtrBuWXhtG3i3gIlIjnNVlPERM/b7JtjL9zKR
         BOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763643385; x=1764248185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlgtCRNk8JjCTXwMmpQaIRJDDDuMEDSfzE9Xaxa/a9c=;
        b=W/Z2qPbenNlBZcMkYZ/OUaZoeyS5mZ1gAAl7J+l1RrIXEl//vGhDBACZMqLHGoS6LZ
         o9DZf4lAafpQ19i/txg9KFBMN2GxXcb5SLoMpxwEkwozz0tZADfYFQN5+K+5M58yGsym
         8nFPIT4FWhhPogsGfvhtXxmqu6KkLWU6VaWTdUo4EWBUQXyfUseHAksBiKn7eXkZ6f4d
         fl1EBMclKfN+oFZIH7CaBMzy1JGeLoo/lHOjOLUhsBFMLj/sdaXMFd1RDXu9RdJNA8c0
         8WvaTTkx33Ad18QC2JkMNWfjE27I7SyrTG9aKsDESpIFQbGjIrLbr4Ud3BwuPB3IPy9x
         JJFQ==
X-Gm-Message-State: AOJu0YxdfzBtXFl9agmDVAGdOimMyVNgfU+NmuSApT1YNSuVEWhZB0ri
	uypu+OKTYBTEnm2tpvGzAYmvYPypurPTXpK8tydXgn3XBRFXNJcuitXV8rIUtt7KkGpG3A==
X-Gm-Gg: ASbGncuKkfYizawIwJZnNioNxQFiGXYrYTO+jK16ERbZqz3dPI1u0hEZ4LbUzkE0ojr
	8iBqyI9WzdFzFkyMxsOOfIcEidkji5uuyl+2AHxCtwdmm7efo94mgEJkC2WU5arODiQuK1ChWnf
	V/h6UrYxS/WqlgSdD6IQvPU0xM7P51k0BhIrpDTE4jk7JMpj9luoiCQedxD+hBD/aHTYqEEg51n
	FV4sk3x+/YD/IDh/O2iO/qw8fW1ZdjQC1WqB2YEdL1rpzLzDGY/T9SFCvHoWX7bYZEz75A+LqPI
	Xq1jhSZpKMzqrVVjqJh9/t5npQbku1OMpqsBd0OswGVdczViw7NhpyMzFeh6m+LCOrwgoe/8Cw6
	grYO8i2UiQZ9AbOAgAOJC21f2UVfxu4SXKO9BxWTx7WcyVbtPRgFVeSSpXQi9+HBXuHziHjCg2Q
	ZonaHzA2tbmrhakzvfofivtHnOx0NlBcdRbSM=
X-Google-Smtp-Source: AGHT+IH6Cxx9ekQROMt6D3RdsjVLzu9EK7/tuG1Oc7Wl7EP8mwN1jNlypi4fx566Z3g1GdSw5Sbymw==
X-Received: by 2002:a05:6a00:3ccc:b0:7ac:acc:1da with SMTP id d2e1a72fcca58-7c3f0d55b66mr3684237b3a.25.1763643385042;
        Thu, 20 Nov 2025 04:56:25 -0800 (PST)
Received: from gmail.com ([183.56.183.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174e5b0sm2745771b3a.67.2025.11.20.04.56.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Nov 2025 04:56:24 -0800 (PST)
From: jiefeng.z.zhang@gmail.com
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	irusskikh@marvell.com,
	Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
Subject: [PATCH net v2] net: atlantic: fix fragment overflow handling in RX path
Date: Thu, 20 Nov 2025 20:56:13 +0800
Message-Id: <20251120125613.35776-1-jiefeng.z.zhang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>

The atlantic driver can receive packets with more than MAX_SKB_FRAGS (17)
fragments when handling large multi-descriptor packets. This causes an
out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic.

The issue occurs because the driver doesn't check the total number of
fragments before calling skb_add_rx_frag(). When a packet requires more
than MAX_SKB_FRAGS fragments, the fragment index exceeds the array bounds.

Fix by adding a check in __aq_ring_rx_clean() to skip extracting
the zeroth fragment when frag_cnt reaches MAX_SKB_FRAGS.

This crash occurred in production with an Aquantia AQC113 10G NIC.

Stack trace from production environment:
```
RIP: 0010:skb_add_rx_frag_netmem+0x29/0xd0
Code: 90 f3 0f 1e fa 0f 1f 44 00 00 48 89 f8 41 89
ca 48 89 d7 48 63 ce 8b 90 c0 00 00 00 48 c1 e1 04 48 01 ca 48 03 90
c8 00 00 00 <48> 89 7a 30 44 89 52 3c 44 89 42 38 40 f6 c7 01 75 74 48
89 fa 83
RSP: 0018:ffffa9bec02a8d50 EFLAGS: 00010287
RAX: ffff925b22e80a00 RBX: ffff925ad38d2700 RCX:
fffffffe0a0c8000
RDX: ffff9258ea95bac0 RSI: ffff925ae0a0c800 RDI:
0000000000037a40
RBP: 0000000000000024 R08: 0000000000000000 R09:
0000000000000021
R10: 0000000000000848 R11: 0000000000000000 R12:
ffffa9bec02a8e24
R13: ffff925ad8615570 R14: 0000000000000000 R15:
ffff925b22e80a00
FS: 0000000000000000(0000)
GS:ffff925e47880000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9258ea95baf0 CR3: 0000000166022004 CR4:
0000000000f72ef0
PKRU: 55555554
Call Trace:
<IRQ>
aq_ring_rx_clean+0x175/0xe60 [atlantic]
? aq_ring_rx_clean+0x14d/0xe60 [atlantic]
? aq_ring_tx_clean+0xdf/0x190 [atlantic]
? kmem_cache_free+0x348/0x450
? aq_vec_poll+0x81/0x1d0 [atlantic]
? __napi_poll+0x28/0x1c0
? net_rx_action+0x337/0x420
```

Changes in v2:
- Fix fragment overflow by skipping zeroth fragment extraction when
  frag_cnt reaches MAX_SKB_FRAGS.

Signed-off-by: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index f21de0c21e52..2c3cfceefd28 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -538,6 +538,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 		bool is_ptp_ring = aq_ptp_ring(self->aq_nic, self);
 		struct aq_ring_buff_s *buff_ = NULL;
 		struct sk_buff *skb = NULL;
+		unsigned int frag_cnt = 0U;
 		unsigned int next_ = 0U;
 		unsigned int i = 0U;
 		u16 hdr_len;
@@ -546,7 +547,6 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 			continue;
 
 		if (!buff->is_eop) {
-			unsigned int frag_cnt = 0U;
 			buff_ = buff;
 			do {
 				bool is_rsc_completed = true;
@@ -631,7 +631,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 		memcpy(__skb_put(skb, hdr_len), aq_buf_vaddr(&buff->rxdata),
 		       ALIGN(hdr_len, sizeof(long)));
 
-		if (buff->len - hdr_len > 0) {
+		if (buff->len - hdr_len > 0 && frag_cnt < MAX_SKB_FRAGS) {
 			skb_add_rx_frag(skb, i++, buff->rxdata.page,
 					buff->rxdata.pg_off + hdr_len,
 					buff->len - hdr_len,
-- 
2.39.5


