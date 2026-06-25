Return-Path: <netdev+bounces-301820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ScvAFIeGPGpMpAgAu9opvQ
	(envelope-from <netdev+bounces-301820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:38:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D63806C22A4
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:38:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=hAIGINI2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301820-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301820-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FDC03008D69
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161AB36F902;
	Thu, 25 Jun 2026 01:38:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC6EEC3
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:38:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351493; cv=none; b=UapG4eBob1zV++wxRTcbkZiFBpHCVhzc2ugXyBY4DWVPIhyO2j2DxnRGOBnWoNTOkT5S+/CFAGGryZby445JOINkwiXvHn8ITBKheLWhveRAZg97pXb60lsVmSI+SrR3Q4Gxil1sa+nQMwSM2pVL1iZc5eXkezNt01o0WA6swj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351493; c=relaxed/simple;
	bh=gZuD8Vvgu+uyRPFcFvPFgy5+G3DNYykp5gSdfDaLGEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AO2p48UTqh09u1qC6rP905XBwC6tN+3yPVt0yX+Vgyus6yngTjMspsAoQN8NcB2ptSHn2fZRhirjkhcnnwyep80fwk7orKBTFHFO+SC7mbYYvaFh9XS3gSqQCoHmsWDTC6iHMfpctwYROtIKM98PE1qoi0VgOgw2Fck0OxXIsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hAIGINI2; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gY
	0Fh4pgY/1ngQWWvSj+epDfJSoFfpNL30c1Mz3Qqx4=; b=hAIGINI2PJnF0GXXzU
	yKjrMancxVZGNQXLftM2eRRzlK3ED7TXedtYBrsWIbqREStR/kJpUfSwy7ITxo0t
	SSHvjN3zdAUR544xm3JcAkgHD54eK1vabHFVmcCkaBEItLNyYqnHJoIbcVD6Zwlh
	YNYkXvXbm0wmknSIrTVlAnV5Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnIm1jhjxqJN6SFQ--.61028S2;
	Thu, 25 Jun 2026 09:37:40 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: jasowang@redhat.com,
	edumazet@google.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH v4] virtio_net: disable cb when NAPI is busy-polled
Date: Thu, 25 Jun 2026 09:37:33 +0800
Message-Id: <20260625013733.29300-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnIm1jhjxqJN6SFQ--.61028S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48WFWUXF4UurWxAFWxXrb_yoW8GryfpF
	4jy3yUurn0grWIqa1kJF48XFy5uwn3GayfGw4Y9w45uFn8KrnxJry5tFyjya1avrs5ta43
	ZFsYvryUGF18uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRknY8UUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-QRkkmo8hmQEZgAA3Z
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,google.com,lists.linux.dev,vger.kernel.org,kylinos.cn,163.com];
	TAGGED_FROM(0.00)[bounces-301820-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[lange_tang@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:jasowang@redhat.com,m:edumazet@google.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:tanglongjun@kylinos.cn,m:lange_tang@163.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lange_tang@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D63806C22A4

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
V1 -> V2: Remain agnostic to busy polling
V2 -> V3: Add fixes tag
V3 -> V4: Update commit message and remove some comments
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..569e4db187d1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3008,6 +3008,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int xdp_xmit = 0;
 	bool napi_complete;
 
+	virtqueue_disable_cb(rq->vq);
+
 	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
-- 
2.43.0


