Return-Path: <netdev+bounces-53428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB919802ED0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38037280F66
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEFF1A733;
	Mon,  4 Dec 2023 09:39:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 7800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 01:39:48 PST
Received: from 10.mo581.mail-out.ovh.net (10.mo581.mail-out.ovh.net [178.33.250.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC829B3
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:39:48 -0800 (PST)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.1.121])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 033F627573
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 07:12:13 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-4ws44 (unknown [10.108.16.92])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id AB4201FEA5;
	Mon,  4 Dec 2023 07:12:12 +0000 (UTC)
Received: from courmont.net ([37.59.142.110])
	by ghost-submission-6684bf9d7b-4ws44 with ESMTPSA
	id hoq/I8x7bWW4dSUATzIUhw
	(envelope-from <remi@remlab.net>); Mon, 04 Dec 2023 07:12:12 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S0042a2dd185-a2d9-4096-8b32-76f2378c721f,
                    30E1F9A4461AC3388A1ED448D051F90A1CF7BE56) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:84.253.200.238
Date: Mon, 04 Dec 2023 09:12:11 +0200
From: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To: Hyunwoo Kim <v4bel@theori.io>, courmisch@gmail.com
CC: v4bel@theori.io, imv4bel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phonet: Fix Use-After-Free in pep_recvmsg
User-Agent: K-9 Mail for Android
In-Reply-To: <20231204065952.GA16224@ubuntu>
References: <20231204065952.GA16224@ubuntu>
Message-ID: <A2443BF8-D693-4182-9E07-3FFA33D97217@remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 8920786440130599287
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejhedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreejnecuhfhrohhmpeftrohmihcuffgvnhhishdqvehouhhrmhhonhhtuceorhgvmhhisehrvghmlhgrsgdrnhgvtheqnecuggftrfgrthhtvghrnheptdehtedtheegfeejfeetheetgedvveekkeejhffggefgieevveffffelgfehueejnecukfhppeduvdejrddtrddtrddupdekgedrvdehfedrvddttddrvdefkedpfeejrdehledrudegvddruddutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht

Hi,

Le 4 d=C3=A9cembre 2023 08:59:52 GMT+02:00, Hyunwoo Kim <v4bel@theori=2Eio=
> a =C3=A9crit=C2=A0:
>Because pep_recvmsg() fetches the skb from pn->ctrlreq_queue
>without holding the lock_sock and then frees it,
>a race can occur with pep_ioctl()=2E
>A use-after-free for a skb occurs with the following flow=2E

Isn't this the same issue that was reported by Huawei rootlab and for whic=
h I already provided a pair of patches to the security list two months ago?

TBH, I much prefer the approach in the other patch set, which takes the hi=
t on the ioctl() side rather than the recvmsg()'s=2E

Unfortunately, I have no visibility on what happened or didn't happen afte=
r that, since the security list is private=2E

>```
>pep_recvmsg() -> skb_dequeue() -> skb_free_datagram()
>pep_ioctl() -> skb_peek()
>```
>Fix this by adjusting the scope of lock_sock in pep_recvmsg()=2E
>
>Signed-off-by: Hyunwoo Kim <v4bel@theori=2Eio>
>---
> net/phonet/pep=2Ec | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>
>diff --git a/net/phonet/pep=2Ec b/net/phonet/pep=2Ec
>index faba31f2eff2=2E=2E212d8a9ddaee 100644
>--- a/net/phonet/pep=2Ec
>+++ b/net/phonet/pep=2Ec
>@@ -1250,12 +1250,17 @@ static int pep_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> 	if (unlikely(1 << sk->sk_state & (TCPF_LISTEN | TCPF_CLOSE)))
> 		return -ENOTCONN;
>=20
>+	lock_sock(sk);
>+
> 	if ((flags & MSG_OOB) || sock_flag(sk, SOCK_URGINLINE)) {
> 		/* Dequeue and acknowledge control request */
> 		struct pep_sock *pn =3D pep_sk(sk);
>=20
>-		if (flags & MSG_PEEK)
>+		if (flags & MSG_PEEK) {
>+			release_sock(sk);
> 			return -EOPNOTSUPP;
>+		}
>+

Also this change is not really accounted for=2E

> 		skb =3D skb_dequeue(&pn->ctrlreq_queue);
> 		if (skb) {
> 			pep_ctrlreq_error(sk, skb, PN_PIPE_NO_ERROR,
>@@ -1263,12 +1268,14 @@ static int pep_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> 			msg->msg_flags |=3D MSG_OOB;
> 			goto copy;
> 		}
>-		if (flags & MSG_OOB)
>+
>+		if (flags & MSG_OOB) {
>+			release_sock(sk);
> 			return -EINVAL;
>+		}
> 	}
>=20
> 	skb =3D skb_recv_datagram(sk, flags, &err);
>-	lock_sock(sk);
> 	if (skb =3D=3D NULL) {
> 		if (err =3D=3D -ENOTCONN && sk->sk_state =3D=3D TCP_CLOSE_WAIT)
> 			err =3D -ECONNRESET;
>@@ -1278,7 +1285,7 @@ static int pep_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>=20
> 	if (sk->sk_state =3D=3D TCP_ESTABLISHED)
> 		pipe_grant_credits(sk, GFP_KERNEL);
>-	release_sock(sk);
>+
> copy:
> 	msg->msg_flags |=3D MSG_EOR;
> 	if (skb->len > len)
>@@ -1291,6 +1298,8 @@ static int pep_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
> 		err =3D (flags & MSG_TRUNC) ? skb->len : len;
>=20
> 	skb_free_datagram(sk, skb);
>+
>+	release_sock(sk);
> 	return err;
> }
>=20

