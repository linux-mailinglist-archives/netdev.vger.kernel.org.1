Return-Path: <netdev+bounces-230887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B7BF1209
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9C624E8920
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6A2E9737;
	Mon, 20 Oct 2025 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="P1+Bz7Ll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3D2ED872
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962927; cv=none; b=Hggx3Q0ntUIG6s0stojeucZKbSzj0/eIga3l78h4q5v3ptyzWkSnJ1jmtKWtL+dk3oysUfv5oBiCJGjYm47dIwS+fKXZW2DgMQNLkh+R1IqC4ITDGfzpmfaoTILqBw++s3O9SZDL3Vk12fRQnTwqQYFJ7RMJiGLpJ/v22V7Kk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962927; c=relaxed/simple;
	bh=0DYgCUssSPxKod8jG802Gv4o3aZRybrO7nkNQEBOzCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YoE+BoTFb5ugIifCiyW+Dbny6JB7qWC8WtWFaVu6KiXbdH+vkm8Ukex3UwqouoYelygBgkNR4N5fE/APn8CiLL/SS35WNkSIIliWG1tOvddS3aFSmouRbZIDTbzAi6RM65DEMGLZm/91r+UkqQS/tVpLd+VNzMdB0V7ejyeIwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=P1+Bz7Ll; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so2412317f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760962924; x=1761567724; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aJAVEp/kEZKOKbtgF8I32iGacDsuu9jE3UnwZxBu1Fk=;
        b=P1+Bz7LlJi89XVQkgVDlTC9fSBBZOKJWdL1O8z9MhDt3/qqkQKXxUf+QQnIJi/JgVg
         EUF9qHE9TAqwrh+6AAJoT7Sw3MnKcMFoSRWwQsepyeYToNGalH2sac00wzPojWfZi1Ak
         7hxOrAsPwHTSYCTDws5FpmzamkGRogot1UgfzWNdmZ7gjgqVIgLroqInYbYC7hDtERd2
         21t1p0TvALYJm4K5f8cZ7tamkqYM6O8VOHgzSFYtPj3zfjgnNiW3yOL4G1kNWsaSBsWX
         +ZTjT3iEkNgmVzPA+6XauaergVfhkFracXhEDif9SwOtH76vQAN4jlcKaJ0BMVov27zS
         5nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760962924; x=1761567724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJAVEp/kEZKOKbtgF8I32iGacDsuu9jE3UnwZxBu1Fk=;
        b=b+NlqAcxDkNVwA4h8FLQfXUJ9NFeYfVOdOQCp98Y/w4YmCLmn1gPVe72Gz9zTaC6zk
         6fxcXPAh4ivNsekWdYnfljX8j4P3y9xRGdYIwzLrltXW5odGnm1eoUtlHhI8WrmLEPE0
         qZghEmaCnaPiUtUHW0o1qOnykbpH3imkFfEjE5vdT5o4HLfW9KQcT5z0GIoJs54kxS9N
         aW9pfrUhCBiKFTQ585Ez3dpVJ32yJ1UPYzdflycXv1O4QoBnkckpZBGyDOovH168gDa4
         g375qegV4FpxJGME2cEYqR7+piIPUq6qT/U5JZMhbyn25nZ+nYqQkJDpSdNGS/VWKWPL
         nZ7w==
X-Gm-Message-State: AOJu0YxYpNfobKCDYPdiJNru5Guxb5/eVD+WaML861fA9WbaYwj09NWv
	GGoyzQZkwgwyssEGa2WH66n9F71wxcPemVE4kPGJtpVqrrmxaokL8oIcKS8tF0QylFw=
X-Gm-Gg: ASbGncvFqR3pH8oC3+dv5Z0rCqD/DvKz13jrK1Qlp7hYxvRPxKT1NOY/vzVcEmp+9id
	0CAG4ICG8i4mAjzCfPoeVt4oguKdPtXtezR0FtD/KqnLs4LS5zT6p6KJqPWk4yZZjqwVkU8/Xpk
	WKqfSoMeL5IR5lUqYFzIBPeFb9mc4M0P0yAsnjSSN3SOcxEBFFjM2BvZc54ePnR9Nqs0oYuF2Zs
	Z8Evrdh0hU/GaqmbgV3oO+quTvyJvT2We48Ggd7JQyqwP8YszF/I0+8TJeIAHxcrZqNr80P6Rnx
	2qL5oLe5l9Bk9THQ+CRqlrAYM5VBnag8FdrJy8maQ95eacFrJ8TJPKl3bkUaFldaTmZBfvMiQuV
	pBfcTTnM4YY7RCEO6DrLKHMkGCG/GmBTDyzJvA4c035I6Bpo8gANE8iYZTWXfGSQ9Q6E/QL340F
	e//DwNte1y5bmCW2rCVOXUim58szXxPYY8NzePTh5sRnwWpXyBisRFK2Josg==
X-Google-Smtp-Source: AGHT+IFX8MyJ1xId/3gN7CxCvb7Xss3T1Dg9ZcEtU3khZzkG28PIuQLSRMb6LPhGmCWXzg7MCb70Mw==
X-Received: by 2002:a05:6000:40c9:b0:427:7d5:e767 with SMTP id ffacd0b85a97d-42707d5e7aemr7912733f8f.42.1760962923837;
        Mon, 20 Oct 2025 05:22:03 -0700 (PDT)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0febsm15155370f8f.6.2025.10.20.05.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:22:03 -0700 (PDT)
Message-ID: <a3572fe174353ee629499f97668c14253083a7fc.camel@mandelbit.com>
Subject: Re: [PATCH net v2 3/3] ovpn: use datagram_poll_queue for socket
 readiness in TCP
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Antonio Quartulli <antonio@openvpn.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni	 <pabeni@redhat.com>
Date: Mon, 20 Oct 2025 14:22:01 +0200
In-Reply-To: <aPYMHdIX68S1Yk-l@krikkit>
References: <20251020073731.76589-1-ralf@mandelbit.com>
	 <20251020073731.76589-4-ralf@mandelbit.com> <aPYMHdIX68S1Yk-l@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 12:17 +0200, Sabrina Dubroca wrote:
> 2025-10-20, 09:37:31 +0200, Ralf Lici wrote:
> > diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> > index 289f62c5d2c7..308fdbb75cea 100644
> > --- a/drivers/net/ovpn/tcp.c
> > +++ b/drivers/net/ovpn/tcp.c
> > @@ -560,16 +560,34 @@ static void ovpn_tcp_close(struct sock *sk,
> > long timeout)
> > =C2=A0static __poll_t ovpn_tcp_poll(struct file *file, struct socket
> > *sock,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poll_table *wait)
> > =C2=A0{
> > -	__poll_t mask =3D datagram_poll(file, sock, wait);
> > +	struct sk_buff_head *queue =3D &sock->sk->sk_receive_queue;
> > =C2=A0	struct ovpn_socket *ovpn_sock;
> > +	struct ovpn_peer *peer =3D NULL;
> > +	__poll_t mask;
> > =C2=A0
> > =C2=A0	rcu_read_lock();
> > =C2=A0	ovpn_sock =3D rcu_dereference_sk_user_data(sock->sk);
> > -	if (ovpn_sock && ovpn_sock->peer &&
> > -	=C2=A0=C2=A0=C2=A0 !skb_queue_empty(&ovpn_sock->peer->tcp.user_queue)=
)
> > -		mask |=3D EPOLLIN | EPOLLRDNORM;
> > +	/* if we landed in this callback, we expect to have a
> > +	 * meaningful state. The ovpn_socket lifecycle would
> > +	 * prevent it otherwise.
> > +	 */
> > +	if (WARN_ON(!ovpn_sock || !ovpn_sock->peer)) {
> > +		rcu_read_unlock();
> > +		pr_err_ratelimited("ovpn: null state in
> > ovpn_tcp_poll!\n");
>=20
> nit: the extra print is not really necessary once we've done a full
> WARN. But if you want the custom message alongside the WARN, maybe:
>=20
> if (WARN(!ovpn_sock || !ovpn_sock->peer, "ovpn: null state in
> ovpn_tcp_poll!")) {
> 	...
> }
>=20
> (you can find examples of the "if (WARN(cond, msg))" pattern in
> net/core/skbuff.c:
> drop_reasons_register_subsys/drop_reasons_unregister_subsys
> and other places)

I wasn't aware of this macro, thanks for pointing it out. I'll use it on
the next version.

--=20
Ralf Lici
Mandelbit Srl

