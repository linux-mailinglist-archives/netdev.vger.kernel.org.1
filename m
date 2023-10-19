Return-Path: <netdev+bounces-42520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EB27CF230
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C43281EBA
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2275C14F6F;
	Thu, 19 Oct 2023 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8014F6D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 08:15:24 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BFBC0
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:15:22 -0700 (PDT)
Received: from [10.0.101.84] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CD71A61E5FE01;
	Thu, 19 Oct 2023 10:14:52 +0200 (CEST)
Message-ID: <5fe36894-5554-4861-8119-e013b80583b9@molgen.mpg.de>
Date: Thu, 19 Oct 2023 10:14:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: initialize waitqueues before
 starting watchdog_task
Content-Language: en-US
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org,
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20231019071346.55949-1-mschmidt@redhat.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231019071346.55949-1-mschmidt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Michal,


Am 19.10.23 um 09:13 schrieb Michal Schmidt:
> It is not safe to initialize the waitqueues after queueing the
> watchdog_task. It will be using them.
> 
> The chance of this causing a real problem is very small, because
> there will be some sleeping before any of the waitqueues get used.
> I got a crash only after inserting an artificial sleep in iavf_probe.
> 
> Queue the watchdog_task as the last step in iavf_probe. Add a comment to
> prevent repeating the mistake.
> 
> Fixes: fe2647ab0c99 ("i40evf: prevent VF close returning before state transitions to DOWN")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 6a2e6d64bc3a..5b5c0525aa13 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -4982,8 +4982,6 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	INIT_WORK(&adapter->finish_config, iavf_finish_config);
>   	INIT_DELAYED_WORK(&adapter->watchdog_task, iavf_watchdog_task);
>   	INIT_DELAYED_WORK(&adapter->client_task, iavf_client_task);
> -	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
> -			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
>   
>   	/* Setup the wait queue for indicating transition to down status */
>   	init_waitqueue_head(&adapter->down_waitqueue);
> @@ -4994,6 +4992,9 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	/* Setup the wait queue for indicating virtchannel events */
>   	init_waitqueue_head(&adapter->vc_waitqueue);
>   
> +	queue_delayed_work(adapter->wq, &adapter->watchdog_task,
> +			   msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
> +	/* Initialization goes on in the work. Do not add more of it below. */
>   	return 0;
>   
>   err_ioremap:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

