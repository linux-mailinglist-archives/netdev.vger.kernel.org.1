Return-Path: <netdev+bounces-55260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC89D80A03C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968BA28193F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BBD12B9D;
	Fri,  8 Dec 2023 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RmPpWLsy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F898171E
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:07:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1e35c2807fso251946066b.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 02:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702030052; x=1702634852; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iZl7f2rfOsZHUUiIEsZKN2+7ZylKMkFRiQYumejvaKw=;
        b=RmPpWLsyKEc19Ss/ZAu754w4MZXzFfMMgMrrZNbje0GJ9SVGYvQOPmWNenyQig0Kj5
         j+zGAmGxgVRfDVt76HQB5B+g0fxeZLzjfvCswbObdyERMmmzD3AXlG7s+KJ5c+Mf9wBM
         03vIWNxbmhlvguNyjYLyHea6bIBtbd1Ee+4/CirBon1gt6ZOAxRuuHW9KocgiByHwSd9
         8seIfl3/iYn4T2wqbVTSuBJyK1hMAV4o8bLyneAUd0k4oz/n6eDalnwUhmr7lUXuDJ/j
         +6J3//KvOZNcgzp4Qp4BW5DM7yBBoEWI+8AyYWAp9GH+wMJF3ZPWZ6eIbZSbqFfdxQkZ
         9uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030052; x=1702634852;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZl7f2rfOsZHUUiIEsZKN2+7ZylKMkFRiQYumejvaKw=;
        b=miJ/sTtEhmRVED262VrqoEOWRtOM1R1A91I5K6Xb4yrdwLc3Sv7us2SyJrzdv7GzMr
         kXd37abWBPRzNo5wU4z1wEveErYPApeER4pc1bC+vI0AKjC5CrqW8vkwu1AmjzrIq/Tv
         cKpkQ18Tf3qyuYnGm3nwE2swevuBxIRRIWZdE48x62qgAK/nS8WjEGU8zZnQBhUVd5NG
         nKL9X2DvxHIQGxtv+2rorw8vd87OSQmesbn1T7HOCdLHdV8BS50zRRPNrA5w6/r+irlW
         FYiGDoYxCFySxrxmBbsGJOoTmnX/FXvKPhimMt/lRcY2yp8WJOR4BoB6MlbjsjbIYD+d
         qr7w==
X-Gm-Message-State: AOJu0YxplRkzLJh9/lHocenBqvgkuE1Irl/nvye8Vh1hBsln/B2U94yz
	Fk97A9JMRc+wgJhigDXVC/tKTA==
X-Google-Smtp-Source: AGHT+IFWbMrMJfdCOJ3DIeDMVWePWarYyJhDjMCQ3VOMRkL5z1bZzVyqanj8Qii7zB5MYf9sxpLOcA==
X-Received: by 2002:a17:907:9554:b0:a1c:a906:3ad4 with SMTP id ex20-20020a170907955400b00a1ca9063ad4mr2013542ejc.70.1702030051553;
        Fri, 08 Dec 2023 02:07:31 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b00a1d754b30a9sm800832ejc.86.2023.12.08.02.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:07:31 -0800 (PST)
Date: Fri, 8 Dec 2023 11:07:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v5 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <ZXLq4Ttq7dEZpLIP@nanopsycho>
References: <20231206182120.957225-1-jiri@resnulli.us>
 <20231206182120.957225-6-jiri@resnulli.us>
 <20231207185526.5e59ab53@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207185526.5e59ab53@kernel.org>

Fri, Dec 08, 2023 at 03:55:26AM CET, kuba@kernel.org wrote:
>On Wed,  6 Dec 2023 19:21:16 +0100 Jiri Pirko wrote:
>> diff --git a/include/net/genetlink.h b/include/net/genetlink.h
>> index e18a4c0d69ee..dbf11464e96a 100644
>> --- a/include/net/genetlink.h
>> +++ b/include/net/genetlink.h
>> @@ -87,6 +87,9 @@ struct genl_family {
>>  	int			id;
>>  	/* starting number of multicast group IDs in this family */
>>  	unsigned int		mcgrp_offset;
>> +	size_t			sock_priv_size;
>> +	void			(*sock_priv_init)(void *priv);
>> +	void			(*sock_priv_destroy)(void *priv);
>
>👍️
>
>but I think it should be above the private fields (and have kdoc)
>The families are expected to make use the new fields, and are not
>supposed to touch anything private.

Oh, right, good point, I missed that.


>
>> --- a/net/netlink/af_netlink.h
>> +++ b/net/netlink/af_netlink.h
>> @@ -60,6 +60,21 @@ static inline struct netlink_sock *nlk_sk(struct sock *sk)
>>  
>>  #define nlk_test_bit(nr, sk) test_bit(NETLINK_F_##nr, &nlk_sk(sk)->flags)
>>  
>> +struct genl_sock {
>> +	struct netlink_sock nlk_sk;
>> +	struct xarray *family_privs;
>> +};
>> +
>> +static inline struct genl_sock *genl_sk(struct sock *sk)
>> +{
>> +	return container_of(nlk_sk(sk), struct genl_sock, nlk_sk);
>> +}
>> +
>> +/* Size of netlink sock is size of the biggest user with priv,
>> + * which is currently just Generic Netlink.
>> + */
>> +#define NETLINK_SOCK_SIZE sizeof(struct genl_sock)
>
>Would feel a little cleaner to me to add
>
>#define NETLINK_SOCK_PROTO_SIZE		8
>
>add that to the size, build time check that struct genl_sock's
>size is <= than sizeof(struct netlink_sock) + NETLINK_SOCK_PROTO_SIZE
>
>This way we don't have to fumble the layering by putting genl stuff
>in af_netlink.h

Yeah, I had it like that originally, I didn't like it :) Mainly because
if someone adds-in another field in the future, the build time check
may only fail on some archs. Also, wasting memory on archs there pointer
is 4 bytes :) But as you wish, I don't mind to switch it back.


>
>> +struct genl_sk_priv {
>> +	void (*destructor)(void *priv);
>> +	long priv[];
>> +};
>> +
>> +static struct genl_sk_priv *genl_sk_priv_alloc(struct genl_family *family)
>> +{
>> +	struct genl_sk_priv *priv;
>> +
>> +	priv = kzalloc(size_add(sizeof(*priv), family->sock_priv_size),
>> +		       GFP_KERNEL);
>> +	if (!priv)
>> +		return ERR_PTR(-ENOMEM);
>> +	priv->destructor = family->sock_priv_destroy;
>
>family->sock_priv_destroy may be in module memory.
>I think you need to wipe them when family goes :(
>
>> +	if (family->sock_priv_init)
>> +		family->sock_priv_init(priv->priv);
>> +	return priv;
>> +}
>
>> +static struct xarray *genl_family_privs_get(struct genl_sock *gsk)
>> +{
>> +	struct xarray *family_privs;
>> +
>> +again:
>> +	family_privs = READ_ONCE(gsk->family_privs);
>> +	if (family_privs)
>> +		return family_privs;
>> +
>> +	family_privs = kzalloc(sizeof(*family_privs), GFP_KERNEL);
>> +	if (!family_privs)
>> +		return ERR_PTR(-ENOMEM);
>> +	xa_init_flags(family_privs, XA_FLAGS_ALLOC);
>> +
>> +	/* Use genl lock to protect family_privs to be
>> +	 * initialized in parallel by different CPU.
>> +	 */
>> +	genl_lock();
>> +	if (unlikely(gsk->family_privs)) {
>> +		xa_destroy(family_privs);
>> +		kfree(family_privs);
>> +		genl_unlock();
>
>nit: unlock can be moved up

Okay.


>
>> +		goto again;
>
>why not return READ_ONCE(gsk->family_privs); ?
>there's no need to loop

Right.

>
>One could also be tempted to:
>
>lock()
>if (likely(!gsk->family_privs)) {
>	WRITE
>} else {
>	destory()
>	free()
>	family_privs = READ
>}
>unlock()
>
>but it could be argued success path should be flat

Okay, I will think about it.



Thanks!


>
>> +	}
>> +	WRITE_ONCE(gsk->family_privs, family_privs);
>> +	genl_unlock();
>> +	return family_privs;
>> +}

