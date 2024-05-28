Return-Path: <netdev+bounces-98486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44B8D1930
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D6A286E03
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDCB16C451;
	Tue, 28 May 2024 11:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2816B757;
	Tue, 28 May 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894785; cv=none; b=uXzP+ZD09Yc28WlN4O0zb+7HLCgXEsMcwi+xbCLWcP7a8qJ1YKlNzjgKlMLc6F535jGXuXgvIbanZ316rM4yANjORdSQis3m8fZk4xRMomRkfSAmwpuQ4NdEQfh9Yzik4z8XjmQGJRSbS1fB1J0NtTMH2gxiFk06UJYUASSnzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894785; c=relaxed/simple;
	bh=Q/Nlx5p3Gs4cg9dK/G0IOH27ZNmABWYn1K95f4lLLqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+fQgAB4LqtVtC9gBBRAM98qvxD1y7z5njfZbEsZNRqMBLPweMxrZZOGJp1YYWqCm/iCcIhymmvqv+WLz80O6xkrMiDmwYPUKIiGUA3nz57wgP87j4WHr8ZLrM1FRY6TTucH//JTfu98VBPcRE/ZaNGlqJrxxrprHbORYpI2vK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.3] (g258.RadioFreeInternet.molgen.mpg.de [141.14.13.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9412061E5FE01;
	Tue, 28 May 2024 13:12:05 +0200 (CEST)
Message-ID: <88c6a5ee-1872-4c15-bef2-dcf3bc0b39fb@molgen.mpg.de>
Date: Tue, 28 May 2024 13:12:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] ice: irdma hardware init failed after
 suspend/resume
To: Ricky Wu <en-wei.wu@canonical.com>
Cc: jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
 rickywu0421@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
References: <20240528100315.24290-1-en-wei.wu@canonical.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240528100315.24290-1-en-wei.wu@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ricky,


Thank you for your patch. Some minor nits. It’d be great if you made the 
summary about the action and not an issue description. Maybe:

Avoid IRQ collision to fix init failure on ACPI S3 resume

Am 28.05.24 um 12:03 schrieb Ricky Wu:
> A bug in https://bugzilla.kernel.org/show_bug.cgi?id=218906 describes
> that irdma would break and report hardware initialization failed after
> suspend/resume with Intel E810 NIC (tested on 6.9.0-rc5).
> 
> The problem is caused due to the collision between the irq numbers
> requested in irdma and the irq numbers requested in other drivers
> after suspend/resume.
> 
> The irq numbers used by irdma are derived from ice's ice_pf->msix_entries
> which stores mappings between MSI-X index and Linux interrupt number.
> It's supposed to be cleaned up when suspend and rebuilt in resume but
> it's not, causing irdma using the old irq numbers stored in the old
> ice_pf->msix_entries to request_irq() when resume. And eventually
> collide with other drivers.
> 
> This patch fixes this problem. On suspend, we call ice_deinit_rdma() to
> clean up the ice_pf->msix_entries (and free the MSI-X vectors used by
> irdma if we've dynamically allocated them). On Resume, we call

resume

> ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
> MSI-X vectors if we would like to dynamically allocate them).
> 
> Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>

Please add a Link: tag.

If this was tested by somebody else, please also add a Tested-by: line.

> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index f60c022f7960..ec3cbadaa162 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5544,7 +5544,7 @@ static int ice_suspend(struct device *dev)
>   	 */
>   	disabled = ice_service_task_stop(pf);
>   
> -	ice_unplug_aux_dev(pf);
> +	ice_deinit_rdma(pf);
>   
>   	/* Already suspended?, then there is nothing to do */
>   	if (test_and_set_bit(ICE_SUSPENDED, pf->state)) {
> @@ -5624,6 +5624,10 @@ static int ice_resume(struct device *dev)
>   	if (ret)
>   		dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret);
>   
> +	ret = ice_init_rdma(pf);
> +	if (ret)
> +		dev_err(dev, "Reinitialize RDMA during resume failed: %d\n", ret);
> +
>   	clear_bit(ICE_DOWN, pf->state);
>   	/* Now perform PF reset and rebuild */
>   	reset_type = ICE_RESET_PFR;

What effect does this have on resume time?


Kind regards,

Paul

