Return-Path: <netdev+bounces-174843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5F8A60F4D
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7503117FDFC
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3791FCF53;
	Fri, 14 Mar 2025 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWjvKezF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147931779AE
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949432; cv=none; b=Da62lUKxvcjtCTetm1ExsjAhn1+An4uAyaFEdTkCYs4orWvjkKydvPJg0QaNUCm7q6m8mIFG0RWEXe2XGR3YlcQ8I623zHMLRw5eGNKccbYD3GfrWVSG5vhxQvg7F/Sl7HJ8aj0VuER7h2OCbrR3A/TNd4TPsqD7ORmXx2wOPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949432; c=relaxed/simple;
	bh=pV/i3PKyujs2F6/TFFWtpucAn/XpLc5VI6KGba6GnYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f5bL06MHc6wgorb+QHhSqau5p/XItLiAtvde4ds5wlW80/Z7huII80KC6F26Xl5Juq2voEpBPlubdzi9e3TOx8cBuLBaag0RJI8GztIFLwB0qQi8maEEeOYoSx/vY/MDhE3pjqDw91yPPalataz11jTJ1jqNYGTTn27TjyiLCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bWjvKezF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so18602065e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741949429; x=1742554229; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=od5SDVzRsqJnhKtT9u8lJ7jltmdYkNALPPyMQCmEgnE=;
        b=bWjvKezFVyg/dTjqrHRKL3mHCD94ErMdVk26I1uPy9of4AJk/NQzz6M4uKHAKHTcZe
         sW0/bX1ptaBk8pS8QLa+PI3Fuq1gK2yluv5qeylGfvTFfRWM/HNjr2iiKFnaTpYFP1UY
         WoNspOvEDTPGMTP7FVzrI9JuYAWyqLdPTo461+P0lzekCSsKH3o4RW+czdvyY44w8BDq
         mQDV9UmCmJMJjWtw/TzpQtBUK3qBrclhAbSp/gWOmiIHXDXyUDksttNTWoDVnyKzk6ga
         VkNivDiPwTkcifgM6UsgufQx94vfsrpMJN1AER5wwfKKFtvI5s/dXF5Im1fCLk50q5jN
         GTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949429; x=1742554229;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=od5SDVzRsqJnhKtT9u8lJ7jltmdYkNALPPyMQCmEgnE=;
        b=K7fwmiiVcbi/qZm1PU5AT63m646PYKr6vtyq509kaD7Jy5pu1V9B5uDgHsouzUlW2W
         8EwPwtIoM1vKTr+XZkrMDZK0saPT4tXewPq8/579hKPwaeWQIkSEnJ3midHmefGKcMlN
         1irnuNUk/OyU4fDAOYPxw0FONIgmt1ngQJbtcXxr4GYzkm6aT1Dy20klifo8OvyjqSp3
         jF0+6Ygp0zmvGELDaj/U+xx3OQDLjujMUNDDq/007HyNltfkWTJ+fZsjXtQk31mK5kvk
         e5teKR0IiivyzmybXomMN9o6qN52+f0Nb5QgLSgqdtI4Ce/BSZTTWtGajfJUrP2P0sCg
         dVwQ==
X-Gm-Message-State: AOJu0Yyc78qxwnmSoGRorMnQeqD0zo+o+EZx238bF4BHl+viEkxnSyLa
	YIpXcnX2aaWhJ+YBpg8VeICt+7YEFhQL13i/sg3Mp/MqTcA1iCArGmkP07cabu2+RGFa9IqDJ0E
	U
X-Gm-Gg: ASbGncs4OUd4IqSP7txzfAB1A/3emOpq/7g8W2mIvdy5OkMfeqUGlUV3z6gVnl2/Ytp
	/z82xkY/cMxmlstgCNdk+2fcNp7mglzkN3QKTtbzyhqISiUDC0ZNZwesEPKRzI0ogdQNNYtfhD4
	VC19rxScGqQp92pkpZDTlYIwe2vpRl4QIrk8j9gMRnIBa9+V13DgG2xjeG0sdonzjHSOogM3fcM
	GFnpODTrNjaEecOVAYFdwnifnb2v5ghuN6971srczSTG2LmuV//+5L74Ok+vlg76hVJHKu4rzU9
	DFjrOEnRVPseNVjC6DIiKeqlreqgtMFBm/GeDPUFCjCb0relYR5F5mqRHn+A
X-Google-Smtp-Source: AGHT+IHvBotvaSh2qWNqxyJfZlOzdoLexgIaj5jk8svfw+NdgPNIfM+Z0q5WgikQ9jzY6egbCNl3iA==
X-Received: by 2002:a05:600c:4f8a:b0:43c:fbe2:df3c with SMTP id 5b1f17b1804b1-43d1ecee010mr22546485e9.26.1741949429283;
        Fri, 14 Mar 2025 03:50:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1fdbc4cesm9813735e9.0.2025.03.14.03.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:50:28 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:50:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: ti: icssg-prueth: Add XDP support
Message-ID: <70d8dd76-0c76-42fc-8611-9884937c82f5@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Roger Quadros,

Commit 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support") from
Mar 5, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/ethernet/ti/icssg/icssg_common.c:635 emac_xmit_xdp_frame()
	error: we previously assumed 'first_desc' could be null (see line 584)

drivers/net/ethernet/ti/icssg/icssg_common.c
   563  u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
   564                          struct xdp_frame *xdpf,
   565                          struct page *page,
   566                          unsigned int q_idx)
   567  {
   568          struct cppi5_host_desc_t *first_desc;
   569          struct net_device *ndev = emac->ndev;
   570          struct prueth_tx_chn *tx_chn;
   571          dma_addr_t desc_dma, buf_dma;
   572          struct prueth_swdata *swdata;
   573          u32 *epib;
   574          int ret;
   575  
   576          if (q_idx >= PRUETH_MAX_TX_QUEUES) {
   577                  netdev_err(ndev, "xdp tx: invalid q_id %d\n", q_idx);
   578                  return ICSSG_XDP_CONSUMED;      /* drop */

Do we need to free something on this path?

   579          }
   580  
   581          tx_chn = &emac->tx_chns[q_idx];
   582  
   583          first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
   584          if (!first_desc) {
   585                  netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
   586                  goto drop_free_descs;   /* drop */
                        ^^^^^^^^^^^^^^^^^^^^
This will dereference first_desc and crash.

   587          }
   588  
   589          if (page) { /* already DMA mapped by page_pool */
   590                  buf_dma = page_pool_get_dma_addr(page);
   591                  buf_dma += xdpf->headroom + sizeof(struct xdp_frame);
   592          } else { /* Map the linear buffer */
   593                  buf_dma = dma_map_single(tx_chn->dma_dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
   594                  if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
   595                          netdev_err(ndev, "xdp tx: failed to map data buffer\n");
   596                          goto drop_free_descs;   /* drop */
   597                  }
   598          }
   599  
   600          cppi5_hdesc_init(first_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
   601                           PRUETH_NAV_PS_DATA_SIZE);
   602          cppi5_hdesc_set_pkttype(first_desc, 0);
   603          epib = first_desc->epib;
   604          epib[0] = 0;
   605          epib[1] = 0;
   606  
   607          /* set dst tag to indicate internal qid at the firmware which is at
   608           * bit8..bit15. bit0..bit7 indicates port num for directed
   609           * packets in case of switch mode operation
   610           */
   611          cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
   612          k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
   613          cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->len);
   614          swdata = cppi5_hdesc_get_swdata(first_desc);
   615          if (page) {
   616                  swdata->type = PRUETH_SWDATA_PAGE;
   617                  swdata->data.page = page;
   618          } else {
   619                  swdata->type = PRUETH_SWDATA_XDPF;
   620                  swdata->data.xdpf = xdpf;
   621          }
   622  
   623          cppi5_hdesc_set_pktlen(first_desc, xdpf->len);
   624          desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
   625  
   626          ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
   627          if (ret) {
   628                  netdev_err(ndev, "xdp tx: push failed: %d\n", ret);
   629                  goto drop_free_descs;
   630          }
   631  
   632          return ICSSG_XDP_TX;
   633  
   634  drop_free_descs:
   635          prueth_xmit_free(tx_chn, first_desc);
   636          return ICSSG_XDP_CONSUMED;
   637  }


regards,
dan carpenter

