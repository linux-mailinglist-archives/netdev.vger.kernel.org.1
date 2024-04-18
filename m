Return-Path: <netdev+bounces-89233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AEA8A9BDB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C8E1C22156
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502251635CB;
	Thu, 18 Apr 2024 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqmqTno8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4E161912
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448657; cv=none; b=ZOl7bLpcPOFO/OMp3HAMn597LtLHqWEQhqkugxjaoDEM/RkOg+Fxjyige90f51eMvubzs8NcBrkb39eX0mbZFK00v3HzTvV7UsP3sjJDfJ5/E7Zn2ZKFSDWZ7/bcwn03l8CdLby8K0Jux7KFo6qxLBBITL+DcrpFnDG4sJXY1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448657; c=relaxed/simple;
	bh=DiUF577G3+0Oe2yo+K3FWHtAJSAxlxD6/97iuH1DL8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bowVNQzrepr8PeGgEWmulXK2SsWk4J2svNvFLRnh1eiHhM6VVSvJxe7bi8kSa3tI1gkGmPLjejdogoCgv7tBuWIcP9pw7rAFuUiaxJ2D65u+V5whflLHba2AnPeS7IShRlan/xB1oMVRv4y8PPNLMBNoH0OzKyQU1OIzSfcl9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqmqTno8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D41C113CC;
	Thu, 18 Apr 2024 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713448656;
	bh=DiUF577G3+0Oe2yo+K3FWHtAJSAxlxD6/97iuH1DL8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqmqTno8oiP+vf/F7aEa2TBoj34jYEsh5VFXSB9xT+flMNJ/1bLRLPbviKjCeFcCe
	 sMiXasKn2/Qbk9WSFLeE2m7SDFJyDra7tYdWZ/F9YyaZyVeApnnGm8HYxW5h2tNijj
	 izlgLmdjzRz36/bTS+dy5b4AmLfP9/vyJWYWFJWCQLNYzHXVjZ9jMIsRtOoyvye0t0
	 b0z/IoqALcG8u52K6fICxpXjUFP6HmYN9kvWR4HiBAszpIdIEFMScTeendE0wL8ou2
	 NBXplSSEJFD9FdLvHc+u6Idqlqh/h7RVeQZXBDpRZAwAmNg+vVF0kuRzmdQfC/nx3l
	 thyvl3QYhEvgA==
Date: Thu, 18 Apr 2024 14:57:31 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: Re: [PATCH v2 net-next 02/14] net_sched: cake: implement lockless
 cake_dump()
Message-ID: <20240418135731.GB3975545@kernel.org>
References: <20240418073248.2952954-1-edumazet@google.com>
 <20240418073248.2952954-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418073248.2952954-3-edumazet@google.com>

On Thu, Apr 18, 2024 at 07:32:36AM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, cake_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in cake_change().
> 
> v2: addressed Simon feedback in V1: https://lore.kernel.org/netdev/20240417083549.GA3846178@kernel.org/
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Toke Høiland-Jørgensen <toke@toke.dk>

Reviewed-by: Simon Horman <horms@kernel.org>


