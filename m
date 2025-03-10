Return-Path: <netdev+bounces-173414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB80A58B7B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D843169148
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 05:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CCE1B4F17;
	Mon, 10 Mar 2025 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iolHTBYT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327681E;
	Mon, 10 Mar 2025 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741582963; cv=none; b=knq+smIm/kT4VXi4mHNICRmA1icGFLMrD8sltkRbcEF5ohaEsvFOuTz8ZMpwjenNm14NMOIX7UPvIjLhFyJ+yukS4z9edG1GDFKu/6Z+FjDkzDUfdDGyDQe7/RfLUXbkUWCtqrtXPCWSug2OulnRtI1K8YU7bg4ov/6p1+8pO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741582963; c=relaxed/simple;
	bh=SU43BrQ5Geh02OjUAMMlIrjn5xFx5LeabQZf4mR1WtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHXk3L2RIxjtgy7rDk/9IXOYfiSOKmSlp5Bw6oEtgQMIV6zqCLh++ISYFwV+kBdihAJUieeF+AAsLmafoSKajxYuEI8BGl64f0by1eXMvYQoyESo50i/KmewjwLNbEkxjSEkaAHFdJYrI93s695YnB8rEdPQj73Ge2HBWDgKhYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iolHTBYT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fee05829edso7606130a91.3;
        Sun, 09 Mar 2025 22:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741582961; x=1742187761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZzDAzsMMiTbeu8KMghmpk7edVoPDWNRfqPRmyFyQAM=;
        b=iolHTBYTSnYhvdXiX5xKNvUODniz/xUJ2neN4ysvGUyJTBDqUr6QP5jlq8yJkysDhU
         jUXcEp6qoHMCYkYLzRv5ellhvc8w+msPuRu4n/ByJlZ7cnN+mJVG31aV5uYn0K2iIITL
         tu0n4KiR1uoiKxiLVFgGsKc1HNr+Kktap9eZyWz8ERBTzbQi3KuYNf1BduR6Bx5bsFbJ
         ecg6eIXqjIpW0hWOgcCVbd930TZgeqgrPdcgwOF20cBT1uR0NAf4vHWT2ZGa864uA0MP
         wn+8YMXYH8bROeffqSOsYhnUevQz5hJ71Jl2nA7G78ByoIQvdhAc0Syd1aUO0A2orjOa
         zP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741582961; x=1742187761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZzDAzsMMiTbeu8KMghmpk7edVoPDWNRfqPRmyFyQAM=;
        b=PwWw/FVtX6bZxRrYWr8GpFYt4/9ZTeg1Rn176WPFpvzF0txQsLeWTp8pwGe43CeUq8
         mjbpGbjXfCpKDqpYbJrYPF0CcNK3Nyo2CxXTW4Whdw5CQWv1ZmsMrAoiE0bs8k9wAhnv
         MmjjkgRaNihYyPb4/j48pY5pjVW4rEgCdO/onhlzJm1cxbFFaI4HSIcDZS1DgYW30frO
         IZB1WidVxwC36XPG4Ex9Pz5YdlOVoWuDPozFY0aWy+5oWGGqOfJXTe/jqYWFMOznw6Om
         N1knXzMXb8PmdW9BaBilXouVmW5tgJBxMtvZ27KqjWSElWctxZb2Wp50lxxX301Ixecq
         mk/w==
X-Forwarded-Encrypted: i=1; AJvYcCV711fCGxX9lEgZDP8j43o9LkmmCUXpH3LoDHSoOH/Z4Z+CepP1ep4jffns2lYcB41c3FB+iqk9HkA5kvA=@vger.kernel.org, AJvYcCW8yobucUrHVXCjEBizFU5rguly5wRnoFcigS8QrkZ9Ish09oFKcIVJhMel7Nq3XisoBAGcN+DJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjnQJU12NXUcSC/808YSNmqJYkXZJbGKMt137+X9bTP9YD7Q3
	uIFJpkYFi6oFu7+UHRolKCWqMKsf78jb2ahdApw4vlW/UQGlwUI=
X-Gm-Gg: ASbGncsSOEwk9hMLqPciRbUpXuMIEFTTKBqEFlcG+MTzckhlirUtIe3BClQoQPuvzsz
	yP+pXKyvXuTB49g513tb/+zlKfWOLhO8TFP2Mr5NtXdziT63x0QRDgmzejHAs4GT/1IckLDvrra
	bNUvplheNUmZupi1G7fOqUUKmipAE4490VMTSvYz0dYnJuDckb+ybna5BQW5P47OwwLv23U+AT3
	YlfcRn74CqI7E7sOHjMdOBgWU3H2YA6L+TObngIZMDIDCdqgvm5rxpF6Mfbcok6I+pqeiZiFfKa
	8W9NtNtvJ/yop8pjBCs5pzx2G+bdWFCacBY+xKr8P4Tn
X-Google-Smtp-Source: AGHT+IG7tzpgs+8t0alOed45KdjVCkt913Wo/UFpJ4Lgl1WT6Inz0OsMgjU+eYKcsC+eo2PA82hv3Q==
X-Received: by 2002:a17:90b:3804:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-2ff7ce77a3fmr20079153a91.13.1741582961390;
        Sun, 09 Mar 2025 22:02:41 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e825306sm8880663a91.43.2025.03.09.22.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 22:02:40 -0700 (PDT)
Date: Sun, 9 Mar 2025 22:02:40 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com,
	asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v1 3/4] net: add granular lock for the netdev
 netlink socket
Message-ID: <Z85ycDdGXZvJ-CN-@mini-arch>
References: <20250307155725.219009-1-sdf@fomichev.me>
 <20250307155725.219009-4-sdf@fomichev.me>
 <20250307153456.7c698a1a@kernel.org>
 <Z8uEiRW91GdYI7sL@mini-arch>
 <CAHS8izPO2wSReuRz=k1PuXy8RAJuo5pujVMGceQVG7AvwMSVdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPO2wSReuRz=k1PuXy8RAJuo5pujVMGceQVG7AvwMSVdw@mail.gmail.com>

On 03/09, Mina Almasry wrote:
> On Fri, Mar 7, 2025 at 3:43 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 03/07, Jakub Kicinski wrote:
> > > On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:
> > > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > > index a219be90c739..8acdeeae24e7 100644
> > > > --- a/net/core/netdev-genl.c
> > > > +++ b/net/core/netdev-genl.c
> > > > @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> > > >             goto err_genlmsg_free;
> > > >     }
> > > >
> > > > +   mutex_lock(&priv->lock);
> > > >     rtnl_lock();
> > > >
> > > >     netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> > > > @@ -925,6 +926,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> > > >     net_devmem_unbind_dmabuf(binding);
> > > >  err_unlock:
> > > >     rtnl_unlock();
> > > > +   mutex_unlock(&priv->lock);
> > > >  err_genlmsg_free:
> > > >     nlmsg_free(rsp);
> > > >     return err;
> > >
> > > I think you're missing an unlock before successful return here no?
> >
> > Yes, thanks! :-( I have tested some of this code with Mina's latest TX + my
> > loopback mode, but it doesn't have any RX tests.. Will try to hack
> > something together to run RX bind before I repost.
> 
> Is the existing RX test not working for you?
> 
> Also running `./ncdevmem` manually on a driver you have that supports
> devmem will test the binding patch.

It's a bit of a pita to run everything right now since drivers are
not in the tree :-(
 
> I wonder if we can change list_head to xarray, which manages its own
> locking, instead of list_head plus manual locking. Just an idea, I
> don't have a strong preference here. It may be annoying that xarray do
> lookups by an index, so we have to store the index somewhere. But if
> all we do here is add to the xarray and later loop over it to unbind
> elements, we don't need to store the indexes anywhere.

Yeah, having to keep the index around might be a bit awkward. And
since this is not a particularly performance sensitive place, let's
keep it as is for now?

