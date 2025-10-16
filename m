Return-Path: <netdev+bounces-229971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B8BE2C45
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68E254E1FDD
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14896111A8;
	Thu, 16 Oct 2025 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LukFeL/f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C032863B
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610452; cv=none; b=PCeqhCH8DlseL2oDi4TVZpwshaics6aBFaBapIB6lGwxAzKUWGrLhw651DVaaLJC5tDCkUHqAQN3Ooijpk/rqncp2EF4gt5WhR5WytMQPSw/pHuzUX85eb5E9lAHql9Jhpcbr2AbYKgKPPD5Qxs5OL9GBy7Xzv6CxtzhZCkScxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610452; c=relaxed/simple;
	bh=FHyxqJ7NpEfoJOizg7du46Bjgb/wMM8LvqFuRAoNySw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1XqgfubVrg2iQNnR9yuf8GYJ7/ZlK951Fv4PoXaTdAAStQNgJcNfRbzt/iFcDhMKXY+vUmkircHy2ueIskZ6j/sxL6oWDuU62A64ymfcNyRYDa95clKyhWVr8NXHgbHsVZOgT2JNkduVrhG21/RvNMOdCDmi+B4PstutVupS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LukFeL/f; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42702037a01so57512f8f.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760610448; x=1761215248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZXW7de0TZtYcWabC5/0MLZ/hIXMHNrJAqTYeL/Yo4c=;
        b=LukFeL/fpr51k24mXCi6H31M14blTQvBCeedZEaEdUJNWz0FKZkJ5cU8k+Ys62ScTK
         DcakdOScyjSVkjcWdRge8EP9Yql0i2fEUNutWZSjhIxO9hWtOPBvpwntDVYXuemAxdyr
         FlX7Dg7NzvaBOVF6hU+c3yLpAdfsfvWFgff6oEU47/EdmLgEJA9KIakk8cWqSFNMhPMi
         mjoHltbuTTLbtWYC+uKn3YVehnEp0GKL/zi+Are8/SIPEgcV7F5iiDuklX3ajX+eu1z9
         owxCgn6gtdRVIhfrMdbv+2nqapiZY6pRvN3gb9Zdpvp/c5NmHndkw804zKAkEKUz+KRC
         2N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760610448; x=1761215248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZXW7de0TZtYcWabC5/0MLZ/hIXMHNrJAqTYeL/Yo4c=;
        b=jU+ELtpW4siBBggKSVhCi5soaxCpl3My+7mLYy5jEep1fTvgamePWRDbb18aaSZFRG
         nNGLVwQ5XRMSDYSRR6eTMVfQzyRFkTZXpsqnMkkA1A2zCfzr+QchH55FgyU/KlUZ+N60
         4Qd7gYbu4rBiWiMVopF964atBS7pko1MpRygYdFZboxWJ42jbzxfbcSZ2dcMA4rgdS/V
         tlBS7qnqJdJSafWkCGp9WG68l1uxuVzNYMOFn2vVZ/VVDBcowlXGNWGEs7P/gOUCjjiD
         WcduR7zmnChfQBso2LKMyXdV6CMcABmS/6+EShicMm4izOgqJtOlebUiEBCHLQLzdioP
         IXIw==
X-Forwarded-Encrypted: i=1; AJvYcCX9KIU2IA6WtX7KrWYzv1qpWQXZhPbUH7fQFZwtbtAgtC9fl6nY4ZLxGcIJi00ksFigUunl350=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70uiqHV6dpnCr0y32LAehiEAurMhfLcietXODLMECx3b4E+Th
	NjtzG1qqiq3/8WFOxi+3u0o3A5t+sP5/3vFlqgebgciw4x8Gp2v5I3LB
X-Gm-Gg: ASbGncsAuSYhLMo1jyUb3zGdehkY/XQCD0qBBkJU2p90/ntQB+inUjx1YJxSRXwsQxv
	hCzXCvM7kTLkd2cDvaSZqFOH6EcfiKlDbo0Az7F1aa6Pwe64lSppIUglw4rg/m9j5VIAgy39n1w
	uZFQrddiLRUa/3Nlx1z4HwFXwPx/0uI1TmpkSJAArK1I+iCw9kKHdl2Y6KBp4vLJkITnlGJqQDm
	BFkkiULOzrxid0iUsRVuXaHpdlBeB/AMvFToMJ8AX1KJERwRFVxSM/qEiy5CUEtDV5wA41G5ZvK
	NJ2rOfaeUc5g18coq762mE0ibzeSlCLqWiIGbuWgo448lXqAyMRvY9dFRiRTv3d5eWxEQpeU6iW
	zAh8tXs2q0uOBWVTNjstgN7iaOmK8skNzcV4xqJOoTNGZJDOR+8ZK/uQZsOAp/mavI8JF2/kvUl
	14F4Q=
X-Google-Smtp-Source: AGHT+IFtEqUBgwh+h7B+3dcQcPYsLZFeKKvADxfTTEFh/RmlxebHKOcnab7PWnwPUD5hyxzzlcAXXQ==
X-Received: by 2002:adf:ec44:0:b0:426:c349:eb1d with SMTP id ffacd0b85a97d-426c349eb51mr8546913f8f.0.1760610448136;
        Thu, 16 Oct 2025 03:27:28 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:eb00:874d:45ad:1884:652d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8207sm33080528f8f.47.2025.10.16.03.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:27:27 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:27:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
Message-ID: <20251016102725.x5gqyehuyu44ejj3@skbuf>
References: <20251015070854.36281-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015070854.36281-1-jonas.gorski@gmail.com>

Hi Jonas,

On Wed, Oct 15, 2025 at 09:08:54AM +0200, Jonas Gorski wrote:
> The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLAN
> tags on egress to CPU when 802.1Q mode is enabled. We do this
> unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
> VLANs while not filtering").
> 
> This is fine for VLAN aware bridges, but for standalone ports and vlan
> unaware bridges this means all packets are tagged with the default VID,
> which is 0.
> 
> While the kernel will treat that like untagged, this can break userspace
> applications processing raw packets, expecting untagged traffic, like
> STP daemons.
> 
> This also breaks several bridge tests, where the tcpdump output then
> does not match the expected output anymore.
> 
> Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
> it, unless the priority field is set, since that would be a valid tag
> again.
> 
> Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  net/dsa/tag_brcm.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
> index 26bb657ceac3..32879d1b908b 100644
> --- a/net/dsa/tag_brcm.c
> +++ b/net/dsa/tag_brcm.c
> @@ -224,12 +224,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
>  {
>  	int len = BRCM_LEG_TAG_LEN;
>  	int source_port;
> +	__be16 *proto;
>  	u8 *brcm_tag;
>  
>  	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
>  		return NULL;
>  
>  	brcm_tag = dsa_etype_header_pos_rx(skb);
> +	proto = (__be16 *)(brcm_tag + BRCM_LEG_TAG_LEN);
>  
>  	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
>  
> @@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
>  	if (!skb->dev)
>  		return NULL;
>  
> -	/* VLAN tag is added by BCM63xx internal switch */
> -	if (netdev_uses_dsa(skb->dev))
> +	/* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN tag on
> +	 * egress to the CPU port for all packets, regardless of the untag bit
> +	 * in the VLAN table.  VID 0 is used for untagged traffic on unbridged
> +	 * ports and vlan unaware bridges. If we encounter a VID 0 tagged
> +	 * packet, we know it is supposed to be untagged, so strip the VLAN
> +	 * tag as well in that case.
> +	 */
> +	if (proto[0] == htons(ETH_P_8021Q) && proto[1] == 0)
>  		len += VLAN_HLEN;
>  
>  	/* Remove Broadcom tag and update checksum */
> 
> base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
> -- 
> 2.43.0
> 

Do I understand correctly the following:

- b53_default_pvid() returns 0 for this switch
- dsa_software_untag_vlan_unaware_bridge() does not remove it, because,
  as the FIXME says, 0 is not the PVID of the VLAN-unaware bridge (and
  even if it were, the same problem exists for standalone ports and is
  not tackled by that logic)?

I'm trying to gauge the responsibility split between taggers and
dsa_software_vlan_untag(). We could consider implementing the missing
bits in that function and letting the generic untagging logic do it.

