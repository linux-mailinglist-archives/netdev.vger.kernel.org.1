Return-Path: <netdev+bounces-169717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B707A45578
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D731B17B26B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BECE267F5A;
	Wed, 26 Feb 2025 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2R2qKU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96801269838
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550745; cv=none; b=sdPEJva9KCTZf0hxdipc/90ZfhhMqQSImG9qofVBldU48t976GEC2mlVYGluokN19QZJliMu2vuyYDsvkvWzRC92bxVuCfCNY8MUsKyp4Ni3fL/3vVdY/CUOdSLGu+NjuCuw2PQ35d1vbSxqYilu+qcVxhQWsi4BpbQN8g/gTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550745; c=relaxed/simple;
	bh=yqIFQx2el2FIURYStm/i2d86KzmDGq+yYRjCkRqwGqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfTrGMAwdeZ1i89zj0dlG7UcSX24McP946epDH+jdqJ7yuuO6c1zL863LuWOfGXaxBR8R/n6fY4gTsVtB9BKJAiJ8iKlbMQ+Y6W3RVaj8ggTHDatpZ/Dv/E0QseGmAFLk9eGIdH/9K0ajJbSg9e7O2Hg6lN6pZvGG08bdBOzQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2R2qKU+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-219f8263ae0so137031445ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740550743; x=1741155543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI20Ufd1kjixh0WEHrG7aZ6R3l4igdmBMtgNg2/GwgA=;
        b=b2R2qKU+j070BgViWhI5/alVj1W5WSkOPsefOXERYdeNJdjVAPrSmrN9Kap00Rt0O0
         YBVi0Bd11Ngpq3JyGLBMB3qI6mlayU7jNDUV+85QMB45UlburydTWo98mEsFOYmRoxd3
         xNB09PqQuksuxP4JzBXagID3uyhKApezg9EZ1g8PUHIC3TwK7VJgW5ZD+WD4Toszlroe
         8z9Io3LBfZsC97lzC6wXQiJf+Eg/BWnXK7ZcSIOtV5Qa8RHrGJaM/05nX0q3zcoK4Q1t
         FXONvy75wgl6MkmE1QDyJ+GnGh9iRKLuafNtJOl1lVbfMemhETZK1A8NBw7e/BLWJuQD
         n2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550743; x=1741155543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI20Ufd1kjixh0WEHrG7aZ6R3l4igdmBMtgNg2/GwgA=;
        b=nPjsoJ924gF+RCR461fL1UXTziX4+9rN2dmkPVZ337FTb7G8fUdZ4+uja1ThL383rW
         2RX3NvRX5AF3a7bIlM32Gur5bUVTE70zUhqUZTA5fajyzaiqUvS4OnUmgJqEbz4/Cz4A
         GCfBCOIIe8RcAxKvA4GUKQyXUanT0QCJ21UQCoact3DUmvgp2MyozGLT5/WNCkTYkjMF
         z4iVHEookHQC8h3DjBz/vn98IylUtG3LUb2ZiOkaHNEMRS9zaniaLY2bovhZ4OvoAumT
         tfbnNprnRurRSti/vY1NFVUO1lzNiyQb9ZEaXNYsl8SBvgsEkr7JMX3guU7AsPPKHbWS
         RQbA==
X-Forwarded-Encrypted: i=1; AJvYcCVy5Y5+k5G/PaME6e3m2+nI2D8ASsYmzxMP70CW0nE0fRDCXn15QL7m4hN/tXq53EhNtSqV6VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBRjmuFeJ8oWgN14SEes09/Rn8cqoVsmAlFQIDxmFGHRDK/SX
	t8XVGZB5kqwPajLZAtpu0arAZqcmhs3DlzVAnqhX3eCxbyr8TkXk
X-Gm-Gg: ASbGncvVKXPQ3D/OpRrd8nj0XIzqY1567BdN993fhRA19iYlslXxXTZhZzuX8OXB04d
	enSi4Ty6FSwRP9IQHe/SoDAWnRNvwZKjcYXmmO3W7AvYgrYCwysE87rKIhtxd0TRPCMCQ91HUF2
	AH/RIQPJ/wTQS6QEoLaFkaySRvZ3gSZQ/NvFh9Ukz8p5luHDKVq/GaxT3n436MZtMrD31rA9BW6
	k4NGI62739xGk0e19I5hQs/bHYGEZa/AN3Sm3oPtV9t54FiM5s+Dxy+X2KXjsI5DXXt+56zS/7Z
	URH16H+/8yn5OSw=
X-Google-Smtp-Source: AGHT+IEGulbnCJBROWprGEwW5brE7y9PRNgHqSL0QS/MLcfNT1YWgCNAABG+EzVwO1xR6uenoI9j6A==
X-Received: by 2002:a17:902:d485:b0:21f:6dca:6932 with SMTP id d9443c01a7336-221a11b9122mr335270405ad.43.1740550742749;
        Tue, 25 Feb 2025 22:19:02 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a61fcsm24575535ad.191.2025.02.25.22.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:19:01 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	horms@kernel.org,
	ap420073@gmail.com
Subject: [PATCH net 2/3] eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
Date: Wed, 26 Feb 2025 06:18:36 +0000
Message-Id: <20250226061837.1435731-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226061837.1435731-1-ap420073@gmail.com>
References: <20250226061837.1435731-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bnxt_queue_mem_alloc() is called to allocate new queue memory when
a queue is restarted.
It internally accesses rx buffer descriptor corresponding to the index.
The rx buffer descriptor is allocated and set when the interface is up
and it's freed when the interface is down.
So, if queue is restarted if interface is down, kernel panic occurs.

Splat looks like:
 BUG: unable to handle page fault for address: 000000000000b240
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 3 UID: 0 PID: 1563 Comm: ncdevmem2 Not tainted 6.14.0-rc2+ #9 844ddba6e7c459cafd0bf4db9a3198e
 Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
 RIP: 0010:bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en]
 Code: 41 54 4d 89 c4 4d 69 c0 c0 05 00 00 55 48 89 f5 53 48 89 fb 4c 8d b5 40 05 00 00 48 83 ec 15
 RSP: 0018:ffff9dcc83fef9e8 EFLAGS: 00010202
 RAX: ffffffffc0457720 RBX: ffff934ed8d40000 RCX: 0000000000000000
 RDX: 000000000000001f RSI: ffff934ea508f800 RDI: ffff934ea508f808
 RBP: ffff934ea508f800 R08: 000000000000b240 R09: ffff934e84f4b000
 R10: ffff9dcc83fefa30 R11: ffff934e84f4b000 R12: 000000000000001f
 R13: ffff934ed8d40ac0 R14: ffff934ea508fd40 R15: ffff934e84f4b000
 FS:  00007fa73888c740(0000) GS:ffff93559f780000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000b240 CR3: 0000000145a2e000 CR4: 00000000007506f0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die+0x20/0x70
  ? page_fault_oops+0x15a/0x460
  ? exc_page_fault+0x6e/0x180
  ? asm_exc_page_fault+0x22/0x30
  ? __pfx_bnxt_queue_mem_alloc+0x10/0x10 [bnxt_en 7f85e76f4d724ba07471d7e39d9e773aea6597b7]
  ? bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en 7f85e76f4d724ba07471d7e39d9e773aea6597b7]
  netdev_rx_queue_restart+0xc5/0x240
  net_devmem_bind_dmabuf_to_queue+0xf8/0x200
  netdev_nl_bind_rx_doit+0x3a7/0x450
  genl_family_rcv_msg_doit+0xd9/0x130
  genl_rcv_msg+0x184/0x2b0
  ? __pfx_netdev_nl_bind_rx_doit+0x10/0x10
  ? __pfx_genl_rcv_msg+0x10/0x10
  netlink_rcv_skb+0x54/0x100
  genl_rcv+0x24/0x40
...

Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b8b5b39c7bb..1f7042248ccc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15439,6 +15439,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_ring_struct *ring;
 	int rc;
 
+	if (!bp->rx_ring)
+		return -ENETDOWN;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
-- 
2.34.1


