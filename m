Return-Path: <netdev+bounces-248552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2698CD0B4C3
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 17:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F15F730ED015
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE9536402E;
	Fri,  9 Jan 2026 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN3WH5Wj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE03385BC
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976292; cv=none; b=T/J0XMRQtKKcnuxcettj0VER0mvZbRpTBRMUUt4nDmBCnGz0fO9sv/AplQu7UWYr1siOvOa/Rij7T9VyPSkDv5xhoJF1iWpfDQozjwv4TJ/Eeor3oX5cxqR4+bAc5w92yGHQtwe1taBrKpWl2KM34MbN5bTePB+vy+rv3OMJ4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976292; c=relaxed/simple;
	bh=sfLQbq5PkJLzZsulbRARyE0eoV1AzANKpvLzQK+dvHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlR5MruytwEU3/5n8BPkqSpSR32hnlReK0nHacVgLyVlbkU2AjbZT1vtLSoZt7zpSe3DA6XOzlbQ2WBpZqLNNMWxfEJrZaODLrQi2/aUorE7u60GIJCJk/vbriDJMH0H5uI8FyZoe12/UOzyXN3sonUgek2KFuB7dQb+dx9lKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN3WH5Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C46C4CEF1;
	Fri,  9 Jan 2026 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767976291;
	bh=sfLQbq5PkJLzZsulbRARyE0eoV1AzANKpvLzQK+dvHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oN3WH5WjSayl7g88OEmJzUcO0PIpL71MIM5DQVXgqSa7sKG26oHHpG0okAegMaLMo
	 Km5DGFYJpeiikOx9uwlhoOIo2qWY7psMGO/D549CaPZv/HtQKiiqVWxeX73i1WfHbq
	 RZs3A8kicwpOlIWhHeB0JdfhM190uHKsHEPGo2ZGXKIHsDajK2BoRXxlvNJ2BNzlT8
	 cx8UD/OXcGjEsaTgGRKwhrqmCfCfTVUXCi/p2F5XStPxsqgauR6VZf9a+3zXDCI/nV
	 MIzNixeDwy5E4dE0gqEiPPQE2qj8PUDYLEXg72Nmg+q0WU1Erg8iuw3G0R6ssOEsnN
	 wjTUSuloO/NwQ==
Date: Fri, 9 Jan 2026 08:31:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: fixed_phy: replace list of fixed
 PHYs with static array
Message-ID: <20260109083130.50ae4ba9@kernel.org>
In-Reply-To: <aWEaWvV_0SfylwW5@shell.armlinux.org.uk>
References: <e14f6119-9bf9-4e9d-8e14-a8cb884cbd5c@gmail.com>
	<20260108181102.4553d618@kernel.org>
	<aWEaWvV_0SfylwW5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 15:10:18 +0000 Russell King (Oracle) wrote:
> > Isn't IDA an overkill for a range this tiny?
> > IDA is useful if the ID range is large and may be sparse.
> > Here a bitmap would suffice.
> > 
> > DECLARE_BITMAP(phy_fixed_ids, NUM_FP); 
> > 
> > id = find_first_zero_bit(phy_fixed_ids, NUM_FP);
> > if (id >= NUM_FP)
> > 	return -ENOSPC;
> > 
> > set_bit(id, phy_fixed_ids);  
> 
> Racy without locking.

True, if there's no existing locking wrap it in a do {} while and use
test_and_set_bit() as the condition for repeat.

