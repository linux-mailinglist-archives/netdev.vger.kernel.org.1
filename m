Return-Path: <netdev+bounces-150965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032D9EC31A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4659B166770
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4E20C000;
	Wed, 11 Dec 2024 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0Ada3Xt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD6209F40
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887250; cv=none; b=tzAxsfi5ncCA3csMAlYHJDzzuZB9bBcKkM108WyC8S16IQN5CaA4imyhVHn64Njxt9u9mNVXKTR5dehv9Pim6Efb3lOcgJ22at5UFLvk1lbG626zIho8M23lvRJT1341k9k+gylI1r05EMojBeecJ/Pj1YRPaGM3IXPMTo2lA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887250; c=relaxed/simple;
	bh=XCY0pXlzNw/8pmnbv7v2GtOBQPku5J4SBwfsoz/32Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaGYH4ofLJj/tiVT/N1spCachr2yDBj6jNESqE4tYtuX5aQMGkXXVOQ0j9bZ8SsVAbjhzeMyItPPu1aI1WFizXk/jdFB+QoWEWm3VrF1Tos+U+RE7qWXvm8OzinXA3GDyxyuBdHMyoEMFOO0rzWBxA2+JLNVz6TYlRgLo9cjiYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0Ada3Xt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91741C4CED6;
	Wed, 11 Dec 2024 03:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733887249;
	bh=XCY0pXlzNw/8pmnbv7v2GtOBQPku5J4SBwfsoz/32Lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H0Ada3XtIYw+muYZwXqVd2BeTW+xOaGovOKzGVtoEggJ0dRXTSDy0yC3eWN1ZLZ5/
	 Y/IWFcBE/jDUPkS/YI/OmjiN2BTsULHac25Y+VsmGXi+3VRmsXhH9rKDqsJsxZ4ajx
	 c+p9PxXuSV8H557uj5xu3Jfde0QZkxO4uX6SLYNQH2bdE+jrz8N/QNvo+NizFxWrBR
	 oe8XIsrSaZbquTfgooD8QfzeeZwKd2qR5WsA44m/YrdQES1/B2iheX0X7tmkPhNS/5
	 Oa9WifiBzbHHjAXHfockimIiloFXtwifSnLhVJhT8qDb46l+SLGbmotosJDVM2R+5X
	 u8u9JparMZwjQ==
Date: Tue, 10 Dec 2024 19:20:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>, Feng Wang
 <wangfe@google.com>
Cc: Leon Romanovsky <leon@kernel.org>, <netdev@vger.kernel.org>,
 <antony.antony@secunet.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v7] xfrm: add SA information to the offloaded packet
 when if_id is set
Message-ID: <20241210192048.386d518a@kernel.org>
In-Reply-To: <Z1gMGlYPCywoqJK5@gauss3.secunet.de>
References: <20241209202811.481441-2-wangfe@google.com>
	<20241209215301.GC1245331@unreal>
	<CADsK2K_NnizU+oY02PW9ZAiLzyPH=j=LYyjHnzgcMptxr95Oyg@mail.gmail.com>
	<Z1gMGlYPCywoqJK5@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 10:38:34 +0100 Steffen Klassert wrote:
> > This patch was done based on our previous discussion.  I did the
> > changes we agreed on.  
> 
> there is still no real packet offload support for netdev sim.
> And as said, this is at most the second best option.
> 
> You need to prove that this works. I want a complete API,
> but I also want a working one.
> 
> The easiest way to prove that this is implemented correctly
> is to upstream your driver. Everyting else is controversial
> and complicated.

Yes, I don't have full context but FWIW offload changes accompanied 
by just netdevsim modifications raise a red flag:

Quoting documentation:

  netdevsim
  ~~~~~~~~~
  
  ``netdevsim`` is a test driver which can be used to exercise driver
  configuration APIs without requiring capable hardware.
  Mock-ups and tests based on ``netdevsim`` are strongly encouraged when
  adding new APIs, but ``netdevsim`` in itself is **not** considered
  a use case/user. You must also implement the new APIs in a real driver.
  
  We give no guarantees that ``netdevsim`` won't change in the future
  in a way which would break what would normally be considered uAPI.
  
  ``netdevsim`` is reserved for use by upstream tests only, so any
  new ``netdevsim`` features must be accompanied by selftests under
  ``tools/testing/selftests/``.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#netdevsim

