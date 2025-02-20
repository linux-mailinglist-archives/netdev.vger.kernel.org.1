Return-Path: <netdev+bounces-168214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48D7A3E1E7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683AA3B14C6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEEB211A0E;
	Thu, 20 Feb 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M7lICHL3"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4621128F
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071037; cv=none; b=gzzuqixIM/U/RI+TIhgg/Zea8pPBnFcXT9PR+UyxokmAuHne9244mmb95bUi/qml7XwbiOYtBjgTlycjDUFA0/XVoBjWEX06PJXj10sFMJbrJLA7d7ZZSgDZeudCPYJIF3wRcPIxEw6Q0BA81pbDhMiyCL9TBD0LzlLnkOYg+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071037; c=relaxed/simple;
	bh=5+S9/Si9gNsDr9p4HVkVVkrMAupZZtn+rX610VhWUJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqitIxNRGyJ/kbH2wUH02JPq1NaJNXsuQMgCa/OlfOIagBRogO5tD+nOad/pNkFV+QwYVXqs7XURrTBypaA7jrKPMZQRcpZFqnJoz/78y8fGR/nzeRw1rZfX/QAWc4wXW4iuLbE2jZPvZoVgHJm1vbYfZnoAF0PL5pmldl3MEJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=M7lICHL3; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740071034; bh=MBDOOJln965UMaLJqLVpgP08hYXFIFAWNSXzmCDWeXg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=M7lICHL3itRZ+cCsgKXVJsl9YJySNq2OPCSdWpMvqTPcWXjXkt+GLwsL2oEU5bpHsCN2ibtGaFAWEFo/qIEBXEkrFrULLBrefZFLZf9nyhjzpuQWydVwnX1MIsb7C/DTplj60symk6uG4q8kzWOmdMDGO7bUFoYdyOOfJVOJzuQ75SFcsCZq+A4/WFv47lpOqhsuIUgpg2lNHhjd181woBMi15udgwYCQnMpwUsZT4o2r5Av1S9fcVTU6sKovsetX+0raHKvFJp2wyb9mJwc9Akl5C8McIA6UdqsKpiyy0gBUEY67PL/4qTinV2D6wEgwIxUOLSi++4alHH51xzjIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740071034; bh=JVQSUMU/Fz2jay0QMUPBfbps1oXEq+ChL2f7ZKDEWf5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tnjXs1npUQ+tG56DWrbGNrc7qiAahj2qbACv3QieMr506DSG0NbxQffmdv2d/oYkoYwn3izvDGbhTyFDGj3VnTD2R2Kd1p8EhWbLs1g0lVTRoYWRf2lo59T9OF+FOrXW3y6x3vXLtj2tQ9nzfgl/d2fs0F3u563FUjj87Y4VrMAx4t5LjGWuS6owTzE8rFhpCoHTo86o7mb98vwZcQQbcZB5NPlq7s4xLRyz70MsVRN462xhKEDI0zB2Iy6D7Z5xU+B0NolB/H1jVJwCTsq/g2u2moPvH/W6r1WJQO9SaLZeZDQM/FQanPCJxCVgUDUxB8EkffUJC6pxTNelFmuLGA==
X-YMail-OSG: Q8qn1SIVM1kVUO_za3yB4ULvDAxXYeAhMsZZ8aPjrY.3V6jwf0fuxXgqmdKomIg
 WSA8IZdDoqnjz9l.Qjv9vz9n7EZ.w67WyskmuQZrkD_HbUl29CmTbYIrokjUpPbsRHaSftvVNzKF
 iKrx9.fXk6dmJQFxGGzh1t.mCR0ZHydGkD1dJN0ZTyq7oXZiwP6XawS.Lz1uETY4HSoinG5gTEhP
 t0vGKbbaLEh.qQW6tYTkA1P052inloMr3XPyMdaLkYsUcYixIw6o0xIDMwkE_OovtqNaCs4mdCoS
 Out9ZpXz8XO_4SOllgljUn8tVpS7zGBtutcd9MV6Nx2dVLGNIwm9OSLLhTxMXNzYVlhGHg2DH1Cg
 QG03Cfv70of3yHJWnezFKZ46TKooZiK2eikrBWJ8ZpgfzqUVHsTCjhC1K60YMieoDV9x1JslavrO
 9LCJFQhPwjeqkapFLF372eImj9MOQLwZhiJCWo7Otp7GHq_9CEW2Ws6cY7MdeJSEnAPPGCGrBaP7
 _0cpSC_1RnuJN6eQrMg7VJFTN52psui6shP6.YyoKWN3QolwSbaWiRNxSoBgiYrD3XND8kzjJHMz
 0n.usN7gzLINIZF_aMqqSLI6jaGdHL9GXTcanGEAOgMiWapbm31qDuTkZU9v23iX4J8GrIFtFJpY
 oEJbz30QH56J.aYVkIxJcXjSv6pujtEz1ieghEzdpohVyOIA738UYPlUnQyGHBcN3mlH41Nnqfio
 bEbUyNXzaVfnFY8niVaVFurRVlbukE3CudMcy6DUCtbzf0jmokU65GOcQRJkGLYgWE2I53d4tmXK
 iSBaWrtRvh3LZMUT2KDk40s2ecmBN3VWu6XSmNtMWSdKNlPtlWh4vjysbEvogoCK1N0suPxHVF2N
 bbwrSn2h4yNbpnnEuMjmnnc85XFKaCEn.ip5sdnuQkyCGxt72sdPICTbnCjFb4f5rgd6N53Rzm57
 uJJ9clW3oxXjGaBt0MShC9s8xaADLHeJOjbT5oRjJrTZ4uRDyJpPrA0CoXoSAbXjRZ._YWq1evZ0
 QF3H.V1ozCp92yrBMQzq1o.NyJQ1dMtna4avGCWxizac9ran2NOCUbR4hLQ3TvQo9TxDCsVv_wab
 UNYwTbuBj10.a_7p7oP2XCdwLgqzcPIo2IgS31TVdvn2v6IDsC2tWoy6Ou6w_u9JS4KMTWzcU2mW
 fUPUKvKmEUqvRVwtsEQm9tObgPPQjyz_JhRNJP3GE8bx81S_CPSFXu0Teiv1hbgkVt2BCSdiN0s3
 KWcCGmxffQtzy2t0R3OCb8mPUkgriRJbbYwe8zZb.dJ2hhT4X1qYyq1rapJKsdfdY.AApeZEXyGO
 MsGMwWv7RwTfSeHy7Ds_.jSHKLDbEWvSCkb.qU10RgKRUdgOZFL2tOjOEpUAVjzsVxWyuidNWi._
 Eg66oxsvEztM4B6LAC7jKXp2_vQvPtF9UjpH5NmKmwfJXuDMwMqZPF7FCql7Y9oChigwymWFp5FT
 AMI5S9eVVEmHAiuQvgBfUxbzMsBfOiCTl3cR8FU5LR581ksLhylMJ0G2gtr1wLPANyoWxSqGYHZo
 8PJRwrUzkEHbSmhJiJJxVbS0xhone2jwhtZaCksl_dRkbar1QjsrWtYVWsU3q.4B.BktUOeZauTd
 d9mm4fuTRmTH93GY8.kUi0LTwiyImSnmXaqWvq8osgVl0PeOyMrKI_646PRotHeRhgmuArIOnv_1
 sw4FfuZM6gGrhb6SpFoBR977sEq8pXy5.GwnclBKINzLT1uu37vYOTL9HypYIB3cZQC9lnVG7EAx
 QfPs8WWgldmrTz21ZTpQ06fFXpvIwIbNPM2nnphryVoqbXqfKm9LX9DE2yE02ByinBsdO2XMqIc4
 Oqr02ZQM74M6dA0N8RxAabPPN8ZidHU4TJ0LlwavO4hNloJ_REAyImtaFuZyqNHVkqX1sIvaLvB4
 SzlP1.ZV34OaterGu3hEcIA6rZLcX6dDIgOolbHSJEkSYTlIWOaazpbvW2bIGpL5BnRZiAuasyS.
 hgAkhprPDJGFnuVUToutkZRSG3PniWkbLSN3U4bXCCj8S9NClroyBpacmNEdEaTHDiwTABDGIeVd
 fFZ.b0UC1.dyJOVZS03w.9gNohuCTzAXPFRb0gGubWYKr5mX6.0CKy_Klk3IOMADPa4m76N6PzN.
 yawHaTnCfWpjRZmDNTN4kc6L6Brl6oJpuX9neunj8D9AtGXZ_EqS_7D_t7zS1IphZ_7EfnfSXmgh
 EmQfXHZw4v5xRyOSgoTyBS598oHj1JdZbHKhN2N9899BNdVlPwM84qbch.g2PUz_2hxcP4_1X.x6
 pXKotBCpR8jRRqO9qfzka5eZ0
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0151b712-c283-4737-8710-2e744a49dee7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2025 17:03:54 +0000
Received: by hermes--production-gq1-5dd4b47f46-n48bg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aa324dd32419f52d60922829ecd3f996;
          Thu, 20 Feb 2025 17:03:51 +0000 (UTC)
Message-ID: <91cc89cd-a9c0-4936-8449-1b9ac6273dfc@schaufler-ca.com>
Date: Thu, 20 Feb 2025 09:03:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netlabel: Remove unused cfg_calipso funcs
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: paul@paul-moore.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250220140808.71674-1-linux@treblig.org>
 <aa6c6f4c-7d46-4e7e-bafc-f042436f47b6@schaufler-ca.com>
 <Z7dcxAYj_jsG9WL6@gallifrey>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <Z7dcxAYj_jsG9WL6@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/20/2025 8:48 AM, Dr. David Alan Gilbert wrote:
> * Casey Schaufler (casey@schaufler-ca.com) wrote:
>> On 2/20/2025 6:08 AM, linux@treblig.org wrote:
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>>> netlbl_cfg_calipso_map_add(), netlbl_cfg_calipso_add() and
>>> netlbl_cfg_calipso_del() were added in 2016 as part of
>>> commit 3f09354ac84c ("netlabel: Implement CALIPSO config functions for
>>> SMACK.")
>>>
>>> Remove them.
>> Please don't. The Smack CALIPSO implementation has been delayed
>> for a number of reasons, some better than others, but is still on
>> the roadmap.
> Hmm OK.
> If it makes it to 10 years next year then perhaps it should hold
> a birthday party!

The difference between network and security developers is that a
network developer thinks 10 microseconds is a long time, while a
security developer thinks 10 years is no time at all.

>
> Dave
>
>>> (I see a few other changes in that original commit, whether they
>>> are reachable I'm not sure).
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>>> ---
>>>  include/net/netlabel.h       |  26 -------
>>>  net/netlabel/netlabel_kapi.c | 133 -----------------------------------
>>>  2 files changed, 159 deletions(-)
>>>
>>> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
>>> index 02914b1df38b..37c9bcfd5345 100644
>>> --- a/include/net/netlabel.h
>>> +++ b/include/net/netlabel.h
>>> @@ -435,14 +435,6 @@ int netlbl_cfg_cipsov4_map_add(u32 doi,
>>>  			       const struct in_addr *addr,
>>>  			       const struct in_addr *mask,
>>>  			       struct netlbl_audit *audit_info);
>>> -int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
>>> -			   struct netlbl_audit *audit_info);
>>> -void netlbl_cfg_calipso_del(u32 doi, struct netlbl_audit *audit_info);
>>> -int netlbl_cfg_calipso_map_add(u32 doi,
>>> -			       const char *domain,
>>> -			       const struct in6_addr *addr,
>>> -			       const struct in6_addr *mask,
>>> -			       struct netlbl_audit *audit_info);
>>>  /*
>>>   * LSM security attribute operations
>>>   */
>>> @@ -561,24 +553,6 @@ static inline int netlbl_cfg_cipsov4_map_add(u32 doi,
>>>  {
>>>  	return -ENOSYS;
>>>  }
>>> -static inline int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
>>> -					 struct netlbl_audit *audit_info)
>>> -{
>>> -	return -ENOSYS;
>>> -}
>>> -static inline void netlbl_cfg_calipso_del(u32 doi,
>>> -					  struct netlbl_audit *audit_info)
>>> -{
>>> -	return;
>>> -}
>>> -static inline int netlbl_cfg_calipso_map_add(u32 doi,
>>> -					     const char *domain,
>>> -					     const struct in6_addr *addr,
>>> -					     const struct in6_addr *mask,
>>> -					     struct netlbl_audit *audit_info)
>>> -{
>>> -	return -ENOSYS;
>>> -}
>>>  static inline int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap,
>>>  				     u32 offset)
>>>  {
>>> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
>>> index cd9160bbc919..13b4bc1c30ec 100644
>>> --- a/net/netlabel/netlabel_kapi.c
>>> +++ b/net/netlabel/netlabel_kapi.c
>>> @@ -394,139 +394,6 @@ int netlbl_cfg_cipsov4_map_add(u32 doi,
>>>  	return ret_val;
>>>  }
>>>  
>>> -/**
>>> - * netlbl_cfg_calipso_add - Add a new CALIPSO DOI definition
>>> - * @doi_def: CALIPSO DOI definition
>>> - * @audit_info: NetLabel audit information
>>> - *
>>> - * Description:
>>> - * Add a new CALIPSO DOI definition as defined by @doi_def.  Returns zero on
>>> - * success and negative values on failure.
>>> - *
>>> - */
>>> -int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
>>> -			   struct netlbl_audit *audit_info)
>>> -{
>>> -#if IS_ENABLED(CONFIG_IPV6)
>>> -	return calipso_doi_add(doi_def, audit_info);
>>> -#else /* IPv6 */
>>> -	return -ENOSYS;
>>> -#endif /* IPv6 */
>>> -}
>>> -
>>> -/**
>>> - * netlbl_cfg_calipso_del - Remove an existing CALIPSO DOI definition
>>> - * @doi: CALIPSO DOI
>>> - * @audit_info: NetLabel audit information
>>> - *
>>> - * Description:
>>> - * Remove an existing CALIPSO DOI definition matching @doi.  Returns zero on
>>> - * success and negative values on failure.
>>> - *
>>> - */
>>> -void netlbl_cfg_calipso_del(u32 doi, struct netlbl_audit *audit_info)
>>> -{
>>> -#if IS_ENABLED(CONFIG_IPV6)
>>> -	calipso_doi_remove(doi, audit_info);
>>> -#endif /* IPv6 */
>>> -}
>>> -
>>> -/**
>>> - * netlbl_cfg_calipso_map_add - Add a new CALIPSO DOI mapping
>>> - * @doi: the CALIPSO DOI
>>> - * @domain: the domain mapping to add
>>> - * @addr: IP address
>>> - * @mask: IP address mask
>>> - * @audit_info: NetLabel audit information
>>> - *
>>> - * Description:
>>> - * Add a new NetLabel/LSM domain mapping for the given CALIPSO DOI to the
>>> - * NetLabel subsystem.  A @domain value of NULL adds a new default domain
>>> - * mapping.  Returns zero on success, negative values on failure.
>>> - *
>>> - */
>>> -int netlbl_cfg_calipso_map_add(u32 doi,
>>> -			       const char *domain,
>>> -			       const struct in6_addr *addr,
>>> -			       const struct in6_addr *mask,
>>> -			       struct netlbl_audit *audit_info)
>>> -{
>>> -#if IS_ENABLED(CONFIG_IPV6)
>>> -	int ret_val = -ENOMEM;
>>> -	struct calipso_doi *doi_def;
>>> -	struct netlbl_dom_map *entry;
>>> -	struct netlbl_domaddr_map *addrmap = NULL;
>>> -	struct netlbl_domaddr6_map *addrinfo = NULL;
>>> -
>>> -	doi_def = calipso_doi_getdef(doi);
>>> -	if (doi_def == NULL)
>>> -		return -ENOENT;
>>> -
>>> -	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
>>> -	if (entry == NULL)
>>> -		goto out_entry;
>>> -	entry->family = AF_INET6;
>>> -	if (domain != NULL) {
>>> -		entry->domain = kstrdup(domain, GFP_ATOMIC);
>>> -		if (entry->domain == NULL)
>>> -			goto out_domain;
>>> -	}
>>> -
>>> -	if (addr == NULL && mask == NULL) {
>>> -		entry->def.calipso = doi_def;
>>> -		entry->def.type = NETLBL_NLTYPE_CALIPSO;
>>> -	} else if (addr != NULL && mask != NULL) {
>>> -		addrmap = kzalloc(sizeof(*addrmap), GFP_ATOMIC);
>>> -		if (addrmap == NULL)
>>> -			goto out_addrmap;
>>> -		INIT_LIST_HEAD(&addrmap->list4);
>>> -		INIT_LIST_HEAD(&addrmap->list6);
>>> -
>>> -		addrinfo = kzalloc(sizeof(*addrinfo), GFP_ATOMIC);
>>> -		if (addrinfo == NULL)
>>> -			goto out_addrinfo;
>>> -		addrinfo->def.calipso = doi_def;
>>> -		addrinfo->def.type = NETLBL_NLTYPE_CALIPSO;
>>> -		addrinfo->list.addr = *addr;
>>> -		addrinfo->list.addr.s6_addr32[0] &= mask->s6_addr32[0];
>>> -		addrinfo->list.addr.s6_addr32[1] &= mask->s6_addr32[1];
>>> -		addrinfo->list.addr.s6_addr32[2] &= mask->s6_addr32[2];
>>> -		addrinfo->list.addr.s6_addr32[3] &= mask->s6_addr32[3];
>>> -		addrinfo->list.mask = *mask;
>>> -		addrinfo->list.valid = 1;
>>> -		ret_val = netlbl_af6list_add(&addrinfo->list, &addrmap->list6);
>>> -		if (ret_val != 0)
>>> -			goto cfg_calipso_map_add_failure;
>>> -
>>> -		entry->def.addrsel = addrmap;
>>> -		entry->def.type = NETLBL_NLTYPE_ADDRSELECT;
>>> -	} else {
>>> -		ret_val = -EINVAL;
>>> -		goto out_addrmap;
>>> -	}
>>> -
>>> -	ret_val = netlbl_domhsh_add(entry, audit_info);
>>> -	if (ret_val != 0)
>>> -		goto cfg_calipso_map_add_failure;
>>> -
>>> -	return 0;
>>> -
>>> -cfg_calipso_map_add_failure:
>>> -	kfree(addrinfo);
>>> -out_addrinfo:
>>> -	kfree(addrmap);
>>> -out_addrmap:
>>> -	kfree(entry->domain);
>>> -out_domain:
>>> -	kfree(entry);
>>> -out_entry:
>>> -	calipso_doi_putdef(doi_def);
>>> -	return ret_val;
>>> -#else /* IPv6 */
>>> -	return -ENOSYS;
>>> -#endif /* IPv6 */
>>> -}
>>> -
>>>  /*
>>>   * Security Attribute Functions
>>>   */

