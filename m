Return-Path: <netdev+bounces-93807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8AB8BD3D6
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EE12854A3
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA539158200;
	Mon,  6 May 2024 17:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 17.mo550.mail-out.ovh.net (17.mo550.mail-out.ovh.net [87.98.179.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0750157487
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.179.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016610; cv=none; b=MZtk2JleQiAVwoX65zYZjLDRU0lpvqClW/ZXuguOj+B7nM8iooU6ZTkCE8VLOnwNmEi6jl/hvdU2ZFrQq34jlFr0La0lDrvWVERtGsNg35J6SAnAV1V7YsZuD0rHKG3r+Re3jxWMKK+tHsooUWQlH3s4I5p16euyy1abUFNMJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016610; c=relaxed/simple;
	bh=CN7xj+uT67o2sW+rYXo0f2Ugt7Pg1ggjIzoYJUkAXa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpXdOHueNOA0S37qm4zRNC+0ZefzL58RE7OnhndqrIhk3Zr+kjF/dTl49fGnva3wj2CVxLraKGXI6tTZMv1LhVQ/RqbZT+2ITdhobRlWuU7KsAq/6k/qufs3NbW2av8hq1kxcKffRhT/JFKJfo+pGEempCnz4xqrlgBWibE/rRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=87.98.179.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.25.63])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4VY7Xv6Kb8z1Qyy
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 17:23:27 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-cbxrr (unknown [10.108.42.240])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D229C1FD18;
	Mon,  6 May 2024 17:23:26 +0000 (UTC)
Received: from courmont.net ([37.59.142.110])
	by ghost-submission-6684bf9d7b-cbxrr with ESMTPSA
	id p9Y0Jw4SOWZvcQEA0aWcsA
	(envelope-from <remi@remlab.net>); Mon, 06 May 2024 17:23:26 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S004dc6be723-f41b-49f6-a08b-4a8adaab5caa,
                    E32D9AD65A977E9A62F8B07C7527B734663DD0F5) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:87.92.194.88
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To: "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] phonet: no longer hold RTNL in route_dumpit()
Date: Mon, 06 May 2024 20:23:23 +0300
Message-ID: <4256876.Znljf6yrvc@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20240506121156.3180991-1-edumazet@google.com>
References: <20240506121156.3180991-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 1301258819392510364
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhfegfeefvdefueetleefffduuedvjeefheduueekieeltdetueetueeugfevffenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgvmhhisehrvghmlhgrsgdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht

Le maanantaina 6. toukokuuta 2024, 15.11.56 EEST Eric Dumazet a =C3=A9crit :
> route_dumpit() already relies on RCU, RTNL is not needed.
>=20
> Also change return value at the end of a dump.
> This allows NLMSG_DONE to be appended to the current
> skb at the end of a dump, saving a couple of recvmsg()
> system calls.
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Remi Denis-Courmont <courmisch@gmail.com>

No objections from me, but TBH I am not familiar with the underlying RTNL=20
locking so my ack wouldn't be worth anything.

> ---
>  net/phonet/pn_netlink.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
> index
> 59aebe29689077bfa77d37516aea4617fe3b8a50..c11764ff72d6ac86e643123e2c49de6=
f0
> 758bf97 100644 --- a/net/phonet/pn_netlink.c
> +++ b/net/phonet/pn_netlink.c
> @@ -178,7 +178,7 @@ static int fill_route(struct sk_buff *skb, struct
> net_device *dev, u8 dst, rtm->rtm_type =3D RTN_UNICAST;
>  	rtm->rtm_flags =3D 0;
>  	if (nla_put_u8(skb, RTA_DST, dst) ||
> -	    nla_put_u32(skb, RTA_OIF, dev->ifindex))
> +	    nla_put_u32(skb, RTA_OIF, READ_ONCE(dev->ifindex)))
>  		goto nla_put_failure;
>  	nlmsg_end(skb, nlh);
>  	return 0;
> @@ -263,6 +263,7 @@ static int route_doit(struct sk_buff *skb, struct
> nlmsghdr *nlh, static int route_dumpit(struct sk_buff *skb, struct
> netlink_callback *cb) {
>  	struct net *net =3D sock_net(skb->sk);
> +	int err =3D 0;
>  	u8 addr;
>=20
>  	rcu_read_lock();
> @@ -272,16 +273,16 @@ static int route_dumpit(struct sk_buff *skb, struct
> netlink_callback *cb) if (!dev)
>  			continue;
>=20
> -		if (fill_route(skb, dev, addr << 2, NETLINK_CB(cb-
>skb).portid,
> -			       cb->nlh->nlmsg_seq, RTM_NEWROUTE) <=20
0)
> -			goto out;
> +		err =3D fill_route(skb, dev, addr << 2,
> +				 NETLINK_CB(cb->skb).portid,
> +				 cb->nlh->nlmsg_seq,=20
RTM_NEWROUTE);
> +		if (err < 0)
> +			break;;
>  	}
> -
> -out:
>  	rcu_read_unlock();
>  	cb->args[0] =3D addr;
>=20
> -	return skb->len;
> +	return err;
>  }
>=20
>  int __init phonet_netlink_register(void)
> @@ -301,6 +302,6 @@ int __init phonet_netlink_register(void)
>  	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELROUTE,
>  			     route_doit, NULL, 0);
>  	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETROUTE,
> -			     NULL, route_dumpit, 0);
> +			     NULL, route_dumpit,=20
RTNL_FLAG_DUMP_UNLOCKED);
>  	return 0;
>  }


=2D-=20
R=C3=A9mi Denis-Courmont
http://www.remlab.net/




