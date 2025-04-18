Return-Path: <netdev+bounces-184069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5217BA93157
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 06:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB4C3AFF2F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED53263C71;
	Fri, 18 Apr 2025 04:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjGLgKK8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239C1DA21;
	Fri, 18 Apr 2025 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744952279; cv=none; b=Hk1wTV1vy0x35/8r51TIqOBM3FCtmFqA/prRYg1MmwDhZkDUAh9wqrISSH5oW633YG/4tvLk1tJu4XogpRmNFI2D5C/p+uNZP+S8Kw77ORHGCrMQZS5YMKOGf9MqwV99hRB5l4vvTGkhMPgUQ/sNHen51OYmo9X4Op1qUyX8Yik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744952279; c=relaxed/simple;
	bh=Q61wTq6fwgjLh5awYrNAIdvOCp25B2Jr/uabG+oMO64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVNzhP/omuK2r5Ug/9DIn3re9/xjdn/qtqShR0dbisaWb09lgK5Y7jKsUlfIVlBNwY49lm7cIH44EPFex2cHV+24RrgaRPCzUmjQESyKATnEYtH8l2S0GfaKbCg91mQmP1fh+XSmBYqx3qKQbwvzzSEzJamSMLKbDgDw72n2ezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjGLgKK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0EFC4CEE2;
	Fri, 18 Apr 2025 04:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744952278;
	bh=Q61wTq6fwgjLh5awYrNAIdvOCp25B2Jr/uabG+oMO64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KjGLgKK8d6sZljrbs5FdZqujTm44FkLncXnR9NFJCG3TYFhabcUbdtqkT93e7sZq0
	 F+WR2G+++bElk0F1wfM/xw0iYpFvAG2TCeZUQGht8QajqCzLFzCGJcBTfIX3To32C5
	 rGCmhtwn0dUeJk7O6jYYFwpo0g+iBUJMpKWRU5PBjsmLx/RtzB/EkqtSacSuA3zGql
	 xHTZ6DZ1cQHfGiDv1xTGx58yTSWh2uFYrjqzwRND6PmBeL4jMHwSzzfrSArTUAOfp9
	 HgzErg1EghwnTqsNUYngCPp/mObvlunaAUX1y1JZbXt7mbDfytC5UqC/gmi9aJ3Pj5
	 uBaVCQYQkBWcg==
Message-ID: <1b17ce33-015f-4a10-9a98-ebea586c3ce4@kernel.org>
Date: Thu, 17 Apr 2025 21:57:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, kuniyu@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 yonghong.song@linux.dev, song@kernel.org, kernel-team@meta.com
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <4dd9504c-4bce-4acd-874c-8eed8c311a2f@kernel.org>
 <aADpIftw30HBT8pq@gmail.com>
 <8dc4d1a8-184b-4d0d-9b38-d5b65ce7e2a6@kernel.org>
 <aAElmpUWd6D7UBZY@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <aAElmpUWd6D7UBZY@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 10:00 AM, Breno Leitao wrote:
>> $ git grep trace_ net drivers/net | grep _tp
>> net/bpf/test_run.c:	trace_bpf_trigger_tp(nonce);
>> net/ipv4/tcp_input.c:	trace_tcp_cwnd_reduction_tp(sk,
>> newly_acked_sacked, newly_lost, flag);
> 
> Do we want to rename them and remove the _tp? I suppose it is OK given
> that tracepoints are not expected to be stable?
> 
> Also, if we have consensus about this patch, I will remove the _tp from
> it.
> 

I am only asking for consistency. Based on existing networking
instances, consistency is no _tp suffix.


