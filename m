Return-Path: <netdev+bounces-89260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883D08A9DEE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98B51C214C7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A4616ABEA;
	Thu, 18 Apr 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt1DZM5R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528A16ABC5
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452667; cv=none; b=c6fZFkpqcZnl00SOur31KVi991AthIN/8zR1Soc1qz6iKv8MuwV8lQnzoBkC7Bb31vbU70q12K9oqG4yWlgrq6v9ep/S9ofOYTPknzYihwS8+3YvMsIR+x/qljrkh44ZQa19U608q818ncDdVJk0boJpbZr4q3ioBrOYCYE5E88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452667; c=relaxed/simple;
	bh=i2agHyFC5ws2I+vLScJ13Xoe9wyHAl12mWNhpe2Knpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNXfvBMK392w3XtWw+Su2y1IgWisuA1MaicNQK2OacI0JHBx47Fj0hw+0QWs4dKFEXluCcG63VSnxLstPanATGtmo1l/vs3zBIcEqc9B61kpLDqNhegb6Zcj9oRjgzPd+rSxI0Sq+DRjHWPWyE6Arx3szOMg5ahTqQVHZp+mkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt1DZM5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68798C113CC;
	Thu, 18 Apr 2024 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713452667;
	bh=i2agHyFC5ws2I+vLScJ13Xoe9wyHAl12mWNhpe2Knpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gt1DZM5R44ObjB35aVwZ8ZhwH0lmrzttGlcgV0XRREDy5m/H/ub7+dSssWN2oYHQj
	 9LVKYOqByM8UPoCkkA84DXhv11gdURBY0rS/J+XTjNLCkMmTwfEJXAyLvtFvUBescq
	 92nZg+b828h+qeOAj0suROioz9PqF+k2CA1VxvhrqiBc2gkRlzvJ5ANk2XQ6EvGpNZ
	 J9/ipDNcKxHXOHI1XrrcwHCUhRn6yYyQlGELRrl6gR4dGXX66s1HnAf3iGxBDVPQ1N
	 h3uaEk5R+KrH9hRT6tEXesvGbcy0SM76Y5woBUihuAN5FVxvX0AXi1BAhtqzdwvzIP
	 0ZlheTqXnlwLw==
Date: Thu, 18 Apr 2024 16:04:23 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 14/14] net_sched: sch_skbprio: implement
 lockless skbprio_dump()
Message-ID: <20240418150423.GE3975545@kernel.org>
References: <20240418073248.2952954-1-edumazet@google.com>
 <20240418073248.2952954-15-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418073248.2952954-15-edumazet@google.com>

On Thu, Apr 18, 2024 at 07:32:48AM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, skbprio_dump() can use READ_ONCE()
> annotation, paired with WRITE_ONCE() one in skbprio_change().
> 
> Also add a READ_ONCE(sch->limit) in skbprio_enqueue().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


