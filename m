Return-Path: <netdev+bounces-155775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083EA03B3E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A971F3A4495
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6331E0091;
	Tue,  7 Jan 2025 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="WhwptH6P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85146434
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242418; cv=none; b=fmI/VR5log2o4BQmNHESa7PnV5JdgGOoRifvbaXQqieCRtNWLJmmIKsHpWCQtsv6377+vJ3faGdN5vBCNbZ1PqTpTkYPPtSML9nLJygMT0Fy1Gw3mbtK+MTaHVP365GDHm6RgzK4O0apO8B7ZFbxrf/nWRad21E/+iDBw0ISwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242418; c=relaxed/simple;
	bh=7ODgJWlOJO4/lGktleAYBsYNtDWOE8VlHBQim6ufeH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opR3RRPW2zSVP/3sKV1lsaZ8NR6Pi6fk5Af0q+qei/2jqVAKL9TUZpVDpiKRwieMpTT+/BNlozHdOLYRugVu5ZqEeKGwqX0FQTiqYnMTYrukcW0mwmIKBSTTNQoSvC6NgHhof2Jcft4Pm3iO/HpBM30wQiKG/z+j9SXQINYPfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=WhwptH6P; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e44654ae3so2554403266b.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 01:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1736242412; x=1736847212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHxjC6h0Kfucr4tH2PqzFsx9yRATfufXfuxgz/uTgy0=;
        b=WhwptH6P40jf+ixkyZEmYyY+pmGKqE2SunRGQun2PJv9BQHI4b621042nRZKC33Mhn
         G1tpDtlWBXapFGHyhMIPonM3I7LKf0qQDymnn8+nAuPaKlNFLibNh2SKxoBkHdpqBsRn
         e16yInB//2yrQld8Cr+4PG66wkxFTFah949EtaFSm1GzXcOXaTe5ahORApG4GSQPe9Zy
         Nbyq6LMA4k3cWAa0+BcBKO/ZTsvdoZyFHtLILFuYfxm2fSqisVNz8sOOsh09fkI20vM/
         g+MljQeNfZuHiBUV4A7dt3S2Nu4D0KtuNR6jtbs2wOoXtu7uCr0AVXcoKcgCw9jXBmk9
         2Qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736242412; x=1736847212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHxjC6h0Kfucr4tH2PqzFsx9yRATfufXfuxgz/uTgy0=;
        b=odC2t/Ya8mVFDXODeXi/xYiuYPmgmSQm5/O4b+HoaG3h1Z5J62KWs4Z4dL7OM+QiHl
         YGJQEXFc4s1Zpc6CaTRt2+95qmwA4/kiWqkmonp6x0Ts1ULezjINf487HYCNvBveWEFh
         TqgDu9CMlFaaRZCG7qEoA7gZ3PUA/Tq4Jh/8ltcv43IPiYiC6+ZDx5JtmoVr41e1MlLt
         e7mUBLiy1Dg+MHgTYSchsKlLX2BznO0R1T2X/SIaxfdTAW6ivRi+x/L4JNscwXM3rcY5
         5AJQbPUR63HA7G733GpEd5txnHXyJL7CHNI66LV8ti49yv6CqwtXW/nBhJbAfCjBN9t0
         +sBg==
X-Gm-Message-State: AOJu0Ywbq3fd4HBJ87iqEBTQGY2YvYJZB2hoyRI0y8d05QYUYjeuN0hP
	sw0Vfj39jX7tf9jYU2ITYsE42X/mp2kU+C58/dvTIpx2hDn3UbC4vcO7CzCaHFc=
X-Gm-Gg: ASbGncvgBbrLAAxrYU4v6v8lSU6ay2A5png0OQ1reqFeQq5tAtsx4MGJ71HnpnUki8i
	JcwmRW7gddyWwkqrb147ljR6x/toTGckl2Egn/nAirbA4Br5CKToryqYy8ZKvyPq1irRSVLI6xp
	QrLfQ2xmLATv0CY9CGcokn93P7eZpPsiZME2zIFTyZuXiyBJF4dC9I5jvvYUOjGXHk0ytpNw0MY
	E9euhYLnF23yLARzOrpyEU1x1rsKv+x/QiaxnWltYPz68lbjnJvKLY1eLw9vbG3OxOb/EeBxasr
	mXrdhTGm0Gc6
X-Google-Smtp-Source: AGHT+IGa/DGsAatcdI0vhBgT7pEyChI9fpmymNYGz7BLnI1zVom6ss0TkBiupaXLIbc8eDhgvofItg==
X-Received: by 2002:a17:907:724f:b0:aae:ebfe:cedb with SMTP id a640c23a62f3a-aaeebfecfc4mr3325114266b.51.1736242412236;
        Tue, 07 Jan 2025 01:33:32 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895080sm2354283266b.47.2025.01.07.01.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 01:33:31 -0800 (PST)
Message-ID: <2b2488d5-8e34-429b-98f2-0ddb0cce87eb@blackwall.org>
Date: Tue, 7 Jan 2025 11:33:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 02/13] netfilter: bridge: Add conntrack double
 vlan and pppoe
To: Eric Woudstra <ericwouds@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Ahern <dsahern@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250107090530.5035-1-ericwouds@gmail.com>
 <20250107090530.5035-3-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250107090530.5035-3-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 11:05, Eric Woudstra wrote:
> This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets that are passing a bridge.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/netfilter/nf_conntrack_bridge.c | 88 ++++++++++++++++++----
>  1 file changed, 75 insertions(+), 13 deletions(-)
> 
> diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
> index 816bb0fde718..31e2bcd71735 100644
> --- a/net/bridge/netfilter/nf_conntrack_bridge.c
> +++ b/net/bridge/netfilter/nf_conntrack_bridge.c
> @@ -241,56 +241,118 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
>  				     const struct nf_hook_state *state)
>  {
>  	struct nf_hook_state bridge_state = *state;
> +	__be16 outer_proto, inner_proto;
>  	enum ip_conntrack_info ctinfo;
> +	int ret, offset = 0;
>  	struct nf_conn *ct;
> -	u32 len;
> -	int ret;
> +	u32 len, data_len;
>  
>  	ct = nf_ct_get(skb, &ctinfo);
>  	if ((ct && !nf_ct_is_template(ct)) ||
>  	    ctinfo == IP_CT_UNTRACKED)
>  		return NF_ACCEPT;
>  

In all cases below I think you should make sure the headers are present
in the linear part of the skb, either do pskb_may_pull() or use
skb_header_pointer(). This is executed in the PRE bridge hook, so nothing
has been pulled yet by it.

> +	switch (skb->protocol) {
> +	case htons(ETH_P_PPP_SES): {
> +		struct ppp_hdr {
> +			struct pppoe_hdr hdr;
> +			__be16 proto;
> +		} *ph = (struct ppp_hdr *)(skb->data);
> +
> +		data_len = ntohs(ph->hdr.length) - 2;
> +		offset = PPPOE_SES_HLEN;
> +		outer_proto = skb->protocol;
> +		switch (ph->proto) {
> +		case htons(PPP_IP):
> +			inner_proto = htons(ETH_P_IP);
> +			break;
> +		case htons(PPP_IPV6):
> +			inner_proto = htons(ETH_P_IPV6);
> +			break;
> +		default:
> +			return NF_ACCEPT;
> +		}
> +		break;
> +	}
> +	case htons(ETH_P_8021Q): {
> +		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data);
> +
> +		data_len = 0xffffffff;
> +		offset = VLAN_HLEN;
> +		outer_proto = skb->protocol;
> +		inner_proto = vhdr->h_vlan_encapsulated_proto;
> +		break;
> +	}
> +	default:
> +		data_len = 0xffffffff;
> +		break;
> +	}
> +
> +	if (offset) {
> +		switch (inner_proto) {
> +		case htons(ETH_P_IP):
> +		case htons(ETH_P_IPV6):
> +			if (!pskb_may_pull(skb, offset))
> +				return NF_ACCEPT;
> +			skb_pull_rcsum(skb, offset);> +			skb_reset_network_header(skb);
> +			skb->protocol = inner_proto;
> +			break;
> +		default:
> +			return NF_ACCEPT;
> +		}
> +	}
> +
> +	ret = NF_ACCEPT;
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IP):
>  		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		len = skb_ip_totlen(skb);
> +		if (data_len < len)
> +			len = data_len;
>  		if (pskb_trim_rcsum(skb, len))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		if (nf_ct_br_ip_check(skb))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		bridge_state.pf = NFPROTO_IPV4;
>  		ret = nf_ct_br_defrag4(skb, &bridge_state);
>  		break;
>  	case htons(ETH_P_IPV6):
>  		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
> +		if (data_len < len)
> +			len = data_len;
>  		if (pskb_trim_rcsum(skb, len))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		if (nf_ct_br_ipv6_check(skb))
> -			return NF_ACCEPT;
> +			goto do_not_track;
>  
>  		bridge_state.pf = NFPROTO_IPV6;
>  		ret = nf_ct_br_defrag6(skb, &bridge_state);
>  		break;
>  	default:
>  		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
> -		return NF_ACCEPT;
> +		goto do_not_track;
>  	}
>  
> -	if (ret != NF_ACCEPT)
> -		return ret;
> +	if (ret == NF_ACCEPT)
> +		ret = nf_conntrack_in(skb, &bridge_state);
>  
> -	return nf_conntrack_in(skb, &bridge_state);
> +do_not_track:
> +	if (offset) {
> +		skb_push_rcsum(skb, offset);
> +		skb_reset_network_header(skb);
> +		skb->protocol = outer_proto;
> +	}
> +	return ret;
>  }
> -
>  static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
>  				    const struct nf_hook_state *state)
>  {


