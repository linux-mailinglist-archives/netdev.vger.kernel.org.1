Return-Path: <netdev+bounces-175952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9C4A680F1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191EA424237
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5020209F2A;
	Tue, 18 Mar 2025 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPkSk2Oz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECC250F8;
	Tue, 18 Mar 2025 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342371; cv=none; b=EetSm951KAC8+EkdX7FoYtLFEbCZ/pa9uyJPEybh4dQEQs8mH+9vpIjU6hxoxFazkjNGaXTl+PoIrxDAIlEq0OMeqeQOxqjIN10XdclCe+4Rn4DZWUvc61qimkNMc7DHcsS7mxZ9bljydsvUqtvp+hDWimJxpMWH9EkXrW/Btpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342371; c=relaxed/simple;
	bh=3PtKh13sIYCt1eK6SKMRDuOeadR5pjAA+a1NszLDiGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=srsKqI0ikkDgC2XLTC/ouCBQ96Q1FvT06+fHK47D2h9HMFGdzam66ArOB2iPEaoyppkp71jee9SFBI3rLpUuiOCkyhk88auINNBi2MRGM9SsTdgiIT+w+dxz/gPqMaZ6kxcgZe1QZWRHCb1fAeDInbUpv4rD3PGGg0E5xzoYTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPkSk2Oz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39143200ddaso3950626f8f.1;
        Tue, 18 Mar 2025 16:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742342368; x=1742947168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZjbTfL2Hj9AUEhnmLWjkxFCTyBrLV8FI1UiGduw1ng=;
        b=bPkSk2OzsC1oqjNMePGimKpBEQ7hOO1osydCVU2RqzVXNrt8HxbWqU2w5ck6RS3/Hb
         HsfzscZyq8SUzPTr1rgTcWdinKATKHxOxZvng5TH9iNLL/LoH2Xtqipb+42LqB/0ulW7
         44ronhjjUkdyQoqxSIXXjcMgZ0Uo4y2pP5N3bLP+BgJ6yjKUvZteWED+KVx1cFL+7sw1
         sp13hYh+U9KlmR3i/2q84hQAAbKhKz9+VGCRISHyFWAO+yCDHnNZmoMt/yIHb6LrOPTZ
         dnh7VXn9iz82pBidcxrWvP6qXQs5vtBkH6cIxZiae4unSqtSpi2J4NUe0PoxxbngQ6/v
         Ybkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342368; x=1742947168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZjbTfL2Hj9AUEhnmLWjkxFCTyBrLV8FI1UiGduw1ng=;
        b=cfWlISEte02OxU2OJ1JLg06LrbPhf+AaZociU4gFhMzNmjQDogqgBeVDqLxxN6/n8K
         NpAIw/c+URxHwh5uNMisYmL7ec3d8iK6PjpLX6bAK4EH1tFYxP5ti8CHUfvt068d95JT
         aRX3THRaWUlgQa67CkiBSSQw4eoi16Vljw8UKmYt+wJEDYWEBu1cUlAP2N+ZoBhpvbIi
         fWxx7TTyo7u71DTTdwN5NuncHuKh5J/m9X8qWHNTwCeRlohVr5kUD/SJazblXIS8EhOD
         X/r1oblPFz59AZugX0Y5atH1xRsRCIvxRw+gDGD8kGzqliTRua9vD1HwqM6XVgADV3Zl
         +SoA==
X-Forwarded-Encrypted: i=1; AJvYcCVbFPJicXEvFlgDd7Zf6ePLQz3rgcTdNUEN/RBN4Eg8VnezOqdOUbfyFQOspLN6krDHDqOvdrWd@vger.kernel.org, AJvYcCX9YnvIOq4HM2aFBMtjWKkzPtaMbfw/r3wZDDfeZ8uP3g8YoxR5gdnM2mwwcdjmrD3b5s+fqFZDiWI0@vger.kernel.org, AJvYcCXtMHoV7uFpDDUuKMGgAcGH/J9z41mEZF7LV2ClzjtQJ6MLH6mNVZCm+FoA7byUVeZheJgy/9uhzMb9lmbG@vger.kernel.org
X-Gm-Message-State: AOJu0YyffGLGjCZ/cWP+T/yUmi0B7IpBNGsy5AsG+B371VXaUJKaeeMc
	/BPjKgahWjbiqjofTKugpVpykm2qP4OnfDD3QilpL8FWjHXOXAGc
X-Gm-Gg: ASbGncuVFK6kcsHWcLplSfUWicinOKi4/ln4u/y9Gl6FjhPSPqyOkF7uFnbBAgu8+uo
	nn+VP/IhdXpjUXK+A8qIOpcQBk7lhojea7pX7jnphR7eOHq/LwijMux0qZFWF88GYKnZBRltNCN
	nw/eI85B7LW4AWgdfPVMpKsBFPx3F0vwtWr0ABIvtpElorZjsPkd3SKtINpC0g/rJC5m438HKGE
	m7ZQTOm2q+D9ajjNlRBF3TsfwYYyRuVNaagxf72Ezj204H7ZiEkKkP7DS5fGQ0AnkCSBqN6Y8Ih
	iceBf0kUeCMn9VeGbXY0V5Zs+tWALK9cykbooGrjzmrNkhi/7WQ9bkAOZuofYV8v9/tzDWxbfP1
	lSqg/HpYCeZfZ7aCrGhNTWxEA
X-Google-Smtp-Source: AGHT+IFK3EBw1ZYUKE9uEOQCOdl5tB6+diYT5Op28PMO59u02BarJ20ylLIC5oJ7rxyr7ZawsIpLUQ==
X-Received: by 2002:a5d:64a4:0:b0:397:3900:ef8c with SMTP id ffacd0b85a97d-39973b028c4mr751354f8f.35.1742342367967;
        Tue, 18 Mar 2025 16:59:27 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c83b748bsm19713268f8f.39.2025.03.18.16.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:59:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH 0/6] net: pcs: Introduce support for PCS OF
Date: Wed, 19 Mar 2025 00:58:36 +0100
Message-ID: <20250318235850.6411-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduce a most awaited feature that is correctly
provide PCS with OF without having to use specific export symbol.

The concept is to implement a producer-consumer API similar to other
subsystem like clock or PHY.

That seems to be the best solution to the problem as PCS driver needs
to be detached from phylink and implement a simple way to provide a
PCS while maintaining support for probe defer or driver removal.

To keep the implementation simple, the PCS driver devs needs some
collaboration to correctly implement this. This is O.K. as helper
to correctly implement this are provided hence it's really a matter
of following a pattern to correct follow removal of a PCS driver.

A PCS provider have to implement and call of_pcs_add_provider() in
probe function and define an xlate function to define how the PCS
should be provided based on the requested interface and phandle spec
defined in DT (based on the #pcs-cells)

of_pcs_get() is provided to provide a specific PCS declared in DT
an index.

A simple xlate function is provided for simple single PCS
implementation, of_pcs_simple_get.

A PCS provider on driver removal should first call
phylink_pcs_release() to release the PCS from phylink and then
delete itself as a provider with of_pcs_del_provider() helper.

A PCS declared with a PCS provider implementation can be used
by declaring in the MAC OPs the .mac_select_pcs with the helper
of_phylink_mac_select_pcs().

This helper will just try every phandle declared in "pcs-handle"
until one supported for the requested interface is found.

A user for this new implementation is provided as an Airoha PCS
driver. This was also tested downstream with the IPQ95xx QCOM SoC
and with the help of Daniel also on the various Mediatek MT7988
SoC with both SFP cage implementation and DSA attached.

Lots of tests were done with driver unbind/bind and with interface
up/down. It was initially used phylink_stop to handle PCS driver
removal, but it was then decided to use dev_close with
phylink_pcs_release() as it does better handle interface drop
and communicate more info to the user than leaving the interface
in a dangling state.

Christian Marangi (6):
  net: phylink: reset PCS-Phylink double reference on phylink_stop
  net: pcs: Implement OF support for PCS driver
  net: phylink: Correctly handle PCS probe defer from PCS provider
  dt-bindings: net: ethernet-controller: permit to define multiple PCS
  net: pcs: airoha: add PCS driver for Airoha SoC
  dt-bindings: net: pcs: Document support for Airoha Ethernet PCS

 .../bindings/net/ethernet-controller.yaml     |    2 -
 .../bindings/net/pcs/airoha,pcs.yaml          |  112 +
 drivers/net/pcs/Kconfig                       |   13 +
 drivers/net/pcs/Makefile                      |    2 +
 drivers/net/pcs/pcs-airoha.c                  | 2858 +++++++++++++++++
 drivers/net/pcs/pcs.c                         |  185 ++
 drivers/net/phy/phylink.c                     |   46 +-
 include/linux/pcs/pcs-airoha.h                |   11 +
 include/linux/pcs/pcs-provider.h              |   46 +
 include/linux/pcs/pcs.h                       |   62 +
 include/linux/phylink.h                       |    2 +
 11 files changed, 3336 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
 create mode 100644 drivers/net/pcs/pcs-airoha.c
 create mode 100644 drivers/net/pcs/pcs.c
 create mode 100644 include/linux/pcs/pcs-airoha.h
 create mode 100644 include/linux/pcs/pcs-provider.h
 create mode 100644 include/linux/pcs/pcs.h

-- 
2.48.1


