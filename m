Return-Path: <netdev+bounces-221002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9A3B49D5E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1202D1692E6
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB952EB849;
	Mon,  8 Sep 2025 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gq/0p925"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A42DC35F
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757373144; cv=none; b=bjqfp/dHAzrsUVC6SPt7Vfc93LErUKHZHT7cttFgangCf8t8fcoOGb7AMAqQdRtwHO2cZ6E7CivsL3b1lFbAdNZyfXmfZXiVpE/snKEogZGTW4xchhIa2Vcw1XUvyTfqn2RN/mUP3PBjKGwAMJNLl63ea2hLZflu5hiwReT5uPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757373144; c=relaxed/simple;
	bh=9nmgSPPLNrymEVjhw7GtJe+5fxmGs+dNjRPwK/2kWaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3PDafli4NXSXnSvyqUXY94lJf6MlCQYngLuXxIzdN/O53uhtlUeB54uGROgUD7lwnut0vn1fqE2xkPdWd4DQM5BMEd6u5qHrGGvFKpJ0x9cwMl7VNyQECfm8vZzuJeiCF5dVMrKNhxfUoh1LsrDwe2EiK+/SMMoU4QfV1BWIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gq/0p925; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757373139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZEeyxK4n4DtiZADtz8JaxMHOcZq9nPWMBuqVrDSVJyI=;
	b=Gq/0p925I3NoSVKfXkigNLKlpV0kt29xBNw2PQrwKSihJhYzm2oVVKnlHhCsX7+dBnHb0x
	m9LftbJbeude2BVonbvOYzWO+fiwRxbYy7ScTMp8VfgQa7Ra9Wl4vsZ+c4nzeLAGCOteDY
	UxJnQDq7GELS98cp8Sg+0JQM8YLFQHM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-cuCe2cQ7OwSX0Ryb9V6AZw-1; Mon,
 08 Sep 2025 19:12:16 -0400
X-MC-Unique: cuCe2cQ7OwSX0Ryb9V6AZw-1
X-Mimecast-MFC-AGG-ID: cuCe2cQ7OwSX0Ryb9V6AZw_1757373134
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB99318004D4;
	Mon,  8 Sep 2025 23:12:13 +0000 (UTC)
Received: from lima-fedora.redhat.com (unknown [10.2.18.244])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CB141956095;
	Mon,  8 Sep 2025 23:12:11 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net] net/octep_ep: Validate the VF ID
Date: Mon,  8 Sep 2025 19:11:58 -0400
Message-ID: <20250908231158.1333362-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Make sure that the VF ID is valid before trying to access the VF.

Fixes: 8a241ef9b9b8 ("octeon_ep: add ndo ops for VFs in PF driver")
Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 .../net/ethernet/marvell/octeon_ep/octep_main.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 24499bb36c00..eaafbc0a55b1 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1124,11 +1124,24 @@ static int octep_set_features(struct net_device *dev, netdev_features_t features
 	return err;
 }
 
+static bool octep_validate_vf(struct octep_device *oct, int vf)
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
 
+	if (!octep_validate_vf(oct, vf))
+		return -EINVAL;
+
 	ivi->vf = vf;
 	ether_addr_copy(ivi->mac, oct->vf_info[vf].mac_addr);
 	ivi->spoofchk = true;
@@ -1143,6 +1156,9 @@ static int octep_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
 	struct octep_device *oct = netdev_priv(dev);
 	int err;
 
+	if (!octep_validate_vf(oct, vf))
+		return -EINVAL;
+
 	if (!is_valid_ether_addr(mac)) {
 		dev_err(&oct->pdev->dev, "Invalid  MAC Address %pM\n", mac);
 		return -EADDRNOTAVAIL;
-- 
2.51.0


