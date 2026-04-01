Return-Path: <netdev+bounces-273998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sESXHgnjzGmjXQYAu9opvQ
	(envelope-from <netdev+bounces-273998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:19:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C095737772C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09F0A30527F1
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7439DBE2;
	Wed,  1 Apr 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnRqwQ2q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832BB3A8746
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034780; cv=none; b=puy+8qoooS5bTOZVm5cfsUwnjgwlwzWiAY5w9mVPxTLdHgUs9K1sJRwKu50nKDVfqyZHRfHd+9K/4rXipUUZzjL2TM5FuNNiaKKNwRV5AaTeLAVvqBltWleIq3/lR/FhyVM6ra5eIU+h0vxvpDapRV4d+Ex+DZwltSXoT7PLc+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034780; c=relaxed/simple;
	bh=sHAcPFkyNdUQAvbRPH/GfSpL3BzTk6+FQRRwQBXtC9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMz+lpGZl4/H5px8djmGQ53Aw7LaWk9idho6cMjXxrNnThfoyLwjc3dCn2c7Jj0T1wt9DSduODe12q0pIgo/4NOiN8cRiILn5RiU0NANgEj4VRvaAq2jWx+C23wadsIN0xLbZUSUNbsCK+va4O9W+6IaMAqGVj2kIA4J62wDueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnRqwQ2q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775034777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdjC/Gl7/ya5ZhOcMWaMy9PpFWCT86jKefTGUojJ/zQ=;
	b=GnRqwQ2qDZrRzIuoZbEfNYVf7xHU7gQOcRt340jOIt1z1eIiHAx0OItxrI49evPf+3XPV1
	S7u+o28YgtwQOjqMuo0n/pXQXudhLOdq3orQb0Qd3GGuRyvt0p/1Q+0yod+9Hko/v0IIYc
	fFJbgkKhx33JBTFpgEg2X8LY887Uzlo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377--60d2waENkql_P-4X28cCA-1; Wed,
 01 Apr 2026 05:12:52 -0400
X-MC-Unique: -60d2waENkql_P-4X28cCA-1
X-Mimecast-MFC-AGG-ID: -60d2waENkql_P-4X28cCA_1775034770
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4936318002D7;
	Wed,  1 Apr 2026 09:12:50 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.175])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05D2B1955F2E;
	Wed,  1 Apr 2026 09:12:44 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/3] dpll: add frequency monitoring to netlink spec
Date: Wed,  1 Apr 2026 11:12:35 +0200
Message-ID: <20260401091237.1071995-2-ivecera@redhat.com>
In-Reply-To: <20260401091237.1071995-1-ivecera@redhat.com>
References: <20260401091237.1071995-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273998-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: C095737772C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add DPLL_A_FREQUENCY_MONITOR device attribute to allow control over
the frequency monitor feature. The attribute uses the existing
dpll_feature_state enum (enable/disable) and is present in both
device-get reply and device-set request.

Add DPLL_A_PIN_MEASURED_FREQUENCY pin attribute to expose the measured
input frequency in millihertz (mHz). The attribute is present in the
pin-get reply. Add DPLL_PIN_MEASURED_FREQUENCY_DIVIDER constant to
allow userspace to extract integer and fractional parts.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes v2 -> v3:
- Improved frequency-monitor doc wording (Jakub)
- Changed measured-frequency to mHz with divider constant (Jakub)

Changes v1 -> v2:
- Renamed actual-frequency to measured-frequency (Vadim)
---
 Documentation/driver-api/dpll.rst     | 20 +++++++++++++++
 Documentation/netlink/specs/dpll.yaml | 35 +++++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |  5 ++--
 include/uapi/linux/dpll.h             |  5 +++-
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 83118c728ed90..93c191b2d0898 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -250,6 +250,24 @@ in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.
   ``DPLL_A_PHASE_OFFSET_MONITOR`` attr state of a feature
   =============================== ========================
 
+Frequency monitor
+=================
+
+Some DPLL devices may offer the capability to measure the actual
+frequency of all available input pins. The attribute and current feature state
+shall be included in the response message of the ``DPLL_CMD_DEVICE_GET``
+command for supported DPLL devices. In such cases, users can also control
+the feature using the ``DPLL_CMD_DEVICE_SET`` command by setting the
+``enum dpll_feature_state`` values for the attribute.
+Once enabled the measured input frequency for each input pin shall be
+returned in the ``DPLL_A_PIN_MEASURED_FREQUENCY`` attribute. The value
+is in millihertz (mHz), using ``DPLL_PIN_MEASURED_FREQUENCY_DIVIDER``
+as the divider.
+
+  =============================== ========================
+  ``DPLL_A_FREQUENCY_MONITOR``    attr state of a feature
+  =============================== ========================
+
 Embedded SYNC
 =============
 
@@ -411,6 +429,8 @@ according to attribute purpose.
       ``DPLL_A_PIN_STATE``             attr state of pin on the parent
                                        pin
     ``DPLL_A_PIN_CAPABILITIES``        attr bitmask of pin capabilities
+    ``DPLL_A_PIN_MEASURED_FREQUENCY``  attr measured frequency of
+                                       an input pin in mHz
   ==================================== ==================================
 
   ==================================== =================================
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 3dd48a32f7837..40465a3d7fc20 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -240,6 +240,20 @@ definitions:
       integer part of a measured phase offset value.
       Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
       fractional part of a measured phase offset value.
+  -
+    type: const
+    name: pin-measured-frequency-divider
+    value: 1000
+    doc: |
+      pin measured frequency divider allows userspace to calculate
+      a value of measured input frequency as a fractional value with
+      three digit decimal precision (millihertz).
+      Value of (DPLL_A_PIN_MEASURED_FREQUENCY /
+      DPLL_PIN_MEASURED_FREQUENCY_DIVIDER) is an integer part of
+      a measured frequency value.
+      Value of (DPLL_A_PIN_MEASURED_FREQUENCY %
+      DPLL_PIN_MEASURED_FREQUENCY_DIVIDER) is a fractional part of
+      a measured frequency value.
   -
     type: enum
     name: feature-state
@@ -319,6 +333,13 @@ attribute-sets:
         name: phase-offset-avg-factor
         type: u32
         doc: Averaging factor applied to calculation of reported phase offset.
+      -
+        name: frequency-monitor
+        type: u32
+        enum: feature-state
+        doc: Current or desired state of the frequency monitor feature.
+          If enabled, dpll device shall measure all currently available
+          inputs for their actual input frequency.
   -
     name: pin
     enum-name: dpll_a_pin
@@ -456,6 +477,17 @@ attribute-sets:
           Value is in PPT (parts per trillion, 10^-12).
           Note: This attribute provides higher resolution than the standard
           fractional-frequency-offset (which is in PPM).
+      -
+        name: measured-frequency
+        type: u64
+        doc: |
+          The measured frequency of the input pin in millihertz (mHz).
+          Value of (DPLL_A_PIN_MEASURED_FREQUENCY /
+          DPLL_PIN_MEASURED_FREQUENCY_DIVIDER) is an integer part (Hz)
+          of a measured frequency value.
+          Value of (DPLL_A_PIN_MEASURED_FREQUENCY %
+          DPLL_PIN_MEASURED_FREQUENCY_DIVIDER) is a fractional part
+          of a measured frequency value.
 
   -
     name: pin-parent-device
@@ -544,6 +576,7 @@ operations:
             - type
             - phase-offset-monitor
             - phase-offset-avg-factor
+            - frequency-monitor
 
       dump:
         reply: *dev-attrs
@@ -563,6 +596,7 @@ operations:
             - mode
             - phase-offset-monitor
             - phase-offset-avg-factor
+            - frequency-monitor
     -
       name: device-create-ntf
       doc: Notification about device appearing
@@ -643,6 +677,7 @@ operations:
             - esync-frequency-supported
             - esync-pulse
             - reference-sync
+            - measured-frequency
 
       dump:
         request:
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index a2b22d4921142..1e652340a5d73 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -43,11 +43,12 @@ static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_ID + 1] = {
 };
 
 /* DPLL_CMD_DEVICE_SET - do */
-static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_PHASE_OFFSET_AVG_FACTOR + 1] = {
+static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_FREQUENCY_MONITOR + 1] = {
 	[DPLL_A_ID] = { .type = NLA_U32, },
 	[DPLL_A_MODE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
 	[DPLL_A_PHASE_OFFSET_MONITOR] = NLA_POLICY_MAX(NLA_U32, 1),
 	[DPLL_A_PHASE_OFFSET_AVG_FACTOR] = { .type = NLA_U32, },
+	[DPLL_A_FREQUENCY_MONITOR] = NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 /* DPLL_CMD_PIN_ID_GET - do */
@@ -115,7 +116,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.doit		= dpll_nl_device_set_doit,
 		.post_doit	= dpll_post_doit,
 		.policy		= dpll_device_set_nl_policy,
-		.maxattr	= DPLL_A_PHASE_OFFSET_AVG_FACTOR,
+		.maxattr	= DPLL_A_FREQUENCY_MONITOR,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index de0005f28e5c5..871685f7c353b 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -191,7 +191,8 @@ enum dpll_pin_capabilities {
 	DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE = 4,
 };
 
-#define DPLL_PHASE_OFFSET_DIVIDER	1000
+#define DPLL_PHASE_OFFSET_DIVIDER		1000
+#define DPLL_PIN_MEASURED_FREQUENCY_DIVIDER	1000
 
 /**
  * enum dpll_feature_state - Allow control (enable/disable) and status checking
@@ -218,6 +219,7 @@ enum dpll_a {
 	DPLL_A_CLOCK_QUALITY_LEVEL,
 	DPLL_A_PHASE_OFFSET_MONITOR,
 	DPLL_A_PHASE_OFFSET_AVG_FACTOR,
+	DPLL_A_FREQUENCY_MONITOR,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
@@ -254,6 +256,7 @@ enum dpll_a_pin {
 	DPLL_A_PIN_REFERENCE_SYNC,
 	DPLL_A_PIN_PHASE_ADJUST_GRAN,
 	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
+	DPLL_A_PIN_MEASURED_FREQUENCY,
 
 	__DPLL_A_PIN_MAX,
 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
-- 
2.52.0


