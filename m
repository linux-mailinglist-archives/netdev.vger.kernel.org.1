Return-Path: <netdev+bounces-180701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8D6A822FB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BD81BA51E4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A43825D537;
	Wed,  9 Apr 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="tYhHt9c0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53593255E32
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196449; cv=none; b=f9/TDjYpE/+8hSAceYmJ3iXjXaJ7JBreUyFWSyTWbJuBgQjWH/I1mF8E+fTZhX1oI+oVFeuqAwgJ48uow3zzKFkdAV3vKxOBlUewhcJnACqv19Pw+KD8bY8NwTqGc/3qXmxAC1Ho8Gay5tGHf7UVD96/txWKEGVoSxUyJAADQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196449; c=relaxed/simple;
	bh=rFmcokOxgQ04IPaHOtO8/QXQv1f3NE8QgHz+zuV8woo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RahBAtDXvWzhFwBzAZY7PCw5IO9xNWKFvx6BUgliEsZmx+SYDbZdgX5OzCTBaS2Z9R2EhpIocYoeYuruccgy9CO4gK0rDDwsYp07seKdevJavwVV14rMYdlpDNgTWaHgH1Xmkqm9ca2pSx0+xmxM+iwf9C9VC5PWKi9qS2FxkPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=tYhHt9c0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so38193475e9.2
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1744196444; x=1744801244; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SeAeVQ2DSMseBN5CKmywMPSjKp9DX8Z0LTquO+DcRDE=;
        b=tYhHt9c07TrgM5aCePAoN9omRQ2NBbp1fDrIsPo5WLhfmpcaM9PPogJKcM9+oyj+YK
         dKaY2Mf7ueNxhMWw0tI6M2Kka3hxQgtSmJqQ1CPtiE+npDh1jEogEby/2HlHR0C/tDSQ
         02CO4wVpx0lBQYJb3qnvgiWLfMMdRXjcPQjiMlquvolQ0Qw3lbDBtrEE0ekWPkZpniGK
         gc1y18PqBjrDDZ6aTj548O8438mw3UvGgR97ZZXFpF0m59sGvc0+AqempTQxynexlrRu
         7KISibnufOvOUIHDA79ON0qujHDKc+d4cSKOn0dgigvfnGqFvdnY6YbCfYMrEFGNzBMZ
         2LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744196444; x=1744801244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeAeVQ2DSMseBN5CKmywMPSjKp9DX8Z0LTquO+DcRDE=;
        b=ZS4HdMBa9ewpeqCtP+dj5f6XN9D0gIA/abZtuQBNMa46f82PfK3I3k6m72VsWIBW9m
         c4R0aKwLjN1XrDbOJ277ItddkNllTy4HkDQz6PqdoD5p7DE784b8Qkc7UA0VoHWxP7jJ
         /2FKDcPULLMq4S5ck1Zx6aUkhYC+kG5/6MGr/He7raMjkhcILDDTduilS3ZxjKbimJwE
         IMWXKBY4WyD72cpFFW+F1ApRf8QMxJfbWX/9D8JPHFwLODtyu4zs9rgEBZCaqhBYvNzH
         mCFr6lyRwRMic9Ose3bvRNthDzd/dYwDVr3ZrTN3DFjurInSwG/T9X9ozc6iv1fiJi3P
         UWlQ==
X-Gm-Message-State: AOJu0Yw+U+IqNPPl+geFcwJKaGtvvgLH4rf4gdTccje7a50ryaSEVf5c
	Tu++7NtZUl5bvOlltnLHkgHN8B+/FQRoCU5JMXB605Un2D7mlnqfWGNJ0QPgnQ==
X-Gm-Gg: ASbGnctM3AHsLwp1qLNLi/BtwUfOpfgWABxG1l9GNU+RV6TffOf5aUeooyQ31cF+Ze+
	eEo6csL0nZf9x6AAOZl9wXL+CzHq6+1m7FwHBkN35PZRTnyOqYH9HZ9NoWy4TXx8NsybfVeajQA
	GeSPsN+yCylTtgfgbWLfEfrNbwQF3M92QNmPuYEJrTahthZhoBob+u4BI3D4gLJBNTrkdPTV+9i
	XO9a+zZcjaK/7PEjp1VbCgV9lFD7ozBBMP+epqKkla9rrAFbOJCWdxFCJnwTB+ERZqpirTH4rdv
	Cd1KgUQs5wplAPoflbpq6lgeMkDAGWWUX+4jfHiS7FJJxYEM
X-Google-Smtp-Source: AGHT+IHQJ4ciGg/WXX3+oeJHUGUYDT70ttAy3gmbsoEwn1Yjl14StNSDV1EEzFQqqh6XDRiIXAcXVQ==
X-Received: by 2002:a05:600c:46ca:b0:43d:fa58:700d with SMTP id 5b1f17b1804b1-43f1ed6f0abmr21214965e9.32.1744196444024;
        Wed, 09 Apr 2025 04:00:44 -0700 (PDT)
Received: from [192.168.2.3] ([109.227.147.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938aac2sm1305610f8f.52.2025.04.09.04.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 04:00:43 -0700 (PDT)
Message-ID: <ce56ed7345d2077a7647687f90cf42da57bf90c7.camel@hazent.com>
Subject: Re: Issue with AMD Xilinx AXI Ethernet (xilinx_axienet) on
 MicroBlaze: Packets only received after some buffer is full
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Katakam, Harini"
	 <harini.katakam@amd.com>, "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Date: Wed, 09 Apr 2025 13:00:42 +0200
In-Reply-To: <MN0PR12MB59537EB05F07459513A2301EB7AE2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <9a6e59fcc08cb1ada36aa01de6987ad9f6aaeaa4.camel@hazent.com>
		 <20250402100039.4cae8073@kernel.org>
	 <80e2a74d4fcfcc9b3423df13c68b1525a8c41f7f.camel@hazent.com>
	 <MN0PR12MB59537EB05F07459513A2301EB7AE2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-03 at 05:54 +0000, Pandey, Radhey Shyam wrote:
> [...]
>  + Going through the details and will get back to you . Just to confirm t=
here is no
> vivado design update ? and we are only updating linux kernel to latest?
>=20

Hi again,

I've reconsidered the upgrading approach and I've first upgraded buildroot
and kept the same kernel version (4.4.43). This has the effect of upgrading
gcc from version 10 to version 13.

With buildroot's compiled gcc-13 and keeping this same old kernel, the effe=
ct
is that the system drops ARP requests. Compiling with older gcc-10, ARP req=
uests
are replied to. Keeping old buildroot version but asking it to use gcc-11
will cause the same issue with kernel 4.4.43, so something must have happen=
ed
in between those gcc versions.

So this does not look like an axienet driver problem, which I first thought
it was, because who would blame the compiler in first instance?

But then things started to get even stranger.

What I did next, was slowly upgrading buildroot and using the kernel versio=
n
that buildroot considered "latest" at the point it was released. I reached
a point in which the ARP requests were being dropped again. This happened o=
n
buildroot 2021.11, which still used gcc-10 as the default and kernel versio=
n
5.15.6. So some gcc bug that is getting triggered on gcc-11 in kernel 4.4.4=
3
is also triggered on gcc-10 by kernel 5.15.6.

Using gcc-10, I bisected the kernel and found that this commit was triggeri=
ng
whatever it is that is happening, around 5.11-rc2:

commit 324cefaf1c723625e93f703d6e6d78e28996b315 (HEAD)
Author: Menglong Dong <dong.menglong@zte.com.cn>
Date:   Mon Jan 11 02:42:21 2021 -0800

    net: core: use eth_type_vlan in __netif_receive_skb_core
   =20
    Replace the check for ETH_P_8021Q and ETH_P_8021AD in
    __netif_receive_skb_core with eth_type_vlan.
   =20
    Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
    Link: https://lore.kernel.org/r/20210111104221.3451-1-dong.menglong@zte=
.com.cn
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>


I've been staring at the diff for hours because I can't understand what
can be wrong about this:

diff --git a/net/core/dev.c b/net/core/dev.c
index e4d77c8abe76..267c4a8daa55 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5151,8 +5151,7 @@ static int __netif_receive_skb_core(struct sk_buff **=
pskb, bool pfmemalloc,
        skb_reset_mac_len(skb);
    }
=20
-   if (skb->protocol =3D=3D cpu_to_be16(ETH_P_8021Q) ||
-       skb->protocol =3D=3D cpu_to_be16(ETH_P_8021AD)) {
+   if (eth_type_vlan(skb->protocol)) {
        skb =3D skb_vlan_untag(skb);
        if (unlikely(!skb))
            goto out;
@@ -5236,8 +5235,7 @@ static int __netif_receive_skb_core(struct sk_buff **=
pskb, bool pfmemalloc,
             * find vlan device.
             */
            skb->pkt_type =3D PACKET_OTHERHOST;
-       } else if (skb->protocol =3D=3D cpu_to_be16(ETH_P_8021Q) ||
-              skb->protocol =3D=3D cpu_to_be16(ETH_P_8021AD)) {
+       } else if (eth_type_vlan(skb->protocol)) {
            /* Outer header is 802.1P with vlan 0, inner header is
             * 802.1Q or 802.1AD and vlan_do_receive() above could
             * not find vlan dev for vlan id 0.



Given that eth_type_vlan is simply this:

static inline bool eth_type_vlan(__be16 ethertype)
{
        switch (ethertype) {
        case htons(ETH_P_8021Q):
        case htons(ETH_P_8021AD):
                return true;
        default:
                return false;
        }
}

I've added a small printk to see these values right before the
first time they are checked:

printk(KERN_ALERT  "skb->protocol =3D %d, ETH_P_8021Q=3D%d ETH_P_8021AD=3D%=
d, eth_type_vlan(skb->protocol) =3D %d",
       skb->protocol, cpu_to_be16(ETH_P_8021Q), cpu_to_be16(ETH_P_8021AD), =
eth_type_vlan(skb->protocol));

And each ARP ping delivers a packet reported as:
skb->protocol =3D 1544, ETH_P_8021Q=3D129 ETH_P_8021AD=3D43144, eth_type_vl=
an(skb->protocol) =3D 0

To add insult to injury, adding this printk line solves the ARP deafness,
so no matter whether I use eth_type_vlan function or manual comparison,
now ARP packets aren't dropped.

Removing this printk and adding one inside the if-clause that should not
be happening, shows nothing, so neither I can directly inspect the packets
or return value of the wrong working code, nor can I indirectly proof that
the wrong branch of the if is being taken. This reinforces the idea of
a compiler bug, but I very well could be wrong.

Adding this printk:
diff --git i/net/core/dev.c w/net/core/dev.c
index 267c4a8daa55..a3ae3bcb3a21 100644
--- i/net/core/dev.c
+++ w/net/core/dev.c
@@ -5257,6 +5257,8 @@ static int __netif_receive_skb_core(struct sk_buff **=
pskb, bool pfmemalloc,
                 * check again for vlan id to set OTHERHOST.
                 */
                goto check_vlan_id;
+       } else {
+           printk(KERN_ALERT "(1) skb->protocol is not type vlan\n");
        }
        /* Note: we might in the future use prio bits
         * and set skb->priority like in vlan_do_receive()

is even weirder because the same effect: the message does not appear
but ARP requests are answered back. If I remove this printk, ARP requests a=
re dropped.

I've generated assembly output and this is the difference between having th=
at
extra else with the printk and not having it.

It doesn't even make much any sense that code would even reach this region
of code because there's no vlan involved in at all here.

And so here I am again, staring at all this without knowing how to proceed.

I guess I will be trying different and more modern versions of gcc,
even some precompiled toolchains and see what else may be going on.

If anyone has any hindsight as to what is causing this or how to solve
it, it'd be great if you could share it.

Thanks!

--=20
=C3=81lvaro G. M.


