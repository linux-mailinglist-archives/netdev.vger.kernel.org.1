Return-Path: <netdev+bounces-168179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1BA3DEBA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C321188B935
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D21DE4CE;
	Thu, 20 Feb 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fgXna+CL"
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162F1B4243
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065721; cv=none; b=PGiWAiCikSnFPCRhR6IYt6gfwTmS0TR7iPhLzgTFXMIxFt/aqhHdNn+eZiylu0W05XFWuX7lGD4FDBOYwRWgkH6/lf5bflMaPJAgcVhAzKVMqaLm2MgfR+Nbu3Tfuz8eTkyqXDE/LcvwrAsFod0MlpfLBgBqxVQfgDNPeDyzsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065721; c=relaxed/simple;
	bh=/H4DXco9xQ4lb8Te7gL+UVyO3rUpq5eC8ie7csVvN1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RApx+dnOngnyuTxmE0JT7BH/+T0yW+rnoVeDwd05v1SzhKp9xE8p0bJWeFlosOuxPWxKch/T7bD3HwhrM02nle50Iq7W/UjgW8mUunOmwjQ9KiVrhN2tqIV9fG8L73lR9VZ+dM2mFf8G++uWeeQKW/5KL6hjjKpb8JtEjtOBBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fgXna+CL; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740065712; bh=ekpCCgF7cpjJGlBUQltrcyy0xqFyiNUqJbBZlZihjSI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fgXna+CLybjpJAx9FsolIuR+PElHUjcl4tFgx1tKlI256L8yobcK8LG9F2gI6WN19uDFb6G9Gih8CB6L25vp6Qjct4RTlH2h6nAL6EElANyGjTOtgsmVUUAHKmpH4LFH1ktOmJlYo+xha+liq2kARdAwnzIpC8lo3uOIyLkvd+nje9pK4txC87+NnQ4IGOhwSN/TxrHRcqW4aKf3yepchB6DgnmkW+ZN1SnsoZEwfocptci2DlqbPJgse4eYHvy9zFfwodIlM6ivp1RHHvF5lkOjqiJmGDl+4oIHfdGyCDTbSwAHHHGT1QtrI3RiOzuQ2eUwmKPj/asfxlnIQwxp0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740065712; bh=OrEylGmR1ETH8N6i90c1TSJOV4hynJD8EL2e41dP/XW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SVIwCSPWRlgYCRyoKdWvtAKpiRh9Q38pUsMVm86aEP3P+fPu6/MB9mYJNx/7e4xMj6m5vN3t3XN3mhdFNc9LNaAf+zJiFA964cVzlGf3apIJD+a+Ko8M1+EeEVSMMYsLUA2T4oNrmMyNeM0e0xeHLk6BrznfgKMUi/pPYDsBUUy5x2HvB3ygRsOWXESB/i4kgQiuxAcALx7XjFI3qtGkvAVlXoGBW1iUYZxIjUOD0SF292U0QS+CKX5npoR4/KZZzw1+QbmZx+HnpgN1dvq6wwzko18ygqiO09mQ2nX378qSRpSRgGNAcVngroiQmZgU1vlFROzj6Gklmg/8Yu6hKA==
X-YMail-OSG: uhcwZIIVM1mxwp8UkThAc3Y_VLM2.oFWnsxyHKoXoYvolYx5TF2GnzWKyvPFV1c
 GkY0HhwkYuzhq0TkMgx6Z1yujoaxTKg8vIq4ycJ.eOXwuM7WILK.KsvpRkXd2BfJJKa8SOfrxEa7
 RI6.C5hE9fnk0W22W8YbrCOqW0voEBQLs5aBZsGcZyoS0XtT3SnUMvico3Yrh.Sog39YlZW1MX1Q
 P4ufYb0rwfYaFSiE9kvE0FKQhLchba1dTh6gRy_2zLxXdr5qn4FMqqjIOTH1zk8MD66_ZJfkntQb
 YDvkL2aJBWNLEmBRdUdJAI6.a3Qnh4jdCWFI.H.nI9PPlU5B80FJMvAsHYk5M8zSqsIC7Xj1LIxj
 C7H1AlRRHmKJAa9RrMST9wH3YPWe0Ooixy9esJq_LTiHTuY2PpE2fObuSRiroo203ZyKWNdNDNjX
 SGc5Vr3oDTAZdWzwqx5G3SWKsZ8bKhX1ls1j.7Te.vp2iHomJcU2XZ2WP6VIQmovxKL9nE6RYg7H
 .c_kVqaLBhvoJxXQY7.ZlfRdsHeJMNAdI.RE_vQOP46CAMggWdxu1xm8Pw_H0EZhvK.FUJZyd7Pr
 6OlK8zTmyFao8QHOl5gl20fbpddW2Pste2mIJxF60ivyLbNx7fDbTrDnGJCEsnT5nPlgg3AqOLiJ
 jbc5n2.D1lo_lX27YiX2fnvhJS7_ZInz7vMo3ggt8PXEYqVC.De2IjDy34A6OwKcP5uzOKXfxrN7
 eA6uunD9HSI1fxH0NF88B8RnAqwqvCFO1ERy17eoayByLfEEQbvULcH8byeICmCRXke1U7m_._nV
 1V6zqygXIPfCncee3ULnm6SkhL7Hvq5iSU5p3xOPTMReG8BRPjXC0uNKQqeDgP_2Z5BxLuqvGtIE
 YGGioUKUuCNJ9zq9TZ1robKcQ1YUBJZiHJUBzATkJ2OoahsB35sTkYIocccwxWp8Sf1_2k24cKAI
 nf7vlh8XjE7Qxi_uMPL1ksNa_CKTl1Ay4sijs4fLfi8w3J6Cj4vVwt3ZJZHlT_w2qHp1DR.dyhUl
 ep5NByEYDUkwMrpHjvJ7wCieT3Hndm_aLOhGYyh6Pi1Q5knNICsVvseZRh152YFYR127UbVsp7QU
 pS15xzAYWyvTQewnBQAYcDtH0uTL5Ln6KHqi4dN1_Lb73VliJ5yll.K8B.0ptwSjTevrbHizCI5s
 gEZgn50WpaVjoRoxdfzLVX3pUZiTBUMn_PhdNJHz4zhSX6aLRs67.u2jkXpZ3v390fu3iw6X2J74
 rUsWqHk75aW2c1CObBsR_iIDFJvOTqfbIIaaBcw7wKTmWeD5kDIwR8M.5wufAoGM7FO2C4sb70jF
 JksxM58lVhAusUZs9qnJUoJI5RqWhj9cFMsHeqp3vdOXPRGfluyE0dgiThTn6aClq8ZN9jZCJ7bj
 uJDIkW0YeYM31RKVtVVBQqQNI8uJWEqsEs0XYv2km2OLX8WNHthneKwGFVR4hQLL.qrcJc_Z3zbr
 h7Cs4hOdPVlbfIikVBnp9wXooJEP06._6MsXuKILwiCfnETHrzK4iGkP5T9c_dxvcYPGnOt6Qvgx
 _CaOTbplhgiY.xVO5NcvR4638VrccisI.JzQHikKkBmNdckFdqpM3rWKn2dIOfc9hOqelaHy5zAt
 UeQuzN.nYJVfRs2Sj1ub9VJIdMMR9Byxzk8KZqahBYFlSS84qAn4MiC0iKUb8EVmXJrfV7hNvEX5
 zU4r5tSgQC4SgoA1mh3WNsfSp_i1LKR2RvBeOzUIAU7NeSnooF_IRbsJYv1O4uLTXgCEfz9mrLQy
 3k7uys6W3EUsAKzYdlfia3LNxb57ahiiypl1j93jfsvK9oX2cOjT7BMcvI8Y__DlEtoht9e98LHM
 _YzLfc09n0rSvAID9XE.BBerikZ5tc00TWi5mMAxpq09jquKRJnaE68JKcF2MykhTPN14XqYfJ41
 rGsopxFdB.UdQvOz2U7qyK44h6K6McCkTuJqlvISs8l1MSlPPP4ATyQDEGeUj6EhV_pjAJ01XNti
 ciE8nAHw_NtEhAIfTkgLA90AfFmroTyYWajSCdYWUBJF4jvRVGyGz6UC26YI.GNCDLqSoK9qPc1X
 sXsxqX7wRAVmqWBix.xenntcNTJ9eco_k2k2CoVY25UKHYOvy9HD6tDiZX8KCuHjX3bpWvNX.Nd2
 MxcmP_tVdCnfrto6g11KA1AHqPmcrv8tH3N8J8pFQ7Kvpnk7NzOc5sPWGsvwETaoeLyLdB5dVhHk
 da7IS0maIqYILjx9OmwaPKfbNJTT.nZ0mKmj3fbMM5nwiHsZmIAAgLpza6fxUSMLXMBet8NHwxLQ
 W1x9uFilC4o7Hn4hfJso-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5074b6c1-d1d0-467f-804a-4d6abf8211b1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Feb 2025 15:35:12 +0000
Received: by hermes--production-gq1-5dd4b47f46-dvwsq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 437aa463eb35749faded69ee77004126;
          Thu, 20 Feb 2025 15:35:09 +0000 (UTC)
Message-ID: <aa6c6f4c-7d46-4e7e-bafc-f042436f47b6@schaufler-ca.com>
Date: Thu, 20 Feb 2025 07:35:07 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netlabel: Remove unused cfg_calipso funcs
To: linux@treblig.org, paul@paul-moore.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250220140808.71674-1-linux@treblig.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250220140808.71674-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/20/2025 6:08 AM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> netlbl_cfg_calipso_map_add(), netlbl_cfg_calipso_add() and
> netlbl_cfg_calipso_del() were added in 2016 as part of
> commit 3f09354ac84c ("netlabel: Implement CALIPSO config functions for
> SMACK.")
>
> Remove them.

Please don't. The Smack CALIPSO implementation has been delayed
for a number of reasons, some better than others, but is still on
the roadmap.

>
> (I see a few other changes in that original commit, whether they
> are reachable I'm not sure).
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  include/net/netlabel.h       |  26 -------
>  net/netlabel/netlabel_kapi.c | 133 -----------------------------------
>  2 files changed, 159 deletions(-)
>
> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index 02914b1df38b..37c9bcfd5345 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -435,14 +435,6 @@ int netlbl_cfg_cipsov4_map_add(u32 doi,
>  			       const struct in_addr *addr,
>  			       const struct in_addr *mask,
>  			       struct netlbl_audit *audit_info);
> -int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
> -			   struct netlbl_audit *audit_info);
> -void netlbl_cfg_calipso_del(u32 doi, struct netlbl_audit *audit_info);
> -int netlbl_cfg_calipso_map_add(u32 doi,
> -			       const char *domain,
> -			       const struct in6_addr *addr,
> -			       const struct in6_addr *mask,
> -			       struct netlbl_audit *audit_info);
>  /*
>   * LSM security attribute operations
>   */
> @@ -561,24 +553,6 @@ static inline int netlbl_cfg_cipsov4_map_add(u32 doi,
>  {
>  	return -ENOSYS;
>  }
> -static inline int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
> -					 struct netlbl_audit *audit_info)
> -{
> -	return -ENOSYS;
> -}
> -static inline void netlbl_cfg_calipso_del(u32 doi,
> -					  struct netlbl_audit *audit_info)
> -{
> -	return;
> -}
> -static inline int netlbl_cfg_calipso_map_add(u32 doi,
> -					     const char *domain,
> -					     const struct in6_addr *addr,
> -					     const struct in6_addr *mask,
> -					     struct netlbl_audit *audit_info)
> -{
> -	return -ENOSYS;
> -}
>  static inline int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap,
>  				     u32 offset)
>  {
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index cd9160bbc919..13b4bc1c30ec 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -394,139 +394,6 @@ int netlbl_cfg_cipsov4_map_add(u32 doi,
>  	return ret_val;
>  }
>  
> -/**
> - * netlbl_cfg_calipso_add - Add a new CALIPSO DOI definition
> - * @doi_def: CALIPSO DOI definition
> - * @audit_info: NetLabel audit information
> - *
> - * Description:
> - * Add a new CALIPSO DOI definition as defined by @doi_def.  Returns zero on
> - * success and negative values on failure.
> - *
> - */
> -int netlbl_cfg_calipso_add(struct calipso_doi *doi_def,
> -			   struct netlbl_audit *audit_info)
> -{
> -#if IS_ENABLED(CONFIG_IPV6)
> -	return calipso_doi_add(doi_def, audit_info);
> -#else /* IPv6 */
> -	return -ENOSYS;
> -#endif /* IPv6 */
> -}
> -
> -/**
> - * netlbl_cfg_calipso_del - Remove an existing CALIPSO DOI definition
> - * @doi: CALIPSO DOI
> - * @audit_info: NetLabel audit information
> - *
> - * Description:
> - * Remove an existing CALIPSO DOI definition matching @doi.  Returns zero on
> - * success and negative values on failure.
> - *
> - */
> -void netlbl_cfg_calipso_del(u32 doi, struct netlbl_audit *audit_info)
> -{
> -#if IS_ENABLED(CONFIG_IPV6)
> -	calipso_doi_remove(doi, audit_info);
> -#endif /* IPv6 */
> -}
> -
> -/**
> - * netlbl_cfg_calipso_map_add - Add a new CALIPSO DOI mapping
> - * @doi: the CALIPSO DOI
> - * @domain: the domain mapping to add
> - * @addr: IP address
> - * @mask: IP address mask
> - * @audit_info: NetLabel audit information
> - *
> - * Description:
> - * Add a new NetLabel/LSM domain mapping for the given CALIPSO DOI to the
> - * NetLabel subsystem.  A @domain value of NULL adds a new default domain
> - * mapping.  Returns zero on success, negative values on failure.
> - *
> - */
> -int netlbl_cfg_calipso_map_add(u32 doi,
> -			       const char *domain,
> -			       const struct in6_addr *addr,
> -			       const struct in6_addr *mask,
> -			       struct netlbl_audit *audit_info)
> -{
> -#if IS_ENABLED(CONFIG_IPV6)
> -	int ret_val = -ENOMEM;
> -	struct calipso_doi *doi_def;
> -	struct netlbl_dom_map *entry;
> -	struct netlbl_domaddr_map *addrmap = NULL;
> -	struct netlbl_domaddr6_map *addrinfo = NULL;
> -
> -	doi_def = calipso_doi_getdef(doi);
> -	if (doi_def == NULL)
> -		return -ENOENT;
> -
> -	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
> -	if (entry == NULL)
> -		goto out_entry;
> -	entry->family = AF_INET6;
> -	if (domain != NULL) {
> -		entry->domain = kstrdup(domain, GFP_ATOMIC);
> -		if (entry->domain == NULL)
> -			goto out_domain;
> -	}
> -
> -	if (addr == NULL && mask == NULL) {
> -		entry->def.calipso = doi_def;
> -		entry->def.type = NETLBL_NLTYPE_CALIPSO;
> -	} else if (addr != NULL && mask != NULL) {
> -		addrmap = kzalloc(sizeof(*addrmap), GFP_ATOMIC);
> -		if (addrmap == NULL)
> -			goto out_addrmap;
> -		INIT_LIST_HEAD(&addrmap->list4);
> -		INIT_LIST_HEAD(&addrmap->list6);
> -
> -		addrinfo = kzalloc(sizeof(*addrinfo), GFP_ATOMIC);
> -		if (addrinfo == NULL)
> -			goto out_addrinfo;
> -		addrinfo->def.calipso = doi_def;
> -		addrinfo->def.type = NETLBL_NLTYPE_CALIPSO;
> -		addrinfo->list.addr = *addr;
> -		addrinfo->list.addr.s6_addr32[0] &= mask->s6_addr32[0];
> -		addrinfo->list.addr.s6_addr32[1] &= mask->s6_addr32[1];
> -		addrinfo->list.addr.s6_addr32[2] &= mask->s6_addr32[2];
> -		addrinfo->list.addr.s6_addr32[3] &= mask->s6_addr32[3];
> -		addrinfo->list.mask = *mask;
> -		addrinfo->list.valid = 1;
> -		ret_val = netlbl_af6list_add(&addrinfo->list, &addrmap->list6);
> -		if (ret_val != 0)
> -			goto cfg_calipso_map_add_failure;
> -
> -		entry->def.addrsel = addrmap;
> -		entry->def.type = NETLBL_NLTYPE_ADDRSELECT;
> -	} else {
> -		ret_val = -EINVAL;
> -		goto out_addrmap;
> -	}
> -
> -	ret_val = netlbl_domhsh_add(entry, audit_info);
> -	if (ret_val != 0)
> -		goto cfg_calipso_map_add_failure;
> -
> -	return 0;
> -
> -cfg_calipso_map_add_failure:
> -	kfree(addrinfo);
> -out_addrinfo:
> -	kfree(addrmap);
> -out_addrmap:
> -	kfree(entry->domain);
> -out_domain:
> -	kfree(entry);
> -out_entry:
> -	calipso_doi_putdef(doi_def);
> -	return ret_val;
> -#else /* IPv6 */
> -	return -ENOSYS;
> -#endif /* IPv6 */
> -}
> -
>  /*
>   * Security Attribute Functions
>   */

