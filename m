Return-Path: <netdev+bounces-164111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7F3A2CA36
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172793A110D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D941885A1;
	Fri,  7 Feb 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMcpqH3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3915E5B8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949584; cv=none; b=CgOYAn2Dd+WHF3dxu6e19J7ttVints0fk14JWmhpeFGuGXgg2/XLN0/WVjldB879FHdDLRX1CUoTZEuSl7jxPJsl37pglfQ0r5VctIIbupCV9P9QO+WtRwyE55ROY3GvjRt6y/Akh/5CqRcjGMEa3lpdP+bB/oshJ/BIHABG1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949584; c=relaxed/simple;
	bh=cKEqUb8E/dm3JqDoluKkF7uJ6WOXqwJncWIdLXdarYg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WbbJiiFc97jZa9bLketFO0cZJOxzvxHFUWypTg2+hAuMQmYCy1HBGmTHcIbiCnWPBtmjvrJE//QWWXYbA0bGZ2tEMfd/lLQztkfOCsH9xfDLXGnV3vOgGItlihPjXFSOR0D8CMPpEM6vvFjkwE13NaCVT8wTx6oPqHHrKhdAcr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMcpqH3Q; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e41e18137bso20595486d6.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738949582; x=1739554382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOZQ6FzeNn5UP+LNZcRFn7cpfwanmQMk0JsuQ+dl1kg=;
        b=BMcpqH3QhKGyz4eSUzPSm8PYEb89gCQP4EnBRh7C2npn4hGnEcOVC64SR0PCIBGpyw
         r6Bc0f8tYXBDmolKiZeTSbFR64J5SA4X8u2zpALVPfmso1/f5lem28Eujwc4rR8PlcZA
         hL2qX1rgZmiUP1qlybNetBrIKdVX/rS5AJV3fBxERWczh3UzsplzC0MqGdL6MamyVbwn
         OksIMMdvMDnR0bSNZ5ze4nktPvCggXKTtHT/0tj6T1emv0w4Nh/4b1fpm7BJfMGmLwHF
         rm1ZtsrprYRLF8R4OHY14ZG1IjHYokwMjTEe1kV3P8KsssalvlEkvHKM/xqoeEb4TKqn
         6RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949582; x=1739554382;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UOZQ6FzeNn5UP+LNZcRFn7cpfwanmQMk0JsuQ+dl1kg=;
        b=K6wr2goikIrs2vhBvwM0MPUX+XRYpEDQUB1g2LCi4jJ3/cyQYcDKRQeMrgLaq2Zzfe
         lFuLyQXGt0k0Ru2miWtBLzlhiy6NidGapNi7CRK1JiWQ9iTjc5riXv7oynxf3kSkROtL
         PlS5izacL2fo+mePEogd48Htcxy0aS6+nr7tAoSWgKjONPmA4Ca2iI5QvISlZEjMGihV
         wUQrj1NddhpMPQ5XhCQDJcohZ3hs79UHXF4WuPMnYmcqAQk+g/VxcLalfpZbs9Zx1HDW
         LCPcJnC2v3VISGvfKrXrUz4wZA1wIaXWm03Pr86wkipqqpTQLzEXJDlynjG6nW27JKu+
         SjbA==
X-Forwarded-Encrypted: i=1; AJvYcCV21SH4M41HEPMR/t26hg6S08WB2iki+7TZmXLgD/BzqUxwKN9nX6WZR01Rw+x9tWsA5aO+Br8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsIRi+qIGFq9+SBzxFkKrNagnS8EB15Vo94LiOv5hIKQ+t2n9
	qqAaGDPeH80HeRQXzOV7r9PtfOcm0t/YjDr+AL3tQ2KGQ8lNLwfj
X-Gm-Gg: ASbGncsc+MdFD4K8wVNs7fr19jiNAAN3wnyNTNNiniZ8eKLxAREV5uXieCG3pK50h6k
	29kVSu2+rjtl00EsjCiaeik/dSqRHIY1WPsyvna/ZfVGYmDoPp5I82UV7+pQp7n0iOQx3Wm2q5W
	fLvydqpwAxVWn/wYgBC1j2scfwlK0VfVE4O/jICiw/ITZt/3yUjGyqaelRacciLnoeX8DNrgeGX
	LZGKEL+/6bHlTzJtJ3d4ychNH5pq4yLZ1DtnSAyqWwGx4tLaOuKcvFYmx5aXIPSo+e+2/OWWqAo
	R8cdKnsjmfrOT4ptYv5SqUTXXXjvRXAkh9okkT5aH3sJzVWbNl4YBcLMUjHo27M=
X-Google-Smtp-Source: AGHT+IGQKD30JLRXtNStRt8a0vwToJno+70jF7Tu7JJglRYLiOFM+Hmu+Pf/czSanB2yyabEJUIVhw==
X-Received: by 2002:ad4:5f0e:0:b0:6d4:211c:dff0 with SMTP id 6a1803df08f44-6e4456d9d9dmr51160396d6.29.1738949581985;
        Fri, 07 Feb 2025 09:33:01 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43e6b3c32sm16506636d6.124.2025.02.07.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:33:01 -0800 (PST)
Date: Fri, 07 Feb 2025 12:33:01 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67a643cde07d_2b3e7e2943@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a55afb822cc_25109e294cc@willemb.c.googlers.com.notmuch>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
 <20250206193521.2285488-5-willemdebruijn.kernel@gmail.com>
 <67a55afb822cc_25109e294cc@willemb.c.googlers.com.notmuch>
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
> Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Initialize the ip cookie tos field when initializing the cookie, in
> > ipcm_init_sk.
> > 
> > The existing code inverts the standard pattern for initializing cookie
> > fields. Default is to initialize the field from the sk, then possibly
> > overwrite that when parsing cmsgs (the unlikely case).
> > 
> > This field inverts that, setting the field to an illegal value and
> > after cmsg parsing checking whether the value is still illegal and
> > thus should be overridden.
> > 
> > Be careful to always apply mask INET_DSCP_MASK, as before.
> > 
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > ---
> >  include/net/ip.h       | 11 +++--------
> >  net/ipv4/ip_sockglue.c |  4 ++--
> >  net/ipv4/ping.c        |  1 -
> >  net/ipv4/raw.c         |  1 -
> >  net/ipv4/udp.c         |  1 -
> >  5 files changed, 5 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/net/ip.h b/include/net/ip.h
> > index 6af16545b3e3..6819704e2642 100644
> > --- a/include/net/ip.h
> > +++ b/include/net/ip.h
> > @@ -92,7 +92,9 @@ static inline void ipcm_init(struct ipcm_cookie *ipcm)
> >  static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
> >  				const struct inet_sock *inet)
> >  {
> > -	ipcm_init(ipcm);
> > +	*ipcm = (struct ipcm_cookie) {
> > +		.tos = READ_ONCE(inet->tos) & INET_DSCP_MASK,
> > +	};
> >  
> >  	sockcm_init(&ipcm->sockc, &inet->sk);
> >  
> > @@ -256,13 +258,6 @@ static inline u8 ip_sendmsg_scope(const struct inet_sock *inet,
> >  	return RT_SCOPE_UNIVERSE;
> >  }
> >  
> > -static inline __u8 get_rttos(struct ipcm_cookie* ipc, struct inet_sock *inet)
> > -{
> > -	u8 dsfield = ipc->tos != -1 ? ipc->tos : READ_ONCE(inet->tos);
> > -
> > -	return dsfield & INET_DSCP_MASK;
> > -}
> > -
> >  /* datagram.c */
> >  int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
> >  int ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
> > diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> > index 6d9c5c20b1c4..98b1e4a8b72e 100644
> > --- a/net/ipv4/ip_sockglue.c
> > +++ b/net/ipv4/ip_sockglue.c
> > @@ -314,8 +314,8 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
> >  				return -EINVAL;
> >  			if (val < 0 || val > 255)
> >  				return -EINVAL;
> > -			ipc->tos = val;
> > -			ipc->sockc.priority = rt_tos2priority(ipc->tos);
> > +			ipc->sockc.priority = rt_tos2priority(val);
> > +			ipc->tos = val & INET_DSCP_MASK;
> >  			break;
> >  		case IP_PROTOCOL:
> >  			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
> > diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> > index 619ddc087957..0215885c6df5 100644
> > --- a/net/ipv4/ping.c
> > +++ b/net/ipv4/ping.c
> > @@ -768,7 +768,6 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >  		}
> >  		faddr = ipc.opt->opt.faddr;
> >  	}
> > -	tos = get_rttos(&ipc, inet);
> 
> Here and elsewhere, subsequent code needs to use ipc.tos directly.

Actually I misunderstood the purpose of get_rttos.

It only masks the dsfield when passed to the routing layer, with
flowi4_init_output().

The other purpose of ipc->tos, to initialize iph->tos, takes the
unmasked version including ECN bits.


