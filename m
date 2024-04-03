Return-Path: <netdev+bounces-84435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5296896EF6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF3CB23099
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4CC44C86;
	Wed,  3 Apr 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xka2IJ8a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5DA1C683
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147932; cv=none; b=WP9mXsE3/o5iyQLPsLwf+NwN0w6p9d+eZjcVFh26hDUDqwu7AcynUkqAnct++ScZjBk41Vb7NUK9VhFX0lpNjJB9GaPDDKyx87CCa6WDjbmyR29QNldscYRRv3Ro+xwH1O0gNXYNSVwgKRQK/9LuSLdsz2DRhl2NuI9KbHuMwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147932; c=relaxed/simple;
	bh=oxOAQat1ljjGn5BGfPZdV3UcvYudQfSSHNWwUFTw74M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBDMOqI2Jps6TxT2F0TqCg+HyD9wvQalARHzg3+x5lQhT3loJiVnKcY79LBTOtqH8iPw7cZKy9nkCASZtPP/dnYZN1VAX/+6a6uT6coLfY9c1cLGlaAukGhyIxK+bSRdVR8k1AABLJRgAeC7OHSUixw2pPJyqA7uFLyqyjYY56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xka2IJ8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DD3C433C7;
	Wed,  3 Apr 2024 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147932;
	bh=oxOAQat1ljjGn5BGfPZdV3UcvYudQfSSHNWwUFTw74M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xka2IJ8a4d+e0Q8rddtOteySDbpwkjclzPvpDYrMUXpsRNz7aTuGlOz+OLOtiJUhM
	 lrcORyU0JbwlhAq5Pn1MPRqSejTUoruU7GKPz1AzGPzkJ0ybojUkDf1ejY50YXtYnU
	 Y2RPFzJ6r1o3HuSiMKWvQM55QQqF1p0PB7rVydHXYMu/46L+kfRMMxigFUgWATcTOA
	 5eImt7XamnQoCVc+3GUnRmmEJO4mCcx695jvn6oA7OD+iENBC98w9WJgTR6XwoWwa0
	 ZK1tbjDd/hnOVShjnselgr9VROnOKRiV9+pmfQFDQ7zUeLLvC2Wf0rtzJLkhUjrXm3
	 +qZjEdyTmiZig==
Date: Wed, 3 Apr 2024 13:38:48 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 07/15] mlxsw: pci: Poll command interface for
 each cmd_exec()
Message-ID: <20240403123848.GC26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <e674c70380ceda953e0e45a77334c5d22e69938f.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e674c70380ceda953e0e45a77334c5d22e69938f.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:20PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Command interface is used for configuring and querying FW when EMADs are
> not available. During the time that the driver sets up the asynchronous
> queues, it polls the command interface for getting completions. Then,
> there is a short period when asynchronous queues work, but EMADs are not
> available (marked in the code as nopoll = true). During this time, we
> send commands via command interface, but we do not poll it, as we can get
> an interrupt for the completion. Completions of command interface are
> received from HW in EQ0 (event queue 0).
> 
> The usage of EQ0 instead of polling is done only 4 times during
> initialization and one time during tear down, but it makes an overhead
> during lifetime of the driver. For each interrupt, we have to check if
> we get events in EQ0 or EQ1 and handle them. This is really ineffective,
> especially because of the fact that EQ0 is used only as part of driver
> init/fini.
> 
> Instead, we can poll command interface for each call of cmd_exec(). It
> means that when we send a command via command interface (as EMADs are
> not available), we will poll it, regardless of availability of the
> asynchronous queues. This will allow us to configure later only EQ1 and
> simplify the flow.
> 
> Remove 'nopoll' indication and change mlxsw_pci_cmd_exec() to poll till
> answer/timeout regardless of queues' state. For now, completions are
> handled also by EQ0, but it will be removed in next patch. Additional
> cleanups will be added in next patches.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


