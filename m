Return-Path: <netdev+bounces-138346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB129ACFA2
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771CBB28BBD
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6281C304B;
	Wed, 23 Oct 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="Ju6RwDnC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A81CACE8
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699067; cv=none; b=fn/T7dJD60MpNRMTCXDv5SsWogQq3aIULDD+yjSY1G6Yqn1+EMaXYhClpP4Z+Hzl3BCu0tyO85gq2LEPmsmLyggEUaJgmNBygYiXxD80BH6/akDF8YFIhCp5Ypc+62UOKEvohszM8qxlw7HyXWzAfCFvrIZO0mByjZuxgFDWKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699067; c=relaxed/simple;
	bh=AuStIkcKjDDnuNnh7W0Ic2QFUcBuPQzsR2xLUEyzr1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7H0RxoiwVO69pidqqJfGHRHvpTcU1jUWeChqrAUx1/KQ3peyIJ445WvQ/S7lReY7vFJl1uTMpudYPD+ZSz/0TLDo0YBTOUp4CPCvpJw8m/JxAWjC9efcn4Az+t/dEJVxc6EnD61MtipwM7r18j4PLJzwM1DBgO8HnNYoWPd5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=Ju6RwDnC; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id EFDBD5A0002;
	Wed, 23 Oct 2024 17:49:14 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GsMDx6UpwuX7; Wed, 23 Oct 2024 17:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1729698554;
	bh=AuStIkcKjDDnuNnh7W0Ic2QFUcBuPQzsR2xLUEyzr1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ju6RwDnCsOmR5ABx/IjfIarm/JxrMaxtlD2d7VUalVj9YSp3ax9FnMmKCVyhRdecF
	 fsi7EJwaJTmkRrJue0B94+HLfWqFJd4vQt+r5BN6TKp/Ddb1ouPoubMqGSYqhJfR/y
	 0YwwIJi19idfwWtaXb+GmqQ3nU4SOOz0Zd/3A+40zVWdsGFhof679WqgaFrCys47gs
	 3SVkvPCRjRkgzqbZtVtJ8zj7/1BiGYbGtyz404vwmx1M3UWrfrjqwVDfk72M6yTyX0
	 ZnJFcqwigE9fETXoLkwakCM6OSNypCqEjVKKeoRoW2H0+KaV2616VMSoCfzlFmFi3/
	 1dEcMjdpY93OQ==
Received: from [IPV6:2a01:8b81:5400:f500:1d4a:4606:c56c:c6f4] (unknown [IPv6:2a01:8b81:5400:f500:1d4a:4606:c56c:c6f4])
	by mail.codelabs.ch (Postfix) with ESMTPSA id D0A0D5A0001;
	Wed, 23 Oct 2024 17:49:13 +0200 (CEST)
Message-ID: <31e0da00-3972-43a1-ab2c-1220f65fa3d3@strongswan.org>
Date: Wed, 23 Oct 2024 17:49:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 ipsec-next 0/4] Add support for RFC 9611 per cpu xfrm
 states.
To: Steffen Klassert <steffen.klassert@secunet.com>,
 Antony Antony <antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>,
 Paul Wouters <paul@nohats.ca>, Simon Horman <horms@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org
References: <20241023105345.1376856-1-steffen.klassert@secunet.com>
From: Tobias Brunner <tobias@strongswan.org>
Content-Language: de-CH, en-US
Autocrypt: addr=tobias@strongswan.org; keydata=
 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
 tvkh7XWO2ycrW1UlzUzM4KV3SDLIhfOU
In-Reply-To: <20241023105345.1376856-1-steffen.klassert@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.10.24 12:53, Steffen Klassert wrote:
> This patchset implements the xfrm part of per cpu SAs as specified in
> RFC 9611.
> 
> Patch 1 adds the cpu as a lookup key and config option to to generate
> acquire messages for each cpu.
> 
> Patch 2 caches outbound states at the policy.
> 
> Patch 3 caches inbound states on a new percpu state cache.
> 
> Patch 4 restricts percpu SA attributes to specific netlink message types.
> 
> Please review and test.

Tested-by: Tobias Brunner <tobias@strongswan.org>

Regards,
Tobias


