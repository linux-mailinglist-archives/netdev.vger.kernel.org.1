Return-Path: <netdev+bounces-155139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BC4A0135D
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48135163E63
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470D165F1A;
	Sat,  4 Jan 2025 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC3HcEGv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1312170A15
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735980373; cv=none; b=s4Ou7zLCDsB82TAkJJbpng0mpvUNG4cam1uc/JILbNqppt8C4+ntEKppFyNZ/D0YZPZP4sy9wSKJ0lT1nHoka0l/AejnQkG7XOu++8E47Lx3cqOs18neUwiuWk6mEGAxaSnGLNKPNjufw7qBdtVqhTlmwIf6RiA97ceJh2+idFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735980373; c=relaxed/simple;
	bh=rXjsdc+U0xRvMvZ3QLwKQ9eNTcQFSgkNHad92O7Eevw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bq7MxEsjcsYmJgHxfjp5pShJq7Lpu9Y9/y79WXATl8FMDJOtBgYFJHExhxOXrVDA0rSxfhJA+aYP7txLuFEen4k1+Th1tAcOIyWjZhBOI2DcrSj5ZF0HM5rfhCL+lile9zjCR+T3xqLe6UbWusTNrAevMjCY64XNhAFa8eWc1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC3HcEGv; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eb3c143727so7050275b6e.1
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 00:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735980368; x=1736585168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl+Ir+W4Tc150TI86Xl3owY10X0QmL5Q3ZTgg7AzqP8=;
        b=DC3HcEGvxFGn6J9Jl14s/hETLXnpjZIlR3aq/ZWOkMkC6yBfBompVF8pdyYO7ZTuuL
         6A+5nT5iPS7PUfEJAOn6+BAlidlwvdCexVSuhWnitkYh8POSebLKE4ExaFNzxhX5rjD+
         TPCTS9iT39O1E8FDfboZlfJO503N5/f1c/MThpUQ2U/Ibe9hpAVTIY4NAempYIssaF5U
         LOMMbwNjVUqpmM3yGtMwFMXoLJyqlWN9IebsrTlI+pEu5wD8XTLbUTbQbxP3ppYKDmW6
         BjZJHpkd8CtJoqhDqWJARmKiqVA+pnUo+q+7xTL4KhwJvhv2oR2nPh5BDfz1G464A8uO
         dcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735980368; x=1736585168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl+Ir+W4Tc150TI86Xl3owY10X0QmL5Q3ZTgg7AzqP8=;
        b=OQn14TK0yH7zpadPCtt3BgqnTGiJ0x3fanQ89FYwAKjfJeBt4N6n6xuzNODN6TRx2q
         RiwFLFwSrrAyPR6m1LTdhNdUfRJqutW8/K8j9M0ZFmfH3FgjHaQw+shtN7FIlIi8zaXd
         r3YyNtur8KixSaGmz7/qxyFH2VrMfAI+VRn+f7wLLLpx+wRIvpTZojl1QysjvTCf8I/H
         gfndErZd8VXfLX2v2qmMKD07Y3LT2CX3sKj6QuRdHr4eKl6Ys/d3/+i+ybZLfnOy0jkK
         4tK/R12fiXI0DPPhStWTGC49cCKNOqjO3VwYImFY/iyN1nTxA21mKc31pmcEZKBqFDMJ
         0XCA==
X-Forwarded-Encrypted: i=1; AJvYcCXnA6TGnmSwBtWRJcJ3mt1qkvG2z2WVyXg8wF9IJ4avv0xvkIHvDBDsdQakbbcp7x4RGGI6b5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwWAP82NSjW5N8t8+n0gYEjZ0dKPGlPZ9lJGEvAdKX3LXPauk
	ldgWL8rw9dZhPWIsjmyzSuS7K/lFGhnwmdLyokWatDoQHtc/KdiwRKf4g6U=
X-Gm-Gg: ASbGncum4p5CBD4p5/TdlINwed7hak8iMYm8y7TwUUcW0CyNgfAGnVrf7itZD80lhzP
	qREfIf4ZU51Om1YcnPvgeYOWCe1BNjZCfr2yN/WumTuE6iZISZi9E9ke3/XZpSnOBcOn+X/7/oL
	wmzt9YhB/Jc5Fc/ju7Au3kkmdjse/jhPx8R6cP/fnN8Qc5RqlZqtr3oD4CjEBFByIiFg1xVhiyJ
	4K5yt3CatLVAukskW9243DIZXz4vZKnaoscHGD6N112YEPpHoZu1RE6
X-Google-Smtp-Source: AGHT+IHSg75soj0PM2nULXoIjrLDnLFqZJlojY/MCnWC55e+vBBNVcMlwjwjjlKj84zfL1TUry7fFQ==
X-Received: by 2002:a05:6808:138a:b0:3eb:615a:eccf with SMTP id 5614622812f47-3ed88f79fd7mr32551549b6e.10.1735980368187;
        Sat, 04 Jan 2025 00:46:08 -0800 (PST)
Received: from ted-dallas ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece244e2b7sm8829599b6e.9.2025.01.04.00.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 00:46:07 -0800 (PST)
Date: Sat, 4 Jan 2025 16:46:06 +0800
From: Ted Chen <znscnchen@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: roopa@nvidia.com, bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] bridge: Make br_is_nd_neigh_msg() accept pointer to
 "const struct sk_buff"
Message-ID: <Z3j1Tp428cuIHUzs@ted-dallas>
References: <20250103070900.70014-1-znscnchen@gmail.com>
 <e7a27b5f-a4fc-4eaa-b215-d7a1bb7fc234@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a27b5f-a4fc-4eaa-b215-d7a1bb7fc234@blackwall.org>

On Fri, Jan 03, 2025 at 11:59:45AM +0200, Nikolay Aleksandrov wrote:
> On 1/3/25 09:09, Ted Chen wrote:
> > The skb_buff struct in br_is_nd_neigh_msg() is never modified. Mark it as const.
> > 
> > Signed-off-by: Ted Chen <znscnchen@gmail.com>
> > ---
> >  net/bridge/br_arp_nd_proxy.c | 2 +-
> >  net/bridge/br_private.h      | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> > index c7869a286df4..115a23054a58 100644
> > --- a/net/bridge/br_arp_nd_proxy.c
> > +++ b/net/bridge/br_arp_nd_proxy.c
> > @@ -229,7 +229,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
> >  #endif
> >  
> >  #if IS_ENABLED(CONFIG_IPV6)
> > -struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *msg)
> > +struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
> >  {
> >  	struct nd_msg *m;
> >  
> > diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> > index 9853cfbb9d14..3fe432babfdf 100644
> > --- a/net/bridge/br_private.h
> > +++ b/net/bridge/br_private.h
> > @@ -2290,6 +2290,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
> >  			      u16 vid, struct net_bridge_port *p);
> >  void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
> >  		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
> > -struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
> > +struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
> >  bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
> >  #endif
> 
> Hi,
> This should be targeted at net-next (subject should be PATCH net-next).
> Also please try to keep commit message lines shorter, checkpatch flags
> this one as over 75 characters. You should wait 24 hours before posting
> v2 of the patch.
> 
> Other than that the patch is ok.
> 
Thank you for your kindly guidance!
v2 is at: https://lore.kernel.org/all/20250104083846.71612-1-znscnchen@gmail.com

Ted

