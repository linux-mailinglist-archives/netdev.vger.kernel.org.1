Return-Path: <netdev+bounces-176488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DEAA6A864
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C8F17C40B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9AD224252;
	Thu, 20 Mar 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki0DB8Ai"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52C226D18
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480435; cv=none; b=PYSIGOEBDfWjeXO1C1y2FCCZz4i2CXFf2J5ul8oHIhcg3K3EPH+Fyijyao+bZ/Pg3g4NqztHoyk9iuNL0ocVjSG3PmMY58CubAldIwW+60Y49uQmAIX5A/Tr5xKVqZ+/ZbC9RHuyzaDgaJ4aQfCJWkd7n1JvtaUamJvufsSLBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480435; c=relaxed/simple;
	bh=5Uk/iJjtDaIO2por5S5lHMjs1GQJ8lh45cm592XHRX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKbaWJNiC3CXTaq+0mruwruLrKGJhwVpuGogltkaTl27yZwWDR2baFR9JPIZEBMjHNTsQTfBPYGSWzMRVodHUq4jAOPW9vIKRNHB8b4mfke94ArBlt+5sE5puPaiSdX80knhLFCa283eQ86V+Lxrm7gvNtlCwo5BwtRq/Zerkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki0DB8Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA55DC4CEE3;
	Thu, 20 Mar 2025 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480435;
	bh=5Uk/iJjtDaIO2por5S5lHMjs1GQJ8lh45cm592XHRX4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ki0DB8AiQjfXAjRKIMTLIAvcrDJfjiFJkcMDcx78gmKxk6LIjAOnzqe96D8lyExBL
	 Bkb7jLFS14uAcL+57VpRSGC1QwxaczkU8CcgVIx1xEY2Ne6ktFnpe4Nhb5aVqfe0xS
	 aIubVYaNt4ml1q6lFxNHskivxmA6PouX4HQbNQnxSqyqOjt3sHuPFGJyNsj6veBwan
	 wwq6kDpphoBcaK5kTxmmktE0bJFKvBxGqdOtRAeQar2Uy7aY707QsORgMd3YfVMvuT
	 yOGZxSSS7vrsV4Lgo3WEZJXOdCe29N7vL9UFfO66/HFcgjRdxG/7O+MqWqpD2d/H/w
	 eha38V9ebs8Ow==
Message-ID: <3b0fbd8d-995e-4bd2-9805-d3c4e4c14c5e@kernel.org>
Date: Thu, 20 Mar 2025 08:20:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 7/7] nexthop: Convert RTM_DELNEXTHOP to
 per-netns RTNL.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250319230743.65267-1-kuniyu@amazon.com>
 <20250319230743.65267-8-kuniyu@amazon.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250319230743.65267-8-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 5:06 PM, Kuniyuki Iwashima wrote:
> In rtm_del_nexthop(), only nexthop_find_by_id() and remove_nexthop()
> require RTNL as they touch net->nexthop.rb_root.
> 
> Let's move RTNL down as rtnl_net_lock() before nexthop_find_by_id().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/nexthop.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



