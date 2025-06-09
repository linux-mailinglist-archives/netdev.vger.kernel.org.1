Return-Path: <netdev+bounces-195668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7226AD1C57
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 13:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0CD97A3BCE
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF22561A3;
	Mon,  9 Jun 2025 11:14:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E92512C8
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467697; cv=none; b=Sk+tsCybGAElOdbqBKgxwgfALa4RqdYPb6T+qh/vVraSj0fiK/6fDXqR7Kh1uJW9jyrvjWHWTKYlyA+JUCb0UyjUtOW6IHWIVaTx5RDfNre2ZvJ04tleZhQ4DMH9a+i3Dw2PTcKnh0GJh2hUuNSjJXzaiq2E7PGNMdaMbYgPYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467697; c=relaxed/simple;
	bh=zBZZBv3kiAof1BRfN9yLp66ggaF/N4q4s9NBKIUWvUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g2mEgKi8LpzDOQ8hqC30+7Och153QU1LfpfPTl0QMi6X61fxU8JMckvLv0z6oW/5/BcScJKHdH6++kodZbhFWkVmPdy5lxshkO57TaarGs9NXsC3KinwO27RpOqpgpg/dbCa2O1IeNCj6JOHVyXcyNqsaTb1j4GqjIEPXfkn31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a5096158dcso3628096f8f.1
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 04:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749467693; x=1750072493;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ODqCSbhS9L36ZfK3yjuZV+/ACT6Glc+OYY/zYpy8/M=;
        b=kt1mSKfI9wjI0vtWtXcj7zReok/tModzae4IEYPN6cZZC9SgTPp6HnVKqIGvtucs/u
         /LY0omABrk0UUUVAQDFzE2lIlVPaIRRRsSJZzzE7glD8iTm0qH3NQ49VktA9/bkJGI9G
         +Ib+ECnD56cGfygHV8YAmiq9U6BrbbEyn7kDJMy6Q9ZFxV6Va148AdgKEzWYPz0CZpNv
         kL55BC9V5ecfvGalrrY511x3doi8RCSEE2xM26CcljskP3wILVj/9isroidJ9Is6DRMD
         3FQ6udBNEMoKlquHaQZ4rnQ8SNbu0QbE7OZmT3cRaJ2ue5qwMKqfMJO6MbH7P8RDqvm8
         oO3w==
X-Forwarded-Encrypted: i=1; AJvYcCWYSAjmnaBlnoWt/9gT7vfnT4iP9meOf09C3bnUVBDuUnGtoV5srUC1y92cjA+5PhjFrLNa0YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMSDjEbl9j7wEYTb9aw70+Z+TqzoDC8I0gqHVpAQkf2tBCbgm
	wkI2l+f/nUiospHHmkPK5gWVLHoPhyFxq7F+af1uiBNT43h2NN9A+tZ3
X-Gm-Gg: ASbGncsy1T2+GR13M5GGW7pm0vi804ijgT0zP6XgtQtSLMRyhhmYh8FXQfCwV92lsmt
	JpiwyXmixo3HN1SWfiev2+QTP+5lDByzSVE90N+4Czy5OAK9xHtpninQgV3GlSw0jCdfpAgEmD1
	Q3WlQNZEusbm8/L/PtJZ1bh4f5MCfWfKYDyeGEGyUhuJTJQGjEQNfDQvKkD0R/dK3VQzfUT2Lk5
	auCBtoS9g7/fVzbOK7bC3KSJcoEYsi9/jRBY46qqzl5aTdvz+0I/AJ+pfeZFg2XA5xnO9QGT00D
	TP3ajaHBG1XbQlbrOZcQUG+Y9FWzf5mxBnN1CtG60NdU1KBm
X-Google-Smtp-Source: AGHT+IHnErBKoy+I6UBItF8jT7xenLuavKGxv/50j/OXxIaq36n954q2YDb8dMvdV3bKPZAEnLRYpg==
X-Received: by 2002:a05:6000:240e:b0:3a4:fc07:f453 with SMTP id ffacd0b85a97d-3a5319b6a11mr9129898f8f.8.1749467693049;
        Mon, 09 Jun 2025 04:14:53 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8929:4a70:c3cf:f767])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a532468360sm9192260f8f.100.2025.06.09.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 04:14:52 -0700 (PDT)
Message-ID: <eb38a7d139a9c0854e2ed7122ee5ea5153227b41.camel@debian.org>
Subject: Re: [PATCH v5 net-next 5/9] net: Restrict SO_PASS{CRED,PIDFD,SEC}
 to AF_{UNIX,NETLINK,BLUETOOTH}.
From: Luca Boccassi <bluca@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
	 <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
  Kuniyuki Iwashima	 <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Mon, 09 Jun 2025 12:14:51 +0100
In-Reply-To: <20250519205820.66184-6-kuniyu@amazon.com>
References: <20250519205820.66184-1-kuniyu@amazon.com>
	 <20250519205820.66184-6-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 13:57 -0700, Kuniyuki Iwashima wrote:
> SCM_CREDENTIALS and SCM_SECURITY can be recv()ed by calling
> scm_recv() or scm_recv_unix(), and SCM_PIDFD is only used by
> scm_recv_unix().
>=20
> scm_recv() is called from AF_NETLINK and AF_BLUETOOTH.
>=20
> scm_recv_unix() is literally called from AF_UNIX.
>=20
> Let's restrict SO_PASSCRED and SO_PASSSEC to such sockets and
> SO_PASSPIDFD to AF_UNIX only.
>=20
> Later, SOCK_PASS{CRED,PIDFD,SEC} will be moved to struct sock
> and united with another field.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
> v3:
> =C2=A0 * Return -EOPNOTSUPP in getsockopt() too
> =C2=A0 * Add CONFIG_SECURITY_NETWORK check for SO_PASSSEC
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index d7d6d3a8efe5..fd5f9d3873c1 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1221,12 +1221,21 @@ int sk_setsockopt(struct sock *sk, int level,
> int optname,
> =C2=A0		}
> =C2=A0		return -EPERM;
> =C2=A0	case SO_PASSSEC:
> +		if (!IS_ENABLED(CONFIG_SECURITY_NETWORK) ||
> sk_may_scm_recv(sk))
> +			return -EOPNOTSUPP;

Hi,

Was this one meant to be !sk_may_scm_recv(sk) like in getsockopt below
by any chance?

We have a report that this is breaking AF_UNIX sockets with 6.16~rc1:

[    1.763019] systemd[1]: systemd-journald-dev-log.socket: SO_PASSSEC
failed: Operation not supported
[    1.763102] systemd[1]: systemd-journald.socket: SO_PASSSEC failed:
Operation not supported
[    1.763121] systemd[1]: systemd-journald.socket: SO_PASSSEC failed:
Operation not supported

https://github.com/systemd/systemd/issues/37783

> @@ -1956,6 +1971,9 @@ int sk_getsockopt(struct sock *sk, int level,
> int optname,
> =C2=A0		break;
> =C2=A0
> =C2=A0	case SO_PASSSEC:
> +		if (!IS_ENABLED(CONFIG_SECURITY_NETWORK) ||
> !sk_may_scm_recv(sk))
> +			return -EOPNOTSUPP;
> +
> =C2=A0		v.val =3D !!test_bit(SOCK_PASSSEC, &sock->flags);
> =C2=A0		break;
> =C2=A0

