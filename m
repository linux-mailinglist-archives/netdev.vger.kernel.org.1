Return-Path: <netdev+bounces-49834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB147F3A42
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAAC1C20ADC
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47CB55C26;
	Tue, 21 Nov 2023 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YguDlj+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA95E55799;
	Tue, 21 Nov 2023 23:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C58AC433C7;
	Tue, 21 Nov 2023 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700609348;
	bh=fEzPROx42WfkO6ncCKE3bs0DQa21Xu0Wvi6ZF8DSajY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YguDlj+pl7itFbltiXmiLAhBiOkyiiGdJyAI4BCCsdkqNRbkC82NHhpmJZERwVdBm
	 iHKbJGIvsbOdu7H1eSNxTdDaa4h94SHPK+tF9q0rbcEWXw4ajc1aoUCC61i7VB+33C
	 Dm80MalZYh/LSDTAyDbn63w8nr28K7/N6Io+6T/mkDuUxxgt9EswN6fvq7RN+KoOfP
	 HNaUuoqS9BkpHRGL/Mt2tlyGrNMOoApmQEFGq5kNrV3+9eTtp0IFxa4usUQy60xPp5
	 lUnca9vviogco38F5hZg9YisLK9X6GJ6QAEbfLJ62aUE79J2K5reijKSpaIP0awBph
	 vXIPMZqMKveiw==
Date: Tue, 21 Nov 2023 15:29:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 corbet@lwn.net, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org,
 mkubecek@suse.cz, willemdebruijn.kernel@gmail.com, gal@nvidia.com,
 alexander.duyck@gmail.com, linux-doc@vger.kernel.org, Igor Bagnucki
 <igor.bagnucki@intel.com>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
Message-ID: <20231121152906.2dd5f487@kernel.org>
In-Reply-To: <20231120205614.46350-2-ahmed.zaki@intel.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
	<20231120205614.46350-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 13:56:08 -0700 Ahmed Zaki wrote:
>  	u32	(*get_rxfh_key_size)(struct net_device *);
>  	u32	(*get_rxfh_indir_size)(struct net_device *);
> -	int	(*get_rxfh)(struct net_device *, u32 *indir, u8 *key,
> -			    u8 *hfunc);
> -	int	(*set_rxfh)(struct net_device *, const u32 *indir,
> -			    const u8 *key, const u8 hfunc);
> +	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh *,
> +			    u32 *indir, u8 *key);
> +	int	(*set_rxfh)(struct net_device *, struct ethtool_rxfh *,
> +			    const u32 *indir, const u8 *key);
>  	int	(*get_rxfh_context)(struct net_device *, u32 *indir, u8 *key,
>  				    u8 *hfunc, u32 rss_context);
>  	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,

This conversion looks 1/4th done. You should do the following:

 - First simplify the code by always providing a pointer to all params
   (indir, key and func); the fact that some of them may be NULL seems
   like a weird historic thing or a premature optimization.
   It will simplify the drivers if all pointers are always present.
   You don't have to remove the if () checks in the existing drivers.

 - Then make the functions take a dev pointer, and a pointer to a
   single struct wrapping all arguments. The set_* should also take
   an extack.

 - Add a rss_context member to the argument struct and a capability
   like cap_link_lanes_supported to indicate whether driver supports
   rss contexts, then you can remove *et_rxfh_context functions,
   and instead call *et_rxfh() with a non-zero rss_context.

 - Add your new member to the struct wrapping all params.

If you just expose struct ethtool_rxfh to the drivers (a) there are
fields in there drivers shouldn't touch, and (b) that struct is uAPI
so we can't add netlink-only fields easily.

