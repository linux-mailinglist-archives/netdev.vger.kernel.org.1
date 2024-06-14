Return-Path: <netdev+bounces-103665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA0F908FBC
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C2D1F22B50
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6476916B751;
	Fri, 14 Jun 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahZf/ccb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD476CDB3;
	Fri, 14 Jun 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381496; cv=none; b=SNSoJO/g0GpfBJaMp+kWnKJ1teOiihtZhBCjkZdbE2yPITfWLvtkrJNK7QCbcrIOGjX1g75eYSQ+CMkZTJt6jgg/N+rTdsAOn/MbNyv+oLZKDiBBFdrFRALJeU5LRhcN937rYPVhJ7QTmYVpfTiTAQj7QJsJdxFzAlVhbFjZAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381496; c=relaxed/simple;
	bh=Y11qylTcMXSe5/oFaWd9ccqY6xOb5K0E3H4fKo7i4BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtZ9Rri9KU1FRgnk4BxSTGpvWyKKmEz+BaBZpxH0pZL1zWqMGTkWO+aCsAiqk5YA2M+XtTM6UgVB7rEa4XTZfon9IMfK3UdDxEbSwjbE9TuraeD0yaYkWqMBFBZe10EtzRIMNHX/9+8CBNOASBxE/Rv4UMSfNNB6f4KXmYbuS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahZf/ccb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C8BC2BD10;
	Fri, 14 Jun 2024 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381495;
	bh=Y11qylTcMXSe5/oFaWd9ccqY6xOb5K0E3H4fKo7i4BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahZf/ccbbybr/r4coTPcq6i/A1fbSnqQStKe6wZV4Vky54gDKsFaQLAEvkkFxfYFM
	 0k1G6/MMuDwlzCUZlVWwwoty7pko2YHa67rXZkgcbzTy93RclN0UjNtRibEB/V+kgL
	 8pjLcLpI4zC59jAgbxkrs1FK0SSbcjfoiKGaT3eRCINmQtR2k4PrTdzZoU3T1/v1XF
	 tGs6Nu1FfbtRww5MkPg5plsgno8PI1tTK5mffvJAyNDm2nCgrE/xUQGZLSlg50e+Mh
	 u/PaDaYwV8qI/U4fdcOmLz5nqrc2wmPg5Dm4ZCaAJ3VD5RlhIpYdOxJg9vLcl0T9FB
	 AGpKk2cPkKTqg==
Date: Fri, 14 Jun 2024 17:11:30 +0100
From: Simon Horman <horms@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, dev@openvswitch.org,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/9] net: psample: allow using rate as
 probability
Message-ID: <20240614161130.GP8447@kernel.org>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-5-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-5-amorenoz@redhat.com>

On Mon, Jun 03, 2024 at 08:56:38PM +0200, Adrian Moreno wrote:
> Although not explicitly documented in the psample module itself, the
> definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
> 
> Quoting tc-sample(8):
> "RATE of 100 will lead to an average of one sampled packet out of every
> 100 observed."
> 
> With this semantics, the rates that we can express with an unsigned
> 32-bits number are very unevenly distributed and concentrated towards
> "sampling few packets".
> For example, we can express a probability of 2.32E-8% but we
> cannot express anything between 100% and 50%.
> 
> For sampling applications that are capable of sampling a decent
> amount of packets, this sampling rate semantics is not very useful.
> 
> Add a new flag to the uAPI that indicates that the sampling rate is
> expressed in scaled probability, this is:
> - 0 is 0% probability, no packets get sampled.
> - U32_MAX is 100% probability, all packets get sampled.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Hi Adrian,

Would it be possible to add appropriate documentation for
rate - both the original ratio variant, and the new probability
variant - somewhere?

That aside, this looks good to me.

...

