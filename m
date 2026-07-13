Return-Path: <netdev+bounces-307033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h0q+ETuQVGqEnQMAu9opvQ
	(envelope-from <netdev+bounces-307033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:14:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE1E747E72
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:14:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=t7vGjfMO;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307033-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307033-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E38DB3037420
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92181369208;
	Mon, 13 Jul 2026 07:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C04367B99;
	Mon, 13 Jul 2026 07:11:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926693; cv=none; b=AzduY0Lz9nhirTag82RNs0GQTRRMAMx7HpTmuiQ2nLDBQZ4blc3gn69aVKj+ojNXH37I/vedroCK/rqZpzRTrJwRGmKHxxTDUv6u1FWnQaIm4DgNexUg/gyXvTPxlr88cLWGF/9kjvhtqEEWaulysFTQOregHDGlLHs+njNdZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926693; c=relaxed/simple;
	bh=v8ikMpobnJwMOrKK4JZETwY+ttfysNPOQ3LuJ3PAhEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h2jgcfxFdmYSp2t92LGKc9bW4gDS2O6zdW6cmWyOgfkTgQd9k5UNYyNN95snF6k7hrQnvlHZIHFSb7Jk7c6ypS05mrrJdaCxRURF7dyLIEklGvYHbss/KWoCaPxaSywJN+PS8aYoACm8IhQ4VMvpLWas5Igcsw0EcEVnTqTwZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=t7vGjfMO; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1E1364E40D81;
	Mon, 13 Jul 2026 07:11:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBD3C60341;
	Mon, 13 Jul 2026 07:11:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 624CD11BD39F5;
	Mon, 13 Jul 2026 09:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783926685; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Eu/DE9hbfTvwI4vEUzCU3KcSbFyR+/46EOXPdnTcM3c=;
	b=t7vGjfMOx2ieTB3+93D9DmXxclOzVmlxq5ETeFt+SqqEbPqTRXtCUSKfqN/wdrUmgc4D/e
	81bigTg+uoSb6ht4VTV3Ga7AEeVp77Z1Esus03JV1fixRsaiMWgTFdjc/WxySG+dvMzNfL
	wTV8QqwrkfwOXNsmsAwD6SkeIx+hOXqE74V5CnNdLadWfwt7q7zOt70XQq21/g/z5f48bV
	vEMWNF0VFSZY9C3Ml+vnT/ebstaoWAhbc9JsaCyeMx7UkYpRYtWHlbOQ6Woix30urTEe3O
	MnpdoTL3eQPlAH4SvtEFsIY0Rk/DvJCTmyq9Lg7Q8sWatYWnZq/o8Vp24cPB3Q==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v2 00/10] net: dsa: microchip: add PTP support for
 KSZ8463
Date: Mon, 13 Jul 2026 09:11:19 +0200
Message-Id: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNwQ6CMBBEf4Xs2TWlEAFP/ofhUGArG7Vt2gZR0
 n+3IV48Tt7Mmw0CeaYA52IDTwsHtiYHeShgnJW5EfKUM0ghT6IRLd7DBw290EWHumunoRKqVbW
 GvHCeNK+77QqGYi6uEfpMZg7R+vd+s5Q7/xm7P+NSosCqrrWQmpqqo8tgbXywOY72CX1K6QsRF
 qNvsgAAAA==
X-Change-ID: 20260708-ksz-new-ptp-f98db30a8a4f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307033-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACE1E747E72

Hi all,

This series adds PTP support for the KSZ8463.

The KSZ8463 differs quite a lot from other KSZ switches supporting PTP:
it has a different interrupt logic and a different 'PTP engine'.

This second iteration addresses most of the Sashiko comments of the v1.
In [1] I said I would re-order the patches to please Sashiko but in fact
it would lead to 'unused function' warnings so I finally decided to keep
this order.

Patches 1 to 4 add interrupt support for the KSZ8463
Patches 5 to 10 add the PTP support for the KSZ8463

[1]: https://lore.kernel.org/r/20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v2:
- PATCH 1:
  - Modify the commit log to explain why IRQ setup isn't done on KSZ8463
- PATCH 4:
  - Fix the error code path in ksz8463_ptp_port_irq_setup().
  - Change the IRQ request/free orders to register/unregister the top level
    handler first/last
- PATCH 8:
  - Free the skb if its linearization fails
  - Downgrade ip_summed to CHECKSUM_NONE when clearing the reserved
    field of the PTP header
- PATCH 10:
  - Ensure the skb is linearized before accessing the PTP header
- Link to v1: https://lore.kernel.org/r/20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com

---
Bastien Curutchet (Schneider Electric) (10):
      net: dsa: microchip: implement ksz8463_setup()
      net: dsa: microchip: split ksz8_config_cpu_port()
      net: dsa: microchip: allow the use of other IRQ operations.
      net: dsa: microchip: add PTP interrupt handling for KSZ8463
      net: dsa: microchip: adapt port offset for KSZ8463's PTP register
      net: dsa: tag_ksz: move the KSZ8795 tag handling below ksz_xmit_timestamp()
      net: dsa: tag_ksz: share code for KSZ8795 and KSZ9893 xmit operations
      net: dsa: microchip: add KSZ8463 tail tag handling
      net: dsa: microchip: explicitly enable detection of L2 PTP frames
      net: dsa: microchip: add two-steps PTP support for KSZ8463

 drivers/net/dsa/microchip/ksz8.c        | 311 +++++++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz8_reg.h    |   1 +
 drivers/net/dsa/microchip/ksz_common.c  |  15 +-
 drivers/net/dsa/microchip/ksz_common.h  |   6 +
 drivers/net/dsa/microchip/ksz_ptp.c     | 266 ++++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_ptp.h     |  16 ++
 drivers/net/dsa/microchip/ksz_ptp_reg.h |  10 +
 include/net/dsa.h                       |   2 +
 net/dsa/tag_ksz.c                       | 232 +++++++++++++++---------
 9 files changed, 721 insertions(+), 138 deletions(-)
---
base-commit: a6cfd2762eb18cde4eb34906599ffa7b07c2ed60
change-id: 20260708-ksz-new-ptp-f98db30a8a4f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


