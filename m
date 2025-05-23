Return-Path: <netdev+bounces-193163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A90AC2B05
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DE2A402AB
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203A21E0A2;
	Fri, 23 May 2025 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EtWai+Rc"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB121D3CD
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032495; cv=none; b=P0vXfc8Gs4HfiOrgEBhTbUe2hTOiODORMdusiZDHkoJHfYC/bkh/5z/xnlSWUsdmB+4TlWDSy4j1PIELM+9yEnogF8GO4mLyuAWr2jQFt3WZXShis2vXhF/vwVVlhM5SQekGqXucr0J3bmx/NJiihHXJAqh/066zWCYlZqxJNyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032495; c=relaxed/simple;
	bh=73lc/rPP9eGUfkWT58IBLrpi8r/eruXKFdJ45xDIfH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pL0fypG8WNmTh6AHu56aP2NeGg27NHqQLRG2N3IcsP3Ys6WooVfhK1aZmLXyhiiUllMZadkaneMny2P2xmSxzdWWyEtdgMm7skG2C1ua0ULY6mROOVELC4M2pwoq3WbLaafvSClPnjLQ3uXHVh9Ln0WqzGk/vPdq+CLu7HA6CY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EtWai+Rc; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748032492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTViHUqHHL7FVcOYR+13mg8Z5ebv/l3Vzj9gh5nlRwU=;
	b=EtWai+RcQT0KQtCIhC9XQzd8sYMtaOQuqnbpn3v0YeOMOXcd58IQXG/99tGbwVPRpYPkfA
	seIRWDPPzRIY/oQhZlduiIosm85YbGT4e7MZB/df0N88aMqf/9RU0+hkV3W8zQLBO9wCBF
	E0zQa+watqjB+z2o3KQ8FISaCUlJ+sg=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Lei Wei <quic_leiwei@quicinc.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [net-next PATCH v5 10/10] of: property: Add device link support for PCS
Date: Fri, 23 May 2025 16:33:39 -0400
Message-Id: <20250523203339.1993685-11-sean.anderson@linux.dev>
In-Reply-To: <20250523203339.1993685-1-sean.anderson@linux.dev>
References: <20250523203339.1993685-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds device link support for PCS devices, providing
better probe ordering.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Saravana Kannan <saravanak@google.com>
---

(no changes since v2)

Changes in v2:
- Reorder pcs_handle to come before suffix props

 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index c1feb631e383..1aa28bfadb12 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1377,6 +1377,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller-cells")
 DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
+DEFINE_SIMPLE_PROP(pcs_handle, "pcs-handle", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1528,6 +1529,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_interrupt_map, },
 	{ .parse_prop = parse_access_controllers, },
+	{ .parse_prop = parse_pcs_handle, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.35.1.1320.gc452695387.dirty


