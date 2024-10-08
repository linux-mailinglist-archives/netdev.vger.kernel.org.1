Return-Path: <netdev+bounces-133241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B3B995628
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B401C2513A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03965212648;
	Tue,  8 Oct 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk/UkpkR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4F113CA93
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410747; cv=none; b=pn2Y/GXzrPVJ1PgkyPd6dQWH4ccZiYQSRDn4TKmyw+VY+o/pBWqUCHldUn0ayKvaqLH+Ch4MHlykEw4Wvb7VUEg2/fV3t9DBnZriYz8zlFtKKzF2lMzMPNvgzYLA1TFtYoKSL7VvxjxwPR0CVcgh/4DhBsG5Pg+fR0qopZJHVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410747; c=relaxed/simple;
	bh=0ZJ9Kfi2/3ZVmnGg5XdNIcP4NBU6ZMHiswIrHiHb2f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCFRPAM93dAywglKh/X93rRhDmUbHHQpLDmAGBBp0V60Rys7G1qXMto/wvfZiu9j8lFflSnft29blseEW4niyrpsF/l0UGN9O//VhBxI1vUzxJ8YKB1D1FycohaFn0sq6/zo1mKcoefLkGImSn5QvZ2F5uj2H3zC1sUnm/7Sg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uk/UkpkR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728410745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cf/DHV7oLxh4iefN5n7XoZ0U+zeNpvhDR5hTkGJTKcg=;
	b=Uk/UkpkR4aDz9NYufe8XGHC2stvB+DLD2jYu0R2IVQJr0zO/nyF473r2EKp365AJaFSDJd
	RhofmdmdTW04ElnYMyUnn42FG0B6ObvBExok+j0AK1LxyiQTByziEtN0yoOztxup8YGlZ5
	yDba0vXoVFPafwchR2Y4U5R2BblO+1w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-2FF5jUO4N7-xUbDzLcu7zg-1; Tue, 08 Oct 2024 14:05:43 -0400
X-MC-Unique: 2FF5jUO4N7-xUbDzLcu7zg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so302935e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 11:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410742; x=1729015542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf/DHV7oLxh4iefN5n7XoZ0U+zeNpvhDR5hTkGJTKcg=;
        b=BnzProkJhhlLjORYSuPsyKwscEk516j7RAqSkBbPlmV0tLb8mA2E3EJKJ3xbPaXmpU
         F5VmrXdd545yKdDNW3D8+pA3owrYi6PYT+OQqiRl2Nj1f7qfWG92xZ9LglB4rAqDzmGe
         KzoiJIWrzq8kU2HYASmkoaa/soINzJ0GO8G5Zj8H9Ziee2z/RuiZsGVTzazTUBcud5Jb
         Zm/gBsFJwxVamQGJ52QZ1dWkNP1rmpnCzZtLN57jLoSkRxtzztviJrnOFRap2M4hGPbt
         ce6yNS24AYU2DLh7G5NU8vcjGe6j8pUWtW91sGuAMhEJ7GJWUeijHEmfTDJnv+PDI4AQ
         QSmA==
X-Forwarded-Encrypted: i=1; AJvYcCVdWpW34I5jVI+vYvG2pf6yeKc17P+pLNRTmKK1bw5tUTN3EGCMoM0zm9UnVOrPwqq8S2Tcfgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIMv5MKhMPG2cuIPV6yqLDTxWs5J9DpvzSYh/96emDetSZAYu7
	C6uiXbbM9wa9K8wVrIChORLojxMDFPqmxCVUR4Jk4J343C+Kzc2BcrWAz+hTC1LgXZFpEBgPGID
	LdD+vFmp/Hv2Cm4jNe5jmEGgBoZuKnpQiMIwe6AYDnW1avk/fnWYZCg==
X-Received: by 2002:a05:600c:19cf:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-42f94bbbc66mr26152095e9.4.1728410741686;
        Tue, 08 Oct 2024 11:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn/zGotqhdU0OvWYc4zxxmP0jbahwuVnwxX51uqAoJ+7xbY5+5crrA52HpfOrOXdsZrcx9jw==
X-Received: by 2002:a05:600c:19cf:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-42f94bbbc66mr26151925e9.4.1728410741344;
        Tue, 08 Oct 2024 11:05:41 -0700 (PDT)
Received: from debian (2a01cb058d23d6009ada0857e99733e4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9ada:857:e997:33e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43056f0ed3csm15275165e9.2.2024.10.08.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:05:40 -0700 (PDT)
Date: Tue, 8 Oct 2024 20:05:38 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
	amcohen@nvidia.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/12] net: vxlan: use kfree_skb_reason() in
 vxlan_xmit()
Message-ID: <ZwV0cjdg2x67URMx@debian>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
 <20241008142300.236781-9-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008142300.236781-9-dongml2@chinatelecom.cn>

On Tue, Oct 08, 2024 at 10:22:56PM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
> new skb drop reasons are introduced for vxlan:
> 
> /* no remote found for xmit */
> SKB_DROP_REASON_VXLAN_NO_REMOTE
> /* packet without necessary metadata reached a device which is in
>  * "eternal" mode

That should be "external" mode (with an "x").

> +	/**
> +	 * @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metadata
> +	 * reached a device which is in "eternal" mode.

Here too.

> +	 */
> +	SKB_DROP_REASON_TUNNEL_TXINFO,
>  	/**
>  	 * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
>  	 * the MAC address of the local netdev.
> -- 
> 2.39.5
> 


