Return-Path: <netdev+bounces-204427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78469AFA62F
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 17:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0855189D350
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AC114A09C;
	Sun,  6 Jul 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoDTZB3n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136DFA932
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751815921; cv=none; b=CN3XY5FnqM3yY0s2w2tHAyFdXeLgkygGAiCaO9c6TkJAWIJOgnSy+1dGX0MzkHR4xwGnPIhMsOU3fMSlewI2kmV3RzEqvK89oLeFkKOBEfdI/D8lImWBufTiddsztjig5psREdEO4Gz5ABHESdgYkCxQduiRFVkmsvFwYDAY1BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751815921; c=relaxed/simple;
	bh=YTWDZypuaIMvIwee5xdkd2s6Ic1k6hUs1KI4xIE+dT8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ndjAHxEDkI4O24PEn/jhBHWa+cYbCMspNW8bTuN9wihqW7EyU7+1e7iReGs0gMCxclB/2vwH8HpvUpH7bcab9h3vcl0cd+nqUtKHtsdBBfE8HM69cEGQjZ8iIt0GyYdQXxuBDbkR7FEXtXRPq6rEEb8P07NovKFPFObDHFori/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoDTZB3n; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso1709739276.0
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751815919; x=1752420719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qT/wsIOz9rcKF+efbWVgBfqK09r1SxugoizFvRkupI=;
        b=RoDTZB3nor1QraWc0rDz3hwoNkQ1liMqMqHJk3lgedxqncaWrRxK/8Jf+yZ+hOfBvQ
         PAZRHec+OD35ZmaucftKtGJJuWV8WWEW4xlR3TCUuf61PPe2h8bWZJvQtwyqDsmxLQfe
         2JwbnIHs6n8JUG/Oo2DzSwpR85NTJ7Ic9L3nN22p+Eyae+kpyPxfYh3m2RtB8cf5F86c
         uyWDJfBBZ3iuORq+cLK/LklA4ibGnMwlvQnnkGuVYuOE04um+M2dJl2vjq2UUDjzsNw6
         kC6KAm52mRfpr0at2lTEcdOr1Vu2qo3HxCfd4eblJUPXLag45ljV14+RTgva+MO9Iuzb
         XZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751815919; x=1752420719;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2qT/wsIOz9rcKF+efbWVgBfqK09r1SxugoizFvRkupI=;
        b=VhLborKYkLY5xU9WUrYX7Sqld1Wve4XA4UqJO/8/PmuPq7xcNrKvnsME1B1/teKRJY
         KllkIPMbEwZPVdhYLw/LG59hzZgxUpnruTT4b3iJhdwaXOx8zDol+JotC4TuUACAHUkj
         j5nBpKT4AgJ3/Y6DHcE08fCHWFbgtKubTgPKM1Pmy3DTBrWAFUlqQY0ULcg7/Q8uMMxg
         ByK1l1Z4PKyqCjeMlXybRcxwNE3B96lTx0k0NXL/hqvcaENNiiWL6phxKNPDmvV8meDF
         mSekTwZ30+ucTwFzwvHdN2tq6yiVi17TPZHRgnYpQfVvUcA4rFLPZqvPrvNgVLr/7gdk
         QO6w==
X-Forwarded-Encrypted: i=1; AJvYcCVYyl4uEqHNZ0s3Lm1i4LWtpq/8oiZcWosx86a7jcANTXOzr3XFGc4MDjrHzC5gntGV93XP8ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrS8cu7Z/nWXi0tEy+eUMFp2yqW4I/6L8w27BR2mYLCUPdyw0
	X18y5Iw5cGpyNExrFshzGF2RewcWfsGXfd71BlacdM92NFYY9uksOHll5Kv+4g==
X-Gm-Gg: ASbGnctjGnIh7yhcbJXrrxCxbIwQ2KJ7VKUnK2cUQnlbGFmGEg3vXsw7EVyJyNeA+E5
	kQqhMCrSVWQ55YDF3p2/teSd4sGINYwMfpvSfNS5uqj3pJBA8thUNzTYUc5h7w8BAK7AZV582CK
	xz6dNM7kcuxbkXzxqJIpQ9w+jrvJ31sHLFtvzvE+3Wa19PQdomCYcAegyi/EXbLeidp6687HW+M
	QfIpQHxT4IRGKrbVNbXLAtLC020n95Q1OkYddU2D2NBXFOwOtIhG1v+ZmHJJ63lx6RAUKkHyGVM
	NZcaI1+WAW0OCg+DYt/TxuWWppCE5eb7h8ZlIeeX4Sf8waOXYasDSxYregV+v1RJfzWuNgRQ5zJ
	xZdc7jJmH3pt6goxvl0w9ifHfHenWK+P/24Euy48=
X-Google-Smtp-Source: AGHT+IHecVeAW6GQLvlNqe2TQ5WiqVHxMLfL6dV0wW7YL5lz9pDHTPdXaxk3BMh0TKhQy5rxg4T4sA==
X-Received: by 2002:a05:690c:39f:b0:702:52af:7168 with SMTP id 00721157ae682-71668c0cdebmr131071617b3.2.1751815918697;
        Sun, 06 Jul 2025 08:31:58 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71665ae0560sm12467017b3.66.2025.07.06.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 08:31:57 -0700 (PDT)
Date: Sun, 06 Jul 2025 11:31:57 -0400
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
Message-ID: <686a96ed46da5_3ad0f32941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702171326.3265825-3-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-3-daniel.zahka@gmail.com>
Subject: Re: [PATCH v3 02/19] psp: base PSP device support
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
> Add a netlink family for PSP and allow drivers to register support.
> 
> The "PSP device" is its own object. This allows us to perform more
> flexible reference counting / lifetime control than if PSP information
> was part of net_device. In the future we should also be able
> to "delegate" PSP access to software devices, such as *vlan, veth
> or netkit more easily.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Minor points only

> +/**
> + * struct psp_dev - PSP device struct
> + * @main_netdev: original netdevice of this PSP device
> + * @ops:	driver callbacks
> + * @caps:	device capabilities
> + * @drv_priv:	driver priv pointer
> + * @lock:	instance lock, protects all fields
> + * @refcnt:	reference count for the instance
> + * @id:		instance id
> + * @config:	current device configuration
> + *
> + * @rcu:	RCU head for freeing the structure
> + */
> +struct psp_dev {
> +	struct net_device *main_netdev;
> +
> +	struct psp_dev_ops *ops;
> +	struct psp_dev_caps *caps;
> +	void *drv_priv;

not used?

> +
> +	struct mutex lock;
> +	refcount_t refcnt;
> +
> +	u32 id;
> +
> +	struct psp_dev_config config;
> +
> +	struct rcu_head rcu;
> +};
> +
> +/**
> + * struct psp_dev_caps - PSP device capabilities
> + */
> +struct psp_dev_caps {
> +	/**
> +	 * @versions: mask of supported PSP versions
> +	 * Set this field to 0 to indicate PSP is not supported at all.
> +	 */
> +	u32 versions;
> +};
> +
> +#define PSP_V0_KEY	16
> +#define PSP_V1_KEY	32

Above two not used? And these and the following are are KEY_LEN

> +#define PSP_MAX_KEY	32

