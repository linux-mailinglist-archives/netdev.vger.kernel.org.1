Return-Path: <netdev+bounces-243673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52835CA54CC
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBE5F3140C55
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 20:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83DA30F552;
	Thu,  4 Dec 2025 20:15:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 6.mo581.mail-out.ovh.net (6.mo581.mail-out.ovh.net [188.165.39.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F22ECE9E
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.39.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764879337; cv=none; b=Ms3z/7FvnVDKBOqDYsEkjTtHeXMEYUHRfN28ag1vbAD0KRmlysQ771t9XQqiMRWEHl1ONckhXKC9tfZ9j4hy6eB6dmicKFzb7DJhEHmuEVGQ1u4IEk/lD+ZZ0sdk4qrbIXkK2FI+bacMxjPiUtrIiEVagenmUDyw37u2LQYAEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764879337; c=relaxed/simple;
	bh=WpIiSH4GxU7onEE+2ezX9gvDAfdCzI+wz8TInd5GTu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rik6WhBTjaJLjalLWsEdlqNjsaO+vtI9w7KfS2FnNowVUbHOgZw9BkgM5p0aEBiYAgtwe2vEh1oZjE+Vz/I9TM4voUKjTZWAJk7rdYDT1SxfLIGxBa/8oL5YOPt+2YSvgKXnKlcJRbh+HaScUGKqpoPLhTVlXBGrLISwpddPLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bp.renesas.com; spf=fail smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=188.165.39.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bp.renesas.com
Received: from director10.ghost.mail-out.ovh.net (unknown [10.110.37.167])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4dMgDT6KG1z6THL
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:38:17 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-m4nfg (unknown [10.111.174.111])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5E190C4796;
	Thu,  4 Dec 2025 16:38:16 +0000 (UTC)
Received: from labcsmart.com ([37.59.142.114])
	by ghost-submission-7d8d68f679-m4nfg with ESMTPSA
	id naCeNve4MWmh+AYArq+dVg
	(envelope-from <john.madieu.xa@bp.renesas.com>); Thu, 04 Dec 2025 16:38:16 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-114S008dea8ec6f-3573-4234-b91e-57f82739fe4c,
                    E90FA267686E4F2ED65044873A5FD8D85CF2A6B0) smtp.auth=john.madieu@labcsmart.com
X-OVh-ClientIp:141.94.163.193
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be
Cc: biju.das.jz@bp.renesas.com,
	claudiu.beznea@tuxon.dev,
	linux@armlinux.org.uk,
	magnus.damm@gmail.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH net-next 0/3]  net: stmmac: add physical port identification support
Date: Thu,  4 Dec 2025 16:37:26 +0000
Message-Id: <20251204163729.3036329-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13328684574918870405
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTF0g3R1pdQ6JLW75+mTBMFpIdpDzonyTfcnxVjUvtlRne6WFvO7QcVphjo3Xa9L2ro/D3yhhzJtc1dfPWja+6BCm1dEuB/2aTBXeKb11fPLLcNr7WgrUiSnUVGskVo7wSZo1kEpwEJ3OeosKSnIPHuezU4mhVIVpLFWLP+s9PVZOXmzmayuD7fbemwm7J6Vl6fTZMyvtDSASIdtIRrh6QhZs8p8lX/f/c7Fl6ZDOj9oLvRh/iLUDTQFV3XqFl6bvFcJxSpsCvT7/PXlrMHklHos/J2hGQPxAH/ucC2BVOt1U5GtUn/5StnFDm7GSQoMkqwsL8cQ4WP9Mmk80Wy6/yKRdPaO+UO7vscqoFAYDfUnNBe8hRmT2gszV7DMQ6mKwvO1Tt3MlPPxUtpcbSffjyvOhjF/pq7tIiaGva/CRqzxFtqZJlr5UNd9GVNsaU8qu3ec+QgvrU7v+4NzFjGrNdRA5Ro4PXdEJYsBUrLUhT6WThIQ3S3wZ3OnDskoZ0Y65pTfmvUDtR4n5r5Fm1ocWU/RvUz22QS+QTEzKrRlXw+KQ/EPFLBXiJX4Tly1oHxvpM5Ik38pUTsPppQGfxRPF7GGFtHC/wOFX0H2zbVQSNtYnuWoFDx8aCOZ3sTj8mDIvWEgnJ+SBh1KsrBn4QiRijrbI91rISt52yQRsTT1mqSkKw

This series adds physical port identification support to the stmmac driver,
enabling userspace to query hardware-stable identifiers for network interfaces
via ndo_get_phys_port_id() and ndo_get_phys_port_name().

On systems with multiple ethernet controllers sharing the same driver,
physical port identification provides stable identifiers that persist
across reboots and are independent of interface enumeration order.
This is particularly useful for predictable network interface naming
and for correlating interfaces with physical connectors.

The implementation follows a two-tier approach:

1. Generic stmmac support: Default implementations use the permanent MAC
   address as port ID and bus_id for port naming. This provides immediate
   benefit for all stmmac-based platforms.

2. Glue driver override: Platform drivers can provide custom callbacks
   for hardware-specific identification schemes. The Renesas GBETH driver
   implements this to support device tree-based port identification,
   addressing cases where hardware lacks unique identification registers.

The Renesas implementation constructs an 8-byte port identifier from:
- Permanent MAC address (if available) or Renesas OUI (74:90:50) as fallback
- Port index from device tree property or ethernet alias


John Madieu (3):
  net: stmmac: add physical port identification support
  dt-bindings: net: renesas-gbeth: Add port-id property
  net: stmmac: dwmac-renesas-gbeth: add physical port identification

 .../bindings/net/renesas,rzv2h-gbeth.yaml     | 19 +++++++
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      | 56 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 54 ++++++++++++++++++
 include/linux/stmmac.h                        |  5 ++
 4 files changed, 134 insertions(+)

-- 
2.25.1


