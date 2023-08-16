Return-Path: <netdev+bounces-28198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F3277EA63
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAD4281BE2
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ECA17AB0;
	Wed, 16 Aug 2023 20:08:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1825615AE5
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:08:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE24CD
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692216533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAGjhNWta9tPOm6pa18Hg91jJmF6Zlk42k2UdS+GBJg=;
	b=U4yberG4S0IfCKEF1m4veXOm24NXdOtVPy1/RmbBHXIYZqNg34Ra8TF949zcZJAok2UINC
	nbXjl8ySi+C0kJO2xdZbirRcUzTqatQ7qrT82erWDltQpVIZpqRmLcVMjlsLOxqfnDfLfg
	IQhDMGDJ2yi9jmVJollvWJ7JZpNjeq0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-L_yX4dNPN9Cud_ofnF9syA-1; Wed, 16 Aug 2023 16:08:49 -0400
X-MC-Unique: L_yX4dNPN9Cud_ofnF9syA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F35553C0011E;
	Wed, 16 Aug 2023 20:08:48 +0000 (UTC)
Received: from [10.22.10.6] (unknown [10.22.10.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5FA2263F6D;
	Wed, 16 Aug 2023 20:08:48 +0000 (UTC)
Message-ID: <c90566f6-5c7b-f20c-b8fb-2347881b23b2@redhat.com>
Date: Wed, 16 Aug 2023 16:08:48 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 net] qede: fix firmware halt over suspend and resume
Content-Language: en-US
To: Manish Chopra <manishc@marvell.com>, kuba@kernel.org
Cc: netdev@vger.kernel.org, aelior@marvell.com, palok@marvell.com,
 njavali@marvell.com, skashyap@marvell.com, yuval.mintz@qlogic.com,
 skalluru@marvell.com, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, David Miller <davem@davemloft.net>
References: <20230816150711.59035-1-manishc@marvell.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20230816150711.59035-1-manishc@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Looks good.

Reviewed-by: John Meneghini <jmeneghi@redhat.com>

On 8/16/23 11:07, Manish Chopra wrote:
> While performing certain power-off sequences, PCI drivers are
> called to suspend and resume their underlying devices through
> PCI PM (power management) interface. However this NIC hardware
> does not support PCI PM suspend/resume operations so system wide
> suspend/resume leads to bad MFW (management firmware) state which
> causes various follow-up errors in driver when communicating with
> the device/firmware afterwards.
> 
> To fix this driver implements PCI PM suspend handler to indicate
> unsupported operation to the PCI subsystem explicitly, thus avoiding
> system to go into suspended/standby mode.
> 
> Without this fix device/firmware does not recover unless system
> is power cycled.
> 
> Fixes: 2950219d87b0 ("qede: Add basic network device support")
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Manish Chopra <manishc@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
> V1->V2:
> * Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
> 
> V2->V3:
> * Removed unnecessary device NULL check in qede_suspend()
> * Updated the commit description to reflect that without
>    this fix firmware can't be recovered over suspend/resume
> ---
>   drivers/net/ethernet/qlogic/qede/qede_main.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
> index d57e52a97f85..c7911a13e8f5 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_main.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
> @@ -177,6 +177,15 @@ static int qede_sriov_configure(struct pci_dev *pdev, int num_vfs_param)
>   }
>   #endif
>   
> +static int __maybe_unused qede_suspend(struct device *dev)
> +{
> +	dev_info(dev, "Device does not support suspend operation\n");
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(qede_pm_ops, qede_suspend, NULL);
> +
>   static const struct pci_error_handlers qede_err_handler = {
>   	.error_detected = qede_io_error_detected,
>   };
> @@ -191,6 +200,7 @@ static struct pci_driver qede_pci_driver = {
>   	.sriov_configure = qede_sriov_configure,
>   #endif
>   	.err_handler = &qede_err_handler,
> +	.driver.pm = &qede_pm_ops,
>   };
>   
>   static struct qed_eth_cb_ops qede_ll_ops = {


