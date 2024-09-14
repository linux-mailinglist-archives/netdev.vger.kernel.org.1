Return-Path: <netdev+bounces-128321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C81D978F84
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF331280FC5
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E5190675;
	Sat, 14 Sep 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsRQd2N6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BF4C96;
	Sat, 14 Sep 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306418; cv=none; b=gel0CIwmu17bIefGxOdlkyvyyQ93zjMXTehX9e1yCBbj1Q2PCUvtmANBg1bdkcZ88Vj4KkWYVrgvuVZgstz2MbqAX/Obn4nUoc/T8MhQrPUQJ1DehEnW9BY03XaaE7QjbnjBzVT2JyKF5YR6Ofpy0cJxl5+sf4bUBlWBF6TLHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306418; c=relaxed/simple;
	bh=nQRB/xQIvJ1bgGtNoT8OhaPo1rcY6M1rP6+zreCpKxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a15VUh9qQlF23nyCt+v3Es5I6CmK8CPowLEY+3IESvtF666rTiN6R0NRJQd44cqgLpNEbmS+Vl5tC1d1/JemHCQwWyu5xwAzOlpiiWeoYIkFMpg+gm/bhkzpOkpFsHOYmXv38JemOGTqPu9jBvucWo7KElFni9I0bY8kiCypGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsRQd2N6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4527C4CEC0;
	Sat, 14 Sep 2024 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726306418;
	bh=nQRB/xQIvJ1bgGtNoT8OhaPo1rcY6M1rP6+zreCpKxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsRQd2N607BnIS7paXwDzUXTgUMDVtnWfxNxNsbBftyv0aCew9kY27S0ULzEnvoLe
	 suFazOvcb7wSrKyUT0kia6V66nOoZHJMABo2nEk/++Ap92FQgqxpRL9rQ7+wp06UWP
	 ppOzOjehFChZFHLa2P0OWLDmxjJUTwVCZBfymn16WDml8jHlIh8ubqHZgrFhmZhZHG
	 NcSrqp/ecRdvnwBRJw19ed2f89BrIuq7XlQqSXvN5Ea0TvnCKEm4feDphkW4NfIGMl
	 mSZjDSD1Uu/RFTmbanxSQPe2e5IYF2XdVYefc9PY7G6kdyftymwPuOTNrlYVLJ7rhW
	 mH25n/9uuc1EA==
Date: Sat, 14 Sep 2024 10:33:32 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 06/12] net: vxlan: make vxlan_snoop() return
 drop reasons
Message-ID: <20240914093332.GF12935@kernel.org>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
 <20240909071652.3349294-7-dongml2@chinatelecom.cn>
 <ZuFP9EAu4MxlY7k0@shredder.lan>
 <CADxym3ZUx7v38YU6DpAxLU_PSOqHTpvz3qyvE4B3UhSHR2K67w@mail.gmail.com>
 <CADxym3ZriQCvHcJjCniJHxXFRo_VnVXg-dheym9UYSM-S=euBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADxym3ZriQCvHcJjCniJHxXFRo_VnVXg-dheym9UYSM-S=euBg@mail.gmail.com>

On Fri, Sep 13, 2024 at 05:13:41PM +0800, Menglong Dong wrote:
> On Thu, Sep 12, 2024 at 10:30 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
> >
> > On Wed, Sep 11, 2024 at 4:08 PM Ido Schimmel <idosch@nvidia.com> wrote:
> > >
> > > On Mon, Sep 09, 2024 at 03:16:46PM +0800, Menglong Dong wrote:
> > > > @@ -1447,7 +1448,7 @@ static bool vxlan_snoop(struct net_device *dev,
> > > >
> > > >       /* Ignore packets from invalid src-address */
> > > >       if (!is_valid_ether_addr(src_mac))
> > > > -             return true;
> > > > +             return SKB_DROP_REASON_VXLAN_INVALID_SMAC;
> > >
> > > [...]
> > >
> > > > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> > > > index 98259d2b3e92..1b9ec4a49c38 100644
> > > > --- a/include/net/dropreason-core.h
> > > > +++ b/include/net/dropreason-core.h
> > > > @@ -94,6 +94,8 @@
> > > >       FN(TC_RECLASSIFY_LOOP)          \
> > > >       FN(VXLAN_INVALID_HDR)           \
> > > >       FN(VXLAN_VNI_NOT_FOUND)         \
> > > > +     FN(VXLAN_INVALID_SMAC)          \
> > >
> > > Since this is now part of the core reasons, why not name it
> > > "INVALID_SMAC" so that it could be reused outside of the VXLAN driver?
> > > For example, the bridge driver has the exact same check in its receive
> > > path (see br_handle_frame()).
> > >
> >
> > Yeah, I checked the br_handle_frame() and it indeed does
> > the same check.
> >
> > I'll rename it to INVALID_SMAC for general usage.
> >
> 
> Hello, does anyone have more comments on this series before I
> send the next version?

Hi,

As you may have noted after posting the above,
net-next is now closed until after v6.12-rc1 has been released.
So, most likely, you will need to hold of on posting v4 until then.

