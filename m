Return-Path: <netdev+bounces-189836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034CDAB3D4A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F077464D9C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889222528E8;
	Mon, 12 May 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HKyTXr1q"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0425229E
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066468; cv=none; b=DUaJPUybzvtaj25Sba/Gko5H3Vd6siOYFGX/S4klWIm/MMK0xcVYFpc7FqqLVUSotBQpJre4WNYIGtc3COWaOAKn1g1CakF2LsUO2G0iSrBwBQGWLaj7jwGzcWEyPx1qSyCXTI/7n+mhy/mgL3DZNxd2WkLmoDvnAaHQyaNdrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066468; c=relaxed/simple;
	bh=73lc/rPP9eGUfkWT58IBLrpi8r/eruXKFdJ45xDIfH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dplYWnSdtsXwqR74ds0eYQI9BjURPMwL738j+AwYSSawr4CrQQSVUK9kVjBQKGa8toBgCdYdUynQJBkKKQphlV24aR6fHsevLMsebs37vgkFbRqkHIibLboLrxc+QL+DHWlTKQH+D030H4MZyQutPjs9+gKflihbmME+D1EDugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HKyTXr1q; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747066465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTViHUqHHL7FVcOYR+13mg8Z5ebv/l3Vzj9gh5nlRwU=;
	b=HKyTXr1qsKP5I8CyYwJayzHmnsFhy4IMShY6C65g8/nAef/NJDObTX0uBIXbbWHhfUHQIc
	gkHBEXGSpxTinglDFFzM2HbzW894ynyDYwQ+8i29/KWERPgBEXZD32aeEQzvjezASwxApj
	+t2/fCiyAL2GNjMTgIcRr7K/BtxOX0g=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: upstream@airoha.com,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [net-next PATCH v4 11/11] of: property: Add device link support for PCS
Date: Mon, 12 May 2025 12:14:15 -0400
Message-Id: <20250512161416.732239-3-sean.anderson@linux.dev>
In-Reply-To: <20250512161416.732239-1-sean.anderson@linux.dev>
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161416.732239-1-sean.anderson@linux.dev>
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


