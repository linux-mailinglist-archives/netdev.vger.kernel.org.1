Return-Path: <netdev+bounces-209386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B91B0F6CC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B73188B112
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527BC2E54D9;
	Wed, 23 Jul 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAmZ0I13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40EA285CAA;
	Wed, 23 Jul 2025 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283608; cv=none; b=Qk5EuWXlX1BugbwqPD05GYNsSbG0wQBRU63mEOCn62CtTUErva2GdWs+ZwLgpfv+3HB/82UdGE/GMfY52Qz+yAiYkV9jzDXZTlD5vrFSh3z5DTki3XXknbXOB54DDIsrU1/LwxqUKRxhmiMhLvjs6nQ8j1kuJMcSOV9tfkY8CBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283608; c=relaxed/simple;
	bh=bmRPPXyy1KivtiDvq/SiRJuxFwp0GduBWrTnZvhgX+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz226p7DfZ9vRPhgo4wzpmT+CjqUtG8apeWQTrQp3onsFZXT+eoA0XmVwwNsaLA2gO2+qDy3vfTZ/yUGp6dtyffPp780mm/mgaQs9QLEjM8avl+FtqomDreM6qZSJoEKkW0Ll8X8mREkvoR4VFbCWAf92i4NGbTqh+bNFjk5l0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAmZ0I13; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2353a2bc210so61884795ad.2;
        Wed, 23 Jul 2025 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753283606; x=1753888406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvB9o6u7KLzM0y0P4HnC3nU4zuU2oVFIaEaNtGW05Io=;
        b=OAmZ0I133BSc06vI6GKW0Ufagxn7HPQsjEcU0IFuOpo54M1qZrYlDSX1fvAUTSngna
         i3cSMmvee8OODgieyY4ArCz61IPdPKgjxzJuRNa61v98xXr2070UtxdbhzgXiB8SWmmV
         Jyqkdyw5ibiP5ZasHD0LRWhBN2bFfUbbXkqtbqr14gwFTjhfKXwirBRlVKsvuT46r6/E
         EF0HYgsXWYH8PqRSys3qyoqxelJhk8J3POOkkCXrONdx2AV0N8KcqknnoBnZN1wmflxi
         wDz8JekAEvM9A9a30gLws/yh9DeHc3g3ufM1mTHoKO3H8n9TTQN4ENzXktPukinDNCdC
         l8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283606; x=1753888406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvB9o6u7KLzM0y0P4HnC3nU4zuU2oVFIaEaNtGW05Io=;
        b=q2WohLH7JTddG8qMNKLK4ePHnMq96NdQZx+1sqMXnZXeMVaAFJtgGwsqYE/5H4JDSL
         wQpi75oi+53RrVqfXMr3n/Y/8QEm4qQ+NKZ67TKQAfjUfbraK9t1bxknET9YjcADXhzZ
         OOPSFGkh2UG3Kr+uLUWytjLQJ3Fi9/1L7Gw8yys6TCaSra2FxKGMQV/dbge8rzRyMqni
         D/4Z34msfJmggiAPbfpn1UmcSED8v1idShNDR7V6kZVwXjp8fDjDzbh8PUm5ZWabX0kd
         6gRgLMZpg9Y12npr7aD/GzN4wsibzYZF9tgNmsX84y3ZYPzb+PoiZGrGT3oDn1xNikSF
         k+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUAbeGCgBSN/J2xRQz6y3yBIYe1Tk5rXPKFC491ee5HUx47c7CGmoPdMb5jz5NKZgUMkUR0zlkC@vger.kernel.org, AJvYcCV+jhwGj3DbsLh9UKoBfhNK9XPpTF//Mxttbezp9yaDTx8Xez5veirUyiCqhenc7h1YTmck8ZMdi+ylJy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagpnSrewNDoTRwwIdG/NqM3Ik0crKGSqEABeEa+fJUglxiLYd
	hFca0kvMrNhTJqDpEW9MfJikh/xGJdTXCke2d/upsyUeEafvekPLioQ=
X-Gm-Gg: ASbGncvy/8w5UAE3hs9EY04PPpI5GQJgPD12LZgQQo2qafRzuYI59xyFzk2VjTusNZg
	zG6id1Ks/nWFbHKzUcSYngt4eN9qlJmSca5Kp3e5SDPZb/dvj4IR09SQcBbj2kwWuNlV/ab55tP
	OlbiH0MZwbUStZxjcV19IoLnDSt4kywVEVsl8nX7hEWKk0qMp75viWfjH5LP9/GlNquhq7W26Kz
	lHbrZaSbvCq9bpRzo7oYNLEE8eoUbLHrYjZyfi2ghL8UTh+VJxWuC7ZX+rlZSPjBMDPSJ+9W+eV
	ioKSxjy/onqnaVHI6hxqHTA9uwHfqspIzfVgxJh0Ty2YTa6apE1an1WQxBklTV3JzWWk3vACCHX
	ymuz/80f7x/o82lWcG7FdKSWbuVeJuDth0az8oCCtZSEm3Oud9K0muL9u5Ak=
X-Google-Smtp-Source: AGHT+IFUFT4xMVJosUhyJuO/OyoYgPY1llQEJMyP+jQRz5B67+FV5KJRaiVZSR4c0q+mjeRS25t7Og==
X-Received: by 2002:a17:902:c94c:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-23f98221bcemr48162295ad.35.1753283606061;
        Wed, 23 Jul 2025 08:13:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b60f426sm99021685ad.67.2025.07.23.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:13:25 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:13:25 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: Warn when overriding referenced dst entry
Message-ID: <aID8FaYlyuVjeOH_@mini-arch>
References: <20250722210256.143208-1-sdf@fomichev.me>
 <20250722210256.143208-2-sdf@fomichev.me>
 <20250722190014.32f00bbb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722190014.32f00bbb@kernel.org>

On 07/22, Jakub Kicinski wrote:
> On Tue, 22 Jul 2025 14:02:56 -0700 Stanislav Fomichev wrote:
> > Add WARN_ON_ONCE with CONFIG_NET_DEBUG to warn on overriding referenced
> > dst entries. This should get a better signal than tracing leaked
> > objects from kmemleak.
> 
> Looks like we're tripping the severe nastiness in icmp.c:
> 
> 		/* Ugh! */
> 		orefdst = skb_in->_skb_refdst; /* save old refdst */
> 		skb_dst_set(skb_in, NULL);
> 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
> 				     dscp, rt2->dst.dev) ? -EINVAL : 0;
> 
> 		dst_release(&rt2->dst);
> 		rt2 = skb_rtable(skb_in);
> 		skb_in->_skb_refdst = orefdst; /* restore old refdst */
> 
> There's more of these around. I think we need a new helper for
> "saving" and "restoring" the refdst? Either way, I reckon the
> patch with the check belongs in net-next.

SG, will run all tests locally and try to weed these out before
reposting for net-next.

> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 5520524c93bf..c89931ac01e5 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1159,6 +1159,12 @@ static inline struct dst_entry *skb_dst(const struct sk_buff *skb)
> >  	return (struct dst_entry *)(skb->_skb_refdst & SKB_DST_PTRMASK);
> >  }
> >  
> > +static inline void skb_dst_check(struct sk_buff *skb)
> 
> skb_dst_check_unset() ? Right now we assume the caller will override.
> Or will there be more conditions added?

skb_dst_check_unset sounds good. I was not planning to add more checks.

> > +{
> > +	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb) &&
> > +			       !(skb->_skb_refdst & SKB_DST_NOREF));
> 
> Why not 
> 
> 	DEBUG_NET_WARN_ON_ONCE(skb->_skb_refdst & SKB_DST_PTRMASK);
> 
> ?

That's more precise, agreed!

