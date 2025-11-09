Return-Path: <netdev+bounces-237055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 760EDC44112
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65C604E10B1
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392925C6E2;
	Sun,  9 Nov 2025 14:55:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7E1AAE13
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762700152; cv=none; b=UTH4BALjxkPDEAaYopS6EljoG5Frv9UtL6hd6VVeUCXSYxXM74jmmnCd2YlR4YXV/OldWLOfxAw8CzR10cQJ8a+xrUSvVI/1DlH44UlRL4nQIflAE1iZEK9NYGVkV4bXkLWZT6+gt8KzDP8BPZRntVEflotXQTAH/H4Qo/s9TMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762700152; c=relaxed/simple;
	bh=lgCzqXkrhThQBcGYtRXUA+OiLdXIrho0ArsGYfrN8kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POyB4Ey5CgSnsh4Xqk6P7NPNu95PxIuDyePY0ly6L6FMHw/ywQ8AiVlplamXyHfA0mj1v1ZlGJGEVFoYne9S2SRDbA7zfddPw+LkLhkXuhUUmwkh4dNCT5Gp1GBI9pfxUuLEqxLZFPUpa71MrT4XKlr18wyJuA+ap01NbX5VySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.40.22] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1CD7D61CC3FDA;
	Sun, 09 Nov 2025 15:55:08 +0100 (CET)
Message-ID: <10160d36-9580-49b5-ac1a-124665c7a396@molgen.mpg.de>
Date: Sun, 9 Nov 2025 15:55:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: fix incorrect src_ip checks
 and memcpy sizes in cloud filter
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com
References: <20251107160943.2614765-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251107160943.2614765-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Alok,


Thank you for the patch.

Am 07.11.25 um 17:09 schrieb Alok Tiwari:
> Fix following issues in the IPv4 and IPv6 cloud filter handling logic in
> both the add and delete paths:
> 
> - The source-IP mask check incorrectly compares mask.src_ip[0] against
>    tcf.dst_ip[0]. Update it to compare against tcf.src_ip[0]. This likely
>    goes unnoticed because the check is in an "else if" path that only
>    executes when dst_ip is not set, most cloud filter use cases focus on
>    destination-IP matching, and the buggy condition can accidentally
>    evaluate true in some cases.

Do you have a reproducer?

> - memcpy() for the IPv4 source address incorrectly uses
>    ARRAY_SIZE(tcf.dst_ip) instead of ARRAY_SIZE(tcf.src_ip), although
>    both arrays are the same size.
> 
> - In the IPv6 delete path, memcmp() uses sizeof(src_ip6) when comparing
>    dst_ip6 fields. Replace this with sizeof(dst_ip6) to make the intent
>    explicit, even though both fields are struct in6_addr.
> 
> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 081a4526a2f0..c90cc0139986 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3819,9 +3819,9 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
>   		if (mask.dst_ip[0] & tcf.dst_ip[0])
>   			memcpy(&cfilter.ip.v4.dst_ip, tcf.dst_ip,
>   			       ARRAY_SIZE(tcf.dst_ip));
> -		else if (mask.src_ip[0] & tcf.dst_ip[0])
> +		else if (mask.src_ip[0] & tcf.src_ip[0])
>   			memcpy(&cfilter.ip.v4.src_ip, tcf.src_ip,
> -			       ARRAY_SIZE(tcf.dst_ip));
> +			       ARRAY_SIZE(tcf.src_ip));
>   		break;
>   	case VIRTCHNL_TCP_V6_FLOW:
>   		cfilter.n_proto = ETH_P_IPV6;
> @@ -3876,7 +3876,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
>   		/* for ipv6, mask is set for all sixteen bytes (4 words) */
>   		if (cfilter.n_proto == ETH_P_IPV6 && mask.dst_ip[3])
>   			if (memcmp(&cfilter.ip.v6.dst_ip6, &cf->ip.v6.dst_ip6,
> -				   sizeof(cfilter.ip.v6.src_ip6)))
> +				   sizeof(cfilter.ip.v6.dst_ip6)))
>   				continue;
>   		if (mask.vlan_id)
>   			if (cfilter.vlan_id != cf->vlan_id)
> @@ -3965,9 +3965,9 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
>   		if (mask.dst_ip[0] & tcf.dst_ip[0])
>   			memcpy(&cfilter->ip.v4.dst_ip, tcf.dst_ip,
>   			       ARRAY_SIZE(tcf.dst_ip));
> -		else if (mask.src_ip[0] & tcf.dst_ip[0])
> +		else if (mask.src_ip[0] & tcf.src_ip[0])
>   			memcpy(&cfilter->ip.v4.src_ip, tcf.src_ip,
> -			       ARRAY_SIZE(tcf.dst_ip));
> +			       ARRAY_SIZE(tcf.src_ip));
>   		break;
>   	case VIRTCHNL_TCP_V6_FLOW:
>   		cfilter->n_proto = ETH_P_IPV6;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

