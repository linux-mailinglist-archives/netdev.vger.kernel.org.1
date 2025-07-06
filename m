Return-Path: <netdev+bounces-204436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BC5AFA6A0
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 18:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E893A9850
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2345288C19;
	Sun,  6 Jul 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hahjXCXg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B5288C14
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751821001; cv=none; b=TR1nG8lXgHpicQzaRBaa+cr0Z1KizE3LsDFxUvKd0UNQcRBK9QmhfdkTHT1LMDcsnjZ9vUpnDHW6c3Fcut9fKIp/6GFQmXbO/mkU5ADwmVGv/kB/OrFXGAyz9f+BmXjdHXT7n3CMxa+NmIQLnvx6OiEBLgAL/QnrjFnJhroqCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751821001; c=relaxed/simple;
	bh=Q2JCHqF5lvgF5CfT3KK8uT9ULMMei6hwpvViQFIy0nk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=N+PBJIbpx1aDyshofc9ggL5ignwvCb4fDO0YmumB73MkcftipcZKeVOeqeBJ22toII6T0bkNo2Y8w+BO6+G2wSLRBMB9H7ZcIpJrLRdcfMHvWu8fRW+f24vtaiLJaCTvuK56RXA2YIhzurxeEqd+3HZo6tHITi+RKncBNPI/oWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hahjXCXg; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e897c8ca777so2166954276.2
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751820999; x=1752425799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak2U/LrlaxhDeP55UD2xP1Xe0RzSTp0vPmRGbvfU6Js=;
        b=hahjXCXgxV7orUDCdmUQ5UAzWZHpUirnOWqmqyz2ewvBi8QuZEraDLSlNozWQFVT1S
         RrI/hVsxMkKsjV5094Z02e2N62fizYbVeGUpXJgJDqzXd6Jhffrzvg/ydLJuSbWePtH1
         GQMjkdQctTXQ/nEanWEdV+39ocv8arWyTndaBeYXM237/HvkFZW4SlofHba0Gt7g+HV6
         bXsDOzdL41DzAsR7cvSL+NzPvWAUYARyFV2J0ERm/VdQ+NT2t10oDoJldEvtKM8rD7Gt
         QzMp3Tw8UgoVB+sj/jwTW4sdK9WFTuP05/M/34xt54mIGeTs0Xyh8ga9kROo/GF3kIYM
         zM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751820999; x=1752425799;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ak2U/LrlaxhDeP55UD2xP1Xe0RzSTp0vPmRGbvfU6Js=;
        b=vBY+fYUy+josxQulz61pxeRlnbfOFk9H2ieakiO71ynCkC6vxPblh4uEv4ecrJvv//
         1qZvhUjjK24Q64U53OAd12ziQQ0z9PszNxi0XPUQqcPse7IMxEsCrfCiOIsyChfUmL+d
         sWmMB6jy9VIHRwKtJtE/Ub0RpIe2tA9Woj3aqqx+dQPv5f8JvCCRNyq39YeQ10AhXtTt
         CKpFcHRZwwr4ZPsuL17t4hLjVL0LafiCn5tL7cd2Ki+hLvkJWSaVfCddStzeDyC6GYt1
         wb4IXUs5KFxGnWCHjo6arAryXIzY2eCTbTga+psMwT761ZolrG2Jubb0ZF8v66DdvOvp
         CvTw==
X-Forwarded-Encrypted: i=1; AJvYcCV2M9E0yJtZAmwwktfARMsd8xgRlbhaVLXDAy8Vft16VcnOR6nLKyhjgzhEBdYUJqAgKBAxy3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADsvv1ijOOsQVpkKal02mfKrFMSbqq3JQ8kUIIFu3hugU+i86
	B5tuvKLurhygjpsfBQcf45tOTF+E8ROSZ0NSiCFKFqvWOTKnSA+93XzG
X-Gm-Gg: ASbGncuylp9G/Ubq6m+1UUfDBcnf41T8lQLzNocha66HmlChZ+rfO1UEeg3asB2bjV5
	NiwQm2n37m1Md6tGenpKHOAKsmV7OCI27/blCFiE3NnqAOHc4FHRWLFUbPHhhzkDr1rsGojMjJ2
	hk2c11+PkhZ8hrhMZQUwC9OFhIL9qRYc+YP7YPBgpN0mDjy6NKuBLzj5a7YJGmp/DeoT0qNKzTs
	ZWJUzGec4tTnCLd93DuAHBMJ94phr2XDqynWahUE/ZxfCCgoM9ubad3iHomx6qJV6EUQM3osHRm
	Pr5TJAJFbQ0xMSSg48/klf8cjGCIASeAy0X2sdEMZYL/uUVwyfCp8FqgMn9ZYEIhIbrgmvVLVWX
	k/qxwE/svB+HsQ5K7IXm3/6UT2pGdZcqaL92SJmWJGleyEov2aQ==
X-Google-Smtp-Source: AGHT+IGjRLinT9AZ6GFioj1gN2sb8t2n8lqHHSr/qaihL82FSJuBg65+reZyI9e9HAZIh2EXlojIuw==
X-Received: by 2002:a05:690c:6910:b0:710:f1a9:1ba0 with SMTP id 00721157ae682-7176c9e5611mr74287237b3.3.1751820998937;
        Sun, 06 Jul 2025 09:56:38 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71665b12006sm12614027b3.87.2025.07.06.09.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 09:56:38 -0700 (PDT)
Date: Sun, 06 Jul 2025 12:56:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <686aaac58f744_3ad0f32943d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-11-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-11-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 10/19] psp: track generations of device key
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> There is a (somewhat theoretical in absence of multi-host support)
> possibility that another entity will rotate the key and we won't
> know. This may lead to accepting packets with matching SPI but
> which used different crypto keys than we expected. 

The device would not have decrypted those? As it only has two keys,
one for each MSB of the SPI.

Except for a narrow window during rotation, where a key for generation
N is decrypted and queued to the host, then a rotation happens, so that
the host updates its valid keys to { N+1, N+2 }. These will now get
dropped. That is not strictly necessary.

> Maintain and
> compare "key generation" per PSP spec.

Where does the spec state this?

I know this generation bit is present in the Google PSP
implementation, I'm just right now drawing a blank as to its exact
purpose -- and whether the above explanation matches that.

> Since we're tracking "key generations" more explicitly now,
> maintain different lists for associations from different generations.
> This way we can catch stale associations (the user space should
> listen to rotation notifications and change the keys).
> 
> Drivers can "opt out" of generation tracking by setting
> the generation value to 0.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
> 
> Notes:
>     v1:
>     - https://lore.kernel.org/netdev/20240510030435.120935-9-kuba@kernel.org/
> 
>  include/net/psp/types.h | 10 ++++++++++
>  net/psp/psp.h           |  1 +
>  net/psp/psp_main.c      |  6 +++++-
>  net/psp/psp_nl.c        | 10 ++++++++++
>  net/psp/psp_sock.c      | 16 ++++++++++++++++
>  5 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/psp/types.h b/include/net/psp/types.h
> index 5b0c2474a042..383a1afab46d 100644
> --- a/include/net/psp/types.h
> +++ b/include/net/psp/types.h
> @@ -50,8 +50,12 @@ struct psp_dev_config {
>   * @lock:	instance lock, protects all fields
>   * @refcnt:	reference count for the instance
>   * @id:		instance id
> + * @generation:	current generation of the device key
>   * @config:	current device configuration
>   * @active_assocs:	list of registered associations
> + * @prev_assocs:	associations which use old (but still usable)
> + *			device key
> + * @stale_assocs:	associations which use a rotated out key
>   *
>   * @rcu:	RCU head for freeing the structure
>   */
> @@ -67,13 +71,19 @@ struct psp_dev {
>  
>  	u32 id;
>  
> +	u8 generation;
> +
>  	struct psp_dev_config config;
>  
>  	struct list_head active_assocs;
> +	struct list_head prev_assocs;
> +	struct list_head stale_assocs;
>  
>  	struct rcu_head rcu;
>  };
>  
> +#define PSP_GEN_VALID_MASK	0x7f
> +
>  /**
>   * struct psp_dev_caps - PSP device capabilities
>   */
> diff --git a/net/psp/psp.h b/net/psp/psp.h
> index b4092936bc64..a511ec85e1c7 100644
> --- a/net/psp/psp.h
> +++ b/net/psp/psp.h
> @@ -27,6 +27,7 @@ int psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
>  int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
>  			  u32 version, struct psp_key_parsed *key,
>  			  struct netlink_ext_ack *extack);
> +void psp_assocs_key_rotated(struct psp_dev *psd);
>  
>  static inline void psp_dev_get(struct psp_dev *psd)
>  {
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index bf1c704a1a40..99facb158abb 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -72,6 +72,8 @@ psp_dev_create(struct net_device *netdev,
>  
>  	mutex_init(&psd->lock);
>  	INIT_LIST_HEAD(&psd->active_assocs);
> +	INIT_LIST_HEAD(&psd->prev_assocs);
> +	INIT_LIST_HEAD(&psd->stale_assocs);
>  	refcount_set(&psd->refcnt, 1);
>  
>  	mutex_lock(&psp_devs_lock);
> @@ -120,7 +122,9 @@ void psp_dev_unregister(struct psp_dev *psd)
>  	xa_store(&psp_devs, psd->id, NULL, GFP_KERNEL);
>  	mutex_unlock(&psp_devs_lock);
>  
> -	list_for_each_entry_safe(pas, next, &psd->active_assocs, assocs_list)
> +	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
> +	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
> +	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list)
>  		psp_dev_tx_key_del(psd, pas);
>  
>  	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
> diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> index 58508e642185..7b8a1d390cde 100644
> --- a/net/psp/psp_nl.c
> +++ b/net/psp/psp_nl.c
> @@ -230,6 +230,7 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
>  	struct psp_dev *psd = info->user_ptr[0];
>  	struct genl_info ntf_info;
>  	struct sk_buff *ntf, *rsp;
> +	u8 prev_gen;
>  	int err;
>  
>  	rsp = psp_nl_reply_new(info);
> @@ -249,10 +250,19 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto err_free_ntf;
>  	}
>  
> +	/* suggest the next gen number, driver can override */
> +	prev_gen = psd->generation;
> +	psd->generation = (prev_gen + 1) & PSP_GEN_VALID_MASK;
> +
>  	err = psd->ops->key_rotate(psd, info->extack);
>  	if (err)
>  		goto err_free_ntf;
>  
> +	WARN_ON_ONCE((psd->generation && psd->generation == prev_gen) ||
> +		     psd->generation & ~PSP_GEN_VALID_MASK);
> +
> +	psp_assocs_key_rotated(psd);
> +
>  	nlmsg_end(ntf, (struct nlmsghdr *)ntf->data);
>  	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
>  				0, PSP_NLGRP_USE, GFP_KERNEL);
> diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
> index f97441935d12..8b5cb31c2836 100644
> --- a/net/psp/psp_sock.c
> +++ b/net/psp/psp_sock.c
> @@ -60,6 +60,7 @@ struct psp_assoc *psp_assoc_create(struct psp_dev *psd)
>  
>  	pas->psd = psd;
>  	pas->dev_id = psd->id;
> +	pas->generation = psd->generation;
>  	psp_dev_get(psd);
>  	refcount_set(&pas->refcnt, 1);
>  
> @@ -243,6 +244,21 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
>  	return err;
>  }
>  
> +void psp_assocs_key_rotated(struct psp_dev *psd)
> +{
> +	struct psp_assoc *pas, *next;
> +
> +	/* Mark the stale associations as invalid, they will no longer
> +	 * be able to Rx any traffic.
> +	 */
> +	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list)
> +		pas->generation |= ~PSP_GEN_VALID_MASK;
> +	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
> +	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
> +
> +	/* TODO: we should inform the sockets that got shut down */
> +}
> +
>  void psp_twsk_init(struct inet_timewait_sock *tw, struct sock *sk)
>  {
>  	struct psp_assoc *pas = psp_sk_assoc(sk);
> -- 
> 2.47.1
> 



