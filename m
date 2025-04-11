Return-Path: <netdev+bounces-181503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2936A853EF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D01B85009
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96627CCCD;
	Fri, 11 Apr 2025 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f1al4Xug"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA323A9;
	Fri, 11 Apr 2025 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351788; cv=none; b=VRa4bjEEE7ZZB08oVJUhFqy+UjQBYzeFjkZIgWF6Rqwh2xhrS6/Fn3FMHxyvhLNWrBVW8qiPP3iRcNTgGVAicsRBBHV4O7I+tB3reXYOc0JfgsoLAml4hdFgH7WiQ/G2/biMLMJn3ipXJhXI8GFloSAWeKau8GUcywTRu3RHMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351788; c=relaxed/simple;
	bh=dxZuWXoiPaMW9f2tmEql6gPJyEr0b1C2tOzOi5GxOnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjD743vt5frYTGIOU5ZFVyN5cVUXVBhpwA58TiL50Pt54Gd+Ouj4oWEnBSj2rYZg4/NgbRD0QZAUuEBehSmG6hJsq0GawbQNoeectR/HpPjXbjZd6OZOWC3uSi1AA3lsXTIl+KLK2OK8qW/jvOx0ujeEz1uFv2/8ExTUuWITAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f1al4Xug; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53B69WLW1991990
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 01:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744351772;
	bh=zrx9fTvidzMHg5rKXmJJDzm+O68SCoI7cvY18Dkdu+g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=f1al4XugidQdDKyXUVMIN8hWprGXmICaPfHG6IiPix0D6kcHKGFAGaVqJ6WvKtSXw
	 EbTExKZUDq1xv/wZM5vDPHKy9QWeSQDg6DNQhCPbGtsYIrxqDUz2G+LI1w4+DVoPVq
	 VXEkeEvt1ZUazdXNR9+J5ELdWXnTP1np20RuI1Ws=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53B69VVQ049863
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 01:09:31 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 01:09:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 01:09:31 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53B69IA1065579;
	Fri, 11 Apr 2025 01:09:27 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net-next 2/2] dt-bindings: net: ti: k3-am654-cpsw-nuss: evaluate fixed-link property
Date: Fri, 11 Apr 2025 11:39:17 +0530
Message-ID: <20250411060917.633769-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411060917.633769-1-s-vadapalli@ti.com>
References: <20250411060917.633769-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Since the fixed-link (phyless) mode of operation is supported by the
CPSW MAC, include "fixed-link" in the set of properties to be evaluated.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index b11894fbaec4..7b3d948f187d 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -143,6 +143,8 @@ properties:
           label:
             description: label associated with this port
 
+          fixed-link: true
+
           ti,mac-only:
             $ref: /schemas/types.yaml#/definitions/flag
             description:
-- 
2.34.1


