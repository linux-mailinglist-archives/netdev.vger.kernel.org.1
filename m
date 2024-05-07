Return-Path: <netdev+bounces-93907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E178BD8E6
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DD91F22E79
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D41877;
	Tue,  7 May 2024 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvyyywHK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C41C32
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045122; cv=none; b=eqhcAI/ug4z3qdDgU6v8/m40YtuFywV4DIHj2GBUaM/VGIE39o+NLspe9+/Q9cgArCE9JvB03cyt9v3+O5LOQXtUHRHgN3VTLj8eeVCjPwHPkmKTPr5BjfGFs1qc0S2esg80G+b2p8Oy0YxTL9GAIpqYZueu41rp7SeN21mAlwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045122; c=relaxed/simple;
	bh=7YFcdiu50ARa+ziyjuHJexuRD3reVsdYnRta0qhWDQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0rVtgO/Q3sKciv2Xvi+lh3ymUWf+a8I/41k++tN5/fIW2RLO8CMm/5Q9yipL54BEGrOqLGE2bVOwHkjiIPpHmNMBYUkmAIAhM0xh/wMdf8aLtw9akDLe6TH9TTWfkX+Wb6u6vSb1IvFY8YgL5p72oEYHbO/0Po8GA0NuivBvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvyyywHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9EBC116B1;
	Tue,  7 May 2024 01:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715045121;
	bh=7YFcdiu50ARa+ziyjuHJexuRD3reVsdYnRta0qhWDQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hvyyywHKK70823qoUaH8czo07qYGtjEniWUNDbFUoVwkY4/Fp0T2jbBTLUAImdsAU
	 Bduh/tQ/j/6YHUMc4nMjDVTPtlMMGxpxNC22bUYn7rnu/OgqBvRkwO9ury06kSCc/v
	 ufREZmVK1t+GoqGPJEw6COcGWu10ENDNWTotNgtxoXGailK5CyOz4UspYlHzKERlwD
	 om0hj/qnC5TVNLjKM7cWZ5crgBZqdNsgsXLSW8TmGN9tXnHMEoD6QsNTOpyGUL33sU
	 VXexquUgkf+3o3rX6YsghD3GzI11XZ8mUbPU4Ca/Ns5c5YDVeXXz5EThRewaiCe6nJ
	 yyPBvxm9GRrHw==
Date: Mon, 6 May 2024 18:25:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shailend Chand <shailend@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, almasrymina@google.com,
 edumazet@google.com, hramamurthy@google.com, jeroendb@google.com,
 pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com,
 willemb@google.com, ziweixiao@google.com
Subject: Re: [PATCH net-next v2 00/10] gve: Implement queue api
Message-ID: <20240506182520.67044aa7@kernel.org>
In-Reply-To: <CANLc=avO2Xmkjh=VsvCkN=jUEOpSFN-74MkbtByicsRs+GANNQ@mail.gmail.com>
References: <20240501232549.1327174-1-shailend@google.com>
	<171491642897.19257.15217395970936349981.git-patchwork-notify@kernel.org>
	<CANLc=autjsuVO3NLhfL6wBg3SH8u9SsWQGUn=oSHHVjhdnn38w@mail.gmail.com>
	<CANLc=avO2Xmkjh=VsvCkN=jUEOpSFN-74MkbtByicsRs+GANNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 11:07:52 -0700 Shailend Chand wrote:
> > The last patch of this patchset did not get applied:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240430231420.699177-11-shailend@google.com/,
> > not sure why there is a "no matching commit" message.  
> 
> This is the v2 patch that did not get applied
> https://patchwork.kernel.org/project/netdevbpf/patch/20240501232549.1327174-11-shailend@google.com/.
> The subjects of the cover letter and this patch both are the same,
> differing only in their number prefix, maybe that could be triggering
> some issue.

The space characters in Mina's review tag are funny looking, maybe that
was the cause. In any case, applied now, will push once build finishes.
Thanks!

