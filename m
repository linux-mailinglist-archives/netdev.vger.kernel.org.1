Return-Path: <netdev+bounces-222335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925CB53EBF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 00:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4463C3B7833
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF62F2915;
	Thu, 11 Sep 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOK9YIV7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A382F28E6
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630184; cv=none; b=SNbu2fn3RhlNsbZHVlQe7lJb0rnsjyc0GrgY+pbFJABMDOBCSm9JGY9zslvYAcy8WL0OTEP2SCEq3eNTETi6osJsHkyW3a3ll8Cy5eFxhJOrTG/fCklKhaz/VKc4uWSp+B/hjag9xEYasd+1VMzd3bfnPoTfTjDOzBj8590rRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630184; c=relaxed/simple;
	bh=5yUmUNgpJLTKQTlYu4DSlmkb4k0pztcKhEpQVJiDqxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cmy3I10OFAB10S8Jd2Zi4QahMLSsRw6StmnNl6gYxiTnhskg/TIP8xC85in4jivbUFbA1JA/H1jaDyo8Q6mjn+lghVYZ5ZBPgv20sAxsgJUvAsf513SloWcV54OzxrhXyd1IAYWJNu0uYUQtn5ew9Kfi6K7rl9fb7ao+IlzTBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOK9YIV7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757630181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8HFI4wlvuMChwyaut35cRx4rQMDWo054QPaa6asQrTo=;
	b=IOK9YIV7bj4ot8lreIeLldkDhGEOR+M9lX+hblIJxRJL1vYn1TWBEd1z6ARrjM9sMseebl
	IO9EfP2L1jYhvTaJE7bTdJvJPLYPyUNDJ/CzAyG5w8RvHvAJLGyt5XDTSk8O7fldu4BfEM
	NXmXKYh+mxFQbbKmNMVftbTc1ToYhJE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-QC80LbRiN5K0wP5pigLLQw-1; Thu,
 11 Sep 2025 18:36:20 -0400
X-MC-Unique: QC80LbRiN5K0wP5pigLLQw-1
X-Mimecast-MFC-AGG-ID: QC80LbRiN5K0wP5pigLLQw_1757630178
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C3E3180057A;
	Thu, 11 Sep 2025 22:36:18 +0000 (UTC)
Received: from lima-fedora.redhat.com (unknown [10.22.64.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3A881800446;
	Thu, 11 Sep 2025 22:36:15 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v3] octeon_ep: Validate the VF ID
Date: Thu, 11 Sep 2025 18:36:10 -0400
Message-ID: <20250911223610.1803144-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
Reviewed-by: Simon Horman <horms@kernel.org>
---
v3: Change dev_err() to netdev_err().
v2: Address the comments from Michal.
---
 .../net/ethernet/marvell/octeon_ep/octep_main.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 24499bb36c00..bcea3fc26a8c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1124,11 +1124,24 @@ static int octep_set_features(struct net_device *dev, netdev_features_t features
 	return err;
 }
 
+static bool octep_is_vf_valid(struct octep_device *oct, int vf)
+{
+	if (vf >= CFG_GET_ACTIVE_VFS(oct->conf)) {
+		netdev_err(oct->netdev, "Invalid VF ID %d\n", vf);
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


