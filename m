Return-Path: <netdev+bounces-87690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E675E8A4195
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AB91F2161F
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2323759;
	Sun, 14 Apr 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbZ2Hidx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C0B1C2AF
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713088102; cv=none; b=Fw+WRpjSTFlrnScFklGmAi1gBaXEZ3/COekTY3mrV3kq6lDOmspMt1oxImMU2J2enrPg/8Bl2AUrewZD1oKe7i+xjSTQffSUFyYH2VTsSFz4pJUiC8yyGX3zmSkQD0Rn8Q4QGW3daX0qdSYvNyRDBbQmgTeupa4jJda8t8pby8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713088102; c=relaxed/simple;
	bh=NDlsgoc6A4IxXBOEATwELgEDexzc69w9dYPIh0f56gg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dEstooeyDc2vsxF2OcRy8/+OzDg55ZGZE1w9mG6P8qcuUPdN8OWwrYULIgfj0fxtUt+YAdyRGxzrHz2NP/ol2RyUeZQC+lJ0LpfsIv2+Zj/BopbF0ZkWYoI6uIhO5207QdNuxQJMJbXhEklb9/E1PKPqON4UhqlSrKpf6sm64Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LbZ2Hidx; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso1834433e87.3
        for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713088098; x=1713692898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVqD2Rvirwu12W5FfnBuYS741rQo1YJJcl1syKPBUN0=;
        b=LbZ2HidxRb7rtWZQjEwxXqYpH6fpvqdvBq9r586eJAtj7Isf5HII9gtx002h7xGK6i
         JbWnMOOKp+Y1X0pNWyOx45lanOh2RDaN3bKBlrFir2yfeG3rGDKulZxrD72GCEkasyTg
         vaJs6JhEO1Ji8y7gKWwSNculshl2eZ9xaFwDbOLzMy79ljpK1A9txGESpYpKK+M0QIlB
         B+B3QsHl2Ca5J4EoKKCUzVlxon539eTgJz5D+uy8v9kBjke50wG2l77WKarnmromXsIf
         mGqUxmlnNwWMOC80Q2TC/W/FbTcy/nhgeeOqgWa9AdP4n3mdU35gv4OfaNTB81ki0v69
         Xpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713088098; x=1713692898;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVqD2Rvirwu12W5FfnBuYS741rQo1YJJcl1syKPBUN0=;
        b=XMM5yKZYRRkkGjHoCPNRELchSSPznHQ4wj/2ytH8WbDUBUYEwuCMzzfEsv+hC6PBfx
         2xWGQRX7E132MiOu+yfCZKT9ctZqpexrUgmncX4E9/oYvZMtgYbX8vq+SPpvE19MWuy3
         Vkkepu7zB1xuTQMvPIh1EiHAJYXo+pbWMTHuP4cUeHTM394SW7+/ByxDdnWd0w53KC/Y
         BWLnCcmiUvy2Pzf9stIdQviGHnmaRGgBVms/Fd9X+6bJabxvwGlz/dPihuDc+lZEnu2y
         xvfzeu+btjEhTj2g31QZk59vQWPsYBlOLviwwSk+TnV/gVPGakIeZ8gyAv5mHE+Tudv/
         Gg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0FTBKM3d3B+NnBAjSo8cmUy+ZUy5dSQ894Rq8sm687i1ETVjrTjVh76NV++DL5ZrRAq+dUpEqR0nBP1Itbk7KkMytf7n4
X-Gm-Message-State: AOJu0Yy/6TASN/Wsvkcdz8zAVzgiMxARWCYVq5TXRiZ/t1l1tev4GDWW
	W9HET+TBefIBWCSFcoWAXfLMLyPieDG51fgeEUSgbzhMa7ny4dx8vxQVaEj92Q3B7hB3EmV0/os
	U
X-Google-Smtp-Source: AGHT+IF+o4gNFJDGJrFzzBfCpTnxmIUEqX4iFJfz0itRIzQrDGl4yEWKWtL79ugoRK/UVLGNpDL1tQ==
X-Received: by 2002:ac2:51b6:0:b0:518:bd37:606e with SMTP id f22-20020ac251b6000000b00518bd37606emr1630389lfk.13.1713088097535;
        Sun, 14 Apr 2024 02:48:17 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906249700b00a52454f4533sm2009486ejb.208.2024.04.14.02.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 02:48:17 -0700 (PDT)
Date: Sun, 14 Apr 2024 12:48:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
Message-ID: <8f518b9a-36cb-4988-8e69-3ea8ea567364@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-introduce-dma-map-api-for-page/20240411-105318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240411025127.51945-5-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 4/6] virtio_net: big mode support premapped
config: i386-randconfig-141-20240414 (https://download.01.org/0day-ci/archive/20240414/202404141343.iPhKo7zd-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404141343.iPhKo7zd-lkp@intel.com/

New smatch warnings:
drivers/net/virtio_net.c:485 give_pages() warn: impossible condition '((page->dma_addr) == (~0)) => (0-u32max == u64max)'

vim +485 drivers/net/virtio_net.c

e9d7417b97f420 Jason Wang      2012-12-07  481  static void give_pages(struct receive_queue *rq, struct page *page)
0a888fd1f6320d Mark McLoughlin 2008-11-16  482  {
9ab86bbcf8be75 Shirley Ma      2010-01-29  483  	struct page *end;
0a888fd1f6320d Mark McLoughlin 2008-11-16  484  
59e4bcf761eeba Xuan Zhuo       2024-04-11 @485  	if (page_dma_addr(page) == DMA_MAPPING_ERROR) {

(struct page)->dma_addr is unsigned long but DMA_MAPPING_ERROR is
dma_addr_t.

59e4bcf761eeba Xuan Zhuo       2024-04-11  486  		if (page_chain_map(rq, page)) {
59e4bcf761eeba Xuan Zhuo       2024-04-11  487  			__free_pages(page, 0);
59e4bcf761eeba Xuan Zhuo       2024-04-11  488  			return;
59e4bcf761eeba Xuan Zhuo       2024-04-11  489  		}
59e4bcf761eeba Xuan Zhuo       2024-04-11  490  	}
59e4bcf761eeba Xuan Zhuo       2024-04-11  491  
e9d7417b97f420 Jason Wang      2012-12-07  492  	/* Find end of list, sew whole thing into vi->rq.pages. */
590f79cf558cb4 Xuan Zhuo       2024-04-11  493  	for (end = page; page_chain_next(end); end = page_chain_next(end));
590f79cf558cb4 Xuan Zhuo       2024-04-11  494  
590f79cf558cb4 Xuan Zhuo       2024-04-11  495  	page_chain_add(end, rq->pages);
e9d7417b97f420 Jason Wang      2012-12-07  496  	rq->pages = page;
0a888fd1f6320d Mark McLoughlin 2008-11-16  497  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


