Return-Path: <netdev+bounces-199285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A941ADFAAE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 03:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213B6170ED3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324957083C;
	Thu, 19 Jun 2025 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVi4uhSi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAF2111
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750296485; cv=none; b=gxNP9vJ0KaninkM3gPbHbYS6l9Y8gkQ1r0w8KyyW90wwUrflY/mJNntW6zSzIlDXuSMb9kGAs/dt20f9vNAObzKv/EyhMLjeTOOne54DfhhPREg3Gi02tD3eLMnY9c86YFmUc5fK8P91q7I0AsvxsDwdAgG361K4rCXC9TooKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750296485; c=relaxed/simple;
	bh=FxqpodvWGjH3sqGLCMrqgjaYWncCbFC7bZ/iC71lxGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZ7fm9u2HiX0gIgmLpYEkbgY/xBSjRulaAuZxOgchz2vDsleLa3jctabg04fb5uvrtN2tQD9o9mqbwS7PlH4E8RMePYtFyJz4YKvjb1rFwl1qdJqE/99qQhxLBHzetGLjA7O3YZ1c8TaDtAc9egrABgg/z9nv3NnfF7Wbp2f+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVi4uhSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51885C4CEE7;
	Thu, 19 Jun 2025 01:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750296484;
	bh=FxqpodvWGjH3sqGLCMrqgjaYWncCbFC7bZ/iC71lxGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVi4uhSiv+6VfmtKyK5RyGKMw4ubiAfzEtND6KMKGjF9AMH7ilAhn4IL7IcrprYJf
	 uYfncavHOz6u6FRLcutBnIiiEeq4agWBDmUxhVaUO6tPCimaBcIaKub05tgl2DhtYo
	 ouT1/AtOIKY4lqs6IMKD3omGS4q5ZrY/UnLlBHSOPIzQESeJaJDS+pwa0rhYjeoqE1
	 JOfTiIR/VaZrhm1w1qHIu8eiqh9POrfJSGJwAKyGOhe0ZwJ4pR0U9Zj4GNDCBfJLc8
	 4MwsN3GEVMtfsA4qsYW/vvG3wQ7IQg/KIRau0E586PlNCYdSWxEib9tpUbibGy2c+w
	 qflZJLO1jWBBw==
Date: Wed, 18 Jun 2025 18:28:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8] Add support to set napi threaded for
 individual napi
Message-ID: <20250618182803.2e367473@kernel.org>
In-Reply-To: <20250616165706.994319-1-skhawaja@google.com>
References: <20250616165706.994319-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 16:57:06 +0000 Samiullah Khawaja wrote:
> A net device has a threaded sysctl that can be used to enable threaded
> napi polling on all of the NAPI contexts under that device. Allow
> enabling threaded napi polling at individual napi level using netlink.
> 
> Extend the netlink operation `napi-set` and allow setting the threaded
> attribute of a NAPI. This will enable the threaded polling on a napi
> context.
> 
> Add a test in `nl_netdev.py` that verifies various cases of threaded
> napi being set at napi and at device level.
> 
> Tested
>  ./tools/testing/selftests/net/nl_netdev.py
>  TAP version 13
>  1..7
>  ok 1 nl_netdev.empty_check
>  ok 2 nl_netdev.lo_check
>  ok 3 nl_netdev.page_pool_check
>  ok 4 nl_netdev.napi_list_check
>  ok 5 nl_netdev.dev_set_threaded
>  ok 6 nl_netdev.napi_set_threaded
>  ok 7 nl_netdev.nsim_rxq_reset_down
>  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index ce4cfec82100..ec2c9d66519b 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -283,6 +283,14 @@ attribute-sets:
>          doc: The timeout, in nanoseconds, of how long to suspend irq
>               processing, if event polling finds events
>          type: uint
> +      -
> +        name: threaded
> +        doc: Whether the napi is configured to operate in threaded polling

lower case napi here

> +             mode. If this is set to `1` then the NAPI context operates

upper case here, let's pick one form

This is technically a form of kernel documentation, fed into Sphinx
I'm a bit unclear on Sphinx and backticks, but IIUC it wants double
backticks? ``1`` ? Or none at all

> +             in threaded polling mode.
> +        type: uint
> +        checks:
> +          max: 1
>    -
>      name: xsk-info
>      attributes: []

>  Threaded NAPI is controlled by writing 0/1 to the ``threaded`` file in
> -netdev's sysfs directory.
> +netdev's sysfs directory. It can also be enabled for a specific napi using
> +netlink interface.
> +
> +For example, using the script:
> +
> +.. code-block:: bash
> +
> +  $ kernel-source/tools/net/ynl/pyynl/cli.py \
> +            --spec Documentation/netlink/specs/netdev.yaml \
> +            --do napi-set \
> +            --json='{"id": 66,
> +                     "threaded": 1}'

I wonder if it's okay now to use ynl CLI in the form that is packaged
for Fedora and RHEL ? It's much more concise, tho not sure if / when
other distros will catch up:

  $ ynl --family netdev --do napi-set --json='{"id": 66, "threaded": 1}'

> +/**
> + * napi_set_threaded - set napi threaded state
> + * @n: napi struct to set the threaded state on
> + * @threaded: whether this napi does threaded polling
> + *
> + * Return: 0 on success and negative errno on failure.
> + */
> +int napi_set_threaded(struct napi_struct *n, bool threaded);

IIRC by the kernel coding standards the kdoc if necessary should 
be on the definition.

> @@ -322,8 +326,14 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
>  {
>  	u64 irq_suspend_timeout = 0;
>  	u64 gro_flush_timeout = 0;
> +	u8 threaded = 0;
>  	u32 defer = 0;
>  
> +	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
> +		threaded = nla_get_u8(info->attrs[NETDEV_A_NAPI_THREADED]);

nla_get_uint(), nla_get_u8 will not work on big endian

> +		napi_set_threaded(napi, !!threaded);

why ignore the error?
-- 
pw-bot: cr

