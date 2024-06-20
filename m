Return-Path: <netdev+bounces-105251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4927910410
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF11F2111F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BCB1AD401;
	Thu, 20 Jun 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA3vsHWM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E121AD3F6;
	Thu, 20 Jun 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886503; cv=none; b=mxOtytLyNsqWczOH2reO/MB+ISAI4FRnVljksTuGf/GvWZ8HRWfQ93aOLsBtv7OCEGoU404slR6uuWgNZZYaS3IgEnyns8ZvHS7QwXuuEkymQtz9BXsIFKFQHpxmTDMCWuPGmAURQ3AnS+e/a04A3GSmn9mylG4Sd5m47bFhRug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886503; c=relaxed/simple;
	bh=6JVxjcSSQVPV7Gv95eTpy/Ya3pQAu/jeYNvFD4eoLl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/E417FfpLYvI9apicdo4/KYdiS7bvHjfnwKJHxJ/ncl2/wajOG/bEnaMZKkXG4T9tuzFnnW9B4k3FZhEXk9Q70IvSycvWTiXfUPf9rd5ZVO8vUqz0G6g53NECapcpfyBn61eupWsw+O3nsoF97ToRiyyqWLpmSyFOwJ48EGSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA3vsHWM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a63359aaacaso118855966b.1;
        Thu, 20 Jun 2024 05:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718886500; x=1719491300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtInD33nzpSK44s1JnnPRYoHH/jmvVeTud7sO01t4nE=;
        b=hA3vsHWMQJGwuLxtNQhrA5GiYEjqyb50D+1hxyly5qvg7n7toBK09RBiZizN+vZaUu
         n3HT0j44WIaCCj3nquLBkILy0aG7etBNCtv2kjUHUyRKD31RtAwNc/qYD2tuBOmfcU+z
         hg6MPukLdRFsWLUXMbYjLXteA5g2vsgejC2bVBx6qhEBPHwUluriotPxdYm0PXJfWsXT
         t6R6/Vya3x1R6mGDmA7CzGLIyjkbX4mCweJ19JF/eTWf/I9Swuhlf0XTzOI0FfMcR7oh
         3Okpi3s3c4rbwVIkLisL0NjH9Kzl2pU5KIvUzFe0NBdQthV2kYDsr7OAyGBm3Zxg1Fiv
         LMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886500; x=1719491300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtInD33nzpSK44s1JnnPRYoHH/jmvVeTud7sO01t4nE=;
        b=Ttd/Z+7Ck1vgeMmbXOBZS854vxanncWM8IVdDz34+UYZ6pxwgFyz0yf6ItwuPqkIJR
         7ftwBrfCXHn5LLRJNv8Ti/kU4VAc5HvsqXe9O+QnzuEs0LP3q9S7GHSkFbMyow09DfZ8
         PUlGNltHPLYENZdjb13HfEwHi6ewSzEHmpOmZUYs33JPreFT00N5XERavhFtQB0k3yJU
         P+DYS3Uxw/rQKAIXp1LrLYlEIJ/wpKuvcDxAYpjwxoCiyHORzvMZiutWFXjYHY6/pMhs
         ycBFhkDTbCfsUD04o7Wh8I7il7h85r3+vKAL6t7KT8zfrqYBSt379boN5SZ6i4ai92uH
         KYEw==
X-Forwarded-Encrypted: i=1; AJvYcCV927q97AYn9hFDhWzMbN2zxR/XPEqjPwaY5z/T8JilUidAfbPAxcgSGL7fCVPOVFddRsb9kHhj0n6Vlq+RNbjwT7oiFVCQOLLJ1loj
X-Gm-Message-State: AOJu0YyCLMrGgRtwxRV/N4Z5J3Sb2/zjKVvdm+fYsXJ58rB89yxbLRld
	KsxnItaJBpDDhHLUVPGfl12ViLIq3dOYpf4vUpseUJIHLaubHP+O
X-Google-Smtp-Source: AGHT+IF4Qyldbfqw1/idXFcHIfvvHaJ2Zwuw1GprSCSOvGAc+FldFLbpqFOpoKNrZx0X2P2i7E5bGA==
X-Received: by 2002:a17:906:c2cc:b0:a6f:6029:998f with SMTP id a640c23a62f3a-a6fab64510emr297906666b.46.1718886500037;
        Thu, 20 Jun 2024 05:28:20 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f4177csm759386866b.162.2024.06.20.05.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:28:19 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:28:16 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/12] net: dsa: tag_sja1105: absorb entire
 sja1105_vlan_rcv() into dsa_8021q_rcv()
Message-ID: <20240620122816.qho2hq7i4eakpnbc@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-5-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-5-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:10PM +0200, Pawel Dembicki wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> tag_sja1105 has a wrapper over dsa_8021q_rcv(): sja1105_vlan_rcv(),
> which determines whether the packet came from a bridge with
> vlan_filtering=1 (the case resolved via
> dsa_find_designated_bridge_port_by_vid()), or if it contains a tag_8021q
> header.
> 
> Looking at a new tagger implementation for vsc73xx, based also on
> tag_8021q, it is becoming clear that the logic is needed there as well.
> So instead of forcing each tagger to wrap around dsa_8021q_rcv(), let's
> merge the logic into the core.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v2,v1:
>   - resend only
> ---
> Before patch series split:
> https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
> v8, v7, v6:
>   - resend only
> v5:
>   - add missing SoB
> v4:
>   - introduced patch
> ---
>  net/dsa/tag_8021q.c        | 34 ++++++++++++++++++++++++++++------
>  net/dsa/tag_8021q.h        |  2 +-
>  net/dsa/tag_ocelot_8021q.c |  2 +-
>  net/dsa/tag_sja1105.c      | 32 ++++----------------------------
>  4 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
> index 3cb0293793a5..332b0ae02645 100644
> --- a/net/dsa/tag_8021q.c
> +++ b/net/dsa/tag_8021q.c
> @@ -507,27 +507,39 @@ EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_port_by_vbid);
>   * @vbid: pointer to storage for imprecise bridge ID. Must be pre-initialized
>   *	with -1. If a positive value is returned, the source_port and switch_id
>   *	are invalid.
> + * @vid: pointer to storage for original VID, in case tag_8021q decoding failed.
> + *
> + * If the packet has a tag_8021q header, decode it and set @source_port,
> + * @switch_id and @vbid, and strip the header. Otherwise set @vid and keep the
> + * header in the hwaccel area of the packet.
>   */
>  void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
> -		   int *vbid)
> +		   int *vbid, int *vid)
>  {
>  	int tmp_source_port, tmp_switch_id, tmp_vbid;
> -	u16 vid, tci;
> +	__be16 vlan_proto;
> +	u16 tmp_vid, tci;
>  
>  	if (skb_vlan_tag_present(skb)) {
> +		vlan_proto = skb->vlan_proto;
>  		tci = skb_vlan_tag_get(skb);
>  		__vlan_hwaccel_clear_tag(skb);
>  	} else {
> +		struct vlan_ethhdr *hdr = vlan_eth_hdr(skb);
> +
> +		vlan_proto = hdr->h_vlan_proto;
>  		skb_push_rcsum(skb, ETH_HLEN);
>  		__skb_vlan_pop(skb, &tci);
>  		skb_pull_rcsum(skb, ETH_HLEN);
>  	}
>  
> -	vid = tci & VLAN_VID_MASK;
> +	tmp_vid = tci & VLAN_VID_MASK;
> +	if (!vid_is_dsa_8021q(tmp_vid))
> +		goto not_tag_8021q;

I think this may be more clearly expressed linearly, without a goto.

	if (!vid_is_dsa_8021q(tmp_vid)) {
		/* Not a tag_8021q frame, so return the VID to the
		 * caller for further processing, and put the tag back
		 */
		if (vid)
			*vid = tmp_vid;

		__vlan_hwaccel_put_tag(skb, vlan_proto, tci);

		return;
	}

>  
> -	tmp_source_port = dsa_8021q_rx_source_port(vid);
> -	tmp_switch_id = dsa_8021q_rx_switch_id(vid);
> -	tmp_vbid = dsa_tag_8021q_rx_vbid(vid);
> +	tmp_source_port = dsa_8021q_rx_source_port(tmp_vid);
> +	tmp_switch_id = dsa_8021q_rx_switch_id(tmp_vid);
> +	tmp_vbid = dsa_tag_8021q_rx_vbid(tmp_vid);
>  
>  	/* Precise source port information is unknown when receiving from a
>  	 * VLAN-unaware bridging domain, and tmp_source_port and tmp_switch_id
> @@ -546,5 +558,15 @@ void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
>  		*vbid = tmp_vbid;
>  
>  	skb->priority = (tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
> +	return;
> +
> +not_tag_8021q:
> +	if (vid)
> +		*vid = tmp_vid;
> +	if (vbid)
> +		*vbid = -1;

Thinking more about it, I don't think this is needed (hence it is
missing in my rewritten snippet above). I mean, *vbid is already
initialized with -1 (it's a requirement also specified in the
kernel-doc) and we haven't changed it.

> +
> +	/* Put the tag back */
> +	__vlan_hwaccel_put_tag(skb, vlan_proto, tci);
>  }
>  EXPORT_SYMBOL_GPL(dsa_8021q_rcv);
> diff --git a/net/dsa/tag_8021q.h b/net/dsa/tag_8021q.h
> index 41f7167ac520..0c6671d7c1c2 100644
> --- a/net/dsa/tag_8021q.h
> +++ b/net/dsa/tag_8021q.h
> @@ -14,7 +14,7 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
>  			       u16 tpid, u16 tci);
>  
>  void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
> -		   int *vbid);
> +		   int *vbid, int *vid);
>  
>  struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
>  						   int vbid);

