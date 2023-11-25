Return-Path: <netdev+bounces-51077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A207F8FDF
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 23:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB11B20F3E
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 22:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF122F505;
	Sat, 25 Nov 2023 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="VnDaOKnm"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2A412D
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 14:48:35 -0800 (PST)
X-KPN-MessageId: c1efd6ff-8be4-11ee-8345-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c1efd6ff-8be4-11ee-8345-005056ab378f;
	Sat, 25 Nov 2023 23:48:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=hXLnjt4JAFY6EgFTooO9qakbLB2dmrhZdMOKxm0lOa4=;
	b=VnDaOKnm1TTVJrYBXAKhHvj3UKgY9al46QBX3qJzLUsOo7RtagSgD1ft0CqTwRmQ+KaoEs6t6Ie6I
	 6GCoqk/habdqMtaNQ4sDrv6K5lfn6vdjILgFTv/KHk9SwpDTfNhm7AbhDgBoDC5xkS8B5udAmn7VKT
	 9j4zjmJrWRCHrgN0=
X-KPN-MID: 33|npFmkDqB96qpO3+MNwE3Ybomc8Sc7G6TDukmZK+LJvFbbmr+ENmVLf7LpknwFMF
 hVs3FR9rOUz3Aen9wWPI9cT2/e3r/QrIcGQ+6sK2AuCY=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|lRxP0ZkgWGGFcTkkx7903JezaEZlME7wIBG8amR8ucR3kwx+7+H/eax/IKeWRYR
 c+M+U3rFZuaHFgrYt4AZbjg==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c0eadb18-8be4-11ee-a7b4-005056ab7447;
	Sat, 25 Nov 2023 23:48:31 +0100 (CET)
Date: Sat, 25 Nov 2023 23:48:29 +0100
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, devel@linux-ipsec.org,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [devel-ipsec] [PATCH v2 ipsec-next 1/2] xfrm: introduce
 forwarding of ICMP Error messages
Message-ID: <ZWJ5vZbbf2YaO6xN@Antony2201.local>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
 <0cde5ae80fd682dba455cb8b18b46fc36ed69422.1698394516.git.antony.antony@secunet.com>
 <ZVcuqzgmLqzVBNdP@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVcuqzgmLqzVBNdP@gauss3.secunet.de>

On Fri, Nov 17, 2023 at 10:13:15AM +0100, Steffen Klassert via Devel wrote:
> On Fri, Oct 27, 2023 at 10:16:29AM +0200, Antony Antony wrote:
> > +
> > +static struct sk_buff *xfrm_icmp_flow_decode(struct sk_buff *skb,
> > +					     unsigned short family,
> > +					     struct flowi *fl,
> > +					     struct flowi *fl1)
> > +{
> > +	struct net *net = dev_net(skb->dev);
> > +	struct sk_buff *newskb = skb_clone(skb, GFP_ATOMIC);
> > +	int hl = family == AF_INET ? (sizeof(struct iphdr) +  sizeof(struct icmphdr)) :
> > +		 (sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr));
> > +	skb_reset_network_header(newskb);
> 
> This is not needed there.

fixed.
> 
> > +
> > +	if (!pskb_pull(newskb, hl))
> > +		return NULL;
> 
> This leaks newskb.

fixedd

> 
> > +	skb_reset_network_header(newskb);
> > +
> > +	if (xfrm_decode_session_reverse(net, newskb, fl1, family) < 0) {
> > +		kfree_skb(newskb);
> 
> The newskb is not dropped because of an error, maybe better use
> consume_skb().

good idea. I will change to consume_skb().

> 
> > +		XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
> 
> This might bump a second stat counter for this packet. Also
> this is not really an error, because you just can't parse
> the payload of the icmp packet. 

yes fixed

> 
> > +		return NULL;
> > +	}
> > +
> > +	fl1->flowi_oif = fl->flowi_oif;
> > +	fl1->flowi_mark = fl->flowi_mark;
> > +	fl1->flowi_tos = fl->flowi_tos;
> > +	nf_nat_decode_session(newskb, fl1, family);
> > +
> > +	return newskb;
> 
> Why do you return newskb here? It is not used in all
> of the Acalling functions.

I thought fl1,  decode session, had pointers to skb fl1. That is not the 
case. Now the skb is consumed and not returned.


> The rest looks good, thanks!

thanks for the review. I will send out new version soon.

