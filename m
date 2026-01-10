Return-Path: <netdev+bounces-248711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45514D0D92E
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46E5930185EF
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0480328000B;
	Sat, 10 Jan 2026 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMYQD8Ij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B734276041
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768063508; cv=none; b=tWQ/BDwTsKqKd+8vZgXANQzQSDvNacKkgKONIe93wEueP1xlYlQkkcH6VmIkfGGCU7ZGZ66Cm2Pz/KM6dgVZBc2T5Js6wkq766VefGq/2pCYphWzUMqDpAij7/lODf9VknJ1r+T39QPsONWk4F6olCSimo7KJb4b4EvumtWwhvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768063508; c=relaxed/simple;
	bh=0VM9KCmw1P39Wqs7XdZuxA4R85V6QsXgtikOUJooDZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhY9v5w6imsm3BxAkEi4XeZ8a2wMLpN4YRKKjNOOqSYGIErkU8BhiZ7ctyc6lU56Ye/tUhm1S3w+MW/gZZfRW/62IVgRIp28LiBmiTbgr22Fnuy+/pQqA+6C/jxjFDKfuxNLxN36SgruGbZaWL/p24mMP+uKmPz6PWBmI7Mq3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMYQD8Ij; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64455a2a096so4414239d50.3
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 08:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768063505; x=1768668305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZj8C+WJTqO5Fhdwh8WBBEtQntwBMgdeokvzPM/Bz9Q=;
        b=aMYQD8Ij3EhBALQrQ39dnqdwmF3xvb0Uv03I31sHy6td8Wq3+7s7/OD5mEOtuRboL2
         ETOPWS9EA7n9n4VbOkEZL3hx7yXIE+5CM2ShHjqRPpJU+R75vmhjlG5eXVj82yeeJiWd
         k+7c5Q6Ygb5o04ezzJ6DrB17wpa/Qj4Zcbm2sKW5HH/wFZ0lzqj2Zf4IpmOl8YkI+Xma
         unLidL6oNCXwoWsSMsXyp98q/EGj71eEe1dMVHrLYByqhRCs67vLTRK5ZmprhKTX/rVQ
         tgMnDJXzKKZFLDUR8Q0IJ9eW+s7wpDWgJTx21SUezwaxUkEicM+uazUpPxWmaS+iKjvT
         w0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768063505; x=1768668305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZj8C+WJTqO5Fhdwh8WBBEtQntwBMgdeokvzPM/Bz9Q=;
        b=DQU+4TgpjtrHBPGPGcq9UOeMxIUeOkzO1KqkMJqvoUFt7WlTBV6dgOuFM9jB1Vl80G
         IlXwkRLNlUmtPOM4pPgGBwP6R+DbEf6MsctrCuZ+RkuYLFUym4vm6MxU5+RTjx65iImT
         tvRoo4zRkHspKViKRC9zQj4ta0oQMCDXcuJ3aMWNj9aOtnc0IfYc+cwTrOCI4zny2mJg
         CeL7NhrcBW5vJYqOrrwSeqqcWp4MbTcRpaMQ72022c8sJijSVOeoCv6Fzx9yk8UUCZ5p
         UFp3qNUKjn4y0ST9wkaAr+KdCI3URADcVDMDhJ+I4g2g4buuf9TH/IBcNjjuDtFBn3cK
         uwTw==
X-Forwarded-Encrypted: i=1; AJvYcCXqRYxDgYQQGovfBzd/Kvg/SaKoAc+oOW+v5qSi5TCUaM6q/L4p35njcsQcYIVp/M3MKEwTh3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3cduKf1FZwE74JGhmHU9eNO2Us08i77hWmHZbpABEQZez/I/
	8Gu86Vj3fU0SHEiO59SUhv3Tp2uf2TaMtiuqfzxLHOlKS5r3IK5FJT+qeGw84w==
X-Gm-Gg: AY/fxX5kxbwmKpdo0vlEnPPQr4kH3EfFnLDC5JBM3JpMZSwmwREOwzyXmUnRg56RXPJ
	Rsgz/X0K/Emnqai/t/Egp/sN6z4iTptEaDLcDEvAj2vUSTCGKJYBH3b4rAoYQ1i4DCJj9+KeE4e
	DP8Eh/CGvZdOHiC0sKlDUjlTW8KFbSXtjVFelBhjjirBKeaj4ZgmSwf+TRU+imwhkRYvFX40/30
	g8HMRn2MV7NDz9rIZ0zONDk1ZpeEZzvgIJk6Xh1B8p6/Bs/P3GILyNeyg7YTcTQAM8jTVgNAIMP
	Nkg9vTEViurZMs3VNolvXocq2STkXEEVNDBOH32fQPqP0PXF5XVC9PRnBMof6J08MeLWNyOdwes
	YvaLu6A5MJ4X2/lCzWyyn2KTErxTMTtMtkQjaRu12HSZ/rTpkXeuClN/+6hZis3Ys4srsGHV9rd
	EddbkjvEovjJ8lVP/PxdCzuqsWdQFGVy6SA66LmXl91m6YwYejZV2I+ioUWtGHiyOt/DoH7Q==
X-Google-Smtp-Source: AGHT+IHdumL/CyDmdrqvgMkE/IVyFzsfovyRmwWdV2GajUG6u0NQ9kSTf83jDhpg21DNJ0ulihZz3w==
X-Received: by 2002:a05:690c:7087:b0:78f:afbe:3e85 with SMTP id 00721157ae682-790b575834bmr261130877b3.24.1768063504921;
        Sat, 10 Jan 2026 08:45:04 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b2573sm5891322d50.21.2026.01.10.08.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 08:45:04 -0800 (PST)
Message-ID: <4bc22faa-2927-4ef9-b5dc-67a7575177e9@gmail.com>
Date: Sat, 10 Jan 2026 11:45:03 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 Matthieu Buffet <matthieu@buffet.re>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>,
 Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
 Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-4-gnoack3000@gmail.com>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <20260110143300.71048-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/10/26 09:32, Günther Noack wrote:
> From: Justin Suess <utilityemal77@gmail.com>
>
> Adds an LSM hook unix_path_connect.
>
> This hook is called to check the path of a named unix socket before a
> connection is initiated.
>
> Cc: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 ++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            |  9 +++++++++
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 44 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..1dee5d8d52d2 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -317,6 +317,10 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
>  LSM_HOOK(int, 0, watch_key, struct key *key)
>  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +LSM_HOOK(int, 0, unix_path_connect, const struct path *path, int type, int flags)
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_NETWORK
>  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
>  	 struct sock *newsk)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..382612af27a6 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  }
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +
> +int security_unix_path_connect(const struct path *path, int type, int flags);
> +
> +#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +static inline int security_unix_path_connect(const struct path *path, int type, int flags)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_INFINIBAND
>  int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
>  int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 55cdebfa0da0..3aabe2d489ae 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1226,6 +1226,15 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  	if (!S_ISSOCK(inode->i_mode))
>  		goto path_put;
>  
> +	/*
> +	 * We call the hook because we know that the inode is a socket
> +	 * and we hold a valid reference to it via the path.
> +	 */
> +	err = security_unix_path_connect(&path, type, flags);
> +	if (err)
> +		goto path_put;
> +
> +	err = -ECONNREFUSED;
>  	sk = unix_find_socket_byinode(inode);
>  	if (!sk)
>  		goto path_put;
> diff --git a/security/security.c b/security/security.c
> index 31a688650601..0cee3502db83 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +/*
> + * security_unix_path_connect() - Check if a named AF_UNIX socket can connect
> + * @path: path of the socket being connected to
> + * @type: type of the socket
> + * @flags: flags associated with the socket
> + *
> + * This hook is called to check permissions before connecting to a named
> + * AF_UNIX socket.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_unix_path_connect(const struct path *path, int type, int flags)
> +{
> +	return call_int_hook(unix_path_connect, path, type, flags);
> +}
> +EXPORT_SYMBOL(security_unix_path_connect);
> +
> +#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_INFINIBAND
>  /**
>   * security_ib_pkey_access() - Check if access to an IB pkey is allowed
Just for awareness,

I'm considering renaming this hook to unix_socket_path_lookup, since as Günther
pointed out this hook is not just hit on connect, but also on sendmsg.

Justin

