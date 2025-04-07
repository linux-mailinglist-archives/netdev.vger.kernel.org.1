Return-Path: <netdev+bounces-180008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D15A7F0EF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560B4189A5EF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B30225779;
	Mon,  7 Apr 2025 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tZmGBxwz"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA588229B28
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744068180; cv=none; b=FoltgRqgVMI9vE1Uucy9Ygpboi7x3kYY0piR5XDnJU2HKETlkASAqJp3VQlY7hk6htClVEUM3WYRl7ElMq+fH5zQf/3fHJSUhAL4+LqZVNQ8dWR2JP93IGHaYCulXmg/r0E236Wdn0tn49XB4snx3peOumwFcNouhvuPmUdARv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744068180; c=relaxed/simple;
	bh=qSsi2Z8oWBNlNKblbyEx0tozbbtH7BqcNKuDv/Xe36s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EH3z/Bn28B53fkoZ6SlTbHEsMrQHO8/N1DLh+orLAxPI2TgeATi+yRCpCTg7lQI/mVlN+fPVFNcUpKoqzIEKILEpFFxDbw6jajE0VFQGqWgWg7kWfdG/aNUqgRfSkPHubeniibai5/MLPmYFv6qFWxsOobhQxRjjeOUEb8JwxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tZmGBxwz; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744068176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhSfZle2DSr8dqq4HF0QoA56gpikuRobNOyQek6vcqI=;
	b=tZmGBxwziVLyqZoep9Yr4EZQGQV5GwvrcOH53EFBpvIEMMdoFxJTQ2yqRbqponGiN/LVzO
	6KZtf1/JWkuWkvriigBIVFaJjziw2XC5Yelr5sX7HRIgq6nq9cHYdJGQnV+OIBm9cejGoo
	miawXin2jM8+OruUkqAwm/PWyFolxJA=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	upstream@airoha.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [net-next PATCH v2 14/14] of: property: Add device link support for PCS
Date: Mon,  7 Apr 2025 19:22:49 -0400
Message-Id: <20250407232249.2317158-1-sean.anderson@linux.dev>
In-Reply-To: <20250407231746.2316518-1-sean.anderson@linux.dev>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
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
---

Changes in v2:
- Reorder pcs_handle to come before suffix props

 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index c41190e47111..86d9afcbfc70 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1373,6 +1373,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller-cells")
 DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
+DEFINE_SIMPLE_PROP(pcs_handle, "pcs-handle", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1524,6 +1525,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_interrupt_map, },
 	{ .parse_prop = parse_access_controllers, },
+	{ .parse_prop = parse_pcs_handle, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.35.1.1320.gc452695387.dirty


