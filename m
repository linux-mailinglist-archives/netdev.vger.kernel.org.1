Return-Path: <netdev+bounces-261765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPtaMOxToWkfsAQAu9opvQ
	(envelope-from <netdev+bounces-261765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:21:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0B1B46FE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A99E8305FB50
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED24389444;
	Fri, 27 Feb 2026 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iAjbCi5t"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3336BCE8;
	Fri, 27 Feb 2026 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180391; cv=none; b=JgZvgDXtihXMIm2OTcaby/71CjhsSi56xx+deOWxstHDQUKCy1m9xA2bWoUSfESsw9DSo/7nJ5SpS/j6zdo61Yv1hI3C1oBqrWoE9MRIzhvRG4mAlLh7DiOKejYQW1bjJ0sXZyqo1ojpCabW64Xq/4ky+JsIHa6uQI/Lz7mqPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180391; c=relaxed/simple;
	bh=5Wt8gx4rI5m/M6u27nYgNDnE3vydq6IQNcRy0M29H9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZaRs5GFmaj8+3IrSxF6tYPf2uPJXhuc6JOoqrhF0KnE9KROMzKAJpFpszPYOysgGQDAjdrj3yRAqFo25LXXPzvwyBpaHpPHHTFzh11HFqmyld0Hx/BGtusJbWOo8sceLdjtQLhLM27Kw/nAzAQ2BhkEZ+oIReD0lf2NkPawKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iAjbCi5t; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772180381; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=BfJ/fUzo8zYw/G5W0TxdzYxzrEE9dyyQWn+P671kgCQ=;
	b=iAjbCi5te+7RWOhv2+KxI57bbkJ/mnMa1yvRBLIAqjKP3t1gjYrub9GiW9fj8jpjGbDrkwzmfLCbGrTLJeyXkReQLU6bPbPMK0yk4Z1LJwWanGTo2ysG45hIpaDcCTWA1w3+F1EwHCjOudAHY6EvicAZ39glWEICj5xYFutplI0=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WztjMg._1772180378 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 16:19:39 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: tglx@kernel.org,
	tglx@linutronix.de,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	mani@kernel.org,
	imran.shaik@oss.qualcomm.com
Cc: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com,
	svens@linux.ibm.com,
	dwmw2@infradead.org,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-fpga@vger.kernel.org,
	imx@lists.linux.dev,
	linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	taniya.das@oss.qualcomm.com
Subject: [RFC v2 2/2] MAINTAINERS: update PTP maintainer entries after directory split
Date: Fri, 27 Feb 2026 16:19:34 +0800
Message-Id: <20260227081934.96865-3-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260227081934.96865-1-guwen@linux.alibaba.com>
References: <20260227081934.96865-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261765-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,linux.dev,linux.ibm.com,infradead.org,broadcom.com,vger.kernel.org,lists.linux.dev,linux.alibaba.com,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,oss.qualcomm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guwen@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[30]
X-Rspamd-Queue-Id: 33B0B1B46FE
X-Rspamd-Action: no action

Update MAINTAINERS to match the new drivers/ptp/ directory layout after
splitting emulated and IEEE 1588 network-oriented drivers into
subdirectories.

Adjust file patterns and per-driver entries to point to their new
locations, and add a dedicated MAINTAINERS entry for the emulated PTP
clock drivers.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 MAINTAINERS | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8d8a5c41597..c87715fc8d1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10253,7 +10253,7 @@ F:	Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
 F:	drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp*
 F:	drivers/net/ethernet/freescale/dpaa2/dprtc*
 F:	drivers/net/ethernet/freescale/enetc/enetc_ptp.c
-F:	drivers/ptp/ptp_qoriq.c
+F:	drivers/ptp/ieee1588/ptp_qoriq.c
 F:	include/linux/fsl/ptp_qoriq.h
 
 FREESCALE QUAD SPI DRIVER
@@ -13134,7 +13134,7 @@ INTEL PTP DFL ToD DRIVER
 L:	linux-fpga@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Orphan
-F:	drivers/ptp/ptp_dfl_tod.c
+F:	drivers/ptp/ieee1588/ptp_dfl_tod.c
 
 INTEL QUADRATURE ENCODER PERIPHERAL DRIVER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
@@ -18321,7 +18321,10 @@ F:	Documentation/devicetree/bindings/net/
 F:	Documentation/networking/net_cachelines/net_device.rst
 F:	drivers/connector/
 F:	drivers/net/
-F:	drivers/ptp/
+F:	drivers/ptp/Kconfig
+F:	drivers/ptp/Makefile
+F:	drivers/ptp/ieee1588/
+F:	drivers/ptp/ptp*
 F:	drivers/s390/net/
 F:	include/dt-bindings/net/
 F:	include/linux/cn_proc.h
@@ -19104,7 +19107,7 @@ L:	imx@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
-F:	drivers/ptp/ptp_netc.c
+F:	drivers/ptp/ieee1588/ptp_netc.c
 
 NXP PF5300/PF5301/PF5302 PMIC REGULATOR DEVICE DRIVER
 M:	Woodrow Douglass <wdouglass@carnegierobotics.com>
@@ -19815,9 +19818,9 @@ F:	include/dt-bindings/
 OPENCOMPUTE PTP CLOCK DRIVER
 M:	Jonathan Lemon <jonathan.lemon@gmail.com>
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
-L:	netdev@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/ptp/ptp_ocp.c
+F:	drivers/ptp/emulated/ptp_ocp.c
 
 OPENCORES I2C BUS DRIVER
 M:	Peter Korsgaard <peter@korsgaard.com>
@@ -21255,15 +21258,25 @@ W:	http://linuxptp.sourceforge.net/
 F:	Documentation/ABI/testing/sysfs-ptp
 F:	Documentation/driver-api/ptp.rst
 F:	drivers/net/phy/dp83640*
-F:	drivers/ptp/*
+F:	drivers/ptp/Kconfig
+F:	drivers/ptp/Makefile
+F:	drivers/ptp/ieee1588/
+F:	drivers/ptp/ptp*
 F:	include/linux/ptp_cl*
 K:	(?:\b|_)ptp(?:\b|_)
 
+PTP EMULATED CLOCK SUPPORT
+M:	Wen Gu <guwen@linux.alibaba.com>
+M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/ptp/emulated/
+
 PTP MOCKUP CLOCK SUPPORT
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/ptp/ptp_mock.c
+F:	drivers/ptp/ieee1588/ptp_mock.c
 F:	include/linux/ptp_mock.h
 
 PTP VIRTUAL CLOCK SUPPORT
@@ -21275,10 +21288,10 @@ F:	net/ethtool/phc_vclocks.c
 
 PTP VMCLOCK SUPPORT
 M:	David Woodhouse <dwmw2@infradead.org>
-L:	netdev@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml
-F:	drivers/ptp/ptp_vmclock.c
+F:	drivers/ptp/emulated/ptp_vmclock.c
 F:	include/uapi/linux/vmclock-abi.h
 
 PTRACE SUPPORT
@@ -23328,7 +23341,7 @@ S390 PTP DRIVER
 M:	Sven Schnelle <svens@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-F:	drivers/ptp/ptp_s390.c
+F:	drivers/ptp/emulated/ptp_s390.c
 
 S390 SCM DRIVER
 M:	Vineeth Vijayan <vneethv@linux.ibm.com>
@@ -28217,9 +28230,9 @@ M:	Nick Shi <nick.shi@broadcom.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
 R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
-L:	netdev@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	drivers/ptp/ptp_vmw.c
+F:	drivers/ptp/emulated/ptp_vmw.c
 
 VMWARE VMCI DRIVER
 M:	Bryan Tan <bryan-bt.tan@broadcom.com>
-- 
2.43.5


