Return-Path: <netdev+bounces-71691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2AC854C25
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBF3284FCA
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B755C3C;
	Wed, 14 Feb 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNrbQu8B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8455B66B
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923091; cv=none; b=U0mQdfnWlG0TjJfl7Y3VUs0mCzU1IOy0Ehg1UwDuJJ2oUXRgWb+wU8/UOofR6i3LoM0QPgxqgjSbtbwHJhVEeOM6YgaWJlFAQXctYhWFBgB2Qey0kbBGWkc8sMiLdPZBHNBT5mP+YiLufbG/Jh5t7VplBZa4yEp7enGYczfhFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923091; c=relaxed/simple;
	bh=A95NGF29PBxc0BGMGbms7a54dK9aTQ67qdW3NnvlnZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLbGT586U+LLv/CLwiOthoZ/qDxCTl9LDkybm/gBPh3FjDEH18ApbAhHI9LFk9UmRgeDedYIm51GyNnYfkQRZiOoQdk3hC3WtcvZfq6jRnfwOH1CiPfD0N666b59eXNAtdYbKGuSoTjMAuFcwtfVUxugyHHYm4rt4bD9VOdc8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNrbQu8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BA5C433C7;
	Wed, 14 Feb 2024 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707923091;
	bh=A95NGF29PBxc0BGMGbms7a54dK9aTQ67qdW3NnvlnZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oNrbQu8BmZFbUpC/Tx03uGh+Yn4fd7yxMZrCEtG0UBPAAjS20bI9XmoB3eG7DvPN5
	 Twm4alpddELI4UBEQFU1GnKeX3YKtV6TcaGwIJ4wvNCJ3pDQCY50sEXLWM5XT4s/xQ
	 8sYkaRqFzOidGTdf4NcllFKZ5xikqNkimbYjUY26v6FECL0rnIAv5QpC4DoUO02+7B
	 E3utr30a08G7R2/RX5tqFCa8QbwRwVA2iTQ7tiBh2uDrXrtU4hfMylfl3hKEaTPuI7
	 CgmUKUNc3+eh+PwjTiV5MA3QMHY6cUY0hB27boqAOiTO04NhMaFX5Kh9qek7qMyS4O
	 nkOuGCSsxK7sg==
Date: Wed, 14 Feb 2024 07:04:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Davide Caratti <dcaratti@redhat.com>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, shmulik.ladkani@gmail.com
Subject: Re: [PATCH net v2 1/2] net/sched: act_mirred: use the backlog for
 mirred ingress
Message-ID: <20240214070449.21bc01db@kernel.org>
In-Reply-To: <Zcx-9HkcmhDR5_r1@nanopsycho>
References: <20240214033848.981211-1-kuba@kernel.org>
	<Zcx-9HkcmhDR5_r1@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 09:51:00 +0100 Jiri Pirko wrote:
> Wed, Feb 14, 2024 at 04:38:47AM CET, kuba@kernel.org wrote:
> >The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlog
> >for nested calls to mirred ingress") hangs our testing VMs every 10 or so
> >runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> >lockdep.
> >
> >In the past there was a concern that the backlog indirection will
> >lead to loss of error reporting / less accurate stats. But the current
> >workaround does not seem to address the issue.  
> 
> Okay, so what the patch actually should change to fix this?

Sorry I'm not sure what you're asking.

We can't redirect traffic back to ourselves because we can end up
trying to take the socket lock for a socket that is generating
the packet.

Or are you asking how we can get the stats from the packet
asynchronously? We could build a local async scheme but I'd rather
not go there unless someone actually cares about these stats.

