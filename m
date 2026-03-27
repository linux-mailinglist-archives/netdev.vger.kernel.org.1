Return-Path: <netdev+bounces-272385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJK3J6UqxmnQGwUAu9opvQ
	(envelope-from <netdev+bounces-272385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:58:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CB63401E0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6F93317F41D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68BB3BF67A;
	Fri, 27 Mar 2026 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="DZDT/DL5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BB3BED20
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593503; cv=none; b=pZYx4HFhU23WBo52TpnenWb6KpF2MVYTZLZiGwQahG2Ax0VX1vuryhvTgMO/Eb0CUOuzr8TvxhtcRb3B54mFvWPkh6bCHUeED2dlqyD1aCUyzbVQ0ZR1/K56RPRnzdJqMk6vrfMiXoFuHGjBBhSQSHSzPdzi3yJz5l1E9ZJJbgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593503; c=relaxed/simple;
	bh=0PQ0R9rAwmS9xKjuhJFascJ1dmFx6hqwZe5aHDfzhHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lbw6nlL5boyupDBrBpVcdfJWA+SV5jYVxaR8Y04d+9y9mwMnxa7WBRpi3yvE/lgTmetOSRLOU/nVMQskvOM0b7yR0xI3s3f+9inijuMeyrTQhYC9OyKZ7NouVu6W9v86Iz1FzVi94D0L1blh8S6+/9qzcZY/VACUuu5g441TONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=DZDT/DL5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso15162105e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774593492; x=1775198292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vy83C5FxtN9GPfanScbX328M9aV0PE+NWeES6DorSXA=;
        b=DZDT/DL5MVXz72Mq71vLbsBp21neVUZWFQNS4K3IuvJ1iKl5v2oFaSukD9a09BWSS+
         BRvnmiALiu48GD9Gh8nrPvBQ7e7hGmSgHUXBkewfiNmH/vgk8v0JvFFFrgn25h9SKXuF
         e/T0C+/aJCM3SXuc7zvzYuLA9Wf0O6YClFBnfOMHonK/sLUDbEcC+2hzbLXaG6Sduu8i
         yzR9vdH9b7wVcNmq95UcXfuA6oRRsCFMduY6k2eCJRKIrl5xiwU0Iggw7VTuqI4C+xAw
         jGm3oi5b1Ew9lv59rXPWJbtPyXb8m5/cLZelRD8xKq2BMLq9aRk7WngXWmHXuVXtZtBY
         fj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593492; x=1775198292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vy83C5FxtN9GPfanScbX328M9aV0PE+NWeES6DorSXA=;
        b=jJgxKpv0v3almoF92wGud0T5GmOlXQL8EZBCeF7xzdsPOJFMs8EyC4yRBvEjcsFJTp
         G778VAuM/MS5/OV7tTWITMR19mUoYnVqvx7YpdqMID+fBkfet0LVlVD4E/APLxwq8APf
         JcQV75XM5wccGbQBDt+Sg5h9ZVq79CVbAtCL3v2SyV98XumLbJRIXBwF57hzFJZA6CkQ
         u3fUTqJ59jhTp6J24xzOy1GUT2UROJXhH0uKT9+VRX0fGvQ0SODtvI83u8AXNkpCU6Jg
         lmSv+PLsiZ4xi2qt0d56VYrrCyG/wemQ0ZygcGB2TMyZo7ViZLldyPKR5jziFtWcpPqw
         FAQg==
X-Forwarded-Encrypted: i=1; AJvYcCWkTyvCPEeDUUmQG/hKGemZbY6gfF9mj7A5TheG48c5G2GbFVjWKNE9GeWqSCBv46Ihy5Aa7VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqVTYkDsDXvLxv5VwhUZTVwvc//nEv5Iz/4UElgnzEsI5eKGk
	MlIiVqfy7Np5kFXi72Wu+6TNli2OitqPup9zlAJ5GrNHfhxg5qgawYq3u4XpMnlhypg=
X-Gm-Gg: ATEYQzxK31jxja+Jw2cFdqwLen/RfGalzdFi82B0YuTAYX3KSxhzgcVTZAquCJGZOE4
	225XjatsCXZqUlJ9KXvkDuqmTbiplEtp4wZekqpgxrS295tPZ67AmdK9ukRWX/ULvLRVEBIGlNB
	1YFY3S5HCQmNqBvdk6Il1Nd1iSyUZ8VDWgi8KA5MH9XFJrL4e/QNWth7wGSIdRqYhGZOgdBfyQ+
	uHr/tP6UEn6nRBdkLD0exicokPpgWuEPf4Q+RQ3GRbdUvEziJ5Et1V5oeebGBNBSqgx2Wkl55Np
	bQ2n+xGgRzk/KcaOE3RcvGO2q+gfE5gBAYPr8djs1qqeT+ZA+jl/W+/UqrMeu8NBH7wqmHZ0wcB
	rsMbbnckydUl5p5mNhlQlEOYQuqz5MS3F8/d+g52Ok0vyXTmfkNyXMJznpZStbAEu/tljDmiNT6
	WYd/3/M4VM3W/nRmmqIVZdMb81oMrPu7oRqubDuZjB+WGQAAncNgYxRw==
X-Received: by 2002:a05:600c:8b77:b0:486:ffa3:584 with SMTP id 5b1f17b1804b1-48727f17035mr17478945e9.15.1774593492578;
        Thu, 26 Mar 2026 23:38:12 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270fd880sm12607495e9.8.2026.03.26.23.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 23:38:12 -0700 (PDT)
Message-ID: <8414c7c5-5400-46b4-a470-fade0ff4faee@blackwall.org>
Date: Fri, 27 Mar 2026 08:38:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] vxlan: validate ND option lengths in
 vxlan_na_create
To: Yang Yang <n05ec@lzu.edu.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com
Cc: andrew+netdev@lunn.ch, horms@kernel.org, florian.fainelli@broadcom.com,
 roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
 netdev@vger.kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 tanyuan98@outlook.com, bird@lzu.edu.cn
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
 <20260326034441.2037420-4-n05ec@lzu.edu.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326034441.2037420-4-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272385-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,broadcom.com,cumulusnetworks.com,us.ibm.com,tipi-net.de,vger.kernel.org,lists.linux.dev,gmail.com,outlook.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 17CB63401E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/03/2026 05:44, Yang Yang wrote:
> vxlan_na_create() walks ND options according to option-provided
> lengths. A malformed option can make the parser advance beyond the
> computed option span or use a too-short source LLADDR option payload.
> 
> Validate option lengths against the remaining NS option area before
> advancing, and only read source LLADDR when the option is large enough
> for an Ethernet address.
> 
> Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
> Cc: stable@vger.kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
> ---
>   drivers/net/vxlan/vxlan_core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 17c941aac32db..a94ac82a61364 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1965,12 +1965,14 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
>   	ns_olen = request->len - skb_network_offset(request) -
>   		sizeof(struct ipv6hdr) - sizeof(*ns);
>   	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
> -		if (!ns->opt[i + 1]) {
> +		if (!ns->opt[i + 1] || i + (ns->opt[i + 1] << 3) > ns_olen) {
>   			kfree_skb(reply);
>   			return NULL;
>   		}
>   		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
> -			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
> +			if ((ns->opt[i + 1] << 3) >=
> +			    sizeof(struct nd_opt_hdr) + ETH_ALEN)
> +				daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
>   			break;
>   		}
>   	}

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


