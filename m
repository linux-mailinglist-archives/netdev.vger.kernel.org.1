Return-Path: <netdev+bounces-166268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B48A3547F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77621890E6B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D313C918;
	Fri, 14 Feb 2025 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ6JBZmr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B413AA2F
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499028; cv=none; b=s9FTw9ELZqNiLYnB4F7Tp/ZQB7C4gSIC/1+YBi86qBh0WONKOR8yqkLaRFCtHvK8Ki/qh773QuUld/dOpz30njL4Qayc7JJgMV9luOFEBjteoHjdrZ51gd24csAqvn+U40S1jCRZxCfYWLNNU4crro5EtwptPweaerGE+kAGuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499028; c=relaxed/simple;
	bh=MTYZrL0RaCjcQBDp8gBP3U2FP0LlOaqMflmRqWowgtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5fZQPN1ukeAY8U39v58ku7QF0HqOpl2YN/w3j2JLXsGJogm9odEJkf/LSSiJ6qm41VogCbQ1eBa2RS8AyVLHulIHgHhhKHhtt/RHGHtVLi7BLIQXHMm4TGO2SZmpyomi4p8ygnWspt7z3dqXgJebVK00WSI2uxVGYjqOIMOVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ6JBZmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77628C4CED1;
	Fri, 14 Feb 2025 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739499028;
	bh=MTYZrL0RaCjcQBDp8gBP3U2FP0LlOaqMflmRqWowgtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZ6JBZmrCdfEO6hjQP2U7ga9mw9jlfIgCMyvCjfy1Inxh1A+VM3dWZulLxZlunOKm
	 Nt+0FsGyEJutwRY6beGiSUZ/Cvyvh46o8qZty6VPP9zyA4y/+Eq+fiw3glca3hP4q6
	 hH+1K3bITXzg06+ckybIqkAt1boRFwft/uZcJmonEXTBoPuEGqVDonQa4H47efIdU3
	 2p/EHOoeDy1Gn0BMNyS6jpJwkBvj4Thzj3WwZ+Dnsu723PSQZ6KT4WTzwtelwz00C0
	 cWMJDorfHoNdN0Wm2R4jR6MIg8L0ADoodbnOudgfPHEt5x7UFRaKWlr2Q3H4ME0aKu
	 97b540qol7vtA==
Date: Thu, 13 Feb 2025 18:10:27 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [RFC net-next 0/4] net: Hold netdev instance lock during ndo
 operations
Message-ID: <Z66mEzg1YU02mr43@x130>
References: <20250204230057.1270362-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250204230057.1270362-1-sdf@fomichev.me>

On 04 Feb 15:00, Stanislav Fomichev wrote:
>As the gradual purging of rtnl continues, start grabbing netdev
>instance lock in more places so we can get to the state where
>most paths are working without rtnl. Start with requiring the
>drivers that use shaper api (and later queue mgmt api) to work
>with both rtnl and netdev instance lock. Eventually we might
>attempt to drop rtnl. This mostly affects iavf, gve, bnxt and
>netdev sim (as the drivers that implement shaper/queue mgmt)
>so those drivers are converted in the process.
>
>This is part one of the process, the next step is to do similar locking
>for the rest of ndo handlers that are being called from sysfs/ethtool/netlink.

Hi Stan, thanks for the patch, sorry I didn't have the time that week to
look at it and it fill between the cracks, I've glanced through the patches
quickly and they seem reasonable. but obviously we need much more, 
so what's the plan? currently I am not able to personally work on
this. 

Also the locking scheme is still not well define with this opt-in idea the
locking shceme is actually still not clear to me?  for me it should be as easy
as netdev_lock protects all paths including, ndos/ioctl/netlinks/etc .. paths
that will access the netdev's underlying driver queues.


