Return-Path: <netdev+bounces-252294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJJ6ClQLcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:34:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F166130
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C1A48E4C2F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CEF3EDAA4;
	Thu, 22 Jan 2026 11:17:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EF3D34A6;
	Thu, 22 Jan 2026 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080646; cv=none; b=bcJrNsA5vhms6FifpDel82FDu2gKe280LA0w+nbyGtR7+4ZNRa4m8gzIxi3MlY7ACOQAv9WtiVwluoA7mV3TZG+55KhdXKd5ce5UMb7Nrvc4xMFnCHf9UN4/UV6jMwILnd8jSRd1VdUE092wkt4qMC/vqF4wzJ3IUnpHheLaoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080646; c=relaxed/simple;
	bh=R/Ez1yESDW0cTiJL0AvVzfr5g4Ms7T05DsZU7p4K3Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fz5qDg/ozGGLhrBoiPz6lTQqhZTRDJNsVgde8zxxURuqmF6vdQrW7maqYO0bClXGqDHReNZHzWnFDdaolpI4Ci8ViSJO2YfSenCxA4qNr6caQsvV6MyMpW9G2IaTRVt3u5+KZjzhLd+XVRmqC78Kelo/Yg0boNYI/PRvSRXh3UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8DDA44C1A15B96;
	Thu, 22 Jan 2026 12:16:26 +0100 (CET)
Message-ID: <880ef2b4-14a5-49fe-81ad-4b6ea430e911@molgen.mpg.de>
Date: Thu, 22 Jan 2026 12:16:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix memory leak in
 ice_set_ringparam()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260122032644.183754-1-zilin@seu.edu.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260122032644.183754-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252294-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,mpg.de:email,molgen.mpg.de:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 991F166130
X-Rspamd-Action: no action

Dear Zilin,


Thank you for your patch.

Am 22.01.26 um 04:26 schrieb Zilin Guan:
> In ice_set_ringparam, tx_rings and xdp_rings are allocated before
> rx_rings. If the allocation of rx_rings fails, the code jumps to
> the done label leaking both tx_rings and xdp_rings. Furthermore, if
> the setup of an individual Rx ring fails during the loop, the code jumps

RX ring

> to the free_tx label which releases tx_rings but leaks xdp_rings.
> 
> Fix this by introducing a free_xdp label and updating the error paths to
> ensure both xdp_rings and tx_rings are properly freed if rx_rings
> allocation or setup fails.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 969d4f8f9c02..1643b118144a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3318,7 +3318,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>   	rx_rings = kcalloc(vsi->num_rxq, sizeof(*rx_rings), GFP_KERNEL);
>   	if (!rx_rings) {
>   		err = -ENOMEM;
> -		goto done;
> +		goto free_xdp;
>   	}
>   
>   	ice_for_each_rxq(vsi, i) {
> @@ -3345,7 +3345,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>   			}
>   			kfree(rx_rings);
>   			err = -ENOMEM;
> -			goto free_tx;
> +			goto free_xdp;
>   		}
>   	}
>   
> @@ -3398,6 +3398,13 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>   	}
>   	goto done;
>   
> +free_xdp:
> +	if (xdp_rings) {
> +		ice_for_each_xdp_txq(vsi, i)
> +			ice_free_tx_ring(&xdp_rings[i]);
> +		kfree(xdp_rings);
> +	}
> +
>   free_tx:
>   	/* error cleanup if the Rx allocations failed after getting Tx */
>   	if (tx_rings) {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

