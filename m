Return-Path: <netdev+bounces-302443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f0pnMMjbQWqcvAkAu9opvQ
	(envelope-from <netdev+bounces-302443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B67A6D58C5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 04:43:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=bSzpDgkb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302443-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302443-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0580300766F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 02:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64B2D3A7C;
	Mon, 29 Jun 2026 02:43:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B31B86C7
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:43:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700998; cv=none; b=C64nOgm+4FGULVdXByJg3buaBiPHJxkU5M/b17VFX3mEhv/L2JLJ0meGaK0gyLZ9yqNpkoSuKhzE2kznyKMFvfkMuUqh4Eh0c8ubGi5GzJNFk+OgBPxMfbRC2QpRuYQlwX7dr/HQCuvkGgZkFwLg1MIsLPMxnMB+Fy8YGSuRacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700998; c=relaxed/simple;
	bh=aYJDqLIeV5q8b+zEeZhiM2ZS/viJ0guXPqKcx31X8Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dErNQDHwTGOBAXXUimXhwXID7RphmB2PiGLtazwrr/DnunitkFUgcacU1B0sH/+24f3v4G8YlocU+FOVm6v9i5XEQVa6p1FnlUvGV7h7gCrRCXbzA8GEq5S5mKB27b0lIbqeOEK6s3g5jXuqXJEuEXq1iOvGwhaghi0vPSjZOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bSzpDgkb; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=g7
	a55kAaxhsU365SUmAyh7UxCGqz2b8SqA464g6a+RU=; b=bSzpDgkbSJMaTkkULA
	ILF9NGngKRadWxguhODVgihdHGNY571sS/KhUvtMvnRp/5TLV4Fm/5P3Y2EBnfSp
	e+qph6TwZ/SqOn9vefUCw9iBTHfV/p03qeNBuJ8XxE3zXiO6DOCb646Cw9ccBr0y
	bGNr5lDS1GAQRZ4bFdiRj4670=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3WgKY20FqvwrtEw--.20426S2;
	Mon, 29 Jun 2026 10:42:32 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: kuba@kernel.org,
	horms@kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	edumazet@google.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH v5] virtio_net: disable cb when NAPI is busy-polled
Date: Mon, 29 Jun 2026 10:42:30 +0800
Message-Id: <20260629024230.37325-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3WgKY20FqvwrtEw--.20426S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48WFWUXF4UurWxCF4kZwb_yoW8Gw4UpF
	4ay34Uurn0qry2qa18JF48XFy5uwn7GayfGw4Y9w45uFn0yrnxJryFyFyUAa1avrs5Ja43
	ZFsYvryUWF109FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUrcsUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4RgINmpB25gsrAAA3v
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,google.com,lists.linux.dev,vger.kernel.org,kylinos.cn,163.com];
	TAGGED_FROM(0.00)[bounces-302443-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[lange_tang@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:horms@kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:edumazet@google.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:tanglongjun@kylinos.cn,m:lange_tang@163.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lange_tang@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B67A6D58C5

From: Longjun Tang <tanglongjun@kylinos.cn>

When busy-poll is active, napi_schedule_prep() returns false in
virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
The device may keep firing irqs until reaches virtqueue_napi_complete().
Under load (received == budget), it will lead to a large number
of spurious interrupts.

Fix it by disabling the callback at the virtnet_poll() entry.
This keeps the callback off while we poll and it is re-enabled by
virtqueue_napi_complete() when going idle.

Fixes: ceef438d613f ("virtio_net: remove custom busy_poll")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>

---
V4 -> V5: Guard disable_cb with budget to avoid netpoll stall
V3 -> V4: Update commit message and remove some comments
V2 -> V3: Add fixes tag
V1 -> V2: Remain agnostic to busy polling
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7d2eeb9b1226..0b3f1bb227d2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3008,6 +3008,9 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int xdp_xmit = 0;
 	bool napi_complete;
 
+	if (budget)
+		virtqueue_disable_cb(rq->vq);
+
 	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
-- 
2.43.0


