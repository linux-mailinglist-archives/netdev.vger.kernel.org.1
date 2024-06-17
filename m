Return-Path: <netdev+bounces-103983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3391690AB15
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5380281885
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE9B19414D;
	Mon, 17 Jun 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1WvYIdz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D991940B1;
	Mon, 17 Jun 2024 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620223; cv=none; b=B1RxyuHAdVx3F86Nm/gI+twAp061FPN7m4RsxS6Je/1sQVN7POteLuB8Kb8EnX9Yx7WYHqBv3hXDqs8ggDqu44o6zr8Crz89ca13vn2ysgty1J/iY4QZRcHdLCX9izWnQ5QDVZMhATcV7G0tGep7MdjulOfXnFiJBeB3ts7CmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620223; c=relaxed/simple;
	bh=legsQcTjmGF/ESY3infoB6MxTfUlzmDtnEkbU9JhtHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkuRPvNDqpadylIQKihIeCHcsR2/aJX3Syljz8MNAifhlOQNPM0+OPjbf43iy6E69KpUGTLZylOwqxq0WGfkTQHj23VG5ynYtCeQUegSgloX75mpLGsjga83BIM5OAuNuOlR5cyq6mYKWcO5oplpVahZW24A7wU7pO5kWcjqBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1WvYIdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AFDC2BD10;
	Mon, 17 Jun 2024 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718620222;
	bh=legsQcTjmGF/ESY3infoB6MxTfUlzmDtnEkbU9JhtHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1WvYIdzflRbJsCA4eyWA1W0k8ZjQtxt26fBxqoFgqg8+M0NI3d/OytudixcKoBX7
	 l8zMN2cSJlIGP5Hmspyi/VswwFsMSYrVMTW8bVY9nArK0uVXSe0knEim+WnidIVNfi
	 gOHAuegd6Fqcl3CiZs5oL6HrsE0HsxrgQ/OC6NnHaiydm7eHuTvHpB2WVSc505FMGr
	 7WaqHIYhF7sg1Sn8F+SDqZI2dPvhvHwwNfMMG3toJEz0OWvVhfT7q9mCJ2HAGMkVQw
	 D7Ap7Ifh6sQRpVAlGURNYpPmjuwIMJQC9Q52cOdXp7QpoEW8QcoigqemjsdLoJ44Os
	 NyJ2xCxlMPH7Q==
Date: Mon, 17 Jun 2024 11:30:17 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
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
Message-ID: <20240617103017.GP8447@kernel.org>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-5-amorenoz@redhat.com>
 <20240614161130.GP8447@kernel.org>
 <CAG=2xmOhMMg8JDVi4x5P5F39yfG2p72kyYxDud0fcjc9VzDeLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=2xmOhMMg8JDVi4x5P5F39yfG2p72kyYxDud0fcjc9VzDeLA@mail.gmail.com>

On Mon, Jun 17, 2024 at 06:32:14AM +0000, Adrián Moreno wrote:
> On Fri, Jun 14, 2024 at 05:11:30PM GMT, Simon Horman wrote:
> > On Mon, Jun 03, 2024 at 08:56:38PM +0200, Adrian Moreno wrote:
> > > Although not explicitly documented in the psample module itself, the
> > > definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
> > >
> > > Quoting tc-sample(8):
> > > "RATE of 100 will lead to an average of one sampled packet out of every
> > > 100 observed."
> > >
> > > With this semantics, the rates that we can express with an unsigned
> > > 32-bits number are very unevenly distributed and concentrated towards
> > > "sampling few packets".
> > > For example, we can express a probability of 2.32E-8% but we
> > > cannot express anything between 100% and 50%.
> > >
> > > For sampling applications that are capable of sampling a decent
> > > amount of packets, this sampling rate semantics is not very useful.
> > >
> > > Add a new flag to the uAPI that indicates that the sampling rate is
> > > expressed in scaled probability, this is:
> > > - 0 is 0% probability, no packets get sampled.
> > > - U32_MAX is 100% probability, all packets get sampled.
> > >
> > > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> >
> > Hi Adrian,
> >
> > Would it be possible to add appropriate documentation for
> > rate - both the original ratio variant, and the new probability
> > variant - somewhere?
> >
> 
> Hi Simon, thanks for the suggestion. Would the uapi header be a good
> place for such documentation?

Hi Adrian,

I didn't look closely, but that does sound like a good place to me.

