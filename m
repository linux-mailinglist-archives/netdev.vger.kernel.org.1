Return-Path: <netdev+bounces-114955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31591944CDA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99AD1F2541C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270C1A38F6;
	Thu,  1 Aug 2024 13:09:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52F1946C7
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517769; cv=none; b=IgIwol1jERJ2ZgE79akEVijLVs9JsIKnDg3qE434i56Q9K8D2yM0H7PDkF4jzS35KzHvNrGefVcQGmv8P+I/HU9CeY0DEF8x+TpGIIPyT5XsDjySeBXln929NfIpcuKqPx8FMErKZfRsckUCx8zmsg3ZZmn8hTQADNYo3eg1ZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517769; c=relaxed/simple;
	bh=9jGa9DtGP8gLr6Tl+ArIizIB4JjfG3FqJ/SS4o7m8b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3X0/ZW0DRCc1yhlJqE9rG3cLidqPqQ0Lzb4tMmcs9ddWmxjiPRdArug8HTKT1Rg7VC12gxlOzDKc4CYoeDK/Xd8Ex9tV3EaFEA+vmLqE+5iYtaoZF39liGRSMPrFvdsYpQ1Z1XuKP9a78LO4EzAEMC6Jh5yx/a0/hEu1B/uavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sZVYZ-0000II-HD; Thu, 01 Aug 2024 15:09:23 +0200
Date: Thu, 1 Aug 2024 15:09:23 +0200
From: Florian Westphal <fw@strlen.de>
To: Christian Hopps <chopps@chopps.org>
Cc: Florian Westphal <fw@strlen.de>, devel@linux-ipsec.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v7 07/16] xfrm: iptfs: add new iptfs xfrm mode
 impl
Message-ID: <20240801130923.GA543@breakpoint.cc>
References: <20240801080314.169715-1-chopps@chopps.org>
 <20240801080314.169715-8-chopps@chopps.org>
 <20240801121310.GA10274@breakpoint.cc>
 <m2y15g75rl.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2y15g75rl.fsf@ja-home.int.chopps.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Christian Hopps <chopps@chopps.org> wrote:
> You are correct the code is not sufficiently protective.
> 
> I need to use rcu to keep `xfrm_mode_cbs_map[mode]` around long enough to do a `try_module_get(&xfrm_mode_cbs_map[mode]->owner)` and return from `xfrm_get_mode_cbs()` with that ref count held. The caller (xfrm_init_state()) will then need do a `module_put()` after it calls `mode_cbs->create_state()` to give the reference back.

Yes, that should work.

