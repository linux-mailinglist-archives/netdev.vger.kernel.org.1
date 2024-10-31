Return-Path: <netdev+bounces-140843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33D9B8795
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C221F21CD4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B186A101EE;
	Fri,  1 Nov 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qx1vyEok"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-23.consmr.mail.bf2.yahoo.com (sonic309-23.consmr.mail.bf2.yahoo.com [74.6.129.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D817C69
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420325; cv=none; b=euIcTdKhRM5eRq32xLHO3FDjKnyGrXfxoF7Ggi6lEcuyx2M2DFTN0mLB0w7G0i9K+DRR+07aeLPYY8w1hGnRLmE2FvPgPicMEzgR5Ljpr7eH9BQkvycfaT4OgrvK3ao21w7NWfT/uxjJgYFTJeqTJ9V4zFHkOQlB/TA1eqgWyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420325; c=relaxed/simple;
	bh=bGeCFlDKVwcUrsRrfOolRi92r08DaTcp1HW8qctO0ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoU6femvw/bX5/VL+pBCVR/h1x+hrOKvwnKU8Qzmhp2IkkIQm+aFjYbnhfUA18dlKbQZHmxHZam9ZCiA13B6p5DcefY8SmNZpkgzL6t6rN+fCWabDw3t781lIaBeIWkrQYK1DWvEN3IcK3TjTQwOl0YoBRqypB/Abh7ariA2xxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qx1vyEok; arc=none smtp.client-ip=74.6.129.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730420317; bh=eu4JLi7eLmvP4ETQmNluHXDkiwbXDA/WottlZNR6SF0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qx1vyEokGL3K2VqyZcg/JKFTcKf/FpcbdW/bQGXJyM7YzHRr5eKg5A1fbcG70t+yVOSffGZxVoNaYu4e00KXb3GBtURBgNMSZ2ND8WgNPzO6vrU1OB+/OxwVw5HzbeY6k86prqCqHwNviQEZe+vDj0KMztJLoRIhzmW90DYhjV91QCAabLemjwnJWHPo2PceJ25KSZ0UZrrdD2hGsLQFWEbU3ujOr/9FevNApYZBD9NnsqeIZm2wlksMHEzw7mvlj/0ozG5V5yMNZIPnG35+ZYeoRlSiGDk1ev7ro9120aLfh5upHpqF05hrit+EsJ4Q9XM1ecoeHBg8jytHqH5OOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1730420317; bh=irGB6gWxwr0nNDJY7/tE/WkdfO6jnsD7jExlaazHX4y=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=G1eQIK9KEgpjdHiBVUBOU+9E+dDIy9gZoJLH+LOKzSaikSf0+alT3S9nlMjPJRITHlO7MAKgbzNCIzQG6HooDSs67oQxnz8arbJNlKMY+H1g51X5NcEhejn2AcZL+bVVtq9hbB2uGb0Nv0at3ODF0UbOY+XcTwvM9xI/ksIR3bjP0WFhPvQ9BrDKbm6ivPWnYzAZ0OthQ5c4ow5/L/FNUf87XnGaHGR7j3t8oC2lYrpDs+fM82hBUiWW96vry40xWQFvlrxjv4Oj3VxaZJ13VzB4QNZByvdJeVaBeqLscCbb95T4jGtHdJ2VAlTDC33mXJJcDz5cljeif4lJKfRSzQ==
X-YMail-OSG: JdQfgtYVM1n5tcS3SqmucOjrTFRw.RVpYkQtxq_APZq4BSI31ret4rbPS3lqWNI
 Zd5OhcVOUzZ3jx78ZLx9KfrUstkrllRV8flBe.59bGngygJ2oE67YSEMl4a8D4obFQyRophaulhB
 6AO28jMh89u_thyvVdxMd1wOmJdOGFjyZlTK97Y6cy_r9BfzCiekRZTRGqaWrxdhjGP.NTC.0AkO
 93AHqaKpIGgoCEjtdNnqMANm8RmEXTY60df7O3TUzIsOgHwBfkbYYbvwxDD7Rn7uw6R7wafM5GLo
 A6W21rLP2MKUtXGPxYiczuW8McJDabECNwBK3SqyHlPUrdcHoHoxKMozMRCTTReg9_ch24jCOGLH
 4MMPHiFHQ8Xh_Ax78SFRg8U8ol1nwJ4NRvq7E58ZT.5JGLW7omJ3BQMxvS5Sbuy8M6qay0MjVyfZ
 qXQl7qinJrlV4fAZYkyoYJTI2iLAOEoylPh8QcxhIRFuq__f8LM72tfZvQTk2tflHlB5I6bhbU9n
 oXG6llfg28chQGGeBJNuL9d7zfnF9deZgzQq5ublpbSQLspLdLspsiIRFA3TIdL9qoDjbhblXd1y
 ZnBncnUolv1U8d.KzqDqJTwNQzT8gQLXUbvEevP1iGny_JLm.jIj9OJsRGL2RTcuutNMgtPzcXLO
 diSEmB0Vw0VjaCi_BbmQvyWUbMMYUmYcJP1IFPiZJMeT1JiTEv3J6mHRPBkoUfL_xyyt87Ikjj0j
 qIO7bWPzyazA08j_P3hNTvgfWlQves2YZBpBZgxQcQ65EobL4qn9q1XccUCxVyut.bxSb5psOqRA
 jOMqEJATd8xES9u.EhrcjiFLk5VnpUYPE0q4k2cq3vQUVG979CNlXO8CTKVBGsVdGh7RD7M5CbQo
 vMMUp2lcp4QKq4arnAKIwn8DNnd4epjKFltjlvM_XuTbWu2q6rf6pVEVUe63pxXsxrWhkDMkEfjE
 Mjvd2RXbUnBV81lVKK33pJBZwcLzaPiMt01Myzl8sew6pEcmWFkjsyT0L90BiMv.Geaa7_iFVnjc
 X7AWonIwEMIXzXkCK9MF8pGNJIn0sOnoJvE1p0ytwaEcMH4tCodNPNsDc6MuNjZgU7OAxzw7VaGf
 8N82sRc1M.ArbRF9wMzuZWsQ6tWJlzeBMvrn_0zBinoCbtrPFeuT3LbkyL02UnRCABf5o0nHKdkT
 o9NP2sh0lg9gChaa9LM3CUZDwuIuiNRBSEkUj8c2vML76UNAcFf9OVTGhua6H3dK.SVZtZvybGvZ
 BlDciz0UPENNr5MkmTzIB89xPuCNS6YIAqpTkyiufbSv9.hf8XESWuJkDq0M95tWSAt6Y1x6Q1yO
 _xdDGjWtDs7YFaugkDgzO.fjXH4yA2uiJOWLOmHrxo39Q2c1I.bkEtMOTfuGpaB41wyJceEIk90q
 4uNRBhp87tTI0mT2vRJZxqLnvqaLjbTQdEZO4cCqmLyhbp1GF6rIlov9wrAOibBz8fOH_06UOfnl
 jdnNMOclf1dphshxxvttD1lwaDZAF719yBeKJ6ZP.GsycGt6uVIX_z.90AgUH3Bz7tGIjQLoFVKH
 usrgvEyDKDBUlb_BbYK5gGoOF3nPKh_gVV85D0.t43_hk5ippRFxAx2PEWVZfdh9FRNR2JZnaCh7
 dV6LfLGIII0X90tGSkCxusA99woXMRs_CUXpDtr6jwHH_rE7bTjyOFwh4AMjStEO9LDm5crKvbSY
 HX2zjZ.9Cuflnp24ZpuIcc_C_JvuTLmPWy24aVBj5grlc7pfRWzgfWEaXX7I24R5WBLTqrBFsuhH
 h52qh6uTWhgT2ck1KKylKqDy1vH9UTHX4mAOnlhK5Fre8VHuolQGIRBs.SS5PAEL2peTcZ8J2RdC
 O6CMZAvp5ocYn3GRR5VP17R_qmYjtXY1hzTN57T5nDfK7qTS_SymXR9C1K5hKZuEEEKDNaq0OEt_
 qQaDoc7VP4ngkWkLU19otSZHM5EMhnOy7.VOKCC43cZ3YXQG_YBNNA6Lc88yd9M.yNzl2.8Zgekw
 XQB6yYSclI.W6mVe0u_ZecI7NmeWaelD8ClGOk9RP7ArL4w7Wed8xyvLUuYywsIt0cupsJtWkIsj
 drB3SskGLMIdig1UQdugwPF_GPZBubmseLta_Fi3gq0CO8KLttwt7_XxLe.EhWwS6hKq7q2_uROa
 6IVzUCEmug3SXNCmVW68JhI97oCtQurk.7qol.djB7GppriU.qLswG9h0i8wDQpkQv3X3Qjk_YuC
 KpvXtBXPWykvrjFSd9Zc4nm.X2.PeEu.Xk50iHPLv712ATHW7kUi34QS36djBEp4VgyPywoAzYjh
 WXcPrlYMObDr3SRvMyE1r
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 23c0fe68-1315-4fb8-8fd1-1cbca2149f8b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Fri, 1 Nov 2024 00:18:37 +0000
Received: by hermes--production-gq1-5dd4b47f46-xx4tp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a32cda00a9a9713e3e947b5095f6c21c;
          Thu, 31 Oct 2024 23:58:17 +0000 (UTC)
Message-ID: <dd727620-9823-4701-aaf1-080b03fb6ccd@schaufler-ca.com>
Date: Thu, 31 Oct 2024 16:58:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] LSM: Replace context+len with lsm_context
To: Pablo Neira Ayuso <pablo@netfilter.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net,
 netdev@vger.kernel.org, audit@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241023212158.18718-3-casey@schaufler-ca.com>
 <68a956fa44249434dedf7d13cd949b35@paul-moore.com>
 <ZyQPfFvPD72rx4ME@calendula> <ZyQRgL_jWdvKgRl-@calendula>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ZyQRgL_jWdvKgRl-@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/31/2024 4:23 PM, Pablo Neira Ayuso wrote:
> On Fri, Nov 01, 2024 at 12:15:16AM +0100, Pablo Neira Ayuso wrote:
>> Hi Paul,
>>
>> This patch breaks nf_conntrack_netlink, Casey mentioned that he will
>> post another series.

I have a fix, it is pretty simple. How about I send a 6/5 patch for it?
Or, if you want to fix it yourself, in ctnetlink_secctx_size() remove the
declaration of "len" and replace its use in the return with "ret".

> Please, see:
>
> https://lore.kernel.org/netfilter-devel/ZxpxZuErvXSLApsf@calendula/
>
>> On Thu, Oct 31, 2024 at 06:53:38PM -0400, Paul Moore wrote:
>>> On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Replace the (secctx,seclen) pointer pair with a single
>>>> lsm_context pointer to allow return of the LSM identifier
>>>> along with the context and context length. This allows
>>>> security_release_secctx() to know how to release the
>>>> context. Callers have been modified to use or save the
>>>> returned data from the new structure.
>>>>
>>>> security_secid_to_secctx() and security_lsmproc_to_secctx()
>>>> will now return the length value on success instead of 0.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> Cc: netdev@vger.kernel.org
>>>> Cc: audit@vger.kernel.org
>>>> Cc: netfilter-devel@vger.kernel.org
>>>> Cc: Todd Kjos <tkjos@google.com>
>>>> ---
>>>>  drivers/android/binder.c                |  5 ++-
>>>>  include/linux/lsm_hook_defs.h           |  5 ++-
>>>>  include/linux/security.h                |  9 +++---
>>>>  include/net/scm.h                       |  5 ++-
>>>>  kernel/audit.c                          |  9 +++---
>>>>  kernel/auditsc.c                        | 16 ++++------
>>>>  net/ipv4/ip_sockglue.c                  |  4 +--
>>>>  net/netfilter/nf_conntrack_netlink.c    |  8 ++---
>>>>  net/netfilter/nf_conntrack_standalone.c |  4 +--
>>>>  net/netfilter/nfnetlink_queue.c         | 27 +++++++---------
>>>>  net/netlabel/netlabel_unlabeled.c       | 14 +++------
>>>>  net/netlabel/netlabel_user.c            |  3 +-
>>>>  security/apparmor/include/secid.h       |  5 ++-
>>>>  security/apparmor/secid.c               | 26 +++++++--------
>>>>  security/security.c                     | 34 +++++++++-----------
>>>>  security/selinux/hooks.c                | 23 +++++++++++---
>>>>  security/smack/smack_lsm.c              | 42 +++++++++++++++----------
>>>>  17 files changed, 118 insertions(+), 121 deletions(-)
>>> See my note on patch 1/5, merging into lsm/dev.

