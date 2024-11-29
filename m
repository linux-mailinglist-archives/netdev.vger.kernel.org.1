Return-Path: <netdev+bounces-147880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B009DEB67
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 18:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD406280F51
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DF814A624;
	Fri, 29 Nov 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWa86qwk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C03224
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732899668; cv=none; b=sY3NKQCrgY/LJfQduIGUiHPKZmubaqOBgwO4vByenE4D2W71Pbrm0w8996bAhjvwsPyTrmeWWBqMiPK1+lW23SNfpU9aHVo/uOlO1YTMTvN3Ef2O+5fqFrr0r0SMkcMCc36axg6asvXEv4FyzJFKiG/rSerTdy071J9hNKiC1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732899668; c=relaxed/simple;
	bh=p6jdZJZefVatUAze0XKwdqs6pccBHc/kVjGwguku3sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8oC4IXdIEi2zaO5FOMR/78jfJAdoqyCIETNaVS8TeZPpCAr+XhA75rzoJv2rWUeNYpukJG3xw37sOBQD3F7yTAq61hTVXvOnKTgKRnsdWfnq5s3QyeL4BYkvwxNKwd+3SQvc1+ZSR5SXJzfrD2c7lHJ42N+Dwg8BZe8nA4K9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWa86qwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8834DC4CECF;
	Fri, 29 Nov 2024 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732899667;
	bh=p6jdZJZefVatUAze0XKwdqs6pccBHc/kVjGwguku3sI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RWa86qwksXoSZeG4e6i+q2axa1rXhRVEXGf3epa6k63sZjn+hVrAOq9jcx6nBN2xD
	 ZzRAI/5+N7vjByFG3U7KgOh8DDcqFyphsY10ywzCg2Dezc+NAv1WyxOvHs2pw05Vl+
	 AMPgMv/cjeBl2GZNEYIxBITra9uv0wlL04gwEt4dcyGsA2FVDeuuPlWS3lPocXL9em
	 wC+cDyFs73m7Dk0d9UmtjjntCr37SKfNCXryR7FX7fkYGVIAi0GLP59mKtnd0LtOsq
	 8SjQWDIESKxHlqEr+l+Kbh8qebf8gcWYTbSbzTgdCtA5HwEIRrJ+3GQD9ygQwFUrdo
	 FK8RgDsSW0jVQ==
Message-ID: <a4ad9242-2191-4f64-9a92-25d11941cf2b@kernel.org>
Date: Fri, 29 Nov 2024 10:01:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipmr: tune the ipmr_can_free_table() checks.
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
References: <fe340d0aaea857d7401b537f1e43e534b69470a2.1732875656.git.pabeni@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <fe340d0aaea857d7401b537f1e43e534b69470a2.1732875656.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 3:23 AM, Paolo Abeni wrote:
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index c5b8ec5c0a8c..d814a352cc05 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -122,7 +122,7 @@ static void ipmr_expire_process(struct timer_list *t);
>  
>  static bool ipmr_can_free_table(struct net *net)
>  {
> -	return !check_net(net) || !net->ipv4.mr_rules_ops;
> +	return !check_net(net) || !net->list.next;
>  }
>  
>  static struct mr_table *ipmr_mr_table_iter(struct net *net,
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 7f1902ac3586..37224a5f1bbe 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -110,7 +110,7 @@ static void ipmr_expire_process(struct timer_list *t);
>  
>  static bool ip6mr_can_free_table(struct net *net)
>  {
> -	return !check_net(net) || !net->ipv6.mr6_rules_ops;
> +	return !check_net(net) || !net->list.next;
>  }
>  
>  static struct mr_table *ip6mr_mr_table_iter(struct net *net,

this exposes internal namespace details to ipmr code. How about a helper
in net_namespace.h that indicates the intent here?

