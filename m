Return-Path: <netdev+bounces-198444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39615ADC2C2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D1318916C5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F612236A8B;
	Tue, 17 Jun 2025 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ5CxfCX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8033C01
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750143653; cv=none; b=S1LVSKQQaR5UyUrlCTgwyEEN2HGnRLT6a1A1DqOP01xw4kUh1bjHmo0wPOE7UACSxMokBJD5+Lm8mWsfUwkfsT6BXqNUuA1yriWE4zCVhZyXCJl+LirRJStHLW2xbxE/U/VezjVfegu24DoITzuqvGsXesGMKVKQgVYkLihlnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750143653; c=relaxed/simple;
	bh=NcwBh6EnekHcip7sx/0f94JunjhSmAdwjt/WnP1X8mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1rYchFWlP5dG5CvRcMHry6oFQdgaRXY+z3V2NoeU8rVpgTOMhyTe53Kk3o6ZfGWfhfqzejEheUgna291Te/JC0ZxVXBakjGr1QG97KvO17a1ZOFgB6lAQA5pmu8rM/mb5ArhLwK3htBHZKoIKPqLXdZHJ2K3pBpaPpgRYnBq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ5CxfCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72154C4CEE3;
	Tue, 17 Jun 2025 07:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750143652;
	bh=NcwBh6EnekHcip7sx/0f94JunjhSmAdwjt/WnP1X8mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJ5CxfCXEc+7PMKfh7lTABYWzG0J/7eQgxc/g1FXaQpHbfgoCFNLMiU535FKonCvU
	 KlisFU+jQ0nQ7uSvlBW1vQCUlUL0sqTmgrS1KSgaziMWtmkDvd/nnQGL/lP2c2HI0X
	 6I19RL3trLQb1wD16DPGyhK8S9U0+o89xaEBg1qnCHTiUcZ79TLVCMSkdmpsu0I627
	 2bjv4bw5VuSOSPmV/p4Wut3kknpGcLVyIieUuPfPzwMDwEUZdMFF67bjU9MEhXNQZb
	 cZj0+zwBlLkZHFd8vj31j5OWPxFhOSZRTAIcrN8fvhqZdZ4ggG5c5iUp2R6TDgMiuv
	 Bge4iZk+h8eZQ==
Date: Tue, 17 Jun 2025 08:00:48 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, kernel-team@meta.com, edumazet@google.com
Subject: Re: [net-next PATCH v2 3/6] fbnic: Replace 'link_mode' with 'aui'
Message-ID: <20250617070048.GD5000@horms.kernel.org>
References: <174974059576.3327565.11541374883434516600.stgit@ahduyck-xeon-server.home.arpa>
 <174974092054.3327565.9587401305919779622.stgit@ahduyck-xeon-server.home.arpa>
 <20250616153438.GE6918@horms.kernel.org>
 <CAKgT0UfEkGiAu2mO15yaF1HRdRLsercm4vJsyi-xg8Je0c_i5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UfEkGiAu2mO15yaF1HRdRLsercm4vJsyi-xg8Je0c_i5A@mail.gmail.com>

On Mon, Jun 16, 2025 at 09:14:33AM -0700, Alexander Duyck wrote:
> On Mon, Jun 16, 2025 at 8:34 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Jun 12, 2025 at 08:08:40AM -0700, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexanderduyck@fb.com>
> > >
> > > The way we were using "link_mode" really was more to describe the
> > > interface between the attachment unit interface(s) we were using on the
> > > device. Specifically the AUI is describing the modulation and the number of
> > > lanes we are using. So we can simplify this by replacing link_mode with
> > > aui.
> > >
> > > In addition this change makes it so that the enum we use for the FW values
> > > represents actual link modes that will be normally advertised by a link
> > > partner. The general idea is to look at using this to populate
> > > lp_advertising in the future so that we don't have to force the value and
> > > can instead default to autoneg allowing the user to change it should they
> > > want to force the link down or are doing some sort of manufacturing test
> > > with a loopback plug.
> > >
> > > Lastly we make the transition from fw_settings to aui/fec a one time thing
> > > during phylink_init. The general idea is when we start phylink we should no
> > > longer update the setting based on the FW and instead only allow the user
> > > to provide the settings.
> > >
> > > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> >
> > Hi Alexander,
> >
> > This patch is doing a lot - I count 3 things.
> > Could you try and break it up a bit in v3?
> 
> Actually I need to clean this up a bit more anyway. Looks like I have
> some text from the earlier version still here as the last item was
> moved to patch 4 I believe.
> 
> Since it is mostly just renames anyway, splitting it up should be
> pretty straight forward.

Thanks, I think that would help (me) a lot.

