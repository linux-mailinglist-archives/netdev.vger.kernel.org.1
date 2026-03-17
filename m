Return-Path: <netdev+bounces-268747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIExKAvJuWl/NgIAu9opvQ
	(envelope-from <netdev+bounces-268747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:35:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B6B2B2C70
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C8E83055FBA
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBF39282B;
	Tue, 17 Mar 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TMX5gULk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A1390C93
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783303; cv=none; b=euN/RnDv9ZgvYqtvZpnB/XYUH4xJ2Vda2/Ufy9356lKIFpn287XDjiD2odjPCxMdTp9jyIJCabnUxm39TcV5HgAl9QzOR5ZgpuY5tU1u3kspW2wjZyVPofE41aXZQO5rR/UeUytuCVsHVJ+IOgEvopzGrEmPD99NnI74mbXvlQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783303; c=relaxed/simple;
	bh=nU4eV9AGDx8XFIVB4fQcYC+OWLftzQaVoXtlpBOrvHM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=LebLboQsaQdkSCQaLKZUhH4dmyExaHNZ/Cgdgn4UmUL03ecNrJfO4XAHFJx8+6mdSqdHO4garmwN/fTG87QmB0Z3eiiHeTjEfNwv0r2CmJg9IMkbweC6kO0BnzrgTssZLmK1OAZBW0ppEElurvheaqEQD7hAGzY7pvIkHWsXWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TMX5gULk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd90401034so658377585a.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773783299; x=1774388099; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HP3FBNe9OuKfJKVhnVb7LIsNz9sKQC2G5cAIorTIY2g=;
        b=TMX5gULkq/o00ctQv3uT5ICdvq6GHmSCziJa25ZiLONTDUUypCIio8NSIxmHv8JPBI
         t0XG3JBTu9xbk71ilwCYpGV1QjF5so9w6xlkdnlD1jssShCAuqx/bRkiVCfWH5ZfNNjx
         JI7GtKoeoh8i1Hs6ux2waunW/azrkHVCpsINDI/mz1XF/LJVxB276KBnlcMlTLl9cPB8
         LBZV8Yx5qqeiVZlmlTdgduwSX0H4OoVVcgx2fwCWIMEGGqRklA1r1XUBS7LJjswuNaWI
         jFeOxjm2lxau0vLmq7AntIY5Gm2+FOVg8Dz15BpVndkgPrmbUQvh4frvKUDxPPC3hpzv
         IOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773783299; x=1774388099;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HP3FBNe9OuKfJKVhnVb7LIsNz9sKQC2G5cAIorTIY2g=;
        b=hB9p7dbGwBOSsWlgRDVki4U/MaXbv/Y5/pYUtpssoIai3ci0gCUlC2tvxtnOOku8hD
         Pt2ex5KnVif1pQdz3ei/dc0KnZsXOiDFVRX2U8o6cZTAdQr3P5fkM2zxG5+t6P/czoXF
         jw3q/Mc4SwZPMQv3hvwJOVYqtSgw/7pMXnRtcMVBosu5BpJmi/vKJ2AY4lyCetg0iTUd
         eu6B3qdOVTdV7spYqY6fpTojuOwV8LTHzJjxIdPvljneMoN2uir5vI0Evqou8Nr6uy89
         1UcuyUuGqCtPWy1WcjXiWyiaiAyGFKOG+fVYCfh7oHyrEAS1ZyVOYlMZiY7qG7oZZSB2
         MX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa1jA5TuZH8NKtarhCc98/iBJjoz7mOT8fkIyUivU1bvq+PmCY5/CUrJMYt4mWpNQnmgYqu5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/B98HhqbtAuRjaZFZ8wz3kSOotWCiWXo1WtClmjHeiuI539+Z
	sqs5dpaLfI5CEhydHuYfZYT2EtikYNw1Gwoa8xxfwI4KwkaR7llxUQBV+uOgFmZs5Q==
X-Gm-Gg: ATEYQzyUkvr9X+UlNo21Dw3xSyE2+jMum3pxEuJwVEUpfI5cqACnFRqGqf0ZthBZNsW
	pDp266CUudgCT3DrZ17ctTOLGpZfUC8R3mKoUCXg6WcPaZq9hU3HfP4gkLJiilLlN9LI5nAMle8
	fAEFiHxQ0r7/efVIUvhEwyRL3qWFvRQ5WXlrzqGVmzun6HG9li7nWJdZURnk8dDLmibPC6JZiPr
	Hgh1hlzjnwGqxsqtvPDCaPEr1SLelGzBlbV7zhCX6gHl/B5WrY1MqvH9wHzmB9tUR8e4Nz+xTa7
	HQsIo8CjZg/te5fzCE0SoAFGVlsurwfBrGteiqZ+Q4XKTqdCT6CuNULf6+kithNB6iUsvoxYRii
	TSpes+ofSTi8wJZVLZwvSg2C9loJfhpvfVHLsL2Rz4JHldwdXzlRMzmDtPRzpIOD98V9zNtYnUI
	toUD4ZAl3t5GUSsWuWBa4gdRBZz4CzS/WBkxYVIANYgvpoZiPkNXK8nw3bHH7xzagmQUAA
X-Received: by 2002:a05:620a:29ca:b0:8cd:c077:40d3 with SMTP id af79cd13be357-8cfad1e0968mr169669185a.25.1773783299458;
        Tue, 17 Mar 2026 14:34:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfacc352a4sm70941785a.0.2026.03.17.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:34:58 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:34:57 -0400
Message-ID: <2697b9f672967b1318630f2ffa21914f@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260317_1333/pstg-lib:20260317_1127/pstg-pwork:20260317_1333
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, "John Johansen" <john.johansen@canonical.com>, "" , James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>, Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, "Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>, "Matthieu Buffet" <matthieu@buffet.re>, "Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, "Demi Marie Obenour" <demiobenour@gmail.com>, "Alyssa Ross" <hi@alyssa.is>, "Jann Horn" <jannh@google.com>, "Tahera Fahimi" <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Kuniyuki Iwashima" <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
References: <20260315222150.121952-2-gnoack3000@gmail.com>
In-Reply-To: <20260315222150.121952-2-gnoack3000@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268747-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,digikod.net,canonical.com,namei.org,hallyn.com];
	FREEMAIL_CC(0.00)[gmail.com,maowtm.org,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,maowtm.org:email,paul-moore.com:dkim,paul-moore.com:mid,paul-moore.com:url]
X-Rspamd-Queue-Id: 42B6B2B2C70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mar 15, 2026 =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com> wrote:
> 
> Add a LSM hook security_unix_find.
> 
> This hook is called to check the path of a named unix socket before a
> connection is initiated. The peer socket may be inspected as well.
> 
> Why existing hooks are unsuitable:
> 
> Existing socket hooks, security_unix_stream_connect(),
> security_unix_may_send(), and security_socket_connect() don't provide
> TOCTOU-free / namespace independent access to the paths of sockets.
> 
> (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> This requires another path lookup. A change in the path between the
> two lookups will cause a TOCTOU bug.
> 
> (2) We cannot use the struct path from the listening socket, because it
> may be bound to a path in a different namespace than the caller,
> resulting in a path that cannot be referenced at policy creation time.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 13 ++++++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 46 insertions(+), 3 deletions(-)

Some really minor nitpicky things (below), but nothing critical.
However, as we discussed, I would like to see the AppArmor folks comment
on the new hook before we merge anything as I know they have an interest
here.

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..7a0fd3dbfa29 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -317,6 +317,11 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
>  LSM_HOOK(int, 0, watch_key, struct key *key)
>  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
> +	 int flags)
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */

I'd suggest moving this into the CONFIG_SECURITY_NETWORK that is directly
below this block so you only have to check the CONFIG_SECURITY_PATH
state.  You can place it directly after the existing security_unix*()
hooks.

>  #ifdef CONFIG_SECURITY_NETWORK
>  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
>  	 struct sock *newsk)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..99a33d8eb28d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  }
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +
> +int security_unix_find(const struct path *path, struct sock *other, int flags);
> +
> +#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */

Similar to above, I would suggest moving this into the
CONFIG_SECURITY_NETWORK block directly above this so you only need to
check for CONFIG_SECURITY_PATH when declaring the security_unix_find()
hook.

Extra bonus points if you locate it next to the existing security_unix*()
hooks.

>  #ifdef CONFIG_SECURITY_INFINIBAND
>  int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
>  int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3756a93dc63a..aced28179bac 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1231,11 +1231,18 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  		goto path_put;
>  
>  	err = -EPROTOTYPE;
> -	if (sk->sk_type == type)
> -		touch_atime(&path);
> -	else
> +	if (sk->sk_type != type)
>  		goto sock_put;
>  
> +	/*
> +	 * We call the hook because we know that the inode is a socket and we
> +	 * hold a valid reference to it via the path.
> +	 */

I'm not entirely sure that this comment is necessary as it doesn't tell
us anything we don't already know from a quick glance at the code.  Is
there something sneaky, or hard to see, that we should know about?

> +	err = security_unix_find(&path, sk, flags);
> +	if (err)
> +		goto sock_put;
> +	touch_atime(&path);
> +

This is hyper nitpicky, but I'd probably put one line of vertical
whitespace before the touch_atime() call as it has nothing to do with
the LSM hook being called.

>  	path_put(&path);
>  
>  	return sk;
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..c73196b8db4b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +/**
> + * security_unix_find() - Check if a named AF_UNIX socket can connect
> + * @path: path of the socket being connected to
> + * @other: peer sock
> + * @flags: flags associated with the socket
> + *
> + * This hook is called to check permissions before connecting to a named
> + * AF_UNIX socket.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_unix_find(const struct path *path, struct sock *other, int flags)
> +{
> +	return call_int_hook(unix_find, path, other, flags);
> +}
> +EXPORT_SYMBOL(security_unix_find);
> +
> +#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */

You can probably guess that I'm going to suggest placing this inside the
existing CONFIG_SECURITY_NETWORK block, right after the existing UNIX
hooks :)

--
paul-moore.com

