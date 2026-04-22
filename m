Return-Path: <netdev+bounces-280560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF9GDltU6Wk7XwIAu9opvQ
	(envelope-from <netdev+bounces-280560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:06:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B79944B64B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 234CC3024529
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25D12BFC60;
	Wed, 22 Apr 2026 23:03:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 15.mo561.mail-out.ovh.net (15.mo561.mail-out.ovh.net [87.98.150.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0128DC4
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.150.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899026; cv=none; b=Hcrp7CnGnjSekpmAPrdoOJWYmmOBUUYumuDwJt93qL0O+j3JRnnkXg0AuZ9sNWf7mGNKfIP6mqUiaHTLQlBuejb+INLkCtIqH6W6Uz5ZbOBxXBeCU2HGFjaX7+yg1z8qa79h/sPZJ7R9mh94s306y6YJ9qGzlGO5zq4UftoZfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899026; c=relaxed/simple;
	bh=P6TMWpuoDcnMkBNq2rr+RdSacWukC6T/CI7O5PuFsIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SY+rr9gXyvwisjO4gNAf75HMiKBeMmd+7sX1FdFq6Wkoh90x04puYTajVZiWiaZvq2gA8je5HUdPLC58kPWr2gsIgGd8/LX5M7WSLx4JwGs7ClsIyYrX0h277KxlzWNrcHJoRrD6Mg2Vf75lIuc6PcTespSCkV4qKoCaJ1qEkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=87.98.150.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director10.ghost.mail-out.ovh.net (unknown [10.110.37.197])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4g12th1NYpz602W
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 15:18:52 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-5pbb9 (unknown [10.111.182.62])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 09706C0FFF;
	Wed, 22 Apr 2026 15:18:49 +0000 (UTC)
Received: from courmont.net ([37.59.142.112])
	by ghost-submission-7d8d68f679-5pbb9 with ESMTPSA
	id WZFVLdnm6GmgNQAAmGmyiA
	(envelope-from <remi@remlab.net>); Wed, 22 Apr 2026 15:18:49 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-112S00611734424-5a69-4c73-a642-2a7cd00ff7f5,
                    14B14BC8C77B9486866D902178DE58E78B326C1C) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:87.94.153.51
From: =?UTF-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
To: Remi Denis-Courmont <courmisch@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Morduan Zang <zhangdandan@uniontech.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com,
 Morduan Zang <zhangdandan@uniontech.com>, zhanjun <zhanjun@uniontech.com>
Subject:
 Re: [PATCH] net: phonet: do not BUG_ON() in pn_socket_autobind() on failed
 bind
Date: Wed, 22 Apr 2026 18:18:48 +0300
Message-ID: <2466095.vKB9LnXJlr@basile.remlab.net>
Organization: Remlab
In-Reply-To:
 <81A6570B633FF6FE+20260422013807.63087-1-zhangdandan@uniontech.com>
References:
 <81A6570B633FF6FE+20260422013807.63087-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
x-ovh-tracer-id: 16635171126822978512
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFwgEp8Qq+Q0A9WIx2zgaVqCKQUhN1HNPX2iHG2ubWEB1Ixda3cVg9fzHImdu0419pDnYgV+5kdUUG4bTSh0Mz4wSWBbD22d5LQqwG1pzolRjFHg/2hFXBm0UUNAaljPVCaJXgugqN45RY7zujiIqtJ3xcJI4cX2uGhGhThEKp0dmA6JXuKDjSEN/MN8FVmQsZAkLz9D4lncZ0Ke01FEAk75HsV/sgJkdNVYFzo0m3wlkMyAJFIzFLvBz9p5Y6g8K2Nmj2eEGNFwrsbnfDB+y8VV67epTCO6AaS6ddHH45dX4edEWOwwTaJaLLLHq6+uHzrM3IWlMrGOwnMP/MQleEAdmRs7CqAqTYj6397q5qvy7dnuvN6hSt6ea/berWW+BvgJx1V37E9+LRrTpX1FNrxBLiGNUC4HBUODYzbdi+XkLsPAOP5I5pD2VGywt7AgnEMBvOy6iTjAphYFQtQqwnM0Ex2/W49/RFx7dvvYoYRS3h47+IIU9tBPUIVd9i4B03vSRIBwRPJ6mRru7KaXXtTJV8AHx45Bz/6FrSpijsC/Rw9CDrYNaLvUpyDzArmuIP14KFtyzNT4GGLwwfMvkLfC82B4/DsTjFk9eqQMl6R+FVT8zKGurD+9tJ5WidSv1Djv9HXh9zm60rHP2ip5OOTXbIrMXTUgTBDI0EBM5soDg
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280560-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,uniontech.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[remlab.net];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[remi@remlab.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,basile.remlab.net:mid]
X-Rspamd-Queue-Id: 7B79944B64B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Le keskiviikkona 22. huhtikuuta 2026, 4.38.07 It=C3=A4-Euroopan kes=C3=A4ai=
ka Morduan=20
Zang a =C3=A9crit :
> syzbot reported a kernel BUG triggered from pn_socket_sendmsg() via
> pn_socket_autobind():
>=20
>   kernel BUG at net/phonet/socket.c:213!
>   RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
>   RIP: 0010:pn_socket_sendmsg+0x240/0x250 net/phonet/socket.c:421
>   Call Trace:
>    sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
>    __sock_sendmsg net/socket.c:812 [inline]
>    __sys_sendto+0x402/0x590 net/socket.c:2280
>    ...
>=20
> pn_socket_autobind() calls pn_socket_bind() with port 0 and, on
> -EINVAL, assumes the socket was already bound and asserts that the
> port is non-zero:
>=20
>   err =3D pn_socket_bind(sock, ..., sizeof(struct sockaddr_pn));
>   if (err !=3D -EINVAL)
>           return err;
>   BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
>   return 0; /* socket was already bound */
>=20
> However pn_socket_bind() also returns -EINVAL when sk->sk_state is not
> TCP_CLOSE, even when the socket has never been bound and pn_port() is
> still 0.  In that case the BUG_ON() fires and panics the kernel from a
> user-triggerable path.
>=20
> Treat the "bind returned -EINVAL but pn_port() is still 0" case as a
> regular error and propagate -EINVAL to the caller instead of crashing.
> Existing callers already translate a non-zero return from
> pn_socket_autobind() into -ENOBUFS/-EAGAIN, so returning -EINVAL here
> only changes behaviour from panic to a normal errno.
>=20
> Fixes: ba113a94b750 ("Phonet: common socket glue")
> Reported-by: syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D706f5eb79044e686c794
> Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
> Signed-off-by: zhanjun <zhanjun@uniontech.com>
> ---
>  net/phonet/socket.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/phonet/socket.c b/net/phonet/socket.c
> index 4423d483c630..de9108adfe1c 100644
> --- a/net/phonet/socket.c
> +++ b/net/phonet/socket.c
> @@ -210,7 +210,15 @@ static int pn_socket_autobind(struct socket *sock)
>  			     sizeof(struct sockaddr_pn));
>  	if (err !=3D -EINVAL)
>  		return err;
> -	BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
> +	/*
> +	 * pn_socket_bind() can return -EINVAL both when the socket is
> +	 * already bound (pn_port() !=3D 0) and when sk_state !=3D TCP_CLOSE
> +	 * without a prior bind.  Only the former is an "already bound"
> +	 * success for autobind; otherwise propagate -EINVAL instead of
> +	 * crashing the kernel.
> +	 */
> +	if (!pn_port(pn_sk(sock->sk)->sobject))
> +		return -EINVAL;

This could be written as just if (err !=3D -EINVAL || unlikely(...)) return=
 err;

>  	return 0; /* socket was already bound */
>  }


=2D-=20
=E5=BE=B7=E5=B0=BC-=E5=BA=93=E5=B0=94=E8=92=99=E2=80=A7=E9=9B=B7=E7=B1=B3
https://www.remlab.net/




