Return-Path: <netdev+bounces-218014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982D5B3AD53
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60228169D54
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665BC225D6;
	Thu, 28 Aug 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1D0pW2D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423DA13FEE
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419254; cv=none; b=UD5lemKlfTghxABI5uSqrlWRYUW0xU+6Bk/Fwk8XM0GJzt7eNPV7N2PO3OYl5/y/XkARq4OXCk4pc+E7oHm3DdPg6lU2i3zRKI80FivJTWw6Pe/yNYGcydTpLaCroX0Q2BNsJ9wQPGaBdAcHoIwFVpwQhxskd611QVSxNvMdVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419254; c=relaxed/simple;
	bh=XhGPQ1zR3OXLANmY/FYbv/frm65hs7wHjfXyuvSQqSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKDZ+s0faSY36mmrbn2j9h4vuFEuGVOuYY9LMBhHnM7CLVIu2rQOLfw0SluqY+0dhcuWbPsvMaNiF1zHgV6L3HLBYVBefK7Qoc1ZOLATwdfNjrA/+UXYuSMosujTnxyKN6hR80laeJZNqY1gLKW1nlpdKQWP7lNzYHdSd/Ks2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1D0pW2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572BEC4CEEB;
	Thu, 28 Aug 2025 22:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756419252;
	bh=XhGPQ1zR3OXLANmY/FYbv/frm65hs7wHjfXyuvSQqSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O1D0pW2DF7dgNquxu8uRIA8m4dOwruiunWbZy/YRn3Yo+vdieHNqcD+Fur3Iqg4F9
	 13Ga/ZU2F1A2OZXmKHNCc5FtKNDRwHyio/cTYyH+FaZBuKPcUr8PeTl2usAXV25ead
	 odIxb25Pb1tYzON2RetP5rMUcCeUSBK1bgZHGPOOOnjFGpKlBwycf+iyki05pbTGqh
	 yuFqBvh7tFMT4BXc+5xLnbjTD3zIqkqoj0ydp/YmQJJ2oAOAXhVn6prpcxhx8pC7iW
	 OhRLNU7UcuICu3Y4eK+sIIul5WQqLhC1CJWYdMyaabrCsN2qmtt86xxpZ75DzrgHzN
	 owVmpHdPOutVg==
Message-ID: <3f2444f2-c339-4542-8be8-fc1d09051265@kernel.org>
Date: Thu, 28 Aug 2025 16:14:11 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/8] tcp_metrics: use dst_dev_net_rcu()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250828195823.3958522-1-edumazet@google.com>
 <20250828195823.3958522-7-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250828195823.3958522-7-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:58 PM, Eric Dumazet wrote:
> Replace three dst_dev() with a lockdep enabled helper.
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



