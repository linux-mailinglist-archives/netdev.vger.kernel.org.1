Return-Path: <netdev+bounces-144140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D8C9C5EB3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE35B2AD30
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E2200121;
	Tue, 12 Nov 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP2Ua2uY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CDC1FF5F4
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424703; cv=none; b=aA3ZaYKNlSgE5niV9niRUyfi3/wL61qDgIMnSrKGD7JmHcfIMs9FW0ylSTwarD17+l+fwJCwTZXQu5Vm7etvEKRNdQiiNaLXR7ofXz+xUsVE1pTVTiIlDM70EhQhvrrgojbNuQq65JTcKZFAMyVW7d/yW7ual1rbmGni1tKwT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424703; c=relaxed/simple;
	bh=nth3J6FETCjuT0ZhgJ2WbzVPX+r5vZ9cXKeYs8Mwt5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDzJgUDF+sOF6B5Y8yj8dzMVoLj+vchOu+lOACTIu6Bp4NRtCg8mKVfgJQRK3kE1aucBy0uYfmT+rjB9qJWLy1TFWfMe4t6vM89ILfpRard7uvS6DYP7dw7ToVQ7Uy+tfytIda95RIH+5XvvTc+O0uBgmf3ReI7v0SCrZdFWBRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP2Ua2uY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF89C4CED0;
	Tue, 12 Nov 2024 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731424703;
	bh=nth3J6FETCjuT0ZhgJ2WbzVPX+r5vZ9cXKeYs8Mwt5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GP2Ua2uY0cnb3MK4O/2GZKsIBKct+UZyU3hCcHaX1CQG22At/E9vXMZdlcXPRLZ/w
	 bJk3vd2emzym1+PsQeNzfSee0G0eFJ04I2jbSjkjyqppebh50A7TveSlWQOCcfkoeu
	 K+nGli3BanOjIis7VJio547h92+1ohhB7k3KqIlw8VvCjnAgJCJ94O6dQYA00f92t0
	 ikGEIuhD0Xa0Hz2NAIT6RapO5o+LEN+EFMHFPS3gLHnKSwGsIA0714doTdLBiDhGHN
	 0IgHcmAZHgE8gbrDt5oVPimIbZ3CpjyLh0APp+KkjQHd+4oD8qCuatMDjEbn+77DBT
	 qWH8fdTOvWXkQ==
Date: Tue, 12 Nov 2024 07:18:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, alexandre.ferrieux@orange.com, Linux Kernel Network
 Developers <netdev@vger.kernel.org>
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic
 failure to free IDR entries for hnodes.
Message-ID: <20241112071822.1a6f3c9a@kernel.org>
In-Reply-To: <CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
	<CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
	<20241111102632.74573faa@kernel.org>
	<CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 07:23:29 -0500 Jamal Hadi Salim wrote:
> > Separate patch - okay, but why are you asking people to send the tests
> > to net-next? These sort of requests lead people to try to run
> > linux-next tests on stable trees.  
> 
> AFAIK, those are the rules.

Do you have more info, or this is more of a "your understanding" thing?
E.g. rules for which subsystem? are they specified somewhere?
I'm used to merging the fix with the selftest, two minor reasons pro:
 - less burden on submitter
 - backporters can see and use the test to validate, immediately
con:
 - higher risk of conflicts, but that's my problem (we really need to
   alpha-sort the makefiles, sigh)

