Return-Path: <netdev+bounces-138467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE5F9ADB9D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 07:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E599B2216E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 05:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2067816FF4E;
	Thu, 24 Oct 2024 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux0ok2tA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB32C8F0;
	Thu, 24 Oct 2024 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729748732; cv=none; b=hcc8GyBaH4sGKipmeaWtBOv4BLF1tRBdc8WQyjr1oKfGbAejO1SmOcZQR0y1dWdR2w/YVoVD6nDuyQMPT7eDbwUz4eIyEvrt+YJ+ve5oFpMvMlF8JK3Zhzq62/Op8glw+GwGwezyTYONKYyl5EDZ/OzwwMfzc59QG4Sviih3mOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729748732; c=relaxed/simple;
	bh=5Kh7/4MGgP/bL0WqxKoOsC5yzfBXVVaNAxEjN0DLaVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LAoHA7rieqfs5FH9OQJLjkbamJyqweLEIT/lY79nqz7rTxdOdjvJZMa4OMudqPCaxbil4+9b1+D15MqIvML7+prjab1y9QvDqq5+L1+RIwsKn33iELGOv1f4FG93t0YLfSV/lcOEyvhLCYHKy7YfWisKGVsTpMwswnt8LImNZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux0ok2tA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso445560a91.3;
        Wed, 23 Oct 2024 22:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729748729; x=1730353529; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+yyo1TIYgMMh3a4MAR/ug/Ems+Ey9XMLLo9KFQKqZY=;
        b=Ux0ok2tAQNSMqOgNiTm9QmVDtQdH/xK7lPMDIg8sCvtV+6dwQn+TJc15HbGCEMO771
         /Ws/XIKWlQqBTWQpmKbqiyNzWPFnU6EdRpPV4xF8PNwf+YiDG3X5U+3OJdTOW4r3miUA
         l0fOMYnbA8zPIIF8ME+Wdlv135QfHzrRRmGsh62G7TVgpPOjcuApCDTmdYbB6RIWl4Aw
         4x0Nm3jM7JCpmtePmsRcTbq2+Tm0RmDpBcRcOtSLJzuT+reVHxMQZ73ijgm0kMJboPQX
         zoSQL+vPjDXaFTza/dhbUGN0PPV7niYD5IplhFErUMo5kDunOnM2CAFohkHDTytcpa1i
         G1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729748729; x=1730353529;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+yyo1TIYgMMh3a4MAR/ug/Ems+Ey9XMLLo9KFQKqZY=;
        b=rmmVMMiBb54JVwbKjJoXrgMM2P+jrYQr1gKN4TwYtRjLPWNqT8Q/5d7lP+Gr0sIv+Y
         TN0X/HwwMVQelRGNj6TUxxy4wxbrVPVACyuW+mApiJ/Gmm5G40kKw1I8E1rGAaFphJQE
         aF1GOJ9bbe3PEVSwhM0A93jualcDhCf16bwZRM8y7nhHe/jmXYmNnKrf34N9TbWjQxB1
         8QOsmoHjIn8ClHIOsTi+kHito0w1PEBfWmlX8pijm0wJ/izwW5ZQH6neDKJ+NsuzNp4q
         nAnlm9ZngOOm6FYddl9/uBUv/uydpTY5hp5qsqjIJIVzN9rxA3TkYXedLQk9Xo0+z0d4
         vjrg==
X-Forwarded-Encrypted: i=1; AJvYcCW08Ien6uV2ttxHRAqNkFwLCOV2QW7ZnhY8SUaoY51ITEIPOKt3uEsas3SVwjfx2mAVvhwj9VOI4kMuHydc@vger.kernel.org, AJvYcCWczy3zsLnv13QYaxVPeBVlq1nNQRHxmKUwLWSikBAePa+lSf9tnj8Ckp8C7Rk/EaLJNCP2TS5GcupY29FH5NY=@vger.kernel.org, AJvYcCX4TkmN1m0L6G8NFkZ3DtK9bDjGyQUJ4C1y2mh5dSwvv84JvR6UPtmzScw6oIGH/5Mg9UZxTazJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxffIvdROwHD0nKuB3fQSIrS7hJj/S+QDn4G9vW/Vs+MbdSAmvo
	JxF+aBzurme6Fy8KeuHdKT5XJd3Gl7/Zel+ShaoVvk9F+cKTBgy+
X-Google-Smtp-Source: AGHT+IGMu0wQIJyQYyM3MtZTwmXTHeotULXZZLZmunxl49BuoVTVKzIpHI0TTzuue/lTyTnLwc7E2g==
X-Received: by 2002:a05:6a20:c998:b0:1d5:10c1:4939 with SMTP id adf61e73a8af0-1d978aeadf1mr5532925637.8.1729748729310;
        Wed, 23 Oct 2024 22:45:29 -0700 (PDT)
Received: from Fantasy-Ubuntu ([2001:56a:7eb6:f700:c21b:c597:f9a6:3608])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76df7095dsm2532477a91.29.2024.10.23.22.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 22:45:28 -0700 (PDT)
Date: Wed, 23 Oct 2024 23:45:26 -0600
From: Johnny Park <pjohnny0508@gmail.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	pmenzel@molgen.mpg.de
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] [net-next] igb: Fix 2 typos in comments in igb_main.c
Message-ID: <Zxne9hBl5E5VhKGm@Fantasy-Ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix 2 spelling mistakes in comments in `igb_main.c`.

Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
---
Changes in v3:
  - Adjust commit message

Changes in v2:
  - Fix spelling mor -> more
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ef4cb871452..fc587304b3c0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1204,7 +1204,7 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 	/* initialize pointer to rings */
 	ring = q_vector->ring;
 
-	/* intialize ITR */
+	/* initialize ITR */
 	if (rxr_count) {
 		/* rx or rx/tx vector */
 		if (!adapter->rx_itr_setting || adapter->rx_itr_setting > 3)
@@ -3906,7 +3906,7 @@ static void igb_remove(struct pci_dev *pdev)
  *
  *  This function initializes the vf specific data storage and then attempts to
  *  allocate the VFs.  The reason for ordering it this way is because it is much
- *  mor expensive time wise to disable SR-IOV than it is to allocate and free
+ *  more expensive time wise to disable SR-IOV than it is to allocate and free
  *  the memory for the VFs.
  **/
 static void igb_probe_vfs(struct igb_adapter *adapter)
-- 
2.43.0


