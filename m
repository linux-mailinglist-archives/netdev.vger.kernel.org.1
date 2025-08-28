Return-Path: <netdev+bounces-217882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632F0B3A461
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEB0163B54
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38E224B12;
	Thu, 28 Aug 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzlwk7kP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DC221FBB
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394761; cv=none; b=hLIbinG2rq+38Z1S3+ouTXoj9SMEIOZ/5mk5YHDBGE4AVskSX0U/iQwQucbqgCnMz/CTZ9pHdXAwkkZ05Damh90HhqP3zcX8vbs6TudOWlAb46WHJSTsf8jbzChbCUyaOr1sKaobGuBV/gE/dnkVrdKRWfgudGQt8I/CtZTi94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394761; c=relaxed/simple;
	bh=tCGr+5fW65OepFqkhqr/WFNWTiRWyml7f4ZLKSeBdLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaCIdKvwc/P/TLPAfaWLQJkMjvHaTw49BwJdB2kxNQCtqoY7pEXWALyox1jtV75VZfNW5QNMuNAUFpS+a/oBcuPEP8eaEyvk6LZL223CNLBYBo+G3CdLdDGIuZJPTQ2wQJrZOsV8paI8WSyvhpk+pzzCU+KujPJUteHNe1lgyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzlwk7kP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CAFC4CEEB;
	Thu, 28 Aug 2025 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394760;
	bh=tCGr+5fW65OepFqkhqr/WFNWTiRWyml7f4ZLKSeBdLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vzlwk7kPToenlo1aLk+e4aQU2bCzfTIx/xBe0osa/aK55If4VqZCknyVy6MpqUFC0
	 vzKPCgaDLfE7/pznkqFgeeT/N8/Pll843wGWQfncvgG/iYu772CMv/0pMcwUe/Qtqd
	 tEM6qerGET7Lo8cfmaiVHbZ8+C6GMNBbq8kBbmgEHchCNkWyi7CjWpRboAfrCReMXY
	 mY0u7kEnE5lEI63UdwZkIPPl+t11+CAH2b0viqVXSiHdaitd2NB5Qed93QS7JHE/9B
	 qZOQJqShOF3gLOrB5aip3qOHXwTwLp+yANcsG90egwoE03D1LecrORWdGJwNACtUPY
	 g7EdNLc7ZyfbA==
Date: Thu, 28 Aug 2025 16:25:56 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/4] net_sched: act_tunnel_key: use RCU in
 tunnel_key_dump()
Message-ID: <20250828152556.GS10519@horms.kernel.org>
References: <20250827125349.3505302-1-edumazet@google.com>
 <20250827125349.3505302-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827125349.3505302-4-edumazet@google.com>

On Wed, Aug 27, 2025 at 12:53:48PM +0000, Eric Dumazet wrote:
> Also storing tcf_action into struct tcf_tunnel_key_params
> makes sure there is no discrepancy in tunnel_key_act().
> 
> No longer block BH in tunnel_key_init() when acquiring tcf_lock.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


