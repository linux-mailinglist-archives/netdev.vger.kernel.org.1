Return-Path: <netdev+bounces-105087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB1490FA27
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67016B213E6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3256A816;
	Thu, 20 Jun 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwTn0J6u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44A64C
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718842682; cv=none; b=PQR93TT1XO9HMPosthf2gtwhtKh8YaGeePteiTvnBUHISSeYfx+sDs8M9kn30MKvupJsPp3MvbHkYnk+QIwM6Fh0mpCBwVl4Jhw5LXCzJxtg/GcelHDVh9IwN7s0FscZZ7PYW60MFzde5sPHIw8IIZhK7mD3oHuhlgwND1aAsnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718842682; c=relaxed/simple;
	bh=gnsKm7GDEsjDd2l6lks9B6OXzyMfZI5vBPCN2APqJfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeYmQBI4YYOBqwt/lUp6MO0pqwURmfiG15wwtsAxRjLdTBqIRCYjGHR9G+ECALOefbZEMRqpQp2L25DWuAEKtJf/h6bG4GoH6U3dDlqMdNSn0X2gl0UIudVjAqu1mRSivL3PX+s2Edo6hU6Sb9rRdLut3d1sGH1z7h2asYvnQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwTn0J6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5C3C2BBFC;
	Thu, 20 Jun 2024 00:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718842681;
	bh=gnsKm7GDEsjDd2l6lks9B6OXzyMfZI5vBPCN2APqJfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TwTn0J6uZI+zQWq3PMhofZnMWLSkER5Qsj3edCKkROzIQlXcW4OYMvFnvJXWdfDaK
	 JVGWkMxrmP5uWWCU1S8RMWBzx3nxkPSUj2bmW3vxJdSu4vgWeDktRwaHYMMtQlPKrk
	 0DN8A+vYMko2eIS/w272e9Fn7MxsVvIA78Ph/FLLjk/wFsCWfW0o3+NwZZwffdXeeq
	 L4KkwSmRGtnNEqcEt0h/9qd9shk0mqWBU9K1y2yri/EYfgo6Vj4NDY9rT7LleAV/Fn
	 HKe8ZdnRaYe36+UmpKFcW9E4JlNN0jyhMRCaw1H6J3xmAADlUOuEK6Bor8dBUXW08O
	 IVOte6A5mrBWg==
Date: Wed, 19 Jun 2024 17:18:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH net] ionic: use dev_consume_skb_any outside of napi
Message-ID: <20240619171800.57a60bfc@kernel.org>
In-Reply-To: <6fb11f9c-1cd3-4a07-a687-96f0c5f146e5@amd.com>
References: <20240619212022.30700-1-shannon.nelson@amd.com>
	<20240619164434.46acb9fb@kernel.org>
	<6fb11f9c-1cd3-4a07-a687-96f0c5f146e5@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 17:11:08 -0700 Nelson, Shannon wrote:
> > Just pass the NAPI budget in, and if not in NAPI pass 0.
> > A bit more plumbing thru, but a lot less thinking required during
> > review..
> > --
> > pw-bot: cr  
> 
> I had a plumb-it-through solution at one point, but this is so much 
> cleaner with a simple one line fix, so much less to go wrong...

So much less to go wrong you say? I'm 75% sure the fix is buggy,
it won't work if hard irq comes during soft irq ;)

