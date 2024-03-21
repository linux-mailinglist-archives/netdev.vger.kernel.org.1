Return-Path: <netdev+bounces-81077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D187885B00
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E321C21299
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF984AEFA;
	Thu, 21 Mar 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBwxzanv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA598528B
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032140; cv=none; b=k0ZWRYiPOBQmnojcG4AB3EVMpnlvz8lwbgxgkTBAMCG9IlOgP2FtD3/dJoC0bfVYXR/l9Tvjix1iUvcM+R/n99nxHFlSlJMLLDVdPxmiisWjJDUlGToiXQDFW9GWms6+CxNjMZmhVqaVeI1pcrJvBvBvNl0SksQWKyxIru2aY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032140; c=relaxed/simple;
	bh=CC5tFlvb6hxX+73XEyTK2FHB+Fg2sdLVzyHaoXKDxxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZhLdM1F9qclSUwi+ByDFFFRQ7uZGwT90u/z2mQPJ4fA5WqUYdEY56NMitv4AQPJtGYVhZqE3vaghUDIhIcGF8nsT5Ct7fVki0kzj2lKGk+o/JTBa2DB61EYVtKqY6+5a8I1RqVtxswdY546JxG+YfHxQXV99+cjZQrD5csvambc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RBwxzanv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-414701303f7so10045635e9.2
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711032137; x=1711636937; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLs/dDV1UD9+YTTOWzQvPyGzkwzyhPvhdwP32+SNXh8=;
        b=RBwxzanv2rj2p2ADfn9Vw/TjOlUrTun+CinbNdFGyS6Xi6evn545M7nJYJMT1E3+F3
         RlNB7l1awItx5LNlhGBWDCePV4tNXmdSzgn1GSLeIokqaUAPg3UILmgTRx8y2jUMdGoe
         02YDC6I8Fs8q1dhM1fzIWaNjhnVpYgTvNwNhBK6Ng1NEOUUzcfMQSd06pnmAg/gOINEp
         ApS55dZZf3J4nkGqq/tE5qvUr2s8mxZTcw3KsTlVzwYJ/hrTqgF+w4OFaNh9oSaYOvVR
         3tIhGrAALBb/eDEIdV6dBscDhtORw2S+IpbquwG6YZTlEC0KYCQGZ42sijLDCEpOtzSn
         jBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032137; x=1711636937;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLs/dDV1UD9+YTTOWzQvPyGzkwzyhPvhdwP32+SNXh8=;
        b=k+DFCLBGQK6fjte5nB6tDTdKmuWBNdZnVliIuVeBVDCKZlhVRyE+RIaE3RVWn4z6TN
         0yVqJBcC1UADovuXA9z8JMHRNUDIYOgU/FP8Z55BShhsQi5xXX+z1y3aZhU9CUcVSxiq
         CS9hbWGbCnJKC1kEx1ph7lAlkM2bG6q0SzPjFnYyJwehzCYFDJ0ER+mrPrK5prlXzRYI
         y3TIF1NnrV0AnG8p8LAn6rpa7wYMm7I8IpsCilX4rIywOFV8a+5zBPEvZovd0WWTFnRp
         5HxcBIPF8U4Pn52f2HXdyLhU76bg8BDfHY87hg8KSSPSKVoHtiMF19IzKyYyUL+Xf0ed
         53fA==
X-Forwarded-Encrypted: i=1; AJvYcCVkhn28JInELvGx2AK8cs46W3fmFt68EmQaLyBj2DnMR4D5D6uuLEx3ZYZ+HPyCvumbrb8r3Gc9GuN5EVTLY3T6EX5ddP8n
X-Gm-Message-State: AOJu0YxluikyftgzIN5l9SaFa0yPsbVasjFBTlDp/yX9RV20hjtGMphD
	E1upEj8UY+Nr44602sYl+QedkBEHAdrJbQAjDrCJM4hNrUlWC45yVn3hAHu76Gg=
X-Google-Smtp-Source: AGHT+IHuznWK1fDYECLfnbOiy0mQQtyDxu46Imz0+SQb6QkWQ7xPr240wa5yVilN5FQsTLQzECoF3Q==
X-Received: by 2002:a05:600c:3546:b0:413:feed:b309 with SMTP id i6-20020a05600c354600b00413feedb309mr2132109wmq.6.1711032136402;
        Thu, 21 Mar 2024 07:42:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n31-20020a05600c3b9f00b00414037f27a9sm5870295wms.31.2024.03.21.07.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:42:16 -0700 (PDT)
Date: Thu, 21 Mar 2024 17:42:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net] ice: Fix freeing uninitialized pointers
Message-ID: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Automatically cleaned up pointers need to be initialized before exiting
their scope.  In this case, they need to be initialized to NULL before
any return statement.

Fixes: 90f821d72e11 ("ice: avoid unnecessary devm_ usage")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: I missed a couple pointers in v1.

The change to ice_update_link_info() isn't required because it's
assigned on the very next line...  But I did that because it's harmless
and makes __free() stuff easier to verify.  I felt like moving the
declarations into the code would be controversial and it also ends up
making the lines really long.

		goto goto err_unroll_sched;

	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) =
		kzalloc(sizeof(*pcaps), GFP_KERNEL);

 drivers/net/ethernet/intel/ice/ice_common.c | 10 +++++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
 2 file changed, 6 insertion(+), 6 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 4d8111aeb0ff..6f2db603b36e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1002,8 +1002,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
  */
 int ice_init_hw(struct ice_hw *hw)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
-	void *mac_buf __free(kfree);
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
+	void *mac_buf __free(kfree) = NULL;
 	u16 mac_buf_len;
 	int status;
 
@@ -3272,7 +3272,7 @@ int ice_update_link_info(struct ice_port_info *pi)
 		return status;
 
 	if (li->link_info & ICE_AQ_MEDIA_AVAILABLE) {
-		struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
+		struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
 
 		pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 		if (!pcaps)
@@ -3420,7 +3420,7 @@ ice_cfg_phy_fc(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 int
 ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
 	struct ice_aqc_set_phy_cfg_data cfg = { 0 };
 	struct ice_hw *hw;
 	int status;
@@ -3561,7 +3561,7 @@ int
 ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 		enum ice_fec_mode fec)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
 	struct ice_hw *hw;
 	int status;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 255a9c8151b4..78b833b3e1d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -941,11 +941,11 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
 	struct ice_pf *pf = orig_vsi->back;
+	u8 *tx_frame __free(kfree) = NULL;
 	u8 broadcast[ETH_ALEN], ret = 0;
 	int num_frames, valid_frames;
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
-	u8 *tx_frame __free(kfree);
 	int i;
 
 	netdev_info(netdev, "loopback test\n");
-- 
2.43.0



