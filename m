Return-Path: <netdev+bounces-110603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E170392D68A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 18:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A120B2871C2
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B28194C86;
	Wed, 10 Jul 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEGi+sto"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC921194C7D;
	Wed, 10 Jul 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628988; cv=none; b=fXKpTBWjA6c4ppbrrI1CsACCRe+suKxsXEEBzgWnwDMx5WSlrkXF2J3gbJcnM3COifl5hpH7zBBU4s+ejhe663ZWYj8ff4IP59YaBGk/0bs/wPvuow1UJnbTHKpLYv4uHRDhSBrBYA6Jv7tYGzVOx9QPBZIPp+lBoGehzAyswwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628988; c=relaxed/simple;
	bh=bx9D8NKwTdRINZb3r2LnlQ1Wd7RT9h4+RBDqcerlajk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj8hJK1JHvwvt4B06thB3/PLkVVAQxv2txlH3BdFewBg/xLP2AaJ+MorMfINCgJkmNlJr3niHnWO0j0i2/et1czqx+5pegMfnHmx2OtJRvwz8HJTPkaiGnrjJ1Cr8nwGMVft7AoCsulxCRrG7UyIUYuXWLgRyQgbYtgX+37MQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEGi+sto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CAAC32781;
	Wed, 10 Jul 2024 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628987;
	bh=bx9D8NKwTdRINZb3r2LnlQ1Wd7RT9h4+RBDqcerlajk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEGi+stov8aPkMbYfVULNzrQjikFEyCT3EM9gGTyjbSuUAphaNf3gCpn3ouKGyqcT
	 hNkWbmQD+qJdAxpxMTsxKFFTMZntrG3Ugcr6uGKzyWLWCiIOE0By3uvVtxecA7+MWP
	 5T2SPF9cSxrnjJ7jk9AJved5hoS9CPaA4oOP6pHuJlZSPfunbN5Z17FR9J/oUE+c1F
	 bTF+mPfyhTwMpMK9GG3QRb10j0hjziso00LbfCyI90ksnaHRI55dX0il9kFM+nZ9MI
	 OEW3OCRzNZQaKNYPpkTo46plPVDtbtR9SRtQnyFPGHM7dWgXAIFpNprL7wxRa4MxGU
	 1LaiYSmqiKfeg==
Date: Wed, 10 Jul 2024 09:29:46 -0700
From: Kees Cook <kees@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, horms@kernel.org,
	linux-hardening@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] netdevice: define and allocate &net_device
 _properly_
Message-ID: <202407100927.3CA9DE888A@keescook>
References: <20240710113036.2125584-1-leitao@debian.org>
 <0664910d-026d-49b8-8b70-a5c881888761@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0664910d-026d-49b8-8b70-a5c881888761@intel.com>

On Wed, Jul 10, 2024 at 04:01:35PM +0200, Alexander Lobakin wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Wed, 10 Jul 2024 04:30:28 -0700
> 
> > From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > In fact, this structure contains a flexible array at the end, but
> > historically its size, alignment etc., is calculated manually.
> > There are several instances of the structure embedded into other
> > structures, but also there's ongoing effort to remove them and we
> > could in the meantime declare &net_device properly.
> > Declare the array explicitly, use struct_size() and store the array
> > size inside the structure, so that __counted_by() can be applied.
> > Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> > allocated buffer is aligned to what the user expects.
> > Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> > as per several suggestions on the netdev ML.
> > 
> > bloat-o-meter for vmlinux:
> > 
> > free_netdev                                  445     440      -5
> > netdev_freemem                                24       -     -24
> > alloc_netdev_mqs                            1481    1450     -31
> > 
> > On x86_64 with several NICs of different vendors, I was never able to
> > get a &net_device pointer not aligned to the cacheline size after the
> > change.
> > 
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: Kees Cook <kees@kernel.org>
> 
> You did a great job converting embedded &net_devices, thanks a lot!
> 
> I hope SLUB won't return you a non-cacheline-aligned pointer after that
> you removed SMP_CACHE_ALIGN(sizeof_priv), right?

Currently the slab will do power-of-2 alignment (i.e. aligned to the
bucket size), so this should be fine. In the future I'm trying to make
the slab more aware of the required alignments so that it can still
provide needed alignment without having to do maximal (power-of-2)
alignments.

-- 
Kees Cook

