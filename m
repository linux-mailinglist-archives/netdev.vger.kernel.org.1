Return-Path: <netdev+bounces-48571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0037EEE2F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6711F25A23
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B76FF4FC;
	Fri, 17 Nov 2023 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB0BD4E
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:13:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D5E8F20891;
	Fri, 17 Nov 2023 10:13:17 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PfacFf9CD-KL; Fri, 17 Nov 2023 10:13:17 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6B753207B0;
	Fri, 17 Nov 2023 10:13:17 +0100 (CET)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 674E280004A;
	Fri, 17 Nov 2023 10:13:17 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 10:13:17 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 17 Nov
 2023 10:13:16 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 122473180CBA; Fri, 17 Nov 2023 10:13:15 +0100 (CET)
Date: Fri, 17 Nov 2023 10:13:15 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, <devel@linux-ipsec.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 ipsec-next 1/2] xfrm: introduce forwarding of ICMP
 Error messages
Message-ID: <ZVcuqzgmLqzVBNdP@gauss3.secunet.de>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
 <0cde5ae80fd682dba455cb8b18b46fc36ed69422.1698394516.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0cde5ae80fd682dba455cb8b18b46fc36ed69422.1698394516.git.antony.antony@secunet.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Oct 27, 2023 at 10:16:29AM +0200, Antony Antony wrote:
> +
> +static struct sk_buff *xfrm_icmp_flow_decode(struct sk_buff *skb,
> +					     unsigned short family,
> +					     struct flowi *fl,
> +					     struct flowi *fl1)
> +{
> +	struct net *net = dev_net(skb->dev);
> +	struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
> +	int hl = family == AF_INET ? (sizeof(struct iphdr) +  sizeof(struct icmphdr)) :
> +		 (sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr));
> +	skb_reset_network_header(newskb);

This is not needed there.

> +
> +	if (!pskb_pull(newskb, hl))
> +		return NULL;

This leaks newskb.

> +	skb_reset_network_header(newskb);
> +
> +	if (xfrm_decode_session_reverse(net, newskb, fl1, family) < 0) {
> +		kfree_skb(newskb);

The newskb is not dropped because of an error, maybe better use
consume_skb().

> +		XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);

This might bump a second stat counter for this packet. Also
this is not really an error, because you just can't parse
the payload of the icmp packet.

> +		return NULL;
> +	}
> +
> +	fl1->flowi_oif = fl->flowi_oif;
> +	fl1->flowi_mark = fl->flowi_mark;
> +	fl1->flowi_tos = fl->flowi_tos;
> +	nf_nat_decode_session(newskb, fl1, family);
> +
> +	return newskb;

Why do you return newskb here? It is not used in all
of the calling functions.

The rest looks good, thanks!

