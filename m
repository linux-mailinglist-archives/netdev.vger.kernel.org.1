Return-Path: <netdev+bounces-214989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2443EB2C81A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81972188318B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9627C875;
	Tue, 19 Aug 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1aKmyqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669C27586C;
	Tue, 19 Aug 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616047; cv=none; b=Yes/U0QI5eZQWMCJyqiAEnic0OkmDdqLPTgpz1YJ92CgpFwcI1PR40NO7F5zXMFQYNFChUi5VJ11nCgR63Ejn7pDMdBrgke4dzkQtHeXrBjw1PQ3Xq9wr7gBAbg06a2gLf5nYkqkCms9Sm2OANymc2GncVPWVakWKCZBjJvtYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616047; c=relaxed/simple;
	bh=YXROFwnNUlOornpPT+7dWoZM3RUfvot8aSuaVg/IVIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw9OIwk3BUkIZIwDeEwVMV6Ar+USmTXC/tAg9YMEu4AcFpHLblFUEjhTtBfARWkoh2LMYkmyaCJKSJqh1NJE2MVeq1z44nqltetLieDi6Lm92ENFCPjljfr7yKcsI/hNIanJ4OpHDL6hTb/8YXq+32p3AR8V4sk7MmueSSoqt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1aKmyqu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so33225215e9.2;
        Tue, 19 Aug 2025 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755616045; x=1756220845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31NnMw+sR/boUBGDMCsfJm4/9DTGEiQe83G8QpDlMRA=;
        b=Q1aKmyqu2uG3TkB5chZ11ORN7TggTbyvcyA6dEvikLR0ySsk8b6pSKajg+78PQ62N3
         ZpnfbmPwbnadSx3buTqRUjvEbT2w0oboN+d4kxLuFy7Ebsvli9PE1/8GLsrckC5q/Bm0
         uzZ8RNyYCCA98lKrajmZF4tn9BIm22jS/TEpYPaPgmX8V6VBoqPweu6AL1ZYX9cVpdT4
         A8DoTmAlp/JEVymqz/2fgj1G3plVc0kiDaohFw5NZpOi9lh0JRPFRSHbLKxisw8EQHxj
         YYeQk7TKKrwydDb87YQsxJsmQ1eBCtxnkG6O64uXcRjy3coIbExK+ci0yAkT7uWrctDU
         XQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616045; x=1756220845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31NnMw+sR/boUBGDMCsfJm4/9DTGEiQe83G8QpDlMRA=;
        b=XKkbEFh7CKP4oqpcGS0GJgnGd36l4BlOXjewhNoCMhdf2vf8m5BVdSVE2jtGd1Fg/1
         IP/QiOO3SbJZ5pnLhqDvqJNVocbLIwVTeENIvKXxZmFRwGhrZn8OjhdbSYHG4izg0iVA
         tRsCaPU+6JSCg1KOjgx5RtnIZHsJ3NfP1CWpxPFg+N1Gx1DfI1laM/yuZrgzhPxXEwnA
         gkKQA0R3sv0rj/aB/kj0TJxkOEjG8YzAwq9II2sd04o6uSp5JP61vnzvlY5f3ctLPBMZ
         6+P3XyurmvP4Ap1S+cUv5o/vXEkZ7+lJ6qmgERnvTPcLgu2gMq3xRiXTpxorEvbUZphQ
         DTiA==
X-Forwarded-Encrypted: i=1; AJvYcCW1kgwCy3Cx65n065ivK25Hw2SnqSDHPzIrQL/4CeUH0SU54NB9kKp+zX4JQIWAWO+TT8FhbYOSm6/c3Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0uWTyV8Pp1Q/DeA2dfFa17h3t0LId98NIeWKQeBkbmZNvr4Z
	q3sBOuqToKO97+dPgi5SFGznksfezrCbEiAmhrVhe3+EhRdi8mbv+bZU
X-Gm-Gg: ASbGnctP5tARlWoq1BevFj3VzLPD5WaRVkSwjLNL0fwQ+qGfQOADjA0njfPCA1/ZG9I
	ZaxSOIP2tQ4mOct357pqbND3Bf3lQHzy/anGQJqORLw2wGmzyfMGg7vgK/kw10dy1PIXPI9uQ8t
	dngiFf3kdLDkRCtfxIKdIwA2T99k61c5zonozpdiQZAn7CgCaI+rEwgcAsFW+jksT3Y+Y775qzT
	vQ5O7NGeT7s4gJA3mDP8oSKburEiwj+sR20g80eDu8oxoGCmAiDpHpYeTOcetnuD2lK3vO8OAkL
	FP6Lxf+laxG0kXahHaRWAmNd3VxDGZKFIhkLVnsKuAjRpKcVopAf6Qc6aqgYxWQqpndRrl0m0Tc
	pGptf9zP1FX5SrfWigjFW0U0Qj2GxOGTAko4=
X-Google-Smtp-Source: AGHT+IFn1rIJUXNL7r+1vboq/WrMO0z52JKcLjM7JGh9GNqqPEHJEJD2aqlyioxB8quYtRtM7SUwXA==
X-Received: by 2002:a05:600c:3506:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45b43e02b79mr20909305e9.28.1755616044294;
        Tue, 19 Aug 2025 08:07:24 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74876csm217597615e9.14.2025.08.19.08.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:07:23 -0700 (PDT)
Date: Tue, 19 Aug 2025 02:08:47 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: ipv4: allow directed broadcast
 routes to use dst hint
Message-ID: <20250819000847-oscmaes92@gmail.com>
References: <20250814140309.3742-1-oscmaes92@gmail.com>
 <20250814140309.3742-2-oscmaes92@gmail.com>
 <3bb31f61-08cd-4680-a16d-20c248e3e1c9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb31f61-08cd-4680-a16d-20c248e3e1c9@redhat.com>

On Tue, Aug 19, 2025 at 12:46:42PM +0200, Paolo Abeni wrote:
> On 8/14/25 4:03 PM, Oscar Maes wrote:
> > diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> > index fc323994b1fa..57bf6e23b342 100644
> > --- a/net/ipv4/ip_input.c
> > +++ b/net/ipv4/ip_input.c
> > @@ -587,9 +587,13 @@ static void ip_sublist_rcv_finish(struct list_head *head)
> >  }
> >  
> >  static struct sk_buff *ip_extract_route_hint(const struct net *net,
> > -					     struct sk_buff *skb, int rt_type)
> > +					     struct sk_buff *skb)
> >  {
> > -	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
> > +	const struct iphdr *iph = ip_hdr(skb);
> > +
> > +	if (fib4_has_custom_rules(net) ||
> > +	    ipv4_is_lbcast(iph->daddr) ||
> > +	    (iph->daddr == 0 && iph->saddr == 0) ||
> 
> ipv4_is_zeronet(iph->daddr) is preferred for the daddr check, and it's
> not clear why the new check for the saddr is needed here.
> 
> /P
> 

Will change.

