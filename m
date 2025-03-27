Return-Path: <netdev+bounces-178013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6CDA73FE0
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C75B3BD917
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576D1C8634;
	Thu, 27 Mar 2025 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4qXzMsB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF31D618A
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109449; cv=none; b=Bkq7xH8H8ocBG4eQ2H5wvP2D5ofOqvxZp6vdReZ5WfA/mS1SaYmjQsJmErpMTcvVyqR5ldTbK7lvt1BnHqF1bMkBWqmfRN7ZdODIkkk13ScNI9NQE4jQplmOPuqrWAyol0kvvJ4eWg0vC5idZiLPjEAWinoSxsFL102ji1AdRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109449; c=relaxed/simple;
	bh=56GotSQN4ROFjgLSPTSdcNaWmVPnl/qL5ycjeMVJhWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGBvb3lOKjqeGBPilTKWHZPzllPOI3Ib/PP0MNLrbfB+tyhbL7LcBfy9l5XO8WbOVkwJtGIkPHGGn9wZ2l38CaUL5b6Qx0Vz5AUSpmr2mJELVnmdtWb3CtmhFCALXJe6J8NGG0w6QGFdUyIOfTNLbvus1EGBZJA8e5TOYFL9jfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4qXzMsB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-226185948ffso32815615ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743109447; x=1743714247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ6IxZqIJcfCnMn17huE8Gly++WXsap5NI0ZzKKPPy8=;
        b=D4qXzMsBchbRP0pJ1EAeojKctPv2SZquCd/y+9u2axpsZy1HESkEBqPHwoewgBwyGL
         aE9uatIGvdC1WWvmOhqwBgptUrlVPzgj2tnXHJhKuVNlCm4A586D99UOwWyUPb297jWC
         RXC37DLZHKzkSe/6fm1mE+D3tUcjevsycJeUvHCzGTNu9eJrNGsNk12H42BIAG86SCcD
         aFIYOOxakoeZzNJAYkYzj8FuNAhCvIlW3DrKlCO3SC9J5d5XwczAW3LVIBvPnmfiP6VK
         O9w/03xpOoPq0/j41MXaLeSWPveYykglOlnZA9RGYTxUMwuKO4pw2Cg++y7z3S+bU5YC
         6CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743109447; x=1743714247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ6IxZqIJcfCnMn17huE8Gly++WXsap5NI0ZzKKPPy8=;
        b=sZc39deqpchmacQStXnIXMvalSZPN2265o6MPVU4dnZT8GFiGHiHzcEIpK6Bu4NLJf
         bp5wHw5lDuTrgRPSoLoxFGzEelH8cehC/Kgl8SOFRWXlO85pMFsvJls5Hkf7Ry4+ozDt
         sZ/NAjqvtzR+I5l17dcG+wfC60yG2VXiydx7OfL3fyuy64nLNld69TFSGOw1lmraPONf
         Y1daFwkbUvxjMnckXpMOyw6OcQsC0ee9vbShaS7eC6/F4XH0cp70OrCXSkuWO4ni/XNj
         7cjK7u2doocKGZcHYwrhn1dUyqs2qMe94aV4UczTlW/9cqcQAuufB7vEm9aWV7dBR12z
         95qg==
X-Forwarded-Encrypted: i=1; AJvYcCVtksrl+ybkEFyUhjvTTm7GpuQaYi8Pc8Cz/lsxAmkCl36VeQ1JZu/7taVSUiR25BEtQiwkxxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmof+/L4DVOXhEXVUhmROhwOrPOoqwBjEPBYt7akxRzATG3WMY
	+F9g8SRN2hvXLyxShAPbT7E+90B+KlFaKiRPLdd4cXCXg+wvnSE=
X-Gm-Gg: ASbGnctnJxJvQyQwlZTBRtN9enIWNo1CKZFbeMOfnzoMRh0gIvKF0itM+u/cbRZrLL3
	e+9vCnN471gAzubA+Yf9PBkKkboJgM+sp6QD62lWwu3Zh5krX+QSfqpZ1F7kdzxT/At74iiJgZZ
	PG2eCMcR3GAIIEBlHq0m16bH9Fv8D0gT8QFGillWb5UxLX04jZ1KoTPb1I1Pf0HqxqhxN96KEX0
	LCdOiGDqK1kALUpUaR4C3TcNP5F10LEtkuWlKCCmgeJzKSKpkLSSPisrxka6U8AHpJFGph3I3mM
	RDPBjRhDHxDtIsKzkXehFY6RzhMCMHL3WbesVfjhEwBT
X-Google-Smtp-Source: AGHT+IHtwanHFU3X/tBKT0PN21rdYBhdcTO3jPdV/1NrEfScPeZuCwcrxzejTHYzB6zifudhXY6O0Q==
X-Received: by 2002:a17:90b:2c84:b0:2ff:6e72:b8e2 with SMTP id 98e67ed59e1d1-303a8e76448mr7365323a91.31.1743109447290;
        Thu, 27 Mar 2025 14:04:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30516d56521sm386244a91.19.2025.03.27.14.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:04:06 -0700 (PDT)
Date: Thu, 27 Mar 2025 14:04:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2 06/11] netdevsim: add dummy device notifiers
Message-ID: <Z-W9Rkr07PbY3Qf4@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <20250327135659.2057487-7-sdf@fomichev.me>
 <20250327121203.69eb78d0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327121203.69eb78d0@kernel.org>

On 03/27, Jakub Kicinski wrote:
> On Thu, 27 Mar 2025 06:56:54 -0700 Stanislav Fomichev wrote:
> > In order to exercise and verify notifiers' locking assumptions,
> > register dummy notifiers and assert that netdev is ops locked
> > for REGISTER/UNREGISTER/UP.
> 
> > +static int nsim_net_event(struct notifier_block *this, unsigned long event,
> > +			  void *ptr)
> > +{
> > +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> > +
> > +	switch (event) {
> > +	case NETDEV_REGISTER:
> > +	case NETDEV_UNREGISTER:
> > +	case NETDEV_UP:
> > +		netdev_ops_assert_locked(dev);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return NOTIFY_DONE;
> > +}
> 
> Can we register empty notifiers in nsim (just to make sure it has 
> a callback) but do the validation in rtnl_net_debug.c
> I guess we'd need to transform rtnl_net_debug.c a little,
> make it less rtnl specific, compile under DEBUG_NET and ifdef
> out the small rtnl parts?

s/rtnl_net_debug.c/notifiers_debug.c/ + DEBUG_NET? Or I can keep the
name and only do the DEBUG_NET part. Not sure what needs to be ifdef-ed out,
but will take a look (probably just enough to make it compile with
!CONFIG_DEBUG_NET_SMALL_RTNL ?). That should work for the regular notifiers,
but I think register_netdevice_notifier_dev_net needs a netdev?

