Return-Path: <netdev+bounces-228733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D9FBD3576
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C95C1885EB0
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F1255F22;
	Mon, 13 Oct 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UhHOBFCu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E323D288
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364366; cv=none; b=ixE28XByzKmjOaTGB96n3/KRQ3Ut5maebfOPymmWFbr6c2kHPb9DoL1OfdMuw4+4OBcaMt9qouBivVLfhBzVyvPH+VSqsw77g3G9bwI1+Ydf7TppfLW+Bg3Lo6ZuBqs4pPtwz6Gylltevchhj+sqmjwtT1Uk06883yRM1LekM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364366; c=relaxed/simple;
	bh=7dPYjVSDa7rzmlYAqgRLJ9hx2KhEy6vNsnnaMEZfJeA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RTJaVChhZRluU3qdcevhFJPRYn39r2yF8BIT/DdU4dCg+dLoycXWPDS9s9VBHL17BMOKp/6TWx36G2nXzk24i1t4xnvWDba9Fh0PAmqZQxtkrMr59l7DVLcOWqEYb7AJK1ELGcV14swLDBy6roYFHuVKPGxh1znDZlRavjp2HIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UhHOBFCu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BD544C093AE;
	Mon, 13 Oct 2025 14:05:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A572A606C6;
	Mon, 13 Oct 2025 14:06:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A936102F226C;
	Mon, 13 Oct 2025 16:05:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760364359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fOo6qZDnMd3ktQFTe2KfUtuiO7JTcxsns9ejw3eMLtw=;
	b=UhHOBFCuKl1kffSJUXGZQMrCVe0zJVIJX4WHwtcpBVa3qdbCcuvKXc1P+s1NMUtcgBaroR
	FTr/9VOEbr6lr6P2gAa/zwLrBe3m3RQFv+sssPYM55PSx3APn1xZUtgXeKeNapAvZtSNtg
	MZD5Htp2HI/AA0QIpLBn8S8w9zlmUTT5CucOSAblnbn5XD2dPGx1yRb6lUTqOD0mNZVMCv
	a4Vi6qKaAeVFeABKg0GkwWn6fe+s7JrzYbTwjv4IgV85TQyvmW6ozImZoOO1/DRw4pxiPB
	2uoHnqYjK18S1CmBwCQGIKDW+MfjBd0jqCzAI7ggND1CyN/A2omRjZX1tl9OnQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v2 0/3] Preserve PSE PD692x0 configuration across
 reboots
Date: Mon, 13 Oct 2025 16:05:30 +0200
Message-Id: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACoH7WgC/4WNQQ7CIBQFr2L+WgzFSsWV9zBNg/TVEhUawKam6
 d3FegCXk3l5M1NEsIh02swUMNpovcsgthsyvXY3MNtmJsHFgSuhWAedXgHN0EolJt4EXL1PzR0
 YGuNdx6TSSslSVqUqKN8MAZ2d1sSFHBJzmBLV2fQ2Jh/ea3ssVv/L7Pn/zFgwzqTgrUEFHLU4f
 wcP63bGP6leluUD5cMS0twAAAA=
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, kernel@pengutronix.de, 
 Dent Project <dentproject@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Previously, the driver would always reconfigure the PSE hardware on
probe, causing a port matrix reflash that resulted in temporary power
loss to all connected devices. This change maintains power continuity
by preserving existing configuration when the PSE has been previously
initialized.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v2:
- Resend the series as I carelessly send it during the merge window.
- Link to v1: https://lore.kernel.org/r/20250930-feature_pd692x0_reboot_keep_conf-v1-0-620dce7ee8a2@bootlin.com

---
Kory Maincent (3):
      net: pse-pd: pd692x0: Replace __free macro with explicit kfree calls
      net: pse-pd: pd692x0: Separate configuration parsing from hardware setup
      net: pse-pd: pd692x0: Preserve PSE configuration across reboots

 drivers/net/pse-pd/pd692x0.c | 155 +++++++++++++++++++++++++++++++------------
 1 file changed, 112 insertions(+), 43 deletions(-)
---
base-commit: 7d5145eba189b35f64c7e7c03a613941fede2cd7
change-id: 20250929-feature_pd692x0_reboot_keep_conf-69a996467491

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


