Return-Path: <netdev+bounces-27642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9974977CA98
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BF71C20B0B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A1100C2;
	Tue, 15 Aug 2023 09:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B3C8E7
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:39:27 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFC4E5F
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692092366; x=1723628366;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=WFx61SnqjJqOlHouu+5TAkN2W5Xj0HIawBmP+tOMkn0=;
  b=RMCVGBGtvCYgb47D5b98HpN1Dc+Iltfezezd9zsR+p1uD6Ygq4OgPzK2
   DKTYF9PWjOXQz3Al/hRu1YosK0ul0Gmn8kRu6gS4BNvmF3MfEZrak9ElJ
   XxmPXhlNssm7PEvlJVCpdpAslc3exl+NLQx1EAUx3soS9jRylGMSx4Zc/
   c=;
X-IronPort-AV: E=Sophos;i="6.01,174,1684800000"; 
   d="scan'208";a="1148567237"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:39:19 +0000
Received: from EX19D010EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id 4ABAB474DA;
	Tue, 15 Aug 2023 09:39:16 +0000 (UTC)
Received: from EX19D028EUB003.ant.amazon.com (10.252.61.31) by
 EX19D010EUA002.ant.amazon.com (10.252.50.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 15 Aug 2023 09:39:15 +0000
Received: from u95c7fd9b18a35b.ant.amazon.com.amazon.com (10.13.248.51) by
 EX19D028EUB003.ant.amazon.com (10.252.61.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 15 Aug 2023 09:39:09 +0000
References: <20230815024248.3519068-1-zhangjialin11@huawei.com>
User-agent: mu4e 1.10.3; emacs 28.2
From: Shay Agroskin <shayagr@amazon.com>
To: Jialin Zhang <zhangjialin11@huawei.com>
CC: <akiyano@amazon.com>, <darinzon@amazon.com>, <ndagan@amazon.com>,
	<saeedb@amazon.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.kubiak@intel.com>,
	<yuancan@huawei.com>, <netdev@vger.kernel.org>, <liwei391@huawei.com>,
	<wangxiongfeng2@huawei.com>
Subject: Re: [PATCH] net: ena: Use pci_dev_id() to simplify the code
Date: Tue, 15 Aug 2023 11:31:19 +0300
In-Reply-To: <20230815024248.3519068-1-zhangjialin11@huawei.com>
Message-ID: <pj41zl1qg4wsp9.fsf@u95c7fd9b18a35b.ant.amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Originating-IP: [10.13.248.51]
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D028EUB003.ant.amazon.com (10.252.61.31)
Precedence: Bulk
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Jialin Zhang <zhangjialin11@huawei.com> writes:

> PCI core API pci_dev_id() can be used to get the BDF number for 
> a pci
> device. We don't need to compose it mannually. Use pci_dev_id() 
> to
> simplify the code a little bit.
>
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c 
> b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index d19593fae226..ad32ca81f7ef 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -3267,7 +3267,7 @@ static void ena_config_host_info(struct 
> ena_com_dev *ena_dev, struct pci_dev *pd
>  
>  	host_info = ena_dev->host_attr.host_info;
>  
> -	host_info->bdf = (pdev->bus->number << 8) | pdev->devfn;
> +	host_info->bdf = pci_dev_id(pdev);
>  	host_info->os_type = ENA_ADMIN_OS_LINUX;
>  	host_info->kernel_ver = LINUX_VERSION_CODE;
>  	strscpy(host_info->kernel_ver_str, utsname()->version,

Same as Leon's response. Otherwise lgtm
Reviewed-by: Shay Agroskin <shayagr@amazon.com>

