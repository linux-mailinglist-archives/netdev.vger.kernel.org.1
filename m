Return-Path: <netdev+bounces-81738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F34D88AF3C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3448A2C519B
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F253A7;
	Mon, 25 Mar 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOIDrjmz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A51C02
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393464; cv=none; b=cBer3v1hr5wq5zrS1Lhcyg8uJ5JOiH6HaxX2LBhZPZWlTOQKok4ZHJxYoln1NF4IIdHqK6G673nAACOhD5YBWBX4/Z9XXlYEfwQKRlayPZKY4Gh3vrOiE/s1LMfuIrcRdZ8J6fyLMugBhe+fdw6XIHwu/FTrk1BEwfLV3Icx+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393464; c=relaxed/simple;
	bh=zIFH7tAy1k5IYse6zAz3Y26C5XbNiZvntT435nPqXvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/kMg+erXvWvu5/RvVqirAv+G/DJMQgL+z9zOj3eJEMji+vzG2kaqo8/ep56AC/yvTU7vhfurWD7fF5EwdIQg0fSwl+IIQFtGmNVcwGfo0MoTQ/3UCS3UZ3NyobWtPZneT0UnPL4Ch4eoPb+l7NxfQHiXHDfQEkUlDSttr9Kv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOIDrjmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7254AC43390;
	Mon, 25 Mar 2024 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711393464;
	bh=zIFH7tAy1k5IYse6zAz3Y26C5XbNiZvntT435nPqXvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOIDrjmznyQMYIEBFA14P3t0QKPETPYwnIToZsccjlOUMPylW0jcXGq1Nq0CCCOb6
	 /1NwZp/wxYU+o538WbXRRkUuLL8S/atuBqyLAk1EIXWKt3+RDawv/N7kAIoRVbOuLt
	 lISTCoGN1n9yeH8AKH+/mLfCX7m1NJpddj9K2DtUyT0FKhoT+VvrSkTJaZF9lHOzVu
	 YQJeyTEpQEaAxN5MlEg3uXMjnpxWATLw4mtPBrQpr251P+eqGgu9haFG/YgVOUsgvJ
	 emztluMoXLEfDLOnWcgN6WjJG53LtRuwksbkKa45yqQsV5jsWKmtx8b6Xz6Mmq1s0r
	 SX0uNR1I1SZww==
Date: Mon, 25 Mar 2024 19:04:20 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] net: remove skb_free_datagram_locked()
Message-ID: <20240325190420.GE403975@kernel.org>
References: <20240325134155.620531-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325134155.620531-1-edumazet@google.com>

On Mon, Mar 25, 2024 at 01:41:55PM +0000, Eric Dumazet wrote:
> Last user of skb_free_datagram_locked() went away in 2016
> with commit 850cbaddb52d ("udp: use it's own memory
> accounting schema").
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Not that it really matters, but I think this function had just one last
user until: 4af8b42e5629 ("SUNRPC: Remove dead code in svc_tcp_release_rqst()")

In any case, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

