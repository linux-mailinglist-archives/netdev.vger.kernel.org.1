Return-Path: <netdev+bounces-152528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887829F479F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE35A16104B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6D1D45EF;
	Tue, 17 Dec 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWOL8Oxb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520592E628;
	Tue, 17 Dec 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428017; cv=none; b=Hj2lpGmNdTvfsg1MpfPT+yehEu+fjWK3Nhp2hwNu7SesLYJEJV2IXy1Pao2Pb2BPudVeFh0Z9LNV3PZMo8W9vazNf17DRnWjwXD0aexX3wkW+CrEhbkAvs1+QCFPvoonZk4wE5O5lfVymlJuzw+ilFJ/WpPoLI+0DSgDfq2rzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428017; c=relaxed/simple;
	bh=AMWNPcIppmlMgqthtCqMphIBrnk4GeQh0Fku2n6+edY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iXO3rLwnf+NaR5lET5dbHv2xHjFPOVKULqN/BAiykWKvDxXW9LHFCloPoKEXZE27kr760q/8xc4Pp7xk+nh7KHbji15ks5uraYhQC2B4/fNH4UiEHJAMaOKoVOjuU5bOmcH4ahhUm+Qz/8ZLlbwDj3+LYvqBsmRh6UDDRFNC/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWOL8Oxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49A3C4CED3;
	Tue, 17 Dec 2024 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734428016;
	bh=AMWNPcIppmlMgqthtCqMphIBrnk4GeQh0Fku2n6+edY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=kWOL8OxbztGzBa9aSTv2r4iX1AJd8gPeYodWZ4PXD+KEv27fga3ffI69hulyPTvTr
	 E92yIhr/kZCZMtpyx6ceL57WT69HnDxW9djHXCaFWtod/k8v4jXaGVTlhPXKdg+a3M
	 inyvT/vsVANzWmB89O6E2PuaQIGogQurcibM3Uw9LB1X6/i1ci2Mi8+Vmdh6dpBO88
	 Pu5v20siRitLbBcEpEEqWxCIZF6EHgKeI1cSGVXq7Cs3L3PYizSBcmMG7GazmsBJCv
	 Xora8iSCTSGbM993A288UPqdDJRySwAfvorC2P+Dk9F22dB3JeO6YCcSq0NTLx+rkw
	 sHQqB6LOxIHZQ==
Date: Tue, 17 Dec 2024 01:33:33 -0800
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: davem@davemloft.net, edumazet@google.com, horms@kernel.org, idosch@nvidia.com,
 kuba@kernel.org, kuniyu@amazon.com, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 petrm@nvidia.com
Subject: Re: [PATCH] rtnetlink: do_setlink: Use true struct sockaddr
User-Agent: K-9 Mail for Android
In-Reply-To: <20241217080335.85554-1-kuniyu@amazon.com>
References: <36C08CAB-1D3A-46CE-BCE2-820605E222CF@kernel.org> <20241217080335.85554-1-kuniyu@amazon.com>
Message-ID: <980CE89E-0E8A-4A0D-A1E4-D03DB8F86A21@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 17, 2024 12:03:35 AM PST, Kuniyuki Iwashima <kuniyu@amazon=2Ec=
om> wrote:
>From: Kees Cook <kees@kernel=2Eorg>
>Date: Mon, 16 Dec 2024 23:53:46 -0800
>> On December 16, 2024 6:41:56 PM PST, Kuniyuki Iwashima <kuniyu@amazon=
=2Ecom> wrote:
>> >From: Kees Cook <kees@kernel=2Eorg>
>> >Date: Mon, 16 Dec 2024 18:04:45 -0800
>> >> Instead of a heap allocation use a stack allocated struct sockaddr, =
as
>> >> dev_set_mac_address_user() is the consumer (which uses a classic
>> >> struct sockaddr)=2E
>> >
>> >I remember Eric's feedback was to keep using heap instead of stack
>> >because rtnl_newlink() path already uses too much on stack=2E
>>=20
>> See below=2E=2E=2E
>>=20
>> >
>> >
>> >> Cap the copy to the minimum address size between
>> >> the incoming address and the traditional sa_data field itself=2E
>> >>=20
>> >> Putting "sa" on the stack means it will get a reused stack slot sinc=
e
>> >> it is smaller than other existing single-scope stack variables (like
>> >> the vfinfo array)=2E
>>=20
>> That's why I included the rationale above=2E (I=2Ee=2E stack usage does=
 not grow with this patch=2E)
>
>Ah okay, but I think we can't cap the address size to 14
>bytes=2E  MAX_ADDR_LEN is 32=2E
>
>Also, dev_set_mac_address_user() still uses dev->addr_len=2E

Oh, hrm, yes, that's true=2E I had audited callers of dev_set_mac_address(=
), but I think I must have missed callers of dev_set_mac_address_user()=2E =
Ugh=2E :( Let me take another look at this=2E=2E=2E

-Kees

>
>
>>=20
>> -Kees
>>=20
>> >>=20
>> >> Signed-off-by: Kees Cook <kees@kernel=2Eorg>
>> >> ---
>> >> Cc: Eric Dumazet <edumazet@google=2Ecom>
>> >> Cc: "David S=2E Miller" <davem@davemloft=2Enet>
>> >> Cc: Jakub Kicinski <kuba@kernel=2Eorg>
>> >> Cc: Paolo Abeni <pabeni@redhat=2Ecom>
>> >> Cc: Ido Schimmel <idosch@nvidia=2Ecom>
>> >> Cc: Petr Machata <petrm@nvidia=2Ecom>
>> >> Cc: netdev@vger=2Ekernel=2Eorg
>> >> ---
>> >>  net/core/rtnetlink=2Ec | 22 +++++++---------------
>> >>  1 file changed, 7 insertions(+), 15 deletions(-)
>> >>=20
>> >> diff --git a/net/core/rtnetlink=2Ec b/net/core/rtnetlink=2Ec
>> >> index ab5f201bf0ab=2E=2E6da0edc0870d 100644
>> >> --- a/net/core/rtnetlink=2Ec
>> >> +++ b/net/core/rtnetlink=2Ec
>> >> @@ -3048,21 +3048,13 @@ static int do_setlink(const struct sk_buff *=
skb, struct net_device *dev,
>> >>  	}
>> >> =20
>> >>  	if (tb[IFLA_ADDRESS]) {
>> >> -		struct sockaddr *sa;
>> >> -		int len;
>> >> -
>> >> -		len =3D sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
>> >> -						  sizeof(*sa));
>> >> -		sa =3D kmalloc(len, GFP_KERNEL);
>> >> -		if (!sa) {
>> >> -			err =3D -ENOMEM;
>> >> -			goto errout;
>> >> -		}
>> >> -		sa->sa_family =3D dev->type;
>> >> -		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
>> >> -		       dev->addr_len);
>> >> -		err =3D dev_set_mac_address_user(dev, sa, extack);
>> >> -		kfree(sa);
>> >> +		struct sockaddr sa =3D { };
>> >> +
>> >> +		/* dev_set_mac_address_user() uses a true struct sockaddr=2E */
>> >> +		sa=2Esa_family =3D dev->type;
>> >> +		memcpy(sa=2Esa_data, nla_data(tb[IFLA_ADDRESS]),
>> >> +		       min(dev->addr_len, sizeof(sa=2Esa_data_min)));
>> >> +		err =3D dev_set_mac_address_user(dev, &sa, extack);
>> >>  		if (err)
>> >>  			goto errout;
>> >>  		status |=3D DO_SETLINK_MODIFIED;
>> >> --=20
>> >> 2=2E34=2E1
>> >
>>=20
>> --=20
>> Kees Cook

--=20
Kees Cook

