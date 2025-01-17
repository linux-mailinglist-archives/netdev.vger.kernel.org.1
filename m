Return-Path: <netdev+bounces-159488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F0BA1599E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2827A2DF3
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE5E1B3F3D;
	Fri, 17 Jan 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXAn3DiZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CED1B0F2C
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154363; cv=none; b=WfWhHvmKr3Nz15Kxj+fRQ2ONDPsYCuWePLrXYbVCytXCerp3NgrhPncEacA5g53UsByBrH86TxnU882xc/RefQI5LytnWyM7mWGwxqfqJN3TndzpR0tH9wtBKNljWP8igrfXXaPIkzU8Zpx3m4hwyUIZHN+FzR/cd1Kb7ilmr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154363; c=relaxed/simple;
	bh=3/pOBt7DGVRkdttmNBGDzdrnhnM5FYvRk7Or1gyqnjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AedS6wYmYbGftkLUh/BqVjvSRAovRnUfrUmUbS0lbEyrG3yvI5KzPvIQ0QpJ//SflTxjWY4EEUspV0R32POhq8tEwUgeXwFOJtLfy8kLcEwL5vWdXO7G0PJCyCcteRYXcA7aNVN9OIDIQnHTHmFAlBxqv93/TPK4kudtXQfmaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXAn3DiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70005C4CEDD;
	Fri, 17 Jan 2025 22:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737154361;
	bh=3/pOBt7DGVRkdttmNBGDzdrnhnM5FYvRk7Or1gyqnjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JXAn3DiZg0+ya67Ac+qwH9zSaOblpVWUooRkGH/al9nPOHc3ad8V4AJyUkgaff2/B
	 4yghjBYptoB9y5y+5mxLT+SfKDIcczgLDQkD1pRtVRsuUMIj9kliUvN8OO4c4xtqqi
	 3xR1I16s0ZvW4ToqBd93IwwwrXPjF0ReyB8jQqrQvGcVSc6xe/RYsrMK1+5wCg+sWH
	 swBnHoH3/qxh7Qn42OBAZiVc+1S9L5aR2N7kEnF1Qd8MTWm6TZQ73wP/X5EvQf3f18
	 exDoqGpSFr/BDR2PQq5G+KFAbEwxu+nhnJp2FvnWNuAdy5MAzxH0MSFkOz0/F2/QSO
	 9Mjf9zp3MM0ig==
Date: Fri, 17 Jan 2025 14:52:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, horms@kernel.org, jdamato@fastly.com,
 netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 05/11] net: protect netdev->napi_list with
 netdev_lock()
Message-ID: <20250117145240.235c6f39@kernel.org>
In-Reply-To: <CANn89i+o79p0tYH=ttRB7rQUp62fTrVXcxGQ3MN1vw9ZcoBg6w@mail.gmail.com>
References: <20250115035319.559603-6-kuba@kernel.org>
	<20250115085711.42898-1-kuniyu@amazon.com>
	<CANn89i+o79p0tYH=ttRB7rQUp62fTrVXcxGQ3MN1vw9ZcoBg6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 23:21:43 +0100 Eric Dumazet wrote:
> > > Reviewed-by: Joe Damato <jdamato@fastly.com>
> > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> >
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>  
> 
> Jakub, has anyone sent the following fix yet ?
> 
> CONFIG_DEBUG_MUTEXES=y should show a splat I think otherwise.

Ugh, no, I didn't see such a fix, looks good!

