Return-Path: <netdev+bounces-85405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0387789AADF
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49131F21A85
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5FD2D05E;
	Sat,  6 Apr 2024 12:40:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32092869B
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712407210; cv=none; b=WeWwb5lVaKE4DmbOFkw2dPJYc9hGR1CbdZNKznjFejCgo7kAh6ztN72rZEgUqq9HBMNALF9l3c+9cE++UnoSXAobKKsM57Ccu2oyfxNWWKquS3HzeWa1f82iMAhQOIrRHhvjKo3+/KzoBSx7tvTjH/+4P2GM7HBqsQQ3m3zTCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712407210; c=relaxed/simple;
	bh=xIYM2o601b/3cnpx8pROVh3pFbf0yLqdJG8lZ4k5GNw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AIevZF8AJyiw3VDSE99YtiCbjiAy8Dh/PFSXgP8L1SLWtWQb3x/xlEKfjNoQRPMvbwcXHlaCd498WXtag7MISEq9jrbHjQImqshC9KXyJy1NAypoD9ck6EiWvu/pqeR4qgURfeed+VpZmab+OmoYjTvSMsE5ZmjWCw4NiPDrldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from smtpclient.apple (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id F045E7D128;
	Sat,  6 Apr 2024 12:40:07 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5] xfrm: Add Direction to the SA
 in or out
From: Christian Hopps <chopps@chopps.org>
In-Reply-To: <13307e0d-11c8-4530-8182-37ecb2f8b8a3@6wind.com>
Date: Sat, 6 Apr 2024 08:39:57 -0400
Cc: Christian Hopps <chopps@chopps.org>,
 Antony Antony <antony.antony@secunet.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 devel@linux-ipsec.org,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7A9D035-C190-4CB9-A873-21A783BC0DCB@chopps.org>
References: <0baa206a7e9c6257826504e1f57103a84ce17b41.1712219452.git.antony.antony@secunet.com>
 <13307e0d-11c8-4530-8182-37ecb2f8b8a3@6wind.com>
To: nicolas.dichtel@6wind.com
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi Nicolas,

IPTFS is the planned first user of the direction attribute. Antony noted =
that most IPTFS config is only for the sending SA and created this patch =
as a result.

Thanks,
Chris.

> On Apr 4, 2024, at 10:08, Nicolas Dichtel via Devel =
<devel@linux-ipsec.org> wrote:
>=20
> Le 04/04/2024 =C3=A0 10:32, Antony Antony a =C3=A9crit :
>> This patch introduces the 'dir' attribute, 'in' or 'out', to the
>> xfrm_state, SA, enhancing usability by delineating the scope of =
values
>> based on direction. An input SA will now exclusively encompass values
>> pertinent to input, effectively segregating them from output-related
>> values. This change aims to streamline the configuration process and
>> improve the overall clarity of SA attributes.
>>=20
>> This feature sets the groundwork for future patches, including
>> the upcoming IP-TFS patch. Additionally, the 'dir' attribute can
>> serve purely informational purposes.
>> It currently validates the XFRM_OFFLOAD_INBOUND flag for hardware
>> offload capabilities.
> Frankly, it's a poor API. It will be more confusing than useful.
> This informational attribute could be wrong, there is no check.
> Please consider use cases of people that don't do offload.
>=20
> The kernel could accept this attribute only in case of offload. This =
could be
> relaxed later if needed. With no check at all, nothing could be done =
later, once
> it's in the uapi.
>=20
>=20
> Regards,
> Nicolas
> --=20
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel


