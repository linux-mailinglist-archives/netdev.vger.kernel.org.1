Return-Path: <netdev+bounces-99584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E88D5647
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F271C20F98
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02832180A71;
	Thu, 30 May 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkUdUhu4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B63548E0
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 23:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717111761; cv=none; b=TyXV3BwwE1kv5B6KKkrqgJMWTITbDXNt3J2MWmD6lj1qMRKyZG91kygcPKsC9KH2nuvCwyB1/rCstyw5SUDa+Q8t4zgFlnENat64kPpp3sGPh1BzIXnb/K25K9vseMMTii6w5e/3KuZRo+oqySqI8vIzXtqP9rpe1k5nTTVobjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717111761; c=relaxed/simple;
	bh=c8zbSwygEDwYH0thwHPeJTYZZ2ak7IzfCxsBrZ1qolM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUYoBD+xzlBC0a6iETU6jGcsFOTP3JFKvy8pYKNtO9lxIEZENPUz+zXpplulP08Q1pe2Rkr23Kci5o7T6a55Pp8OgnyjFpeybedvPASENYN5KaTmfh0zxkorwIXqI4inr71mWz6/QfrFAUYik+YxLupFy+oYKXNA/9f3Ca3kE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkUdUhu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BFCC2BBFC;
	Thu, 30 May 2024 23:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717111761;
	bh=c8zbSwygEDwYH0thwHPeJTYZZ2ak7IzfCxsBrZ1qolM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bkUdUhu49hlTGkZtDE+rweIBp9nK0DDZ6jq5OYfqzDOmlZh+0desID2YgQHCvgyN5
	 wPoWmllCMW2TMji80sHCyAREvUYdUKuBWn7PjI3nQHN3k2HFRnQpJROGL2QWbdKQRu
	 9J8fFQtTjkbI32ZwPrZ9H6ulh56mZWu7O8toeEIU2IOSjhmQHL9XGMsxpEH913ofUn
	 st9n8HtyKDU9Ii4RvU6MLXPog7m6n1PQGdtmc1HONfAti8gBj0OyhbX0dSfulhh9zS
	 kTPvaD7HbHrXfw8O0um6VgiI5YpCaytupNTc5dRPhD4AL4a9jFdlNfLAa9R88qhPIT
	 L7s+SqWFwYcLQ==
Date: Thu, 30 May 2024 16:29:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 sd@queasysnail.net, dhowells@redhat.com, borisp@nvidia.com,
 john.fastabend@gmail.com
Subject: Re: [PATCH net] net: tls: fix marking packets as decrypted
Message-ID: <20240530162919.178c8cda@kernel.org>
In-Reply-To: <20240530232607.82686-1-kuba@kernel.org>
References: <20240530232607.82686-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 16:26:07 -0700 Jakub Kicinski wrote:
> For TLS offload we mark packets with skb->decrypted to make sure
> they don't escape the host without getting encrypted first.
> The crypto state lives in the socket, so it may get detached
> by a call to skb_orphan(). As a safety check - the egress path
> drops all packets with skb->decrypted and no "crypto-safe" socket.
> 
> The skb marking was added to sendpage only (and not sendmsg),
> because tls_device injected data into the TCP stack using sendpage.
> This special case was missed when sendpage got folded into sendmsg.
> 
> Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Forgot to mention - compile tested only, ENODEV :(

