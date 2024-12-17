Return-Path: <netdev+bounces-152503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73D9F4586
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D1B7A2771
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 07:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC81D54E3;
	Tue, 17 Dec 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRkCymkk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01518A6AE;
	Tue, 17 Dec 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422030; cv=none; b=kdDrbmap1HO/hZ5VX+S406TPKeIYTxs2Q3jfn6cxAbbL/69TWMw9R0VhsxsM3PF5zs6Rk+BxE5dyte2dKQQGvrar19YaPu9/Jo216qFDgilBhpn+Ia1unDtTRwJUy+VTs6+w0LCDDAlCJe6j3/4vsvT9j2G194vwEtKGIAvC2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422030; c=relaxed/simple;
	bh=vlzD3RAiBnvqmVmP0dbDaT7MMdxEo6mzUNf2MrpEPRE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ayFxtfhN78+iGREOJvaq85FYfPSQR4dejzbq5q5px7TBuuW7JSVctDK1aV2T+beLgh5WioRhLe2dR0UeP7vT4OQWVnNcpj3no4YuMbikLpsDOihbMzPIW34q5RfxapnuBEZNfmVlmJ0MGl1hvotRyGUhNZFSH46fkxmmay7gbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRkCymkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183D8C4CED6;
	Tue, 17 Dec 2024 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734422030;
	bh=vlzD3RAiBnvqmVmP0dbDaT7MMdxEo6mzUNf2MrpEPRE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bRkCymkkT0fstZ3f/YbR5LI7F09s5lrJkOCYzmhbvfGJn0Fdpmw97r0Ou7fyclK8C
	 jOUjntt2+AXgFznYwk5CqsjdHPpRK0cIIqgImiUOj2WIMzxnLcwi9OQGDIW4qvwTBz
	 Aaz243Yp8slxsaaEnmGH9Qb+HoZXySR2xfW669oc7Oiu7yuP/JiP6bu/LOeylyFl6M
	 QnG5DHtOpGwiAKQpXDjH13xQIcHErgQaK/yNhNdQPn8q3UbMzINjh+nY+RUPebhWn7
	 k8jIK4XwSmK4dy2pcogbSlmGcQKSpfMBByNQcf2h2kEu3neZ0Un86JNcAchiGBmO3e
	 toYPaALFjIlHA==
Date: Mon, 16 Dec 2024 23:53:46 -0800
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: davem@davemloft.net, edumazet@google.com, horms@kernel.org, idosch@nvidia.com,
 kuba@kernel.org, kuniyu@amazon.com, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 petrm@nvidia.com
Subject: Re: [PATCH] rtnetlink: do_setlink: Use true struct sockaddr
User-Agent: K-9 Mail for Android
In-Reply-To: <20241217024156.43328-1-kuniyu@amazon.com>
References: <20241217020441.work.066-kees@kernel.org> <20241217024156.43328-1-kuniyu@amazon.com>
Message-ID: <36C08CAB-1D3A-46CE-BCE2-820605E222CF@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 16, 2024 6:41:56 PM PST, Kuniyuki Iwashima <kuniyu@amazon=2Eco=
m> wrote:
>From: Kees Cook <kees@kernel=2Eorg>
>Date: Mon, 16 Dec 2024 18:04:45 -0800
>> Instead of a heap allocation use a stack allocated struct sockaddr, as
>> dev_set_mac_address_user() is the consumer (which uses a classic
>> struct sockaddr)=2E
>
>I remember Eric's feedback was to keep using heap instead of stack
>because rtnl_newlink() path already uses too much on stack=2E

See below=2E=2E=2E

>
>
>> Cap the copy to the minimum address size between
>> the incoming address and the traditional sa_data field itself=2E
>>=20
>> Putting "sa" on the stack means it will get a reused stack slot since
>> it is smaller than other existing single-scope stack variables (like
>> the vfinfo array)=2E

That's why I included the rationale above=2E (I=2Ee=2E stack usage does no=
t grow with this patch=2E)

-Kees

>>=20
>> Signed-off-by: Kees Cook <kees@kernel=2Eorg>
>> ---
>> Cc: Eric Dumazet <edumazet@google=2Ecom>
>> Cc: "David S=2E Miller" <davem@davemloft=2Enet>
>> Cc: Jakub Kicinski <kuba@kernel=2Eorg>
>> Cc: Paolo Abeni <pabeni@redhat=2Ecom>
>> Cc: Ido Schimmel <idosch@nvidia=2Ecom>
>> Cc: Petr Machata <petrm@nvidia=2Ecom>
>> Cc: netdev@vger=2Ekernel=2Eorg
>> ---
>>  net/core/rtnetlink=2Ec | 22 +++++++---------------
>>  1 file changed, 7 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/net/core/rtnetlink=2Ec b/net/core/rtnetlink=2Ec
>> index ab5f201bf0ab=2E=2E6da0edc0870d 100644
>> --- a/net/core/rtnetlink=2Ec
>> +++ b/net/core/rtnetlink=2Ec
>> @@ -3048,21 +3048,13 @@ static int do_setlink(const struct sk_buff *skb=
, struct net_device *dev,
>>  	}
>> =20
>>  	if (tb[IFLA_ADDRESS]) {
>> -		struct sockaddr *sa;
>> -		int len;
>> -
>> -		len =3D sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
>> -						  sizeof(*sa));
>> -		sa =3D kmalloc(len, GFP_KERNEL);
>> -		if (!sa) {
>> -			err =3D -ENOMEM;
>> -			goto errout;
>> -		}
>> -		sa->sa_family =3D dev->type;
>> -		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
>> -		       dev->addr_len);
>> -		err =3D dev_set_mac_address_user(dev, sa, extack);
>> -		kfree(sa);
>> +		struct sockaddr sa =3D { };
>> +
>> +		/* dev_set_mac_address_user() uses a true struct sockaddr=2E */
>> +		sa=2Esa_family =3D dev->type;
>> +		memcpy(sa=2Esa_data, nla_data(tb[IFLA_ADDRESS]),
>> +		       min(dev->addr_len, sizeof(sa=2Esa_data_min)));
>> +		err =3D dev_set_mac_address_user(dev, &sa, extack);
>>  		if (err)
>>  			goto errout;
>>  		status |=3D DO_SETLINK_MODIFIED;
>> --=20
>> 2=2E34=2E1
>

--=20
Kees Cook

