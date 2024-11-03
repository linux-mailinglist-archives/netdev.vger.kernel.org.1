Return-Path: <netdev+bounces-141254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FAC9BA373
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 02:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81831C20DC7
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 01:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2772628D;
	Sun,  3 Nov 2024 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adKR8U/j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904C2F3B
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730597273; cv=none; b=mF6WYug7I6mqG2S0lqw0LYT7qi2VViSXbSoZ79ds81dCTHs1hQKlrEVyN3706MvGmrABz0hgo801WSpGwpzqtJ2rNR6YicwlJ06NR9X14ZHnHF0H5quNjkPFre0mA4GQTr6NND/4yyDoImnsZWUFF2a3HIB2lfvDUlWnwfGA860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730597273; c=relaxed/simple;
	bh=+3WgNxon/utMTnbShjAGvjrrum7/lhyaAJuh/Xfw9lc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UwSU3ASFTbo33kIydOWSRATckcwClYs4ZVQQlwgidkNdqlK8iCZB8307e/BRtzvMuNk4eNr/bguXjuJzUvKcWKSZytgKbuVG+LLJK3kNTZAigenF/F3a0iP/YsKlrj1CHzixwAsuqg8MZNd4t4aEIzLq5TDR4t/rRtyRHWpSfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adKR8U/j; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cc03b649f2so23209316d6.3
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 18:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730597271; x=1731202071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nihCQje3KhptOm1kiceAz4JNzxjNlnjPyCBWMmHlV/8=;
        b=adKR8U/jTrPBk6KM9U1EK67kP8RIol1ubD0gPp3SU0yfkhTa7e6cZZFqqzHnRkJkeb
         eRHvyXkvvJaUNuZehEhxELOiCZvvEFVPGdh+agZySFBvOm/yiuLgAfPcArx+H/yljLED
         PXdlfTNG91kgtVai4s5rawSPSMwsl9alWYHMqbfgxdnwNCLjcO22h2DSlgiubtbXSlOc
         Q29pDyzkMvVQvbGfBBS5vo2MK3MwLdp23p4Mm7RzTs3MZU+Cl3gD2pnDgsvM9jdWMh/4
         4vacr9sD/TN7ew41vXrhZXAQj7pT59E6Gzn5/ibZI32X3mDYPz7ORSHkD4/U+37gOvp+
         Oy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730597271; x=1731202071;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nihCQje3KhptOm1kiceAz4JNzxjNlnjPyCBWMmHlV/8=;
        b=JbiQ/3xPTgPP3xLqSUtB7mhhXaZQMQZEbTBay395rpWL5PEgCXRoiV73fUdtIyaKUW
         0k9zTQ+R3NFmNp/AfHPbPgEq4ZOsuqt5xKJDkoh0xBhBs00+PF5+oFn4kDeb91WOxUoq
         5sWm7J1s9F7Z6Spuw8PyyB9fFaFqUgVPUlgSE6L4eXbbaQOy+0fKZd1IIr1N/pO+Cx/J
         Zc1GDCO8sjrfP0Jm1+kMN1NfgeM8HnqOTpios539cH9heKu7GfVS+/MG7IqaziXBp0Ma
         JOdWdnnlR89VXQ6aa3F1ZHmCsZHME5yTC4I4il0vunDulgCbvBM8pqqy/YvUvNe6kFIS
         e8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWhGOD2kAguk6f0M41mWhJ/M7CyFdLe5GY2ilkPUHvYtTWztW4WCAM6SFf3IxviOERO0tcH4jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4DaNOmsWjdFzYu5HydJI54iUZjKKW9bEWqyKxxKhuYYgCpWRx
	IPajqRLhT1Xg1NS39lcPFIftT6Js+/QQObzxi75FBDvpgJc+Ge4u
X-Google-Smtp-Source: AGHT+IGBmkYCmGFkBTJrWlEgkm6kF0QJUknfmDYPryoY2AeCFQGQ6XIftBG3JMvoNR1O4lJBByBpYg==
X-Received: by 2002:a05:6214:5783:b0:6d3:46a8:8f02 with SMTP id 6a1803df08f44-6d351a930abmr182825036d6.5.1730597270717;
        Sat, 02 Nov 2024 18:27:50 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415a62asm34375126d6.80.2024.11.02.18.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 18:27:49 -0700 (PDT)
Date: Sat, 02 Nov 2024 21:27:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 annaemesenyiri@gmail.com, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com
Message-ID: <6726d1954a48f_2980c729499@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241102125136.5030-3-annaemesenyiri@gmail.com>
References: <20241102125136.5030-1-annaemesenyiri@gmail.com>
 <20241102125136.5030-3-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] support SO_PRIORITY cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> The Linux socket API currently supports setting SO_PRIORITY at the
> socket level, which applies a uniform priority to all packets sent
> through that socket. The only exception is IP_TOS; if specified as
> ancillary data, the packet does not inherit the socket's priority.
> Instead, the priority value is computed when handling the ancillary
> data (as implemented in commit <f02db315b8d88>

nit: drop the brackets

> ("ipv4: IP_TOS and IP_TTL can be specified as ancillary data")). If
> the priority is set via IP_TOS, then skb->priority derives its value
> from the rt_tos2priority function, which calculates the priority
> based on the value of ipc->tos obtained from IP_TOS. However, if
> IP_TOS is not used and the priority has been set through a control
> message, skb->priority will take the value provided by that control
> message.

The above describes the new situation? There is no way to set
priority to a control message prior to this patch.

> Therefore, when both options are available, the primary
> source for skb->priority is the value set via IP_TOS.
> 
> Currently, there is no option to set the priority directly from
> userspace on a per-packet basis. The following changes allow
> SO_PRIORITY to be set through control messages (CMSG), giving
> userspace applications more granular control over packet priorities.
> 
> This patch enables setting skb->priority using CMSG. If SO_PRIORITY

Duplicate statement. Overall, the explanation can perhaps be
condensed and made more clear.

> is specified as ancillary data, the packet is sent with the priority
> value set through sockc->priority_cmsg_value, overriding the

No longer matches the code.

> socket-level values set via the traditional setsockopt() method. This
> is analogous to existing support for SO_MARK (as implemented in commit
> <c6af0c227a22> ("ip: support SO_MARK cmsg")).
> 
> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> ---
>  include/net/inet_sock.h | 2 +-
>  include/net/ip.h        | 3 ++-
>  include/net/sock.h      | 4 +++-
>  net/can/raw.c           | 2 +-
>  net/core/sock.c         | 8 ++++++++
>  net/ipv4/ip_output.c    | 7 +++++--
>  net/ipv4/raw.c          | 2 +-
>  net/ipv6/ip6_output.c   | 3 ++-
>  net/ipv6/raw.c          | 2 +-
>  net/packet/af_packet.c  | 2 +-
>  10 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 56d8bc5593d3..3ccbad881d74 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -172,7 +172,7 @@ struct inet_cork {
>  	u8			tx_flags;
>  	__u8			ttl;
>  	__s16			tos;
> -	char			priority;
> +	u32			priority;

Let's check with pahole how this affects struct size and holes.
It likely adds a hole, but unavoidably so.

>  	__u16			gso_size;
>  	u32			ts_opt_id;
>  	u64			transmit_time;
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 0e548c1f2a0e..e8f71a191277 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -81,7 +81,7 @@ struct ipcm_cookie {
>  	__u8			protocol;
>  	__u8			ttl;
>  	__s16			tos;
> -	char			priority;
> +	u32			priority;

No need for a field in ipcm_cookie, when also present in
sockcm_cookie. As SO_PRIORITY is not limited to IP, sockcm_cookie is
the right location.

If cmsg IP_TOS is present, that can overridde ipc->sockc.priority with
rt_tos2priority.

Interesting that this override by IP_TOS seems to be IPV4 only. There
is no equivalent call to rt_tos2priority when setting IPV6_TCLASS.

>  	__u16			gso_size;
>  };
>  
> @@ -96,6 +96,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
>  	ipcm_init(ipcm);
>  
>  	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
> +	ipcm->sockc.priority = READ_ONCE(inet->sk.sk_priority);
>  	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags);
>  	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
>  	ipcm->addr = inet->inet_saddr;
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7464e9f9f47c..316a34d6c48b 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1814,13 +1814,15 @@ struct sockcm_cookie {
>  	u32 mark;
>  	u32 tsflags;
>  	u32 ts_opt_id;
> +	u32 priority;
>  };
>  
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
>  			       const struct sock *sk)
>  {
>  	*sockc = (struct sockcm_cookie) {
> -		.tsflags = READ_ONCE(sk->sk_tsflags)
> +		.tsflags = READ_ONCE(sk->sk_tsflags),
> +		.priority = READ_ONCE(sk->sk_priority),
>  	};
>  }
>  
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 255c0a8f39d6..46e8ed9d64da 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -962,7 +962,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  	}
>  
>  	skb->dev = dev;
> -	skb->priority = READ_ONCE(sk->sk_priority);
> +	skb->priority = sockc.priority;
>  	skb->mark = READ_ONCE(sk->sk_mark);
>  	skb->tstamp = sockc.transmit_time;
>  
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5ecf6f1a470c..d5586b9212dd 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2941,6 +2941,14 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
>  		break;
> +	case SO_PRIORITY:
> +		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
> +			return -EINVAL;
> +		if (sk_set_prio_allowed(sk, *(u32 *)CMSG_DATA(cmsg))) {
> +			sockc->priority = *(u32 *)CMSG_DATA(cmsg);
> +			break;
> +		}
> +		return -EPERM;

nit: invert to make the error case the (speculated as unlikely) branch
and have the common path unindented.

>  	default:
>  		return -EINVAL;
>  	}

