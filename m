Return-Path: <netdev+bounces-166464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22EA360F4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D303A346A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B380C266EF0;
	Fri, 14 Feb 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH4lOXfM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5C1862A
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545347; cv=none; b=Li0JCGtz/qTGpL06vy+HcLVj4AC83h1AwGflQmRbXdOUGoISW9i3l9tVgUbfty2OeLGP3SDx5sGML2caZlJJ+VIlysQrV1mFDvNVU9tLPoRSYkoVIHPwl1Cps4AcUfchFP1Yn9+oLwe4QjYrTGvg+X/5Jnao4c/awfIj8E2rhm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545347; c=relaxed/simple;
	bh=GONcNYUd6aXgXNNYgGHMSWc3rZbXHg2GWmF1ORr5jwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdpCxcAsAw6H6ascWGQBlT4HBNqq819LS+7XOzq75VjlzdnqWrCkwWPos2tLN6xymBKUGCXj6tOyFU5U2hviNrypV7dn36mvqaRjZl2GfVxo+2Fu+afW9KJk+a+GC2agRlYTaubU98RAJoFflWHUyHKvYI5X7nc9sn6VoZcdq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH4lOXfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7268C4CED1;
	Fri, 14 Feb 2025 15:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739545347;
	bh=GONcNYUd6aXgXNNYgGHMSWc3rZbXHg2GWmF1ORr5jwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KH4lOXfMpdN4zg10mcYhW5LDTuAmkJzU6Ndnf6eVq9A/B+Nz5JiEBBaOT1C8kAEZ0
	 SsO1DVIQFF/xSngdmAcqHYAgG+GnOuedEdy+060tslj8nCMBkaMKqrKV3miHFQ8eJ5
	 L0q8et0mTf50xJL9qa9AsTgg2YCjVj59vhLsle2rYquRtkfUuwKxBpitMdRhZUGqJ4
	 3YKHF5S9+U0jVeRNtfAVzmqNlqaL4OJM4tXrFUZwWAGcfAVLkCPgbpDoj7XaEAOzgG
	 WczEPfQxXavqrvlGtWnVeCyCIMrClKtKSyhNGbcPTYgYPMUbUZeeTctIqsloSsHt4h
	 988C0ayanJdlg==
Message-ID: <327cbd06-e2ee-4362-8c4e-8035b58ae333@kernel.org>
Date: Fri, 14 Feb 2025 08:02:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ndisc: ndisc_send_redirect() cleanup
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20250214140705.2105890-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250214140705.2105890-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/25 7:07 AM, Eric Dumazet wrote:
> ndisc_send_redirect() is always called under rcu_read_lock().
> 
> It can use dev_net_rcu() and avoid one redundant
> rcu_read_lock()/rcu_read_unlock() pair.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ndisc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



