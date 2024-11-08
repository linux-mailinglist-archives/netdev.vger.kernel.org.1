Return-Path: <netdev+bounces-143282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B69799C1CAA
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FECA1F21DFF
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B91E570E;
	Fri,  8 Nov 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Htx8yJWU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC91946CD
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067735; cv=none; b=FIV4VkQzBwUSLXpGx1SrBDiFv+5W73HrE/YPCrFTr7T/LOCkiQkPNy3uaMyiOwEmFDFkoAhv+3+mp5Lrx1Z88fEESSySdpDnb4JaCOXaNbzLljPxjxWRBZJcOQTGC4jjSbo5LRMK9yh5zMSPaiLDmbqcDw8PKwDTt7sJ9OLaWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067735; c=relaxed/simple;
	bh=BBtJUrEaso8H3SdEq7rhKtyo0xY4Ni3ESO7270cX9F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXQhQ6dc3NGG6XuJBev+yiI+A4IfoGUSnCYWkgYhLmTkxElpdUsqMqGWxAV3DKzEr4zspUxU/xuLpRyv7Ll8sj3EIM6P8o0QHWyvb6G/5alOcCcdOVTx/kpaAXpjWBlHfKeR9lJrmOBXZh4ogMoOaaOFhqGWOATfecuPc0gFoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Htx8yJWU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731067732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6abcWn8+lo10PkwRar0tkRivYprJehhWWB8R18O/pU=;
	b=Htx8yJWU2SoE3bdynMUcVKv4qi1qfmcFR9RpMWxATQF2zIx5CUhLUjI25OsdvuQoaO8PY/
	l+yqBMXYxC5OnXlJGof6e0whMrC2JrSFwDj9cbkhqupQUfqQdSYvLErKlrjBdgDneokXfh
	RdVeQEJa3Tf+kJHV+dW4jfj70tgJC0w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-E4U_WgnvOfaF7yz4MtInWw-1; Fri, 08 Nov 2024 07:08:51 -0500
X-MC-Unique: E4U_WgnvOfaF7yz4MtInWw-1
X-Mimecast-MFC-AGG-ID: E4U_WgnvOfaF7yz4MtInWw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-381e8cf69a6so1119298f8f.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 04:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731067730; x=1731672530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6abcWn8+lo10PkwRar0tkRivYprJehhWWB8R18O/pU=;
        b=J8Me+ziDWm3GTsA3VttW5/ecDiyCaEdsWHloygA7O9Y2PB7R3MNIWKuu8env3JkHVs
         sPxSUU/y95r70Tz+P/kDmN7IDSPMlfx1laCRCbFcfkt1Lcaq3z+1Vkv+hUlLpMDjwaXF
         nN74berUtXNRxlBKVVCiUZDOugSORZ/1wkYlmcaSLXUbtmPT0x5G3ntCeIIKRc2cMc7n
         ZVoatXbWYl0QbN5zARLNY4C4vWxDpfcaGPYr/WFF1h9LXXBIVbWKnhouB78dU4k71Uz2
         Bk1EiB+OGsXFu03PSCBUQrxs8EjFC/yw1LZDJPbB5qqXZsIgpumcyDl/DWjTBmO8J5ic
         yaVA==
X-Gm-Message-State: AOJu0Yyp1pZfr5UoezkeJ/CDp+SJBnjDQ5Y8pGWaMYOuLu8Pet1opXah
	7HwuJ2g0CY9FRPd+r8JUTASyoe5eJP1NC9uKIgO6KMZ6rJrYEFQpK2ay7qCkfdaPudEDbR5P0x3
	IODNgewiliDXVZ7CfhFfnmRZydNnKcKGdwFDsvvansLs97bMnizukKg==
X-Received: by 2002:a05:6000:184b:b0:37c:fdc9:fc17 with SMTP id ffacd0b85a97d-381f1867342mr2241364f8f.23.1731067729684;
        Fri, 08 Nov 2024 04:08:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqJxGlEuvxdy552FkCe7vNdlUqrpnEt/f0qeVra3UUqVkXbybUChYCJdoefNYu9Lm5D1IdRA==
X-Received: by 2002:a05:6000:184b:b0:37c:fdc9:fc17 with SMTP id ffacd0b85a97d-381f1867342mr2241338f8f.23.1731067729240;
        Fri, 08 Nov 2024 04:08:49 -0800 (PST)
Received: from debian (2a01cb058d23d60039a5c1e29a817dbe.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:39a5:c1e2:9a81:7dbe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed998e6esm4489137f8f.55.2024.11.08.04.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 04:08:48 -0800 (PST)
Date: Fri, 8 Nov 2024 13:08:46 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Emanuele Santini <emanuele.santini.88@gmail.com>
Cc: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org, friedrich@oslage.de,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	dsahern@kernel.org
Subject: Re: [PATCH] net: ipv6: fix the address length for net_device on a
 GRE tunnel
Message-ID: <Zy3/TmyK7imjT348@debian>
References: <20241108092555.5714-1-emanuele.santini.88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108092555.5714-1-emanuele.santini.88@gmail.com>

On Fri, Nov 08, 2024 at 10:25:55AM +0100, Emanuele Santini wrote:
> While GRE tunneling does not require
> a hardware address, a random Ethernet address is still assigned to
> the 'net_device'.

That's really surprising and not what I can see on my system. Are you
really talking about ip6gre (and not ip6gretap)?

> Therefore, the correct 'addr_len' value should be
> the size of an Ethernet address (6 bytes), not the size of an IPv6
> address.

Ethernet address length only makes sense for ip6gretap. This doesn't
seem like a valid justification for ip6gre.

> This fix sets 'addr_len' to the appropriate value, ensuring
> consistency in the net_device setup for IPv6 GRE tunnels.
> 
> Bug: Setting addr_len to the size of an IPv6 network address (16 bytes)
> can cause a packet socket with SOCK_DGRAM to fail on 'sendto' calls.
> This happens due to a check in 'packet_snd' for SOCK_DGRAM types,
> which validates the address length.
> 
> This bug was introduced in kernel version 4.20.0 and is still present in the current version.
> 
> Steps to reproduce:
> 
>   ip -6 tunnel add <dev_name> mode ip6gre remote <remote_addr> local <local_addr> ttl 255
>   ip link set dev <dev_name> up
>   busybox udhcpc -i <dev_name> -n -f
>   -> It returns Invalid Argument.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202147
> Reported-by: Friedrich Oslage <friedrich@oslage.de>
> Signed-off-by: Emanuele Santini <emanuele.santini.88@gmail.com>
> ---
>  net/ipv6/ip6_gre.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 235808cfec70..db7679b04a02 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1455,7 +1455,7 @@ static void ip6gre_tunnel_setup(struct net_device *dev)
>  	dev->type = ARPHRD_IP6GRE;
>  
>  	dev->flags |= IFF_NOARP;
> -	dev->addr_len = sizeof(struct in6_addr);
> +	dev->addr_len = ETH_ALEN;

I guess it should be "dev->addr_len = 0" instead. We have no "hardware"
address.

>  	netif_keep_dst(dev);
>  	/* This perm addr will be used as interface identifier by IPv6 */
>  	dev->addr_assign_type = NET_ADDR_RANDOM;
> -- 
> 2.46.0
> 
> 


