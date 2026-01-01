Return-Path: <netdev+bounces-246483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B4CED008
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 13:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCFB300518C
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFFB2C11D1;
	Thu,  1 Jan 2026 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngrydRdz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ADD2877FA
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767269622; cv=none; b=IhnMewk0+nrvbbph5pdVNNp1+y4V5KnuN9UFu7iFRAa//rTR+Xi8abQ4uFbGICe+iqkcli2MX080n7e3A3wjuWauCPU1vjTeWSGkPkrdvvET/pEo9m/YHJQIOK7RzLFra4k09ZuaU99QgvizFTusniQ1CD4NpZzPKsnu/1EHCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767269622; c=relaxed/simple;
	bh=UdM1HfQreH+Y+jnaqsSNzGeHjhqbTMMiQQfYeJbdnXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrA5gUtRy7+f9h8B2FV3XUteDoc6PvJuFiGIEcE50jUg8THU+aILijn5N04U2q8/Z2sxU+fpvr6FbN/87UQXMXnK/KzO2ZrL4U8lERy7E4CwaGH7/R3O46GxlhspM9bamoi3Vq/Pcx39TbayIMgKPc9zNlL1O+6xXH8OOGpQM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngrydRdz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso15407621a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 04:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767269619; x=1767874419; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYSYQ5jiWBTKPeAkBFI55cURVtS8dCeOtSoRxb6fDPY=;
        b=ngrydRdzp9UMrAAej0nm7dkpQYveneJRxLWiyOvp1O2sxhVO8OTYXWAKDdXmel0STx
         Qsv/RmFeEH1izvJ9ebpbYScLl++pt74kFZFaLL8Tr7H/l8aUDvi1UudI9pqFC8lGRI3q
         B3+GygT0X+adD9K6bExUcOQw/itPdhl0XSR9UOSmDr/og2fbLgxXVY0Ks0kJYEE5kRLy
         DxDFk+QZV6yUjuoNqT1bIfrtz7G5DWznBTwhFH/xlsslP9i0kHSscurTTmrdumuySNPh
         pnVM1Q/NKekhakr9prrVHuRGn3J2A+eWfHIHxHkrx5XoNloUdkt8eYt5ZDEG9Njeh3rE
         bcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767269619; x=1767874419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYSYQ5jiWBTKPeAkBFI55cURVtS8dCeOtSoRxb6fDPY=;
        b=ThtFKei6ow7aCtF4H8ORnT8c7BzACrkUTaQsWHWEtUiu3Dk5qm6fV2/Xmy/Cjem01O
         95GSH/rT7ZnoU8Ns6J5sqjnHF26I3ZnqJdw4mUsxbDd8ZvU4tuZW+DpfKjq5NLVv+xcF
         KKM7oYTosacy0jtrFwqCtbsOYN3UAEgvIpns2wjvrdKD6qPwsIDrNoRoih2i47nzp1+9
         Uver/Z3zS0cx4rAPLDgLTKYRmMtYJJlHnfCt+8vzJeGqyzXfjeiEdLaRI/eJ4chrJMt3
         cmL80zlOo0IQpiqNLP0A/1FjNueMPiGmBKt9ksP3iP06khrTc89XoP0Br6CBCr61SQFd
         6/rA==
X-Forwarded-Encrypted: i=1; AJvYcCXgSg4QpA3Uu0gW1hqHRdpu70wgPI5/RHX46yUIH5+KnAMfC0+FkohjTaePcJYtHQ06uHaesFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyVvHAPJYPmlP34F91vheKuefXXEB3Y0urIHanTdA2jE/vI/Eb
	H91LYFNtjh7LXsJASvq4pmfPL+AagC4E+qLSadZOXI90AqGlmJoJABfv
X-Gm-Gg: AY/fxX50smb3NKda6L1nHlQqi0YySxgN4VQ6pYRfHH7QiycmAqAEt1w2KBhqWEcqn9i
	c3OuRWM3gTp561D/jpcU5VCRjaXtEVs59chuXAl4+Elk5VFNPq4H3G01I7eVAZsxfn38liRIvfE
	Tv7WCkIovKYb2Z1dvn/wQauNwnhNbbBqW1uhVJs5/7mrtOUCeWyAVLpuCcWgaFn4FNA059+KLOZ
	omFAqs6plkEnF5dU6kIDZ+9zeuXV1a2uf0v1swIaWNX+DDlYc+9WwwJYKn7xaM3VmkZmEqOcx/4
	iOKj3XUkF0dGcoWS6ZFLYFU+8Q/7JzH5MHA240UK88fce1485A8HF9/uXCOCY3B5DJ+uFhnN9zr
	+ZuaLmdCt6/gRXU9RC0D2m79mx9VpfU6hOW9Vy6cxhh5hZYVWjWE15TWARlRtscnUtDfP6FbKZ2
	L18vhijzYWJURUYqQu6QI+LHIvHaylUxkozFht
X-Google-Smtp-Source: AGHT+IEA+7d+Le0QvTD4GE5Cpqvg95b6e5wI7qG/ls/oCYhqJAD+jFmLwVfPk9/Tl1oJiXP0XLihGw==
X-Received: by 2002:a17:907:7eaa:b0:b73:1e09:7377 with SMTP id a640c23a62f3a-b80371d6c10mr4513082466b.58.1767269619308;
        Thu, 01 Jan 2026 04:13:39 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80620c4520sm3669832066b.28.2026.01.01.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 04:13:39 -0800 (PST)
Date: Thu, 1 Jan 2026 13:13:37 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] lsm: Add hook unix_path_connect
Message-ID: <20260101.f6d0f71ca9bb@gnoack.org>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <20251231213314.2979118-2-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251231213314.2979118-2-utilityemal77@gmail.com>

On Wed, Dec 31, 2025 at 04:33:14PM -0500, Justin Suess wrote:
> Adds an LSM hook unix_path_connect.
> 
> This hook is called to check the path of a named unix socket before a
> connection is initiated.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Cc: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/unix/af_unix.c            |  8 ++++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..a42d1aaf3b8a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -318,6 +318,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
>  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> +LSM_HOOK(int, 0, unix_path_connect, const struct path *path)

You are placing this guarded by CONFIG_SECURITY_NETWORK, but there is
also CONFIG_SECURITY_PATH.  Should it be guarded by both?


>  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
>  	 struct sock *newsk)
>  LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..ab66f22f7e5a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1638,6 +1638,7 @@ static inline int security_watch_key(struct key *key)
>  
>  #ifdef CONFIG_SECURITY_NETWORK
>  
> +int security_unix_path_connect(const struct path *path);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
>  int security_unix_may_send(struct socket *sock,  struct socket *other);
> @@ -1699,6 +1700,11 @@ static inline int security_netlink_send(struct sock *sk, struct sk_buff *skb)
>  	return 0;
>  }
>  
> +static inline int security_unix_path_connect(const struct path *path)
> +{
> +	return 0;
> +}
> +
>  static inline int security_unix_stream_connect(struct sock *sock,
>  					       struct sock *other,
>  					       struct sock *newsk)
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 55cdebfa0da0..af1a6083a69b 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1226,6 +1226,14 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  	if (!S_ISSOCK(inode->i_mode))
>  		goto path_put;
>  
> +	/*
> +	 * We call the hook because we know that the inode is a socket
> +	 * and we hold a valid reference to it via the path.
> +	 */
> +	err = security_unix_path_connect(&path);
> +	if (err)
> +		goto path_put;

In this place, the hook call is done also for the coredump socket.

The coredump socket is a system-wide setting, and it feels weird to me
that unprivileged processes should be able to inhibit that connection?


> +
>  	sk = unix_find_socket_byinode(inode);
>  	if (!sk)
>  		goto path_put;
> diff --git a/security/security.c b/security/security.c
> index 31a688650601..17af5d0ddf28 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4047,6 +4047,22 @@ int security_unix_stream_connect(struct sock *sock, struct sock *other,
>  }
>  EXPORT_SYMBOL(security_unix_stream_connect);
>  
> +/*
> + * security_unix_path_connect() - Check if a named AF_UNIX socket can connect
> + * @path: Path of the socket being connected to
             ^
mega-nit: lowercase for consistency

> + *
> + * This hook is called to check permissions before connecting to a named
> + * AF_UNIX socket. This is necessary because it was not possible to check the
> + * VFS inode of the target socket before the connection is made.

I'd drop the last sentence; the defense why this is necessary can go
in the commit message, and once we have a call-site for the hook,
someone browsing the kernel code can look up what it is used for.

> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_unix_path_connect(const struct path *path)
> +{
> +	return call_int_hook(unix_path_connect, path);
> +}
> +EXPORT_SYMBOL(security_unix_path_connect);
> +
>  /**
>   * security_unix_may_send() - Check if AF_UNIX socket can send datagrams
>   * @sock: originating sock
> -- 
> 2.51.0
> 

