Return-Path: <netdev+bounces-244927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69482CC3047
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E3BB3033737
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D763136BCC6;
	Tue, 16 Dec 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="ltIVypAI"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42883446AC
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887437; cv=none; b=AinZIz03KCGp2ccDNGXjDx8jfI8DYdnLW3MzZi8ZGQgdJL7UUcr2fQSDtaSmBiUN4AQomb0PsrHv+DwC/7oIhacrC+DFuISdmfiRWI7xeO2WQCjgivZkgDRVeB82VMi4Z0TRihvy82+QrYRSpt8/Iat92VeHWgsq0g75ZuxN2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887437; c=relaxed/simple;
	bh=Q/5kqMY0ZxWyldfN/9yw3DZDiEesyuUC/u0gbfLsK5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2tVAwjn7IfNRfXgOzhPVTrs4Pk72gYWTz3yZOfVvCDH00DvcEYc/0CIPx5KmUBN079aS0Qs3Ny+Ia1PrHQkC/0QeaNZLlqscy7A18GLOUGmCHBvSZiFNXXa1nTLeMnUJPZO7aLHoK/0HTpcp0bgsY/3TQu9w4aW9foCsj/15cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=ltIVypAI; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202512161217070a73589e7700020741
        for <netdev@vger.kernel.org>;
        Tue, 16 Dec 2025 13:17:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ikB3E0wPVwS1ewcktNtjWchQcujBk9OAC79K2+IoSHM=;
 b=ltIVypAIUZDdqL8ANLsob0yROPjbcYeR2hBoCtm/j4kfxs6hgEhKhJW1LKrj8uWbxH+ATc
 CEZ21PNJ3rcdC/x9j6mCDOd+bPczxA2v1aenyZFdxebbsKuwGogtvKhoPl8hF1HSvunaRlNN
 BgaKO2uJtmpGIEHE1Nb7VgTj1CImoETaaH1du7AmF64apZq/4k80kp6aUmO4K6uuiitnzJrm
 5G9Iml1F2AsChyt15PpPqMK+pDpqvBn7YptRfgLUceIpsy88NPJc/5ZFgy88mShzVzI/yKME
 gfMr+zvAB7bz7YlQJO8+dTEKFX0iVWaf+MYcSSSyZ2ezimVvvfY68kMg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next v2 0/2] dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration
Date: Tue, 16 Dec 2025 13:16:59 +0100
Message-ID: <20251216121705.65156-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Maxlinear GSW1xx switches offer slew rate configuration bits for R(G)MII
interface. The default state of the configuration bits is "normal", while
"slow" can be used to reduce the radiated emissions. Add the support for
the latter option into the driver as well as the new DT bindings.

Changelog:
v2:
- do not hijack gsw1xx_phylink_mac_select_pcs() for configuring the port,
  introduce struct gswip_hw_info::port_setup callback
- actively configure "normal" slew rate (if the new DT property is missing)
- properly use regmap_set_bits() (v1 had reg and value mixed up)
v1:
- https://lore.kernel.org/all/20251212204557.2082890-1-alexander.sverdlin@siemens.com/

Alexander Sverdlin (2):
  dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
  net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration

 .../bindings/net/dsa/lantiq,gswip.yaml        |  5 ++++
 drivers/net/dsa/lantiq/lantiq_gswip.h         |  1 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  |  6 +++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 26 +++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |  2 ++
 5 files changed, 40 insertions(+)

-- 
2.52.0


