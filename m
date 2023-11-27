Return-Path: <netdev+bounces-51384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 139FB7FA75C
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B258B1F20F6F
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34B3716C;
	Mon, 27 Nov 2023 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hil/ESDH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C334CDE;
	Mon, 27 Nov 2023 16:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44DBC433C7;
	Mon, 27 Nov 2023 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701104245;
	bh=fwpUjuF5ShDyPElkq7WkuUJxK4tf7Xezd/JJVyXFQ44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hil/ESDHYVy2hFe6Vw+4TnylC7oFmRqzdMdERMLKQ7BVO1vn/5joYw4X37cn1XVsR
	 MomcONrvEkshDvsGLd4gsRAfar9fzpllN6ptrDNf+nVSRYUiCRzVcoNOP6U32HRuR3
	 1ffoY02dGRSz3rX8b/BabLMWBFeaAIA/zBtd30DHPSBQ7eGooVKEeRukyeQ0smKt2i
	 7812LhzHFaF5aI8ML85fn+igCyw/e2iggKltp/UlSthbvRnmHOZRR01ZNSifVRutyw
	 zPKxkHVJTOIzjfUpWEGDlGAR7hrxHjXL8Klqp+p1l7ZDGnAUgUWZpNxo3ipN9emXUS
	 9XDqyv1qFmFcw==
Date: Mon, 27 Nov 2023 08:57:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <corbet@lwn.net>, <jesse.brandeburg@intel.com>,
 <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <vladimir.oltean@nxp.com>, <andrew@lunn.ch>,
 <horms@kernel.org>, <mkubecek@suse.cz>, <willemdebruijn.kernel@gmail.com>,
 <gal@nvidia.com>, <alexander.duyck@gmail.com>, <linux-doc@vger.kernel.org>,
 Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v6 2/7] net: ethtool: add support for
 symmetric-xor RSS hash
Message-ID: <20231127085724.3cc31a9c@kernel.org>
In-Reply-To: <f24802ae-bd66-446b-9b13-e291d33fb5c6@intel.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
	<20231120205614.46350-3-ahmed.zaki@intel.com>
	<20231121153358.3a6a09de@kernel.org>
	<f24802ae-bd66-446b-9b13-e291d33fb5c6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 07:21:47 -0700 Ahmed Zaki wrote:
> On 2023-11-21 16:33, Jakub Kicinski wrote:
> > On Mon, 20 Nov 2023 13:56:09 -0700 Ahmed Zaki wrote:  
> >> + * @data: Extension for the RSS hash function. Valid values are one of the
> >> + *	%RXH_HFUNC_*.  
> > 
> > @data is way too generic. Can we call this key_xfrm? key_preproc?  
> 
> We manipulate the "input data" (protocol fields) not the key. I will 
> rename to "input_xfrm".

Ugh, right!

> >> +/* RSS hash function data
> >> + * XOR the corresponding source and destination fields of each specified
> >> + * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
> >> + * calculation.
> >> + */
> >> +#define	RXH_HFUNC_SYM_XOR	(1 << 0)  
> > 
> > We need to mention somewhere that sym-xor is unsafe, per Alex's
> > comments.  
> 
> I already added the following in Documentation/networking/scaling.rst:
> 
> "The Symmetric-XOR" is a type of RSS algorithms that achieves this hash 
> symmetry by XORing the input source and destination fields of the IP
> and/or L4 protocols. This, however, results in reduced input entropy and
> could potentially be exploited."
> 
> Or do you mean add it also to "uapi/linux/ethtool.h" ?

Yes, a short mention in a comment next to the define.
There's a good chance person looking at this will not notice 
the documentation in scaling.

