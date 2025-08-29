Return-Path: <netdev+bounces-218420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6EB3C5FB
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66BF3A8E6A
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E3931AF0C;
	Fri, 29 Aug 2025 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/KT0JKi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A4276025;
	Fri, 29 Aug 2025 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511928; cv=none; b=dBHn9wmtq7EzYiepz5zkdssjzBY4wfjbf9o4aJt6xvugma1jbVX8CB2tJycf8cOQSpWp0wMeTZ+P5jIGnxDkgjTu2uQ35uJti6KuU6IYr1Lp6Az1bGNbDIve69Mjgct7RnwljhTY93kJ7Xb6UqbSHKxYJu5cDj5nHEozdMgV+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511928; c=relaxed/simple;
	bh=bF+r5UjG0k/G1NhLeNLWzjUzrnb9lzS6mwOO5Nsutk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmjA/sYA5ceK+mYwLbSJ4IPcJZzEDLdVn37yhWIpTM64peSI+NEMf3q/MRNnB/qyLQVa6AM4IVf8pK1gPo4h6kYO/PzNGVamSqil3xzKFAXyfdJn3Ujxyh0F8b6lqe61tQNcuH9i/Lnur1pIdYgOmuq+nfy6/keOFqGn7iZ5Pio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/KT0JKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DE8C4CEF0;
	Fri, 29 Aug 2025 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756511928;
	bh=bF+r5UjG0k/G1NhLeNLWzjUzrnb9lzS6mwOO5Nsutk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/KT0JKiplKZ27RrERy1CsiNGV9rmb+6JPMD20Gou94Q5xkFpYzTSSzpWmOSRvI1u
	 Ce5kDF4EwkwaQikiUESh1aQd9yGitpJKAKWp/2B0J8bMwW3HPUY20ormfH8ipYdVxi
	 2th1D4HhxdZuHtTfDBhSPHOkCDet4ipRWkFFls171vyzDoTenp1lsHrCywCxLvlEHq
	 oeZN0TCrXEXdSHWqLcN76w2uiINQ0iV24NRxBocVWD1G8eWPBpZDMw3ZvAm7rqMJxS
	 iUYm8RXYGTOxyhG2a/Fc/AAziy58ixuhtY23W6Wwf1Q3NS3qdsruRwvdN0DFBrrSXu
	 2bQOPr2VRf1AQ==
Date: Fri, 29 Aug 2025 16:58:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 1/2] net: pse-pd: pd692x0: Separate
 configuration parsing from hardware setup
Message-ID: <20250829165846.1cee2798@kernel.org>
In-Reply-To: <20250829102624.1d959943@kmaincent-XPS-13-7390>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-1-dcd41290254d@bootlin.com>
	<20250825151001.38af758c@kernel.org>
	<20250828104612.6b47301b@kmaincent-XPS-13-7390>
	<20250828151218.1c187938@kernel.org>
	<20250829102624.1d959943@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 10:26:24 +0200 Kory Maincent wrote:
> > > I don't think so, as manager is declared like the following it should not.
> > > struct pd692x0_manager *manager __free(kfree) = NULL;    
> > 
> > Please consult documentation on the user of __free() within networking.  
> 
> Oh, I didn't know about this net policy.
> I didn't follow the maintainer-netdev doc changes. Maybe I should.
> Ok, I will add a patch to the series to remove the __free macro. 

Up to you on existing code, but maybe avoid using it in the future?

