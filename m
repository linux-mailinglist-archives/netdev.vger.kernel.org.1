Return-Path: <netdev+bounces-159479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D414A1597C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20837A285F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7EA1ABEA1;
	Fri, 17 Jan 2025 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKFwbHEJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871BB67F
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737152315; cv=none; b=ntatJM1RSWwZ1lv+ox2vSjhCCw2xbRK4KJprJweOHVHWjfsE60m/bI3YemWPYG2PzrejA/ecIycOPAHhNw+4oawGVfSfJSPxh4tHSKFxssy4t7DXomyLmcE4CHsKUI404XBnIlqgxO8lCOUO1heJBQhNEXpTvThTcKr8s62FOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737152315; c=relaxed/simple;
	bh=rc5gvcO5VQLgk2fzpzNrCj6/NJ+a5t7MctPotIFsEiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpyTBxr1Q83osoUzIivWg3mvgmzLQ8PG83/0AV64+e2cVuw7GqOPx+atFq5PPRCuRYXCXKf5J/9InMyNEQXtyHe5MLcL6zShpfhPZklRJzjHZs62GKwyL6gO1v/9DCD33T+2RWZTo+DlZJu3bIR377klsrYfhg5V9mmJSuO0V9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKFwbHEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2CEC4CEDD;
	Fri, 17 Jan 2025 22:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737152314;
	bh=rc5gvcO5VQLgk2fzpzNrCj6/NJ+a5t7MctPotIFsEiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DKFwbHEJgEQKWsxjeywkp2uncZvBNVPeRpnMyUCCg3uCskwp/EcLJ1V8itN3Wsc1k
	 ZsctPQF4PnqiecgXLXER644wI1QhnrKDTKQ+Df76rHAwcZexps9zIcG5+BtwyY0eF1
	 zlXk9obMKN25p7v/t2RePniXk05Mt9L6On2es8YiPOGKZN05hu9i2NLrJwp4Jf+Gam
	 YESKkAq+xaFWUt9Eo4M/Qf6FXV2YcQvoHlckzS+BE/DQWaePM9jZnXFRaUeTO0F5UY
	 /C+sgEL7ncIhl6TnQWkqg7hC2EfJq6rsmHrosy/fAxEcAS9kqtfue4+30PbxTR+LfA
	 mzkQwQ9FmMSpw==
Date: Fri, 17 Jan 2025 14:18:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com, ap420073@gmail.com
Subject: Re: [PATCH net-next 2/6] net: provide pending ring configuration in
 net_device
Message-ID: <20250117141833.7d8b519e@kernel.org>
In-Reply-To: <CACKFLinRxGgrgz8LUROsK0O+KTk=4a2B=mF-b2269JU+CigFPQ@mail.gmail.com>
References: <20250117194815.1514410-1-kuba@kernel.org>
	<20250117194815.1514410-3-kuba@kernel.org>
	<CACKFLinRxGgrgz8LUROsK0O+KTk=4a2B=mF-b2269JU+CigFPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 14:07:03 -0800 Michael Chan wrote:
> > +out_tie_cfg:
> > +       dev->cfg_pending = dev->cfg;  
> 
> If I understand this correctly, cfg_pending can momentarily point to
> the old cfg and freed memory before pointing to the new cfg outside of
> rtnl_lock.  Shouldn't it be inside the rtnl_lock?
> 
> In the bnxt patch, we now look at cfg_pending so it must always point
> to the correct cfg.

Good catch, I moved it out to avoid an allocation under rtnl_lock..
-- 
pw-bot: cr

