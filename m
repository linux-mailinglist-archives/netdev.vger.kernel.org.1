Return-Path: <netdev+bounces-190826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307C4AB8FF7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 21:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D951BC5858
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE8227EC73;
	Thu, 15 May 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExAYm1oG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231525C6FA
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747337161; cv=none; b=ndnFdmWFJppNV3/TX4i2LgFYOiKVy7H+kEDxWlF6H/J7cAtc8uYh/UpM/41hSan7vOq2uTBNTUpX9/ktaKIhb8ouP/e9tlQlAHOebvd9X6IGn2RxytlNc0QO+mTEqbuBbSrSoQi+L5f/H4BFrCnqmm6dcLSv/SbezQQvjwStVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747337161; c=relaxed/simple;
	bh=/Fpgqx13dSubLrx5zerOyRO0DAGulMIrvsP1LqjrYGQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=my2A7XgcmWVa3tu8FE2YPZF1DduaC9c7byVq9n9ej6OZa69Vy5oRK3PRaxBU+lMedPiWHu9iW00ByCqpec9ev61+LGMgLDBdn17iAXLVV2VIcJaXuenTaWZpvOum/F6VDGz/vtmRhkI5qMo7vU1GMvnYiWeywIbLDqXuSKxGy5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExAYm1oG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c54a9d3fcaso135692985a.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747337158; x=1747941958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ct3oPJ3+eUq//KLObXFez6mE2bN/J0+aw5DKboMa1w=;
        b=ExAYm1oGtcEJblmLN366kFVwvII3aaBmxus7ipdRmObBapf0do2kGveyw0625t6IGD
         DzAZwzJmb9ELLrQx32ooqSwRoTp4BbaZUfHFKa++NkTJZz20EK/HCQ1Y4EaueKRjG080
         9VLVdBxHSEeTv3tVSG4UYvkPsMePJ2TcQxScrZPZyZVCojCtQkNamRzxERm5X9IL9dnT
         NCHLxSq52L2vTXe2MmPWBnid4JlLWe1mf6VKsi/qwyah5uaKWBAMZ4biZu/b2FgpupGA
         f+UEA9WyEPsKYGh4YnkukGYpDs8e097MDfZnKzJ5kEoIONZeo3JJKy8cq0uKYT1Qmi7V
         H/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747337158; x=1747941958;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ct3oPJ3+eUq//KLObXFez6mE2bN/J0+aw5DKboMa1w=;
        b=NnD9sJvsg0YXQK6WHM2Jt/FJDY5R4/hftoIW7lbJzf+qczlN2oxI2Mv4dipvZRV7cb
         AFK0U5DEGguURotxWzbmaD/mv5DIKyJ0SB7hCqVTvB4GyeG9IZej5sGQPl6Va2iZzokq
         Bg+HRiJHY1VdUHuulnGRqoTE7KpTpvF/+U+EvBHGim2ctsPSxrn8x1aBCIqo/C4D7JZV
         Q3KaDtFPBtRI4WQACbZAYPgRSMavSv5wiTHj+eeg9ekDZTxt/sGYSY2RgmPFj6x3HV4F
         hBvSvjJ8H8++jlKkvp+UaOkoQU0NQNe0wmuqPr4nxo4JKcbJ6dZQHZRCSP+YQF3/6pG7
         2H8A==
X-Forwarded-Encrypted: i=1; AJvYcCUHb4isFLKDEmHjcDd1W8/M2G25DFYbWjiwYu0GDFBOerfUqoZFp6hnc/4cLXY0DgbHpsX3tl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznRVZqN1Iw17hh6A5v/6vMWAPCLCZJooyKq2e0uowTayskdlvZ
	MHZA8eiOY7zM+pPPCQGHxSvzmByFQt8WnMs+n6beeFXnJa4eNwLMRvak1f18AQ==
X-Gm-Gg: ASbGnctdKWjUl5qWU82TlZ0g+eMytidYQSvimSfvXzNP1/s72kVovrw9fpdSr4AFx3V
	deVVDongeNX3JyDxLtD7jbotLRpAwAFFfcCgTvzf4SpV0GWcW6rvAb/B1fbpa1lTPgFJhQlV1Jv
	ihcBBHymu8Wa78Tkq61CUwK+PpAW5vuzwN7eHdp6nTxBD0ziU3zNc6oc57RSN38KyM5xDCXm1lN
	nr43xploZLawUVWPI37t7zraVrPj/PcgX8fCR38PZtNmKwkYwvw3Y69DajiB5XO4xBlLk5Ye238
	fzyR5WNaJrdsmxdgDwvFOdJHbu5igq/lxk9msSLjg0hLv5881BmWbK2yu0nX5KEGERD75Rr5Sl4
	dFkUcC0ptkYkhkowQy1BbLDs=
X-Google-Smtp-Source: AGHT+IEnsNoQF16RD7P890faRI+OiIjExmXbubDG0P5JmtYe5XNAjpH0F4ps6IBBLeKOqFMDlO3YGg==
X-Received: by 2002:a05:620a:4015:b0:7c7:c772:7442 with SMTP id af79cd13be357-7cd4672dbd2mr99462585a.20.1747337158599;
        Thu, 15 May 2025 12:25:58 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd468ccbfcsm20857885a.107.2025.05.15.12.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:25:57 -0700 (PDT)
Date: Thu, 15 May 2025 15:25:57 -0400
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
Message-ID: <68263fc569b91_25ebe529448@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514165226.40410-9-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
 <20250514165226.40410-9-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 8/9] af_unix: Introduce SO_PASSRIGHTS.
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
> As long as recvmsg() or recvmmsg() is used with cmsg, it is not
> possible to avoid receiving file descriptors via SCM_RIGHTS.
> 
> This behaviour has occasionally been flagged as problematic, as
> it can be (ab)used to trigger DoS during close(), for example, by
> passing a FUSE-controlled fd or a hung NFS fd.
> 
> For instance, as noted on the uAPI Group page [0], an untrusted peer
> could send a file descriptor pointing to a hung NFS mount and then
> close it.  Once the receiver calls recvmsg() with msg_control, the
> descriptor is automatically installed, and then the responsibility
> for the final close() now falls on the receiver, which may result
> in blocking the process for a long time.
> 
> Regarding this, systemd calls cmsg_close_all() [1] after each
> recvmsg() to close() unwanted file descriptors sent via SCM_RIGHTS.
> 
> However, this cannot work around the issue at all, because the final
> fput() may still occur on the receiver's side once sendmsg() with
> SCM_RIGHTS succeeds.  Also, even filtering by LSM at recvmsg() does
> not work for the same reason.
> 
> Thus, we need a better way to refuse SCM_RIGHTS at sendmsg().
> 
> Let's introduce SO_PASSRIGHTS to disable SCM_RIGHTS.
> 
> Note that this option is enabled by default for backward
> compatibility.
> 
> Link: https://uapi-group.org/kernel-features/#disabling-reception-of-scm_rights-for-af_unix-sockets #[0]
> Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> v3: Return -EOPNOTSUPP for getsockopt()
> ---
>  arch/alpha/include/uapi/asm/socket.h    |  2 ++
>  arch/mips/include/uapi/asm/socket.h     |  2 ++
>  arch/parisc/include/uapi/asm/socket.h   |  2 ++
>  arch/sparc/include/uapi/asm/socket.h    |  2 ++
>  include/net/sock.h                      |  4 +++-
>  include/uapi/asm-generic/socket.h       |  2 ++
>  net/core/sock.c                         | 14 ++++++++++++++
>  net/unix/af_unix.c                      | 22 ++++++++++++++++++++--
>  tools/include/uapi/asm-generic/socket.h |  2 ++
>  9 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 3df5f2dd4c0f..8f1f18adcdb5 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -150,6 +150,8 @@
>  
>  #define SO_RCVPRIORITY		82
>  
> +#define SO_PASSRIGHTS		83
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
> index 22fa8f19924a..31ac655b7837 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -161,6 +161,8 @@
>  
>  #define SO_RCVPRIORITY		82
>  
> +#define SO_PASSRIGHTS		83
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
> index 96831c988606..1f2d5b7a7f5d 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -142,6 +142,8 @@
>  #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
>  #define SO_DEVMEM_DONTNEED	0x4050
>  
> +#define SO_PASSRIGHTS		0x4051
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
> index 5b464a568664..adcba7329386 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -143,6 +143,8 @@
>  
>  #define SO_RCVPRIORITY           0x005b
>  
> +#define SO_PASSRIGHTS            0x005c
> +
>  #if !defined(__KERNEL__)
>  
>  
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 77232a098934..17fb6b8c4b6e 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -341,6 +341,7 @@ struct sk_filter;
>    *	@sk_scm_credentials: flagged by SO_PASSCRED to recv SCM_CREDENTIALS
>    *	@sk_scm_security: flagged by SO_PASSSEC to recv SCM_SECURITY
>    *	@sk_scm_pidfd: flagged by SO_PASSPIDFD to recv SCM_PIDFD
> +  *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
>    *	@sk_scm_unused: unused flags for scm_recv()
>    *	@ns_tracker: tracker for netns reference
>    *	@sk_user_frags: xarray of pages the user is holding a reference on.
> @@ -534,7 +535,8 @@ struct sock {
>  		u8		sk_scm_credentials : 1,
>  				sk_scm_security : 1,
>  				sk_scm_pidfd : 1,
> -				sk_scm_unused : 5;
> +				sk_scm_rights : 1,
> +				sk_scm_unused : 4;
>  	};
>  	u8			sk_clockid;
>  	u8			sk_txtime_deadline_mode : 1,
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index aa5016ff3d91..f333a0ac4ee4 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -145,6 +145,8 @@
>  
>  #define SO_RCVPRIORITY		82
>  
> +#define SO_PASSRIGHTS		83
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 381abf8f25b7..0cb52e590094 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1571,6 +1571,13 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  			ret = -EOPNOTSUPP;
>  		break;
>  
> +	case SO_PASSRIGHTS:
> +		if (sk_is_unix(sk))
> +			sk->sk_scm_rights = valbool;
> +		else
> +			ret = -EOPNOTSUPP;
> +		break;
> +
>  	case SO_INCOMING_CPU:
>  		reuseport_update_incoming_cpu(sk, val);
>  		break;
> @@ -1879,6 +1886,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  		v.val = sk->sk_scm_pidfd;
>  		break;
>  
> +	case SO_PASSRIGHTS:
> +		if (!sk_is_unix(sk))
> +			return -EOPNOTSUPP;
> +
> +		v.val = sk->sk_scm_rights;

Same question about lockless reading of the field.

