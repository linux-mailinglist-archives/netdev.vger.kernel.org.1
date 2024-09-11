Return-Path: <netdev+bounces-127595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D6E975D67
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6688E1F232BD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257AF181BA8;
	Wed, 11 Sep 2024 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtG9kuT1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102614B09C
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095206; cv=none; b=qb8J30pBPXQbD+yRmF+CZMG1xgxrZvY7tN59IN8bmcUcq8q2BPSmPgSQ4bi7RKMulutCAWcAyHrzTkussopLJ8d76vQ4ttdNTN8zgFDE0cd2xn6Vi1m7wt2G6/d5pICDuG1SUmf/k0JguXUpQOjZcTS6Js+mI4v6FSx+llrp6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095206; c=relaxed/simple;
	bh=3TzezdTE7xvrbPx0sXbeKin53v+VhHRFb/xY7Zzhk5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1+2zemqO9VvLtHK8FKd5E84LpAbX8zNla0cCC1vh+Kv8TyAwS0dbDgb8Bb03rYVHNEDX7VFYZP0NS7pDBUkxqjYm0DbtCdIBsS7ZiigUa/gwz8d+oUKDmNkimrA1dJ/EHnVNe1i/FqapWNAm8fwPfp5xpuO8nuFUV7ftHppehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtG9kuT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D263C4CEC0;
	Wed, 11 Sep 2024 22:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095205;
	bh=3TzezdTE7xvrbPx0sXbeKin53v+VhHRFb/xY7Zzhk5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HtG9kuT137xbpY88Q8cFnHOEX2d/z6A5ftj0jct76gbP/qtQ+gEPNUYlamh0QszL2
	 uEpEJCeUqqUsWX7ZwPN99WSCuWNyQOjjZ8LERBfyCEH0R1E4rhgv+EIvjQ8Y9dDsh2
	 eY8YNuzwaeXoWq96Pl4rERTolifaTC7ES9CpUgd020IAV/ngmsotbbIsd6mKOWfzug
	 F62GaIhKX9i54EGUqw1WfS4I3EZDOhMujwX+t8kkxg7x7VblL73J8NssED1fIG4TY1
	 iw7omP/HOQ7g74ac6FQUFRuVQF517anw0iT1LXHQggvQRkE5YBRqKPMUezOi9uqs2k
	 U6DkqF16rHeoA==
Date: Wed, 11 Sep 2024 15:53:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net 0/2] net: hsr: Use the seqnr lock for frames
 received via interlink port.
Message-ID: <20240911155324.79802853@kernel.org>
In-Reply-To: <20240906132816.657485-1-bigeasy@linutronix.de>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Sep 2024 15:25:30 +0200 Sebastian Andrzej Siewior wrote:
> I hope the two patches in a series targeting different trees is okay.

Not really. Out of curiosity did you expect them to be applied
immediately but separately; or that we would stash half of the
series somewhere until the trees converge?

> Otherwise I will resend.

The fix doesn't look super urgent and with a repost it won't have
time to get into tomorrow's PR with fixes. So I just pushed them
both into net-next.

