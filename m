Return-Path: <netdev+bounces-166691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87163A36F79
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53517A2D2E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C92415CD41;
	Sat, 15 Feb 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyggRRoE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586CA17C61
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637083; cv=none; b=r6GrAnydiKR8hKXuCrerg2897tqpizi9HrC6ggLI9qv61Ngy9XUSDsEmZ5dw2IUKvW12yLlO9Ux9YGyWIQNOxhGFmKzPBehP9Fz//Vu17wu3isubx2l38gLiKZOVbiiQcWrtQIflgIK7bT7EsThLFK5ZDlyLP8fxQAuMt9qnPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637083; c=relaxed/simple;
	bh=HtbGcNbysAsDhB3zQcfjY25PTIb6wTEwUsMQD/E9NEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEZe1BSpUZOlKCe3Xrt73f8e+5aXm56M62ea6yzI9Ldh/ZlT5Lp/f57mWNRPZDz0DvkvlsFQszpvEXJYQb3F09sEewPsL21hJ44Q2ZRXWyf/OpCxtI73LDDxf9YncrMu8U2UOmXEXeMdarUhzifS0/ZdCmMhxD2jdaWtPsBUfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyggRRoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D16AC4CEDF;
	Sat, 15 Feb 2025 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739637082;
	bh=HtbGcNbysAsDhB3zQcfjY25PTIb6wTEwUsMQD/E9NEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CyggRRoEmQ70bIBMHHUFjftN7f9qQIhVGNmOVSIuRTGE874XeOJrKH7SSf5joJtgM
	 vNsbCL6rk6R+qKm64PNTfLYjox+dheM7ehoYlsPJ/f93xCc12FrQ+/5mgErXYdfbP0
	 5ar773hJOthqVPyO0ka8su/9qtC5ICurDKDie2OW7XNZ49URQDohUmWM0MP8OLuyfJ
	 tA3GQYVLXvMkUfH8oZTSFOnqSd0YEFxGfDYgxfEKv4q9qR5gjeopj16Tw9G+CKiO77
	 vgUjTBjwk6fT57usUOJs1ML9x2vWZVs9E6P9xqGlq+Mdw12iY7sTx5vrTgEN7RQOdt
	 yuYs4IwOBPQOw==
Date: Sat, 15 Feb 2025 08:31:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com, stfomichev@gmail.com
Subject: Re: [PATCH net-next v2 3/3] selftests: drv-net: add a simple TSO
 test
Message-ID: <20250215083121.5bb31524@kernel.org>
In-Reply-To: <67b0a976ba5fd_36e344294b1@willemb.c.googlers.com.notmuch>
References: <20250214234631.2308900-1-kuba@kernel.org>
	<20250214234631.2308900-4-kuba@kernel.org>
	<67b0a976ba5fd_36e344294b1@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 09:49:26 -0500 Willem de Bruijn wrote:
> > +        cases = []
> > +        for outer_ipv4 in [True, False]:
> > +            for info in test_info:
> > +                # Skip if test which only works for a specific IP version
> > +                if outer_ipv4 == info[1]:  
> 
> Only if need to respin:
> 
> using ternary True, False, None for skip_ipv6, skip_ipv4, skip_neither
> is a bit non-obvious. Use strings?

Now that you say it..
I think using ipver with values "4" "6" could clean up a few things.
I'll poke a little bit on Monday, and probably respin.

