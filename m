Return-Path: <netdev+bounces-179785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF944A7E848
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90902178BFB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD46221ABCD;
	Mon,  7 Apr 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oq49BB/9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F421ABB9
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046972; cv=none; b=hsmX5218qv5MspBEgzthh0Q1L4mWLiIMSac+VKj//hlp2ObXpwuu0RRO6VwrzB7vgRO/YVTe3rLU3tWnjd+yESiw1by8aAtD79eDEc+XYAdC6aBkfG4jh2bKyOQHAsl/0Pbl1fPRdwHa6xfVqroAlPNEdWjbwcezvThNxz3co88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046972; c=relaxed/simple;
	bh=FNVfDjiAs80CxSrgw2joIxTPr3R1fwS+JdUgXRyMHws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyikD6xdWrM1eowwHxTgdVXh2fP971yRohYr6aiZN/s+ygByAVCcBb0qOJP8IKc+wgfu220orWh6+sKAJWxk3ZNOGXDJqxkpuNWPRkw3UNYUPUqWVN1eKLMrmY+udqNnZ3hFHcZGl57Oz+4Is6uqjlft8PFD+j0d4Tg8jelm9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oq49BB/9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuEW/SGI3isu0yVFd6QA70OIZUfyWajvSLe1fJC9qPY=;
	b=Oq49BB/9crgH6p3t2tqO093YDHZ54rSjipuT4tiswlvM9CxmmaUZPJ30ng8jVAV8a6Ba1j
	Boh+y+ZG/QaCZD13qg8wYR3XRWhSs+XRYMTIcgP4BOwE5wgxYAI9EsoFnMn2d0gm0K2qeN
	oWawMG4xzmE1GuP01rV5n+yr9rgNX4g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-ERpXse5eN2usobjcXKM-7g-1; Mon,
 07 Apr 2025 13:29:24 -0400
X-MC-Unique: ERpXse5eN2usobjcXKM-7g-1
X-Mimecast-MFC-AGG-ID: ERpXse5eN2usobjcXKM-7g_1744046962
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 372AE1955DC6;
	Mon,  7 Apr 2025 17:29:22 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A49DE1828AA4;
	Mon,  7 Apr 2025 17:29:16 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 06/28] mfd: zl3073x: Implement devlink device info
Date: Mon,  7 Apr 2025 19:28:33 +0200
Message-ID: <20250407172836.1009461-7-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Provide ASIC ID, ASIC revision, firmware version and optionally
custom config version through devlink device info.

Sample output:
 # devlink dev
 i2c/1-0070
 # devlink dev info
 i2c/1-0070:
   driver zl3073x-i2c
   versions:
       fixed:
         asic.id 1E94
         asic.rev 300
         fw 7006

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index b3091b00cffa8..33e76666e5694 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -142,7 +142,80 @@ int zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg,
 }
 EXPORT_SYMBOL_GPL(zl3073x_write_reg);
 
+/**
+ * zl3073x_devlink_info_get - Devlink device info callback
+ * @devlink: devlink structure pointer
+ * @req: devlink request pointer to store information
+ * @extack: netlink extack pointer to report errors
+ *
+ * Returns 0 in case of success or negative value otherwise
+ */
+static int zl3073x_devlink_info_get(struct devlink *devlink,
+				    struct devlink_info_req *req,
+				    struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dev *zldev = devlink_priv(devlink);
+	u16 id, revision, fw_ver;
+	char buf[16];
+	u32 cfg_ver;
+	int rc;
+
+	guard(zl3073x)(zldev);
+
+	rc = zl3073x_read_id(zldev, &id);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%X", id);
+	rc = devlink_info_version_fixed_put(req,
+					DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
+					buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_revision(zldev, &revision);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%X", revision);
+	rc = devlink_info_version_fixed_put(req,
+					DEVLINK_INFO_VERSION_GENERIC_ASIC_REV,
+					buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_fw_ver(zldev, &fw_ver);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%u", fw_ver);
+	rc = devlink_info_version_fixed_put(req,
+					    DEVLINK_INFO_VERSION_GENERIC_FW,
+					    buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
+	if (rc)
+		return rc;
+
+	/* No custom config version */
+	if (cfg_ver == U32_MAX)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%lu.%lu.%lu.%lu",
+		 FIELD_GET(GENMASK(31, 24), cfg_ver),
+		 FIELD_GET(GENMASK(23, 16), cfg_ver),
+		 FIELD_GET(GENMASK(15, 8), cfg_ver),
+		 FIELD_GET(GENMASK(7, 0), cfg_ver));
+
+	rc = devlink_info_version_running_put(req, "cfg.custom_ver", buf);
+
+	return rc;
+}
+
 static const struct devlink_ops zl3073x_devlink_ops = {
+	.info_get = zl3073x_devlink_info_get,
 };
 
 static void zl3073x_devlink_free(void *ptr)
-- 
2.48.1


