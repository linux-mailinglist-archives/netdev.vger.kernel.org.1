Return-Path: <netdev+bounces-150980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8831D9EC3F1
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 05:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30B9168387
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3237F1BD9CA;
	Wed, 11 Dec 2024 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8ESym3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A52AE90
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890874; cv=none; b=STih0pPLZaU9V0Z5NKauU8hROCdP1Yf0dkxcorlGm4TkO9AMJNzAf7TeT90B92DY26jaBdS9HE8GFGqjFj9R577uxjBTefOJQJNrUYWhTUx32SknjR79qYU676v/PNF3X2XaQ7tl3q26d6PaeI4+u7aCaiM0TciLlGPg2FCysFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890874; c=relaxed/simple;
	bh=00Xr4iiIPcrxg8sF6uscKsYeAVXQPkoHYFPv+z1hHhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CE6LyhPPnwu5Us6sTJqoyHiw/m7ESYEEDqjUtYXHP3iUr8ts3z5U/K9sBNR34SPX8GpwVyrx2MdGQeYXVS23Y2r8Hf2UXVkaFmPeWHWeowpD0jAunqvy6MN650aeA3bDezrpob69pZRvOkAHcYL4dntnwgysuGaKPbMYoVmDZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8ESym3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E338CC4CED2;
	Wed, 11 Dec 2024 04:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733890873;
	bh=00Xr4iiIPcrxg8sF6uscKsYeAVXQPkoHYFPv+z1hHhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s8ESym3dEZqHWhAxasFMSDQMWKT8bUdo4BGeqJYrHiYsgHklnE+3cWNZe0vHK14ir
	 fdf7+wliWyrkEnp8oPENX+BWfSHQ7cxJicZ/pG/qItyEbRQnbBtEZ1npIdQqqBzxt6
	 LennZzmTpI/2/xI5RxFDVsDLp7rpeKG8BQcRoeznLdnf9k7ljrDip9NsmKTbXPb4d2
	 CgSq0YFk+NJ5fPrhhiBfyots77Fz7xREzRsfxA5zjCNAZQjDUTSbVYB/Tvz39BSqnU
	 JbSRe54n0HnztuJTYFhO0W08cOFyWJv7rIQzYLyuA75Q1Kl1s5qYgqFsRtU6xYFInw
	 loK8M2Q8jL9Jg==
Date: Tue, 10 Dec 2024 20:21:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
 michael.chan@broadcom.com, tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 net-next 2/6] net: napi: add CPU affinity to
 napi->config
Message-ID: <20241210202111.7d3a2dc8@kernel.org>
In-Reply-To: <Z1eZXKe58ncARD2N@LQ3V64L9R2>
References: <20241210002626.366878-1-ahmed.zaki@intel.com>
	<20241210002626.366878-3-ahmed.zaki@intel.com>
	<Z1eZXKe58ncARD2N@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 17:29:00 -0800 Joe Damato wrote:
> My understanding when I attempted this was that using generic IRQ
> notifiers breaks ARFS [1], because IRQ notifiers only support a
> single notifier and so drivers with ARFS can't _also_ set their own
> notifiers for that.

Ah, you are so right, I forgot the details and was grepping for
notifier registration :S

> Two ideas were proposed in the thread I mentioned:
>   1. Have multiple notifiers per IRQ so that having a generic core
>      based notifier wouldn't break ARFS.
>   2. Jakub mentioned calling cpu_rmap_update from the core so that a
>      generic solution wouldn't be blocked.
> 
> I don't know anything about option 1, so I looked at option 2.
> 
> At the time when I read the code, it seemed that cpu_rmap_update
> required some state be passed in (struct irq_glue), so in that case,
> the only way to call cpu_rmap_update from the core would be to
> maintain some state about ARFS in the core, too, so that drivers
> which support ARFS won't be broken by this change.
> 
> At that time there was no persistent per-NAPI config, but since
> there is now, there might be a way to solve this.
> 
> Just guessing here, but maybe one way to solve this would be to move
> ARFS into the core by:
>   - Adding a new bit in addition to NAPIF_F_IRQ_AFFINITY... I don't
>     know NAPIF_F_ARFS_AFFINITY or something? so that drivers
>     could express that they support ARFS.
>   - Remove the driver calls to irq_cpu_rmap_add and make sure to
>     pass the new bit in for drivers that support ARFS (in your
>     changeset, I believe that would be at least ice, mlx4, and
>     bnxt... possibly more?).
>   - In the generic core code, if the ARFS bit is set then you pass
>     in the state needed for ARFS to work, otherwise do what the
>     proposed code is doing now.

SG, maybe I'd put the flag(s) in struct net_device, so that we are sure 
the whole device either wants the new behavior or not.

I say flag(s) because idpf probably wants just to opt in for affinity
mask management, without ARFS. So pretty close to Ahmed's existing code.
ARFS support will require another flag to ask for rmap management in
the core as you describe.

