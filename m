Return-Path: <netdev+bounces-25001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E33772822
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EB728119E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0AEDDD8;
	Mon,  7 Aug 2023 14:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA120FE
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F951C433C8;
	Mon,  7 Aug 2023 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691419670;
	bh=bpPHccARP+nSofUhaL1UTNcFQ9beOi9t6SJoSE+64CU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DVCe7XhX+w1CcVE9sMRbu4kaoE22D7T378pKolQU/NZkUYIovAC2clzWcvxvhvRYx
	 PrC6uO0Qv0Tbh4NmYEvmCdt2GKSJdMzbJ3rB71PbVkaUKuPfah3HwUL1pSyHVNgbuJ
	 he84dzDxmHUA2axwG0pD3mzpNxZUl+dSYIvnyVGOqgSmYZt/aQSI8rh/9PZGUtTsFv
	 7E3xr8V5a3feekKKFD/CUnEjkS8yfFKW3fgpbIfke32KYpl2qwWk603RF4Q9tRbrRu
	 HB9tYJUECFjU9Mv0SPoUpnM0R4t9basYDKo7AxVMYbSxcFAuqtzUAkK/9GAcQuzZiE
	 94om0YYaPitPQ==
Date: Mon, 07 Aug 2023 07:47:47 -0700
From: Kees Cook <kees@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Kees Cook <keescook@chromium.org>, Jacob Keller <jacob.e.keller@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_net-next_1/2=5D_overflow=3A_ad?= =?US-ASCII?Q?d_DECLARE=5FFLEX=28=29_for_on-stack_allocs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9f817d7a-8f85-9217-620f-dd2f62c2c050@intel.com>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com> <20230801111923.118268-2-przemyslaw.kitszel@intel.com> <202308011403.E0A8D25CE@keescook> <e0cb5bf2-2278-b83f-c45c-0556927787a6@intel.com> <572fb95a-7806-0ed1-00e3-6a7796273946@intel.com> <9f817d7a-8f85-9217-620f-dd2f62c2c050@intel.com>
Message-ID: <6C572B68-2913-4F5B-8295-C001A98CA7A2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 7, 2023 5:42:31 AM PDT, Przemek Kitszel <przemyslaw=2Ekitszel@int=
el=2Ecom> wrote:
>On 8/4/23 17:44, Alexander Lobakin wrote:
>> From: Przemek Kitszel <przemyslaw=2Ekitszel@intel=2Ecom>
>> Date: Fri, 4 Aug 2023 15:47:48 +0200
>>=20
>>> On 8/2/23 00:31, Kees Cook wrote:
>>>=20
>>> [=2E=2E=2E]
>>>=20
>>>> Initially I was struggling to make __counted_by work, but it seems we=
 can
>>>> use an initializer for that member, as long as we don't touch the
>>>> flexible
>>>> array member in the initializer=2E So we just need to add the counted=
-by
>>>> member to the macro, and use a union to do the initialization=2E And =
if
>>>> we take the address of the union (and not the struct within it), the
>>>> compiler will see the correct object size with __builtin_object_size:
>>>>=20
>>>> #define DEFINE_FLEX(type, name, flex, counter, count) \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 union { \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0 byte=
s[struct_size_t(type, flex, count)]; \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type obj; \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 } name##_u __aligned(_Alignof(type)) =3D { =
=2Eobj=2Ecounter =3D count }; \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 /* take address of whole union to get the c=
orrect
>>>> __builtin_object_size */ \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 type *name =3D (type *)&name##_u
>>>>=20
>>>> i=2Ee=2E __builtin_object_size(name, 1) (as used by FORTIFY_SOURCE, e=
tc)
>>>> works correctly here, but breaks (sees a zero-sized flex array member=
)
>>>> if this macro ends with:
>>>>=20
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 type *name =3D &name##_u=2Eobj
>>>=20
>>> __builtin_object_size(name, 0) works fine for both versions (with and
>>> without =2Eobj at the end)
>>>=20
>>> however it does not work for builds without -O2 switch, so
>>> struct_size_t() is rather a way to go :/
>>=20
>> You only need to care about -O2 and -Os, since only those 2 are
>> officially supported by Kbuild=2E Did you mean it doesn't work on -Os a=
s well?
>
>Both -Os and -O2 are fine here=2E
>
>One thing is that perhaps a "user friendly" define for "__builtin_object_=
size(name, 1)" would avoid any potential for misleading "1" with any "count=
er" variable, will see=2E

I meant that FORTIFY_SOURCE will work correctly in the example I gave=2E (=
__builtin_object_size() is used there=2E) Also note that "max size" (mode 0=
) is unchanged in either case, but mode 1 needs to see the outer object to =
get the min size correct=2E

-Kees


--=20
Kees Cook

