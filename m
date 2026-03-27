Return-Path: <netdev+bounces-272383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLZUOaknxmnQGwUAu9opvQ
	(envelope-from <netdev+bounces-272383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:46:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7DD33FFCC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBF1730E4276
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907139FCD1;
	Fri, 27 Mar 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="K1Kw/B1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AE23BE63E
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593482; cv=none; b=kVnljgiAYWxo9PHw86Gmn1AlNiJROiIFI5wR9LxCARzJJu2Pn1BT6AzBXRloTnfTQ6nEIrS1gpIBB3Yb9LTKOlEeaDjSOuGUOlMwGUPwTlxXIXuOu8a86hZdOtN1QgRw7f04Pop0BWw24GQ44u9QfwxxMCPgxm27wW047dNhpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593482; c=relaxed/simple;
	bh=+4LgBG2lPnteLEva5q5EV8krPKKJf5AzHFIuy/FUdK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTf0nsPjz+fxr14GRuHJtpE0KBORlD0FsZ9LR1xeQCW5sP0wi57dgqlP45xDqNfsCFEXfZhjCnVEsOQykT4ND7AS9ldNAD1oCvvtApg005hed08fZBwF6O+QtFRNJ0cBO402555dxjVbBdhjKR0wHNmdMsJE/gGwdu+3/pnOaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=K1Kw/B1m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48704db565eso24678705e9.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774593471; x=1775198271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eglRAgY65J6K+hGvowI7XYpmAYRuD59HMwb8erAafGE=;
        b=K1Kw/B1mww//S1t+6oVki27SFuiGdVD7Xx46jspQmc25Q2e3GnyHKkx3ewuWBnDrT8
         jZ4A/gx7ThG5VAfMDl0n3boDTruwj7A7u1qX+f/nQWz5Dy156288nVvvf12JxM2GIJ/D
         agGmWSMQUKHKHnWCK1Ij385apB+Z0/aw+4aXxNgR733V4l9TLsZLI70x3pL9YpdsQ4ZE
         u66rcp/7WhI/Un7MC/utmFkyYNfB+Naqp0WRtCFQjTPFjfLp2wXqGAmPdPP8IyWNkzj8
         t//09oYfb6oFsLZxcOGVUTKkyHrndmKlAONChNPkAJnJvdmMg49fZ3VAicMZpAeh6vjp
         vPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593471; x=1775198271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eglRAgY65J6K+hGvowI7XYpmAYRuD59HMwb8erAafGE=;
        b=kDJ2PHR4qensJ7aJwkUKdZWulYgvCw3zbqqahvL4bqqUbQ8L5nXJWULAZFl5AumWXU
         0sftRj4wGNjESUPlrIuZO7Oo2PtK2N0bmYB1v2Bgbn8ZzdjNmzwgww5bi5A5we0a0nL1
         yBm+/qxbp+0cx1P6goXFACWoMabVnARKRXGSeOLHKFtn/L9p9849+Em4wZh0P0JQmz4e
         KJCv2u51wS6dvR9GpHGQWFe5FZJZCoJZT/bu3W8lzpI780uX9kvQ2Tpw/vqSzDJwtWem
         0m7mui+HSZVqoJ6oZqMAKxOXlKEiAkoGXjGOqfaO87cV5N9TYXZR6Qt856HdrtMLhm8e
         J1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWEIVOqrFVvr2OMQMSOdYAEYkXbkK17dbTGzJXSKIL7OX7Cd8dr6n5i82Xy9IRknKpJg1nGZ/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANs96hRvDta/vG6hoRcR7ipLgec3dAsAzo2qtESBQbPjJna+m
	mp3hqZ4F6F0PWFoci2wT8lGd9IM3jEIuQ2uskytydfzJsqOGPiT3mZmritRTlAtOhGo=
X-Gm-Gg: ATEYQzzaOfo89BdAUYpxhOG7LvXCeWssuqXLdmGrlTtG8p35PhDmkveqs7SEnqFlKER
	zngNn/G3MCXsY4V4mkcr7lBJmZQM3cW7+MA8frB7T2vjh119ZpGoEJQWdb9LxTOQDg7KuMRk3A6
	WXqSy4hE1hZcGNN5g4+uQU7X5SK0+PgLRgAHF7VF1z8V4UD4XrLOEkDWDiMm2S5mYpkla6pbVls
	bXOedE1qMDbVjIUAhq2ife/E0krx9Y9ekJ/OjfG4foHNVnprr1BL1/KpdkGNNcLJ42dtW+9mtV5
	zRJpn0YBsdbS4AN57D2shK5/azqNyZyCzY7Odwe7gmOn9T5lqFgxu3L2sGeO28fDvZvNzwv/Co6
	XWoRJJHlUpUo88RKxdFf/uRQEPZFEIZLohRlm20fpV4VE08LqFO+cinwSZb5LEMIxeTIj1MTr5V
	gQ8z9TSqAKWfT0zy7h7ZQtUTNkRz+GbA+qZwdAfn24VaWPmSsDRkxz6A==
X-Received: by 2002:a05:600c:8485:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-48727d77c8fmr19397525e9.15.1774593470767;
        Thu, 26 Mar 2026 23:37:50 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9134fsm123324635e9.9.2026.03.26.23.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 23:37:50 -0700 (PDT)
Message-ID: <cc0bf1a8-5bae-4e92-8b92-8b9038632990@blackwall.org>
Date: Fri, 27 Mar 2026 08:37:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] bridge: br_nd_send: linearize skb before parsing
 ND options
To: Yang Yang <n05ec@lzu.edu.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com
Cc: andrew+netdev@lunn.ch, horms@kernel.org, florian.fainelli@broadcom.com,
 roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
 netdev@vger.kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 tanyuan98@outlook.com, bird@lzu.edu.cn
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
 <20260326034441.2037420-2-n05ec@lzu.edu.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326034441.2037420-2-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272383-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,broadcom.com,cumulusnetworks.com,us.ibm.com,tipi-net.de,vger.kernel.org,lists.linux.dev,gmail.com,outlook.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,lzu.edu.cn:email,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D7DD33FFCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/03/2026 05:44, Yang Yang wrote:
> br_nd_send() parses neighbour discovery options from ns->opt[] and
> assumes that these options are in the linear part of request.
> 
> Its callers only guarantee that the ICMPv6 header and target address
> are available, so the option area can still be non-linear. Parsing
> ns->opt[] in that case can access data past the linear buffer.
> 
> Linearize request before option parsing and derive ns from the linear
> network header.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_arp_nd_proxy.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 1e2b51769eec8..af3d1e33f50b8 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -251,12 +251,12 @@ struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
>   
>   static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   		       struct sk_buff *request, struct neighbour *n,
> -		       __be16 vlan_proto, u16 vlan_tci, struct nd_msg *ns)
> +		       __be16 vlan_proto, u16 vlan_tci)
>   {
>   	struct net_device *dev = request->dev;
>   	struct net_bridge_vlan_group *vg;
> +	struct nd_msg *na, *ns;
>   	struct sk_buff *reply;
> -	struct nd_msg *na;
>   	struct ipv6hdr *pip6;
>   	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
>   	int ns_olen;
> @@ -264,7 +264,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	u8 *daddr;
>   	u16 pvid;
>   
> -	if (!dev)
> +	if (!dev || skb_linearize(request))
>   		return;
>   
>   	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
> @@ -281,6 +281,8 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	skb_set_mac_header(reply, 0);
>   
>   	daddr = eth_hdr(request)->h_source;
> +	ns = (struct nd_msg *)(skb_network_header(request) +
> +			       sizeof(struct ipv6hdr));
>   
>   	/* Do we need option processing ? */
>   	ns_olen = request->len - (skb_network_offset(request) +
> @@ -472,9 +474,9 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>   				if (vid != 0)
>   					br_nd_send(br, p, skb, n,
>   						   skb->vlan_proto,
> -						   skb_vlan_tag_get(skb), msg);
> +						   skb_vlan_tag_get(skb));
>   				else
> -					br_nd_send(br, p, skb, n, 0, 0, msg);
> +					br_nd_send(br, p, skb, n, 0, 0);
>   				replied = true;
>   			}
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


