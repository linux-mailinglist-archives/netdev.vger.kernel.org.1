Return-Path: <netdev+bounces-96119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D758C461B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A14928217F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820E0224CE;
	Mon, 13 May 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PBHbiJ16"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FF20DF4
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621614; cv=none; b=kD+rR2Ikb0eSjiUSPfbfKlEhNBUpUNKzwLO57nWmztZVkvAwcIOTaw4r8cUaMMyZ8tRMt8MEkCOQXHx81MaIrcHt9/LLaumsfbdbUdfxkJXDDEhtlrElhQTc0wXRMqzy2nEOAq/vtD+DjcWBzdK94pZQuMrZOF3QLoQns7vM8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621614; c=relaxed/simple;
	bh=004wZ/BTyT9fE4JXjqxo7dvB6azeLVxU7gAlJEphKdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zeq2U1IpGWWpyUrdZHw8B+eqGw/2Ycu1BAg/y1ijX3BGj/sTVdse+XB7z04SzbtQChgFFVJipWL0jyPWBi1a7THxgyZw3HmzhBXXU84A2HQTNe/HYicBb+vH4ITFGRgSSOiRvCpDhetSzIxwsszEviG8oGDWOxruDVWl1j0nyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PBHbiJ16; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b2768410d3so2089023eaf.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715621612; x=1716226412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWgFC3S2PfP1iJSh371S2lssW1zUAEloG1SEMk5tnQo=;
        b=PBHbiJ16yUyRq8xxXOantAlgyE+09KxSYjBca7c1xc4qrO7q0VcT1Jd86n/6qd2N0n
         L8hp46JRPfQEs9ncx3lrKtwI4o0tLCDylmw8DicDZDngxrxs+7ECFbH0+B9LsTtr2cUj
         KG+Lh/nwg5DSwJL7rYxyzx2LhBz1xsEYVWX5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621612; x=1716226412;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWgFC3S2PfP1iJSh371S2lssW1zUAEloG1SEMk5tnQo=;
        b=GA5LOGijOiqacyx8K62OkT6loXrvlTFBs0CY1VlywYlfXLhN3HxiXMrHA8VHwjzAo5
         gKKyjfF838RtWpV01/e2niT4OeieHKBLs3/Ba9WeShCi6oNkvlOHQVQdlCXLFjxPdyiI
         Lc1BPZSUTuDwfojJe3wnG56ncomCSdg2Dg3EicgJc5udSP8adB+k3yDKRYu9P+6MiOXw
         LID9CaaAM9ghONmRZ0/X2T5hko5OaSxmLro2NWR0gjHwOSrHVEl6tnT8KO5pQLAh4nYj
         AioLTHFM3vGSFFxRnKEu9k6Qh8LDG/IX4lNahva0mKl315ltGtZt0UXE+XSiAO7/vsm1
         TcGg==
X-Forwarded-Encrypted: i=1; AJvYcCWijUB3vHQMfAXhEAtjGWo8ARki+HjHoWerwOST1fQ9xKkzM8a3JgfzURGI2ArQeT7DG5nOe8XDVfaN/8akmZG7WP/N4knt
X-Gm-Message-State: AOJu0YxOuqUjBq50u6A7ZZO9mCTSpy+ToGz7TRDwZ5KiOyJ7Q5Q0gCrl
	+KjxgRy58tDTQ2qw/4BVfh59tBQEFRerntovfxKIgf4/5jgwjtbtTMvSt9F3WuY=
X-Google-Smtp-Source: AGHT+IGLySbm6b/4r6B+YP3EJ/0D5HsDixyPGRii0Uq+ZLUeYN7X2cixlwoD4AR5edXW/aNBuPaBkA==
X-Received: by 2002:a05:6870:c185:b0:22e:a451:57d1 with SMTP id 586e51a60fabf-24172f69da0mr10682085fac.52.1715621612005;
        Mon, 13 May 2024 10:33:32 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a449e0esm7969360a12.13.2024.05.13.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:33:31 -0700 (PDT)
Date: Mon, 13 May 2024 10:33:28 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, zyjzyj2000@gmail.com, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/1] net/mlx5e: Add per queue netdev-genl
 stats
Message-ID: <ZkJO6BIhor3VEJA2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	zyjzyj2000@gmail.com, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240510041705.96453-1-jdamato@fastly.com>
 <20240510041705.96453-2-jdamato@fastly.com>
 <20240513075827.66d42cc1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513075827.66d42cc1@kernel.org>

On Mon, May 13, 2024 at 07:58:27AM -0700, Jakub Kicinski wrote:
> On Fri, 10 May 2024 04:17:04 +0000 Joe Damato wrote:
> > Add functions to support the netdev-genl per queue stats API.
> > 
> > ./cli.py --spec netlink/specs/netdev.yaml \
> > --dump qstats-get --json '{"scope": "queue"}'
> > 
> > ...snip
> > 
> >  {'ifindex': 7,
> >   'queue-id': 62,
> >   'queue-type': 'rx',
> >   'rx-alloc-fail': 0,
> >   'rx-bytes': 105965251,
> >   'rx-packets': 179790},
> >  {'ifindex': 7,
> >   'queue-id': 0,
> >   'queue-type': 'tx',
> >   'tx-bytes': 9402665,
> >   'tx-packets': 17551},
> > 
> > ...snip
> > 
> > Also tested with the script tools/testing/selftests/drivers/net/stats.py
> > in several scenarios to ensure stats tallying was correct:
> > 
> > - on boot (default queue counts)
> > - adjusting queue count up or down (ethtool -L eth0 combined ...)
> > - adding mqprio TCs
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> Tariq, could you take a look? Is it good enough to make 6.10? 
> Would be great to have it..

Thanks Jakub.

FYI: I've also sent a v5 of the mlx4 patches which is only a very minor
change from the v4 as suggested by Tariq (see the changelog in that cover
letter).

I am not trying to "rush" either in, to to speak, but if they both made it
to 6.10 it would be great to have the same support on both drivers in the
same kernel release :)

