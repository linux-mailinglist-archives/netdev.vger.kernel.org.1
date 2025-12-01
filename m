Return-Path: <netdev+bounces-242953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D4C96D7B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 12:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 759D53422D7
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833BA306B04;
	Mon,  1 Dec 2025 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn4Nvlb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE013054C5
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587590; cv=none; b=plYS1U1MzYMvvKaC/RZbVT2IlEpK6aAW+OapOqP4gbJVh6ifFZjD03l517Gsar0TaIc7ldpQohpDoP1SqDdMUAH13S8BYLx8yFfr/UldOazSWksJbN8MQOpisz/ftBJTuDQwJJeAMJvkvgEyvjXzMllrS/HAVRmJiFBAQMl7Vco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587590; c=relaxed/simple;
	bh=fYMUbue3Ka37fHtYbiOTRTL0VUjzqr8ncwExp4fw1FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6qVigy9z+UNjlwVVMh4omY6IUtatiYGl9bJrY8b43R28rVTB0K27RIb0u3lErB9dp0Vm3xh76v2wZ/u/Qk7AHz/LNF/m//p/0JmFPw5bFsTtKXTPgD1U+kQKlpNh2iMkNP4lfvAjdTFCGhheYUtyjbeMu1y3QDF6EsngoHE00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn4Nvlb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD66C113D0;
	Mon,  1 Dec 2025 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764587586;
	bh=fYMUbue3Ka37fHtYbiOTRTL0VUjzqr8ncwExp4fw1FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pn4Nvlb4RGM/2J1Djw/JQddi/rPHy2L2SrgU5wUXUnhXZ3erHzGf44qJlxd7ZqHwA
	 yJN7Vle/JIEZF0TQeGO1vFt8693jeI7pr/V94TDEHSF8mfHH0xSgIjXAmPAXXim7Bm
	 Yjz5RGABeUJ3Ze/bYIsjU/vtpQ8W1S6Mz2gS/YxxxbhDhf6Twvo6DG2FSyOTT4fGUh
	 jMZEpDLyHunt9uxqS8oFWE7G72LSqK3a0jK/eKFABDtWYJxZynlB45SneYduYroF+G
	 S9LGtt+fxGQLHTHgGi/TrM9Lp6yVGuNTtYDNuve6IUXFkmmMgMoW1dq6xMTQaIHEE6
	 /89T5rQuMh1KQ==
Date: Mon, 1 Dec 2025 11:13:02 +0000
From: Simon Horman <horms@kernel.org>
To: 2694439648@qq.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, hailong.fan@siengine.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, inux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Modify the judgment condition of "tx_avail"
 from 1 to 2
Message-ID: <aS14PnwjbFcD_J70@horms.kernel.org>
References: <tencent_22959DC8315158E23D77C14B9B33C97EA60A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_22959DC8315158E23D77C14B9B33C97EA60A@qq.com>

On Mon, Dec 01, 2025 at 10:57:01AM +0800, 2694439648@qq.com wrote:
> From: "hailong.fan" <hailong.fan@siengine.com>
> 
>     Under certain conditions, a WARN_ON will be triggered
>     if avail equals 1.
> 
>     For example, when a VLAN packet is to send,
>     stmmac_vlan_insert consumes one unit of space,
>     and the data itself consumes another.
>     actually requiring 2 units of space in total.

Hi,

I am wondering if there are other cases where an extra
descriptor is needed. And if so, can multiple such conditions
occur at the same time?

I am also wondering if the VLAN condition can be detected,
so a descriptor is only reserved for VLAN use if it will
actually be used for a VLAN.

And I think it would be worth noting how this problem was discovered
e.g. by inspection, using tooling (static analysis, AI, ...).
And how it has been tested e.g. On real HW, compile tested only.


As this is a fix for Networking code present in the net tree
it should be based on that tree. And targeted at that tree like this:

Subject: [PATCH net] ...

Also, as a fix for net, it should have a fixes tag.
Generally, this should denote the first patch where the problem would
manifest. In this case this seems to be a likely candidate:

Fixes: 30d932279dc2 ("net: stmmac: Add support for VLAN Insertion Offload")

The tag should go immediately above other tags, in this case your
Signed-off-by line, without any blank lines in between. And, like other
tags, it should not be line-wrapped.

For more information on the workflow for Networking changes please see:
https://docs.kernel.org/process/maintainer-netdev.html

> 
> Signed-off-by: hailong.fan <hailong.fan@siengine.com>

