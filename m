Return-Path: <netdev+bounces-89344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18CB8AA155
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB3C284108
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76FA178CF2;
	Thu, 18 Apr 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIatU2p3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93606175564
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462364; cv=none; b=kqqUE3s+8Sqn4MZHazOngkkD1kFYNlaVlGxpT6ZgCaOlXreC/8xKlYaQf6fvt63T/EuVX9OrlAPpPg/mlgp3EzuOSpzbVbegdSMagMx5cXyd9S5mwqxY6ZeN0ZCWY97QUfUxc7087Mrma4FTpQVRq49HzdO0abstchnDrOYcayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462364; c=relaxed/simple;
	bh=sdCF9ZM7s+/AQCo9pyUeMeUt04k2nWP5mqmIUROV9qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3iRymrnAuoB8u2FRJMu/jNYngEa22khkhRHlVMOS0SaKKx5IPXsEW0Gx0vZeneJx+Xv6VjUe2mp7ziwK6psxNEjRLlqj53BwFqlcurDbe6VwU04W4EbVipO/VwN3NLHHv8HuupZmGguNsUILYCzjoCXnHWvaA3BFm+MhmXtL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIatU2p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DDEC113CC;
	Thu, 18 Apr 2024 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713462364;
	bh=sdCF9ZM7s+/AQCo9pyUeMeUt04k2nWP5mqmIUROV9qA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FIatU2p3p85lDLm/ZAQgd7RqN+RTGeCUhh9ThnMJaZBVcCCupNm4QklMiz9bAf9kC
	 8aKpNHjLs6jHkswjNl5MYxhHoQq7Q2XtLrM+8Z2Hfj8L+nX+oXog7XqdqSf02Wu87l
	 8x9y27epibHEeDTly0P58MSFQyin1HUGzp43oV8Gy451HuI9HhJM76jzhNKUdbmSkT
	 8656vlTK8EgULROaqCOOjHewSpDiFgwQlikptviJKz1vlqGsJdMo8VHj8CaudfM9tq
	 MzJLWn0GJaYE1XVo5CdBhTlP87+u6iibcTi4FbPQNvfDtSPV/RxVbGofpY863oRcf7
	 zFl+xbjxZzkIA==
Message-ID: <274d458e-36c8-4742-9923-6944d3ef44b5@kernel.org>
Date: Thu, 18 Apr 2024 10:46:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from
 tcp_v4_err()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org,
 Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 eric.dumazet@gmail.com, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Willem de Bruijn <willemb@google.com>,
 Shachar Kagan <skagan@nvidia.com>
References: <20240417165756.2531620-1-edumazet@google.com>
 <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
 <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
 <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/24 4:15 AM, Eric Dumazet wrote:
> 
> Thanks Paolo
> 
> I found that the following patch is fixing the issue for me.
> 
> diff --git a/tools/testing/selftests/net/nettest.c
> b/tools/testing/selftests/net/nettest.c
> index cd8a580974480212b45d86f35293b77f3d033473..ff25e53024ef6d4101f251c8a8a5e936e44e280f
> 100644
> --- a/tools/testing/selftests/net/nettest.c
> +++ b/tools/testing/selftests/net/nettest.c
> @@ -1744,6 +1744,7 @@ static int connectsock(void *addr, socklen_t
> alen, struct sock_args *args)
>         if (args->bind_test_only)
>                 goto out;
> 
> +       set_recv_attr(sd, args->version);
>         if (connect(sd, addr, alen) < 0) {
>                 if (errno != EINPROGRESS) {
>                         log_err_errno("Failed to connect to remote host");

You have a kernel patch that makes a test fail, and your solution is
changing userspace? The tests are examples of userspace applications and
how they can use APIs, so if the patch breaks a test it is by definition
breaking userspace which is not allowed.

