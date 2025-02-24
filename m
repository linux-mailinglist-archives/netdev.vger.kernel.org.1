Return-Path: <netdev+bounces-169118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6A6A429C3
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4E2188E98F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701726560F;
	Mon, 24 Feb 2025 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWlJOvps"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE1264613
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418085; cv=none; b=cTA89looRL1GcZC//eyOc3G4ln1RkfOhYjPCRZ0cbzZmuw7A68UG/raatHlYY3vgxOw9jVcoKCFXqUOAxdvxmlSWOhmCfbu0w2LUVXHvWr2Nw/F2mvTXlLhmKkoWvuyDqdbKAs6lHvtvO+dL7J2OY985NdPNi5J7H7e5x0Mbc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418085; c=relaxed/simple;
	bh=RCQ9NA0K8F4QBrplAQzVHFLsVqL7FvrrFe0zodxcmns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhDP6zUogkdS/pP7mhjAiaQJ6sIFfz8p2QjhK7UzIZQrsC346PgMW3Meg6kNXeO3pAZRRVb3HzPaS8wW3//w+u3invF/wYGjItonDSH++kFb+3DdUAUv+47jes6o1rsafcYMRY3hOrBZT7I5KGYqYtQEDpmvWle8BNm77N1M85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWlJOvps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740418082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HxVWH4sT/O5UUwrwlG8z94/6x2ivxPf/BjQ/uICxxM=;
	b=GWlJOvps+o8T03xgFDf6Y1mWhk6Sc9T0E0coOsYjd2nuHykpt1nc6y48ASfAzTEU1jRKdT
	/PKlcgHuxkHMcE5MHPJcVg+5fHGoddIvZSxbrOzmbGD7np42JC8vLBHYov5otOC/+bGP9A
	kKHdNIkKbR7XFnImxnZ9rmqergWyIUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-cUKKvoQQNSesIOaQytEqVQ-1; Mon, 24 Feb 2025 12:28:01 -0500
X-MC-Unique: cUKKvoQQNSesIOaQytEqVQ-1
X-Mimecast-MFC-AGG-ID: cUKKvoQQNSesIOaQytEqVQ_1740418080
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394c489babso25830535e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418080; x=1741022880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HxVWH4sT/O5UUwrwlG8z94/6x2ivxPf/BjQ/uICxxM=;
        b=U3gNDQT6oECBfqsr7BCxsGFHlnvY9AOfi+MxzfnBOJVC3KxMMX7o11F2HXJe/A4U/G
         UfTSQNlCwoc6PkQoteemcM39riioYILeyNUAEMnDoqRC2q/mugXQ+hM8LCnDQ5ATgPaL
         O/xKlSm6rlwceUnOBqR5xKTqu9XBy3hB/98ax0Mp7ARTlgdVvN49PJFRuR4yvc5Zqadl
         BhBooE7e0S7HNOEogmJKCjoJCXqxEmkZIcgc8y7/IMKWVbz0QEyQzlmKsSCIzntFG6Is
         hP4vl62Uq3Ksxz08T9Tw2TG7kUh06UscoPvx4myUSNYXQUY+33IUqTF1Jinx5YfD0RMc
         Oelg==
X-Forwarded-Encrypted: i=1; AJvYcCUvBAfQjoNpVup0+fJbxdPXIlsVFTuUU1fvOcl74IFuAmVtgw/nAFKk0ZTk7XHccZaeUXZTI2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9LapEbPpENa1ldcdMROKRK2L2hnv6h7hDH/Znxl461anZFox
	rV8snS9vXG62BYYlo99yH6cug2OaR5R713B/GxijeSH+dUbbfOHOZpVnM71BiyTJUBT/XygoRGG
	Qb++1NpW6tHG+3GFBVlzWYkCmNKiwI3rAre4H459Zgdf4IEnpkhlyTA==
X-Gm-Gg: ASbGncv8C8HPv8ihub/9UKn631TOFuZgte6aFQKo9ymvAYMb8EWLtRVTLHPcVy5gnmJ
	4B84MEZX9tojyJm8cCKtUOonv2TFdaBjXFbIGY/DlVvn4pVtkLs/H5pUTtr45YkYxIfieaRd1xP
	IdH/6uz/AUm+Lf2L/li0gAwhyBR/IWI9fHt80WEXsyGXsMMzMhJEnmoFEl697nbha84DqWkGfbM
	nI2r8XxwiuTOn6tJ4pkIQ83LiX442qn+EUxVhhZmWZLL/2uDKRzOLtJUvuvhec6qewLiO5xD1g7
	ZBs=
X-Received: by 2002:a05:600c:468e:b0:439:9828:c44b with SMTP id 5b1f17b1804b1-43ab0f3ccddmr1505725e9.14.1740418080061;
        Mon, 24 Feb 2025 09:28:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRmQ8RM+y+/J+KDbrVfaH0j+iu/NZY1piRY61UaE4/1JgE02nhnCocoZohhxlX6dSptlrHEw==
X-Received: by 2002:a05:600c:468e:b0:439:9828:c44b with SMTP id 5b1f17b1804b1-43ab0f3ccddmr1505485e9.14.1740418079714;
        Mon, 24 Feb 2025 09:27:59 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce65dsm112835695e9.1.2025.02.24.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:27:59 -0800 (PST)
Date: Mon, 24 Feb 2025 18:27:56 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: Re: [PATCH net v2 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z7ysHMi4NociwDgR@debian>
References: <cover.1740129498.git.gnault@redhat.com>
 <942aa62423e0d7721abd99a5ca1069f4e4901a6d.1740129498.git.gnault@redhat.com>
 <Z7sfmLG4V_kHKRfy@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7sfmLG4V_kHKRfy@shredder>

On Sun, Feb 23, 2025 at 03:16:08PM +0200, Ido Schimmel wrote:
> On Fri, Feb 21, 2025 at 10:24:04AM +0100, Guillaume Nault wrote:
> > Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> > devices in most cases and fall back to using add_v4_addrs() only in
> > case the GRE configuration is incompatible with addrconf_addr_gen().
> > 
> > GRE used to use addrconf_addr_gen() until commit e5dd729460ca
> > ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
> > address") restricted this use to gretap devices and created
> 
> It's not always clear throughout the commit message to which devices you
> are referring to.

Yes, that's a problem I had when writing the commit message: I couldn't
find a proper way to name the different GRE device types unambiguously.

By reusing the device types of "ip link" we don't know if "gre" refers
to all GRE types or if it's only for IPv4 encapsulation. But using the
ARPHRD_* types wouldn't help, as that wouldn't allow to distinguish
between gretap and ip6gretap.

Maybe the following terms would be clearer:
'ip4gre', 'ip4gretap', 'ip6gre', 'ip6gretap' (and potentially 'ipXgre'
and 'ipXgretap' when considering both the IPv4 and IPv6 tunnel
versions). Would you find these terms clearer?

> For example, here, by "gretap" you mean both "gretap"
> and "ip6gretap", no?

Yes.

> BTW, I believe the check against 'ARPHRD_ETHER' in addrconf_gre_config()
> is dead code. addrconf_gre_config() is only called for ARPHRD_IP{,6}GRE
> devices.

Yes, that was dead code. But I'm reusing that condition to minimise
code changes so to make the fix simpler. Do you mean I should write
explicitely, somewhere, that it was dead code but isn't anymore?

> > add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.
> > 
> > The original problem came when commit 9af28511be10 ("addrconf: refuse
> > isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
> > addr parameter was 0. The commit says that this would create an invalid
> > address, however, I couldn't find any RFC saying that the generated
> > interface identifier would be wrong. Anyway, since plain gre devices
> > pass their local tunnel address to __ipv6_isatap_ifid(), that commit
> > broke their IPv6 link-local address generation when the local address
> > was unspecified.
> 
> By "plain gre devices" you mean "ipgre"? Because addrconf_ifid_ip6tnl()
> is called for "ip6gre" and it doesn't fail, unlike __ipv6_isatap_ifid().

Exactly. I tried to use the "plain" adjective to say that's the kind of
device you get with the "gre" keyword in "ip link".

> > Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
> > interfaces when computing v6LL address") tried to fix that case by
> > defining add_v4_addrs() and calling it to generated the IPv6 link-local
> 
> s/generated/generate/
> 
> > address instead of using addrconf_addr_gen() (appart for gretap devices
> 
> s/appart/apart/

Will fix both.

> > which would still use the regular addrconf_addr_gen(), since they have
> > a MAC address).
> 
> Assuming what I wrote is correct, I'm not sure why e5dd729460ca didn't
> restrict the fix to "ipgre" and applied it to "ip6gre" as well.

I asked myself the same question. Antonio might have an answer to this.
But in my understanding the changes brought by e5dd729460ca were much too
broad.

> > -	if (dev->type == ARPHRD_ETHER) {
> > +	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
> > +	 * unless we have an IPv4 GRE device not bound to an IP address and
> > +	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
> > +	 * case). Such devices fall back to add_v4_addrs() instead.
> > +	 */
> > +	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
> 
> Doesn't this mean that the 'ARPHRD_IP6GRE' case (and the
> 'CONFIG_IPV6_GRE' checks) can be removed from
> addrconf_init_auto_addrs()? That is, only call addrconf_gre_config() for
> "ipgre", but not for "ip6gre".

Yes. But I didn't want to do that here, to keep the fix as simple as
possible. Because that'd mean we'd also have to add a
"(dev->type != ARPHRD_IP6GRE)" condition in the test at the beginning
of addrconf_dev_config(), and I feel that'd be a distraction from the
core of the patch. So I prefer to do that in net-next.

> > +	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
> >  		addrconf_addr_gen(idev, true);
> >  		return;
> >  	}
> > -- 
> > 2.39.2
> > 
> > 
> 

Thanks a lot for your review.


