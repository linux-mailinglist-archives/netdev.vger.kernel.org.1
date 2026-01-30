Return-Path: <netdev+bounces-254961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 78cvHQYAfGmUJwIAu9opvQ
	(envelope-from <netdev+bounces-254961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:49:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD854B601C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFEDB3019CB9
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0182DF143;
	Fri, 30 Jan 2026 00:49:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54812D660E;
	Fri, 30 Jan 2026 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769734146; cv=none; b=pRu2vSQk6CU28JqxB2Y+40i625fQK7D93vICeLtH+um5g7MPzgK/8iy9ZnRutwLylLQ7LMQ8/jKMwhlpD7GYevOqRSSIzPENiOjGfZkU2m50meKthan867JAKAGtGxgdbPv3UCrnnq/tJ+UToIyBrSgk3+ULVzWmd+V/CtWsA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769734146; c=relaxed/simple;
	bh=AsHTU5gSelaVrEdl0uIYTTFhXmofZc6Br0krFbQxaPc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V/t1clOebCCS8zn/Oy2hvL9o6LdL5B7IKBg4y0i2LjZhOJecjVFdu15nY5VooV9+ZxOqh0lxX/pJkqRUtqwUI1n92bC/IuCfYvE7auOtwHoe2Wl72kRAOOCupBBNqr5xSEMV9VuPY+GRDWEhjWDSEBW7mxz2qMaPT3vspK3V0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vlch2-000000007qF-1Ifd;
	Fri, 30 Jan 2026 00:49:00 +0000
Date: Fri, 30 Jan 2026 00:48:57 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: dsa: mxl-gsw1xx: setup polarities and
 validate chip
Message-ID: <cover.1769733972.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD854B601C
X-Rspamd-Action: no action

Now that common PHY properties make it easy to configure the SerDes RX
and TX polarities, use that for the SGMII/1000Base-X/2500Base-X PCS of
the MaxLinear GSW1xx switches.

Also, validate hardware in probe() function to make sure the switch is
actually present and MDIO communication works properly.
---
Changes since initial submission:
 * use allOf to include phy-common-props in dt-schema
 * use phy_get_manual_rx_polarity and phy_get_manual_tx_polarity helpers
   instead of open-coding them

Daniel Golle (4):
  net: dsa: mxl-gsw1xx: setup polarities and validate chip
  dt-bindings: net: dsa: lantiq,gswip: reference common PHY properties
  net: dsa: mxl-gsw1xx: configure PCS polarities
  net: dsa: mxl-gsw1xx: validate chip ID

 .../bindings/net/dsa/lantiq,gswip.yaml        |  4 ++
 drivers/net/dsa/lantiq/Kconfig                |  1 +
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           | 61 +++++++++++++++----
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |  9 +++
 4 files changed, 64 insertions(+), 11 deletions(-)

-- 
2.52.0

