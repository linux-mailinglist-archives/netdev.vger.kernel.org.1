Return-Path: <netdev+bounces-251820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCRbAE6fcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:41:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F654932
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E76A880EB7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254147B403;
	Wed, 21 Jan 2026 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R22BqTqV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F146AF31;
	Wed, 21 Jan 2026 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987420; cv=none; b=Bs+07JCJV/mi5DRLhMp5qsqY2r99cBhI0x0shGqpgho1BKhNBafDXW0pKYRQyNNyOs9MAFiaePTHRIhSNy9akvSKPeYvXBi7Xy/gybOUjufPqW3Bp6K48nMp2aLkhRYa02MGIXBbZmtttS9UZIfuCwo117uzzzycjrW5BDryyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987420; c=relaxed/simple;
	bh=G1GyKVSX9uKD79xYXrL1AswlRkuNmQ2QzEepyMFCmHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCxqfL42BE1c3AoWOjynsYK7y80zm96rKTQgQnaPa+I9JUHCA93dK49J3iferE46IhbhRXTq1POB4Acn408Hoox+cQEIvvgnDLZPd+oYzyQAQw9QmH1CJl1Jqu24mSsuyCfiMjshX5VmYTpNPmTE+JptbFtwG9KyUfJBcNQkDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R22BqTqV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768987418; x=1800523418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G1GyKVSX9uKD79xYXrL1AswlRkuNmQ2QzEepyMFCmHs=;
  b=R22BqTqVFMy195+eHXC5iTdyZVcMhYYWCPtG7LUAzIKKZ+kcyG4w8mje
   jyqgmFLdWNdD6akaki1+gwqGxx3GsclGg4ayR54d5jeY6IqKEiIvYqqnO
   tXF7mhVpVzvFP489taHRvRgnHntVsigex/SZdbrwr75I615vy7vsw8QdE
   6hGRATbkmNn7o1e/1qvoBXviJPmaRtV3EzieUwVkHP8WE4TGEwgqXh6OZ
   K+FwZygeJXRfbudmot3nseiuiUl2soIbYra+z9rKSmEkaZKARClUN6mX7
   rly14/sbXfS0C88aRJpLdt0NRSECZYCuzgTVZQa061OxdZ0FjuSB+jh+d
   Q==;
X-CSE-ConnectionGUID: UV1IEhP7QSeXcOd18fWRXQ==
X-CSE-MsgGUID: eihg6aN5T0eQ34apfD3wug==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57773282"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="57773282"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:23:38 -0800
X-CSE-ConnectionGUID: Uoph8pElSlGD9fUCxwwe5A==
X-CSE-MsgGUID: 9HzlT/PCQROiXYhEDVPByQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210561003"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2026 01:23:37 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] mctp i2c: Enable SMBus ARP discovery
Date: Wed, 21 Jan 2026 10:23:27 +0100
Message-ID: <20260121092328.2308705-4-heikki.krogerus@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-251820-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.intel.com:mid,dmtf.org:url,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: C64F654932
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since the SMBus Address Resolution Protocol (ARP) is now
supported with all I2C host adapters, every ARP-capable MCTP
device will get automatically enumerated. Those devices just
need to be bind to this driver.

The SMBus ARP-capable MCTP devices are identified by
checking the interface (MCTP SMBus/I2C Transport Binding
Specification section 6.5). The interface must match the ASF
protocol, so all devices that use the ASF protocol as their
interface will be probed by this driver.

Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.2.0.pdf
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/net/mctp/mctp-i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 8043b57bdf25..47d7f6b5212e 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -21,6 +21,7 @@
 #include <linux/netdevice.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
+#include <linux/i2c-smbus.h>
 #include <linux/if_arp.h>
 #include <net/mctp.h>
 #include <net/mctpdevice.h>
@@ -1105,6 +1106,12 @@ static const struct i2c_device_id mctp_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mctp_i2c_id);
 
+static const struct smbus_device_id mctp_smbus_id[] = {
+	{ SMBUS_INTERFACE_ASF },
+	{}
+};
+MODULE_DEVICE_TABLE(smbus, mctp_smbus_id);
+
 static const struct of_device_id mctp_i2c_of_match[] = {
 	{ .compatible = "mctp-i2c-controller" },
 	{},
@@ -1119,6 +1126,7 @@ static struct i2c_driver mctp_i2c_driver = {
 	.probe = mctp_i2c_probe,
 	.remove = mctp_i2c_remove,
 	.id_table = mctp_i2c_id,
+	.smbus_id_table = mctp_smbus_id,
 };
 
 static __init int mctp_i2c_mod_init(void)
-- 
2.50.1


