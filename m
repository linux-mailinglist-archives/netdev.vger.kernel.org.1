Return-Path: <netdev+bounces-239344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA680C67011
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 512064ECEF1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B9E3254BE;
	Tue, 18 Nov 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln1TixMs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30CC3254A2
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432505; cv=none; b=i6Zo9YK+FVeANaup7OjfI9HNrMJbMW6WjRVeQruOdV99PQIE2I8pRP7TTzfquBu/fFne6RqsEtzj4v5+UL4x4zHIWYvMrRucpN+5QR+aU9H60wGOGSlRFLozkgHTrQWLMMVEomWPJ11AxhP1+H6IcbmnGjLTaVgMFOqRhM42pHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432505; c=relaxed/simple;
	bh=Dxo6argfOd4gg/MKHqkObtOc3KDfRSBa9IFUE06if1k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UqmzBt1IaPg8kN3kerXyZCVZT4qoAb8gQJdfCD6W/6wvyMSp6Qmn0t5ThsAeDw04n9UjWBCa+A1gJi6Df+2TIX5GqR4OUxgpZYjcOzhB/HfgNqUy9I6z/SWLhCre+RK7EBWjMwfvjwOLIMSamuiWR8CmWpVdapSxvDipWwkrkzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln1TixMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62E0C116B1;
	Tue, 18 Nov 2025 02:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763432504;
	bh=Dxo6argfOd4gg/MKHqkObtOc3KDfRSBa9IFUE06if1k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ln1TixMs1IM1Mvse9jG5LEtAfDAHdpx9z7R9e/+6NO5mTKRN0V5j2PsMik1TxXhqz
	 Gy1dR7SmJd2iuoM2eoIGSV11afSnalPTKaDDOGTiaJ68ED+LGAgRdhrUijFkWDjgcH
	 LsOfP9Q4+26zX/WoG66cwqAgrw7VWImWjUhpbgXQ6VrM9NYtn7Qi1x5sCGWJhdaLCN
	 xuy8Mrc0qOzYkWYHq4M7CO0hz8VOAMxn8npU82Upor+ILu5MGuiM0d3UyCPDSNTb6f
	 J1ZRSIaV8SNiAw4soLM8G5G71BISifP8qZL7lPaEqA+vJ+TSl1xIl67PfzNdJAgrwH
	 1EC9uFt0wWPig==
Date: Tue, 18 Nov 2025 03:21:35 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	=?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>
Message-ID: <e7aba5b3-d402-4a09-9656-1b96be6efa84@kernel.org>
In-Reply-To: <aRvIh-Hs6WjPiwdV@fedora>
References: <20251117024457.3034-1-liuhangbin@gmail.com> <20251117024457.3034-4-liuhangbin@gmail.com> <b3041d17-8191-4039-a307-d7b5fb3ea864@kernel.org> <aRvIh-Hs6WjPiwdV@fedora>
Subject: Re: [PATCHv5 net-next 3/3] tools: ynl: add YNL test framework
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <e7aba5b3-d402-4a09-9656-1b96be6efa84@kernel.org>

18 Nov 2025 02:15:08 Hangbin Liu <liuhangbin@gmail.com>:

> On Mon, Nov 17, 2025 at 11:59:32AM +0100, Matthieu Baerts wrote:
>> I just have one question below, but that's not blocking.
>>
>> (...)
>>
>>> diff --git a/tools/net/ynl/tests/test_ynl_cli.sh b/tools/net/ynl/tests/=
test_ynl_cli.sh
>>> new file mode 100755
>>> index 000000000000..cccab336e9a6
>>> --- /dev/null
>>> +++ b/tools/net/ynl/tests/test_ynl_cli.sh
>>> @@ -0,0 +1,327 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Test YNL CLI functionality
>>> +
>>> +# Load KTAP test helpers
>>> +KSELFTEST_KTAP_HELPERS=3D"$(dirname "$(realpath "$0")")/../../../testi=
ng/selftests/kselftest/ktap_helpers.sh"
>>> +# shellcheck source=3D/dev/null
>>
>> Out of curiosity, why did you put source=3D/dev/null? It is equivalent t=
o
>> "disable=3DSC1090" and there is no comment explaining why: was it not OK
>> to use this?
>>
>> =C2=A0 shellcheck source=3D../../../testing/selftests/kselftest/ktap_hel=
pers.sh
>>
>
> I got the following warning with it
>
> In test_ynl_cli.sh line 8:
> source "$KSELFTEST_KTAP_HELPERS"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^-----------------------^ SC1091 (in=
fo): Not following: ../../../testing/selftests/kselftest/ktap_helpers.sh wa=
s not specified as input (see shellcheck -x).

How did you execute shellcheck?

If I'm not mistaken, you are supposed to execute it from the same directory=
, and with -x:

=C2=A0 cd "$(dirname "${script}")"
=C2=A0 shellcheck -x "$(basename "${script}")"

Cheers,
Matt

