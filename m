Return-Path: <netdev+bounces-267429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HWWJxL+s2mWewAAu9opvQ
	(envelope-from <netdev+bounces-267429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:07:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC8C282B34
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82F59306CDE2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306923914FA;
	Fri, 13 Mar 2026 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6zIYfOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F22C0F6F
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403638; cv=none; b=mktueaXnajngHUsb+MDZYGh/V8ivMsoITNBhFyFjNTb6Du0xFEGIsgEd6DXil5L5szEp+l8Xl4N2fdSpRwCwSh6e6EQWQmKP9Af9dD2Oomd0Hg1az5vlaODsZiy0e/Ly5gJzTVYz56D5PXiN7fE/HbFA88H1gZXq/8ERxbfAI+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403638; c=relaxed/simple;
	bh=WyGBrZEqneOMA36Rq97DAhfkG/b1VNMLozC8HuoKhOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQ85YL04kNDSl9xnidpAWri1yA9tMno1OIbf/pJ56b9ayvCZkUs1VLl42qWNgzM7gkjp5RK4IiA1mlnzJs0a2MJoUxAZLBBtDC1+gu1LRJH2zXPREO4aN2sG/NCCvsEMTk2obDifVb69wBXWh7Pg2wZqmRX0KKDll2IZMWhPKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6zIYfOx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso19485525e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 05:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773403635; x=1774008435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qi4fWV4Vp6Y6RIKcKR3GE504LvU1lft8ajgS4e4DM4s=;
        b=m6zIYfOx3yTsNgqrqlmjtcPLbNHg3Ib3LMXpl1hy+sbUV9SvqJEdtcH0mEluk9KWJk
         pUJ5LKjXH2b4KsbsbzW2ADXPf3ImZ3m576MB6cm7cAcB3U2G/84vOrOQCxQJMqwyqnIO
         +IA4FW8UGAwzv48siqVBarpGCeGA7XOIPFmNDpKjJ0b59i6v4FCYHLsSIXgoCOoHExeC
         qCDtOBelUdarLsqT4B/mEdJYTr8Ej1ynr1bCaY41+wRfR9qwL8kqO9bkQJ68J/YYUhqA
         TzaUH2i4CyaDpcYiVcQYYxvMxOELjAOHKb2JhJ2tkQakLlYryTrIA/JMng8j2VDixXc2
         bozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773403635; x=1774008435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi4fWV4Vp6Y6RIKcKR3GE504LvU1lft8ajgS4e4DM4s=;
        b=Y58jNARJACVnSLuzF3S57w3vbace0kY7MK3ja3xyTNDZ6zkB02RyJa2zdPtgLH3FVd
         NgWjpxdxQYouH3zBmAPp+3dijMr9qEDcQ1spcUjRulUzndxV+nDLsJqqSMIVtqRoFZT1
         VgMzFFvNBjlkaVLyt9tT08swkp04tImHxo2mk5ZnAT546wpJF4QuSah9OruPqUPmoO0N
         FyYBE+K6rD7Iw50t2wGmDb2b+sEL+9huak/Lbd0uoNjpG3shPuHHxa8gy3OkELNZlcGy
         TggAtX3BczfmYA/fHzcloExK0cFgSgB+cD6INFhA1PlxxWnFXZFPt9d9KyEr/5N2oPXI
         ck0w==
X-Forwarded-Encrypted: i=1; AJvYcCVjBDspHQdM5nffdm0zKsjNg1zQz5sKzbglQDyCIoWFU5sx6AgkTzTzlku4WPI2fh3t82MWmWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/0x0qsMbTOszvkUuX/5Q1AZtIXZFAsqPVWKk4vzwIHAG7MVB
	5U98yN9lN7G7Kt+mcHYle3hxdXYTksZSX4E7b4ZlxJs7qyS98U33BlZXvsJTag==
X-Gm-Gg: ATEYQzyKGuf3Rl8iYP7G9FISIworjk+eSgw/irWp65EoB3cgsIMmDEROuwe8XgfY3gf
	Vu/x3fg77NXVu9LXh3rVa4b9nUoH+f5gNus5aaKcMdem/a6tGFOUrQCVTc0zNs1RyWj4MLEh8um
	W3goOAjdOW+5oPISuTexo76EUGxso+dARWl9rE72wIm5EAyog5olo0XzugMvXa396Co24GRcqxQ
	Q63VhZIrq+wHgnlrGoPn3YFFBkLnJqfaOYhSaoe0yEyb//yJ/e47bROgghrVMy7XACXCQTYC5m2
	x1MnRwNyv2dafW4Hu3HJcqOE6Y1absGF8kP86syG3NuZLLkNh3SUE8sHaJZ++Q5pgVXdgEn8kL1
	bIcTPIyRyK/bLXFMechCC3bWFOrFgSyFv2UlGlt7DwlWQGeBS7v4OR+ou8YwsPpFut2NPZF3Be9
	Q4tz883VQq6Jm9rZP8k3Lc+VNh4+IUAMoi7u3NrawMkQ9VHzsENh62+PzHuSkKwRHCHKnf578gY
	yFayxPnijuCFA==
X-Received: by 2002:a05:600c:1f8e:b0:485:3f58:da1 with SMTP id 5b1f17b1804b1-485566e936amr52710955e9.9.1773403634782;
        Fri, 13 Mar 2026 05:07:14 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe226473sm15837450f8f.32.2026.03.13.05.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 05:07:14 -0700 (PDT)
Message-ID: <9748039f-3bba-4420-8da9-7644022d1ffc@gmail.com>
Date: Fri, 13 Mar 2026 12:07:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10 net-next v2] drivers: net: drop ipv6_stub usage and
 use direct function calls
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:SFC NETWORK DRIVER" <linux-net-drivers@amd.com>
References: <20260310153506.5181-1-fmancera@suse.de>
 <20260310153506.5181-6-fmancera@suse.de>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260310153506.5181-6-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267429-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DC8C282B34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 10/03/2026 15:34, Fernando Fernandez Mancera wrote:
> As IPv6 is built-in only, the ipv6_stub infrastructure is no longer
> necessary.
> 
> Convert all drivers currently utilizing ipv6_stub to make direct
> function calls. The fallback functions introduced previously will
> prevent linkage errors when CONFIG_IPV6 is disabled.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
...
> diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
> index d168282f30bf..d8a5f9fd1007 100644
> --- a/drivers/net/ethernet/sfc/tc_counters.c
> +++ b/drivers/net/ethernet/sfc/tc_counters.c
> @@ -112,7 +112,7 @@ static void efx_tc_counter_work(struct work_struct *work)
>  					 encap->neigh->egdev);
>  		else
>  #if IS_ENABLED(CONFIG_IPV6)
> -			n = neigh_lookup(ipv6_stub->nd_tbl,
> +			n = neigh_lookup(ipv6_get_nd_tbl(),
>  					 &encap->neigh->dst_ip6,
>  					 encap->neigh->egdev);
>  #else
> diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
> index da35705cc5e1..63d8f794b869 100644
> --- a/drivers/net/ethernet/sfc/tc_encap_actions.c
> +++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
> @@ -149,8 +149,7 @@ static int efx_bind_neigh(struct efx_nic *efx,
>  #if IS_ENABLED(CONFIG_IPV6)
>  			struct dst_entry *dst;
>  
> -			dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &flow6,
> -							      NULL);
> +			dst = ip6_dst_lookup_flow(net, NULL, &flow6, NULL);
>  			rc = PTR_ERR_OR_ZERO(dst);
>  			if (rc) {
>  				NL_SET_ERR_MSG_MOD(extack, "Failed to lookup route for IPv6 encap");
> @@ -531,7 +530,7 @@ static int efx_neigh_event(struct efx_nic *efx, struct neighbour *n)
>  	if (n->tbl == &arp_tbl) {
>  		keysize = sizeof(keys.dst_ip);
>  #if IS_ENABLED(CONFIG_IPV6)
> -	} else if (n->tbl == ipv6_stub->nd_tbl) {
> +	} else if (n->tbl == ipv6_get_nd_tbl()) {
>  		ipv6 = true;
>  		keysize = sizeof(keys.dst_ip6);
>  #endif

# for sfc:
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

