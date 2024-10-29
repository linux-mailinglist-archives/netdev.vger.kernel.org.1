Return-Path: <netdev+bounces-140079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EE09B5304
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413AC1F23BE5
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBF42076D4;
	Tue, 29 Oct 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp5AxGKa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D62076CA;
	Tue, 29 Oct 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232039; cv=none; b=ksh48eXD1hVfmui9Y30BQrcDHJmsZiYTC6jJsi2VkVbmn9ZlAbpkrmytYgH9YEVuNqcEWzsuPctDBhMYY0hiGhyj6p5oa9UJzoalfOcTor8WlemiMajZfCEjM08MhIi3ugXq1LY2SWo6mSFMZNMChqk7RubkSuL6LVOSC+iZj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232039; c=relaxed/simple;
	bh=pKypalYakTpPySQDkMJhREf+MBtrrJGMKov0teHbvtk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2QhVqSQ3Ch/GfNId1lSvaNisWokRPC6DRNEiiU4MlnXLMnCMljIIVQQxPaRe0TIbESaT5HsGr+QhEuQhVNjjrOyCowOtRe09b7InjzcM5PiyJEq3ES2/bOZgJp57IVbXbvxzHSAtYc/IWRdG8dkByvyJLEedVSx0AYVrjc2+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp5AxGKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4D0C4CECD;
	Tue, 29 Oct 2024 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730232038;
	bh=pKypalYakTpPySQDkMJhREf+MBtrrJGMKov0teHbvtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dp5AxGKaXzmIiJStJRelad+pUYQm4KxqYN4SrWpWXLi6ZuKnGyPo/mQQHUzyqglgb
	 MhPQZKdDI7Vefl+hJRMia9y41Cn2cBCn9hJljRLpZN7xxPNuMRyCCQ/ibQqKc9JQqw
	 heYtqN02nBBCPRSiQ/fLrKbx8FGhj50C1psB1jvB0XP2tP0VF74r6nmsNYLclqxBnh
	 +UMDt7yg2ztjfrFdzV6z9iRpaQtnlMVFIhaPEJdwDMo9Om5FO7iPQR0K2DHXdMn7qZ
	 4GoN/Rxv6TZYDLgxRufzGvubwKekxoWRk8+pv7yt+7MqkRaTHUGLt2vrFwdCGZhjuy
	 bhPnHO+3sfgdQ==
Date: Tue, 29 Oct 2024 13:00:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241029130037.2c7e96c7@kernel.org>
In-Reply-To: <5aa93a65-e325-4c77-aaa8-5ef04f3b9697@embeddedor.com>
References: <cover.1729536776.git.gustavoars@kernel.org>
	<f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org>
	<20241029065824.670f14fc@kernel.org>
	<f6c90a57-0cd6-4e26-9250-8a63d043e252@embeddedor.com>
	<20241029110845.0f9bb1cc@kernel.org>
	<7d227ced-0202-4f6e-9bc5-c2411d8224be@embeddedor.com>
	<20241029113955.145d2a2f@kernel.org>
	<26d37815-c652-418c-99b0-9d3e6ab78893@embeddedor.com>
	<20241029115426.3b0fcaff@kernel.org>
	<5aa93a65-e325-4c77-aaa8-5ef04f3b9697@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 13:18:56 -0600 Gustavo A. R. Silva wrote:
> By priority I mean if preserving the reverse xmas tree is a most
> after any changes that mess in some way with it. As in the case below,
> where things were already messed up:
> 
> +       const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
>          struct bnxt *bp = netdev_priv(dev);
>          struct bnxt_link_info *link_info = &bp->link_info;
> -       const struct ethtool_link_settings *base = &lk_ksettings->base;
>          bool set_pause = false;
>          u32 speed, lanes = 0;
>          int rc = 0;
> 
> Should I leave the rest as-is, or should I now have to rearrange the whole
> thing to accommodate for the convention?

Don't rearrange the rest. The point is that if you touch a line you end
up with a delete and an add. So you can as well move it to get it closer
to the convention. But that's just nice to have, I brought the entire
thing up because of the net/ethtool/ code which previously followed the
convention and after changes it wouldn't.

> How I see this, we can take a couple of directions:
> 
> a) when things are already messed up, just implement your changes and leave
> the rest as-is.

This is acceptable, moving things closer to convention is nice to have.

> b) when your changes mess things up, clean it up and accommodate for the
> convention.

Yes, if by "your changes mess things up" you mean that the code follows
the convention exactly for a given function - then yes, the changes must
remain complaint. Not sure why you say "clean it up", if the code is
complaint you shouldn't break it. No touching of pre-existing code
(other than modified lines) should be necessary.

> extra option:
> 
> c) this is probably going to be a case by case thing and we may ask you
>     to do more changes as we see fit.
> 
> To be clear, I have no issue with c) (because it's basically how things
> usually work), as long as maintainers don't expect v1 of any patch to
> be in pristine form. In any other case, I would really like to be crystal
> clear about what's expected and what's not.

