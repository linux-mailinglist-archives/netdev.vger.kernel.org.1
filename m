Return-Path: <netdev+bounces-271705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id b2C7HPk5xGlsxgQAu9opvQ
	(envelope-from <netdev+bounces-271705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:39:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 081A132B571
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F7C9301BDE7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313AB346ADC;
	Wed, 25 Mar 2026 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h65mXx0A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574F346774
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467575; cv=none; b=q/K3NwNnTmbHoGFW6c6MnrZse1Z5Pr/BbcIPvz6kvXQSa0kK6ZqphEPrQXVCyVZXFiWBJG8Nlndaw2zLFPzBrhf7/NOgEjwLs3ykVAwoEb4y+UXPyOFnMZsOtXavULUYwpX21grQ6RocJlKMyr/HZT2aaBdNFufn4os813vzxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467575; c=relaxed/simple;
	bh=Lw5FWm9bpNH4RVjPd2+H5CvNX9j41gLuyeNk4y0uL1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YExFSpmcY8cm8PSdhG2dAxJl9Ymre0iLt6GTQDlLnRoBSpE+9l4+pMo787OvqLIwiTtho6lr/i7dylHqJZ1o2oXlOgP7iJrIIiFKtc5Zf5jA7mpXB0o0LvU1CXnuwYUfhTiJzEeFm+EFNDYR+jKFC7iG3CUNAlZMEWgMnMzY3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h65mXx0A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774467572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5GESph4X6iX7AMmPOWj2uQ8opjfaPxbiqOMrrOZgqo=;
	b=h65mXx0A58F8pOyg9O/oLvKHfXLxwIt6Ec2jogdwskKED69obttRs3QdiJ2DPGRStDkc30
	Azm5qsRMH888fCl2oNKqABW8jYHKryfNG5qF7bnhyxTWAZZdN/4C4u/pLtTQzjWXYHaCPE
	wTxmuNcBKcBRJades4VaPP8pYbhV/38=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-QpQOGRGGN8q-wS4PtFlFng-1; Wed,
 25 Mar 2026 15:39:28 -0400
X-MC-Unique: QpQOGRGGN8q-wS4PtFlFng-1
X-Mimecast-MFC-AGG-ID: QpQOGRGGN8q-wS4PtFlFng_1774467566
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D9211955DDB;
	Wed, 25 Mar 2026 19:39:26 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.254])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9607A3000223;
	Wed, 25 Mar 2026 19:39:21 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] dpll: add actual frequency monitoring to netlink spec
Date: Wed, 25 Mar 2026 20:39:12 +0100
Message-ID: <20260325193914.124898-2-ivecera@redhat.com>
In-Reply-To: <20260325193914.124898-1-ivecera@redhat.com>
References: <20260325193914.124898-1-ivecera@redhat.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,microchip.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-271705-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 081A132B571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add DPLL_A_FREQUENCY_MONITOR device attribute to allow control over
the frequency monitor feature. The attribute uses the existing
dpll_feature_state enum (enable/disable) and is present in both
device-get reply and device-set request.

Add DPLL_A_PIN_ACTUAL_FREQUENCY pin attribute to expose the measured
input frequency in Hz. The attribute is present in the pin-get reply.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst     | 18 ++++++++++++++++++
 Documentation/netlink/specs/dpll.yaml | 17 +++++++++++++++++
 drivers/dpll/dpll_nl.c                |  5 +++--
 include/uapi/linux/dpll.h             |  2 ++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 83118c728ed90..5634111e651df 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -250,6 +250,22 @@ in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.
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
+returned in the ``DPLL_A_PIN_ACTUAL_FREQUENCY`` attribute.
+
+  =============================== ========================
+  ``DPLL_A_FREQUENCY_MONITOR``    attr state of a feature
+  =============================== ========================
+
 Embedded SYNC
 =============
 
@@ -411,6 +427,8 @@ according to attribute purpose.
       ``DPLL_A_PIN_STATE``             attr state of pin on the parent
                                        pin
     ``DPLL_A_PIN_CAPABILITIES``        attr bitmask of pin capabilities
+    ``DPLL_A_PIN_ACTUAL_FREQUENCY``    attr measured actual frequency of
+                                       an input pin in Hz
   ==================================== ==================================
 
   ==================================== =================================
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 3dd48a32f7837..84ccc686db4dd 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -319,6 +319,13 @@ attribute-sets:
         name: phase-offset-avg-factor
         type: u32
         doc: Averaging factor applied to calculation of reported phase offset.
+      -
+        name: frequency-monitor
+        type: u32
+        enum: feature-state
+        doc: Receive or request state of frequency monitor feature.
+          If enabled, dpll device shall monitor all currently available
+          inputs for their actual (measured) input frequency.
   -
     name: pin
     enum-name: dpll_a_pin
@@ -456,6 +463,13 @@ attribute-sets:
           Value is in PPT (parts per trillion, 10^-12).
           Note: This attribute provides higher resolution than the standard
           fractional-frequency-offset (which is in PPM).
+      -
+        name: actual-frequency
+        type: u64
+        doc: |
+          The actual (measured) frequency of the input pin in Hz.
+          This is the actual frequency being received on the pin,
+          as measured by the dpll device hardware.
 
   -
     name: pin-parent-device
@@ -544,6 +558,7 @@ operations:
             - type
             - phase-offset-monitor
             - phase-offset-avg-factor
+            - frequency-monitor
 
       dump:
         reply: *dev-attrs
@@ -563,6 +578,7 @@ operations:
             - mode
             - phase-offset-monitor
             - phase-offset-avg-factor
+            - frequency-monitor
     -
       name: device-create-ntf
       doc: Notification about device appearing
@@ -643,6 +659,7 @@ operations:
             - esync-frequency-supported
             - esync-pulse
             - reference-sync
+            - actual-frequency
 
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
index de0005f28e5c5..f7be0b4c123e9 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -218,6 +218,7 @@ enum dpll_a {
 	DPLL_A_CLOCK_QUALITY_LEVEL,
 	DPLL_A_PHASE_OFFSET_MONITOR,
 	DPLL_A_PHASE_OFFSET_AVG_FACTOR,
+	DPLL_A_FREQUENCY_MONITOR,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
@@ -254,6 +255,7 @@ enum dpll_a_pin {
 	DPLL_A_PIN_REFERENCE_SYNC,
 	DPLL_A_PIN_PHASE_ADJUST_GRAN,
 	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
+	DPLL_A_PIN_ACTUAL_FREQUENCY,
 
 	__DPLL_A_PIN_MAX,
 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
-- 
2.52.0


