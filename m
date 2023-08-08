Return-Path: <netdev+bounces-25621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370EA774EDE
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685EA1C20EE6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AFB18038;
	Tue,  8 Aug 2023 23:00:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814AF100B2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E44C433C9;
	Tue,  8 Aug 2023 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691535637;
	bh=1+fp21MqF6KntDdFbgZ1oMwBrAWE3yROyeT/Yf4gLaA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HV74zwmQ9KMzQVRuCI4qOWFBpxm1whPstAE6VTcXGI27a836eve4BHUhDQ6ZFrC0a
	 BQ4Mkjy1mkMXU2VdMCDfg7ic7NBPPKveWSt4+lVQuUQKm2MoLKFcUA8DB5oH33kLfM
	 L/DcI98+DBMx3Rc84SFCnwXVlbwP64W1fvJM75p8D41letvCfh9GRvKmNGXOfXq60G
	 F3uOq1RfFPgi0Vw0EO+rfzD6MQTLqEYpaPz05J9cLCA/pU222VzXpYyCc60BKB6vUq
	 VlZVnAzr7GmDDSZlpeNu1h+pHGpjZRNhYCeOE51giyiD8OmL2jIpFVLOQUBjwQyo2n
	 2GqkwP7vVLt1w==
Date: Tue, 08 Aug 2023 16:00:36 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
CC: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wang Weiyang <wangweiyang2@huawei.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH v2] netfilter: ebtables: fix fortify warnings
User-Agent: K-9 Mail for Android
In-Reply-To: <ZNJuMoe37L02TP20@work>
References: <20230808133038.771316-1-gongruiqi@huaweicloud.com> <ZNJuMoe37L02TP20@work>
Message-ID: <45DEF7A6-093D-4517-8CD8-D86D1671BE48@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 8, 2023 9:32:50 AM PDT, "Gustavo A=2E R=2E Silva" <gustavoars@ker=
nel=2Eorg> wrote:
>On Tue, Aug 08, 2023 at 09:30:38PM +0800, GONG, Ruiqi wrote:
>> From: "GONG, Ruiqi" <gongruiqi1@huawei=2Ecom>
>>=20
>> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=3Dy, the following
>> warning appears:
>>=20
>> In function =E2=80=98fortify_memcpy_chk=E2=80=99,
>>     inlined from =E2=80=98size_entry_mwt=E2=80=99 at net/bridge/netfilt=
er/ebtables=2Ec:2118:2:
>> =2E/include/linux/fortify-string=2Eh:592:25: error: call to =E2=80=98__=
read_overflow2_field=E2=80=99
>> declared with attribute warning: detected read beyond size of field (2n=
d parameter);
>> maybe use struct_group()? [-Werror=3Dattribute-warning]
>>   592 |                         __read_overflow2_field(q_size_field, si=
ze);
>>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
>>=20
>> The compiler is complaining:
>>=20
>> memcpy(&offsets[1], &entry->watchers_offset,
>>                        sizeof(offsets) - sizeof(offsets[0]));
>>=20
>> where memcpy reads beyong &entry->watchers_offset to copy
>> {watchers,target,next}_offset altogether into offsets[]=2E Silence the
>> warning by wrapping these three up via struct_group()=2E
>>=20
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei=2Ecom>
>> ---
>>=20
>> v2: fix HDRTEST error by replacing struct_group() with __struct_group()=
,
>> since it's a uapi header=2E
>>=20
>>  include/uapi/linux/netfilter_bridge/ebtables=2Eh | 14 ++++++++------
>>  net/bridge/netfilter/ebtables=2Ec                |  3 +--
>>  2 files changed, 9 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/include/uapi/linux/netfilter_bridge/ebtables=2Eh b/include=
/uapi/linux/netfilter_bridge/ebtables=2Eh
>> index a494cf43a755=2E=2Eb0caad82b693 100644
>> --- a/include/uapi/linux/netfilter_bridge/ebtables=2Eh
>> +++ b/include/uapi/linux/netfilter_bridge/ebtables=2Eh
>> @@ -182,12 +182,14 @@ struct ebt_entry {
>>  	unsigned char sourcemsk[ETH_ALEN];
>>  	unsigned char destmac[ETH_ALEN];
>>  	unsigned char destmsk[ETH_ALEN];
>> -	/* sizeof ebt_entry + matches */
>> -	unsigned int watchers_offset;
>> -	/* sizeof ebt_entry + matches + watchers */
>> -	unsigned int target_offset;
>> -	/* sizeof ebt_entry + matches + watchers + target */
>> -	unsigned int next_offset;
>> +	__struct_group(/* no tag */, offsets, /* no attrs */,
>> +		/* sizeof ebt_entry + matches */
>> +		unsigned int watchers_offset;
>> +		/* sizeof ebt_entry + matches + watchers */
>> +		unsigned int target_offset;
>> +		/* sizeof ebt_entry + matches + watchers + target */
>> +		unsigned int next_offset;
>> +	);
>>  	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct eb=
t_replace))));
>>  };

Actually, looking at what size_entry_mwt() is doing, I think you probably =
DO want a tag for this and to use a real structure for the manipulations in=
stead of doing array indexing? I dunno=2E This is a weird function! :)

-Kees

>> =20
>> diff --git a/net/bridge/netfilter/ebtables=2Ec b/net/bridge/netfilter/e=
btables=2Ec
>> index 757ec46fc45a=2E=2E5ec66b1ebb64 100644
>> --- a/net/bridge/netfilter/ebtables=2Ec
>> +++ b/net/bridge/netfilter/ebtables=2Ec
>> @@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry =
*entry, const unsigned char *ba
>>  		return ret;
>> =20
>>  	offsets[0] =3D sizeof(struct ebt_entry); /* matches come first */
>> -	memcpy(&offsets[1], &entry->watchers_offset,
>> -			sizeof(offsets) - sizeof(offsets[0]));
>> +	memcpy(&offsets[1], &entry->offsets, sizeof(offsets) - sizeof(offsets=
[0]));
>							^^^^^^^^^^^^
>You now can replace this ____________________________________|
>with just `sizeof(entry->offsets)`
>
>With that change you can add my
>Reviewed-by: Gustavo A=2E R=2E Silva <gustavoars@kernel=2Eorg>
>
>Thank you
>--
>Gustavo
>
>> =20
>>  	if (state->buf_kern_start) {
>>  		buf_start =3D state->buf_kern_start + state->buf_kern_offset;
>> --=20
>> 2=2E41=2E0
>>=20


--=20
Kees Cook

