Return-Path: <netdev+bounces-172531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE490A5531D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006293A9924
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037825C6F3;
	Thu,  6 Mar 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/cqQae+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AB25BAC4
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282307; cv=none; b=X7fuvZqBg9Y2YSg37n+22vCkb/kT2FW+vhCG1defosYu5AluYligEFZuyXZJkbpTlq7q+hGHLiyDSKCS8mZuLqExmsJzSXHDcnEKkmS9teJUvYvSpyRAko/lX+/DH+NFWWVAALD0MzWeHCptKNmVuXG5PVvNcjKY2kafFTjjfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282307; c=relaxed/simple;
	bh=aB2RV4WgY/SUY7OUaVz5CR/iQh4JDjDr+dcgUFhSTjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz9TyhTs60j1jXFg9JpSCIPVRufC5MEtuGzl1wJSLlTh0rz4y4JdCkwVbXCyOvrqUc5qMK77z7H6GDAc5JM6BIIWMtpU7FNjkebkm5VGByODqtOMF1mV9lFs+nOB2AZLUvVs2+XItCbwVQuPzRlxp7SQCadG6k4TG9eQBDN+t40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/cqQae+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C76C4CEE0;
	Thu,  6 Mar 2025 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741282307;
	bh=aB2RV4WgY/SUY7OUaVz5CR/iQh4JDjDr+dcgUFhSTjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/cqQae+iuznvDHvnzWEuw8EPPoMlDDeOQjFLxPfv2fxAERIgR4oRC6xXBjRn/El5
	 zJsctGmg99uPqYG8PhRoDDZyhyEp2NjREg5H+zoIrTmZV441D0OOrEhA5EF20hhd1j
	 tYtmncp7wdio5/KN5z+1+X/yrdkcctPG/2QNJN21o+Vg+249ZGzNHBnXBNvi8KdWBe
	 FVmkh7xg+02RCxQt80Gj29PxygV083LFjEQ4Q25TdihYgq5rPQPjXk7Jml8B9RaKb9
	 jnkM2p4+4LAotyW3JUxI9Us2Qs8RuwAjUoyyN7LgboXRTDZ9OXXN+50pe3Y9TeHRmY
	 YjrLb71AF5rSA==
Date: Thu, 6 Mar 2025 19:31:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, David Arinzon <darinzon@amazon.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 4/5] net: ena: PHC stats through sysfs
Message-ID: <20250306173142.GU1955273@unreal>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-5-darinzon@amazon.com>
 <21fe01f0-7882-46b8-8e7c-8884f4e803f6@lunn.ch>
 <20250304145857.61a3bd6e@kernel.org>
 <89b4ceae-c2c8-4a7b-9f1b-39b6bce17d34@lunn.ch>
 <20250305183637.2e0f6a9f@kernel.org>
 <ed0fb5d8-5cd7-446a-9637-493224af4fb3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0fb5d8-5cd7-446a-9637-493224af4fb3@lunn.ch>

On Thu, Mar 06, 2025 at 04:40:55PM +0100, Andrew Lunn wrote:
> On Wed, Mar 05, 2025 at 06:36:37PM -0800, Jakub Kicinski wrote:
> > On Wed, 5 Mar 2025 16:33:10 +0100 Andrew Lunn wrote:
> > > > I asked them to do this.
> > > > They are using a PTP device as a pure clock. The netdev doesn't support
> > > > any HW timestamping, so none of the stats are related to packets.  
> > > 
> > > So how intertwined is the PHC with the network device? Can it be
> > > separated into a different driver? Moved into drivers/ptp?
> > > 
> > > We have already been asked if this means network drivers can be
> > > configured via sysfs. Clearly we don't want that, so we want to get
> > > this code out of drivers/net if possible.
> > 
> > Is it good enough to move the relevant code to a ptp/ or phc/ dir
> > under ...thernet/amazon/ena/ ? Moving it to ptp/ proper would require
> > some weird abstractions, not sure if it's warranted? 
> 
> mtd devices have been doing this for decades. And the auxiliary bus
> seems to be a reinvention of the mtd concepts.

No, it is not. MTD concepts are no different from standard
register_to_other_subsystem practice, where driver stays in
one subsystem to be used by another.

Auxillary bus is different in that it splits drivers to their logical
parts and places them in right subsystems.

Thanks

