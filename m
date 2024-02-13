Return-Path: <netdev+bounces-71458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DDC85355C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73523284741
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA95F850;
	Tue, 13 Feb 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idjMzibH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343375F848
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839763; cv=none; b=JjjnA1MJM6qjHyB7+E6gPWz3I7MKYnF3hBMpIMfcA/E2k3PwnDMCcHS3Dk1kpyr8NE8SOGRCAS0wytIOXvveqmh3TjSw6NbSvIelA5SaEozWctVnBb+YgZnU3Jb//C1Sffh/NqleyhfwnAci3SQ4vLSCvk9RJuYVO54EL/d22MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839763; c=relaxed/simple;
	bh=nX4LG467khe0dDlcFY6ifXxQkz7qfWFLUxpgXfvOdaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLaQguxBTt/IMknI+Q6vr6/fc/S1GO+ckFsP4vhxKlkg25bT7fuEVt0ZqPVfqdZ3ef3xIQ4OQ/Gdwi6K22YF4r2oni8auSp6CVQ0unioRrIlH4KpIjKxtJAkACSI7WbZMHcoD+boM5/5VgM4FK/H+5GnPV+hMCboDCtr4Y6pCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idjMzibH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9D1C433C7;
	Tue, 13 Feb 2024 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707839762;
	bh=nX4LG467khe0dDlcFY6ifXxQkz7qfWFLUxpgXfvOdaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=idjMzibHz5bVegUnAbA6QoBnHHuy/U+pezpVsK9SrlMm3zGYqAw2+eKRpWqJ1zPpy
	 GZDA+NYoocXdh8hMHYO5PqubJEVxkZrkio61dHWRz4VvDXL5BdDFmUuTfWuK1MTN6W
	 g/LT9+a4q7bwfIBZWkZcRUhSZXjh33YArL1SCBJ/uRC0kjvguUCNbbl/LQ4rcPIRMH
	 XBuK/nHPwM4wJkXWWfr8w7zvIYJa2UJbWHdgqGndqErOwZVspH6WUR8Rw+0aK4nq+/
	 cyAQMPYCchNjDxBYaTE/8U71IFW6lozKUkiofteS00DzCkD54gFXDRY7qTXY5TyaX/
	 GKEgVxaGr3UJg==
Message-ID: <632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org>
Date: Tue, 13 Feb 2024 08:56:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/5] tcp: use drop reasons in cookie check for
 ipv4
Content-Language: en-US
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20240213134205.8705-1-kerneljasonxing@gmail.com>
 <20240213134205.8705-4-kerneljasonxing@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240213134205.8705-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 6:42 AM, Jason Xing wrote:
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 38f331da6677..07e201cc3d6a 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -452,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
>  	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
>  	rt = ip_route_output_key(net, &fl4);
> -	if (IS_ERR(rt))
> +	if (IS_ERR(rt)) {
> +		SKB_DR_SET(reason, IP_ROUTEOUTPUTKEY);

Reason names should be based on functional failures, not function names
which will change over time. In this case the failure is an output route
lookup which is basically SKB_DROP_REASON_IP_OUTNOROUTES




