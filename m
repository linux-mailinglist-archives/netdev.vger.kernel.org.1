Return-Path: <netdev+bounces-193127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6278AC2943
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D041616492F
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AC129899F;
	Fri, 23 May 2025 18:05:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CAB2949F4
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023513; cv=none; b=VWuZKRof3Nq/wezv3YYVhVQZRaM8iuaBj93pMg9qrzMuG0qHXoDGj8qGzeHYkhkq5blas8zl7s/pJFpZ/9Ycly12cmo3zwmKfUmeWVLNoHJ3YkQh96k21khFGVyFbIzV9XA5h49Jqzhsi2KgFjMsSR85WUU8ZNVxI59DbxyId9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023513; c=relaxed/simple;
	bh=vgQNg8uCMSs4zR97rFHmvy8dNP4vNUBCGwJsw5LuQRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJIi/N+XNkcFsWrNNnXWBf49HjSvoWDzDl2dkj7RcqKVq4vU9q5paGaYUP0p1Aa6eYSKnbmTHYiFLN7LdcC0oQ+3aXD5rpKYFfz11gCV9DaBqSEcsysIeBz01Q82hQjGEW7sGOZysyEiXmd29EVyL3+61u0rSmmSQNP4suCMqVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 710316035B; Fri, 23 May 2025 20:05:01 +0200 (CEST)
Date: Fri, 23 May 2025 20:05:00 +0200
From: Florian Westphal <fw@strlen.de>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	syzbot+7ed9d47e15e88581dc5b@syzkaller.appspotmail.com
Subject: Re: [PATCH ipsec 1/2] xfrm: state: initialize state_ptrs earlier in
 xfrm_state_find
Message-ID: <aDC4zH_iZ5ss08uK@strlen.de>
References: <cover.1748001837.git.sd@queasysnail.net>
 <73c9e0ad005210c0813316008ec69fe3da1bd4ba.1748001837.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c9e0ad005210c0813316008ec69fe3da1bd4ba.1748001837.git.sd@queasysnail.net>

Sabrina Dubroca <sd@queasysnail.net> wrote:
> In case of preemption, xfrm_state_look_at will find a different
> pcpu_id and look up states for that other CPU. If we matched a state
> for CPU2 in the state_cache while the lookup started on CPU1, we will
> jump to "found", but the "best" state that we got will be ignored and
> we will enter the "acquire" block. This block uses state_ptrs, which
> isn't initialized at this point.

Yep, I missed the "goto" and cc doesn't complain either.

> Let's initialize state_ptrs just after taking rcu_read_lock. This will
> also prevent a possible misuse in the future, if someone adjusts this
> function.

Thanks for fixing this bug.

Reviewed-by: Florian Westphal <fw@strlen.de>

