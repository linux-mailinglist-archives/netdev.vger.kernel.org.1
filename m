Return-Path: <netdev+bounces-221213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC3EB4FC19
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2BD7ACA35
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280A8321F39;
	Tue,  9 Sep 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJkQuCgl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9682472BF
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423458; cv=none; b=E8geltcbJ/5L22F+3lCV7vi1EuFhLDuwDoZg9S5LnTnaJLR5RmZ3LQ8xGTP+kIeA+7/00ZEv+hkP0SFM8HTmaJG3EZmTEGn1pUGxHH7V48/KT3Un/msr7QRR6gWtXeJv9An5oLD6vrxAFp/19x5NYHYCLhEjnO8QmRkwXIiTDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423458; c=relaxed/simple;
	bh=bz0xLyjZdqtnxLz0ihLt4vmI1X79BREoGr1hTkijQ3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/KSI7GqZUZXoV69lFwA3o77TfeDCtfAXI429Bm0fV3udvN5V7zvshuFnmY3aPs34FA2EM3+CgXNd4RFtb1FUwzl821PutTA8jIetVCS43bcipo0IBwNfPTUcSFnFMCeeWWJJHyDTVcU68jHT80CrlJq01PDgGy0yPAo5FJnW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJkQuCgl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757423455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qGepU4klNbkZ9X7CaKD/j1iCDFqq4s0ozledVEGqyhg=;
	b=BJkQuCglIF8Wulh3FDLcgKW9MDZQ77UteCfQaGHfNdWj4RHs1Ckp+72nFUgZx7x3c25Xeb
	ecFVSU44rP09JPZyg2jZ/SwNb2AxE1O8LP+wwNIlBux/3zkK+Y+aOQOrE1vd8GPHZWtR/G
	43DFAAaExs0hEN4OtoonZiOJFmnC3lI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-rnxIM3ETPRSFzJx8O0y6cw-1; Tue,
 09 Sep 2025 09:10:50 -0400
X-MC-Unique: rnxIM3ETPRSFzJx8O0y6cw-1
X-Mimecast-MFC-AGG-ID: rnxIM3ETPRSFzJx8O0y6cw_1757423448
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D07C19560AF;
	Tue,  9 Sep 2025 13:10:48 +0000 (UTC)
Received: from lima-fedora.redhat.com (unknown [10.2.18.244])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5258E19560BC;
	Tue,  9 Sep 2025 13:10:46 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net v2] octeon_ep: Validate the VF ID
Date: Tue,  9 Sep 2025 09:10:20 -0400
Message-ID: <20250909131020.1397422-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a helper to validate the VF ID and use it in the VF ndo ops to
prevent accessing out-of-range entries.

Without this check, users can run commands such as:

 # ip link show dev enp135s0
 2: enp135s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 00:00:00:01:01:00 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
    vf 1     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
 # ip link set dev enp135s0 vf 4 mac 00:00:00:00:00:14
 # echo $?
 0

even though VF 4 does not exist, which results in silent success instead
of returning an error.

Fixes: 8a241ef9b9b8 ("octeon_ep: add ndo ops for VFs in PF driver")
Signed-off-by: Kamal Heib <kheib@redhat.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v2: Address the comments from Michal.
---
 .../net/ethernet/marvell/octeon_ep/octep_main.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 24499bb36c00..861341a883f0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1124,11 +1124,24 @@ static int octep_set_features(struct net_device *dev, netdev_features_t features
 	return err;
 }
 
+static bool octep_is_vf_valid(struct octep_device *oct, int vf)
+{
+	if (vf >= CFG_GET_ACTIVE_VFS(oct->conf)) {
+		dev_err(&oct->pdev->dev, "Invalid VF ID %d\n", vf);
+		return false;
+	}
+
+	return true;
+}
+
 static int octep_get_vf_config(struct net_device *dev, int vf,
 			       struct ifla_vf_info *ivi)
 {
 	struct octep_device *oct = netdev_priv(dev);
 
+	if (!octep_is_vf_valid(oct, vf))
+		return -EINVAL;
+
 	ivi->vf = vf;
 	ether_addr_copy(ivi->mac, oct->vf_info[vf].mac_addr);
 	ivi->spoofchk = true;
@@ -1143,6 +1156,9 @@ static int octep_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
 	struct octep_device *oct = netdev_priv(dev);
 	int err;
 
+	if (!octep_is_vf_valid(oct, vf))
+		return -EINVAL;
+
 	if (!is_valid_ether_addr(mac)) {
 		dev_err(&oct->pdev->dev, "Invalid  MAC Address %pM\n", mac);
 		return -EADDRNOTAVAIL;
-- 
2.51.0


