Return-Path: <netdev+bounces-226702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A88EBA430E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7ACD5624F4
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D12D1DD0EF;
	Fri, 26 Sep 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8pzvAcK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F71D5ACE
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896584; cv=none; b=OwGoXmWNrih5Q6eTTDgO8M//POduubi5+TsZeusUWusX9YZrN13VYa+RToCsXQFTniA94/SNVskEyEBLI3aS6bOq9fZeOqBKyIPhsi0f464dmmcgyPFXmuhahAsUVRDmFjUF0l3IiKOMCOBIeZQwzhqaH81adxNqrcs5XKzqNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896584; c=relaxed/simple;
	bh=PrNdObNwK8MyVUSlXClOFNlkhDifhAVkWnm+Rf0inck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVxy9GrBhrpPblJUyLy0OBbvXqvjfTI0p3js8vFUFO877OBNc7l+XrEl1WkVJ7HMZc9Yl6pDocdDHQoWfnHt7hW+4uDoT/BebcLPC4H9CxsqCtVnQzqrdrkPLcJwApqDViKIg2GeHV2QAtFPxEvT78yi9TLUb1Yece4NATPOL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8pzvAcK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758896582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lFxR1925+K2SMQxPr1ghXoGOdc0XoB4pfQ2tyX/Lkg=;
	b=G8pzvAcKC19YZnTLEeQ9DpMJjtTNSTQqIIxovEdH1qhCaR4k1n+7opzLnoLCVfhuMvrCNh
	GKfboUhFOpROo8RnJOSPr3d7DclWPs++Z099zF0CntO642w0jbU9uQFIkChs6dt3Mn0CM/
	SQzsAYeG9JmYQNJA0wuzcSX9M9ei0kg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-tuL2aiKUNf6dUPswiR8cFw-1; Fri,
 26 Sep 2025 10:21:56 -0400
X-MC-Unique: tuL2aiKUNf6dUPswiR8cFw-1
X-Mimecast-MFC-AGG-ID: tuL2aiKUNf6dUPswiR8cFw_1758896514
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E97A195605E;
	Fri, 26 Sep 2025 14:21:53 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D28D330003BB;
	Fri, 26 Sep 2025 14:21:47 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 1/3] dpll: add phase-offset-avg-factor device attribute to netlink spec
Date: Fri, 26 Sep 2025 16:21:38 +0200
Message-ID: <20250926142140.691592-2-ivecera@redhat.com>
In-Reply-To: <20250926142140.691592-1-ivecera@redhat.com>
References: <20250926142140.691592-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add dpll device level attribute DPLL_A_PHASE_OFFSET_AVG_FACTOR to allow
control over a calculation of reported phase offset value. Attribute is
present, if the driver provides such capability, otherwise attribute
shall not be present.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst     | 18 +++++++++++++++++-
 Documentation/netlink/specs/dpll.yaml |  6 ++++++
 drivers/dpll/dpll_nl.c                |  5 +++--
 include/uapi/linux/dpll.h             |  1 +
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index eca72d9b9ed87..be1fc643b645e 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -179,7 +179,23 @@ Phase offset measurement and adjustment
 Device may provide ability to measure a phase difference between signals
 on a pin and its parent dpll device. If pin-dpll phase offset measurement
 is supported, it shall be provided with ``DPLL_A_PIN_PHASE_OFFSET``
-attribute for each parent dpll device.
+attribute for each parent dpll device. The reported phase offset may be
+computed as the average of prior values and the current measurement, using
+the following formula:
+
+.. math::
+   curr\_avg = prev\_avg * \frac{2^N-1}{2^N} + new\_val * \frac{1}{2^N}
+
+where `curr_avg` is the current reported phase offset, `prev_avg` is the
+previously reported value, `new_val` is the current measurement, and `N` is
+the averaging factor. Configured averaging factor value is provided with
+``DPLL_A_PHASE_OFFSET_AVG_FACTOR`` attribute of a device and value change can
+be requested with the same attribute with ``DPLL_CMD_DEVICE_SET`` command.
+
+  ================================== ======================================
+  ``DPLL_A_PHASE_OFFSET_AVG_FACTOR`` attr configured value of phase offset
+                                     averaging factor
+  ================================== ======================================
 
 Device may also provide ability to adjust a signal phase on a pin.
 If pin phase adjustment is supported, minimal and maximal values that pin
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 5decee61a2c4c..cafb4ec20447e 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -315,6 +315,10 @@ attribute-sets:
           If enabled, dpll device shall monitor and notify all currently
           available inputs for changes of their phase offset against the
           dpll device.
+      -
+        name: phase-offset-avg-factor
+        type: u32
+        doc: Averaging factor applied to calculation of reported phase offset.
   -
     name: pin
     enum-name: dpll_a_pin
@@ -523,6 +527,7 @@ operations:
             - clock-id
             - type
             - phase-offset-monitor
+            - phase-offset-avg-factor
 
       dump:
         reply: *dev-attrs
@@ -540,6 +545,7 @@ operations:
           attributes:
             - id
             - phase-offset-monitor
+            - phase-offset-avg-factor
     -
       name: device-create-ntf
       doc: Notification about device appearing
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 9f2efaf252688..3c6d570babf89 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -42,9 +42,10 @@ static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_ID + 1] = {
 };
 
 /* DPLL_CMD_DEVICE_SET - do */
-static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_PHASE_OFFSET_MONITOR + 1] = {
+static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_PHASE_OFFSET_AVG_FACTOR + 1] = {
 	[DPLL_A_ID] = { .type = NLA_U32, },
 	[DPLL_A_PHASE_OFFSET_MONITOR] = NLA_POLICY_MAX(NLA_U32, 1),
+	[DPLL_A_PHASE_OFFSET_AVG_FACTOR] = { .type = NLA_U32, },
 };
 
 /* DPLL_CMD_PIN_ID_GET - do */
@@ -112,7 +113,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.doit		= dpll_nl_device_set_doit,
 		.post_doit	= dpll_post_doit,
 		.policy		= dpll_device_set_nl_policy,
-		.maxattr	= DPLL_A_PHASE_OFFSET_MONITOR,
+		.maxattr	= DPLL_A_PHASE_OFFSET_AVG_FACTOR,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index 37b438ce8efc4..ab1725a954d74 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -216,6 +216,7 @@ enum dpll_a {
 	DPLL_A_LOCK_STATUS_ERROR,
 	DPLL_A_CLOCK_QUALITY_LEVEL,
 	DPLL_A_PHASE_OFFSET_MONITOR,
+	DPLL_A_PHASE_OFFSET_AVG_FACTOR,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
-- 
2.49.1


