Return-Path: <netdev+bounces-241838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CDDC891BA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0DA0356933
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BF3161B3;
	Wed, 26 Nov 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axCXk882"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FBB305943
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150558; cv=none; b=gVdAJ4xhe1Vtwq3135r6HTkRhRITYp0igpdU6wotmUVMt9zaVthIktQame/ddsiLY4/KQpVp2JSaVP1prYN9g6nn8t1+R9sfnUgioQzIVeuSuRGzeKnq666VsXCsuOr3u6iVRTL1iwLV20clYkWF7jKrez9UkoCpyP9jQFJbHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150558; c=relaxed/simple;
	bh=R2y8l/KjnXJf3o8YkbNoqFJ4CfEN1+8geFr0UODzAHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fc9+XTwIGmyhgay5D5/i2BE17F13+4aA9E8rb1bClhES0sLzyfO0ia78xR4UwbIs8FXqXEmM3yG4pbyMXHfO4+lsw2bVHz/iMxon8NZ2OXxVsKra5TFn00xa9sCgcRlGO7CQJ395w3W7Bjpqs37PoPFtvrxvWZ3BiVqUo1N1JVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axCXk882; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764150555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nIbCRcyXpSwDfJlHCfXsHmm33BBMEQ9tSPjNLTIWWbE=;
	b=axCXk882IYFuRaYyPclhCL3r/NFcYqOK6RB4sHX6pc3/CDxz3SJVmlwsHEF6pcRVJZvqos
	77oJjm/clDsTaWe+hUGkjrddujcXUqKvs80D5p1uC2mqwmmDtA+bRZ5nkrVO9ENEEoFvHP
	YqxJSWVsEHqi1iY6Ym6DiUQQqyw8z4o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-_T7aow0FMQuVCKVuiLxYPw-1; Wed,
 26 Nov 2025 04:49:09 -0500
X-MC-Unique: _T7aow0FMQuVCKVuiLxYPw-1
X-Mimecast-MFC-AGG-ID: _T7aow0FMQuVCKVuiLxYPw_1764150547
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA9EE1956059;
	Wed, 26 Nov 2025 09:49:06 +0000 (UTC)
Received: from rhel-developer-toolbox (unknown [10.43.3.204])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE2F13001E83;
	Wed, 26 Nov 2025 09:49:01 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Tim Hostetler <thostet@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] iavf: Implement settime64 with -EOPNOTSUPP
Date: Wed, 26 Nov 2025 10:48:49 +0100
Message-ID: <20251126094850.2842557-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

ptp_clock_settime() assumes every ptp_clock has implemented settime64().
Stub it with -EOPNOTSUPP to prevent a NULL dereference.

The fix is similar to commit 329d050bbe63 ("gve: Implement settime64
with -EOPNOTSUPP").

Fixes: d734223b2f0d ("iavf: add initial framework for registering PTP clock")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index b4d5eda2e84f..9cbd8c154031 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -252,6 +252,12 @@ static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
 	return iavf_read_phc_indirect(adapter, ts, sts);
 }
 
+static int iavf_ptp_settime64(struct ptp_clock_info *info,
+			      const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  * iavf_ptp_cache_phc_time - Cache PHC time for performing timestamp extension
  * @adapter: private adapter structure
@@ -320,6 +326,7 @@ static int iavf_ptp_register_clock(struct iavf_adapter *adapter)
 		 KBUILD_MODNAME, dev_name(dev));
 	ptp_info->owner = THIS_MODULE;
 	ptp_info->gettimex64 = iavf_ptp_gettimex64;
+	ptp_info->settime64 = iavf_ptp_settime64;
 	ptp_info->do_aux_work = iavf_ptp_do_aux_work;
 
 	clock = ptp_clock_register(ptp_info, dev);
-- 
2.51.1


