Return-Path: <netdev+bounces-273628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHRECNDHy2mnLgYAu9opvQ
	(envelope-from <netdev+bounces-273628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:10:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864E369FAC
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7B23302A96B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5553DBD76;
	Tue, 31 Mar 2026 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtQVer5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA819992C
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962217; cv=none; b=HmoYpMJUjp2MOA/eUpVpd8aCynHEXbvaVW79twfdISM/y9tIt3WDghw5vzpYymMIyH+TYFYANTLeQcVCfOdxqai5zRPD0CpG8+FL2EC9CU4u0t8RPyQ2y29yd74FHs4lFn4N/G4Urt/Db/1MRijYhA1+szn6ihaOmIwZ0NFOWKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962217; c=relaxed/simple;
	bh=HLL+anMQEr2xZrKHsjbOOFs32foSdLCqdsMgxZQgwS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpnwm8X6RMf2s21lJO8FX+A1qblAcLcJRPByfrVHIuhH1u/vdpbRUCVTIOkk7q4S0AG4bmuxixKl5NZ4MfFjPNDCYszMIs2bNZgxmwj+TtXMITaPjgwjAM0XDUKcY7QpwXNQLd7BfoutvUflsRotpbFgCAXZUETvtySR5V58Pf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtQVer5K; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89cc68655f8so59221536d6.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774962215; x=1775567015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0LFedWL/RtJaVjEz95rA1/31zCEvOBr1xfaMxHaAk8=;
        b=qtQVer5KYDBH12geSTTJsnsDXZL+MBJ9VIFZfqus0VV2To+J9TvdzCRcOLyusY1YSd
         E4rYDkGAopSXiXoHLv+gPc1EVnH2bdGEjqILWBqGN7Fe/VZ2/GACP+gPSPBqF29y0r2D
         vCTxTROvBuXVFC+B2DEdmBFuuLpg5RYi/LpFudRyGucuiPBEUmGN53k8L0JB1ZK75Gog
         Qw2veOewRCVI8wjtbtVUh4g+Q1d1SyiwgE6ZKdO7hM3Y35HVJyMxEEH6OH1eOeeOw9ep
         D86YdTTtue2KuuJ+3fgOj3ZkVcPsyAlK6sm1PGRlxdy5K+xkg/W572UFscM0IwlDHj5g
         U7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774962215; x=1775567015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0LFedWL/RtJaVjEz95rA1/31zCEvOBr1xfaMxHaAk8=;
        b=YRLX/K9pz8duBD67c/adgYRrtcUYhdelJ+fQVj5PPWQIVZEtCg0oTpyBdLOV2yJwyM
         lwRWdvGYWHoQ+ShLVkWkpVVJ5Oum8jpBlfoRUyivcPF2hMeBNmuYZ10+HJLv3fZKMg4Q
         OywO+Ab9V7jBVf9pGPOkNO5shBWRFic97LnuNzzPx/MMbgN9mV8gWnKizvOYg893neEM
         nohkjSJ6OA3R1ocCOPP4BWiGJGZxUhoNgoAOR0xlD6gHzJd+2wAYDX7t2W1fgGYeVvi0
         dD3m0W6NAn1EVQdpyzwSw2isCRFPkbXrLFa40zTJmADguBU0Zb8dU/TKzfYwHskgA6bo
         NDLA==
X-Forwarded-Encrypted: i=1; AJvYcCUCSkSLaQBiRxyrY1/3FJ8K5cetFU89m2lSDkGY7gnV0GJHKjyUNQxCmGtjlDjPlNu+TG4pELo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQZYiRnBh1Cgpmx1V18Qo8WdgQt/Gaj8VC9daGZL0/MlyKA8k
	kLk4PK7MDD5Y1JbheJPtCYhNwME0h0uc0u9bNFLcjnBcR7q/LVq8+vOj
X-Gm-Gg: ATEYQzxXhRWyiPeDqhvLUp65aoj23wIm7OiIOZxpGRie/DfWMLcTS1PZl0LMX73sDUW
	3LZ9kePLjI/evaDJ2oI5dpunwV7ZFvt+la9WlHNCKMP2hAqhxAwOX1JPagnbIK+Xrk/3miocP+5
	gTvp4q2Rdyg9BvIenYWaoLNAbYAxCWDwr/AXZvz6LuW9jU5VUgSNkrGNYrTyuJ/Erf+8k2wB9Qc
	vKguMlCGCxhVQZeCnlEgsOwvaFbUmnuM/CGasn+f33p+uzTTACCHK63dXMW5x6aMb0wboAOyKKk
	pagXeQwG+7mOyqNLbtKU13XZH02JqUQ8a7G3XaDqejVMX82bEAfBdrCq23NHjhsB15oH7EEs9oo
	NQ6m2+KK135CIlJbuObQ2IrteueO552J+fz9PI1wW5+8dVixO5Jxl5sebDxywL4WaYjrHtO0iEf
	WxAioQIhqrUQCWVArXjCtEGC7OEz/4EjAgC84wrw6c3/7l4kmN8n6DTz5nNUL+4OHpG7NKKyvaI
	IdRESf18RUyF7c=
X-Received: by 2002:a05:6214:4710:b0:8a0:9376:99c5 with SMTP id 6a1803df08f44-8a2cbe52700mr49406126d6.30.1774962215106;
        Tue, 31 Mar 2026 06:03:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:c599:9014:d27e:9c09? ([2620:10d:c091:500::1:4033])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf28016dsm90501156d6.25.2026.03.31.06.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 06:03:34 -0700 (PDT)
Message-ID: <a9c76822-cca7-4108-9395-4af6a4ff1eca@gmail.com>
Date: Tue, 31 Mar 2026 09:03:33 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
 <20260330223143.2394706-3-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260330223143.2394706-3-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273628-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1864E369FAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/30/26 6:31 PM, Wei Wang wrote:
> +    -
> +      name: dev-assoc
> +      doc: Associate a network device with a PSP device.
> +      attribute-set: dev
> +      do:
> +        request:
> +          attributes:
> +            - id
> +            - ifindex
> +            - nsid
> +        reply:
> +          attributes: []
> +        pre: psp-device-get-locked
> +        post: psp-device-unlock
> +    -
> +      name: dev-disassoc
> +      doc: Disassociate a network device from a PSP device.
> +      attribute-set: dev
> +      do:
> +        request:
> +          attributes:
> +            - id
> +            - ifindex
> +            - nsid
> +        reply:
> +          attributes: []
> +        pre: psp-device-get-locked
> +        post: psp-device-unlock
>   

Not sure where we ended up on the netns isolation model, but I'll just 
note that these ops are not "admin" so they can be done from any netns. 
I don't think that's an issue per se, but I wonder if someone with a 
different use case will come along down the road and want to go for the 
more restrictive deployment option.

>   
> +	list_for_each_entry_safe(entry, entry_tmp, &psd->assoc_dev_list,
> +				 dev_list) {
> +		list_del(&entry->dev_list);
> +		rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
> +		netdev_put(entry->assoc_dev, &entry->dev_tracker);
> +		kfree(entry);
> +	}
> +
>   	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
>   
>   	psd->ops = NULL;
> @@ -361,5 +381,4 @@ static int __init psp_init(void)
>   
>   	return genl_register_family(&psp_nl_family);
>   }
> -
>   subsys_initcall(psp_init);

nit: spurious line deletion

> +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_dev *psd = info->user_ptr[0];
> +	struct psp_assoc_dev *psp_assoc_dev;
> +	struct net_device *assoc_dev;
> +	u32 assoc_ifindex;
> +	struct sk_buff *rsp;

nit: reverse xmas issue

> +
> +int psp_nl_dev_disassoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_assoc_dev *entry, *found = NULL;
> +	struct psp_dev *psd = info->user_ptr[0];
> +	u32 assoc_ifindex;
> +	struct sk_buff *rsp;

nit: reverse xmas issue


