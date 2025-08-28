Return-Path: <netdev+bounces-217880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B406EB3A45E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE105463BD6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5FB22A4D8;
	Thu, 28 Aug 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQwVGotn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E5229B12
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394730; cv=none; b=rk/zDHbh/Gvg9iquc0rodP/t8TD+8lmyD8x2C9j7+0JE32tukcaDKgX68bXhFHJrKDcxGGnN2n1ECjYpCG/baUZV1ZPw47lFyoAARxWXmwErUd6UbBSlGtvPAoPMFEmY2I0ys4p+TZYBch9KdMmw98oTYSkV+vj/HIv4lNLmfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394730; c=relaxed/simple;
	bh=4E2v68CZChf9VPJClZt0WOh0kQnGGrZKOFCrNY5KVmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3oO86Fgu6ZqtLsdbIBMbIa/RGGmgInEuGikxpwc3aAFA6z+Y64vA5b19kp272/Ko3yCvT23Qj2tCGSR1K4PDyDcSx7oHsp9VY00yWeYR9qHyWrfKcRVA2GDhqs7FMb7XhjS8mOjKMdXkUauB0zZkXG4FMO7uhKYeQ+R2Z26TPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQwVGotn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB715C4CEEB;
	Thu, 28 Aug 2025 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394729;
	bh=4E2v68CZChf9VPJClZt0WOh0kQnGGrZKOFCrNY5KVmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQwVGotna1OH+9DqitxJXxdyeE4Vp+mttzlqpXkAP15zbQeuUHaNU2xmnAJ3hOTSI
	 M6PzHFB1yuiYpbn/YnsJbA8sPvJBh1I+WkFQ+zNi9vIoQhG9StlzW/uxVUjwFDXjPT
	 AvnahMlGxlpXFzjr/mxJRPB1ByEjxwkVS0S7wLcuG/eee/3Lp0e4Rt23A6gHEJQJZ4
	 XTP5OL/R06l6t95xF6zPEAaSn3j8U9yQeJpKHoIbOaUH4ENjVjkIqoBDD6Bl2G+TkE
	 hlZZQwsOJFXRE+ieelxqeSV1K7RPeZM/8LF1e3kMmXOb1PqT1sZoNYZ7q5RmNtHCfT
	 P1oVa2D/rpOIQ==
Date: Thu, 28 Aug 2025 16:25:25 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/4] net_sched: remove BH blocking in eight
 actions
Message-ID: <20250828152525.GQ10519@horms.kernel.org>
References: <20250827125349.3505302-1-edumazet@google.com>
 <20250827125349.3505302-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827125349.3505302-2-edumazet@google.com>

On Wed, Aug 27, 2025 at 12:53:46PM +0000, Eric Dumazet wrote:
> Followup of f45b45cbfae3 ("Merge branch
> 'net_sched-act-extend-rcu-use-in-dump-methods'")
> 
> We never grab tcf_lock from BH context in these modules:
> 
>  act_connmark
>  act_csum
>  act_ct
>  act_ctinfo
>  act_mpls
>  act_nat
>  act_pedit
>  act_skbedit
> 
> No longer block BH when acquiring tcf_lock from init functions.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


