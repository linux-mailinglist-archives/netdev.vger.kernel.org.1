Return-Path: <netdev+bounces-151430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D59EECB3
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2038188D4D8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96692210CA;
	Thu, 12 Dec 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfTQiBsC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682D1547F0
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017699; cv=none; b=s8CKbWGPHVqSVypZBr4C7AJFpWBDaz/s9yGb8M0jhS1Hs6DTnxDUaO9Hx/opqQvnk/DpU1DPTngnK5Xo6QXxNFjUnAjQdVtxqs5iSpa53qvdZcp7slXkiMEEEuQERhn+Ll3BZ+KqSkgqi/nAuQkYl/+ouDbEWeLibzm0pKZH3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017699; c=relaxed/simple;
	bh=C57TKEpLKHLYwxxb5Nfo8nwCv4fS7Uymf4LiqSL7lx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jX7rHfy+GqrsPTnR7HC6Va46PHHwxiRvccMWdAx9MtDaEiUCDn6NTscp8fhsBvUYXRkjCvRjJ9YNu8RWdTn/mGV5mfCOhNFA3dtgRagTcT8FYxZttBPvDjwPpZiwgxFldTeFt1aEecGwX3ffUUF10yY1hWSpW6y1FBwptsVMBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfTQiBsC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734017697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgRpHTP53KJoPgmSVqas3EAYkmn+eljsiKnfwFmp98Y=;
	b=CfTQiBsCamrKTUyRldnjNlUX+/GyJaVNAkaOe2My5gwiJ9lmbP75xsusO3C9RCZEpG5ish
	fpEW7Ei81MeDrlfJMd5KRlAKiQr53vXUKCbgAvC+LvvfdTA7xEI2xurLYZfBssx4UfSqPp
	zr6pEA/K8HZFHgNvNb3+cLcKkymo1qY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-wnFhZv6mNTinhUTJ6RY-Jw-1; Thu,
 12 Dec 2024 10:34:52 -0500
X-MC-Unique: wnFhZv6mNTinhUTJ6RY-Jw-1
X-Mimecast-MFC-AGG-ID: wnFhZv6mNTinhUTJ6RY-Jw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E91A1955D45;
	Thu, 12 Dec 2024 15:34:51 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.224.236])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23C02195606C;
	Thu, 12 Dec 2024 15:34:48 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-next 3/3] ice: remove special delay after processing a GNSS read batch
Date: Thu, 12 Dec 2024 16:34:17 +0100
Message-ID: <20241212153417.165919-4-mschmidt@redhat.com>
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

I do not see a reason to have a special longer delay (100 ms) after
passing read GNSS data to userspace.

Just use the regular GNSS polling interval (20 ms).

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 5 ++---
 drivers/net/ethernet/intel/ice/ice_gnss.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 7922311d2545..83a2f0d4091e 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -85,7 +85,6 @@ static void ice_gnss_read(struct kthread_work *work)
 {
 	struct gnss_serial *gnss = container_of(work, struct gnss_serial,
 						read_work.work);
-	unsigned long delay = ICE_GNSS_POLL_DATA_DELAY_TIME;
 	unsigned int i, bytes_read, data_len, count;
 	struct ice_aqc_link_topo_addr link_topo;
 	char buf[ICE_MAX_I2C_DATA_SIZE];
@@ -140,9 +139,9 @@ static void ice_gnss_read(struct kthread_work *work)
 				count, bytes_read);
 	}
 
-	delay = ICE_GNSS_TIMER_DELAY_TIME;
 requeue:
-	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work, delay);
+	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work,
+				   ICE_GNSS_POLL_DATA_DELAY_TIME);
 	if (err)
 		dev_dbg(ice_pf_to_dev(pf), "GNSS failed to read err=%d\n", err);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.h b/drivers/net/ethernet/intel/ice/ice_gnss.h
index e0e939f1b102..fa52727cd3d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.h
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.h
@@ -6,7 +6,6 @@
 
 #define ICE_E810T_GNSS_I2C_BUS		0x2
 #define ICE_GNSS_POLL_DATA_DELAY_TIME	(HZ / 50) /* poll every 20 ms */
-#define ICE_GNSS_TIMER_DELAY_TIME	(HZ / 10) /* 0.1 second per message */
 #define ICE_GNSS_TTY_WRITE_BUF		250
 /* ICE_MAX_I2C_DATA_SIZE is FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M).
  * However, FIELD_MAX() does not evaluate to an integer constant expression,
-- 
2.47.1


