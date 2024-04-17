Return-Path: <netdev+bounces-88702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F888A84DC
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CA41C20CF5
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE49140380;
	Wed, 17 Apr 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouS5hiro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9013D89F
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361085; cv=none; b=ceLgtS5bHVWbS2DwSXCoC/2p3gX2+M/xRmyNUYCBnpGWAK7d+Wi/lTYsAbT/4Cg3DorcWWqV9y2mxvc2QJGkB9EdisG0UNxCIF+a8HxmRCa7WBU7RKUkWocc09MbzQYs7xzUY9q8WQutt/Q/4MZfhSRbPHExwbcP/U6N3E/V3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361085; c=relaxed/simple;
	bh=SrAwHiw5DS+3uTSjKRZI5h+3ICzAKM4DzCwh7BbwxAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TN4pPIrWpiJa6KVK/hCu3G96+ETUg3449dxP/HMzqZ9oB/46opisTOvg/TJik07RHKt57hxtTrt2LXMhKwcAnmJ5oLtgSIQY3ObK0YxtzNs6oJdZKz8FHfsllrwpoqVX3qhINAQe6n8C0ib90LBqmPm1wnt7dG6Do8pD9b3NkFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouS5hiro; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a555b203587so75108566b.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713361081; x=1713965881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/KcmpYcei3Au2kK2wtQQuvWtpfCCMou6DWdFUvWLAs=;
        b=ouS5hiro/cWi0hG34ogY8GhoCee2yv3BsnNhum7rxFQ1YZ12w3/XswkUmUQzi7b0Ju
         UDcC96pZL4Z+QBxgemtDCfA6x5MfdmOGHVGhhQ9YqzFynF6xQrzVkZGl/RvN04vH1HCH
         gbk6sdRylFDrL/66/6H9S3c/GlgwHVBCNY/EXyACwJq25LVzXW9mYddG9c3u6+iuTvXI
         E7kzj7AP4kCREHNBlwISUeSnK+VMPfiJ/ZQNpYcuvP23VRwwQ7x7KnFGEeDTRUiHhS2I
         nUJzHSIQlec8+tK5l3mVgiUXv6dlShEHqi8tBRK9s3wcKgEidzx8P+eMf0NHLcLrrsbD
         Ghjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713361081; x=1713965881;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/KcmpYcei3Au2kK2wtQQuvWtpfCCMou6DWdFUvWLAs=;
        b=LAyUwhf3Se8oH9HRCnSAAzESBeTHWH/NjjGLONmRDwrJf4gev4Qp2TiM5iqY0jhpy1
         JMvCLVr+C0ZKHmTt4JPthM3YI9EXUhxwkbSMhYrcj4tfMNagTiNvI8KciDskpbTaXnMW
         PU/BPOFGKrRYwGDbU+Ts9wiGIXwqWqHygXJz1CpoYKeHPT0GGp75wlwcIi6sW68h8pwy
         v0aFHlpTvCztdr/Gjr/akXRsu/P9ZZY0s7VZ4Xc9JCOvVj7NaK7Hv5ZW5LlPDf2wdxCp
         LgvS6prlt8oVlhl5G0xq126HZ08hexY69nMjxVyQCPM+egi9vMbv0zWxiKio+62KWfAJ
         QzZA==
X-Forwarded-Encrypted: i=1; AJvYcCUWSXmx0Ox2FoSzqQS1S2wjwsGVuZiyKKREyT8ozLNGnSGTRkpnsbeeZlBhMPL3SNS4hb9Dy9T3YvqgbAIbv8VQFGo94ItL
X-Gm-Message-State: AOJu0YxbdvysO/imbl2weYzs4EgnS4eYlbEnNqJwyUuWrESyAZeVQbJ0
	qTElZORMgiu+gGXmyXKWRMeHmOT1EqGO+4CLh8s9MmoB3VSLNVhYsYwz837lke8=
X-Google-Smtp-Source: AGHT+IH8LxCS7KS5d8H7g/NIwyGENvuKbbtlWI07tDHjS6X1fV1ErfXpF9XVc1J7DgEdG+8mWfhWYA==
X-Received: by 2002:a17:906:dc8f:b0:a51:af7d:4652 with SMTP id cs15-20020a170906dc8f00b00a51af7d4652mr15531363ejc.32.1713361080838;
        Wed, 17 Apr 2024 06:38:00 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906470900b00a51a74409dcsm8216147ejq.221.2024.04.17.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:38:00 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:37:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH 2/9] octeontx2-pf: RVU representor driver
Message-ID: <546b7783-78ec-4fec-b338-f1980a5871d0@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416050616.6056-3-gakula@marvell.com>

Hi Geetha,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Geetha-sowjanya/octeontx2-pf-Refactoring-RVU-driver/20240416-131052
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240416050616.6056-3-gakula%40marvell.com
patch subject: [net-next PATCH 2/9] octeontx2-pf: RVU representor driver
config: alpha-randconfig-r081-20240417 (https://download.01.org/0day-ci/archive/20240417/202404172056.MpOMwcGB-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404172056.MpOMwcGB-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/marvell/octeontx2/nic/rep.c:95 rvu_get_rep_cnt() warn: passing zero to 'PTR_ERR'
drivers/net/ethernet/marvell/octeontx2/nic/rep.c:140 rvu_rep_probe() warn: missing unwind goto?

vim +/PTR_ERR +95 drivers/net/ethernet/marvell/octeontx2/nic/rep.c

1e15129a77b419 Geetha sowjanya 2024-04-16   76  static int rvu_get_rep_cnt(struct otx2_nic *priv)
1e15129a77b419 Geetha sowjanya 2024-04-16   77  {
1e15129a77b419 Geetha sowjanya 2024-04-16   78  	struct get_rep_cnt_rsp *rsp;
1e15129a77b419 Geetha sowjanya 2024-04-16   79  	struct mbox_msghdr *msghdr;
1e15129a77b419 Geetha sowjanya 2024-04-16   80  	struct msg_req *req;
1e15129a77b419 Geetha sowjanya 2024-04-16   81  	int err, rep;
1e15129a77b419 Geetha sowjanya 2024-04-16   82  
1e15129a77b419 Geetha sowjanya 2024-04-16   83  	mutex_lock(&priv->mbox.lock);
1e15129a77b419 Geetha sowjanya 2024-04-16   84  	req = otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
1e15129a77b419 Geetha sowjanya 2024-04-16   85  	if (!req) {
1e15129a77b419 Geetha sowjanya 2024-04-16   86  		mutex_unlock(&priv->mbox.lock);
1e15129a77b419 Geetha sowjanya 2024-04-16   87  		return -ENOMEM;
1e15129a77b419 Geetha sowjanya 2024-04-16   88  	}
1e15129a77b419 Geetha sowjanya 2024-04-16   89  	err = otx2_sync_mbox_msg(&priv->mbox);
1e15129a77b419 Geetha sowjanya 2024-04-16   90  	if (err)
1e15129a77b419 Geetha sowjanya 2024-04-16   91  		goto exit;
1e15129a77b419 Geetha sowjanya 2024-04-16   92  
1e15129a77b419 Geetha sowjanya 2024-04-16   93  	msghdr = otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
1e15129a77b419 Geetha sowjanya 2024-04-16   94  	if (IS_ERR(msghdr)) {
1e15129a77b419 Geetha sowjanya 2024-04-16  @95  		err = PTR_ERR(rsp);
                                                                              ^^^
s/rsp/msghdr/

1e15129a77b419 Geetha sowjanya 2024-04-16   96  		goto exit;
1e15129a77b419 Geetha sowjanya 2024-04-16   97  	}
1e15129a77b419 Geetha sowjanya 2024-04-16   98  
1e15129a77b419 Geetha sowjanya 2024-04-16   99  	rsp = (struct get_rep_cnt_rsp *)msghdr;
1e15129a77b419 Geetha sowjanya 2024-04-16  100  	priv->hw.tx_queues = rsp->rep_cnt;
1e15129a77b419 Geetha sowjanya 2024-04-16  101  	priv->hw.rx_queues = rsp->rep_cnt;
1e15129a77b419 Geetha sowjanya 2024-04-16  102  	priv->rep_cnt = rsp->rep_cnt;
1e15129a77b419 Geetha sowjanya 2024-04-16  103  	for (rep = 0; rep < priv->rep_cnt; rep++)
1e15129a77b419 Geetha sowjanya 2024-04-16  104  		priv->rep_pf_map[rep] = rsp->rep_pf_map[rep];
1e15129a77b419 Geetha sowjanya 2024-04-16  105  
1e15129a77b419 Geetha sowjanya 2024-04-16  106  exit:
1e15129a77b419 Geetha sowjanya 2024-04-16  107  	mutex_unlock(&priv->mbox.lock);
1e15129a77b419 Geetha sowjanya 2024-04-16  108  	return err;
1e15129a77b419 Geetha sowjanya 2024-04-16  109  }
1e15129a77b419 Geetha sowjanya 2024-04-16  110  
1e15129a77b419 Geetha sowjanya 2024-04-16  111  static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
1e15129a77b419 Geetha sowjanya 2024-04-16  112  {
1e15129a77b419 Geetha sowjanya 2024-04-16  113  	struct device *dev = &pdev->dev;
1e15129a77b419 Geetha sowjanya 2024-04-16  114  	struct otx2_nic *priv;
1e15129a77b419 Geetha sowjanya 2024-04-16  115  	struct otx2_hw *hw;
1e15129a77b419 Geetha sowjanya 2024-04-16  116  	int err;
1e15129a77b419 Geetha sowjanya 2024-04-16  117  
1e15129a77b419 Geetha sowjanya 2024-04-16  118  	err = pcim_enable_device(pdev);
1e15129a77b419 Geetha sowjanya 2024-04-16  119  	if (err) {
1e15129a77b419 Geetha sowjanya 2024-04-16  120  		dev_err(dev, "Failed to enable PCI device\n");
1e15129a77b419 Geetha sowjanya 2024-04-16  121  		return err;
1e15129a77b419 Geetha sowjanya 2024-04-16  122  	}
1e15129a77b419 Geetha sowjanya 2024-04-16  123  
1e15129a77b419 Geetha sowjanya 2024-04-16  124  	err = pci_request_regions(pdev, DRV_NAME);
1e15129a77b419 Geetha sowjanya 2024-04-16  125  	if (err) {
1e15129a77b419 Geetha sowjanya 2024-04-16  126  		dev_err(dev, "PCI request regions failed 0x%x\n", err);
1e15129a77b419 Geetha sowjanya 2024-04-16  127  		return err;
1e15129a77b419 Geetha sowjanya 2024-04-16  128  	}
1e15129a77b419 Geetha sowjanya 2024-04-16  129  
1e15129a77b419 Geetha sowjanya 2024-04-16  130  	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
1e15129a77b419 Geetha sowjanya 2024-04-16  131  	if (err) {
1e15129a77b419 Geetha sowjanya 2024-04-16  132  		dev_err(dev, "DMA mask config failed, abort\n");
1e15129a77b419 Geetha sowjanya 2024-04-16  133  		goto err_release_regions;
1e15129a77b419 Geetha sowjanya 2024-04-16  134  	}
1e15129a77b419 Geetha sowjanya 2024-04-16  135  
1e15129a77b419 Geetha sowjanya 2024-04-16  136  	pci_set_master(pdev);
1e15129a77b419 Geetha sowjanya 2024-04-16  137  
1e15129a77b419 Geetha sowjanya 2024-04-16  138  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
1e15129a77b419 Geetha sowjanya 2024-04-16  139  	if (!priv)
1e15129a77b419 Geetha sowjanya 2024-04-16 @140  		return -ENOMEM;

goto err_release_regions.

1e15129a77b419 Geetha sowjanya 2024-04-16  141  	pci_set_drvdata(pdev, priv);
1e15129a77b419 Geetha sowjanya 2024-04-16  142  	priv->pdev = pdev;
1e15129a77b419 Geetha sowjanya 2024-04-16  143  	priv->dev = dev;
1e15129a77b419 Geetha sowjanya 2024-04-16  144  	priv->flags |= OTX2_FLAG_INTF_DOWN;
1e15129a77b419 Geetha sowjanya 2024-04-16  145  	priv->flags |= OTX2_FLAG_REP_MODE_ENABLED;
1e15129a77b419 Geetha sowjanya 2024-04-16  146  
1e15129a77b419 Geetha sowjanya 2024-04-16  147  	hw = &priv->hw;
1e15129a77b419 Geetha sowjanya 2024-04-16  148  	hw->pdev = pdev;
1e15129a77b419 Geetha sowjanya 2024-04-16  149  	hw->max_queues = OTX2_MAX_CQ_CNT;
1e15129a77b419 Geetha sowjanya 2024-04-16  150  	hw->rbuf_len = OTX2_DEFAULT_RBUF_LEN;
1e15129a77b419 Geetha sowjanya 2024-04-16  151  	hw->xqe_size = 128;
1e15129a77b419 Geetha sowjanya 2024-04-16  152  
1e15129a77b419 Geetha sowjanya 2024-04-16  153  	err = otx2_init_rsrc(pdev, priv);
1e15129a77b419 Geetha sowjanya 2024-04-16  154  	if (err)
1e15129a77b419 Geetha sowjanya 2024-04-16  155  		goto err_release_regions;
1e15129a77b419 Geetha sowjanya 2024-04-16  156  
1e15129a77b419 Geetha sowjanya 2024-04-16  157  	err = rvu_get_rep_cnt(priv);
1e15129a77b419 Geetha sowjanya 2024-04-16  158  	if (err)
1e15129a77b419 Geetha sowjanya 2024-04-16  159  		goto err_detach_rsrc;
1e15129a77b419 Geetha sowjanya 2024-04-16  160  
1e15129a77b419 Geetha sowjanya 2024-04-16  161  	err = rvu_rep_rsrc_init(priv);
1e15129a77b419 Geetha sowjanya 2024-04-16  162  	if (err)
1e15129a77b419 Geetha sowjanya 2024-04-16  163  		goto err_detach_rsrc;
1e15129a77b419 Geetha sowjanya 2024-04-16  164  
1e15129a77b419 Geetha sowjanya 2024-04-16  165  	return 0;
1e15129a77b419 Geetha sowjanya 2024-04-16  166  
1e15129a77b419 Geetha sowjanya 2024-04-16  167  err_detach_rsrc:
1e15129a77b419 Geetha sowjanya 2024-04-16  168  	if (priv->hw.lmt_info)
1e15129a77b419 Geetha sowjanya 2024-04-16  169  		free_percpu(priv->hw.lmt_info);
1e15129a77b419 Geetha sowjanya 2024-04-16  170  	if (test_bit(CN10K_LMTST, &priv->hw.cap_flag))
1e15129a77b419 Geetha sowjanya 2024-04-16  171  		qmem_free(priv->dev, priv->dync_lmt);
1e15129a77b419 Geetha sowjanya 2024-04-16  172  	otx2_detach_resources(&priv->mbox);
1e15129a77b419 Geetha sowjanya 2024-04-16  173  	otx2_disable_mbox_intr(priv);
1e15129a77b419 Geetha sowjanya 2024-04-16  174  	otx2_pfaf_mbox_destroy(priv);
1e15129a77b419 Geetha sowjanya 2024-04-16  175  	pci_free_irq_vectors(pdev);
1e15129a77b419 Geetha sowjanya 2024-04-16  176  err_release_regions:
1e15129a77b419 Geetha sowjanya 2024-04-16  177  	pci_set_drvdata(pdev, NULL);
1e15129a77b419 Geetha sowjanya 2024-04-16  178  	pci_release_regions(pdev);
1e15129a77b419 Geetha sowjanya 2024-04-16  179  	return err;
1e15129a77b419 Geetha sowjanya 2024-04-16  180  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


