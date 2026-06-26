Return-Path: <netdev+bounces-302083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L7w0C5vePWpf7QgAu9opvQ
	(envelope-from <netdev+bounces-302083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 04:06:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E946C9A5A
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 04:06:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=QWQuvBiU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302083-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302083-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E7E730368B5
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 02:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB7B29D294;
	Fri, 26 Jun 2026 02:06:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659712CDA5;
	Fri, 26 Jun 2026 02:06:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439576; cv=none; b=ENeAotl1KzJBERP3LEj+bKeEpi18DCSatLoKSC/tU4Mfd5JkQtXY/0M5Zl/+BYVumyi054j/uc8uUpuM82TKP/boIqBG8XBrCB5SjfcBTHYIEc4eDLB89jFw0a+4sfzx6f+Zk0BIQ+6Pn3pDcnXoWbShdElZc956PdAYbv9IGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439576; c=relaxed/simple;
	bh=5+wJ6pTDbqo6a5OaXQZYq75bjR1odo+XYKOik9uLp3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmVAQETaAvLNLyqrYJhJ0ZJ+p3H3CrxncnWemq6ps2ewZ57gSWLuz68PfjpNlKBqrNeiPG7CwTrCa4UknIYeIoUdIg/tPrs/NrXHnM/QfPlHoJr2xgGK/Z/wFrXtoThveGGNJCF4B1RFZwHnMxZSqW8fdxIPnaSGtAkPjGrHwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QWQuvBiU; arc=none smtp.client-ip=117.135.210.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mO
	SgYwaLawiIFYNPeX44qpXqdxhREpsWdcKCCKp8Sow=; b=QWQuvBiU+ZCjVB7V4K
	xBYysWD1egowB6GO2M7yUMc+1fxh7E6mOW9txsZbpUvlJCeQ2/pn4L2ahskCajjc
	aNgDRmTk+3bSyJs4ntwL6/vN1iTDflFzInxjC1CEdGmKwncfk2m4Jy0OFgMWGMRt
	Ee9O9hsRresk7ZLhKUV3PQ+yw=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBn4SB83j1qWhWLEA--.17305S2;
	Fri, 26 Jun 2026 10:05:49 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 0/2] vdpa_sim: fix suspend/reset and dma_unmap locking
Date: Fri, 26 Jun 2026 10:05:43 +0800
Message-ID: <20260626020545.607600-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBn4SB83j1qWhWLEA--.17305S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF47Gw4rXw4kGr18Jw1kXwb_yoW3CrbEgr
	Z7uryqyw1rGrZayw1UKr9rJFsxK39FkrWrZw1qga17X34rtwnxWa1kKFyUJF17GFW2yFs5
	tF1UtryfAr1xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbgdb7UUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0h3ASWo93n2IHQAA3n
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_RECIPIENTS(0.00)[m:jasowang@redhat.com,m:mst@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302083-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4E946C9A5A

From: Xiong Weimin <xiongweimin@kylinos.cn>

This series fixes two independent issues in the vDPA simulator:

1. Clear pending_kick on device reset so a deferred kick from a
   suspended device cannot be replayed after reset/re-init.

2. Hold iommu_lock across the full dma_unmap() path, including the
   passthrough-to-custom mapping transition, matching dma_map().

Both patches tested on an openEuler VM running kernel 6.16.8: built
vdpa_sim.ko from /usr/src/linux-6.16.8 and reloaded vdpa_sim /
vdpa_sim_net successfully.

Xiong Weimin (2):
  vdpa_sim: clear pending_kick on device reset
  vdpa_sim: hold iommu_lock across dma_unmap passthrough transition

---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0


