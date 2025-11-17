Return-Path: <netdev+bounces-239037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888CC62B75
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44A794EAF17
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A0A30EF66;
	Mon, 17 Nov 2025 07:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372E156661;
	Mon, 17 Nov 2025 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364413; cv=none; b=XiAhzjpEHANTiI4z0il9ZOljgpCOGUZmEkKWk9+57lwSqxZvxMYWcYAskb7IPGscVTQnmkdmfMunmX8QjDcRIV9iMCUe++0czAHBaM32Jg4BL8L+0VLp4vFWuD0eo5DKgDo7h4MD/V1Kt48Koco8oNzj52oiShGNxO1gquPHjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364413; c=relaxed/simple;
	bh=tWBXgKy9oEsdWFTCNVD9n4cGX778aInFhrpLM35q0HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5yeGK3YwBRNZ2X/jPoXmcuzblLBfyTmsV99M1I/LQ8jr5L5OaMC93gdy/YQ0foCGE4a61lmv/LrwFLRyJ0qfAZ/L1X8jB3IoMEiZTkwBdoKTO88JJuldVA3iUtsluLpmsuTX6xAyXoorpBSCtPEXNBM6MrDT1zYtCaw+ZJunv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.216] (p5dc55243.dip0.t-ipconnect.de [93.197.82.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 600AF61CC3FDE;
	Mon, 17 Nov 2025 08:25:56 +0100 (CET)
Message-ID: <09f58140-8d9c-42f3-a9f4-380c30d7c11e@molgen.mpg.de>
Date: Mon, 17 Nov 2025 08:25:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix aux device unplugging
 when rdma is not supported by vport
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Tantilov <emil.s.tantilov@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>, Josh Hay <joshua.a.hay@intel.com>
References: <20251117070350.34152-1-larysa.zaremba@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251117070350.34152-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Larysa,


Thank you for your patch.

Am 17.11.25 um 08:03 schrieb Larysa Zaremba:
> If vport flags do not contain VIRTCHNL2_VPORT_ENABLE_RDMA, driver does not
> allocate vdev_info for this vport. This leads to kernel NULL pointer
> dereference in idpf_idc_vport_dev_down(), which references vdev_info for
> every vport regardless.

Please paste part of the Oops log lines.

> Check, if vdev_info was ever allocated before unplugging aux device.

Please describe your test system.

> Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_idc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index c1b963f6bfad..4b1037eb2623 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -322,7 +322,7 @@ static void idpf_idc_vport_dev_down(struct idpf_adapter *adapter)
>   	for (i = 0; i < adapter->num_alloc_vports; i++) {
>   		struct idpf_vport *vport = adapter->vports[i];
>   
> -		if (!vport)
> +		if (!vport || !vport->vdev_info)
>   			continue;
>   
>   		idpf_unplug_aux_dev(vport->vdev_info->adev);

The diff looks good.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

