Return-Path: <netdev+bounces-251819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAcYBkifcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:41:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE165492B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41EDF8803E5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38260478847;
	Wed, 21 Jan 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4gdju9U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD50449EC1;
	Wed, 21 Jan 2026 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987419; cv=none; b=d/Bm5HYV6nWk749awnAiyWgyHZwrpqdI5ATGdsEH7P0daayQoSnZP5/ZVVhgxE2ooVV+j9XQNPXtsiRtxa566QkshmILJM1ZevXX/2OAZvjZDdocOgezmt9FSSd7fI8yMorwJ+eBlV+Sj/KC02EsjQISH52i3pks3NdYrRTDuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987419; c=relaxed/simple;
	bh=oKrZdqtv0rn5ebODG9t8T6zh953Yk7Gz/RbvHkfVf7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPPGbIy0Yqd0VuoUKAx2qkeG9Xo6VmyTvNwO0Fqviip1D+uOnyAxalpEEoN1SvF6JFX8g3gngtHr4Uxk/TtDhpv6VKltPNJtIOW5IeTAaTq32T1RFfOzEiGUvzdku/NvCEDrTAbN+0mMzl8J2jf2etI7KtaZkLMEwIv/a45yq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4gdju9U; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768987416; x=1800523416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKrZdqtv0rn5ebODG9t8T6zh953Yk7Gz/RbvHkfVf7c=;
  b=I4gdju9UXx1TKUGmVKsBygZFl1G73rWmke9vUJIbYdc7Ls26yJxu3icV
   paZWyU/4EqbffKNENuUeqyFnll2sCWy1oIcKRBUkAZYUuPu9oCjrChjMJ
   qHJogPcJmnjkHg8fa0u+r/FTtC0kdi9BqjL1QtPN5VTNkaJTdacgK5JtJ
   YWcfLvzALkFixA7vCBl/KEmwrdqo8e9AvK5V9RFxuNLMLJsgn8tZqxMI6
   K18++jP9F3hYdLjmcwRZvzWRBF5uWJeQQR3koQiksuZ69SP9RbVdt664p
   B0jYwhuDECBhzTbsuh99zpovb6EwoQw6OdVpEbn66aoZCM3QLbMQXPV8H
   Q==;
X-CSE-ConnectionGUID: CmC0GRH2RwSKHl4e5h/eAw==
X-CSE-MsgGUID: fGSYUl9uRxiNNOnO/aeJLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57773278"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="57773278"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:23:36 -0800
X-CSE-ConnectionGUID: pwWJY6lhSJenAR5EyWk7MA==
X-CSE-MsgGUID: rAVn8JSmQjuK8XcrnB2N6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210560995"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2026 01:23:35 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] i2c: Sysfs attribute files for the Unique Device Identifier fields
Date: Wed, 21 Jan 2026 10:23:26 +0100
Message-ID: <20260121092328.2308705-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251819-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 8BE165492B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to utilise the SMBus Address Resolution Protocol's
(ARP) Unique Device Identifier (UDID) also in user space,
the UDID details need to be exposed. With ARP the address is
also dynamically assigned (and may be reset) so it also
needs to be exposed to the user space with its own file.

The UDID details are only visible with ARP devices, but the
address file is made always visible for all I2C client
devices.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-i2c |  53 ++++++++++++
 drivers/i2c/i2c-core-base.c             | 107 +++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c b/Documentation/ABI/testing/sysfs-bus-i2c
new file mode 100644
index 000000000000..b9ebfc2e1b9d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c
@@ -0,0 +1,53 @@
+What:		/sys/bus/i2c/devices/.../address
+Date:		September 2025
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file has the target address the I2C client responds to.
+
+What:		/sys/bus/i2c/devices/.../vendor
+Date:		September 2025
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file is only visible for ARP devices. It returns the Vendor
+		ID field from the SMBus ARP Unique Device Identifier. It is the
+		device manufacturer's ID assigned by the SBS Implementers Forum
+		or the PCI SIG.
+
+What:		/sys/bus/i2c/devices/.../device
+Date:		September 2025
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file is only visible for ARP devices. It returns the Device
+		ID field from the SMBus ARP Unique Device Identifier. The
+		device ID is assigned by the device manufacturer.
+
+What:		/sys/bus/i2c/devices/.../interface
+Date:		September 2025
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file is only visible for ARP devices. It returns the
+		Interface field from the SMBus ARP Unique Device Identifier.
+
+What:		/sys/bus/i2c/devices/.../subsystem_vendor
+Date:		September 2025
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file is only visible for ARP devices. It returns the
+		Subsystem Vendor ID field from the SMBus ARP Unique Device
+		Identifier.
+
+What:		/sys/bus/i2c/devices/.../subsystem_device
+Date:		September 2025
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file is only visible for ARP devices. It returns the
+		Subsystem Device ID field from the SMBus ARP Unique Device
+		Identifier.
+
+What:		/sys/bus/i2c/devices/.../vendor_specific_id
+Date:		September 2025
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This file is only visible for ARP devices. It returns the
+		Vendor Specific ID field from the SMBus ARP Unique Device
+		Identifier.
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 6e96ac186921..4e2422cd0448 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -685,6 +685,13 @@ name_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(name);
 
+static ssize_t
+address_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0x%02x\n", to_i2c_client(dev)->addr);
+}
+static DEVICE_ATTR_RO(address);
+
 static ssize_t
 modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -712,11 +719,109 @@ static DEVICE_ATTR_RO(modalias);
 
 static struct attribute *i2c_dev_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_address.attr,
 	/* modalias helps coldplug:  modprobe $(cat .../modalias) */
 	&dev_attr_modalias.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(i2c_dev);
+
+static const struct attribute_group i2c_dev_group = {
+	.attrs = i2c_dev_attrs,
+};
+
+static ssize_t
+capabilities_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return sysfs_emit(buf, "0x%02x\n", client->udid->capabilities);
+}
+static DEVICE_ATTR_RO(capabilities);
+
+static ssize_t
+vendor_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return sysfs_emit(buf, "0x%04x\n", client->udid->vendor);
+}
+static DEVICE_ATTR_RO(vendor);
+
+static ssize_t
+device_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return sysfs_emit(buf, "0x%04x\n", client->udid->device);
+}
+static DEVICE_ATTR_RO(device);
+
+static ssize_t
+interface_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return sysfs_emit(buf, "0x%04x\n", client->udid->interface);
+}
+static DEVICE_ATTR_RO(interface);
+
+static ssize_t
+subsystem_vendor_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return sysfs_emit(buf, "0x%04x\n", client->udid->subvendor);
+}
+static DEVICE_ATTR_RO(subsystem_vendor);
+
+static ssize_t
+subsystem_device_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return sysfs_emit(buf, "0x%04x\n", client->udid->subdevice);
+}
+static DEVICE_ATTR_RO(subsystem_device);
+
+static ssize_t
+vendor_specific_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return sysfs_emit(buf, "0x%08x\n", client->udid->vendor_specific_id);
+}
+static DEVICE_ATTR_RO(vendor_specific_id);
+
+static struct attribute *udid_attrs[] = {
+	&dev_attr_capabilities.attr,
+	&dev_attr_vendor.attr,
+	&dev_attr_device.attr,
+	&dev_attr_interface.attr,
+	&dev_attr_subsystem_vendor.attr,
+	&dev_attr_subsystem_device.attr,
+	&dev_attr_vendor_specific_id.attr,
+	NULL
+};
+
+static umode_t
+udid_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	if (to_i2c_client(kobj_to_dev(kobj))->udid)
+		return attr->mode;
+
+	return 0;
+}
+
+static const struct attribute_group udid_group = {
+	.is_visible = udid_is_visible,
+	.attrs = udid_attrs,
+};
+
+static const struct attribute_group *i2c_dev_groups[] = {
+	&i2c_dev_group,
+	&udid_group,
+	NULL
+};
 
 const struct bus_type i2c_bus_type = {
 	.name		= "i2c",
-- 
2.50.1


