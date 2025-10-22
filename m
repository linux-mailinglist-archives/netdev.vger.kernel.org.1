Return-Path: <netdev+bounces-231806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22113BFDA34
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C22E24F19E4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E32C3247;
	Wed, 22 Oct 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0fLYb71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307B2D9487
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154781; cv=none; b=Ng5AUmUG6chYJtak+4Y3rngP8r4AumKK+ZeKLARbHtXpihK7VC5+6SMIRpmP5P7fCUMusxp9aoo2677iLMmYHZfbS6pUHltyYWkU/MNH3gyWMv0RGRBs/9IWVWQ+CSgjJQsFz8lny4MSll6MmoutBfu5bARkPNQY26N+hcxgvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154781; c=relaxed/simple;
	bh=O2rS9th93VdiObqGHqJg9tF9FtBIZpNefdSGlMkHdmY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9S5+lN2ZqSldxmrEY4stI/K1XsGtMvSATWQeCmG+QyZShOLW1ZMwT7YN09BZwCGPxIjxicoHiPi06vfEiZXQESd4NdPAHjm40REk43vPTmM+WgpGqMzPsjI+ca56y6WD5+R7BrdReVAo6sJqJMBbIpUWbSJF3kxXg7locB8p+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0fLYb71; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so582148a91.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154778; x=1761759578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQdE14qwP3ArpvNj7koaLBKy4oXNS6rDuyXrc8Mb3G8=;
        b=V0fLYb71LWnbHwu7vx+4+aT/VvkpyKipsXg1ezt52QvFAnKAfO/rz8U9SAK3QD+I6M
         a3HuAHR/dntApw2kb4XyxrlPKGsIblTNQGIM7K4tFoGHgZ6ops7ZEi4ej4IlWOObDJm2
         IGIrsJfG3ZqjSKhfdC+6zndkFNPU5yo3U9KEVSZ91FQWAFQOEtArWzGhABH71QcRTZOg
         uvcGXrc7+cns1KPyTfU9cemH2ySU+42kbSGJIqEf8kt2hiXVHOmLb56+1/ID69JrZMux
         A9Y8GYgN8ATvaCfykkSZtFExjj/YN5o1fkoz8QhJi46JrLqbTSz3oNTO72YXBpdF6oLg
         QBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154778; x=1761759578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQdE14qwP3ArpvNj7koaLBKy4oXNS6rDuyXrc8Mb3G8=;
        b=lm6Hanb3Y5zipagJhTr+z5RVznsYuAD1Yms0SOQMINRwWnaCzBbQIAMbZgdWqkAHmM
         4XGmwaKFC3rgwi9jQPB+/aB6S8wF3t2QyQ7ApIlG2EYqauYLHD8reQeGrtHW0jmJ+UsK
         +XW6L7NBLA2xf42tqAwAa2l3/6uJNJZYTYUjN8ikj9lWYw5jwzUNSS5MOywBlIBkgt7v
         UoAu+oHEVixqURIlFpiLXIlImKPzfIfqoJ+aUfXSBH9jKYGCEaCtEWZFSLnOafx4r7GK
         Bz8tQ5P4gZv6S47c9hvv/ZgF0dJj50OaiXMGQWZt2wHAwlUbschtTRqtUbpGTC+IBSxQ
         RhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnveyvw+kF1Lg97gHj4jaOQ+XDTUt2jiqWWas3qcheiyDHBblb4OKVpTV+0uMJ77UlzQZZyig=@vger.kernel.org
X-Gm-Message-State: AOJu0YytC0w6IbHHS+k5ZOoJsNnVbH3DyuS0lOh4HEoesvZc5flh9Np5
	pOaBBF3y5almlDcltUb70MAJmUA44hkD51Haa8pkAI2RVu65zqNr814W
X-Gm-Gg: ASbGncv5Gz2g6o5hz0Dzf49e5DRkqL9IZALgM1VMLwuGZ4WQv9Krr0ZtZQJoWIpGyKr
	IZhnpEhKuoxYq251GD6AxTs43yW1UbXwhCuU1p/q0lO0VR7c4dCmln3aFgUNyJ8AjeFafBDhT9c
	O350zkIMitrGePEECM0aSXAK77ribm5y96CZXdK6pQoeS6CIHKB7OLdInY/Pj7DMKQyz2QgTerp
	zRL9lTB42eYnGNuUICPT1+GG+Lf4v6S4C/TfuGeG5kv05yo5RF8/9t5tGk9CTopc+9salxaMEtB
	JQzTan5nYynJSF7w+5mpcfBgjyzrnmA3t9gDFEpyZ+gT4glS5CuBw8CjIsX3q4GhDYSsCplvY33
	uYXAwmBL1324nAPgqP8syK5AMFUJyFYqw2J5r0VANjWQckAWyg4mdHlVeMJXoynzKDU1pr3nSFe
	wMtZU=
X-Google-Smtp-Source: AGHT+IF/wQlvN1PHS4P0FuXHnhUI6gRONo719YP7lTtUWQHYnX87iTmhZHJVAyR2zlOCWjra1Hg12w==
X-Received: by 2002:a17:90b:3c88:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-33bcf85d01dmr25963979a91.5.1761154778032;
        Wed, 22 Oct 2025 10:39:38 -0700 (PDT)
Received: from lima-default ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d11c8sm3174342a91.4.2025.10.22.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:39:37 -0700 (PDT)
From: Your Name <alessandro.d@gmail.com>
X-Google-Original-From: Your Name <you@gmail.com>
Date: Thu, 23 Oct 2025 04:39:29 +1100
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alessandro Decina <alessandro.d@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status
 descriptors
Message-ID: <aPkW0U5xG3ZOekI0@lima-default>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
 <20251021173200.7908-2-alessandro.d@gmail.com>
 <aPkRoCQikecxLxTS@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPkRoCQikecxLxTS@boxer>

On Wed, Oct 22, 2025 at 07:17:20PM +0200, Maciej Fijalkowski wrote:
> On Wed, Oct 22, 2025 at 12:32:00AM +0700, Alessandro Decina wrote:
> 
> Hi Alessandro,

Hey,

Thanks for the review!


> 
> > Whenever a status descriptor is received, i40e processes and skips over
> > it, correctly updating next_to_process but forgetting to update
> > next_to_clean. In the next iteration this accidentally causes the
> > creation of an invalid multi-buffer xdp_buff where the first fragment
> > is the status descriptor.
> > 
> > If then a skb is constructed from such an invalid buffer - because the
> > eBPF program returns XDP_PASS - a panic occurs:
> 
> can you elaborate on the test case that would reproduce this? I suppose
> AF_XDP ZC with jumbo frames, doing XDP_PASS, but what was FDIR setup that
> caused status descriptors?

Doesn't have to be jumbo or multi-frag, anything that does XDP_PASS
reproduces, as long as status descriptors are posted. 

See the scenarios here https://lore.kernel.org/netdev/aPkDtuVgbS4J-Og_@lima-default/

As for what's causing the status descriptors, I haven't been able to
figure that out. I just know that I periodically get
I40E_RX_PROG_STATUS_DESC_FD_FILTER_STATUS. Happy to dig deeper if you
have any ideas!

> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..dbc19083bbb7 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> >  		dma_rmb();
> >  
> >  		if (i40e_rx_is_programming_status(qword)) {
> > +			u16 ntp;
> > +
> >  			i40e_clean_programming_status(rx_ring,
> >  						      rx_desc->raw.qword[0],
> >  						      qword);
> >  			bi = *i40e_rx_bi(rx_ring, next_to_process);
> >  			xsk_buff_free(bi);
> > -			if (++next_to_process == count)
> > +			ntp = next_to_process++;
> > +			if (next_to_process == count)
> >  				next_to_process = 0;
> > +			if (next_to_clean == ntp)
> > +				next_to_clean = next_to_process;
> 
> I wonder if this is more readable?
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..36f412a2d836 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -446,6 +446,10 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  						      qword);
>  			bi = *i40e_rx_bi(rx_ring, next_to_process);
>  			xsk_buff_free(bi);
> +			if (next_to_clean == next_to_process) {
> +				if (++next_to_clean == count)
> +					next_to_clean = 0;
> +			}
>  			if (++next_to_process == count)
>  				next_to_process = 0;
>  			continue;
> 
> >  			continue;
> >  		}

Probably because I've looked at it for longer, I find my version clearer
(I think I copied it from another driver actually). But I don't really
mind, happy to switch to yours if you prefer!

Ciao
Alessandro


