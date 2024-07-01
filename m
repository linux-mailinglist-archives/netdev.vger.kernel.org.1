Return-Path: <netdev+bounces-108298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BAB91EB5F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 01:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B63281CFE
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329D171E61;
	Mon,  1 Jul 2024 23:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpt6u+qh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF62F29
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877107; cv=none; b=IwY7aEFIy8IzdKxsMMfabrHbsincgIvt1NTPnZ2nSW1K+pZFQzmu8v+4bUXa4ehysnoMvXmqjl1WZQ0tw1mqGfuw07s82dfm0bPIgKgoJ+MhF3XxWyrx8O74QkKLIBfxcnmeC0sLZyOtPkeEVRuuswoX7xdKumjv1Ijvnzz/6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877107; c=relaxed/simple;
	bh=CPE+8G7msAL0cWZbyb+QXAsMN9tg/yR6FrexI3ct0Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CA4D9L60RhVRyZMezM5W9mFV9LD0RRNyx8MCWLDuq+g1S9HZZo4TS/Jrv2us2JEQVB1WyyFJVfz+QUK1Mjlz90WHUmhEhK9Ii3v169TsGgA0GIYp6/JMeIlepy+NB+jPIDj7D8SjEiQtkTfxCtN6uBoEUT4DXKE23NmaQA1OIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpt6u+qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE1AC116B1;
	Mon,  1 Jul 2024 23:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719877107;
	bh=CPE+8G7msAL0cWZbyb+QXAsMN9tg/yR6FrexI3ct0Pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hpt6u+qhRxmZGvWzf72sSFR7ZUd9/uU8wGWDjuCBJErqYO5BsMNXoUzsIdzl9aniI
	 8wnPTNEeAS6FvJr4coJMf5V082FvBSbeq7pAkCVimTIrCF66dcSbiqHCjyBQghoJv4
	 q+CASrZjnFFFwZ/w7+JYFsGY4xvH3IvRUB4j36K09rE27EMgGm5r5AIOGv9n5XPpCf
	 vxLp5QDRxvTtBQNgGty47lXJv13+bEVgA7kChPiTn9P0/+Z1zBt9eRLXrkRnv0pfhz
	 G8hyWDXScSP77N6OoeWlANj5m8Y4up7ZfFXXkDZGWDfHEcc4RWLDGgqLPUqSCjc3Xu
	 SjGzwiVILs3+A==
Date: Mon, 1 Jul 2024 16:38:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [FYI] Input route ref count underflow since probably 6.6.22
Message-ID: <20240701163826.76558147@kernel.org>
In-Reply-To: <87ikxtfhky.fsf@cloudflare.com>
References: <87ikxtfhky.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 13:10:53 +0200 Jakub Sitnicki wrote:
> We've observed an unbalanced dst_release() on an input route in v6.6.y.
> First noticed in 6.6.22. Or at least that is how far back our logs go.
> 
> We have just started looking into it and don't have much context yet,
> except that:
> 
> 1. the issue is architecture agnostic, seen both on x86_64 and arm64;
> 2. the backtrace, we realize, doesn't point to the source of problem,
>    it's just where the ref count underflow manifests itself;
> 3. while have out-of-tree modules, they are for the crypto subsystem.
> 
> We will follow up as we collect more info on this, but we would
> appreciate any hints or pointers to potential suspects, if anything
> comes to mind.

Hi! Luck would have it the same crash landed on my desk.
Did you manage to narrow it down?

