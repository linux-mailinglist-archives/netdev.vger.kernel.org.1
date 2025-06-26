Return-Path: <netdev+bounces-201694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A714AEA92C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EF6642DCA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC807265621;
	Thu, 26 Jun 2025 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGU4PPo+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACF2620C4
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975180; cv=none; b=EFf2gIEfFflVk/Ia4geouAb6oOpvHiGkFrj/m47sdhpLWdDv9K2rqbSpBUostABKQJO9a5xUpbvgqD4mX70alUEFJeBwallBpOXPCSiv7R5Jp7Qn1gJSYnCKtsaXx/cwkGjgLtVCoj4PvMlXoGH8z2vSxrxY1WbzhmFFG4i8r0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975180; c=relaxed/simple;
	bh=aW3OKh65xmX1rIQAXMBt9nyxtvoln/xu4ovPWUjAai8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BOje1PkdtETIPRYQGZAD+O4oEWPfTno+AMaLCjsUQIHk7ec4xkbrQrE8B9OB6ycQiV+oqpoUdkeONerEu6+xHNcFMmCIpIcUL+H/ScJ7Y5qpFkuXhXK4RDdDrKxjI1rqJmeJNA0u1+4uPAMPFCb2kyEhqaIQSZNV0kE3oHrDtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGU4PPo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4694BC4CEEB;
	Thu, 26 Jun 2025 21:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750975180;
	bh=aW3OKh65xmX1rIQAXMBt9nyxtvoln/xu4ovPWUjAai8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pGU4PPo+Pmja2Tc3ti+Bs/pxqrDsUTHzZBdPOLJOjFBnDFGBAX4AasYf67Kripraw
	 ZS/ACz8F5Fir52QkhbvkJA7NIed5uIyP0FZYEEhoAqKQUs9EPgr9npQoFmT8c4zTTG
	 G/+3uMBI7a7K/5QjbXJWvRtL4gQZ98I4Jj246s+UOFsXCWQY7OzmHhS+4CyCz7vmL4
	 RAwOVmbvfZhjFXyz4benEtFLY/fKqrL32LDZSB5hAP5qSwe2GvnMx2o3wRXYFpgouu
	 4W8CaJHU48qedrMcDxLjszD3mRYHP5R4Q860gBjuKj7Kehokq193uOfq37PpJ7W8KP
	 WR4ibb2MReyHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC643A40FCB;
	Thu, 26 Jun 2025 22:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] bond: fix stack smash in xstats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175097520650.1346572.7068115127244556855.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 22:00:06 +0000
References: <20250626140124.39522-2-stephen@networkplumber.org>
In-Reply-To: <20250626140124.39522-2-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, zhongxuan2@huawei.com, nikolay@cumulusnetworks.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 26 Jun 2025 07:01:25 -0700 you wrote:
> Building with stack smashing detection finds an off by one
> in the bond xstats attribute parsing.
> 
> $ ip link xstats type bond dev bond0
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> bond0
>                     LACPDU Rx 0
>                     LACPDU Tx 0
>                     LACPDU Unknown type Rx 0
>                     LACPDU Illegal Rx 0
>                     Marker Rx 0
>                     Marker Tx 0
>                     Marker response Rx 0
>                     Marker response Tx 0
>                     Marker unknown type Rx 0
> *** stack smashing detected ***: terminated
> 
> [...]

Here is the summary with links:
  - [iproute2] bond: fix stack smash in xstats
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ede5e0b67c13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



