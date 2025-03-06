Return-Path: <netdev+bounces-172608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE2A5585D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EE2188E5A8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF2D207A03;
	Thu,  6 Mar 2025 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="YfspTFSe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C41311AC
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295403; cv=none; b=Snm7svBZt2gujqrW7/jQXBaIpXe3XWhhk2oY1www055Hi0xN9pRXXNjEAp4L0M6G/ZsiSxKvnmrY7PXlwNrvF0dTtxlbqNl6uv5ixaUnohf6+14pO4356Whsr/IAkCrefB9KK0rGKjJEtNfd4vqZKVofgFT/kTBIqCok72YL8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295403; c=relaxed/simple;
	bh=CqDwVU/7nprSiF8y5VrrWZurTCaefDs5QFxlc3Lmriw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eK1r+TGaFN8mgReLflUf+bzpGhREFlfOpub8lHzZ1HbuYZWhWsgkYVmaxubvtMjx1+Grl7YDNoPiI6MEgdZ4mOhGt/l6pwWNOg0VWreZHaPIdXDDh7o/CWeMIrkTeiLmcM6ia2nUmgjTHVNC7Nau68kgajG5dFWtml0z2WvPFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=YfspTFSe; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1741295401;
 bh=sDXS6ccmXHM7aVTn2W8PvKDj84puFXbx1PJBmmh83iE=;
 b=YfspTFSeIMHzRRto45DBpf8rkOu/8hLwCDbAUzwBCc5R8eCoeVdOpcsCH9c/w0BjndnoRXjMi
 05xcrTXCq3NE5HFzjISp91NnRXo+DyuqgEwwpa1HobxVyksvPaeYSZ2jnRUtXxEx0DK2I/hcDVs
 s1zyuKl+/+A1ebqB3OxveEpT4DAO1jCNJERQIuZOVG7vcL5Um6MO5vylmt57JYEth+nymHohlHl
 +N/7xnSRtKemjAQj0lAmkKLEQtvsHV0oNFxBQQjkpKCxePa+trsaWTl3Ln6E6RTqWrGrJWN/T05
 mTIgyAOz1trHyIcUsHKDJKcth5ZSpzYXcNRcHH+P/0AA==
X-Forward-Email-ID: 67ca0f24ad3e70e1cd99d7f2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] net: stmmac: dwmac-rk: Validate rockchip,grf and php-grf during probe
Date: Thu,  6 Mar 2025 21:09:44 +0000
Message-ID: <20250306210950.1686713-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Rockchip GMAC variants require writing to GRF to configure e.g.
interface mode and MAC rx/tx delay. The GRF syscon regmap is located
with help of a rockchip,grf and rockchip,php-grf phandle.

However, validating the rockchip,grf and rockchip,php-grf syscon regmap
is deferred until e.g. interface mode or speed is configured.

This series change to validate the rockchip,grf and rockchip,php-grf
syscon regmap at probe time to help simplify the SoC specific operations.

I do not expect that this will introduce any regression. Prior to this,
use of a device tree without a rockchip,grf would fail when interface
mode or speed is configured, with this use of such device tree would
instead result in failure at probe time.

Jonas Karlman (2):
  dt-bindings: net: rockchip-dwmac: Require rockchip,grf and
    rockchip,php-grf
  net: stmmac: dwmac-rk: Validate rockchip,grf and php-grf during probe

 .../bindings/net/rockchip-dwmac.yaml          |  17 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 269 ++----------------
 2 files changed, 32 insertions(+), 254 deletions(-)

-- 
2.48.1


