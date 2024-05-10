Return-Path: <netdev+bounces-95469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5B8C2551
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA0B282501
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE38512C47D;
	Fri, 10 May 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z68fIlci"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9712C472;
	Fri, 10 May 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345946; cv=none; b=nh/VGimPxFZVoxUvJqh/0YviqpQrCMmqMHr/Sj2V5t3yfonPiEO42bXSm4M1FKPBE9b0uXxpCOlcj26IlDpHi+TRKwEl2vOZQOSr59+vMYxAUNY85Pc5TCCfHY5s1ZhEksDWmvYiod+yRSWePACXV54SxLE/LrB4Mf94FcEB/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345946; c=relaxed/simple;
	bh=eeNPiBqOsv0YXM+GYDp3/PEiHFlAYLDNqJMQRBIXGGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzAvJ4pTlAiDIcsQW2LoPS8ixPkkxkcES53cuqsy3A4ymoScAqUPmLzQUCmy8PEP8W20apg1sK2UQOJS1/YAoktTipcUqkBd/hvQ8nV2WktX1lAhI6StZ3shH+4bYt2AwcgfX/mqF91dCLAkTWYrA99cte+8MljUrc3mv2t1tIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z68fIlci; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ywoEF1e3a3leDTOvzrIvYVZ/Ez+WjZjfnXDQ3Chcg+U=; b=Z68fIlciOjIvb5a8uvzHT7QMHX
	1jSmk+85Zpt/852vCyLAnys9f9K9Q3DC/bveqtASNF9PgPdOoHAdbPWtLcK+ucSfiW9vsDUtvzbQh
	iB/67qoontCvdODViBFuphpJuUCkhLNMXYCW731wWh6pVUmiNTKkF2BVmOlKo+WPKGP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5Ppz-00F8Z4-Pe; Fri, 10 May 2024 14:58:59 +0200
Date: Fri, 10 May 2024 14:58:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Jurgens <danielj@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and wake
Message-ID: <26e8aa14-b159-4a3c-ab67-bec41f15f7c6@lunn.ch>
References: <20240509163216.108665-1-danielj@nvidia.com>
 <20240509163216.108665-2-danielj@nvidia.com>
 <1b16210a-c0dd-4b79-88ac-d7cec2381e11@lunn.ch>
 <CH0PR12MB85808FC72B8F48C3F6BF3A9DC9E62@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR12MB85808FC72B8F48C3F6BF3A9DC9E62@CH0PR12MB8580.namprd12.prod.outlook.com>

On Thu, May 09, 2024 at 09:19:52PM +0000, Dan Jurgens wrote:
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Thursday, May 9, 2024 3:47 PM
> > To: Dan Jurgens <danielj@nvidia.com>
> > Subject: Re: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and
> > wake
> > 
> > On Thu, May 09, 2024 at 11:32:15AM -0500, Daniel Jurgens wrote:
> > > TX queue stop and wake are counted by some drivers.
> > > Support reporting these via netdev-genl queue stats.
> > >
> > > +        name: tx-wake
> > > +        doc: |
> > > +          Number of times the tx queue was restarted.
> > > +        type: uint
> > 
> > I'm curious where these names came from. The opposite of stop would be
> > start. The opposite of wake would be sleep. Are these meant to be
> > opposites of each other? If they are opposites, why would they differ by
> > more than 1? And if they can only differ by 1, why do we need both?
> 
> The names come from the API. netif_tx_stop_queue, netif_tx_wake_queue.

O.K. So in that context, these names make sense. Maybe extend the doc:
to mention these function names?

You say there are a few drivers with these counters? Does it make
sense to actually push the increment into netif_tx_stop_queue(),
netif_tx_wake_queue() so that they become available for all drivers?
I've no idea what that implies...

	Andrew

