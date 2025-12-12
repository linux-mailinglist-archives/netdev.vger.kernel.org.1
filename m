Return-Path: <netdev+bounces-244563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B138CB9D59
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 21:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1C8030607DD
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D50310635;
	Fri, 12 Dec 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="CIFquPs9"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CB314A7B
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572981; cv=none; b=LmCDBBeYMTOutpBZSHI+hbypcy9rdQAcE3h4yeQV9V6ZTzYx2P5p7KyQFsFC8YU4IGc5rQgq541b/J0eTVasCNwmlMdM6OjHpNs+0jcSIR9OwJ3BrqHT1eM/f/ySeogGGp5djvON0rDbbN/l0HasFh5mktcwuOS2u+6+sFOX0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572981; c=relaxed/simple;
	bh=aauJs1J/Gkh6roPnBtH5sB4pnrQTI9lCh4Ou19IFhWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIybbqD5S+O+p+X8WOqsD1GpDA5ZVebBeoD1S/c+4BoVajC7hhjZePFCpMD1PLmlNpXsWqL+2KSTl9ADwRMUmZlDf32fUXNpc0QycTgEjc8g4dzEKNdOq/IDhdPFoXtKdd31Tad66aSEMutdPJW2xQh2VgNgny5rD9ACwaZ/ITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=CIFquPs9; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202512122046049ee6ff3f7000020703
        for <netdev@vger.kernel.org>;
        Fri, 12 Dec 2025 21:46:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=jkKRNu8RePBTzLRlHwShxXUlHdolGq1GO4F41VgDmFU=;
 b=CIFquPs93Lz2rmW0h1/25BobRFozlevYo0Po+OAMN5x1plsaAKnOG953rr9pW7T0gULdFl
 AJrHubyUuGb06BaUP37JOdSEBdMm41MUM7NvLKiywESTPlKuroT7tWJebMw0xe9ezXv+zZk9
 9GO39GZhko7G5UqsBIxGZBoWJLzatxgpe0YJHdCjxzewaQ2QGN0obsvaqOoqS0Md3G1O9NpM
 i4xyt8iZz6LGJuoSw8SV9fAzzbbLJf2ZGwCkc0zUOI4pufFAY+XMWYsD8xGer5qifaq1T4gE
 A1/uawR2nmt3HiA8NxAT9c+jNNk8PIxjcA0lNJLeSvmiNaTzOS7M/3Bg==;
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
Subject: [PATCH net-next 0/2] dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration
Date: Fri, 12 Dec 2025 21:45:51 +0100
Message-ID: <20251212204557.2082890-1-alexander.sverdlin@siemens.com>
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

Alexander Sverdlin (2):
  dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
  net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration

 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 5 +++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c                         | 6 ++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h                         | 2 ++
 3 files changed, 13 insertions(+)

-- 
2.52.0


