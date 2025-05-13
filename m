Return-Path: <netdev+bounces-189959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB5AB499A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36143463FE2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12F11DF977;
	Tue, 13 May 2025 02:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaMmp/1T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7011DED5C
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104149; cv=none; b=QOXC2+T7p/JfJLW2c2QTqF8sYeF4QVVuj8bM2Inuy8UgzF7aMYq1lzmzrcq7VcnGJDsSFtPNUFfPqjJlC7AoutKsOL/KqIMsRu0v6OXIvk3ZfzbDDANGRQLmNfmVAfHyHCjWEkG1B2R0x+K0QF7Fk3lAFrZejLlTx0KZs0n/4FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104149; c=relaxed/simple;
	bh=5Yq2DtRO+e08Qxu0LOk0h0fJFDrD6uH0QCaCGqAPRd0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UvHK+ztbOsl7vYTiZhp45itatRGyYh6xF7R8pUsGStyik5sd1G8oFWhliLc1FhFECsWrQ1oxwwbV3lO9UlWpOmRrYVMCSYjzFY02JIVdpoO92dpUSE1XbtVM7r0g7f2/dCi/iuDd9KiomBWif7uf+Wd8C1ebxK+Lf+ij08+i0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaMmp/1T; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476ab588f32so79840391cf.2
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747104147; x=1747708947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ueDwdmDxWBpIpw8Nkxwp15H/BOJ5oIQZBd4yi8Os1Y=;
        b=MaMmp/1Twk03omKWW8le3jPUdS030DfKkKzPHx4u3uFMygeSFQg4/5qLsMeIrU4x/K
         p65b2XYzaILDRLgIJEpLlXN6qwhnETlpoMYMZb3GBB9sy98Tmy3x1//hWjvhlzuEvWN5
         AkmKftwJnT718tbDi2gyHGm/6iJIgoYmoHUdITpe0KBOS0Ingfb1nhd0TZCoHGMRFbJO
         uwuk3XQJZbpvFs0wQ3/x+ztjCTNnuJU9qydKjwjg5yKvDAFGCl8FcMj09pfNIGgiZz7E
         oO0MEbtkETj9Qmv3nToAT1Sve3WEMGT9xdMGJVyTzEVS86KVaxnSG/uP70LGITUnShTZ
         PK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747104147; x=1747708947;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ueDwdmDxWBpIpw8Nkxwp15H/BOJ5oIQZBd4yi8Os1Y=;
        b=HDNeDtbxL4jcROqyMQobx19fdWOrgJAUc+hG+JRqwDRcYGgSJwOXazA4DzQKjAKU/Z
         uoevIVnSlskGfZ5tUnSFLmac34AGlA3vAzPGZy2KGDHZuth0AcpbNdZZZp+67u/IytB9
         o6m9lxbjMyFQ6AF1yKKDRWurMmP7qHt8T7Z/6I6UVxkphZ45Llawcui/Q8NVqFR68Hry
         lqNoXm279EFARIv15Q+dU5Y3maDAmhJwW5NFLb5MJeY4BXv3+ObrKGHyKtJnt+1G/VFX
         q1bkucFxbf9DVDFi+lKzCHUxykfA3CeuZ4rIVmms3/UIxHG9BCAZX5zGwwc/n/2ErcPa
         D23A==
X-Forwarded-Encrypted: i=1; AJvYcCXVLy+L4eYsfngSP2ok/v8h2nP4tCMQpfRVVdzTH7iFYT6/8VodWY+d8ndUp2xTOQLGob7+QFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4u2NkldmojXbwod8UQbyXRxux6yVwIHGdePaYXvqNFU6em3TW
	HhJvKGpDZnEd7WHJXc8u3VU3YoS7aSg55hH0Yh014NmPnd6BCCfc
X-Gm-Gg: ASbGncuYB50CwkpTMl8jf0aOzweDQdrQNmWJ42GDLbbpUl+p/y7O/U1VEB5657PX6lE
	sZEsHydEgEJlDr9NL6MS74GZA4iGWBsY7mxennQxkA8oSF1lthV2nfXlMcRcQPVhNYOAyVsQ1XN
	aUtFRIrXEXcHpqgn2bA4QtIONJo3Y98sbYDkQXanG0OJmWSGKopoR5wZBgGuJWxL441RRmABvXA
	gxHFdSEtNh1faD7iHdWK40D3KMBM+2mDg6VfauVHUEortEsXZb/nO4YTzPNiYtx3sBsqBClC6UG
	Rq6I9iG/x5r4yE1H4YBe6HvmMSRK+iqkBhrOzMmRQuhOQLA8Gjd7LmwoleZl4WVpEvw0XvQMwHg
	pXZuDjZYH5NQy6PFRu4nKLL8taoDjacYrCw==
X-Google-Smtp-Source: AGHT+IF7L0XdwsYPEGwonJUbGvLlgr7cGg0wipTa6JfbRsFApQzwmyvgSxRszhHar/kXzzUQ+LCDHw==
X-Received: by 2002:ac8:57c8:0:b0:48e:9b77:38a4 with SMTP id d75a77b69052e-4945274cc76mr201794991cf.26.1747104146764;
        Mon, 12 May 2025 19:42:26 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4945259fa2bsm58645951cf.76.2025.05.12.19.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 19:42:26 -0700 (PDT)
Date: Mon, 12 May 2025 22:42:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: brauner@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com
Message-ID: <6822b191d0399_104f1029490@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250512221414.56633-1-kuniyu@amazon.com>
References: <68224974de7ed_e985e294b5@willemb.c.googlers.com.notmuch>
 <20250512221414.56633-1-kuniyu@amazon.com>
Subject: Re: [PATCH v2 net-next 4/9] tcp: Restrict SO_TXREHASH to TCP socket.
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
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Mon, 12 May 2025 15:18:12 -0400
> > Kuniyuki Iwashima wrote:
> > > sk->sk_txrehash is only used for TCP.
> > > 
> > > Let's restrict SO_TXREHASH to TCP to reflect this.
> > > 
> > > Later, we will make sk_txrehash a part of the union for other
> > > protocol families, so we set 0 explicitly in getsockopt().
> > > 
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/core/sock.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index b64df2463300..5c84a608ddd7 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -1276,6 +1276,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
> > >  		return 0;
> > >  		}
> > >  	case SO_TXREHASH:
> > > +		if (!sk_is_tcp(sk))
> > > +			return -EOPNOTSUPP;
> > >  		if (val < -1 || val > 1)
> > >  			return -EINVAL;
> > >  		if ((u8)val == SOCK_TXREHASH_DEFAULT)
> > > @@ -2102,8 +2104,11 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
> > >  		break;
> > >  
> > >  	case SO_TXREHASH:
> > > -		/* Paired with WRITE_ONCE() in sk_setsockopt() */
> > > -		v.val = READ_ONCE(sk->sk_txrehash);
> > > +		if (sk_is_tcp(sk))
> > > +			/* Paired with WRITE_ONCE() in sk_setsockopt() */
> > > +			v.val = READ_ONCE(sk->sk_txrehash);
> > > +		else
> > > +			v.val = 0;
> > 
> > Here and in the following getsockopt calls: should the call fail with
> > EOPNOTSUPP rather than return a value that is legal where the option
> > is supported (in TCP).
> 
> I was wondering which is better but didn't have preference, so will
> return -EOPNOTSUPP in v3.

It's a reminder that this is breaking an existing API.

It is unlikely to affect any real users in this case, as SO_TXREHASH
never was function for Unix sockets. But for this and subsequent such
changes we have to be aware that it is in principle a user visible
change.


