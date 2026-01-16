Return-Path: <netdev+bounces-250586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9168D37A65
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAF8330146CE
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E4D339857;
	Fri, 16 Jan 2026 17:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9CD335573
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585192; cv=none; b=nf4HYuxe4MtA2D5TgojCVxwlyRwdDiDZwLoCIS9Kd05DwmzpJ07tqO7VXTCHfU2W6SIoKyQO/g3DiJtVXOGdTXagQLz8NJEHJU5bwcVbRzMSHcqN/DOiRFsAEEZp+gl/F31sy684Hbux0MVaToSWbSTMpwcXPdJAG6RZuFP2c3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585192; c=relaxed/simple;
	bh=4KhA2N89OUrkCUozlHBvO123NlacAJdVbaEW8kC5D4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rATQey1H+LvRUUL0Hc+se4zQiq9AYKRyKhB4CK8wPt0H2FhjWbOewNXY7AUNsgaLT703GkxQ7WR+zN1wzUlLoIs77VbBQ80e8PJ7K6Ku44rvaUu6LGzEZC9695kz7X6KRLVFoNGIL/C+CMX5wSBBarFggjnjN90vRtnajzaFS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.54.236] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8CAA44C2887195;
	Fri, 16 Jan 2026 18:39:27 +0100 (CET)
Message-ID: <f7f38dbf-3c5e-428d-a4c3-19f3a9ce18ee@molgen.mpg.de>
Date: Fri, 16 Jan 2026 18:39:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: Fix flow rule delete
 failure due to invalid validation
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>
References: <20260113180113.2478622-1-sreedevi.joshi@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260113180113.2478622-1-sreedevi.joshi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +Ahmed Zaki]

Dear Sreedevi,


Thank you for your patch.

Am 13.01.26 um 19:01 schrieb Sreedevi Joshi:
> When deleting a flow rule using "ethtool -N <dev> delete <location>",
> idpf_sideband_action_ena() incorrectly validates fsp->ring_cookie even
> though ethtool doesn't populate this field for delete operations. The
> uninitialized ring_cookie may randomly match RX_CLS_FLOW_DISC or
> RX_CLS_FLOW_WAKE, causing validation to fail and preventing legitimate
> rule deletions. Remove the unnecessary sideband action enable check and
> ring_cookie validation during delete operations since action validation
> is not required when removing existing rules.
> 
> Fixes: ada3e24b84a0 ("idpf: add flow steering support")
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index 2efa3c08aba5..49cefb973f4d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -307,9 +307,6 @@ static int idpf_del_flow_steer(struct net_device *netdev,
>   	vport_config = vport->adapter->vport_config[np->vport_idx];
>   	user_config = &vport_config->user_config;
>   
> -	if (!idpf_sideband_action_ena(vport, fsp))
> -		return -EOPNOTSUPP;
> -
>   	rule = kzalloc(struct_size(rule, rule_info, 1), GFP_KERNEL);
>   	if (!rule)
>   		return -ENOMEM;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

