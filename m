Return-Path: <netdev+bounces-109119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C29270CB
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA1B20A1C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1EF174EC0;
	Thu,  4 Jul 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI+ZhLk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C9145B21
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078926; cv=none; b=Zd1fPpiAhOipknR/2pKvmBoMKKaCRbwWsNvHseSV9h/zeF+yELbHrqrn5tuI9H0YwEOGkkRSkjMdos52raNTjkMCzPBsUONAvLDTHW4ZjYQcJDEi+w1evERHTcKVYikZghXhnUy7PmRGFUY3mvrgYgp6qfyZgZZiEZVNJ4Ropvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078926; c=relaxed/simple;
	bh=jhhzDuCRR8UZF2C9XolZ10dTqpNVUBwGK6oeReLNTMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XPRttBkPImg6hcnwPTmI0BTSyMhZ1h6DreP3JKpf/IgjmfYI6pNN+ITP5O/yknZzAFsXHc0oMrT6XEXRpR/0nMS4ZPaJYdb8YTUL8o3w5yY+sA5KSMW1u0hNnccwk/ooElBynZzUTgJMTqc/DGoS6WphfA26CO9Uk+LzqqgCqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI+ZhLk5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f64ecb1766so2003895ad.1
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720078924; x=1720683724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NK3TigUPNI5mLQ79R/NG/opPwuXSQ49xpiUKWR/aclk=;
        b=cI+ZhLk5CQMp6bHq/7JIsEbLR2uF9WGLLFNF1vLXKuXplYOu9wR0+KVeTyTTtuSGxS
         JNAF563NNAFn9luUIEZS+H9HVJJ9JnG9dn+TNnt/pbduvxyFpPF9Y02rgSXKlqEuQBYD
         NB2MnxAtUzxu9Q+zaVVZDxO114A87jY/zUkTs8xF2kvsKfN3ZU2un3FuD/fDEoiCb5AC
         HWJuGlArPoqthwhR+6obJ/1IenLWfob/FMv2EsBJxP/6HsgFyyQ+xZLaDlpVm3EpeF8v
         Z0veXhf01k1AYKGSzs9Hscz2aUHyWu+fgK6KguzQZVKN/hGynCM+7voFvXZsN5lzbNSi
         aUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078924; x=1720683724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK3TigUPNI5mLQ79R/NG/opPwuXSQ49xpiUKWR/aclk=;
        b=l7ZqT2FIKxL0cmYuZN+Qns5/OwY5yVESRI/r0NqRNeXU/6LfcrDb+P/sLClHVm7NbU
         raefscqcJuLRbZfetyWgC/FjGZdWMmzU//BQMu5jNBHymDuUUWOJoPpEwV2J3L2IpJCS
         fpz2ksB7HVGmnDNnW9eifWmMEmZu79S2s+TvhVjBsygX7NNsZtvfDWfS4NQUyEVJRfed
         XkC/1NBNG3h41Hlgya2hwEp9kFBGYy6JRTzjvfXgzSBigXpEPU1YEXJzMtWm+F/SVnRB
         69Am+Q9L5E/VKMqMWddM29dToGcMT5bcbuSkoKgq+cZbZMLn/sY8OP4pjF64XkmSLAyr
         vvTg==
X-Forwarded-Encrypted: i=1; AJvYcCUGiTFPSrgOgARYhAW87At15UfUOuHvdz6ne1MHy2t3S+3B/2vCK2viWPZq+SqKuJbNKtEd0UriQcr8cIz/BBDc+fbo/6gI
X-Gm-Message-State: AOJu0YxmXpztxMJ2yJDuVOIHAwou7uNxmUAwKNWS9aBkPXsRYxsRjVtE
	uPg1B2HKwgIf1m83jivWY0/0sRrb14jAUwpHOocOE3oGVkokF6ez
X-Google-Smtp-Source: AGHT+IF/d+zyxuz9iTpv/7y5FUOz44Rx+TCjNJ1fn5bRPpxqqo99BeqWQ7Oi4lUxhk65qSs9SR4qyA==
X-Received: by 2002:a17:902:7c88:b0:1fb:1bb5:4062 with SMTP id d9443c01a7336-1fb33e7f02amr5525585ad.33.1720078923797;
        Thu, 04 Jul 2024 00:42:03 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8c52sm115864015ad.112.2024.07.04.00.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:42:03 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	horms@kernel.org
Subject: [PATCH net-next] bnxt_en: fix kernel panic in queue api functions
Date: Thu,  4 Jul 2024 07:41:53 +0000
Message-Id: <20240704074153.1508825-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_queue_{mem_alloc,start,stop} access bp->rx_ring array and this is
initialized while an interface is being up.
The rings are initialized as a number of channels.

The queue API functions access rx_ring without checking both null and
ring size.
So, if the queue API functions are called when interface status is down,
they access an uninitialized rx_ring array.
Also if the queue index parameter value is larger than a ring, it
would also access an uninitialized rx_ring.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 1 PID: 1697 Comm: ncdevmem Not tainted 6.10.0-rc5+ #34
 RIP: 0010:bnxt_queue_mem_alloc+0x38/0x410 [bnxt_en]
 Code: 49 89 f5 41 54 4d 89 c4 4d 69 c0 c0 05 00 00 55 48 8d af 40 0a 00 00 53 48 89 fb 48 83 ec 05
 RSP: 0018:ffffa1ad0449ba48 EFLAGS: 00010246
 RAX: ffffffffc04c7710 RBX: ffff9b88aee48000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff9b8884ba0000 RDI: ffff9b8884ba0008
 RBP: ffff9b88aee48a40 R08: 0000000000000000 R09: ffff9b8884ba6000
 R10: ffffa1ad0449ba88 R11: ffff9b8884ba6000 R12: 0000000000000000
 R13: ffff9b8884ba0000 R14: ffff9b8884ba0000 R15: ffff9b8884ba6000
 FS:  00007f7b2a094740(0000) GS:ffff9b8f9f680000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000015f394000 CR4: 00000000007506f0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die+0x20/0x70
  ? page_fault_oops+0x15a/0x460
  ? __vmalloc_node_range_noprof+0x4f7/0x8e0
  ? exc_page_fault+0x6e/0x180
  ? asm_exc_page_fault+0x22/0x30
  ? __pfx_bnxt_queue_mem_alloc+0x10/0x10 [bnxt_en 2b2843e995211f081639d5c0e74fe1cce7fed534]
  ? bnxt_queue_mem_alloc+0x38/0x410 [bnxt_en 2b2843e995211f081639d5c0e74fe1cce7fed534]
  netdev_rx_queue_restart+0xa9/0x1c0
  net_devmem_bind_dmabuf_to_queue+0xcb/0x100
  netdev_nl_bind_rx_doit+0x2f6/0x350
  genl_family_rcv_msg_doit+0xd9/0x130
  genl_rcv_msg+0x184/0x2b0
  ? __pfx_netdev_nl_bind_rx_doit+0x10/0x10
  ? __pfx_genl_rcv_msg+0x10/0x10
  netlink_rcv_skb+0x54/0x100
  genl_rcv+0x24/0x40
  netlink_unicast+0x243/0x370
  netlink_sendmsg+0x1bb/0x3e0

Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

The branch is not net because the commit 2d694c27d32e is not
yet merged into net branch.

devmem TCP causes this problem, but it is not yet merged.
So, to test this patch, please patch the current devmem TCP.
The /tools/testing/selftests/net/ncdevmem will immediately reproduce 
this problem.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6fc34ccb86e3..e270fb6b2866 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15022,6 +15022,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_ring_struct *ring;
 	int rc;
 
+	if (!bp->rx_ring || idx >= bp->rx_nr_rings)
+		return -EINVAL;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
@@ -15156,6 +15159,9 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	struct bnxt_cp_ring_info *cpr;
 	int rc;
 
+	if (!bp->rx_ring || idx >= bp->rx_nr_rings)
+		return -EINVAL;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 
@@ -15195,6 +15201,9 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr;
 
+	if (!bp->rx_ring || idx >= bp->rx_nr_rings)
+		return -EINVAL;
+
 	rxr = &bp->rx_ring[idx];
 	napi_disable(&rxr->bnapi->napi);
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
-- 
2.34.1


