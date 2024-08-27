Return-Path: <netdev+bounces-122193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC919604E4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBDD1F21872
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA43197A92;
	Tue, 27 Aug 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzhLSjPW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089901EEE0
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748773; cv=none; b=Zo2bd1ZSkOMfEksS0dig/yhHji+qDmUWVgwt8OgpOvQDuCLIKMyo45mpqR4S1DPooS0hTU/LrUqbCDTUxomFes81Nretmd3wH+3BT+wd4cJgb1RnRGJ9xn8q83wKUmsZ7i21gMHLwgG/rQXRkARWmtVjgL0QCEfnnyTJKZ9r4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748773; c=relaxed/simple;
	bh=pr6wzhBwzp71oVi0jNwwvo+5R/Wi+iMFxnuuf2AH71Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKvVvt06LxI2ojh4VwWmI6d4xZxbn11jS9Zln+0Nw+aLfsfou5/GUqgo9ip6O0hr/neRlpldSAG0eTVPsuy5eNntZIOraMYLm5MbyHgTWflZ5eIwNeb/bbjG6mkBKtnnm1Va901qxi1ShvycCK6CjG9xZB9GcNtFwVvuImUpPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzhLSjPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47E8C8B7A0;
	Tue, 27 Aug 2024 08:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724748772;
	bh=pr6wzhBwzp71oVi0jNwwvo+5R/Wi+iMFxnuuf2AH71Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzhLSjPWpSY5AEXRzEOE0dfnmZUnxKk0S90CnNj/KaNXMKSXJggjzWMxKcy9Cqh8B
	 7bbZQtu5PNuA2YtitswaJRkDjK2r1hZw7Z7kC5F+DTVZRer7/rRJfe/oB58tqbm4k2
	 MTjX2KKMVwZA8l7olsVSlXBGUq88+TMHoFNXXmIPsUfR35phiF6gzVMArnU6kpsHKy
	 JYkuMq9kuGtUVtAdke769E1lGb2LZMz9vH8RTygJgAbD1C2a/q188ESYOwUPPpAbBu
	 M32ivff+NLg+nYQnhMTfuHi4n+pe/Z08YgRzhhDQwZkBUOhMwhbodjZAAE4iVZB3pK
	 PHPkWFkhO/YZg==
Date: Tue, 27 Aug 2024 09:52:48 +0100
From: Simon Horman <horms@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net/ncsi: Use str_up_down to simplify
 the code
Message-ID: <20240827085248.GB1368797@kernel.org>
References: <20240827025246.963115-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827025246.963115-1-lihongbo22@huawei.com>

On Tue, Aug 27, 2024 at 10:52:44AM +0800, Hongbo Li wrote:
> In commit a98ae7f045b2, str_up_down() helper is introduced to
> return "up" or "down" string literal, so we can use it to
> simplify the code and fix the coccinelle warning.
> 
> v2:
>  - change subject into net-next
> 
> v1: https://lore.kernel.org/netdev/20240823162144.GW2164@kernel.org/T/

Thanks, but another problem I raised wrt to v1 still stands.
There is a dependency of this patch that is not present in net-next:
commit a98ae7f045b2 ("lib/string_choices: Add str_up_down() helper").

So I think you will need to repost once that commit has
made it into net-next.

-- 
pw-bot: cr

