Return-Path: <netdev+bounces-85892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB289CC42
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35E8B20C44
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D063145330;
	Mon,  8 Apr 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP85ybKB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63168F51B;
	Mon,  8 Apr 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603366; cv=none; b=W5Q6JjWFPD/Y3OwpiZu3B1DxwX9QwW9Ytn3f8eKyd4Ig2hXW+qXqlG44ZeBnC4976bJvjdOi92nOH+ut4E9EpZJ0QImWTOVUY8kpi+h/GExwNMM3i/+czdZ3nAWk98pNwcrYwH/qlquZDOhcSt0ROTrsRypGmXGATz4EmJj4EtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603366; c=relaxed/simple;
	bh=+imjXZLxiC5vLNyw+n7Df/46xhLqYK1EsF6hPytaED0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUVGFRsUKwW1UVY1dt8kHR7FXIK5Uf3rdXpnCkl35fCRivZky/BzEQodxuEAhAjGwpMhLbepnoPa8sk5iEM2WhGo+ipQPSyP9aNHq+KbEZQmm1bKfV4lw/RWodjD4XMfo9Ehn+iCkpz398XyzCHzYqB8kCfQRl0o2wZ39cuZ/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP85ybKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83344C433F1;
	Mon,  8 Apr 2024 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712603365;
	bh=+imjXZLxiC5vLNyw+n7Df/46xhLqYK1EsF6hPytaED0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NP85ybKByCsTahYkkm69bL/ZJf8WAAcxcWLvHJ/FRlWhquLHVm6qK39ytwA8fjTDb
	 Dma00VSrnY8BVXYwh3WL/x02h7bLnPGe0Rv8Phq3GHceHZGK0CYx25WA3YF3BJGcBV
	 wbd+6cSB4Dc2ZDKSwleKlscF9q+zWTZXVJGarX9URHURQaHv7gmcSJ3yQmkS77gzyF
	 n5aJsW4jL6AP0rb/BSX0EdJ12MiWwTqwX5hEttZTL1SZLtfsy5O6HmHxP3StaEVaGN
	 dkX6GgdriWwS/q+vzTMz8m+xtIPh5l2JXIQKqgcQBQpLNsjrd3EqHxM9oKsWXv6o96
	 Bm4DoQg991zkQ==
Date: Mon, 8 Apr 2024 12:09:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 1/4] ethtool: provide customized dim profile
 management
Message-ID: <20240408120924.1f01e722@kernel.org>
In-Reply-To: <1712547870-112976-2-git-send-email-hengqi@linux.alibaba.com>
References: <1712547870-112976-1-git-send-email-hengqi@linux.alibaba.com>
	<1712547870-112976-2-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:44:27 +0800 Heng Qi wrote:
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -408,6 +408,18 @@ attribute-sets:
>        -
>          name: combined-count
>          type: u32
> +   -
> +     name: profile
> +     attributes:
> +       -
> +         name: usec
> +         type: u16
> +       -
> +         name: pkts
> +         type: u16
> +       -
> +         name: comps
> +         type: u16
>  
>    -
>      name: coalesce
> @@ -497,6 +509,23 @@ attribute-sets:
>        -
>          name: tx-aggr-time-usecs
>          type: u32
> +      -
> +        name: rx-eqe-profs
> +        type: nest
> +        nested-attributes: profile
> +      -
> +        name: rx-cqe-profs
> +        type: nest
> +        nested-attributes: profile
> +      -
> +        name: tx-eqe-profs
> +        type: nest
> +        nested-attributes: profile
> +      -
> +        name: tx-cqe-profs
> +        type: nest
> +        nested-attributes: profile

Something wrong with the YAML format :(

while parsing a block collection
  in "../../../../Documentation/netlink/specs/ethtool.yaml", line 25, column 3
expected <block end>, but found '<block sequence start>'
  in "../../../../Documentation/netlink/specs/ethtool.yaml", line 416, column 4
while parsing a block collection
  in "../../../../Documentation/netlink/specs/ethtool.yaml", line 25, column 3
expected <block end>, but found '<block sequence start>'
  in "../../../../Documentation/netlink/specs/ethtool.yaml", line 416, column 4

does make -C tools/net/ynl work for you?
-- 
pw-bot: cr

