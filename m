Return-Path: <netdev+bounces-49179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131177F10D0
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0123281A29
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F776FC5;
	Mon, 20 Nov 2023 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFdwQSmd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C36ABA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A23BC433C7;
	Mon, 20 Nov 2023 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700477537;
	bh=rmz6ahCxLYUghRVrp0WdXh7h/CNtoT7IIvYuRQqGGhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFdwQSmdMXP4BF2EzD7YZvXzj/anwteemOUEBEUm1/e1+knS4KrmAcCxqCYoO0sJ/
	 OFeC2HrC+OXg8mk4xN3ludiKFFmLVwBdsJPD7Utl7LccDkQDdiV16Vj/o0dYoE9Xcx
	 KBx5LTRZ8/hKcsv70wOOYOzTfqbSr03pScOt7klCNXqj7HUyyK7zVeUxUf0wlZ/17P
	 nwKuvqD6kqVxZqBva2u2wErcCyZ5BMKAfnJaD/46G1qg0HdLQgFok8b+0c/IKJR1mW
	 fT5eNPXQbW0Qcdas2tSL1TZQwcnt+gm2QpB0TQwCn/39NXUemvLE+Ap+jzHffmtzoF
	 rXla+w7z629yg==
Date: Mon, 20 Nov 2023 10:52:14 +0000
From: Simon Horman <horms@kernel.org>
To: Yinjun Zhang <yinjun.zhang@corigine.com>
Cc: Louis Peens <louis.peens@corigine.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	oss-drivers <oss-drivers@corigine.com>
Subject: Re: [PATCH net-next 1/2] nfp: add ethtool flow steering callbacks
Message-ID: <20231120105214.GA223713@kernel.org>
References: <20231117071114.10667-1-louis.peens@corigine.com>
 <20231117071114.10667-2-louis.peens@corigine.com>
 <20231120094321.GK186930@vergenet.net>
 <DM6PR13MB3705D3EAE5FEF8D3B6902146FCB4A@DM6PR13MB3705.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR13MB3705D3EAE5FEF8D3B6902146FCB4A@DM6PR13MB3705.namprd13.prod.outlook.com>

On Mon, Nov 20, 2023 at 10:18:13AM +0000, Yinjun Zhang wrote:
> On Monday, November 20, 2023 5:43 PM, Simon Horman wrote:
> <...>
> > > +     case TCP_V6_FLOW:
> > > +     case UDP_V6_FLOW:
> > > +     case SCTP_V6_FLOW:
> > > +             for (i = 0; i < 4; i++) {
> > > +                     fs->h_u.tcp_ip6_spec.ip6src[i] = entry->key.sip6[i];
> > > +                     fs->h_u.tcp_ip6_spec.ip6dst[i] = entry->key.dip6[i];
> > > +                     fs->m_u.tcp_ip6_spec.ip6src[i] = entry->msk.sip6[i];
> > > +                     fs->m_u.tcp_ip6_spec.ip6dst[i] = entry->msk.dip6[i];
> > > +             }
> > 
> > I think the above loop can be more succinctly be expressed using a single
> > memcpy(). For which I do see precedence in Intel drivers. Likewise
> > elsewhere in this patch-set.
> > 
> > I don't feel strongly about this, so feel free to take this suggestion,
> > defer it to later, or dismiss it entirely.
> 
> Thanks Simon. Louis did have same suggestion about this part. But
> since we have similar code below:
> ```
> for (i = 0; i < 4; i++) {
> 	entry->msk.sip6[i] = fs->m_u.tcp_ip6_spec.ip6src[i];
> 	entry->msk.dip6[i] = fs->m_u.tcp_ip6_spec.ip6dst[i];
> 	entry->key.sip6[i] = fs->h_u.tcp_ip6_spec.ip6src[i] & entry->msk.sip6[i];
> 	entry->key.dip6[i] = fs->h_u.tcp_ip6_spec.ip6dst[i] & entry->msk.dip6[i];
> }
> ```
> which can not be replaced by `memcpy`, so I decided to leave them as
> they are to keep consistency.
> So if you don't feel strongly and nobody else objects it, I'll leave it.

Hi Yinjun,

thanks for the clarification. I agree that we can leave this
if nobody else objects.

> 
> > 
> > > +             fs->h_u.tcp_ip6_spec.psrc = entry->key.sport;
> > > +             fs->h_u.tcp_ip6_spec.pdst = entry->key.dport;
> > > +             fs->m_u.tcp_ip6_spec.psrc = entry->msk.sport;
> > > +             fs->m_u.tcp_ip6_spec.pdst = entry->msk.dport;
> > > +             break;
> > 
> > ...

