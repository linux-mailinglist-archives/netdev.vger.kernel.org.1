Return-Path: <netdev+bounces-138626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097A59AE5EE
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EED3B21128
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057DF1D89E3;
	Thu, 24 Oct 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7VX5Woi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D91D5158;
	Thu, 24 Oct 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776015; cv=none; b=FSaM47y8as/MUWP6wQ6fv3cDdwlXLmCCPWjPca8GiYQ1SSZAViR6+Ah3edVEKqG+8gEGc9tbdsB3rY0bY8GQBziSJIfGvSJ2sJnlL6YmacqE8I3egQRUXLhHU5L7H0XtJlyXHRZCXTj4ir8H54FhsG6w87Dpd6jwty1MO8Jq2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776015; c=relaxed/simple;
	bh=/m4HPPraDyo/dwN16U6sOcMlkv1ByR/voIQNhTClxPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFmdMzWsaUAYfnt6OEI9iD+DHo8ACDDtdL9EKmdZ0eozDylueAhgXbu3knF0Zv2FFkWVI8P7UPDViYmkVS8YIg2ZZPKSYbPCCnNxNb+1akWExhjck8N8dbn6LyROp35oyvbfo0ZlAmbukjVl8Ujk5NpPDli/OW2Mlyk5q7Fg42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7VX5Woi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E76C4CEC7;
	Thu, 24 Oct 2024 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729776015;
	bh=/m4HPPraDyo/dwN16U6sOcMlkv1ByR/voIQNhTClxPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7VX5WoiN3Kz9cypyFgmwEFDq9/4EsQo82RnEKc3Tu2sk3ZULlovo0vFmX37JaQSw
	 TGYOCpnAnCh34E0g7IGq6evurzkfXHaFDjxNnZkaGDHsGHKbT//cdM25I5Ww00pR9J
	 t8nV0rPE17YY0fMYVRpUlTT7plbQ+t58AJ2SmblqNTWtbyT7sJYJPS1ds/u55AUnis
	 riKXTWM+cGyQ0zxy74Yn9xMqH1AEz4z0I27oLLXLhFIpnnOVi5ofv6i/vOyDb3EEzV
	 /VOSXYdaW3HBi1uB4CTBF6dhL4UVRjW19QhA9HnjJoOYZ3Cd2rY7oLBiHbD1dLuKjb
	 HyPEGdLjz4l/g==
Date: Thu, 24 Oct 2024 14:20:11 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sched: sch_api: fix xa_insert() error path in
 tcf_block_get_ext()
Message-ID: <20241024132011.GM1202098@kernel.org>
References: <20241023100541.974362-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023100541.974362-1-vladimir.oltean@nxp.com>

On Wed, Oct 23, 2024 at 01:05:41PM +0300, Vladimir Oltean wrote:
> This command:
> 
> $ tc qdisc replace dev eth0 ingress_block 1 egress_block 1 clsact
> Error: block dev insert failed: -EBUSY.
> 
> fails because user space requests the same block index to be set for
> both ingress and egress.
> 
> [ side note, I don't think it even failed prior to commit 913b47d3424e
>   ("net/sched: Introduce tc block netdev tracking infra"), because this
>   is a command from an old set of notes of mine which used to work, but
>   alas, I did not scientifically bisect this ]
> 
> The problem is not that it fails, but rather, that the second time
> around, it fails differently (and irrecoverably):
> 
> $ tc qdisc replace dev eth0 ingress_block 1 egress_block 1 clsact
> Error: dsa_core: Flow block cb is busy.
> 
> [ another note: the extack is added by me for illustration purposes.
>   the context of the problem is that clsact_init() obtains the same
>   &q->ingress_block pointer as &q->egress_block, and since we call
>   tcf_block_get_ext() on both of them, "dev" will be added to the
>   block->ports xarray twice, thus failing the operation: once through
>   the ingress block pointer, and once again through the egress block
>   pointer. the problem itself is that when xa_insert() fails, we have
>   emitted a FLOW_BLOCK_BIND command through ndo_setup_tc(), but the
>   offload never sees a corresponding FLOW_BLOCK_UNBIND. ]
> 
> Even correcting the bad user input, we still cannot recover:
> 
> $ tc qdisc replace dev swp3 ingress_block 1 egress_block 2 clsact
> Error: dsa_core: Flow block cb is busy.
> 
> Basically the only way to recover is to reboot the system, or unbind and
> rebind the net device driver.
> 
> To fix the bug, we need to fill the correct error teardown path which
> was missed during code movement, and call tcf_block_offload_unbind()
> when xa_insert() fails.
> 
> [ last note, fundamentally I blame the label naming convention in
>   tcf_block_get_ext() for the bug. The labels should be named after what
>   they do, not after the error path that jumps to them. This way, it is
>   obviously wrong that two labels pointing to the same code mean
>   something is wrong, and checking the code correctness at the goto site
>   is also easier ]

Yes, a text book case of why that practice is discouraged.

> Fixes: 94e2557d086a ("net: sched: move block device tracking into tcf_block_get/put_ext()")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


