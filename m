Return-Path: <netdev+bounces-85406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190989AAEE
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 14:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28643282258
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 12:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5092C1A3;
	Sat,  6 Apr 2024 12:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ECEE546
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712407529; cv=none; b=gRC0ZrT2AhDlCHb4VaaQJnFmPtmVVsxdtmUBPHFAIm/4h6MrYO4AOAdv0ZvOelFWbwUiCVZJfv59CtaBgXGJfjviIgzrumyOB7ecYA5pcY3ipwKc9J22aNJt6iC0sROwdTCLhqbaywKkOxbI9xNO95m6m+blUo8VeVgPaz8bs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712407529; c=relaxed/simple;
	bh=jXG8WT8tTm5rxdE5PY8Uo30AJqEfXI4UjfQ7ZR6Q7Ys=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SVYPKBxA7gP7f7W3SMbFaf47Vj8snhXxIRx37DU8QeEFK2X6YxJjVovqEb8LgUSNiIcc+jmwKG1f0KPKv6ySpMTTg+Yo/BEnFwWnRfKosuIyb6ag1pl8EcKLoiJKn8lcHkhsEG1yUgyoPHt7b0L3ZoqsaxR8iZ+RdDSLiH3YT58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 0912C7D111;
	Sat,  6 Apr 2024 12:36:19 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the SA
 in or out
From: Christian Hopps <chopps@chopps.org>
In-Reply-To: <ZhBzcMrpBCNXXVBV@hog>
Date: Sat, 6 Apr 2024 08:36:09 -0400
Cc: Christian Hopps <chopps@chopps.org>,
 Antony Antony <antony.antony@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org,
 devel@linux-ipsec.org,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F71A296-D9DF-4C4F-844E-CB3DE01B3F34@chopps.org>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog>
To: Sabrina Dubroca <sd@queasysnail.net>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Apr 5, 2024, at 17:56, Sabrina Dubroca via Devel =
<devel@linux-ipsec.org> wrote:
>=20
> Hi Antony,
>=20
> 2024-04-05, 14:40:07 +0200, Antony Antony wrote:
>> This patch introduces the 'dir' attribute, 'in' or 'out', to the
>> xfrm_state, SA, enhancing usability by delineating the scope of =
values
>> based on direction. An input SA will now exclusively encompass values
>> pertinent to input, effectively segregating them from output-related
>> values.
>=20
> But this patch isn't doing that for existing properties (I'm thinking
> of replay window, not sure if any others are relevant [1]). Why not?
>=20
> [1] that should include values passed via xfrm_usersa_info too,
>    not just XFRMA_* attributes
>=20
> Adding these checks should be safe (wrt breakage of API): Old software
> would not be passing XFRMA_SA_DIR, so adding checks when it is =
provided
> would not break anything there. Only new software using the attribute
> would benefit from having directed SAs and restriction on which =
attributes
> can be used (and that's fine).
>=20
> Right now the new attribute is 100% duplicate of the existing offload
> direction, so I don't see much point.

A subset of the ipsec has requested that IPTFS utilize this new =
directional attribute as most of IPTFS config is send-only. So IPTFS is =
the planned first user and is also now blocked on this patch.

Chris.


>=20
>> This change aims to streamline the configuration process and
>> improve the overall clarity of SA attributes.
>>=20
>> This feature sets the groundwork for future patches, including
>> the upcoming IP-TFS patch.
>>=20
>> Currently, dir is only allowed when HW OFFLOAD is set.
>>=20
>> ---
>=20
> BTW, everything after this '---' will get cut, including your =
sign-off.
>=20
>> v5->v6:
>> - XFRMA_SA_DIR only allowed with HW OFFLOAD
>>=20
>> v4->v5:
>> - add details to commit message
>>=20
>> v3->v4:
>> - improve HW OFFLOAD DIR check check other direction
>>=20
>> v2->v3:
>> - delete redundant XFRM_SA_DIR_USE
>> - use u8 for "dir"
>> - fix HW OFFLOAD DIR check
>>=20
>> v1->v2:
>> - use .strict_start_type in struct nla_policy xfrma_policy
>> - delete redundant XFRM_SA_DIR_MAX enum
>> ---
>>=20
>> Signed-off-by: Antony Antony <antony.antony@secunet.com>
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>=20
> nit: If I'm making non-trivial changes to the contents of the patch, I
> typically drop the review (and test) tags I got on previous versions,
> since they may no longer apply.
>=20
> --=20
> Sabrina
>=20
> --=20
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel
>=20


