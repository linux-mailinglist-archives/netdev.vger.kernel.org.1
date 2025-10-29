Return-Path: <netdev+bounces-234044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3EC1C0C3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D249E664C2D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675F31D754;
	Wed, 29 Oct 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhyHMoe4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224E336EC4
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751949; cv=none; b=SH5TXffr03QTdaLGJVOWjGen8QKGy7XhUifT1aB9wsrg69NG0xEU8NzSubmTY6ISVmM/qTt/J1I6kYaurb6qL/A1qmRd2cWgPCLOXNFdXByfY20H2lpq/pJJB/4Jc747yqzhfQ/L0bb5T4EeitpkL820lt1m5RSD2TSIp8VoIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751949; c=relaxed/simple;
	bh=sUcJaCOjvNTfbycbW9fncHYT+hoJnhL+w1JrFOj+hHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po3SK5PeJvmTvatQpyERmlW148ZnSgbqjgoE0JT5OFmRg28EaoMcPavow+rgRCY+YhVFbTWp8fic/jDnl9RqanwniKF1vgmlCE9rQCKvN7Hb1KJEp4gUqErnxoq1keGmvy744mDGJUdJxuYyEedPKsFhU8A2mXJoN7MPkekZYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhyHMoe4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761751945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dQGa3CFW4hFGsHrb/A8+pgnXptZBQDWHI/vCIt+uRE=;
	b=ZhyHMoe44lyQOFC2CAzwzqZeudUOsAFqKZ2BkwHob0mzQ+5nUnfJJwwaM+db0JJUIFL4A+
	buBk+3VC0ZZHXPF108tq0ckCZ6DnzZosY9i4jSthzT11oUOrdVu5pYGVhWTAUgBr4DjRep
	oduPwvmMEZUV1sCXm69PAIc23MHFE2w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-Hk4z_1dANlybBEX820sroQ-1; Wed,
 29 Oct 2025 11:32:22 -0400
X-MC-Unique: Hk4z_1dANlybBEX820sroQ-1
X-Mimecast-MFC-AGG-ID: Hk4z_1dANlybBEX820sroQ_1761751940
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E780819540E3;
	Wed, 29 Oct 2025 15:32:19 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.44.34.31])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 908F91800353;
	Wed, 29 Oct 2025 15:32:14 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] dpll: add phase-adjust-gran pin attribute
Date: Wed, 29 Oct 2025 16:32:06 +0100
Message-ID: <20251029153207.178448-2-ivecera@redhat.com>
In-Reply-To: <20251029153207.178448-1-ivecera@redhat.com>
References: <20251029153207.178448-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Phase-adjust values are currently limited by a min-max range. Some
hardware requires, for certain pin types, that values be multiples of
a specific granularity, as in the zl3073x driver.

Add a `phase-adjust-gran` pin attribute and an appropriate field in
dpll_pin_properties. If set by the driver, use its value to validate
user-provided phase-adjust values.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* changed type to u32 and added explicit cast to s32 during remainder
  computation (per Jiri's request)
---
 Documentation/driver-api/dpll.rst     | 36 +++++++++++++++------------
 Documentation/netlink/specs/dpll.yaml |  7 ++++++
 drivers/dpll/dpll_netlink.c           | 12 ++++++++-
 include/linux/dpll.h                  |  1 +
 include/uapi/linux/dpll.h             |  1 +
 5 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index be1fc643b645e..83118c728ed90 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -198,26 +198,28 @@ be requested with the same attribute with ``DPLL_CMD_DEVICE_SET`` command.
   ================================== ======================================
 
 Device may also provide ability to adjust a signal phase on a pin.
-If pin phase adjustment is supported, minimal and maximal values that pin
-handle shall be provide to the user on ``DPLL_CMD_PIN_GET`` respond
-with ``DPLL_A_PIN_PHASE_ADJUST_MIN`` and ``DPLL_A_PIN_PHASE_ADJUST_MAX``
+If pin phase adjustment is supported, minimal and maximal values and
+granularity that pin handle shall be provided to the user on
+``DPLL_CMD_PIN_GET`` respond with ``DPLL_A_PIN_PHASE_ADJUST_MIN``,
+``DPLL_A_PIN_PHASE_ADJUST_MAX`` and ``DPLL_A_PIN_PHASE_ADJUST_GRAN``
 attributes. Configured phase adjust value is provided with
 ``DPLL_A_PIN_PHASE_ADJUST`` attribute of a pin, and value change can be
 requested with the same attribute with ``DPLL_CMD_PIN_SET`` command.
 
-  =============================== ======================================
-  ``DPLL_A_PIN_ID``               configured pin id
-  ``DPLL_A_PIN_PHASE_ADJUST_MIN`` attr minimum value of phase adjustment
-  ``DPLL_A_PIN_PHASE_ADJUST_MAX`` attr maximum value of phase adjustment
-  ``DPLL_A_PIN_PHASE_ADJUST``     attr configured value of phase
-                                  adjustment on parent dpll device
-  ``DPLL_A_PIN_PARENT_DEVICE``    nested attribute for requesting
-                                  configuration on given parent dpll
-                                  device
-    ``DPLL_A_PIN_PARENT_ID``      parent dpll device id
-    ``DPLL_A_PIN_PHASE_OFFSET``   attr measured phase difference
-                                  between a pin and parent dpll device
-  =============================== ======================================
+  ================================ ==========================================
+  ``DPLL_A_PIN_ID``                configured pin id
+  ``DPLL_A_PIN_PHASE_ADJUST_GRAN`` attr granularity of phase adjustment value
+  ``DPLL_A_PIN_PHASE_ADJUST_MIN``  attr minimum value of phase adjustment
+  ``DPLL_A_PIN_PHASE_ADJUST_MAX``  attr maximum value of phase adjustment
+  ``DPLL_A_PIN_PHASE_ADJUST``      attr configured value of phase
+                                   adjustment on parent dpll device
+  ``DPLL_A_PIN_PARENT_DEVICE``     nested attribute for requesting
+                                   configuration on given parent dpll
+                                   device
+    ``DPLL_A_PIN_PARENT_ID``       parent dpll device id
+    ``DPLL_A_PIN_PHASE_OFFSET``    attr measured phase difference
+                                   between a pin and parent dpll device
+  ================================ ==========================================
 
 All phase related values are provided in pico seconds, which represents
 time difference between signals phase. The negative value means that
@@ -384,6 +386,8 @@ according to attribute purpose.
                                        frequencies
       ``DPLL_A_PIN_ANY_FREQUENCY_MIN`` attr minimum value of frequency
       ``DPLL_A_PIN_ANY_FREQUENCY_MAX`` attr maximum value of frequency
+    ``DPLL_A_PIN_PHASE_ADJUST_GRAN``   attr granularity of phase
+                                       adjustment value
     ``DPLL_A_PIN_PHASE_ADJUST_MIN``    attr minimum value of phase
                                        adjustment
     ``DPLL_A_PIN_PHASE_ADJUST_MAX``    attr maximum value of phase
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index cafb4ec20447e..4e5f0b7c41492 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -440,6 +440,12 @@ attribute-sets:
         doc: |
           Capable pin provides list of pins that can be bound to create a
           reference-sync pin pair.
+      -
+        name: phase-adjust-gran
+        type: u32
+        doc: |
+          Granularity of phase adjustment, in picoseconds. The value of
+          phase adjustment must be a multiple of this granularity.
 
   -
     name: pin-parent-device
@@ -614,6 +620,7 @@ operations:
             - capabilities
             - parent-device
             - parent-pin
+            - phase-adjust-gran
             - phase-adjust-min
             - phase-adjust-max
             - phase-adjust
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 74c1f0ca95f24..017999beccba8 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -637,6 +637,10 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	ret = dpll_msg_add_pin_freq(msg, pin, ref, extack);
 	if (ret)
 		return ret;
+	if (prop->phase_gran &&
+	    nla_put_u32(msg, DPLL_A_PIN_PHASE_ADJUST_GRAN,
+			prop->phase_gran))
+		return -EMSGSIZE;
 	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MIN,
 			prop->phase_range.min))
 		return -EMSGSIZE;
@@ -1261,7 +1265,13 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 	if (phase_adj > pin->prop.phase_range.max ||
 	    phase_adj < pin->prop.phase_range.min) {
 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
-				    "phase adjust value not supported");
+				    "phase adjust value of out range");
+		return -EINVAL;
+	}
+	if (pin->prop.phase_gran && phase_adj % (s32)pin->prop.phase_gran) {
+		NL_SET_ERR_MSG_ATTR_FMT(extack, phase_adj_attr,
+					"phase adjust value not multiple of %u",
+					pin->prop.phase_gran);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 25be745bf41f1..562f520b23c27 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -163,6 +163,7 @@ struct dpll_pin_properties {
 	u32 freq_supported_num;
 	struct dpll_pin_frequency *freq_supported;
 	struct dpll_pin_phase_adjust_range phase_range;
+	u32 phase_gran;
 };
 
 #if IS_ENABLED(CONFIG_DPLL)
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index ab1725a954d74..69d35570ac4f1 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -251,6 +251,7 @@ enum dpll_a_pin {
 	DPLL_A_PIN_ESYNC_FREQUENCY_SUPPORTED,
 	DPLL_A_PIN_ESYNC_PULSE,
 	DPLL_A_PIN_REFERENCE_SYNC,
+	DPLL_A_PIN_PHASE_ADJUST_GRAN,
 
 	__DPLL_A_PIN_MAX,
 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
-- 
2.51.0


