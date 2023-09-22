Return-Path: <netdev+bounces-35749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176C57AAEB3
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B17BA2826B4
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B41A1E52A;
	Fri, 22 Sep 2023 09:49:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D86109
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7280C433C7;
	Fri, 22 Sep 2023 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695376186;
	bh=C1TsA26h2PkSGFiFliu5DwMyoqefkmeglTLnCAP9d9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXC9DqJjION2vrfq9RuaaW315WVz0s0Wph7EIWJrIZT/07reUPbTcDSkOv8Ap8vBq
	 N1dNMWTVz1Gr2MFQuS3Ax0b+c+r62J5m1r+0tsjO70FzhGOg0U7M4y60WHjT9Fe5Hm
	 +Fgb8u5uF6e9gH1prSG5ljy80BEp3wFVmB8Ioq9AumoCGfcvaZ5ToK48d4DII7QbYZ
	 +JwCQz7Be91lwx9/7tLxgJBqTipkFmgC5fUyhRMeqfE4OBNi0isgbpthk98oDEe7uu
	 whOPNOW1toohMcpEzdhVX73Mcj6DiXppKeXdnB4SdjzJDY4+fpEmWP2qPnkuz0UFOr
	 dwfC26Utq/oWw==
Date: Fri, 22 Sep 2023 10:49:41 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] net: fix possible store tearing in
 neigh_periodic_work()
Message-ID: <20230922094941.GZ224399@kernel.org>
References: <20230921084626.865912-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921084626.865912-1-edumazet@google.com>

On Thu, Sep 21, 2023 at 08:46:26AM +0000, Eric Dumazet wrote:
> While looking at a related syzbot report involving neigh_periodic_work(),
> I found that I forgot to add an annotation when deleting an
> RCU protected item from a list.
> 
> Readers use rcu_deference(*np), we need to use either
> rcu_assign_pointer() or WRITE_ONCE() on writer side
> to prevent store tearing.
> 
> I use rcu_assign_pointer() to have lockdep support,
> this was the choice made in neigh_flush_dev().
> 
> Fixes: 767e97e1e0db ("neigh: RCU conversion of struct neighbour")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


