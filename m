Return-Path: <netdev+bounces-79681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8087A8D5
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14685B22D59
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5D42077;
	Wed, 13 Mar 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQrq4V1M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99743AB2;
	Wed, 13 Mar 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338246; cv=none; b=k2X7/34H0iX7jbfjjVVUhSUiVwsbcPVe9NH6/LdGyWNXcaFcvl0lMHJIjbvsRwzyEV8YlFE4s5UObz5Hj5sxb2Dt9PxrnvyZNn4F4ArULYIEXzBD8xja95SjRXy7qGpX0T/3nmaFtuZyEnsEfs4o3jY47soseJd6WFV4SexfneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338246; c=relaxed/simple;
	bh=KK7opGThc5jVikuIZOARKvcqSgweVwoAbK4+fL+Z7i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeKS3PsqAwNHROKYg149tcO8glTDT2tuxn/FTY78VS1ycT75/AY+wt8vHYZTArFOdJzrFQL6cuYt+fUPSvJKFwuf5Ixy1tkmZSMnFbsZI4LNc7q/UT0xCjIgGjd7U1axtUsXG4PTeWlRpf25lS6jCpSnqkR8i6u0ZrJc1iw/5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQrq4V1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1073BC433C7;
	Wed, 13 Mar 2024 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710338246;
	bh=KK7opGThc5jVikuIZOARKvcqSgweVwoAbK4+fL+Z7i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hQrq4V1MDwQCQbkfiWfTuBhrm3ro/rZ+y/D+/Q7pUR/BySOCVcjwGZe4ycQTSaesQ
	 KdYFvR0n12l8Cx0EXso3LMYSGgUA2gWzwpldGaL9a0Ba7Vw/qFgCWxRVD2ubg0D1cY
	 asxYK1AGTNj63+c8gihwd45nwVogogSN4VLs9pIDT1ombW0q8FPBetp9HoWhh3qXK0
	 hNgE68Bx2Sq9UlMfyO4hx3QLG8xnmCjEnEhE+geJs+UMJ+X69oEIw3GGrG1jeLzKTG
	 U9mojRHusR5SNubDqfNnGZALhsua0vN5Um1Sz7qD19/dJAaRyEv2SVIzOmzvwnYPO2
	 rfRhdBDEmU8TQ==
Date: Wed, 13 Mar 2024 06:57:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Ignat Korchagin <ignat@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH net v2 2/2] selftests: net: veth: test the ability to
 independently manipulate GRO and XDP
Message-ID: <20240313065725.46a50ea8@kernel.org>
In-Reply-To: <ZfGN6RTBCbEm6uSO@localhost.localdomain>
References: <20240312160551.73184-1-ignat@cloudflare.com>
	<20240312160551.73184-3-ignat@cloudflare.com>
	<ZfGN6RTBCbEm6uSO@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 12:28:41 +0100 Michal Kubiak wrote:
> On Tue, Mar 12, 2024 at 04:05:52PM +0000, Ignat Korchagin wrote:
> > We should be able to independently flip either XDP or GRO states and toggling
> > one should not affect the other.
> > 
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>  
> 
> Missing "Fixes" tag for the patch targeted to the "net" tree.

it's adjusting a selftest, I don't think we need a Fixes tag for that

