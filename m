Return-Path: <netdev+bounces-104426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8CC90C794
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205371F24167
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BA1A01C4;
	Tue, 18 Jun 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrWywNC4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEF13A401
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701471; cv=none; b=qUXEsMVylkZrF2J33vWaiComydo+TUPOQzJ20gZrD7QpwTO1qV8zhLkU9dVwIEy2s//Q7e6Wniw2FgYAnGlQpY5f3jhw3Hra1wcT8tPLPh8m/KSg4xn9PjC6aUjWPLHumn+AlhvL3oSVPdD9UPXQ3oksL4sCdhUyAQxxB+nqiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701471; c=relaxed/simple;
	bh=/7ajYiEcWaOfoFirXPrwKlflRmQu2KJc61rL+aBMbTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLnSIDrLnDNUxtj1rMkCK7dikvCl5X1ohFyUwnyuMovU+1QETr7NrRf8X8f1r8gulgs8IV/SxzznA0VESp2BScH11+DfsQjIyfakBkhuD+UN2dPAZWCxfSO8QneiYEs8lMcdR47cIJAMBrnjS6Zy39snDvcD17CInO98WYUHISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrWywNC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CADC3277B;
	Tue, 18 Jun 2024 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718701470;
	bh=/7ajYiEcWaOfoFirXPrwKlflRmQu2KJc61rL+aBMbTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrWywNC4HLjA1To2GgIiZxJsyLLb8mU45nxwwXwOHuNby8+Kq6QD4d3r2OHzqHM+z
	 Vw7BqJoUQTNWw0nogHX5gDizIpsBTeNyGLNFnUq+oeV7/5c8TfdVUtiWFUb95vYB58
	 OUGQpuCeq0FDgr0Tl2nPRjlyQhTQ3vDcIcc0MZG01ml7dz8eHPtuhhfAWtW6LjCeWZ
	 4RPYrooRJ8f0TytxglAw2BFLHVEkShYXky5lRrRbwSPkv93/0wp2pEel+yvbJc4WUM
	 ubVOZopwPn77b//W4i+j4ylWQz0FfTQBTJ1qt4E9IYFeMeaBHRci2vyYbDg2pxs4/t
	 /a6YgHjwfrYDw==
Date: Tue, 18 Jun 2024 10:04:25 +0100
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net,
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Paul Blakey <paulb@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net] sched: act_ct: add netns into the key of
 tcf_ct_flow_table
Message-ID: <20240618090425.GG8447@kernel.org>
References: <1db5b6cc6902c5fc6f8c6cbd85494a2008087be5.1718488050.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db5b6cc6902c5fc6f8c6cbd85494a2008087be5.1718488050.git.lucien.xin@gmail.com>

On Sat, Jun 15, 2024 at 05:47:30PM -0400, Xin Long wrote:
> zones_ht is a global hashtable for flow_table with zone as key. However,
> it does not consider netns when getting a flow_table from zones_ht in
> tcf_ct_init(), and it means an act_ct action in netns A may get a
> flow_table that belongs to netns B if it has the same zone value.
> 
> In Shuang's test with the TOPO:
> 
>   tcf2_c <---> tcf2_sw1 <---> tcf2_sw2 <---> tcf2_s
> 
> tcf2_sw1 and tcf2_sw2 saw the same flow and used the same flow table,
> which caused their ct entries entering unexpected states and the
> TCP connection not able to end normally.
> 
> This patch fixes the issue simply by adding netns into the key of
> tcf_ct_flow_table so that an act_ct action gets a flow_table that
> belongs to its own netns in tcf_ct_init().
> 
> Note that for easy coding we don't use tcf_ct_flow_table.nf_ft.net,
> as the ct_ft is initialized after inserting it to the hashtable in
> tcf_ct_flow_table_get() and also it requires to implement several
> functions in rhashtable_params including hashfn, obj_hashfn and
> obj_cmpfn.
> 
> Fixes: 64ff70b80fd4 ("net/sched: act_ct: Offload established connections to flow table")
> Reported-by: Shuang Li <shuali@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


