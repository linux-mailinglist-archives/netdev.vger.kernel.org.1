Return-Path: <netdev+bounces-215180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA0B2D798
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117DF5E7874
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE582DEA76;
	Wed, 20 Aug 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VLG7Bm+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D82DCBF1;
	Wed, 20 Aug 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680870; cv=none; b=RlaY3tyZHTT7yiT3oFQMyF561IeE1zieGDuDQX5VHk2gFEpP50bnKaKDE8A9QwZYRp++Kk5b9t0ThLUPeWs/Qdh6+TCCxiJZYl6atw89gbacYosZGvYN3g/93q59Fl9Q/Q3Qox0hPWn1+x+3oOZ2IP8B8/uFbMxiWF4JlxsX60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680870; c=relaxed/simple;
	bh=A8dPjprWxoNsWRX3HoLPc5JeriXwc19V907JzeqIlaQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ar6O4/VC6ONzXOk2vfxKlOjTVUkX661ZGjZ7Qyo6ArDEHK61O4KbvbGB4dlEIlfQQu/I8u4yO6kaqzviDawr1h0fKY0ZdYoXYIQ3Ib/UpY3AdrdxONqqgKpkSCrCLwO39ohFAjI5gXGUbY9quWX1Don8i19EM7a2OeMPugQXt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VLG7Bm+i; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6032A4E40C45;
	Wed, 20 Aug 2025 09:07:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D85F606A0;
	Wed, 20 Aug 2025 09:07:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B2771C22D33A;
	Wed, 20 Aug 2025 11:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755680864; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=e3lpIExcXw2eYOSrRQDqVTlQbJZKW/vqui2JHO+zjlo=;
	b=VLG7Bm+iD2mjewn5yLbOMvAPsCh9eO3HmF9bmEbBblBoxyAKJLQGBx73Df6h/7v78TlVb0
	fGrJiG/7gZzPFRH4/VpReLxGfEb9P04vqpMp1eWQpJ1kx0KPxYDqU6uaHJVU41iPv1a0II
	ivXHjkN7IlbJJVt/q3tacERT7lVLoYybWOm8lh4ZqYlYYJ16g9hm8r0L4YJP3MpZJw/b+s
	LXWVbnYJg0qYnCDwSntd0Eb7MIv4NRJww+mzAl5Af/mOe3/AupfL4El4MlT+rprntZuEZr
	eYfoYldXbJJbtOa2T5lDuIYGBjTHI3MQVT+cU6vqtrRdaeV0PwzZNNAkv4MyFw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH ethtool v3 0/3] Add support for PSE priority feature and
 PSE event monitoring
Date: Wed, 20 Aug 2025 11:07:31 +0200
Message-Id: <20250820-b4-feature_poe_pw_budget-v3-0-c3d57362c086@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFOQpWgC/33NQQ7CIBAF0Ks0rMVQSlt05T2MaQoMLUktDVDUN
 L27hI1xoYtZ/Pz8Nxvy4Ax4dC425CAab+ycQnUokBz7eQBsVMqIEspKShgWDGvow+qgW2y6Ryd
 WNUDApAfgDWVa1jVK88WBNs9MXxGEMVg7oVsqRuODda/8Mpa5TnpNGkp+67HEBBOhRKuoOEmuL
 8LaMJn5KO09s5F+KF5WfyiaKdCN0FK2hH9T+76/AZKrqqkWAQAA
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Dent Project <dentproject@linuxfoundation.org>, 
 Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for PSE (Power Sourcing Equipment) priority management and
event monitoring capabilities.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v3:
- Change event loop limit to not ignore events that could be out of scope.
- Fix incorrect attribute usage.
- Improve documentation.
- Link to v2: https://lore.kernel.org/r/20250813-b4-feature_poe_pw_budget-v2-0-0bef6bfcc708@bootlin.com

Changes in v2:
- Split the second patch in two to separate the PSE priority feature and
  the PSE event feature support.
- Regenerate the "update UAPI header copies" patch.
- Link to v1: https://lore.kernel.org/r/20250620-b4-feature_poe_pw_budget-v1-0-0bdb7d2b9c8f@bootlin.com

---
Kory Maincent (3):
      update UAPI header copies
      ethtool: pse-pd: Add PSE priority support
      ethtool: pse-pd: Add PSE event monitoring support

 ethtool.8.in                           | 31 ++++++++++++
 ethtool.c                              |  1 +
 netlink/monitor.c                      |  9 +++-
 netlink/netlink.h                      |  1 +
 netlink/pse-pd.c                       | 89 ++++++++++++++++++++++++++++++++++
 uapi/linux/ethtool.h                   |  4 +-
 uapi/linux/ethtool_netlink.h           |  2 -
 uapi/linux/ethtool_netlink_generated.h | 83 +++++++++++++++++++++++++++++++
 uapi/linux/if_link.h                   |  2 +
 uapi/linux/neighbour.h                 |  5 ++
 10 files changed, 222 insertions(+), 5 deletions(-)
---
base-commit: 755f5d758e7a365d13140a130a748283b67f756e
change-id: 20241204-b4-feature_poe_pw_budget-0aee8624fc55

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


