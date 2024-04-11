Return-Path: <netdev+bounces-87135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572558A1D96
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F742836D8
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE91E7932;
	Thu, 11 Apr 2024 17:13:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C71E6F6E
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855622; cv=none; b=fbk9VSf1RavQydzVh4qyfulRXPc74qZ6M+RHwfuKl//jrtT8NS6Byu/OKSQpENbYP6vtzIpfHYR/j5INYKMGc/1FHcK0SF6dkySY8r6KyP11faZs9VcAJRTIasdeEF+uNVmeYgEECNHZr892/x3wDv9qBPPTYWrOd8jeT1s4Lvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855622; c=relaxed/simple;
	bh=V+EIRVUrZSLLRxpJ2mD22WIXjPmwpRVg3emzOMtJr5U=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=sGYz1YY+0nb9IsmAWx7h4enN/+mJaunVqJgpstlKTSHmfQm2W1KOeJK6K9u11Jwh+nD+CTTCrFjRqz0sm4ZbzfgcUaJyuC0QgiTY/DSpYJ8rwGKJWa84lRxteN7a2kRLfOfBdmNMlcbuFEyUYZ0UkgMKLUcRe2QHC3AlfPwpAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [47.50.120.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 4A3067D12D;
	Thu, 11 Apr 2024 17:13:39 +0000 (UTC)
References: <20240411114132.GO4195@unreal>
 <549D487E-8B20-439C-93EB-85E0B3C9A2D7@nohats.ca>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Paul Wouters <paul@nohats.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Antony Antony
 <antony.antony@secunet.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Eyal Birger <eyal.birger@gmail.com>, Nicolas
 Dichtel <nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>,
 devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 1/3] xfrm: Add Direction to
 the SA in or out
Date: Thu, 11 Apr 2024 12:40:30 -0400
In-reply-to: <549D487E-8B20-439C-93EB-85E0B3C9A2D7@nohats.ca>
Message-ID: <m24jc7lt50.fsf@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


Paul Wouters via Devel <devel@linux-ipsec.org> writes:

> On Apr 11, 2024, at 07:41, Leon Romanovsky via Devel <devel@linux-ipsec.o=
rg> wrote:
>>
>>
>> I asked it on one of the previous versions, but why do we need this limi=
tation?
>> Update SA is actually add and delete, so if user wants to update
>> direction, it should be allowed.
>
> An SA can never change direction without dealing with updated SPIs. Logic=
ally,
> it makes no sense. Sure, if you treat SA=E2=80=99s as Linux lego bricks t=
hat can be
> turned into anything, then yeah why not. Why not turn the SA into block d=
evice
> or magic flute?
>
> If you keep to the RFC, an SA is uni directional. More things might apply=
 too,
> eg the mode (transport vs tunnel) should not change, sequence numbers can=
 only
> increase, etc.

I have to agree. When we add new direction specific attributes (e.g., iptfs=
 send-rate, pkt-size, etc, for "out", reorder window size, drop-time for "i=
n") changing direction would mean removing invalidating these attributes an=
d possibly setting new different ones, deleting old send state adding new r=
eceive state, etc.. this doesn't feel like an SA update IMO, it feels like =
a new SA. I say we should apply KISS and just require a new SA for a differ=
ent direction attribute.

Thanks,
Chris.


>
> Paul


