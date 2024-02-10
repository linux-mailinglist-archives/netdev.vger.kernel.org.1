Return-Path: <netdev+bounces-70737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E098502C0
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 07:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8468E1C2132C
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1DB16435;
	Sat, 10 Feb 2024 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuUvkB6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C2339AA
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707546619; cv=none; b=Ce3bf/8fCosUTYRMsCq6axgQAc9AY2hPjLwezNAnAB04H23FFXJGHX7RIggTMVz4Y9fPNV1wu482yndgLXQDZPp3JElMdHBxss1VHRF33geWsjOHiBL9cDdL3QMDS1q44Cd87dgPwlh1Tpc6gW9gEenUP9LUR0J1IlfjJrXMe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707546619; c=relaxed/simple;
	bh=d7jF8ctJRDfR5YMBHSG7JS1zPdQwByCMNZtkTZ/KW1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OufOfMsK5lOY/jESbUfw2O6wo4xSCTQ8dp2UABpgNOLbBr3lDEDaBwjynzuGqtkBA72be/0MXczdc2AtlxTb510WLOIY/Ec5fi0hzNKMgftOgZCjXLHhX3XTcUzxr35Ae9ilFkpQycIPSuL/U7o6LBo2UaYTy5gPMKvbu0FgbZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuUvkB6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C864C433F1;
	Sat, 10 Feb 2024 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707546618;
	bh=d7jF8ctJRDfR5YMBHSG7JS1zPdQwByCMNZtkTZ/KW1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YuUvkB6sp++EcrXLbklbOKU6l6Jmr/L2cNig6J+Vg4nnmZxMOWimCVVeijbsvV4pS
	 lVvDM9bORJIlBX5G1SeIUbiPLWRZgyKiZo/Bt+E2MLPnk/cZjrlNO9pVqAV6pC+GBB
	 oD6VLlLAGSuefcJ5IkiosvmhW965oq3buUT04ax1ifuXXbfWNOl4jHk65urZ/uARYD
	 jXqMncbzKaosC38cuaew6mABTJEVytPFb8NwzIi4XLz9lOxD7wv9KWi+de3JKliRbt
	 VplcudbPL8REAP4yDUEg0ekAR8As67mXdI1ycJka9T2bkP9+f84cftd4pS4LLI+l8s
	 TCkC+TPWLRdqw==
Date: Fri, 9 Feb 2024 22:30:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 0/3] netdevsim: link and forward skbs
 between ports
Message-ID: <20240209223017.5a03acaf@kernel.org>
In-Reply-To: <20240210003240.847392-1-dw@davidwei.uk>
References: <20240210003240.847392-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 16:32:37 -0800 David Wei wrote:
> This patchset adds the ability to link two netdevsim ports together and
> forward skbs between them, similar to veth. The goal is to use netdevsim
> for testing features e.g. zero copy Rx using io_uring.
> 
> This feature was tested locally on QEMU, and a selftest is included.

Sadly we appear to be heading towards double-digit version numbers :)

https://netdev-3.bots.linux.dev/vmksft-netdevsim-dbg/results/458900/14-peer-sh/stdout
-- 
pw-bot: cr

