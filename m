Return-Path: <netdev+bounces-33295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B7979D575
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F021C20AA1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FD418C2A;
	Tue, 12 Sep 2023 15:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C71803C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A6FC433C8;
	Tue, 12 Sep 2023 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694534325;
	bh=KgRuz1YKKnvn3+5q5xBzDA3Ez1gk/i9Uli3VgVYG7lo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U1aUXtarNKvtdOPD8dtv+zYCsT5EFLw36J5gVwfn6g+9Zq+4OTrObLj0H5+f5TO/A
	 0ug8JHq3jEofOK3PaAYQ/pbFJRi5463xpP210MBGyBwFt5nb1EmIr6KG1S8LP4l93N
	 MF+CnmV84nNAscLkRqGTUDqDuzj+X7v8EF2jdBHFzBvQ2UL8DDyoMeuEkVwZ0Ydvb4
	 E3hlGjGpfPYVx3FLHsYlv9SdzodEUEPD5nE14eohzdG3pVa2alXD4nMqO3agEkio7X
	 SXZvguLAgZciehNnC8CgMjm9BXQgEQw6nhg/zsrjM2VtUvJF2/fn9q4QXwUmxdNFDd
	 yjmY0F/EZR5qQ==
Message-ID: <a49df474-fbe8-6581-8102-f4c4b89d4ed3@kernel.org>
Date: Tue, 12 Sep 2023 09:58:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net] fix null-deref in ipv4_link_failure
Content-Language: en-US
To: Kyle Zeng <zengyhkyle@gmail.com>, pabeni@redhat.com
Cc: vfedorenko@novek.ru, davem@davemloft.net, netdev@vger.kernel.org,
 ssuryaextr@gmail.com
References: <ZP/OjT62OGVxwa3t@westworld>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZP/OjT62OGVxwa3t@westworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/23 8:35 PM, Kyle Zeng wrote:
> Currently, we assume the skb is associated with a device before calling
> __ip_options_compile, which is not always the case if it is re-routed by
> ipvs.
> When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
> This patch adds a check for the edge case and switch to use the net_device
> from the rtable when skb->dev is NULL.
> 
> Fixes: ed0de45 ("ipv4: recompile ip options in ipv4_link_failure")
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
> Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
> Cc: Vadim Fedorenko <vfedorenko@novek.ru>
> ---
>  net/ipv4/route.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



