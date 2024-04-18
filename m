Return-Path: <netdev+bounces-89259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06C8A9DED
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706901C21D2E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AAB168B11;
	Thu, 18 Apr 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5UH6ktI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2D1649DE
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452646; cv=none; b=q5XUdU3QKcSNMlmK+FHo4GQ84ozmDv6RUrUfy/Upj0wks2vqAmwRSmxIqWjpg8z8Wq9E9ck29QSljza6Xxq0EAM9MAWjsOkXfRSUj6cdQkZ1ExtRRvrjaLaZ5tJr61q2cQBZrkCxOpN3y2Vc4QJsIS7LKKST6L1xV4AyU8LP4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452646; c=relaxed/simple;
	bh=B6FBkxX0iBNew+qJnciHbg9JLG36D99pyVQg6gP84vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZ7gwVOL+6SJWdkQu1hQ+7eAcFtk+3Hlcizcp8OrHTiyRIbqyaN/FcO8olMfSTUHZ/iWEkvandEJwgCgdOjQWe2rlAgKA0dg81bTxuYlESbF82hqJ9FFULJEvc9SXF7ODRG3pIXIZHAWWS4SBLinlUbe1hOxvVhT6wGen8ekqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5UH6ktI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF836C113CC;
	Thu, 18 Apr 2024 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713452645;
	bh=B6FBkxX0iBNew+qJnciHbg9JLG36D99pyVQg6gP84vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5UH6ktIy/OApmZGAccqi0SpWUPmdylx3wNtq3oHGkartJpyT/6wWRkT/bAeVvrPO
	 WZ0EKj0y1WOC5+/izCIJJ+1qL5tCwY7q1ra4WQmq1I+q2kY4zvgopfC6irQr3xCTIz
	 zvEEMJ7okANPnxyetqFD47GRy04BHmnkRhv4LBNbD0BnJjUFgECSesRJnJWlc9IdbT
	 MUS6X8Y4zpm4cOOVuMp+gr6zJvdG2ZIq2d3Ed+mdhRsS4eQSbnrHVZaeaLraH5AQ4e
	 lAwfBY4QPkXLFd1l7Rm2W2KEV4U1ktTnuFBxa7pPWm62K++GJwAm5QcFqPEzb4ATC1
	 sQ35wdB/nrXGw==
Date: Thu, 18 Apr 2024 16:04:01 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 08/14] net_sched: sch_fifo: implement
 lockless __fifo_dump()
Message-ID: <20240418150401.GD3975545@kernel.org>
References: <20240418073248.2952954-1-edumazet@google.com>
 <20240418073248.2952954-9-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418073248.2952954-9-edumazet@google.com>

On Thu, Apr 18, 2024 at 07:32:42AM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, __fifo_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in __fifo_init().
> 
> Also add missing READ_ONCE(sh->limit) in bfifo_enqueue(),
> pfifo_enqueue() and pfifo_tail_enqueue().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


