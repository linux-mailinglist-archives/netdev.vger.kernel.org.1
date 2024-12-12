Return-Path: <netdev+bounces-151429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E4A9EEC7E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5FB2840EB
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F8D216E12;
	Thu, 12 Dec 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEV6kDcQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE82215777
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017698; cv=none; b=tDOX42AVZ6WX/IN77qRSmKa8sblUaPXii9Ul5JrG7fxXj+ClcFvteeMuRUhPEzqnTbu3+tgW8qa0eONG3lTFBp8kUq/bJpnDl6Vxi2HgN74wGTBezlKDvQlHJtSt0q2HZjSBLA7bA1kYBXT1MN3e9WypruDxzGhmNw+Uyos2mvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017698; c=relaxed/simple;
	bh=zXIR2NuuIFC6dj7Hxelwy+WDqXYThMpEBsNF4dCWpUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjF++GuXlCr2ShqwIuO48Lsn4G8yi/K3UxTOxxLGpY1rnleFij0rA/kGnwux4rzzUec3q43YJpQgVzlc9AN6u7Oy70gAAyolCnfe1GkQRdOQs+GfzWkyyTnEtcax0qiaceSSz7P0U6F/VmMoheP3OVi8ihQZzYx1m6M7+f5Uhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEV6kDcQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734017695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJBxfCGWGRVTBMuIZgJFT97kyEa63qkWbjw3aPCqaY8=;
	b=YEV6kDcQlBY5Wp7WGWPUcyhJ0qkNnyLbfsXKzUEwXteu9aOFAgPXUI7FXfmD0vhg3ZUTYu
	9ygRt+QYd/TYaizVzrV5lYyxc3sJ+oL7I0w4ir6zY543iy7V9BR5CNyXCe3Bnyz2mFIXa3
	RBxKXxUckLxpZKxxC0txIgDfHfcHNDc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-2yc1YoOROWKvqFxaensUjw-1; Thu,
 12 Dec 2024 10:34:50 -0500
X-MC-Unique: 2yc1YoOROWKvqFxaensUjw-1
X-Mimecast-MFC-AGG-ID: 2yc1YoOROWKvqFxaensUjw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92476195609F;
	Thu, 12 Dec 2024 15:34:48 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.224.236])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00F07195605A;
	Thu, 12 Dec 2024 15:34:45 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Miroslav Lichvar <mlichvar@redhat.com>
Subject: [PATCH iwl-next 2/3] ice: lower the latency of GNSS reads
Date: Thu, 12 Dec 2024 16:34:16 +0100
Message-ID: <20241212153417.165919-3-mschmidt@redhat.com>
In-Reply-To: <20241212153417.165919-1-mschmidt@redhat.com>
References: <20241212153417.165919-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The E810 is connected to the u-blox GNSS module over I2C. The ice driver
periodically (every ~20ms) sends AdminQ commands to poll the u-blox for
available data. Most of the time, there's no data. When the u-blox
finally responds that data is available, usually it's around 800 bytes.
It can be more or less, depending on how many NMEA messages were
configured using ubxtool. ice then proceeds to read all the data.
AdminQ and I2C are slow. The reading is performed in chunks of 15 bytes.
ice reads all of the data before passing it to the kernel GNSS subsystem
and onwards to userspace.

Improve the NMEA message receiving latency. Pass each 15-bytes chunk to
userspace as soon as it's received.

Tested-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 29 +++++++----------------
 drivers/net/ethernet/intel/ice/ice_gnss.h |  6 ++++-
 2 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 9b1f970f4825..7922311d2545 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -88,10 +88,10 @@ static void ice_gnss_read(struct kthread_work *work)
 	unsigned long delay = ICE_GNSS_POLL_DATA_DELAY_TIME;
 	unsigned int i, bytes_read, data_len, count;
 	struct ice_aqc_link_topo_addr link_topo;
+	char buf[ICE_MAX_I2C_DATA_SIZE];
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	__be16 data_len_b;
-	char *buf = NULL;
 	u8 i2c_params;
 	int err = 0;
 
@@ -121,16 +121,6 @@ static void ice_gnss_read(struct kthread_work *work)
 		goto requeue;
 
 	/* The u-blox has data_len bytes for us to read */
-
-	data_len = min_t(typeof(data_len), data_len, PAGE_SIZE);
-
-	buf = (char *)get_zeroed_page(GFP_KERNEL);
-	if (!buf) {
-		err = -ENOMEM;
-		goto requeue;
-	}
-
-	/* Read received data */
 	for (i = 0; i < data_len; i += bytes_read) {
 		unsigned int bytes_left = data_len - i;
 
@@ -139,19 +129,18 @@ static void ice_gnss_read(struct kthread_work *work)
 
 		err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
 				      cpu_to_le16(ICE_GNSS_UBX_EMPTY_DATA),
-				      bytes_read, &buf[i], NULL);
+				      bytes_read, buf, NULL);
 		if (err)
-			goto free_buf;
+			goto requeue;
+
+		count = gnss_insert_raw(pf->gnss_dev, buf, bytes_read);
+		if (count != bytes_read)
+			dev_dbg(ice_pf_to_dev(pf),
+				"gnss_insert_raw ret=%d size=%d\n",
+				count, bytes_read);
 	}
 
-	count = gnss_insert_raw(pf->gnss_dev, buf, i);
-	if (count != i)
-		dev_dbg(ice_pf_to_dev(pf),
-			"gnss_insert_raw ret=%d size=%d\n",
-			count, i);
 	delay = ICE_GNSS_TIMER_DELAY_TIME;
-free_buf:
-	free_page((unsigned long)buf);
 requeue:
 	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work, delay);
 	if (err)
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.h b/drivers/net/ethernet/intel/ice/ice_gnss.h
index 15daf603ed7b..e0e939f1b102 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.h
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.h
@@ -8,7 +8,11 @@
 #define ICE_GNSS_POLL_DATA_DELAY_TIME	(HZ / 50) /* poll every 20 ms */
 #define ICE_GNSS_TIMER_DELAY_TIME	(HZ / 10) /* 0.1 second per message */
 #define ICE_GNSS_TTY_WRITE_BUF		250
-#define ICE_MAX_I2C_DATA_SIZE		FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M)
+/* ICE_MAX_I2C_DATA_SIZE is FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M).
+ * However, FIELD_MAX() does not evaluate to an integer constant expression,
+ * so it can't be used for the size of a non-VLA array.
+ */
+#define ICE_MAX_I2C_DATA_SIZE		15
 #define ICE_MAX_I2C_WRITE_BYTES		4
 
 /* u-blox ZED-F9T specific definitions */
-- 
2.47.1


