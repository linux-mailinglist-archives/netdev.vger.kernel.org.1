Return-Path: <netdev+bounces-94728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04FC8C0681
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 23:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972051F229D3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7750C1E89A;
	Wed,  8 May 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TheGFhq9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9F82862
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204870; cv=none; b=jrj1bzF1P/pp9U+BDxfz9eYtNgV7bi+5VGR3EGsRYg5j/mgBLBQo+XPpad0ugew4Pn2W4x1cymV4+/163Yc8kDy//7iLPw7+8UEdpOPGlaATEr8TloDFSmImV6qpPwJ0pAYQ7QzEO3rh3ODo0PepL5tYVEB8KV1gEwv4XZ+czkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204870; c=relaxed/simple;
	bh=1KSEK5ofZFmqJVYMnW8dKM15dLH3QnE/lvqwfXKggRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKzEDrjHI5QmcoR+kQUeMFl9vKGhmgjATxalLuHByZI+1MLtjEN2DpZXCxQmERRWJqy31IuBphOoOQt+E2laFekudfWwSmw3q+jp3wjTtFQgxELrF8LaVFhiu1lUpjMOZkRqB6X2/GA+dchiViCV9zINflIw5E9UnY70D+/enac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TheGFhq9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4yWirW6JeFbhnrmEYG9LLk3tLKZaooe0OScOOv0HpEY=; b=TheGFhq9JoAqhrHsOnGwLlfPFG
	oGn8Nr8uUo2SOBQuKxgoxFYd2DNQTF1LezbvN6uYvPK27zolP1OiR93H+V1IetjFOjiJt/YXr3MpC
	BlDrpk5+OladozYAQHK6LCXUhK2ERhCL7W08FQ0q4AX2SHGBzYq1ypARXWI8JBOqh1EE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4p8Z-00EzZk-Cl; Wed, 08 May 2024 23:47:43 +0200
Date: Wed, 8 May 2024 23:47:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>

Hi Paolo

> + * struct net_shaper_info - represents a shaping node on the NIC H/W
> + * @metric: Specify if the bw limits refers to PPS or BPS
> + * @bw_min: Minimum guaranteed rate for this shaper
> + * @bw_max: Maximum peak bw allowed for this shaper
> + * @burst: Maximum burst for the peek rate of this shaper
> + * @priority: Scheduling priority for this shaper
> + * @weight: Scheduling weight for this shaper
> + */
> +struct net_shaper_info {
> +	enum net_shaper_metric metric;
> +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
> +	u64 bw_max;	/* maximum allowed bandwidth */
> +	u32 burst;	/* maximum burst in bytes for bw_max */
> +	u32 priority;	/* scheduling strict priority */

Above it say priority. Here is strict priority? Is there a difference?

> +	u32 weight;	/* scheduling WRR weight*/
> +};

Are there any special semantics for weight? Looking at the hardware i
have, which has 8 queues for a switch port, i can either set it to
strict priority, meaning queue 7 needs to be empty before it look at
queue 6, and it will only look at queue 5 when 6 is empty etc. Or i
can set weights per queue. How would i expect strict priority?

Shaping itself is not performed on the queues, but the port. So it
seems like i should create 8 net_shaper_info and set the weight in
each, and everything else to 0? And then create a queue group shaper,
put the 8 queue shapers into it, and then configure bw_max for the
group? Everything else is 0, because that is all i can configure.

Does this sound correct?

> + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
> + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.

Are they also available on plain boring devices which don't have PFs
or VFs?

Would i be correct in assuming my driver should just create these
shapers. There will be some netlink calls to allow user space to
enumerate them, and display the relationships between them? And
netlink calls to set values in a shaper? Will there be a way to say
which fields are actually settable, since i doubt most hardware will
have everything? In my case, only one field appears to be relevant in
each shaper, and maybe we want to give a hint about that to userspace?

	Andrew

