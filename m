Return-Path: <netdev+bounces-88784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB8C8A88D5
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D691F219C4
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E32148821;
	Wed, 17 Apr 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPJkAJ0R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2821147C9D
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371264; cv=none; b=PKl/GvwiEcMCPsTLGZ7HnQpMaUEqYFkjCn9GEPzDE5rs91q3gircjYtGKllyp2qweELTeRM8+zIf56BNGoHXD4yJnEaLtAG74PamnxZon7B4aIx8UOKeaMZSyvpUtH2igDICLoWqDGJVzVWUTiTV60aS1A1pBPksJZEZYPinpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371264; c=relaxed/simple;
	bh=8MW2mLA2iS8lk+H30VfJZPVvnQGjEUX2QNEgpnep7Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eajN7ZFNBCJUlbN/DiCm/hxYB+VXrQ/x8OSqtNA6qixLhhlhTQUW+53szmhjPMX/b7OFP7BXGfzNd564ugZFNZJs7LwpqPmfpxwYMHbH3MawZnmWBuYu7+12hVCmDkhzO7j7rsatGvtapg8PLAAEDW105fIFhHMDE0822NAxF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPJkAJ0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D690C072AA;
	Wed, 17 Apr 2024 16:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713371263;
	bh=8MW2mLA2iS8lk+H30VfJZPVvnQGjEUX2QNEgpnep7Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPJkAJ0RUOEOFNY0558GlYOQMw5F6lergrqXkdc463aZaqcbOwtSMhKWIcbDPd7gb
	 N3tLSjjjXjJROP/P4RujI99eTYLzRMKS77qdGe+WVktiI4hC6JmSQPoiOoQ7nGgfJg
	 e9SLOXzdT0ltZPUoWnyH+KL30TBTIDX1U/6e7bOs9LHeUHfxV09gD5ycxXu+R7KVdg
	 F+wixObIN+bdsxAY4Cdb1cjyS1T6ZbpJ1O+UUuY1DMg+ai16udtGL5wRy4+Ga/jQ4F
	 COlEWxEy8MRP+h0XjhzOvA4z69jT5hO527wIsdIn8/B5ISQGqmM++Vn/9mCbzSHRz2
	 1CJIlYES2NrxQ==
Date: Wed, 17 Apr 2024 17:27:39 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 06/14] net_sched: sch_tfs: implement lockless
 etf_dump()
Message-ID: <20240417162739.GC2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-7-edumazet@google.com>

On Mon, Apr 15, 2024 at 01:20:46PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, codel_dump() can use READ_ONCE()
> annotations.
> 
> There is no etf_change() yet, this patch imply aligns
> this qdisc with others.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


