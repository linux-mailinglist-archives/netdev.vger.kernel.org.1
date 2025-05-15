Return-Path: <netdev+bounces-190817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37780AB8F41
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC789E458D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951E727A477;
	Thu, 15 May 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfwmKpYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B626A0D1
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334660; cv=none; b=Zcu5HHNptFShCdXQMBwrcqHN2agwogqKEEMfkmboGGO1+nCPDcQv+w23LKlfZYzWjcQZDl2rEyKkU1h/8k4UHp/QPLtz8XrPqIMCGfcR15jCl3wATlQnjXUUOjqqffXG1UiUJtmjeGHXjr9AbpwPVGXTWZew5kk3mSdcjN0/FJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334660; c=relaxed/simple;
	bh=9N/hzsqTyGLBDyvhSteQwo6X/hLU8YcdFInvOONggOQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QjVI2xEgdvHfj9YTVP4m55God4m7FSAoD4rmB6HT9a/RnGPPma3Vea6F23JmRzH/LA45Yu1TmwYD3GLjoOei61/7tNiqt7SXBC5jNZkmnF/GpZ3Cq5934IIy6/kfuTFkiPffwUNRwehxwIxFKZAk66AP/CyU/RI1yRrRntXD3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfwmKpYS; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f8ae08e3b3so6648616d6.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747334656; x=1747939456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nGEzoHiLn8ihoBvsVODLO+XgkawSLJVBX6CWmEkTHM=;
        b=WfwmKpYSadqQvLog3w79o9cjDBT1g7VPm9GdxWpNIV5iuZPFuDzbjWoF1hfVRndVDS
         Z/WBziXvL+SOfUcX/6qYl7ErTDXs27OdStY+nsK+3hwbO8DCwCMGyHfxdpuaB46+AXuK
         uR0eKnFGn546APTYex181wkTlUiMvORYRNR+7Siup1E3MDV+jf4nD8/aZMJXUqsifJQL
         DU04/UKO50dfRyf5FWXIBQMA8wCdZPjIWPGYNfqBTrcYiyZ56/1NVWpPyL5JZNi4C6Bh
         cOTojH/3s0CEvIwCalNQRLdjy7/rdKBxj0xdNqn/aUfLN2d5aHNFzA6ppb77oi9cTo2M
         2bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747334656; x=1747939456;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3nGEzoHiLn8ihoBvsVODLO+XgkawSLJVBX6CWmEkTHM=;
        b=J87Cf4Zip4B4Q7KaNZy7QQRRd//J1FH55cHLtdqR+1q6GWEaSPgoN2xD+Oqw3MRE91
         Ouot4MqA7lqP10y7/HCbtV+oxPyC7T2gaUwvwXX4t3HB/vFyLPc/JOEoeeqRzb4k+Rfg
         mGcXU7Jb+rHDBuKiIjigKc2L1GcUrVFm7R+CXbiiXxoQjiYqVjY/Cn6rr3DWsvjyaxc4
         qh/lp7/UDVItoMdWaHGiwlW5FU3ttQCymdivS56z45anCL3lPKTUpm2UFEpukPOwhmag
         6iQT2lQyrxPBX6MorBecE7+NOqRlL9hiEEIMrncfAybOUzvph+cKG2H/0MMsQMnBF4OA
         DFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCViotAHeKjE5SNwBddIwLmfgpdKinkfXnZE9KFRyLr+Nc8yhQEMeTCoItfLWkbz15JVZDbuw6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02TyPZAh27PadSKzn176+HCfdHYZdQBMkCRAREl3rL7JpkujU
	hbkXG7A7Bp/FCbsB7snANGOCa07xrKE+d7xrc3n6M+kGTN8M4wBjPN28
X-Gm-Gg: ASbGncsIs0iHcXVbmYkbfGmmYsdTjjkskgJW9TqP/rc8Dw0Er49UN4GYmXZckWovg0F
	dXsRZOIPQIfhXxFjbAGzAimzqPvD9O34tUynjBzfLiP+FIMwPT4NUuo/ZpErL8S8YBW/NZh+i52
	a7XJZUSRy/aird4aCjrurTY+ee+9/RN2u/hGHDxIleuwSerjUbN57ky6BVO6IfKThKwU7gKoUYw
	JHbT9BymWrzOBqjxm740EvPndVLZPknlIvTiW11TQBaFF61o4GrOfry7cRWphStS5y8CLZFUkho
	09XKTPz1ZdbuKijaLOjhE8cE/FiJei9AOwsce2DaZKPzbec8SRdZ+fXRdFoSGd7iu+AuQtMjI1X
	7cuYC749RYn63G4nquCnDvu0=
X-Google-Smtp-Source: AGHT+IEUP1ekjUDs4wA5e+ARMgqyOmXLdG23wKYom6ehfQqJyUY3bPWaR4Umm1qosYHjvR/n2ozf5A==
X-Received: by 2002:a05:6214:1cca:b0:6f2:c94f:8cfe with SMTP id 6a1803df08f44-6f8b08b7479mr13779886d6.23.1747334656072;
        Thu, 15 May 2025 11:44:16 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0965831sm2523856d6.75.2025.05.15.11.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:44:15 -0700 (PDT)
Date: Thu, 15 May 2025 14:44:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <682635fea3015_25ebe52945d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514165226.40410-7-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
 <20250514165226.40410-7-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC}
 to struct sock.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> As explained in the next patch, SO_PASSRIGHTS would have a problem
> if we assigned a corresponding bit to socket->flags, so it must be
> managed in struct sock.
> 
> Mixing socket->flags and sk->sk_flags for similar options will look
> confusing, and sk->sk_flags does not have enough space on 32bit system.
> 
> Also, as mentioned in commit 16e572626961 ("af_unix: dont send
> SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
> is known to be slow, and managing the flags in struct socket cannot
> avoid that for embryo sockets.
> 
> Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> 
> While at it, other SOCK_XXX flags in net.h are grouped as enum.
> 
> Note that assign_bit() was atomic, so the writer side is moved down
> after lock_sock() in setsockopt(), but the bit is only read once
> in sendmsg() and recvmsg(), so lock_sock() is not needed there.

Because the socket lock is already held there?

What about getsockopt. And the one READ_ONCE in unix_accept.
 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v3:
>   * Add kdoc for sk_scm_unused
>   * Update sk->sk_scm_xxx after lock_sock() in setsockopt()
> ---
>  include/linux/net.h | 15 +++++++--------
>  include/net/sock.h  | 14 +++++++++++++-
>  net/core/scm.c      | 29 ++++++++++++++---------------
>  net/core/sock.c     | 44 +++++++++++++++++++++++---------------------
>  net/unix/af_unix.c  | 18 ++----------------
>  5 files changed, 59 insertions(+), 61 deletions(-)
> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index 0ff950eecc6b..f8418d6e33e0 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -36,14 +36,13 @@ struct net;
>   * in sock->flags, but moved into sk->sk_wq->flags to be RCU protected.
>   * Eventually all flags will be in sk->sk_wq->flags.
>   */
> -#define SOCKWQ_ASYNC_NOSPACE	0
> -#define SOCKWQ_ASYNC_WAITDATA	1
> -#define SOCK_NOSPACE		2
> -#define SOCK_PASSCRED		3
> -#define SOCK_PASSSEC		4
> -#define SOCK_SUPPORT_ZC		5
> -#define SOCK_CUSTOM_SOCKOPT	6
> -#define SOCK_PASSPIDFD		7
> +enum socket_flags {
> +	SOCKWQ_ASYNC_NOSPACE,
> +	SOCKWQ_ASYNC_WAITDATA,
> +	SOCK_NOSPACE,
> +	SOCK_SUPPORT_ZC,
> +	SOCK_CUSTOM_SOCKOPT,
> +};
>  
>  #ifndef ARCH_HAS_SOCKET_TYPES
>  /**
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 56fa558d24c0..77232a098934 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -337,6 +337,11 @@ struct sk_filter;
>    *	@sk_txtime_deadline_mode: set deadline mode for SO_TXTIME
>    *	@sk_txtime_report_errors: set report errors mode for SO_TXTIME
>    *	@sk_txtime_unused: unused txtime flags
> +  *	@sk_scm_recv_flags: all flags used by scm_recv()
> +  *	@sk_scm_credentials: flagged by SO_PASSCRED to recv SCM_CREDENTIALS
> +  *	@sk_scm_security: flagged by SO_PASSSEC to recv SCM_SECURITY
> +  *	@sk_scm_pidfd: flagged by SO_PASSPIDFD to recv SCM_PIDFD
> +  *	@sk_scm_unused: unused flags for scm_recv()
>    *	@ns_tracker: tracker for netns reference
>    *	@sk_user_frags: xarray of pages the user is holding a reference on.
>    *	@sk_owner: reference to the real owner of the socket that calls
> @@ -523,7 +528,14 @@ struct sock {
>  #endif
>  	int			sk_disconnects;
>  
> -	u8			sk_txrehash;
> +	union {
> +		u8		sk_txrehash;
> +		u8		sk_scm_recv_flags;
> +		u8		sk_scm_credentials : 1,
> +				sk_scm_security : 1,
> +				sk_scm_pidfd : 1,
> +				sk_scm_unused : 5;
> +	};
>  	u8			sk_clockid;
>  	u8			sk_txtime_deadline_mode : 1,
>  				sk_txtime_report_errors : 1,
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 66e02b18c359..0225bd94170f 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -406,12 +406,12 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
>  EXPORT_SYMBOL(scm_fp_dup);
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> -static void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
> +static void scm_passec(struct sock *sk, struct msghdr *msg, struct scm_cookie *scm)
>  {
>  	struct lsm_context ctx;
>  	int err;
>  
> -	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> +	if (sk->sk_scm_security) {
>  		err = security_secid_to_secctx(scm->secid, &ctx);
>  
>  		if (err >= 0) {
> @@ -423,16 +423,16 @@ static void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cooki
>  	}
>  }
>  
> -static bool scm_has_secdata(struct socket *sock)
> +static bool scm_has_secdata(struct sock *sk)
>  {
> -	return test_bit(SOCK_PASSSEC, &sock->flags);
> +	return sk->sk_scm_security;
>  }
>  #else
> -static void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
> +static void scm_passec(struct sock *sk, struct msghdr *msg, struct scm_cookie *scm)
>  {
>  }
>  
> -static bool scm_has_secdata(struct socket *sock)
> +static bool scm_has_secdata(struct sock *sk)
>  {
>  	return false;
>  }
> @@ -474,20 +474,19 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
>  		fd_install(pidfd, pidfd_file);
>  }
>  
> -static bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
> +static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
>  			      struct scm_cookie *scm, int flags)
>  {
>  	if (!msg->msg_control) {
> -		if (test_bit(SOCK_PASSCRED, &sock->flags) ||
> -		    test_bit(SOCK_PASSPIDFD, &sock->flags) ||
> -		    scm->fp || scm_has_secdata(sock))
> +		if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
> +		    scm->fp || scm_has_secdata(sk))
>  			msg->msg_flags |= MSG_CTRUNC;
>  
>  		scm_destroy(scm);
>  		return false;
>  	}
>  
> -	if (test_bit(SOCK_PASSCRED, &sock->flags)) {
> +	if (sk->sk_scm_credentials) {
>  		struct user_namespace *current_ns = current_user_ns();
>  		struct ucred ucreds = {
>  			.pid = scm->creds.pid,
> @@ -498,7 +497,7 @@ static bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
>  		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(ucreds), &ucreds);
>  	}
>  
> -	scm_passec(sock, msg, scm);
> +	scm_passec(sk, msg, scm);
>  
>  	if (scm->fp)
>  		scm_detach_fds(msg, scm);
> @@ -509,7 +508,7 @@ static bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
>  void scm_recv(struct socket *sock, struct msghdr *msg,
>  	      struct scm_cookie *scm, int flags)
>  {
> -	if (!__scm_recv_common(sock, msg, scm, flags))
> +	if (!__scm_recv_common(sock->sk, msg, scm, flags))
>  		return;
>  
>  	scm_destroy_cred(scm);
> @@ -519,10 +518,10 @@ EXPORT_SYMBOL(scm_recv);
>  void scm_recv_unix(struct socket *sock, struct msghdr *msg,
>  		   struct scm_cookie *scm, int flags)
>  {
> -	if (!__scm_recv_common(sock, msg, scm, flags))
> +	if (!__scm_recv_common(sock->sk, msg, scm, flags))
>  		return;
>  
> -	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
> +	if (sock->sk->sk_scm_pidfd)
>  		scm_pidfd_recv(msg, scm);
>  
>  	scm_destroy_cred(scm);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index fd5f9d3873c1..381abf8f25b7 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1220,24 +1220,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  			return 0;
>  		}
>  		return -EPERM;
> -	case SO_PASSSEC:
> -		if (!IS_ENABLED(CONFIG_SECURITY_NETWORK) || sk_may_scm_recv(sk))
> -			return -EOPNOTSUPP;
> -
> -		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
> -		return 0;
> -	case SO_PASSCRED:
> -		if (!sk_may_scm_recv(sk))
> -			return -EOPNOTSUPP;
> -
> -		assign_bit(SOCK_PASSCRED, &sock->flags, valbool);
> -		return 0;
> -	case SO_PASSPIDFD:
> -		if (!sk_is_unix(sk))
> -			return -EOPNOTSUPP;
> -
> -		assign_bit(SOCK_PASSPIDFD, &sock->flags, valbool);
> -		return 0;
>  	case SO_TYPE:
>  	case SO_PROTOCOL:
>  	case SO_DOMAIN:
> @@ -1568,6 +1550,26 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		sock_valbool_flag(sk, SOCK_SELECT_ERR_QUEUE, valbool);
>  		break;
>  
> +	case SO_PASSCRED:
> +		if (sk_may_scm_recv(sk))
> +			sk->sk_scm_credentials = valbool;
> +		else
> +			ret = -EOPNOTSUPP;
> +		break;
> +
> +	case SO_PASSSEC:
> +		if (IS_ENABLED(CONFIG_SECURITY_NETWORK) && sk_may_scm_recv(sk))
> +			sk->sk_scm_security = valbool;
> +		else
> +			ret = -EOPNOTSUPP;
> +		break;
> +
> +	case SO_PASSPIDFD:
> +		if (sk_is_unix(sk))
> +			sk->sk_scm_pidfd = valbool;
> +		else
> +			ret = -EOPNOTSUPP;
> +		break;
>  
>  	case SO_INCOMING_CPU:
>  		reuseport_update_incoming_cpu(sk, val);
> @@ -1867,14 +1869,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  		if (!sk_may_scm_recv(sk))
>  			return -EOPNOTSUPP;
>  
> -		v.val = !!test_bit(SOCK_PASSCRED, &sock->flags);
> +		v.val = sk->sk_scm_credentials;
>  		break;
>  
>  	case SO_PASSPIDFD:
>  		if (!sk_is_unix(sk))
>  			return -EOPNOTSUPP;
>  
> -		v.val = !!test_bit(SOCK_PASSPIDFD, &sock->flags);
> +		v.val = sk->sk_scm_pidfd;
>  		break;
>  
>  	case SO_PEERCRED:
> @@ -1974,7 +1976,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  		if (!IS_ENABLED(CONFIG_SECURITY_NETWORK) || !sk_may_scm_recv(sk))
>  			return -EOPNOTSUPP;
>  
> -		v.val = !!test_bit(SOCK_PASSSEC, &sock->flags);
> +		v.val = sk->sk_scm_security;
>  		break;
>  
>  	case SO_PEERSEC:
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index a39497fd6e98..27ebda4cd9b9 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -767,10 +767,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
>  
>  static bool unix_may_passcred(const struct sock *sk)
>  {
> -	struct socket *sock = sk->sk_socket;
> -
> -	return test_bit(SOCK_PASSCRED, &sock->flags) ||
> -		test_bit(SOCK_PASSPIDFD, &sock->flags);
> +	return sk->sk_scm_credentials || sk->sk_scm_pidfd;
>  }
>  
>  static int unix_listen(struct socket *sock, int backlog)
> @@ -1713,17 +1710,6 @@ static int unix_socketpair(struct socket *socka, struct socket *sockb)
>  	return 0;
>  }
>  
> -static void unix_sock_inherit_flags(const struct socket *old,
> -				    struct socket *new)
> -{
> -	if (test_bit(SOCK_PASSCRED, &old->flags))
> -		set_bit(SOCK_PASSCRED, &new->flags);
> -	if (test_bit(SOCK_PASSPIDFD, &old->flags))
> -		set_bit(SOCK_PASSPIDFD, &new->flags);
> -	if (test_bit(SOCK_PASSSEC, &old->flags))
> -		set_bit(SOCK_PASSSEC, &new->flags);
> -}
> -
>  static int unix_accept(struct socket *sock, struct socket *newsock,
>  		       struct proto_accept_arg *arg)
>  {
> @@ -1760,7 +1746,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
>  	unix_state_lock(tsk);
>  	unix_update_edges(unix_sk(tsk));
>  	newsock->state = SS_CONNECTED;
> -	unix_sock_inherit_flags(sock, newsock);
> +	tsk->sk_scm_recv_flags = READ_ONCE(sk->sk_scm_recv_flags);
>  	sock_graft(tsk, newsock);
>  	unix_state_unlock(tsk);
>  	return 0;
> -- 
> 2.49.0
> 



