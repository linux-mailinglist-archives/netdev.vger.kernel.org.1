Return-Path: <netdev+bounces-207977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A48B092E6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2F45A4DB7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11782FE31B;
	Thu, 17 Jul 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtEaWq3c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD92FD89D
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772280; cv=none; b=KVqORls2Jbd6UoZJPdyqPSfjctOAS85cRpHJTGwcvKKbV1X85DIfkZ6g2/AXe0UWkUztgDrB5hBO6/6acF1gpDg2I7od0M6aEF+BerESsZjOzNpeX3s3nOw6P+9aKmKSLi932kPwezWQdWeECltzQ2+HTKu0Qnv8flFyRH6D3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772280; c=relaxed/simple;
	bh=8qCq9OayXSySDMcO9kUVXO5iWHFCPIYqWEidFWXyRJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jd/b928QB1+JKYfyXu922rM2mn94hrfN3JS1PNEjoE0hjqUEp463QZk2xMAkvYqajjglPUUMWE/YDtaGS0MCb8KHxcJOg7VC8WqfiOWIFNtbz0yZYMAkM0KESCaFfbBet4L8j1h2MrDjKqp4zLOY1bstLnRv6c+vhA6r96UQkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtEaWq3c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752772278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xagYrAR0OP8mWYVE7CNmGAY9Ju20MBtsOAnBb9IfOoE=;
	b=ZtEaWq3c6oFHRaxquIst+hjZI0N9q/jE7UsMRAq/iWcvU8BoTSydnEWh7AElaRZT+D0PoL
	JBFZ4yhSKwQjk4Yul8HA3D46LSPqSiZ7o14yVCoMTNL6Kw9zrkuYi4S/mtVkt3PjAfhrDz
	15obzWB0vTGbrOsofuGRxQLWP9+w3+s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-p6SJ0MBHP4GRtDfmFaGs4w-1; Thu,
 17 Jul 2025 13:11:14 -0400
X-MC-Unique: p6SJ0MBHP4GRtDfmFaGs4w-1
X-Mimecast-MFC-AGG-ID: p6SJ0MBHP4GRtDfmFaGs4w_1752772273
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8955118088B4;
	Thu, 17 Jul 2025 17:11:09 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.34.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CD1F195609D;
	Thu, 17 Jul 2025 17:11:05 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 1/2] dt-bindings: dpll: Add clock ID property
Date: Thu, 17 Jul 2025 19:10:59 +0200
Message-ID: <20250717171100.2245998-2-ivecera@redhat.com>
In-Reply-To: <20250717171100.2245998-1-ivecera@redhat.com>
References: <20250717171100.2245998-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add property to specify the ID of the clock that the DPLL device
drives. The ID value represents Unique Clock Identified (EUI-64)
defined by IEEE 1588 standard.

The property is not mandatory because some DPLL devices can have
an ability to read this from HW. The situation is very similar
to network controllers without assigned MAC address.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/devicetree/bindings/dpll/dpll-device.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
index fb8d7a9a3693f..8e4ffe8ca279c 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
@@ -27,6 +27,11 @@ properties:
   "#size-cells":
     const: 0
 
+  clock-id:
+    description: Specifies ID of the clock that the DPLL device drives
+    $ref: /schemas/types.yaml#/definitions/uint64
+    minimum: 1
+
   dpll-types:
     description: List of DPLL channel types, one per DPLL instance.
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-- 
2.49.1


