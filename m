Return-Path: <netdev+bounces-296437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XpPZAHqOJmrLYgIAu9opvQ
	(envelope-from <netdev+bounces-296437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:42:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F88654AF6
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 11:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=X8G3fjYi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296437-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296437-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCD5E3005D0E
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E03B38AD;
	Mon,  8 Jun 2026 09:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFA83845B0
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 09:37:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911426; cv=none; b=VL6XYybwvPBJzFCTghGEnyYPjODtJayO4aVZ8yN3KblCBy/E9ab9md06miDfvh3+Lq9mJjh6Lxi4rucDW9jdiFxlsDUGDQh9x4tp0ZKLme3EMEX3Ajg43ukRqtDTFm6p53lv1ZhUZn9ED75ekiy2dqgkCTIAJHv4cegWfi/n9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911426; c=relaxed/simple;
	bh=59/tSJ0dW51Zn1c5BQkejmWziRwoc8zt4d0DBdDQLfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5HhAnmH19kdLgSsioiM/WgjMxxO2bNkxHO4IG6PtTfpiyZKrdVe/IAuTVfhWXPhTpKty9sjHVbwttdITYyzctckuFaU3bQ7a8spxDCQe2Kw4ruIj/1nhDgM12CIkbAePASRBZ0r9FUTnaN0shRs+kd8bXHu76s8hCxKgLK+E+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8G3fjYi; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1853781f8f.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780911424; x=1781516224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Spb0RtZEviQD3qiwv62vU4Wzwzz7ccUnGUeAg2w4gY=;
        b=X8G3fjYiOpM9+24zhgjsJrZ3zuEqBqU3EkC2N1dTwSoOTpEl1xndwv3zkfy4ROBwEg
         RosFkFZZgdpiII42/uF4+TMOWexyXGPc1aESM3UNq3oiZIdHDaSG0JFWXU125LUmLRAd
         icY2fBfrbiZvzSTrMHimrJjfF84rs27H3w1nJg4A+McoZpIluyn5iBftyHK/9iYnu3g9
         BZQmnPsO71bxLwat/Su8u0tdV6V4lxCk5wi1ROw1tbVUspchpzCuLG+NQsJI8qEeDheT
         Wb7OlT3mXNrxIaUEQf1AS0I+sYfGE080oOis35xpFKLrSHAteFwnuLq+G6MxVJjeof1+
         /6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780911424; x=1781516224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Spb0RtZEviQD3qiwv62vU4Wzwzz7ccUnGUeAg2w4gY=;
        b=YKXx4HXNdokaKebsgJ1VDgwifDvkpBnusJBpW5EWAP/jRn+5eIaMPXgqU2ZitwkC2e
         E6gyi5NOJccfEzXq85KeLpWkQoJhEt8c30m1KozmLM08t5opKJBlUnVVYGyduBbZUWR2
         bKUjQy3JUN6uKAVvXHlKYRCZG3Y3LopanUDTNUsDuXKLyyZaRWY3+nMKvVnVEXNi4oN4
         ZSv6hPEPoqAiKkeDMZr936lpyE3WPMzWuwvbUZP+/LOZ0Ws1iNYa4oRuPn9rocm3nPHm
         3xoMVjlwdNxbTiCSBtuUnVKqQk9Zqvm8Zu2Bc/Iu9VjTSU/zlGRpaOMKRnUhi/9XD3C+
         JETg==
X-Forwarded-Encrypted: i=1; AFNElJ/N2E4QMfGKlXUviDdkt5igTWPFo80MpRV+y9ZvewkjitbZg7QPbKKRYcC9ztZhjDxToGv24vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcPXqKLCbaY+y+CsG7VOFA9aB0EwGThObczIJSrO78ylcwTzCx
	TeYWN47mlajM+Eq4cxrM9R3LKWgzvsOF202eijKNQkUi+UqAabWv2xSG
X-Gm-Gg: Acq92OFCiXsabttIKchD5bANnZYrYh/xmdf7gkP5Qo28Vo6JwFyyoPOFEofSRYMvDTV
	khH9axZQt3Mlnvq0G7E/Djsz+yND4e9XeH5D4RrjodY3eKtOfFBBjcoUv4MpwmxCsOCDS9MmPaZ
	8u1f9Hu/kUFFtNRR9N6yQXJX9Cq9S9zikewOFvZwuiBM5/wYY2YfGSpqyhS8ORd2weTN5iIDD0M
	a/CL9waXbuwCx8FKn+FZFr2WfzseGuL0FUm1Po3J2tPPDg516xb/lWLF8GC81wdfADWwPUGs7rU
	vAq+Sacb198fKX2mrDdfKeGO9SjC5LVY8JwEEQQPc1rtcdvBAlAK7HBI7DId4aKe6RGk8Q9ka4Q
	Zwc/H4RZj7IgxqpZkcxyPzZImHsNnDbdsLCoAC2YRioYqweIqfR8SYwaiDQi0k/PHNRP//DIoMg
	/3xPYeLfZAEjDTT+dfANjvysLJucXtYCKh1zYkN15+04YE5xiAakSTGJf6aRNXShpSgfQw0E7hS
	sb06bpHeQ==
X-Received: by 2002:a5d:42d1:0:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-46030609782mr16804802f8f.22.1780911423510;
        Mon, 08 Jun 2026 02:37:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm55824962f8f.5.2026.06.08.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:37:03 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:37:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
 rulkc@linuxtesting.org
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <20260608103701.7839ff1b@pumpkin>
In-Reply-To: <e5200406-d336-4ddf-9abd-78fccda24546@rulkc.org>
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
	<20260605160851.3ddbd2ed@pumpkin>
	<e5200406-d336-4ddf-9abd-78fccda24546@rulkc.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296437-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@rulkc.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobby.eshleman@bytedance.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,bytedance.com,linux.alibaba.com,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pumpkin:mid,rulkc.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51F88654AF6

On Mon, 8 Jun 2026 11:10:24 +0300
Arseniy Krasnov <avkrasnov@rulkc.org> wrote:

> On 05/06/2026 18:08, David Laight wrote:
> > On Fri,  5 Jun 2026 14:53:14 +0300
> > Arseniy Krasnov <avkrasnov@rulkc.org> wrote:
> > =20
> >> Logically it was based on TCP implementation, so to make further
> >> support easier, rewrite it in the TCP way.
> >>
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
> >> ---
> >>  net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
> >>  1 file changed, 32 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/v=
irtio_transport_common.c
> >> index 2fd9eaaf5ca6..00caeeaa5590 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struc=
t virtio_transport *t_ops,
> >>  static int virtio_transport_fill_skb(struct sk_buff *skb,
> >>  				     struct virtio_vsock_pkt_info *info,
> >>  				     size_t len,
> >> -				     bool zcopy)
> >> +				     bool zcopy, struct ubuf_info *uarg)
> >>  {
> >>  	struct msghdr *msg =3D info->msg;
> >> =20
> >> +	/* We have completion - attach it to 'skb'. */
> >> +	skb_zcopy_set(skb, uarg, NULL);
> >> +
> >>  	if (zcopy)
> >>  		return __zerocopy_sg_from_iter(msg, NULL, skb,
> >>  					       &msg->msg_iter, len, NULL);
> >> @@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(=
struct virtio_vsock_pkt_info *
> >>  						  u32 src_cid,
> >>  						  u32 src_port,
> >>  						  u32 dst_cid,
> >> -						  u32 dst_port)
> >> +						  u32 dst_port,
> >> +						  struct ubuf_info *uarg)
> >>  {
> >>  	struct vsock_sock *vsk;
> >>  	struct sk_buff *skb;
> >> @@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(=
struct virtio_vsock_pkt_info *
> >>  	if (info->msg && payload_len > 0) {
> >>  		int err;
> >> =20
> >> -		err =3D virtio_transport_fill_skb(skb, info, payload_len, zcopy);
> >> +		err =3D virtio_transport_fill_skb(skb, info, payload_len, zcopy, ua=
rg);
> >>  		if (err)
> >>  			goto out;
> >> =20
> >> @@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct=
 vsock_sock *vsk,
> >>  	if (pkt_len =3D=3D 0 && info->op =3D=3D VIRTIO_VSOCK_OP_RW)
> >>  		return pkt_len;
> >> =20
> >> -	if (info->msg) {
> >> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> >> -		 * there is no MSG_ZEROCOPY flag set.
> >> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> >> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> >> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> >> +		 * handling from 'tcp_sendmsg_locked()'.
> >>  		 */
> >> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> >> -			info->msg->msg_flags &=3D ~MSG_ZEROCOPY;
> >> +		if (info->msg->msg_ubuf) {
> >> +			uarg =3D info->msg->msg_ubuf;
> >> +			can_zcopy =3D virtio_transport_can_zcopy(t_ops, info, pkt_len);
> >> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> >> +			uarg =3D msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> >> +						    NULL, false);
> >> +			if (!uarg) {
> >> +				virtio_transport_put_credit(vvs, pkt_len);
> >> +				return -ENOMEM;
> >> +			}
> >> =20
> >> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
> >>  			can_zcopy =3D virtio_transport_can_zcopy(t_ops, info, pkt_len);
> >> =20
> >> +			if (!can_zcopy)
> >> +				uarg_to_msgzc(uarg)->zerocopy =3D 0;
> >> +
> >> +			have_uref =3D true;
> >> +		}
> >> +
> >> +		/* 'can_zcopy' means that this transmission will be
> >> +		 * in zerocopy way (e.g. using 'frags' array).
> >> +		 */ =20
> > I've not looked at the tcp code, but the above doesn't look right.
> > I don't see why msg->msg_ubuf might be non-NULL without SOCK_ZEROCOPY s=
et.
> > That would give the outer code a callback when the last skb is freed but
> > still copy the data. =20
>=20
> Hi,=C2=A0
>=20
> I guess case when 'msg->msg_ubuf' is non-NULL is special case today for i=
o_uring MSG_ZEROCOPY implementation.
> It was added here https://git.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux.git/commit/?id=3Deb315a7d1396b1139fc7daea55f2d3191e8e7092
> As I see implementation of its tests in tools/testing/selftests/net/io_ur=
ing_zerocopy_tx.c , it doesn't require setting SOCK_ZEROCOPY option for
> socket, so for virtio vsock case I just copied same logic to maintain com=
patibility, because there is MSG_ZEROCOPY io_uring test for virtio/vsock.

That code path probably sets info->msg->msg_flags & MSG_ZEROCOPY so wants '=
zerocopy'.
But wants it's own callback function called rather than one that msg_zeroco=
py_realloc()
adds.

But there is no reason why a caller might not just want a notification that
all the skb associated with the sendmsg have been freed without requesting =
zerocopy.
Maybe no one does it today, but it is trivial to support.

>=20
>=20
> >
> > I also don't see the point of calling msg_zerocopy_realloc() to get a
> > callback when the last skb is freed and then setting
> > 	uarg_to_msgzc(uarg)->zerocopy =3D 0;
> > so that the callback doesn't actually do anything.
> > It isn't as though you 'find out' later on that you can't actually do
> > zerocopy. =20
>=20
>=20
> Sorry, what do You mean "last skb" ? In this code we first allocate uarg =
(allocate, because third arg is always NULL). Then in
> loop we allocate sk_buffs, fill it with data and send. I mean first/last =
skb will be freed after uarg is already allocated and we
> don't touch it. I think i didn't understand Your question here.

The 'uarg' is referenced by all of the skb that contain data for the sendms=
g().
So when the last one of them is freed the callback function is called.
The purpose of that callback is to 'undo' the zerocopy (page pinning etc).
But when you set uarg_to_msgzc(uarg)->zerocopy =3D 0 the callback does noth=
ing.
So there is no point setting up the callback at all.

-- David

>=20
>=20
> > =20
> >>  		if (can_zcopy)
> >>  			max_skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> >>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> >> -
> >> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> >> -		    info->op =3D=3D VIRTIO_VSOCK_OP_RW) {
> >> -			uarg =3D info->msg->msg_ubuf;
> >> -
> >> -			if (!uarg) {
> >> -				uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
> >> -							    pkt_len, NULL, false);
> >> -				if (!uarg) {
> >> -					virtio_transport_put_credit(vvs, pkt_len);
> >> -					return -ENOMEM;
> >> -				}
> >> -
> >> -				if (!can_zcopy)
> >> -					uarg_to_msgzc(uarg)->zerocopy =3D 0;
> >> -
> >> -				have_uref =3D true;
> >> -			}
> >> -		}
> >>  	}
> >> =20
> >>  	rest_len =3D pkt_len;
> >> @@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct=
 vsock_sock *vsk,
> >> =20
> >>  		skb =3D virtio_transport_alloc_skb(info, skb_len, can_zcopy,
> >>  						 src_cid, src_port,
> >> -						 dst_cid, dst_port);
> >> +						 dst_cid, dst_port, uarg);
> >>  		if (!skb) {
> >>  			ret =3D -ENOMEM;
> >>  			break;
> >>  		}
> >> =20
> >> -		skb_zcopy_set(skb, uarg, NULL); =20
> > Aren't you passing uarg through two function calls instead of doing it =
here.
> > Doesn't even make it clearer what is going on. =20
>=20
>=20
> Agree, to simplify patch, uarg could be set earlier (without passing it t=
o functions) I guess.
>=20
> Thanks
>=20
>=20
> >
> > -- David
> > =20
> >> -
> >>  		virtio_transport_inc_tx_pkt(vvs, skb);
> >> =20
> >>  		ret =3D t_ops->send_pkt(skb, info->net);
> >> @@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const =
struct virtio_transport *t,
> >>  					   le64_to_cpu(hdr->dst_cid),
> >>  					   le32_to_cpu(hdr->dst_port),
> >>  					   le64_to_cpu(hdr->src_cid),
> >> -					   le32_to_cpu(hdr->src_port));
> >> +					   le32_to_cpu(hdr->src_port), NULL);
> >>  	if (!reply)
> >>  		return -ENOMEM;
> >>   =20


