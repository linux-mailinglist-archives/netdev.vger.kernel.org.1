Return-Path: <netdev+bounces-144628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8279A9C7F6F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4AA283D1D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B6BE4E;
	Thu, 14 Nov 2024 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVwvEp8p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF844A954
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731544872; cv=none; b=Sg5wVFLZ5ZFwIozhAnQYFl0XZ1df0tLjVyMNNlfHZtMBc95ThBW41gpq2WPi/qEqtfr7YkpaKAPcKg7NBJMFUN1fD1Vhu6r0n4tdqaCZurABeIoX8FBDN0FMQM7vF2EobPuutDxsCZy+A84x8lPPCAiRkRDrwLCdN5gh2FLKZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731544872; c=relaxed/simple;
	bh=C7ODDwvffHJ2YtnHrtzEf1EjtgbOEdFYer7W+NxWjJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tReDSEmHLxdzRDug5VMn92xzhVz+Pz6q/zqPFRKJBm/CkSLgFv8ldBrl6eVMUBXsMPYkCb8bHMvWc3q6dCErWf2xtiVZLlcE55aKm4RkhcL+rf2mPMlnJQ1IsDqsx2jN056HhcPbn/uUyl8GxBtLzKGBDvZKDXTv6zygbDE8k04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVwvEp8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DD4C4CEC3;
	Thu, 14 Nov 2024 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731544871;
	bh=C7ODDwvffHJ2YtnHrtzEf1EjtgbOEdFYer7W+NxWjJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EVwvEp8pzoXP0sACNzzhfMuakENwWe2Y5P6z9qhCEWdUR/mKVp8xr+SnzmYSIr4bP
	 75Au6PuxDOde5Mvau5uftr7m1dczCA1NADm66IK2ux0Al9onQKXhHp6zqkGqwPJ1B3
	 nQH5GWNprFfJOA1Ub6C4HTDFqcP8/XtBvYz3TX3nxr8gkOHcEymvc37EDQVTmVUN23
	 NNN/mi2vh/I23vZmQrYq3FCYVGx5cDh+afcrjmXP5/nBBhxQC+mwPeu+dQTW8FKf0r
	 DI+Y/Ys6+LR8eypwtAqiXppJ6qKW0vodPTOQTc16hElc3tF9REj3FBLXqj1Pdff3qB
	 9rWR/Ytfzrpjg==
Date: Wed, 13 Nov 2024 16:41:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, alexandre.ferrieux@orange.com, Linux Kernel Network
 Developers <netdev@vger.kernel.org>, Simon Horman <horms@verge.net.au>,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic
 failure to free IDR entries for hnodes.
Message-ID: <20241113164110.196f491d@kernel.org>
In-Reply-To: <CAM0EoM=V80Qj3NQEcS4cmLoByTnUDn9BER8SWkWKUEp+OVRXWA@mail.gmail.com>
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
	<CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
	<20241111102632.74573faa@kernel.org>
	<CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
	<20241112071822.1a6f3c9a@kernel.org>
	<CAM0EoMkQUqpkGJADfYUupp5zP7vZdd7=4MVo5TTJbWqEYDkq7g@mail.gmail.com>
	<20241112175713.6542a5cf@kernel.org>
	<CAM0EoM=V80Qj3NQEcS4cmLoByTnUDn9BER8SWkWKUEp+OVRXWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 09:17:09 -0500 Jamal Hadi Salim wrote:
> >   Co-posting selftests
> >   --------------------
> >
> >   Selftests should be part of the same series as the code changes.
> >   Specifically for fixes both code change and related test should go into
> >   the same tree (the tests may lack a Fixes tag, which is expected).
> >   Mixing code changes and test changes in a single commit is discouraged.  
> 
> Just the last sentence:
> Mixing unrelated (to the fix) code changes and test changes in a
> single commit is discouraged.

Perfect example why things are not documented.
I have no idea what you're trying to say..
I think you're the only person who is getting this wrong,
so I'll toss the documentation patch.

