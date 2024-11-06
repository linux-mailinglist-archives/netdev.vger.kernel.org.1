Return-Path: <netdev+bounces-142567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E529D9BFA50
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB50D283523
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ADE20D4EC;
	Wed,  6 Nov 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbZSbPkS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7816383;
	Wed,  6 Nov 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936631; cv=none; b=sOYkB7VwsaQuzsrK+Ox8zEzFTV1yHO9D4vS7FCermcVNeDERbEsr8SEDXKqXQnfKJzFEefIsHDvKBmbLnpdVBHL3pqoneeT61jWEr5KUksLQtGY269fMUw5+DjBIMaWgIoONggc/+2KpRJABViBi7llMTIxfMFnfdF0YsXGyTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936631; c=relaxed/simple;
	bh=oMSx7cFQsJOJ3gwqkz//mcLuJs+BFCUAs3k7bmsmUY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zb5f9xp8TbGKMeb/Hl89yt1t1KVKVY0i550YJCyObwsFPY5GxESBlQGe4+ds9R1Dol1FpyxUDIBN2lfmCSwz+7vVcuaajTLCac5FspmtkaEwEs/3joh+kgTB5u1aT5IwIicgV2X+6iDk8Q+lCFTcyYih8sRWifG0z37YkAHuFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbZSbPkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE20C4CEC6;
	Wed,  6 Nov 2024 23:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730936631;
	bh=oMSx7cFQsJOJ3gwqkz//mcLuJs+BFCUAs3k7bmsmUY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TbZSbPkSNcthL4E4qxLl/J1Hk7/M7JdBB4V1JqdqR3d73fFffar0HtCDxq8xOAY9B
	 jNa0p235LqhzrYckydXfqxgFjRWlaKmty/1321mzyr+MLu/gNfJD8UCf7adjnfC2Ac
	 /5PCng7LALzeP/CBf8Mv9NWxLARJJo7s9J/W0nCAbqJaEoNyoxnt+XOa2XOgymJceY
	 APUlP1bVa0j/OCOaFmD6Hp/iOyqiISX/r4fB7eDvm1NrqomvgDfyaXA21Me10MepI/
	 Z68s1CQesR1HuR9UK8uz8MJEJaqW6GDO6DZ/W8QrAb1OstKdR5rCt84hdR5kJwd6fd
	 NA3cvSlfUG/Dw==
Date: Wed, 6 Nov 2024 15:43:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, vlad.wing@gmail.com,
 max@kutsevol.com, kernel-team@meta.com, jiri@resnulli.us, jv@jvosburgh.net,
 andy@greyhouse.net, aehkn@xenhub.one, Rik van Riel <riel@surriel.com>, Al
 Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population
 until setup success
Message-ID: <20241106154349.0ebca894@kernel.org>
In-Reply-To: <20241106-gecko-of-sheer-opposition-dde586@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
	<20241025142025.3558051-2-leitao@debian.org>
	<20241031182647.3fbb2ac4@kernel.org>
	<20241101-cheerful-pretty-wapiti-d5f69e@leitao>
	<20241101-prompt-carrot-hare-ff2aaa@leitao>
	<20241101190101.4a2b765f@kernel.org>
	<20241104-nimble-scallop-of-justice-4ab82f@leitao>
	<20241105170029.719344e7@kernel.org>
	<20241106-gecko-of-sheer-opposition-dde586@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 07:06:06 -0800 Breno Leitao wrote:
> To clarify, let me take a step back and outline what this patchset proposes:
> 
> The patchset enhances SKB pool management in three key ways:
> 
> 	a) It delays populating the skb pool until the target is active.
> 	b) It releases the skb pool when there are no more active users.
> 	c) It creates a separate pool for each target.
> 
> The third point (c) is the one that's open to discussion, as I
> understand.
> 
> I proposed that having an individualized skb pool that users can control
> would be beneficial. For example, users could define the number of skbs
> in the pool. This could lead to additional advantages, such as allowing
> netpoll to directly consume from the pool instead of relying on alloc()
> in the optimal scenario, thereby speeding up the critical path.

Patch 1 is the one I'm not completely convinced by. I understand 
the motivation but its rather unusual to activate partially initialized
objects. Maybe let's leave it out.

The rest is fine, although I'd invert the justification for the second
patch. We should in fact scale the number of pooled packets with the
number of consoles. Each message gets send to every console so system
with 2 netconsoles has effectively half the OOM cushion.

