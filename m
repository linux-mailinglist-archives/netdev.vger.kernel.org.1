Return-Path: <netdev+bounces-211680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A48B1B213
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD539163271
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEDE2E36FE;
	Tue,  5 Aug 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDGcUQcC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD52566
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389939; cv=none; b=sFV7w4bN2CZIVQpmmNmdumJPiUxwGL9lGjNtWjV/VNR3AvNJx3kbPKzCstuJzqJXm+fnx7ShUJ5qbC4iI0nhZ877oA9iubBwTnMz25ym/5gRJEK10UXj7Dy0jGYK0aRp+JkuHEK2Gz3uxynlditLbS2HX1MSuReIOBIQj5kAjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389939; c=relaxed/simple;
	bh=okIbm/EZP1V9e+G6qtS/F2HlT1eO3T6MXrlyZtYu4BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDRQUmzbcPVYFTs6N7CkBKKa1FoEG03UzuJ12fnm2GVgY+TqXugaDSYDECg2cvOnct7H2qhwSl0slrD2iFlZdpr5DD2fVacB2oBx3GmraI/VfPjKlstNF+vQMzapqmoV7guduKAhYy8NjVZkAZMc/ls8ZLBPtop+npXAJnNs0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDGcUQcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350B7C4CEF0;
	Tue,  5 Aug 2025 10:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754389936;
	bh=okIbm/EZP1V9e+G6qtS/F2HlT1eO3T6MXrlyZtYu4BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDGcUQcCK4v82y6pigp1RrZtRWyTnkfB1+ztr4K2cxnEHIflFPg1ycBU8JXAsqLgl
	 ugjOWsyDYNxjMJ/6Csh0YZcZMBUVxfa1mkId3gW0xu+v7NJPmQYsTLwKxVB1HAwUSp
	 BloC/k3uVsomqUFCkgIIDDuEKdf+8+Uexl6Z5QxUAB8BQbnCbugSer7QkMF0sRo07c
	 Gk11DjFlTOlbTOeCVFs1jwRa5XETYy0k45CmjlIxNsXtKpNdS38wj3BH+KogHLKE0k
	 F85uGL3O9Zu4ZkWyi97JzdSOj6AaXex3V7SmyO/smAPthuicOzCUt5W3OCQ4aWE6SL
	 k5JH6MBNVOX8A==
Date: Tue, 5 Aug 2025 11:32:12 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
Subject: Re: [PATCH ipsec] xfrm: flush all states in xfrm_state_fini
Message-ID: <20250805103212.GX8494@horms.kernel.org>
References: <beb8eb1b675f18281f67665f6181350f33be519f.1753820150.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb8eb1b675f18281f67665f6181350f33be519f.1753820150.git.sd@queasysnail.net>

On Mon, Aug 04, 2025 at 11:05:43AM +0200, Sabrina Dubroca wrote:
> While reverting commit f75a2804da39 ("xfrm: destroy xfrm_state
> synchronously on net exit path"), I incorrectly changed
> xfrm_state_flush's "proto" argument back to IPSEC_PROTO_ANY. This
> reverts some of the changes in commit dbb2483b2a46 ("xfrm: clean up
> xfrm protocol checks"), and leads to some states not being removed
> when we exit the netns.
> 
> Pass 0 instead of IPSEC_PROTO_ANY from both xfrm_state_fini
> xfrm6_tunnel_net_exit, so that xfrm_state_flush deletes all states.
> 
> Fixes: 2a198bbec691 ("Revert "xfrm: destroy xfrm_state synchronously on net exit path"")
> Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
> Tested-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Sabrina,

Looking over Git history my understanding matches
what you describe in the commit message.

Reviewed-by: Simon Horman <horms@kernel.org>

