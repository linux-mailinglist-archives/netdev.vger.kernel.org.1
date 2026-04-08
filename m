Return-Path: <netdev+bounces-276432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DnCATAu1mkUBggAu9opvQ
	(envelope-from <netdev+bounces-276432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:30:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DC63BA886
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120AF306E80D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D83B9DB3;
	Wed,  8 Apr 2026 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRIFiT+J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90393B530D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644072; cv=none; b=oak6IYFnTloQsA32R8oDNKotE3vy9PEukYTcDm9GQsWPf6vV+HQ49LvV9zCo2wxqiykCPRkCOTErMLcS3MIh4cxZ1E/fiZuVc/TXWkV0mDPKCp3XpjiEW8yXG4UAiDTPHKkdbCx4h4JiToc6E7CA1x8jx86W/CJtppA/A0BPYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644072; c=relaxed/simple;
	bh=rYFaKlm47XGDdmElQrjmAd4dEqAY64/d73G/0THZP/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQpAF18Tbw1V2XL/8rxoyzKdwZL9IeBiieYZcYJx2jZrFCgViMGnzcew//cAmj7mHei8Gds5f++hqePuN3KfcVjQcT8Ek9+9k1iNqtEMkXfM4lxzl3lPXhiRmarFVCJ++yI74oQxgAj+v+5ttxUxbZxL7jMtyNurpvz2sh1JI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRIFiT+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775644068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2meoUMW6Isodhk0QRxOP3Crjo4iEDn0NWCpeMg1w0m8=;
	b=eRIFiT+JbZ+grRanJC8R0LPvXEAHMCZdLsoJI7yDABxhX9RSZzNn0FJGjw5E3ZkYxeFEBt
	XsJTQoiyJfFJjevS/cBJelsJKgoWVGRgmL1yLI+wvr820nL5gVyYJtDDI3vJnTsTIe7tme
	HNKP0B30FTiFYF5gJoxE52RL+e0HP+I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-DduYxFtaMF20B0pL1YadxA-1; Wed,
 08 Apr 2026 06:27:42 -0400
X-MC-Unique: DduYxFtaMF20B0pL1YadxA-1
X-Mimecast-MFC-AGG-ID: DduYxFtaMF20B0pL1YadxA_1775644060
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58B551800344;
	Wed,  8 Apr 2026 10:27:40 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.188])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E695300019F;
	Wed,  8 Apr 2026 10:27:35 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next v3 4/5] dt-bindings: dpll: add ref-sync-sources property
Date: Wed,  8 Apr 2026 12:27:15 +0200
Message-ID: <20260408102716.443099-5-ivecera@redhat.com>
In-Reply-To: <20260408102716.443099-1-ivecera@redhat.com>
References: <20260408102716.443099-1-ivecera@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276432-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,0.0.0.0:email,0.0.0.1:email]
X-Rspamd-Queue-Id: 70DC63BA886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ref-sync-sources phandle-array property to the dpll-pin schema
allowing board designers to declare which input pins can serve as
sync sources in a Reference-Sync pair.  A Ref-Sync pair consists of
a clock reference and a low-frequency sync signal where the DPLL locks
to the clock but phase-aligns to the sync reference.

Update both examples in the Microchip ZL3073x binding to demonstrate
the new property with a 1 PPS sync source paired to a clock source.

Reviewed-by: Petr Oros <poros@redhat.com>
Reviewed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../devicetree/bindings/dpll/dpll-pin.yaml    | 13 ++++++++
 .../bindings/dpll/microchip,zl30731.yaml      | 30 ++++++++++++++-----
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
index 51db93b77306f..1287a472f08fa 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
@@ -36,6 +36,19 @@ properties:
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
+    items:
+      maxItems: 1
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


