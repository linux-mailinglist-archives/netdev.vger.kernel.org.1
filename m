Return-Path: <netdev+bounces-34372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034CC7A3F5A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 04:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0788E28132C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDBD139B;
	Mon, 18 Sep 2023 02:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A71108;
	Mon, 18 Sep 2023 02:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC020C433C8;
	Mon, 18 Sep 2023 02:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695002459;
	bh=P5kbmZu6oeMbM/PnhQwtSFCxSpJ/ktMepMBX4j4Jido=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HUAbS/TCe7nPwq9iMY0e26ipjFoUiBffiD5fT7l2g3TaWQyMdO6TQtwxPrAL8OAyA
	 tOx6KNswGmyoE1K3q4YUgvR/3c1Maio31BPI5X+1KK6j02difk4fccVLavTCwm7O8v
	 VcwoQnPM1mbeLHUxZUmguNzib4JS8g9ky5cgwrcOL5tYfEo6buOuPJ8tvmkjwrLhgH
	 f8OeEJfCCkwVsiSuHfZC3wWCcIWzkheG+zFPJ941VYLeKvHmvZhECqiX+rjG21HYbe
	 asL6UhTSv7j2kSuOq8eAeFq+yXT2tqyWWUCBfECV951LtP9WzNMdeAvPSkMTbnTPnK
	 zl3YvI+dQttEg==
Date: Sun, 17 Sep 2023 19:00:58 -0700
From: Kees Cook <kees@kernel.org>
To: Xiubo Li <xiubli@redhat.com>, Kees Cook <keescook@chromium.org>,
 Ilya Dryomov <idryomov@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ceph-devel@vger.kernel.org,
 netdev@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
User-Agent: K-9 Mail for Android
In-Reply-To: <3c4c7ca8-e1a2-fbb1-bda4-b7000eb9a8d9@redhat.com>
References: <20230915201510.never.365-kees@kernel.org> <3c4c7ca8-e1a2-fbb1-bda4-b7000eb9a8d9@redhat.com>
Message-ID: <6122C479-ADD9-43A8-8EB6-CF518F97F64C@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 17, 2023 5:25:10 PM PDT, Xiubo Li <xiubli@redhat=2Ecom> wrote:
>
>On 9/16/23 04:15, Kees Cook wrote:
> > [=2E=2E=2E]
>> Additionally, since the element count member must be set before accessi=
ng
>> the annotated flexible array member, move its initialization earlier=2E
>>=20
>> [=2E=2E=2E]
>> diff --git a/net/ceph/mon_client=2Ec b/net/ceph/mon_client=2Ec
>> index faabad6603db=2E=2Ef263f7e91a21 100644
>> --- a/net/ceph/mon_client=2Ec
>> +++ b/net/ceph/mon_client=2Ec
>> @@ -1136,6 +1136,7 @@ static int build_initial_monmap(struct ceph_mon_c=
lient *monc)
>>   			       GFP_KERNEL);
>>   	if (!monc->monmap)
>>   		return -ENOMEM;
>> +	monc->monmap->num_mon =3D num_mon;
>>     	for (i =3D 0; i < num_mon; i++) {
>>   		struct ceph_entity_inst *inst =3D &monc->monmap->mon_inst[i];
>> @@ -1147,7 +1148,6 @@ static int build_initial_monmap(struct ceph_mon_c=
lient *monc)
>>   		inst->name=2Etype =3D CEPH_ENTITY_TYPE_MON;
>>   		inst->name=2Enum =3D cpu_to_le64(i);
>>   	}
>> -	monc->monmap->num_mon =3D num_mon;
>
>BTW, is this change related ?

Yes, this is needed so that the __counted_by size is set before accessing =
the flexible array=2E

>
>>   	return 0;
>>   }
>>  =20
>
>Else LGTM=2E
>
>Reviewed-by: Xiubo Li <xiubli@redhat=2Ecom>

Thanks!


--=20
Kees Cook

