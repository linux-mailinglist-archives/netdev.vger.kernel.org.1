Return-Path: <netdev+bounces-249374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45AD17BF5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18E66306435B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7912A33BBC6;
	Tue, 13 Jan 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmJvPuye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D22EA48F;
	Tue, 13 Jan 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296846; cv=none; b=jRKygaTFk6RsYTEatS54jNIKfTFadtYwrgjI6Pl3MFFRsoF1E/C5gVOBmfdyHbf2aUdH40OsUzhdSHJXTHQ4IpdG7UFLWFYBijR70DYIQ+q6WhQPDPNWjj84QQGSUORbbSacO5Gnkg/69kzHHZwzk03LU8qZQyEtTHC5gruAm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296846; c=relaxed/simple;
	bh=3BAHxdUuSQCK2Gm9pkSjDL+/cYetI64jI16DsIz55Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAgtDs4zRFNXMICzY0EV8dx9nurmMc7XtZ/T7e+lqYOKW0uJyFe29X1Xc2wC3xeUQD5Ie7+icMR2NyC+HyTC2ZQ8H3A2r17FAk37nk05YqirvaCBI1nyNJNUh9T5ugHESX/Cg+nCntm08ctnEAREhtxIqW5m20B6URqR/E019MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmJvPuye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A040C116C6;
	Tue, 13 Jan 2026 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296846;
	bh=3BAHxdUuSQCK2Gm9pkSjDL+/cYetI64jI16DsIz55Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmJvPuyeZ/EGjyDFqRTMxV0H0EnvyUmm1xDGSf1aLxX6xBNDIz9gShJvhj8P+1sXb
	 mFmpnPgcnDgAZW+3ubBRbyqtG/Viv9XrFeF8YF8nJYf/X9Pgv1SigGt/1479pe3/ZA
	 rXU6wUNYsnM7S+yyVnMK70vOzJcdPHB24oOEYK6nOnxveZlpAD3/t+42v0QGQ+t26g
	 nFH7wEF8YSKAE0RMS249z4cD70XX39fApOQbq6jGp8jSQkt90iUwMIR74ZSC/KkXLJ
	 WcnaaudOpZuEroltlHbBxqKMD6Hilgv7RH1B58ugeU8mJrseyJLAer95Psf3riaogO
	 P9wOrgbMWdfuQ==
Date: Tue, 13 Jan 2026 10:34:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
Message-ID: <20260113-kerngesund-etage-86de4a21da24@brauner>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-4-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260110143300.71048-4-gnoack3000@gmail.com>

On Sat, Jan 10, 2026 at 03:32:57PM +0100, Günther Noack wrote:
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

Couldn't we try reflowing the code here so the path is passed to
security_unix_stream_connect() and security_unix_may_send() so that all
LSMs get the same data and we don't have to have different LSMs hooks
into different callpaths that effectively do the same thing.

I mean the objects are even in two completely different states between
those hooks. Even what type of sockets get a call to the LSM is
different between those two hooks.

