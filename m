Return-Path: <netdev+bounces-302085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nbBFNBTfPWp97QgAu9opvQ
	(envelope-from <netdev+bounces-302085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 04:08:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1436C9A7C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 04:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=pWiiU50Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302085-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302085-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C53430892E7
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 02:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5742EB5A6;
	Fri, 26 Jun 2026 02:06:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C92F0661;
	Fri, 26 Jun 2026 02:06:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439583; cv=none; b=PzKW0ggLnHHyAyVZ6y4TQRFVASTfZjNhgMdYE1s3rSRNeGtYyv0Yb+78Cbmdv+NWH2HSBSiGOqhTgKqOie12O98k1OX50HShZ9vivTaUEpCJaJzHKy3eCe0V594Mq/NrTGXOqBU4rmZkZj3thN2TPw5kytrBmgMPeGlTeqNoBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439583; c=relaxed/simple;
	bh=L28thVxDuPwu4W8UYQ3of1uvi9fpbjeAwjn5Ol+a02Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR6By1/5VQZ9IIdiy3FvWHofWm3yAtRmHiYMbMQftbVUYU1m6t5diYF97L9CQB9X7xd/b7Of9WnQZeBUZuPxdkdLCdsB7iErLBZEjsgbpKP8NDjYeZEL5l1/Pd1rg3pjWSM4SRuWNpgkYJrA9SGP38CVTLmEi9zqSL4Cfql4ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pWiiU50Z; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pl
	cB/czLDn3eZAiAw8vFY41ABLwJ61bHMGAvnLvHR+8=; b=pWiiU50ZZSeGcRkGwc
	EgjwxY/UA4NM2I0tPTCd2yQd867oYizX6YmVFk1ylaqGV3wYvBcaLoTF3jkH90jN
	oAwXAIMPz/WVV+/msBnz3LEx3tv9oO7ndwB1Dvh1F0KnXvehJeMvJFVPTfX/ezQi
	qD7WpOSC7r3YOjqlVsAhkp/W4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBn4SB83j1qWhWLEA--.17305S3;
	Fri, 26 Jun 2026 10:05:53 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 1/2] vdpa_sim: clear pending_kick on device reset
Date: Fri, 26 Jun 2026 10:05:44 +0800
Message-ID: <20260626020545.607600-2-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626020545.607600-1-15927021679@163.com>
References: <20260626020545.607600-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBn4SB83j1qWhWLEA--.17305S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWUCry3Ar1kZF1xJFy3XFb_yoWkKFb_Kr
	95uws7Ar43Gr40krykKryfAr90ka95WFW3uwn2qr4fJ34Ut3W5Wa1kWry3Ja97AFZ2ya4a
	yrWYy34xCr1rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8iZ23UUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9AHBSmo93oGYOgAA3U
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jasowang@redhat.com,m:mst@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302085-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[15927021679@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C1436C9A7C

From: Xiong Weimin <xiongweimin@kylinos.cn>

vdpasim_kick_vq() sets pending_kick when a virtqueue is kicked while
the device is suspended (!running but DRIVER_OK).  vdpasim_resume()
later replays kicks for all virtqueues when pending_kick is set.

vdpasim_do_reset() clears running and status but leaves pending_kick
unchanged.  If a kick is deferred during suspend and the device is
reset before resume, a later resume can spuriously kick every
virtqueue even though no new work was queued after reset.

Clear pending_kick in vdpasim_do_reset() together with the other
device state that must not survive a reset.

Tested-on: openEuler VM (6.16.8, /usr/src/linux-6.16.8)
Tested-by: Xiong Weimin <xiongweimin@kylinos.cn>

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -161,6 +161,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
 	}
 
 	vdpasim->running = false;
+	vdpasim->pending_kick = false;
 	spin_unlock(&vdpasim->iommu_lock);
 
 	vdpasim->features = 0;
-- 
2.43.0


