Return-Path: <netdev+bounces-272750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFp9N/GMx2m+YwUAu9opvQ
	(envelope-from <netdev+bounces-272750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:10:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A93B34DC4B
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0F1330A3A7D
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6C36308A;
	Sat, 28 Mar 2026 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYCplL5n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B735F5E7
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774685216; cv=none; b=V33XUs1Y7YNJBrqR/Q0XcwQTgMfUv//3/x/zb5YU/m37iT4UEr1EkX06TXKUFbsn92xNwWlurK7pLHWpApDn2cfzCVQmC4J5P+0OtElHlhyH+l20uYr8giKZVAAeAj+B8ZzXqBK7K7wA99ObYi7uQIPjjM9Ps0HEK6+A5ppoYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774685216; c=relaxed/simple;
	bh=SvhyWW3tt3Ud0yWsd7T0BRbVeC5mUdW739kw/8bEoUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEpkg/zjxjviLl4myrPxIuK3AlppvA02qdFvhmj0KXHEih9liQ/pwCTosQ1UA3fTTRZk0BRWr8HQMHbV+WFBqaM81VVk4IF9XhVOw7yZL91WPlZfMGMbJy5sRlcLSsg/nLUba3CKhmE79SlB0VoL+Qyl/ohDkjJgpUBB/UogoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYCplL5n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774685214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpsyArjLv3rVabAfchF7KfNQHGCZv++NltOe2FfD/wU=;
	b=QYCplL5nnyJGYxqrs6azkWpdDqQ5wHH15DzHV7G8nrfFxnQRyKwcAuuGD21dnwJow7UCkw
	C2iHHZBruu4DN0Zz6u3+mXK+iAeZHwbrTgmKK2yPNE2HIUF9+ffZHAq8A9pVvXR+ONTSxG
	MXeF5vZlVlG3ndxRZxfQcWRqnAxXZr8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-bsaVJ61yP5qd2LFOeLvb6Q-1; Sat,
 28 Mar 2026 04:06:49 -0400
X-MC-Unique: bsaVJ61yP5qd2LFOeLvb6Q-1
X-Mimecast-MFC-AGG-ID: bsaVJ61yP5qd2LFOeLvb6Q_1774685208
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBE1218005B2;
	Sat, 28 Mar 2026 08:06:47 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE9011800351;
	Sat, 28 Mar 2026 08:06:43 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next v2 4/5] dt-bindings: dpll: add ref-sync-sources property
Date: Sat, 28 Mar 2026 09:06:23 +0100
Message-ID: <20260328080624.593916-5-ivecera@redhat.com>
In-Reply-To: <20260328080624.593916-1-ivecera@redhat.com>
References: <20260328080624.593916-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	TAGGED_FROM(0.00)[bounces-272750-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,microchip.com:email]
X-Rspamd-Queue-Id: 8A93B34DC4B
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


