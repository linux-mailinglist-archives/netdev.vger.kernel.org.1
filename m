Return-Path: <netdev+bounces-161586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616DA22793
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 02:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713A51639D1
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D32A1B2;
	Thu, 30 Jan 2025 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8GUMZsY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E492556E;
	Thu, 30 Jan 2025 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738201946; cv=none; b=r88nn19L8T2j4VZFOaPQVSzkLbHYkwk1NYmUeqSG1cjP+Mjv/UlO6al37Yyh9W7xSvojmUWdZ7Qf6380iQ+KELbULcUJUEc+wLgdrBzUFlBLZLhOPbASEQn8A8/Q6yll2iEdCCE2K9By69OeFIEJ3dUxiIJWcCMm4GMIP0hV8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738201946; c=relaxed/simple;
	bh=DHDAiFrnLz/caqpPilmfqY0tl42KzUPyiOd96aQ5Jo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+X/wTPb7UunlmaExZelh4FQLeZfqVKwwpphLZzosHv/B9uxx8gMd3pvFlm7+fpQriesaEgxkBXXL55Q3vsBF+91DcGHFfYdiUTwuetGlh2XpmCB/d6VtoAF8tQpv1jok2V6nmQqStOdEsIyF84J5ZvA78WfcNjMnYeaGlWjQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8GUMZsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4422FC4CED1;
	Thu, 30 Jan 2025 01:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738201945;
	bh=DHDAiFrnLz/caqpPilmfqY0tl42KzUPyiOd96aQ5Jo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j8GUMZsYsEzBaLIpPEM4m1mdFGhLxLHexYoLc8roRwXQzbgqG51wE6TVVHFLk3eLW
	 g0fsWRyioqrc0ZGE8H/rNEZAAbevW0CeMVVn+a/S1Q5emwbhPE2Nphkfy7CWsRN/Zp
	 QbabL8CM7z0gdF7boomr2CZxWDnwXvhM97uLBUZJWm8L4tUxn21y6gz0H94xw+Y8A2
	 EWVvtyb3V07JXSdvuaLCQUGhLeJO/2S2MASAqOu46i6wDL8mjo4RK9d3cNsO75DmUT
	 1StL9iZzl30r+s16PW+rsdsbjyjemQ2fs7j7qoik3Qg7T6mPDkxTpMMXkYd8r6SV+a
	 w9DvFmlLShpzQ==
Date: Wed, 29 Jan 2025 17:52:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, Martin
 Karsten <mkarsten@uwaterloo.ca>, Amritha Nambiar
 <amritha.nambiar@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, Daniel
 Jurgens <danielj@nvidia.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC net-next 1/2] netdev-genl: Add an XSK attribute to queues
Message-ID: <20250129175224.1613aac1@kernel.org>
In-Reply-To: <20250129172431.65773-2-jdamato@fastly.com>
References: <20250129172431.65773-1-jdamato@fastly.com>
	<20250129172431.65773-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 17:24:24 +0000 Joe Damato wrote:
> Expose a new per-queue attribute, xsk, which indicates that a queue is
> being used for AF_XDP. Update the documentation to more explicitly state
> which queue types are linked.

Let's do the same thing we did for io_uring queues? An empty nest:
https://lore.kernel.org/all/20250116231704.2402455-6-dw@davidwei.uk/

At the protocol level nest is both smaller and more flexible.
It's just 4B with zero length and a "this is a nest" flag.
We can add attributes to it as we think of things to express.

