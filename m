Return-Path: <netdev+bounces-249798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E37D1E367
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE8AE300A79A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D85393DED;
	Wed, 14 Jan 2026 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="LzIDAseC"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF8392C4D
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387579; cv=none; b=JG7fzpWaA+yd2XMI/qSR/4dk2z4t4ZD3vA6FAsEbX23sVhxtR1mWjRXnUNjQ+v98d8Ad8LifCcBlTIXqg+E0QN0J7eEGGTkaOCkRAcxFUDFtNDihKoAunfEO+AtOXhGU3BOG0M3rEA59mm9KRQM/du1Gr3TLTlFzm2GDX+skVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387579; c=relaxed/simple;
	bh=D+e3z0jwwSJ/jjSIelEwRyJu/mea3WE63qX44iBS6wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2gPFCASOVAyX1NMr1mHTNFPg+0GPEiC0oXdAodkQBLjjrVtlE2L4r1QjjZPlJPr35ALSR3+IHVGVbX9rOLB5zlY7R+PK1jc40vbw8oub8QMSRtNytqghsRwccr/ivDVWhaaE5FquZM4X4/bukO1iZfdL2Kd3AMYfTkmrC1Ciwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=LzIDAseC; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260114104603084ccb8d4000020786
        for <netdev@vger.kernel.org>;
        Wed, 14 Jan 2026 11:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Hsk9giDZ3rzrNEZl642AzZnZlbepHrpP8Fn7XrRdciU=;
 b=LzIDAseCuMMfV+6Uhs541ZX5a8pa5dz6Nn4ssTJDd2T39uqWbugy7c+l56J+N+MfL780Lt
 SQXyGU6+sd0Jce+0z992jaPnIUa40Ae03iweg64Yl7A5Ip5XQZdk992RqLnaLQZd5IEfKn2v
 4PcT5DdVx7rA4oI8Hc0LAkCav0stLwRmCNUghDpVSDb2UsXnUHvC83lZzBMKYYNMBGEGe/g6
 EPpS/LxQdHgZKLPj+Q5l2g6uDYOWGkQLguCL/Ch4+wWUqzpsXRgRdU0kLTawQbCWWCw7qtbN
 rb29G9UBSxNAfgwRJVAwEl6TKRiQQ7qF/LIJMS6Ip8GsF1pHurKYaigw==;
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
Subject: [PATCH net-next v5 0/2] dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration
Date: Wed, 14 Jan 2026 11:45:02 +0100
Message-ID: <20260114104509.618984-1-alexander.sverdlin@siemens.com>
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
v5:
- improved options' descriptions on Rob's suggestions
v4:
- separate properties for TXD and TXC pads
- https://lore.kernel.org/all/20260107090019.2257867-1-alexander.sverdlin@siemens.com/
v3:
- use [pinctrl] standard "slew-rate" property as suggested by Rob
  https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
- better sorted struct gswip_hw_info initialisers as suggested by Daniel
- https://lore.kernel.org/all/20260105175320.2141753-1-alexander.sverdlin@siemens.com/
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

 .../bindings/net/dsa/lantiq,gswip.yaml        | 22 ++++++++++
 drivers/net/dsa/lantiq/lantiq_gswip.h         |  1 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  |  6 +++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 40 +++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |  2 +
 5 files changed, 71 insertions(+)

-- 
2.52.0


