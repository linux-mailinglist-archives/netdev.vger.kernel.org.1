Return-Path: <netdev+bounces-163748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F04A2B769
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D9C1885BFB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A6528E3F;
	Fri,  7 Feb 2025 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezG+KlXa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029617E4
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738889983; cv=none; b=E9kck8yZWghxqbi8wiLNyZO96ihtFN/Z5NVQB4W3OPo++tAqDcVJDCkoYntbnQWYuZ5PIyQLnNjCOOV9F6IhAznS9Xgu6JD2dbhDqlHfRCz2MC5j8xe3dC0+VqiZIL9i2esxX7iFznDBZjRO/AmSegq2f5TuhId4eBXCoiv9jmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738889983; c=relaxed/simple;
	bh=OugmG7W2CQqI086nir6poZo3UPlqtjeF4rKUIHC6qiA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hX8U40ljDVuFiKRy6uu4X9+PuPYQEHJI5DgLhLf24OEDgMYochj/f/J/Z36/Up7wBEQnJuVzh2CiHAG56MgM6ms7EhXMSfrNRbgFgDVQOfJi9zpKVaNpa53JUNDh8cTtib9TH7N2K2vwVo4zQVC7ZT6SdH5GyOHf3kHr28nHNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezG+KlXa; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467a63f5d1cso13393941cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 16:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738889981; x=1739494781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r99EwP0t4XCZkJ6lw2MEGnPJ22PpmjgOH6poGs/9toc=;
        b=ezG+KlXahNFiBpqTu5/g2dcZdYrPoVu5396Bd94bH0YABuSxymIvaFCFNv5eoFdAiM
         5i2o3rqbasJjHfv4eRnpKXIkU94uweKpr99OMTAEB29V5vv54Q+5G/s2QnIo4DbfMGNh
         5pCmAk8LOKa6hMdH2J1EZa49v954UCF57KnAl1DrWFNcw+gL7UNgWTKnX6Q2TzgYHjoM
         BC5Yi0OYky2W18H2PsPAL16xDmlWVyQZzVdgfvVxoAASocdRCodyE6pQxGoi3COQ8n5O
         EllBBzJ+PUiSbAguoIkt33PboKFa9g4CnkvaDYK67jinOFNLyNiFY7AXqmNH9rMKv1Wz
         q+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738889981; x=1739494781;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r99EwP0t4XCZkJ6lw2MEGnPJ22PpmjgOH6poGs/9toc=;
        b=Hdrau0bnSXBh3fRmXsc5TylvltTPl7bta0/tse7xwQlHghOrRnBX4rxTFSgWPLu/Bz
         UqL6oB8uQq30vmN7UI/kQdrebk2AdMdFht9oTPtdEuB1D9fn9Ol3GP+/aoGOKLvk+0ez
         4Eu6ePkwdxo/HpCx27/1mP7StudD4Qe6Mmh8RrYPrWLjrBKjwRQK9z6y/b0p8+UjXy3K
         0u1Hml0E8U6i9X1JN4IviGNnhNjTc9ds8l3bN+JF9jlhnkmWIfuJoHS+Oee0VeaeZ/Kd
         CVU1+fp2MSAa1XrKVlWqULSg9KfrANH/cifUI6/wpTUIqaONKrPOBuBauBiuD9pgPFW6
         gIEA==
X-Forwarded-Encrypted: i=1; AJvYcCXFv/YZH1N6J236hBnqM1dRoXbNMNEzSZT5RHMR7eF+nujGg+SlkbC5cZYpOo62Z02ophzjMv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZ7fPEKUW/rViYkmUZH/4cOccDzGZwYSeGJOsxfOafOw2ubNm
	W5GRmxdPZCYYANU2OQmDlRQL16im5H0T92xNYgc6UJmq9ooyFkK/
X-Gm-Gg: ASbGnctlI1RKWbXW0EfesU6TSW7x/zrivFI5Ssck6Foj+vsGmZCIrT4mT16iKUSU244
	Jy2yNgOX9VECV8uSXkHg8Uyxw7EurrTRnvuD2eu6+UvDSu6i5nZkyLPMWNxvADLca/TEpWoEWH6
	5SQMz+RqDaL4EYWheKC2TMIU3jK1wcWRORzxeQ+sSXBpUhFiKWrCFshaVhLBiZGMuqbVVl3ydIs
	4A6gr49TQsCffr0HK3pP+j5bebogbaBpiHfTRdfCa5LIbvGm2LvYVqknTH422fXimm4RjMzkXzt
	c5zTcKbaPNHDwZv2GWEjriARMClzNJJfxnm3To4//JIazlkRza3gCw7iiLXc8aQ=
X-Google-Smtp-Source: AGHT+IE9jttpEsaQChD2qoOSIhMAtJ7b9Or1HcMplPvtzWj/12Uj7B586FeYFbFwu8Dx6aE6RQ5nQA==
X-Received: by 2002:a05:622a:199c:b0:467:674d:237f with SMTP id d75a77b69052e-4716798aa31mr21645661cf.11.1738889980711;
        Thu, 06 Feb 2025 16:59:40 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bec10esm10890071cf.74.2025.02.06.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 16:59:39 -0800 (PST)
Date: Thu, 06 Feb 2025 19:59:39 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67a55afb822cc_25109e294cc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250206193521.2285488-5-willemdebruijn.kernel@gmail.com>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
 <20250206193521.2285488-5-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 4/7] ipv4: remove get_rttos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Initialize the ip cookie tos field when initializing the cookie, in
> ipcm_init_sk.
> 
> The existing code inverts the standard pattern for initializing cookie
> fields. Default is to initialize the field from the sk, then possibly
> overwrite that when parsing cmsgs (the unlikely case).
> 
> This field inverts that, setting the field to an illegal value and
> after cmsg parsing checking whether the value is still illegal and
> thus should be overridden.
> 
> Be careful to always apply mask INET_DSCP_MASK, as before.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  include/net/ip.h       | 11 +++--------
>  net/ipv4/ip_sockglue.c |  4 ++--
>  net/ipv4/ping.c        |  1 -
>  net/ipv4/raw.c         |  1 -
>  net/ipv4/udp.c         |  1 -
>  5 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 6af16545b3e3..6819704e2642 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -92,7 +92,9 @@ static inline void ipcm_init(struct ipcm_cookie *ipcm)
>  static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
>  				const struct inet_sock *inet)
>  {
> -	ipcm_init(ipcm);
> +	*ipcm = (struct ipcm_cookie) {
> +		.tos = READ_ONCE(inet->tos) & INET_DSCP_MASK,
> +	};
>  
>  	sockcm_init(&ipcm->sockc, &inet->sk);
>  
> @@ -256,13 +258,6 @@ static inline u8 ip_sendmsg_scope(const struct inet_sock *inet,
>  	return RT_SCOPE_UNIVERSE;
>  }
>  
> -static inline __u8 get_rttos(struct ipcm_cookie* ipc, struct inet_sock *inet)
> -{
> -	u8 dsfield = ipc->tos != -1 ? ipc->tos : READ_ONCE(inet->tos);
> -
> -	return dsfield & INET_DSCP_MASK;
> -}
> -
>  /* datagram.c */
>  int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
>  int ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 6d9c5c20b1c4..98b1e4a8b72e 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -314,8 +314,8 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
>  				return -EINVAL;
>  			if (val < 0 || val > 255)
>  				return -EINVAL;
> -			ipc->tos = val;
> -			ipc->sockc.priority = rt_tos2priority(ipc->tos);
> +			ipc->sockc.priority = rt_tos2priority(val);
> +			ipc->tos = val & INET_DSCP_MASK;
>  			break;
>  		case IP_PROTOCOL:
>  			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
> diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> index 619ddc087957..0215885c6df5 100644
> --- a/net/ipv4/ping.c
> +++ b/net/ipv4/ping.c
> @@ -768,7 +768,6 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		}
>  		faddr = ipc.opt->opt.faddr;
>  	}
> -	tos = get_rttos(&ipc, inet);

Here and elsewhere, subsequent code needs to use ipc.tos directly.

