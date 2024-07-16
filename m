Return-Path: <netdev+bounces-111802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920CD932EBC
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 18:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4878E282D11
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03A19F468;
	Tue, 16 Jul 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qylbn4qv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D34619ADBE
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149035; cv=none; b=A7g2MjRxlEHaIi190seGx7A97Mz5S/YpKluOGbQw+BBp0rzg4H8CLMfPVYfGWiN2g3DI4r3G1Z46+DvtQjgbXnZSriViRAWBKN3CvftrySnkWknuSO/q2rZQaEYAyf9qLH44bp/Rc0xn+rBmGaMIAIQGCJC69G8UkVPqN7ZIefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149035; c=relaxed/simple;
	bh=+WEwJtQmNFz6Fgf2o32vnZLHKWv4UEs9o7rEqZx7nUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wf0w3C06Zyb1p45q//9XE/md4Sa2jze3Jx06OUDPwssL4Cokl40pliqnmBIiX68IbRDWGe9hpPxeu/K9z9cAKhKVOU93jEvOFh5osiYd+TaG8dDm2iKaLc5vVw+ftpfLACoWh9aV/mE5QR3+q3J/PVWpdUnsH0Iu19DDd94npco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qylbn4qv; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-708cf5138b6so1879019a34.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721149032; x=1721753832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HjkM0fbgW4Xibz/XMDT5sJRhMp7xdz/ejU4/CeTrp3w=;
        b=Qylbn4qvr4Q+dugCrcfYwhtHT+f8i+qtn6cc5ZjM18TDUQ0v2UBZZA4z2I7M92UBM0
         5D8PkIlZ+rKy/gWKOiAF9XR9XZ5A34RPi1+bOw12+Rh/A/KB7q2mjSCAGvCSZiAJPT54
         DmGXw5Inehpo4p/c4sdF1deag0HEWizJd5q9bPp2Gs1UO/fzmcjvPQkvMZbjndspPkid
         kWgeBhL3nCv/MIW7HFVAMOn15Sa3zEGDUX0IxiVgtwcko60ge28yqFnbC2qdTB6Ajgr6
         UWWXTUPPzKFRrzT/xOITs6vpISVsaJTjiw+DfNgenmUBKND4J1E6qItqS4GawHHx7oBt
         1RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721149032; x=1721753832;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjkM0fbgW4Xibz/XMDT5sJRhMp7xdz/ejU4/CeTrp3w=;
        b=WNr/12HlscJRd1VlMd60U7Prd/FZ9EKM6yEHx4Z1orG1YS/i0nHiaCxnHF3gH6eLMw
         Br1yCAgtcg7ySRikeHQI74dNH07b1sTWTFuBPmNOvXVkQJyo2W0PvLXinefIhjMUF+bx
         m99eChywis+dS/aW8bLHqclOV9K0tkcp+qfosLzoMQbmnT96fcDfBlnNttCUvlcFgGxH
         2wcuCusMe5fUJcXo9ViTiJWdc5ze5JHUCzFmHiQNuolfk0l9o4OMgVj8Ne+vXrXEvL0m
         8VEn4OjLRoKKp4PafEmJ6M7GtYmRDt5O9qEShkBw2fJmMjMtmtQjfttHaYgyTS7+GSHI
         upgA==
X-Forwarded-Encrypted: i=1; AJvYcCUlDZBG82RZ+ZdSG/kOkNa2mBKzHqC9TeQfi3Bc37iKF/5CDGzxN5w5VcAhcVImrxASChpD8BYJvZJeE2q+ps7YZhve6ely
X-Gm-Message-State: AOJu0YwepI0/oS9qE992sJJXTeoWik5f/G03b9R28kko6oEM5JgmO+6U
	PatQGeG/wMAgtncsWjPNCiwqIv7E7fzykDFy52QebJc4CnZtqcyqC8g9MKMkln0=
X-Google-Smtp-Source: AGHT+IHwHuHUEtahEJi2/XAfyKDCh1Uvg+qhHUpEpDPGVV6h8gOsQvlPHHyM2YgDYy98evYFe+e56A==
X-Received: by 2002:a05:6830:6b04:b0:708:b334:de64 with SMTP id 46e09a7af769-708d9950cfamr4208306a34.13.1721149032176;
        Tue, 16 Jul 2024 09:57:12 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:b5d2:9b28:de1e:aebb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0d29022sm1363431a34.73.2024.07.16.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:57:11 -0700 (PDT)
Date: Tue, 16 Jul 2024 11:57:09 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Michael Chan <michael.chan@broadcom.com>,
	davem@davemloft.net
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 4/9] bnxt_en: Deprecate support for legacy INTX
 mode
Message-ID: <48cd9096-7f25-4a89-bd10-f5124abac4af@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-5-michael.chan@broadcom.com>

Hi Michael,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Chan/bnxt_en-add-support-for-storing-crash-dump-into-host-memory/20240714-074731
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240713234339.70293-5-michael.chan%40broadcom.com
patch subject: [PATCH net-next 4/9] bnxt_en: Deprecate support for legacy INTX mode
config: i386-randconfig-141-20240716 (https://download.01.org/0day-ci/archive/20240716/202407162324.caSQMdc3-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202407162324.caSQMdc3-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/broadcom/bnxt/bnxt.c:15950 bnxt_init_one() warn: 'dev' from register_netdev() not released on lines: 15719.

Old smatch warnings:
drivers/net/ethernet/broadcom/bnxt/bnxt.c:769 bnxt_start_xmit() error: we previously assumed 'ptp' could be null (see line 514)

vim +/dev +15950 drivers/net/ethernet/broadcom/bnxt/bnxt.c

c0c050c58d84099 Michael Chan        2015-10-22  15681  static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
c0c050c58d84099 Michael Chan        2015-10-22  15682  {
f42822f22b1c5f7 Michael Chan        2024-02-05  15683  	struct bnxt_hw_resc *hw_resc;
c0c050c58d84099 Michael Chan        2015-10-22  15684  	struct net_device *dev;
c0c050c58d84099 Michael Chan        2015-10-22  15685  	struct bnxt *bp;
6e6c5a57fbe1c77 Michael Chan        2016-01-02  15686  	int rc, max_irqs;
c0c050c58d84099 Michael Chan        2015-10-22  15687  
4e00338a61998de Ray Jui             2017-02-20  15688  	if (pci_is_bridge(pdev))
fa853dda19a1878 Prashant Sreedharan 2016-07-18  15689  		return -ENODEV;
fa853dda19a1878 Prashant Sreedharan 2016-07-18  15690  
8743db4a9acfd51 Vasundhara Volam    2020-02-20  15691  	/* Clear any pending DMA transactions from crash kernel
8743db4a9acfd51 Vasundhara Volam    2020-02-20  15692  	 * while loading driver in capture kernel.
8743db4a9acfd51 Vasundhara Volam    2020-02-20  15693  	 */
8743db4a9acfd51 Vasundhara Volam    2020-02-20  15694  	if (is_kdump_kernel()) {
8743db4a9acfd51 Vasundhara Volam    2020-02-20  15695  		pci_clear_master(pdev);
8743db4a9acfd51 Vasundhara Volam    2020-02-20  15696  		pcie_flr(pdev);
8743db4a9acfd51 Vasundhara Volam    2020-02-20  15697  	}
8743db4a9acfd51 Vasundhara Volam    2020-02-20  15698  
c0c050c58d84099 Michael Chan        2015-10-22  15699  	max_irqs = bnxt_get_max_irq(pdev);
ba098017791eb8a Michael Chan        2023-11-13  15700  	dev = alloc_etherdev_mqs(sizeof(*bp), max_irqs * BNXT_MAX_QUEUE,
ba098017791eb8a Michael Chan        2023-11-13  15701  				 max_irqs);
c0c050c58d84099 Michael Chan        2015-10-22  15702  	if (!dev)
c0c050c58d84099 Michael Chan        2015-10-22  15703  		return -ENOMEM;
c0c050c58d84099 Michael Chan        2015-10-22  15704  
c0c050c58d84099 Michael Chan        2015-10-22  15705  	bp = netdev_priv(dev);
c7dd4a5b0a155c4 Edwin Peer          2021-10-29  15706  	bp->board_idx = ent->driver_data;
8fb35cd302f74e6 Michael Chan        2020-10-12  15707  	bp->msg_enable = BNXT_DEF_MSG_ENABLE;
9c1fabdf424f273 Michael Chan        2018-10-14  15708  	bnxt_set_max_func_irqs(bp, max_irqs);
c0c050c58d84099 Michael Chan        2015-10-22  15709  
c7dd4a5b0a155c4 Edwin Peer          2021-10-29  15710  	if (bnxt_vf_pciid(bp->board_idx))
c0c050c58d84099 Michael Chan        2015-10-22  15711  		bp->flags |= BNXT_FLAG_VF;
c0c050c58d84099 Michael Chan        2015-10-22  15712  
0020ae2a4aa81be Vikas Gupta         2022-12-26  15713  	/* No devlink port registration in case of a VF */
0020ae2a4aa81be Vikas Gupta         2022-12-26  15714  	if (BNXT_PF(bp))
0020ae2a4aa81be Vikas Gupta         2022-12-26  15715  		SET_NETDEV_DEVLINK_PORT(dev, &bp->dl_port);
0020ae2a4aa81be Vikas Gupta         2022-12-26  15716  
5c11f6d07a2994d Michael Chan        2024-07-13  15717  	if (!pdev->msix_cap) {
5c11f6d07a2994d Michael Chan        2024-07-13  15718  		dev_err(&pdev->dev, "MSIX capability not found, aborting\n");
5c11f6d07a2994d Michael Chan        2024-07-13  15719  		return -ENODEV;


	rc = -ENODEV;
	goto init_err_free;

5c11f6d07a2994d Michael Chan        2024-07-13  15720  	}
c0c050c58d84099 Michael Chan        2015-10-22  15721  
c0c050c58d84099 Michael Chan        2015-10-22  15722  	rc = bnxt_init_board(pdev, dev);
c0c050c58d84099 Michael Chan        2015-10-22  15723  	if (rc < 0)
c0c050c58d84099 Michael Chan        2015-10-22  15724  		goto init_err_free;
c0c050c58d84099 Michael Chan        2015-10-22  15725  
c0c050c58d84099 Michael Chan        2015-10-22  15726  	dev->netdev_ops = &bnxt_netdev_ops;
af7b3b4adda592c Jakub Kicinski      2024-03-06  15727  	dev->stat_ops = &bnxt_stat_ops;
c0c050c58d84099 Michael Chan        2015-10-22  15728  	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
c0c050c58d84099 Michael Chan        2015-10-22  15729  	dev->ethtool_ops = &bnxt_ethtool_ops;
2d694c27d32efc9 David Wei           2024-06-18  15730  	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
c0c050c58d84099 Michael Chan        2015-10-22  15731  	pci_set_drvdata(pdev, dev);
c0c050c58d84099 Michael Chan        2015-10-22  15732  
3e8060fa837630f Prashant Sreedharan 2016-07-18  15733  	rc = bnxt_alloc_hwrm_resources(bp);
3e8060fa837630f Prashant Sreedharan 2016-07-18  15734  	if (rc)
17086399c113d93 Sathya Perla        2017-02-20  15735  		goto init_err_pci_clean;
3e8060fa837630f Prashant Sreedharan 2016-07-18  15736  
3e8060fa837630f Prashant Sreedharan 2016-07-18  15737  	mutex_init(&bp->hwrm_cmd_lock);
ba642ab773db97c Michael Chan        2019-08-29  15738  	mutex_init(&bp->link_lock);
3e8060fa837630f Prashant Sreedharan 2016-07-18  15739  
7c3809181468a21 Michael Chan        2019-07-29  15740  	rc = bnxt_fw_init_one_p1(bp);
e605db801bdeb9d Deepak Khungar      2017-05-29  15741  	if (rc)
e605db801bdeb9d Deepak Khungar      2017-05-29  15742  		goto init_err_pci_clean;
e605db801bdeb9d Deepak Khungar      2017-05-29  15743  
3e3c09b0e999f51 Vasundhara Volam    2021-01-25  15744  	if (BNXT_PF(bp))
3e3c09b0e999f51 Vasundhara Volam    2021-01-25  15745  		bnxt_vpd_read_info(bp);
3e3c09b0e999f51 Vasundhara Volam    2021-01-25  15746  
1c7fd6ee2fe4ec6 Randy Schacher      2023-11-20  15747  	if (BNXT_CHIP_P5_PLUS(bp)) {
1c7fd6ee2fe4ec6 Randy Schacher      2023-11-20  15748  		bp->flags |= BNXT_FLAG_CHIP_P5_PLUS;
a432a45bdba4387 Michael Chan        2023-12-01  15749  		if (BNXT_CHIP_P7(bp))
a432a45bdba4387 Michael Chan        2023-12-01  15750  			bp->flags |= BNXT_FLAG_CHIP_P7;
9d6b648c3112012 Michael Chan        2020-09-27  15751  	}
e38287b72ec5455 Michael Chan        2018-10-14  15752  
46e457a454de1d9 Jakub Kicinski      2024-07-11  15753  	rc = bnxt_alloc_rss_indir_tbl(bp);
5fa65524f6e0b95 Edwin Peer          2020-08-26  15754  	if (rc)
5fa65524f6e0b95 Edwin Peer          2020-08-26  15755  		goto init_err_pci_clean;
5fa65524f6e0b95 Edwin Peer          2020-08-26  15756  
7c3809181468a21 Michael Chan        2019-07-29  15757  	rc = bnxt_fw_init_one_p2(bp);
3c2217a675bac22 Michael Chan        2017-03-08  15758  	if (rc)
3c2217a675bac22 Michael Chan        2017-03-08  15759  		goto init_err_pci_clean;
3c2217a675bac22 Michael Chan        2017-03-08  15760  
8ae2473842bdbb9 Michael Chan        2020-05-04  15761  	rc = bnxt_map_db_bar(bp);
8ae2473842bdbb9 Michael Chan        2020-05-04  15762  	if (rc) {
8ae2473842bdbb9 Michael Chan        2020-05-04  15763  		dev_err(&pdev->dev, "Cannot map doorbell BAR rc = %d, aborting\n",
8ae2473842bdbb9 Michael Chan        2020-05-04  15764  			rc);
8ae2473842bdbb9 Michael Chan        2020-05-04  15765  		goto init_err_pci_clean;
8ae2473842bdbb9 Michael Chan        2020-05-04  15766  	}
8ae2473842bdbb9 Michael Chan        2020-05-04  15767  
c0c050c58d84099 Michael Chan        2015-10-22  15768  	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SG |
c0c050c58d84099 Michael Chan        2015-10-22  15769  			   NETIF_F_TSO | NETIF_F_TSO6 |
c0c050c58d84099 Michael Chan        2015-10-22  15770  			   NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_GRE |
7e13318daa4a67b Tom Herbert         2016-05-18  15771  			   NETIF_F_GSO_IPXIP4 |
152971ee75fddbc Alexander Duyck     2016-05-02  15772  			   NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
152971ee75fddbc Alexander Duyck     2016-05-02  15773  			   NETIF_F_GSO_PARTIAL | NETIF_F_RXHASH |
3e8060fa837630f Prashant Sreedharan 2016-07-18  15774  			   NETIF_F_RXCSUM | NETIF_F_GRO;
feeef68f6f3d21a Michael Chan        2023-12-11  15775  	if (bp->flags & BNXT_FLAG_UDP_GSO_CAP)
feeef68f6f3d21a Michael Chan        2023-12-11  15776  		dev->hw_features |= NETIF_F_GSO_UDP_L4;
3e8060fa837630f Prashant Sreedharan 2016-07-18  15777  
e38287b72ec5455 Michael Chan        2018-10-14  15778  	if (BNXT_SUPPORTS_TPA(bp))
3e8060fa837630f Prashant Sreedharan 2016-07-18  15779  		dev->hw_features |= NETIF_F_LRO;
c0c050c58d84099 Michael Chan        2015-10-22  15780  
c0c050c58d84099 Michael Chan        2015-10-22  15781  	dev->hw_enc_features =
c0c050c58d84099 Michael Chan        2015-10-22  15782  			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_SG |
c0c050c58d84099 Michael Chan        2015-10-22  15783  			NETIF_F_TSO | NETIF_F_TSO6 |
c0c050c58d84099 Michael Chan        2015-10-22  15784  			NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_GRE |
152971ee75fddbc Alexander Duyck     2016-05-02  15785  			NETIF_F_GSO_UDP_TUNNEL_CSUM | NETIF_F_GSO_GRE_CSUM |
7e13318daa4a67b Tom Herbert         2016-05-18  15786  			NETIF_F_GSO_IPXIP4 | NETIF_F_GSO_PARTIAL;
feeef68f6f3d21a Michael Chan        2023-12-11  15787  	if (bp->flags & BNXT_FLAG_UDP_GSO_CAP)
feeef68f6f3d21a Michael Chan        2023-12-11  15788  		dev->hw_enc_features |= NETIF_F_GSO_UDP_L4;
77b0fff55dcd34b Michael Chan        2023-12-11  15789  	if (bp->flags & BNXT_FLAG_CHIP_P7)
77b0fff55dcd34b Michael Chan        2023-12-11  15790  		dev->udp_tunnel_nic_info = &bnxt_udp_tunnels_p7;
77b0fff55dcd34b Michael Chan        2023-12-11  15791  	else
442a35a5a7aa727 Jakub Kicinski      2020-07-09  15792  		dev->udp_tunnel_nic_info = &bnxt_udp_tunnels;
442a35a5a7aa727 Jakub Kicinski      2020-07-09  15793  
152971ee75fddbc Alexander Duyck     2016-05-02  15794  	dev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM |
152971ee75fddbc Alexander Duyck     2016-05-02  15795  				    NETIF_F_GSO_GRE_CSUM;
c0c050c58d84099 Michael Chan        2015-10-22  15796  	dev->vlan_features = dev->hw_features | NETIF_F_HIGHDMA;
1da63ddd0e15527 Edwin Peer          2020-07-08  15797  	if (bp->fw_cap & BNXT_FW_CAP_VLAN_RX_STRIP)
1da63ddd0e15527 Edwin Peer          2020-07-08  15798  		dev->hw_features |= BNXT_HW_FEATURE_VLAN_ALL_RX;
1da63ddd0e15527 Edwin Peer          2020-07-08  15799  	if (bp->fw_cap & BNXT_FW_CAP_VLAN_TX_INSERT)
1da63ddd0e15527 Edwin Peer          2020-07-08  15800  		dev->hw_features |= BNXT_HW_FEATURE_VLAN_ALL_TX;
e38287b72ec5455 Michael Chan        2018-10-14  15801  	if (BNXT_SUPPORTS_TPA(bp))
1054aee82321483 Michael Chan        2017-12-16  15802  		dev->hw_features |= NETIF_F_GRO_HW;
c0c050c58d84099 Michael Chan        2015-10-22  15803  	dev->features |= dev->hw_features | NETIF_F_HIGHDMA;
1054aee82321483 Michael Chan        2017-12-16  15804  	if (dev->features & NETIF_F_GRO_HW)
1054aee82321483 Michael Chan        2017-12-16  15805  		dev->features &= ~NETIF_F_LRO;
c0c050c58d84099 Michael Chan        2015-10-22  15806  	dev->priv_flags |= IFF_UNICAST_FLT;
c0c050c58d84099 Michael Chan        2015-10-22  15807  
b6488b161ab2972 Coco Li             2022-12-10  15808  	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
b7bfcb4c7ce44fd Michael Chan        2024-06-18  15809  	if (bp->tso_max_segs)
b7bfcb4c7ce44fd Michael Chan        2024-06-18  15810  		netif_set_tso_max_segs(dev, bp->tso_max_segs);
b6488b161ab2972 Coco Li             2022-12-10  15811  
66c0e13ad236c74 Marek Majtyka       2023-02-01  15812  	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
66c0e13ad236c74 Marek Majtyka       2023-02-01  15813  			    NETDEV_XDP_ACT_RX_SG;
66c0e13ad236c74 Marek Majtyka       2023-02-01  15814  
c0c050c58d84099 Michael Chan        2015-10-22  15815  #ifdef CONFIG_BNXT_SRIOV
c0c050c58d84099 Michael Chan        2015-10-22  15816  	init_waitqueue_head(&bp->sriov_cfg_wait);
c0c050c58d84099 Michael Chan        2015-10-22  15817  #endif
e38287b72ec5455 Michael Chan        2018-10-14  15818  	if (BNXT_SUPPORTS_TPA(bp)) {
309369c9b3f6a86 Michael Chan        2016-06-13  15819  		bp->gro_func = bnxt_gro_func_5730x;
67912c366d4bb0a Michael Chan        2019-07-29  15820  		if (BNXT_CHIP_P4(bp))
94758f8de037cf5 Michael Chan        2016-06-13  15821  			bp->gro_func = bnxt_gro_func_5731x;
1c7fd6ee2fe4ec6 Randy Schacher      2023-11-20  15822  		else if (BNXT_CHIP_P5_PLUS(bp))
67912c366d4bb0a Michael Chan        2019-07-29  15823  			bp->gro_func = bnxt_gro_func_5750x;
e38287b72ec5455 Michael Chan        2018-10-14  15824  	}
e38287b72ec5455 Michael Chan        2018-10-14  15825  	if (!BNXT_CHIP_P4_PLUS(bp))
434c975a8fe2f70 Michael Chan        2017-05-29  15826  		bp->flags |= BNXT_FLAG_DOUBLE_DB;
309369c9b3f6a86 Michael Chan        2016-06-13  15827  
a22a6ac2ff8080c Michael Chan        2017-08-23  15828  	rc = bnxt_init_mac_addr(bp);
a22a6ac2ff8080c Michael Chan        2017-08-23  15829  	if (rc) {
a22a6ac2ff8080c Michael Chan        2017-08-23  15830  		dev_err(&pdev->dev, "Unable to initialize mac address.\n");
a22a6ac2ff8080c Michael Chan        2017-08-23  15831  		rc = -EADDRNOTAVAIL;
a22a6ac2ff8080c Michael Chan        2017-08-23  15832  		goto init_err_pci_clean;
a22a6ac2ff8080c Michael Chan        2017-08-23  15833  	}
c0c050c58d84099 Michael Chan        2015-10-22  15834  
2e9217d1e8b72dd Vasundhara Volam    2019-05-22  15835  	if (BNXT_PF(bp)) {
03213a996531e50 Jiri Pirko          2019-04-03  15836  		/* Read the adapter's DSN to use as the eswitch switch_id */
b014232f7f56f6d Vasundhara Volam    2020-01-27  15837  		rc = bnxt_pcie_dsn_get(bp, bp->dsn);
2e9217d1e8b72dd Vasundhara Volam    2019-05-22  15838  	}
567b2abe6855178 Satish Baddipadige  2016-06-13  15839  
7eb9bb3a0c7c297 Michael Chan        2017-10-26  15840  	/* MTU range: 60 - FW defined max */
7eb9bb3a0c7c297 Michael Chan        2017-10-26  15841  	dev->min_mtu = ETH_ZLEN;
7eb9bb3a0c7c297 Michael Chan        2017-10-26  15842  	dev->max_mtu = bp->max_mtu;
7eb9bb3a0c7c297 Michael Chan        2017-10-26  15843  
ba642ab773db97c Michael Chan        2019-08-29  15844  	rc = bnxt_probe_phy(bp, true);
d5430d31ca72ec3 Michael Chan        2017-08-28  15845  	if (rc)
d5430d31ca72ec3 Michael Chan        2017-08-28  15846  		goto init_err_pci_clean;
d5430d31ca72ec3 Michael Chan        2017-08-28  15847  
f42822f22b1c5f7 Michael Chan        2024-02-05  15848  	hw_resc = &bp->hw_resc;
f42822f22b1c5f7 Michael Chan        2024-02-05  15849  	bp->max_fltr = hw_resc->max_rx_em_flows + hw_resc->max_rx_wm_flows +
f42822f22b1c5f7 Michael Chan        2024-02-05  15850  		       BNXT_L2_FLTR_MAX_FLTR;
f42822f22b1c5f7 Michael Chan        2024-02-05  15851  	/* Older firmware may not report these filters properly */
f42822f22b1c5f7 Michael Chan        2024-02-05  15852  	if (bp->max_fltr < BNXT_MAX_FLTR)
f42822f22b1c5f7 Michael Chan        2024-02-05  15853  		bp->max_fltr = BNXT_MAX_FLTR;
1f6e77cb9b328f2 Michael Chan        2023-12-22  15854  	bnxt_init_l2_fltr_tbl(bp);
c61fb99cae51958 Michael Chan        2017-02-06  15855  	bnxt_set_rx_skb_mode(bp, false);
c0c050c58d84099 Michael Chan        2015-10-22  15856  	bnxt_set_tpa_flags(bp);
c0c050c58d84099 Michael Chan        2015-10-22  15857  	bnxt_set_ring_params(bp);
2e4592dc9bee5ca Vikas Gupta         2024-04-09  15858  	bnxt_rdma_aux_device_init(bp);
702c221ca64060b Michael Chan        2017-05-29  15859  	rc = bnxt_set_dflt_rings(bp, true);
bdbd1eb59c565c5 Michael Chan        2016-12-29  15860  	if (rc) {
662c9b22f5b568f Edwin Peer          2022-01-09  15861  		if (BNXT_VF(bp) && rc == -ENODEV) {
662c9b22f5b568f Edwin Peer          2022-01-09  15862  			netdev_err(bp->dev, "Cannot configure VF rings while PF is unavailable.\n");
662c9b22f5b568f Edwin Peer          2022-01-09  15863  		} else {
bdbd1eb59c565c5 Michael Chan        2016-12-29  15864  			netdev_err(bp->dev, "Not enough rings available.\n");
bdbd1eb59c565c5 Michael Chan        2016-12-29  15865  			rc = -ENOMEM;
662c9b22f5b568f Edwin Peer          2022-01-09  15866  		}
17086399c113d93 Sathya Perla        2017-02-20  15867  		goto init_err_pci_clean;
bdbd1eb59c565c5 Michael Chan        2016-12-29  15868  	}
c0c050c58d84099 Michael Chan        2015-10-22  15869  
ba642ab773db97c Michael Chan        2019-08-29  15870  	bnxt_fw_init_one_p3(bp);
2bcfa6f6e7cf867 Michael Chan        2015-12-27  15871  
df78ea22460b6c6 Michael Chan        2021-12-27  15872  	bnxt_init_dflt_coal(bp);
df78ea22460b6c6 Michael Chan        2021-12-27  15873  
a196e96bb68fbc7 Edwin Peer          2020-07-08  15874  	if (dev->hw_features & BNXT_HW_FEATURE_VLAN_ALL_RX)
c0c050c58d84099 Michael Chan        2015-10-22  15875  		bp->flags |= BNXT_FLAG_STRIP_VLAN;
c0c050c58d84099 Michael Chan        2015-10-22  15876  
7809592d3e2ec79 Michael Chan        2016-12-07  15877  	rc = bnxt_init_int_mode(bp);
c0c050c58d84099 Michael Chan        2015-10-22  15878  	if (rc)
17086399c113d93 Sathya Perla        2017-02-20  15879  		goto init_err_pci_clean;
c0c050c58d84099 Michael Chan        2015-10-22  15880  
832aed16ce7af2a Michael Chan        2018-03-09  15881  	/* No TC has been set yet and rings may have been trimmed due to
832aed16ce7af2a Michael Chan        2018-03-09  15882  	 * limited MSIX, so we re-initialize the TX rings per TC.
832aed16ce7af2a Michael Chan        2018-03-09  15883  	 */
832aed16ce7af2a Michael Chan        2018-03-09  15884  	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
832aed16ce7af2a Michael Chan        2018-03-09  15885  
c213eae8d3cd4c0 Michael Chan        2017-10-13  15886  	if (BNXT_PF(bp)) {
c213eae8d3cd4c0 Michael Chan        2017-10-13  15887  		if (!bnxt_pf_wq) {
c213eae8d3cd4c0 Michael Chan        2017-10-13  15888  			bnxt_pf_wq =
c213eae8d3cd4c0 Michael Chan        2017-10-13  15889  				create_singlethread_workqueue("bnxt_pf_wq");
c213eae8d3cd4c0 Michael Chan        2017-10-13  15890  			if (!bnxt_pf_wq) {
c213eae8d3cd4c0 Michael Chan        2017-10-13  15891  				dev_err(&pdev->dev, "Unable to create workqueue.\n");
b5f796b62c98cd8 Zhang Changzhong    2020-11-18  15892  				rc = -ENOMEM;
c213eae8d3cd4c0 Michael Chan        2017-10-13  15893  				goto init_err_pci_clean;
c213eae8d3cd4c0 Michael Chan        2017-10-13  15894  			}
c213eae8d3cd4c0 Michael Chan        2017-10-13  15895  		}
18c7015cc65ab62 Jakub Kicinski      2020-07-17  15896  		rc = bnxt_init_tc(bp);
18c7015cc65ab62 Jakub Kicinski      2020-07-17  15897  		if (rc)
18c7015cc65ab62 Jakub Kicinski      2020-07-17  15898  			netdev_err(dev, "Failed to initialize TC flower offload, err = %d.\n",
18c7015cc65ab62 Jakub Kicinski      2020-07-17  15899  				   rc);
c213eae8d3cd4c0 Michael Chan        2017-10-13  15900  	}
2ae7408fedfee97 Sathya Perla        2017-08-28  15901  
190eda1a9dbc474 Vasundhara Volam    2021-04-11  15902  	bnxt_inv_fw_health_reg(bp);
e624c70e1131e14 Leon Romanovsky     2021-09-23  15903  	rc = bnxt_dl_register(bp);
e624c70e1131e14 Leon Romanovsky     2021-09-23  15904  	if (rc)
e624c70e1131e14 Leon Romanovsky     2021-09-23  15905  		goto init_err_dl;
cda2cab07711839 Vasundhara Volam    2020-01-27  15906  
8336a974f37df3c Pavan Chebbi        2024-02-05  15907  	INIT_LIST_HEAD(&bp->usr_fltr_list);
8336a974f37df3c Pavan Chebbi        2024-02-05  15908  
fea41bd766342a7 Pavan Chebbi        2024-03-25  15909  	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
20c8ad72eb7f151 Jakub Kicinski      2024-07-11  15910  		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
194fad5b27815ca Vikas Gupta         2024-04-09  15911  
7809592d3e2ec79 Michael Chan        2016-12-07  15912  	rc = register_netdev(dev);
7809592d3e2ec79 Michael Chan        2016-12-07  15913  	if (rc)
cda2cab07711839 Vasundhara Volam    2020-01-27  15914  		goto init_err_cleanup;
7809592d3e2ec79 Michael Chan        2016-12-07  15915  
937f188c1f4f89b Vasundhara Volam    2019-12-10  15916  	bnxt_dl_fw_reporters_create(bp);
4ab0c6a8ffd7d25 Sathya Perla        2017-07-24  15917  
194fad5b27815ca Vikas Gupta         2024-04-09  15918  	bnxt_rdma_aux_device_add(bp);
d80d88b0dfff582 Ajit Khaparde       2022-03-06  15919  
c7dd4a5b0a155c4 Edwin Peer          2021-10-29  15920  	bnxt_print_device_info(bp);
90c4f788f6c08aa Ajit Khaparde       2016-05-15  15921  
df3875ec5503969 Vasundhara Volam    2020-08-26  15922  	pci_save_state(pdev);
c0c050c58d84099 Michael Chan        2015-10-22  15923  
d80d88b0dfff582 Ajit Khaparde       2022-03-06  15924  	return 0;
cda2cab07711839 Vasundhara Volam    2020-01-27  15925  init_err_cleanup:
194fad5b27815ca Vikas Gupta         2024-04-09  15926  	bnxt_rdma_aux_device_uninit(bp);
cda2cab07711839 Vasundhara Volam    2020-01-27  15927  	bnxt_dl_unregister(bp);
e624c70e1131e14 Leon Romanovsky     2021-09-23  15928  init_err_dl:
2ae7408fedfee97 Sathya Perla        2017-08-28  15929  	bnxt_shutdown_tc(bp);
7809592d3e2ec79 Michael Chan        2016-12-07  15930  	bnxt_clear_int_mode(bp);
7809592d3e2ec79 Michael Chan        2016-12-07  15931  
17086399c113d93 Sathya Perla        2017-02-20  15932  init_err_pci_clean:
bdb3860236b3ec8 Vasundhara Volam    2019-11-23  15933  	bnxt_hwrm_func_drv_unrgtr(bp);
a2bf74f4e1b8239 Venkat Duvvuru      2018-10-05  15934  	bnxt_free_hwrm_resources(bp);
6ad71984aa6bb29 Kalesh AP           2023-09-26  15935  	bnxt_hwmon_uninit(bp);
03400aaa69f916a Somnath Kotur       2021-06-18  15936  	bnxt_ethtool_free(bp);
a521c8a01d267bc Michael Chan        2021-07-28  15937  	bnxt_ptp_clear(bp);
ae5c42f0b92ca0a Michael Chan        2021-06-27  15938  	kfree(bp->ptp_cfg);
ae5c42f0b92ca0a Michael Chan        2021-06-27  15939  	bp->ptp_cfg = NULL;
07f83d72d238f5d Michael Chan        2019-08-29  15940  	kfree(bp->fw_health);
07f83d72d238f5d Michael Chan        2019-08-29  15941  	bp->fw_health = NULL;
17086399c113d93 Sathya Perla        2017-02-20  15942  	bnxt_cleanup_pci(bp);
62bfb932a51f6d0 Michael Chan        2020-03-22  15943  	bnxt_free_ctx_mem(bp);
b440eb65fe73aa6 Vikas Gupta         2024-07-13  15944  	bnxt_free_crash_dump_mem(bp);
1667cbf6a4ebe09 Michael Chan        2020-07-08  15945  	kfree(bp->rss_indir_tbl);
1667cbf6a4ebe09 Michael Chan        2020-07-08  15946  	bp->rss_indir_tbl = NULL;
c0c050c58d84099 Michael Chan        2015-10-22  15947  
c0c050c58d84099 Michael Chan        2015-10-22  15948  init_err_free:
c0c050c58d84099 Michael Chan        2015-10-22  15949  	free_netdev(dev);
c0c050c58d84099 Michael Chan        2015-10-22 @15950  	return rc;
c0c050c58d84099 Michael Chan        2015-10-22  15951  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


