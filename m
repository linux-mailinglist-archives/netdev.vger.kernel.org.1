Return-Path: <netdev+bounces-269589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJLCMfw5vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:01:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E52D0742
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4B9F32CDD44
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE3D3F54BA;
	Thu, 19 Mar 2026 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP6+Xiuf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F33F074A
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942543; cv=none; b=JUN3S4bwZffoVvXAt8mIS0yuZnHVlByiViqe5Vees5WfUnBahkwfim19fuwldJUDGt0gPnl6gUK02YEo96/SmR8KI3EaFiKOVhSEEzuxQMA9cgBGEsv6TLdIEErEQWDnNHb+5cVEPV+cAcG2skCLsoV25puEvAJ5gmosixGqPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942543; c=relaxed/simple;
	bh=VYpA0DQ8G9DeBFM/wAWmznKvooMNjsjpUnKlx2bZcCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+m8GUa6DVdkZF5fp9KyGKOChYbH8RXAfQ3xKJ7BmxVYNsZpRRl69r3/i9RqvNoxCaKTWvTBmutXK44YUuFMMO+RGBF43TSV9j8O/V/hMi/RC8NHJtfkP9HeWoJMU0bnyjoMN9SMGbYQUbsnkzFtzED1KYxJy8yy70QbgS1A3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP6+Xiuf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773942536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3OjAkiL/S+3p+HfwQkXwnxSsIlnuXX4GUVvffn+aHY=;
	b=VP6+XiufyUk0EFI58C55A2a7FdPx88FWWPbko/qeKPRKMytw2HbU0SQGMlcZRkpk7w8Z1s
	Mlraf1SPWx5671pBBieK2Bp9R7MBIm/PZcJV9DbaLpZF7s4HKlAiOAlsOh7B3AR7KAktNz
	qgbhfQyfr1oFSh4/aHBkzLlGy5n7AJk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-qdM941obPXSKZkKVZrcktw-1; Thu,
 19 Mar 2026 13:48:52 -0400
X-MC-Unique: qdM941obPXSKZkKVZrcktw-1
X-Mimecast-MFC-AGG-ID: qdM941obPXSKZkKVZrcktw_1773942529
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F08719560B5;
	Thu, 19 Mar 2026 17:48:49 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AE3D30001A1;
	Thu, 19 Mar 2026 17:48:45 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next 4/5] dt-bindings: dpll: add ref-sync-sources property
Date: Thu, 19 Mar 2026 18:48:25 +0100
Message-ID: <20260319174826.7623-5-ivecera@redhat.com>
In-Reply-To: <20260319174826.7623-1-ivecera@redhat.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269589-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.910];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,0.0.0.1:email]
X-Rspamd-Queue-Id: 5B2E52D0742
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ref-sync-sources phandle-array property to the dpll-pin schema
allowing board designers to declare which input pins can serve as
sync sources in a Reference-Sync pair.  A Ref-Sync pair consists of
a clock reference and a low-frequency sync signal where the DPLL locks
to the clock but phase-aligns to the sync reference.

Update both examples in the Microchip ZL3073x binding to demonstrate
the new property with a 1 PPS sync source paired to a clock source.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../devicetree/bindings/dpll/dpll-pin.yaml    | 11 +++++++
 .../bindings/dpll/microchip,zl30731.yaml      | 30 ++++++++++++++-----
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
index 51db93b77306f..7084f102e274c 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
@@ -36,6 +36,17 @@ properties:
     description: String exposed as the pin board label
     $ref: /schemas/types.yaml#/definitions/string
 
+  ref-sync-sources:
+    description: |
+      List of phandles to input pins that can serve as the sync source
+      in a Reference-Sync pair with this pin acting as the clock source.
+      A Ref-Sync pair consists of a clock reference and a low-frequency
+      sync signal.  The DPLL locks to the clock reference but
+      phase-aligns to the sync reference.
+      Only valid for input pins.  Each referenced pin must be a
+      different input pin on the same device.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
   supported-frequencies-hz:
     description: List of supported frequencies for this pin, expressed in Hz.
 
diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
index 17747f754b845..fa5a8f8e390cd 100644
--- a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
@@ -52,11 +52,19 @@ examples:
           #address-cells = <1>;
           #size-cells = <0>;
 
-          pin@0 { /* REF0P */
+          sync0: pin@0 { /* REF0P - 1 PPS sync source */
             reg = <0>;
             connection-type = "ext";
-            label = "Input 0";
-            supported-frequencies-hz = /bits/ 64 <1 1000>;
+            label = "SMA1";
+            supported-frequencies-hz = /bits/ 64 <1>;
+          };
+
+          pin@1 { /* REF0N - clock source, can pair with sync0 */
+            reg = <1>;
+            connection-type = "ext";
+            label = "SMA2";
+            supported-frequencies-hz = /bits/ 64 <10000 10000000>;
+            ref-sync-sources = <&sync0>;
           };
         };
 
@@ -90,11 +98,19 @@ examples:
           #address-cells = <1>;
           #size-cells = <0>;
 
-          pin@0 { /* REF0P */
+          sync1: pin@0 { /* REF0P - 1 PPS sync source */
             reg = <0>;
-            connection-type = "ext";
-            label = "Input 0";
-            supported-frequencies-hz = /bits/ 64 <1 1000>;
+            connection-type = "gnss";
+            label = "GNSS_1PPS_IN";
+            supported-frequencies-hz = /bits/ 64 <1>;
+          };
+
+          pin@1 { /* REF0N - clock source */
+            reg = <1>;
+            connection-type = "gnss";
+            label = "GNSS_10M_IN";
+            supported-frequencies-hz = /bits/ 64 <10000000>;
+            ref-sync-sources = <&sync1>;
           };
         };
 
-- 
2.52.0


