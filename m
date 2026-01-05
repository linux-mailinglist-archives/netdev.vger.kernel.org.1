Return-Path: <netdev+bounces-247157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C48CF5232
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 161C6316E124
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93264341670;
	Mon,  5 Jan 2026 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="PaQCKdNn"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF133A03A
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635662; cv=none; b=EVryNxt3bHPWVqNvkb30gIn76y8AwIT9o7HzylnuoNCLFbLWO8JGmjnuqwsAdKn4e96QSTOr4uSRgvYSP5BI/oZsB3pl9HTdfm/E9iYzWnLycy49HpCZ8ctK/5EoiMBzp1+dpnPvJl9Q1VJFaQNikZ9It3EUZIidjnraGtpyeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635662; c=relaxed/simple;
	bh=rp6oMiltIBG5xzrwYgM7NxRGzmICVUFnI94Pv6EsBg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0zQ3PLKwG399PB74hqztRuWkSikqkLSFaHtjcZZVXejXQ5FIxKX/ULK0vJVTpPMtHiZh0aHUdJhTBApAFH5DtL4cZVJKBgBSVNBr4CxueLOxWAYSA1m6/z/hMjE+cUvBiAKhRweQnEjc+yWCaaMAz4kMxbIpwrgSkJN0KQ2iVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=PaQCKdNn; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260105175414f4e330c4c8000207e7
        for <netdev@vger.kernel.org>;
        Mon, 05 Jan 2026 18:54:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=78lJofstsjazXIljE1VwN40yDxLb/avzRgg48ql6ksw=;
 b=PaQCKdNnNbbNc6UG2NV7JdahCjMrsDyJQR63oKwvBlEAwc3V0T1m4sEeCpHT1xKO9naMJT
 5t6cYN4DAnn38f5al+XsRlvmxni14yIvmozi+gJaNCtZ2wwCKMhXvPlbUKR+3ZlbkJFxvp6Z
 1eRy5oBGYKyo6PkOX8mEc+FDaYGebU6xbv/2oi2BIIxXj5rPggWOX0pcQvxPvnCFV711Sy2Z
 RIe8xz4XXcBj7OLzC/Pcvunon31RK/+aY9DZj4nPYqL7oFCo4bwXsAjgVfB9cm2t9Hwk/CLP
 a6FPV3DfkaQHBrWr+lu9Iq77pdAkMsY5yT1b4NX/OdxQF4sMc6hoGAaQ==;
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
Subject: [PATCH net-next v3 0/2] dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration
Date: Mon,  5 Jan 2026 18:53:09 +0100
Message-ID: <20260105175320.2141753-1-alexander.sverdlin@siemens.com>
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
v3:
- use [pinctrl] standard "slew-rate" property as suggested by Rob
  https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
- better sorted struct gswip_hw_info initialisers as suggested by Daniel
v2:
- do not hijack gsw1xx_phylink_mac_select_pcs() for configuring the port,
  introduce struct gswip_hw_info::port_setup callback
- actively configure "normal" slew rate (if the new DT property is missing)
- properly use regmap_set_bits() (v1 had reg and value mixed up)
- https://lore.kernel.org/all/20251216121705.65156-1-alexander.sverdlin@siemens.com/
v1:
- https://lore.kernel.org/all/20251212204557.2082890-1-alexander.sverdlin@siemens.com/

Alexander Sverdlin (2):
  dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
  net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration

 .../bindings/net/dsa/lantiq,gswip.yaml        |  7 +++++
 drivers/net/dsa/lantiq/lantiq_gswip.h         |  1 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  |  6 ++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 31 +++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |  2 ++
 5 files changed, 47 insertions(+)

-- 
2.52.0


