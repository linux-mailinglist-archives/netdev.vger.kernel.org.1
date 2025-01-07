Return-Path: <netdev+bounces-156044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7706DA04BDD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AE33A4ED2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB941F63F0;
	Tue,  7 Jan 2025 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cSxYcAgd"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1351E04B8
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286128; cv=none; b=ID3V5dDZ7l4hxcm6UoOPIgTNzQB9yKTWs8Usgy70mrDmRI9HdhUCd+BxBk3sEPE+GrUBq7s4Te1ScvNg09IL9zkLzAmYZWZh5yGpEJonlWHUmbapXELGdSx1O998tmbSJ+livgJD+ZZkR+EUkBcfroExhOgxNP29bvt/bnMbdQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286128; c=relaxed/simple;
	bh=5sVRjmx+NkyHd1IX9h15MHb85uCWuVplGXvapP2GtJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E6F1x8amvwknfrFXE9qm1DzJInL/nSYBUfTKQl9ng9xGKEjfSCShZzp2cU2xjYFdlolMSuYpGV93/8zFllsBiKjpnJwavMfcbK/e4vd3aV8mPBx3baUuJcbYZH/VJhWZo7Ll0eBdnkSgZZ8RknSKyVapwBzlUbljErGVdLcCw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=cSxYcAgd; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1731; q=dns/txt; s=iport;
  t=1736286126; x=1737495726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPrpfxg0BcN3JWGtlnUVMZeSSERKEUWnLhK9TVY3w/Q=;
  b=cSxYcAgdNal7XFb0IkyozvNsC0eUu6UJHcatlRZDLyaRvLiolIYSZG/9
   ver2rGG9crKERycYO/5iJDv59c5D1K33sjOzCban2pE27Fimq6MevFGZ/
   CK04h5durLNwCCrvgxhuopig9+zSllUNsG14AA0+mMIWtw28jEnHReJmd
   Q=;
X-CSE-ConnectionGUID: QzrBSbgXQcK8AE0JITnWew==
X-CSE-MsgGUID: Is2Ef0EASdyEyxwBVEq1RQ==
X-IPAS-Result: =?us-ascii?q?A0BaAACVnn1n/5QQJK1aHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?QUBAQsBgkqBT0NIjVGIcp4bFIERA1YPAQEBD0QEAQGFBwKKdAImNgcOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZbAgEDJwsBNBIQU?=
 =?us-ascii?q?SsrBxKDAYJlA7FCgXkzgQHeM4FtgUgBhWqHX3CEdycbgUlEhA5vhAogZoV3B?=
 =?us-ascii?q?IdpnglIgSEDWSwBVRMNCgsHBYE5OgMiCwsMCxQcFQIVHgESBhEEbkQ3gkZpS?=
 =?us-ascii?q?zcCDQI1gh4kWIIrhFyER4RYgktVgkiCF3yBHYMWQAMLGA1IESw3Bg4bBj5uB?=
 =?us-ascii?q?5p1PINuAYEONUc1pn+hA4QlgWOfYxozqlOYfCKkJYRmgW4BNIFZMxoIGxWDI?=
 =?us-ascii?q?lIZD44tFrknJTI8AgcLAQEDCY9YgX0BAQ?=
IronPort-Data: A9a23:Q3nYf69twATn7qW7TQX+DrUDo3+TJUtcMsCJ2f8bNWPcYEJGY0x3m
 zFKUWqDbPaJYzD0f9gjOtjl8khTvJ+BxtAyQQBqpXxEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qoyyHjEAX9gWMsazpLs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kPL5cywex4MVhF1
 qwxBWgvTyyFuO+plefTpulE3qzPLeHiOIcZ/3UlxjbDALN/GNbIQr7B4plT2zJYasJmRKmFI
 ZFHL2MxKk2cM3WjOX9PYH46tOWvhn/zejlVgFmUvqEwpWPUyWSd1ZCxaoaJJITaFZQ9ckCwh
 3mc0mqhLzghOM2y2Cqa2EyBn7b1pHauMG4VPPjinhJwu3Wfz3IeDTUaXEW2pP2+hFL4Xd9DQ
 2QZ9jcrpLo/6GSkSd7yWxD+q3mB1jYfRtBZO+438geAzuzT+QnxLmECQiRMd58gudM6SCIC0
 kKPmZXiBVRHqLSfRHSc3q2ZoTO7JW4eKmpqTSkJUQcI/fH9r4wpyBHCVNBuFOiylNKdJN3r6
 zmOqC57g/AYitQGkvziu1vGmDmr4JPOS2bZ+znqY45s1SshDKbNWmBiwQOzASpoRGpBcmS8g
 Q==
IronPort-HdrOrdr: A9a23:POdhsa0vP3vVfTLgLg4x8gqjBLUkLtp133Aq2lEZdPWaSKOlfq
 eV7ZMmPHDP6Qr5NEtMpTnEAtjjfZq+z+8Q3WBuB9eftWDd0QPCRr2Kr7GSpgEIcBeRygcy78
 tdmtBFeb7N5ZwQt7eC3OF+eOxQpuW6zA==
X-Talos-CUID: 9a23:W4CaxG6Xf3Mlc+F5P9sszVwOMPsvfU3kx1SACmLgK0dVToKYVgrF
X-Talos-MUID: 9a23:1gbVlQh687N21haFqxQY9cMpFdwyzqr2JWk2nYQrqtmbHxJdIm6ntWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,296,1728950400"; 
   d="scan'208";a="424460889"
Received: from alln-l-core-11.cisco.com ([173.36.16.148])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 21:42:05 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-11.cisco.com (Postfix) with ESMTP id 60753180001E5;
	Tue,  7 Jan 2025 21:42:05 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 386D920F2005; Tue,  7 Jan 2025 13:42:05 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v2 2/3] enic: Obtain the Link speed only after the link comes up
Date: Tue,  7 Jan 2025 13:41:58 -0800
Message-Id: <20250107214159.18807-3-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250107214159.18807-1-johndale@cisco.com>
References: <20250107214159.18807-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-11.cisco.com

The link speed is obtained in the RX adaptive coalescing function. It
was being called at probe time when the link may not be up. Change the
call to run after the Link comes up.

The impact of not getting the correct link speed was that the low end of
the adaptive interrupt range was always being set to 0 which could have
caused a slight increase in the number of RX interrupts.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 957efe73e41a..8109e9c484f6 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -466,6 +466,7 @@ static void enic_link_check(struct enic *enic)
 	if (link_status && !carrier_ok) {
 		netdev_info(enic->netdev, "Link UP\n");
 		netif_carrier_on(enic->netdev);
+		enic_set_rx_coal_setting(enic);
 	} else if (!link_status && carrier_ok) {
 		netdev_info(enic->netdev, "Link DOWN\n");
 		netif_carrier_off(enic->netdev);
@@ -3063,7 +3064,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	timer_setup(&enic->notify_timer, enic_notify_timer, 0);
 
 	enic_rfs_flw_tbl_init(enic);
-	enic_set_rx_coal_setting(enic);
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
-- 
2.35.2


