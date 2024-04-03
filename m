Return-Path: <netdev+bounces-84628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63549897A49
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934341C21A5F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA5515624A;
	Wed,  3 Apr 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2I2lCHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB8155308
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177920; cv=none; b=M1p1Ax0sornYy+ocx6mb5XFODSquPPGJBdDe/znpFXrGr7an8TWLm0kxLtzcw+AJ31B9njI/+tz43L+7ZqUOgtdF5/eBMghAmKFo5eHNVD87qlOnsoqxSjUsp/8442Y+VT0cp2zbw9C4klf4zQLVJ4762s8qU9FOCh3eWyfj01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177920; c=relaxed/simple;
	bh=RxkrahTrphG/MPUXUeaXNtU1e5plCx8WQCYV1G077uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7atm3spRDMW5/WkXw7lAlj10l7x2V9UaY4xjDKUt+O3Re4gmM0KWzzkdxxAxaYTUTio7b5HjZYPAtw8jy+laZCUr2n5lNmRGtHNhMMnel30TRk4ntgAnlMpJMQS95L+hpjyW1DMvmX1Vg34SCMZn6EoIy7tLWodDJ8EA3t0X0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2I2lCHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8358C433F1;
	Wed,  3 Apr 2024 20:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712177920;
	bh=RxkrahTrphG/MPUXUeaXNtU1e5plCx8WQCYV1G077uM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F2I2lCHQ586KoBOKQmOFtOTiJUe0Bu8qtl0GokCZLEfapsyaPh92Nssy/+McksKaI
	 QAHITP42tPYKlHTezR4f6Zq2h5bzX8aV3lm7Omg9QIjAM6yzDSufZjOdp7bpQmo/th
	 8VQ/jDBs9oKOLIKKBfJjugVUlkovcS/wc1Lbh8sFj+QkIlJLrpAimWgPly3m8z/FvQ
	 S9y2XulSKlHul7GUVV++KXmHD2OWHkgtvnl405wM399N7sxbdj11G6pozTMmWARUlf
	 JRWBLW7y3J2dw5P966I1VnhiAxQPDdpPs4cVlZBlBAm0xidKraH3Ne96/gv73iQGGS
	 69tBRcEEu3w3Q==
Message-ID: <df1130b3-c695-42af-b939-05fc0a029e26@kernel.org>
Date: Wed, 3 Apr 2024 14:58:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: skbuff: generalize the skb->decrypted bit
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 borisp@nvidia.com, john.fastabend@gmail.com
References: <20240403202139.1978143-1-kuba@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240403202139.1978143-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 2:21 PM, Jakub Kicinski wrote:
> The ->decrypted bit can be reused for other crypto protocols.
> Remove the direct dependency on TLS, add helpers to clean up
> the ifdefs leaking out everywhere.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> I'm going to post PSP support.. as soon as the test groundwork
> is in place. I think this stands on its own as a cleanup.
> 
> CC: dsahern@kernel.org
> CC: borisp@nvidia.com
> CC: john.fastabend@gmail.com
> ---
>  include/linux/skbuff.h | 15 ++++++++++++---
>  include/net/sock.h     |  4 +---
>  net/Kconfig            |  3 +++
>  net/core/sock.c        |  5 ++---
>  net/ipv4/tcp_input.c   | 12 +++---------
>  net/ipv4/tcp_ipv4.c    |  4 +---
>  net/ipv4/tcp_offload.c |  4 +---
>  net/tls/Kconfig        |  1 +
>  8 files changed, 24 insertions(+), 24 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


