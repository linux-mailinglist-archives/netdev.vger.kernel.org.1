Return-Path: <netdev+bounces-158325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1181EA11656
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6227A1E35
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A89D3D76;
	Wed, 15 Jan 2025 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyCaBcLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E72B9BC
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903120; cv=none; b=YL9yst8663OPeZWPxkEygvmw9j6dUkRJDhQE05qILjcOVBJNhUDbyMbEh7TboONmfDLTnJ6mF0bpHtZZj3ZpIFfyPRXbKvUkbTjqRCFR+WGcrgCD/TFWYb4teKTY6WGDxxnK3ljs2RLZVqtppVdJp75Uaob4irqPaVgv9C8qbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903120; c=relaxed/simple;
	bh=RZSv0CI/9d7FeETOZYCHAa2iEyKS+si83OTS0qw4YTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEfj++IG/5tBvwNkh7mmGUKHnNdrZp1HV6uFUVgR1ql3yu/lWMbQH7j8IApoRfRPjvfyePr9TXYT2DGp1U5uC+52EKOiLb2d00X6GoLRqi4tVaVlui71C5RWjMQZObhlMzoFMDFB+D9H1TT4U5nR+O6pBl4Qskzz4s0b7uTMp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyCaBcLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DB7C4CEDD;
	Wed, 15 Jan 2025 01:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736903117;
	bh=RZSv0CI/9d7FeETOZYCHAa2iEyKS+si83OTS0qw4YTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NyCaBcLh/btNJeOEYPITebYw+g/dtFi+H98/MJsSaQLWizzmsvC0wABadiGwDjcu/
	 /zFcUYxgHalzcHjnI8IlKDFKJ2uGaBg6Lg0HL41bWN8wJfgT7d07MqeKkDDWbeseJO
	 mQFfyqDeekS/dX7ieWFOHwhE0RRkEQX4sKI/bhR5u/IbJNOGHlP03I37xd1p5S93rs
	 AAZDIvcfmW3ilMCDTYoPv2a+hVcgnvveIRmnwofHBnVhrUW0VaIfO7Pe176x3Fj1Ix
	 9BOGT48IktXAmK0N5+jHHwCvbcHcVaNolWa8VHLLH5Qy6ilRwX6vITq+x/yvsZ3p+S
	 rJimABO1IzyTA==
Date: Tue, 14 Jan 2025 17:05:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@redhat.com>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 06/11] af_unix: Set drop reason in
 unix_stream_sendmsg().
Message-ID: <20250114170516.2a923a87@kernel.org>
In-Reply-To: <20250112040810.14145-7-kuniyu@amazon.com>
References: <20250112040810.14145-1-kuniyu@amazon.com>
	<20250112040810.14145-7-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 13:08:05 +0900 Kuniyuki Iwashima wrote:
> @@ -2249,14 +2265,13 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
>  static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  			       size_t len)
>  {
> +	enum skb_drop_reason reason;

I feel like we should draw the line somewhere for the reason codes.
We started with annotating packet drops in the stack, which are
otherwise hard to notice, we don't even have counters for all of them.
But at this point we're annotating sendmsg() errors? The fact we free
an skb on the error path seems rather coincidental for a sendmsg error.
IOW aren't we moving from packet loss annotation into general tracing
territory here?

If there is no ambiguity and application will get an error from a system
call I'd just use consume_skb().

I'm probably the most resistant to the drop reason codes, so I defer 
to Paolo / Eric for the real judgment...

