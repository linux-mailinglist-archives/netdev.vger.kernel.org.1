Return-Path: <netdev+bounces-207772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD081B088AE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8144E37FA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31DA286D79;
	Thu, 17 Jul 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="Ne0VSSo1"
X-Original-To: netdev@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9B1FC0EF;
	Thu, 17 Jul 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742850; cv=none; b=lX992GUmPVJPIokd3rtG/uljBNvPsES3zqJbfKvlECOc8JhIAm/EUqeaY1Y5oBTchnnW36tenPHv7BHK8nLaQucQtLXga6zH/AKmdeP484AMAM25HwKZY8XhqEGUDKE22Wzm1J7xyVSIRhG5fH5JzoeyIfStPd7GFGZG8Gp7pXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742850; c=relaxed/simple;
	bh=y+NgVNqs9UPssA6IR1WIkBlfTnT0s5ae7SOiR83nCUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PRxRIc/d1XaedwOY9K5tCRfbLXCD3xw6ca2/NPQ0mDvc9dfmtEl/5C24x59RlCF4xh6OPNRsQoaW/JCICel1xupjYlQaua3cvQeKy+PirVQvRHtmwz5vjGSYkXlbsCfMOULMILQoFxLUbuo+9rkjamy/C4sVk1A5akzqqFI6ERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=Ne0VSSo1; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dsr9dRbVAldNjV8JKgEZYv9SvaMuV8zTMgrBYyOwtvE=; b=Ne0VSSo1FLMDjFtkk3AAUBO5xK
	pTqhbA0WtSEWXzGsjQ9zMWPhGJPBdZs0rj5gEFVGGscS0TVlWNbFMQna8knEIof9bjUXTMcpoFAW9
	s+XZji/MfUzftQXCOFDAAebFBP60xagu34eHu5Pcoi7RvfnesdqDwk1GiARfXnyzOE21NGOdmjAaz
	ahO/BCLMzXImHsBQi6pJYKKNaKBZCDwsEhuTRoOlYrRMO3ct1crtcglsT5jvA/XuuOSYKC8QN6um4
	iGPGgbcgZOkMSbCEbbOgRvT/JyUNDjBLHYkEsm4K6DgLKcHWvshJAds9DcSVCu0g7pJy2hFKLCtpm
	4JxFgFDA==;
Received: from [89.212.21.243] (port=53282 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1ucKTp-00DbO3-1Q;
	Thu, 17 Jul 2025 11:00:40 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH 0/2] Populate of_node for i.MX netdevs
Date: Thu, 17 Jul 2025 11:00:35 +0200
Message-Id: <20250717090037.4097520-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Recently when working on predictable network names for i.MX SoCs, it
was discovered that of_node sysfs properties are missing for FEC and
EQOS interfaces.

Without this, udev is unable to expose the OF_* properties (OF_NAME,
OF_FULLNAME, OF_COMPATIBLE, OF_ALIAS, etc.) and thus we cannot identify
interface based on those properties.

Fix this by populating netdev of_node in respective drivers.

Result:

$ ls -l /sys/class/net/end1/of_node
/sys/class/net/end1/of_node -> 
'../../../../../../../firmware/devicetree/base/soc@0/bus@42800000/ethernet@428a0000'/
$ ls -l /sys/class/net/end0/of_node                                                                              
/sys/class/net/end0/of_node -> 
'../../../../../../../firmware/devicetree/base/soc@0/bus@42800000/ethernet@42890000'/

$ udevadm info /sys/class/net/end0
P: /devices/platform/soc@0/42800000.bus/42890000.ethernet/net/end0
M: end0
R: 0
U: net
I: 2
E: DEVPATH=/devices/platform/soc@0/42800000.bus/42890000.ethernet/net/end0
E: SUBSYSTEM=net
E: OF_NAME=ethernet
E: OF_FULLNAME=/soc@0/bus@42800000/ethernet@42890000
E: OF_COMPATIBLE_0=fsl,imx93-fec
E: OF_COMPATIBLE_1=fsl,imx8mq-fec
E: OF_COMPATIBLE_2=fsl,imx6sx-fec
E: OF_COMPATIBLE_N=3
E: OF_ALIAS_0=ethernet0
E: INTERFACE=end0
E: IFINDEX=2
E: USEC_INITIALIZED=5227083
E: ID_NET_DRIVER=fec
E: ID_NET_NAMING_SCHEME=latest
E: ID_NET_NAME_MAC=enx502df44dbd5e
E: ID_NET_NAME_ONBOARD=end0
E: ID_PATH=platform-42890000.ethernet
E: ID_PATH_TAG=platform-42890000_ethernet
E: SYSTEMD_ALIAS=/sys/subsystem/net/devices/end0
E: TAGS=:systemd:
E: CURRENT_TAGS=:systemd:

$ udevadm info /sys/class/net/end1
P: /devices/platform/soc@0/42800000.bus/428a0000.ethernet/net/end1
M: end1
R: 1
U: net
I: 3
E: DEVPATH=/devices/platform/soc@0/42800000.bus/428a0000.ethernet/net/end1
E: SUBSYSTEM=net
E: OF_NAME=ethernet
E: OF_FULLNAME=/soc@0/bus@42800000/ethernet@428a0000
E: OF_COMPATIBLE_0=nxp,imx93-dwmac-eqos
E: OF_COMPATIBLE_1=snps,dwmac-5.10a
E: OF_COMPATIBLE_N=2
E: OF_ALIAS_0=ethernet1
E: INTERFACE=end1
E: IFINDEX=3
E: USEC_INITIALIZED=5370305
E: ID_NET_NAMING_SCHEME=latest
E: ID_NET_NAME_MAC=enx502df44dbd5f
E: ID_NET_NAME_ONBOARD=end1
E: ID_PATH=platform-428a0000.ethernet
E: ID_PATH_TAG=platform-428a0000_ethernet
E: SYSTEMD_ALIAS=/sys/subsystem/net/devices/end1
E: TAGS=:systemd:
E: CURRENT_TAGS=:systemd:


Primoz Fiser (2):
  net: fec: fec_probe(): Populate netdev of_node
  net: stmmac: Populate netdev of_node

 drivers/net/ethernet/freescale/fec_main.c         | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1


