Return-Path: <netdev+bounces-128047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF627977A1E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843B41F2797D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4121E1D54E5;
	Fri, 13 Sep 2024 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoWxUrnX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161281BDAA7;
	Fri, 13 Sep 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213409; cv=none; b=RKk0DC15qV7M0mtJKUukJctl5pENgB0m38roMrqY69oy8H5w+T8/LMJ7zgoDZ9gkF1NEvbV2C5J3GbWHXsV7zENqoq1wx4ctBWeRT/8gt0xWFPM1nVxIZs1ydDSO8p/RRB1qNJXQtdf35mJ/Qc4LvwOucjdNRBCdUPkofH3RokY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213409; c=relaxed/simple;
	bh=kwzdX+8F7dVZ3+T9RXxURmOh+xGEJSRS6RIzA7Wna7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrANwNdP5P250Il4TU1t6ecWJaEzgbg6HCg9aXrBs7L9r4OKDVYrLPd+fFaJoYG4GZwytP+RaZXTTMwbNWmj8gIgOpSkT9K3T86ZSvcNHubG8gGLbpZrLz4oA/tWPviyTu/SOfuDLF4p0kIGRQiyWoMOc2+vvvDklYeprpQYGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoWxUrnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9C7C4CECC;
	Fri, 13 Sep 2024 07:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726213408;
	bh=kwzdX+8F7dVZ3+T9RXxURmOh+xGEJSRS6RIzA7Wna7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoWxUrnXrzn3U/spGO0uvUs+CynPY+zyG2UkU7vHSUI2KEEGgvWahTxE3NFeFRQjv
	 PBQs45DqyDoKMRP1n4XXy9xmCcnfE/VJl2qqx2MwigV7ub98MkjnBEa2/Y+3d1zZeo
	 TDLDTKD5A8njD2PwM6z/D5Fcd38fG9rlSsmuscS1//LxwqZ4gq0w/1+xJuvjCcozPR
	 a3wMyXnq6+Mn3UxkRE/v/hnnZUsRFHa4arKLYxCaPN2qKyRzzvpzem8Ojfe/a+sEKg
	 bK/LrB5D786DwT2W6dKKpUYuDnml644KO/XpFD6mpqiVoLp/pwk0KDBb8bpz1e6cIY
	 0JOTJTneAhpqA==
Date: Fri, 13 Sep 2024 08:43:24 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] caif: replace deprecated strncpy with strscpy_pad
Message-ID: <20240913074324.GA1132019@kernel.org>
References: <20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com>
 <20240910093751.GA572255@kernel.org>
 <CAFhGd8qQ_e_rh1xQqAnaAZmA7R+ftRGjprxGp+njoqg_FGMCSw@mail.gmail.com>
 <CAFhGd8r2PO9qLej9okVpwcfL2Kz5oCahdnzEVRpCJVm+b5g-Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8r2PO9qLej9okVpwcfL2Kz5oCahdnzEVRpCJVm+b5g-Bw@mail.gmail.com>

On Thu, Sep 12, 2024 at 01:47:22PM -0700, Justin Stitt wrote:
> On Thu, Sep 12, 2024 at 1:43 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > Hi,
> >
> > On Tue, Sep 10, 2024 at 2:37 AM Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Mon, Sep 09, 2024 at 04:39:28PM -0700, Justin Stitt wrote:
> > > > strncpy() is deprecated for use on NUL-terminated destination strings [1] and
> > > > as such we should prefer more robust and less ambiguous string interfaces.
> > > >
> > > > Towards the goal of [2], replace strncpy() with an alternative that
> > > > guarantees NUL-termination and NUL-padding for the destination buffer.
> > >
> > > Hi Justin,
> > >
> > > I am curious to know why the _pad variant was chosen.
> >
> > I chose the _pad variant as it matches the behavior of strncpy in this
> > context, ensuring minimal functional change. I think the point you're
> > trying to get at is that the net_device should be zero allocated to
> > begin with -- rendering all thus NUL-padding superfluous. I have some
> > questions out of curiosity: 1) do all control paths leading here
> > zero-allocate the net_device struct? and 2) does it matter that this
> > private data be NUL-padded (I assume not).
> >
> > With all that being said, I'd be happy to send a v2 using the regular
> > strscpy variant if needed.
> 
> I just saw [1] so let's go with that, obviously.

Hi Justin,

Yes, right, let's go with that.

But as I asked some questions, and you provided your own, let me see if I
can respond appropriately as although the answers are specific to this
patch the questions seem more generally applicable.

1) It seems to me that the priv data is allocated by alloc_netdev_mqs()
   which makes the allocation using kvzalloc(). So I believe the answer
   is that the allocation of name is zeroed.

   My analysis is based on ops->priv_size being passed
   to rtnl_create_link() by rtnl_create_link().

   And ops being registered using rtnl_link_register()
   by chnl_init_module().

   Of course, I could be missing something here.

2) Regarding a requirement to NUL-pad. FWIIW, this is what I had in mind
   when I asked my question. But perhaps given 1) it is moot.

   In any event we now know, thanks to Jakub's investigation [1],
   that the answer must be no. For the trivial reason that name isn't used.

