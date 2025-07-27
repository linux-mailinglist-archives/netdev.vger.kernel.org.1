Return-Path: <netdev+bounces-210388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3846DB130AA
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 18:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419F21897447
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2460221A426;
	Sun, 27 Jul 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1G3GKKx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845C63987D;
	Sun, 27 Jul 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634201; cv=none; b=phGguczVHLjhvFVMTlD67oYDRrWQjWK/nwcAOkShwPTHVngjQvzjE/qsCUNHuygp/LvWfQt7R1JgRw7yHDaNi1Jb8trIWQGlHIfiViMW54EJWPVNMjSM73GZvQGrs8fQwEdFn65hTbneMF4hu9qA/gCylZ2HKF7BS3f/71o2Zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634201; c=relaxed/simple;
	bh=YfAzeldAjz07knn7/Q10GjzdRMcNPA5deTH4dsmrlf4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ss1+ODsrafXeR0VMqI6ss7gRmbgTugzKsuHILaqYUPWH31SecIqoMS6SKPoHX3H+P6XZpqH5kNSOK4dNp4+unXpBMEg6fKR9PZc8lcyGW3fbl+nXJt46cAIUb+LzuetAT829N4j8sHrZsCpQNnFfKbGSe0rN04HoGZ8EdyHAfZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1G3GKKx; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8b3cc12dceso2579729276.1;
        Sun, 27 Jul 2025 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753634198; x=1754238998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF5033q7gDVxM47w7GcaBWsntXTdySNW1g3Q5fv/mck=;
        b=Q1G3GKKxyvZ+7hLP8JqcelAmlufKkNfxZ3+vOiIn9Xjb9qJAUXVev2vjfVfZSnumlf
         5mFEgGQzkj6va85vXRFSmJP/IGVCIzTXRsRF4PPQ9eQe96tWRVZ+Gr0HNRlkzIN+tZTh
         IlwdC1fKwpRkyqjw31bgr4/+fiNN9Qb9C01AHHu/sAPgTQCOuuNVUIBvUltN47aKi8HO
         POfqr4EXuIEylxvRReOasFxegH3PwNx0r49aKesShyDMuRLUmlOU27UR88HJOwwnHP56
         S2Os8rnwE0Dn6BvZmahhcDqY1EFp2hujQ2BK/D5t0ifQQ71MfRKQLcQ9AeQCxbu35off
         CBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634198; x=1754238998;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eF5033q7gDVxM47w7GcaBWsntXTdySNW1g3Q5fv/mck=;
        b=YzQEbbu4CN07srUFoOEm/A4Vs21O/OEBxMXlqdtaUULkGVM1GnzkgpZlTDHOaYGypT
         GcuQWKw7hwEXxpBPmBueYIRBRJj22TT58akME+8/oP7PfNzLy1zHEAlXTUlnFO1sf9pM
         ALWP5XAtC1KlHJPGZJFV9IWr61vbEIj/eXBFyo5/Rq2R962z9BP/6pgJRMWuQK8QXUrK
         dmaLZxDn4chM6A7dU4Khtyipp7MZiPXPklOwDfCgFUTPe7+yPmx0bvapCqv7H0E999Vu
         Osm2+Ed0d/DoVNXGRaAOfXX3hggImqQdghqT7+yaNdmD700W1c/0L1iXKZcI7Ljn6gn4
         lvhA==
X-Forwarded-Encrypted: i=1; AJvYcCWu0cDIXQFu4Kf4/Vi68ZzC6xg+ozdX3D4/bWMgU6rZjrLDbNhe3+I21J4eShLectVqeBGXORRO@vger.kernel.org, AJvYcCXcrhGGZkQ3L3LxyX14MxMtAnhF+qS78bs8cN4DnNO4aKtvmJ0ttK93+fBXx9T+uB0ZGj79D/y3jq4SsJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2V/hojTcTyBT3rd4SXlB9buc305xWPJ4NDPFribZZq7IdI7Xt
	2Skk4dJnTVN1jRcbmip06TnCrFj/MtVZx37LdB89bFc9XSU1uzugBnF4
X-Gm-Gg: ASbGncv5UjJZ9OzDKwuHm9psF9AxcABgv9YgkJ338Ffa7dpb/LLjyVozTXravWfBrOT
	HaS/VIBQlmlcCXctmDgZAZzzziLvfeJD3u4AqwUTlxC/XltUBKkQ+xO96Dc3oG2Qvhh9zZfYzEG
	2/p/9aVZfYwRmxTANzuTDJDn6lrguMr2e9WIKrkE8H3KYfxKpxJZPFTqp7US4Fq3C8L7MlnX0PT
	ypp9V3ghzvVvmEXTS9nKPzaz6nuXVJoZt9baMPvIOlciRF9BhDwpAFVnzCoYXgaa758mUA1lu1+
	9m5ocSNmgTBju0pwqZHg3fDVnq0ysNkr2rKaBvAWFydUjWBezte+TAqmE8q7bJ+doG0OAV4m5Tp
	rW5MqDNCh53OKu3o0FSMywSD1O29C8FNivOPfGKxD6yYn/9c/mKjk2CHQAxdff85Pi6ofYQ==
X-Google-Smtp-Source: AGHT+IExGqsABb2nfDpqx62l2Grr9WMf6NksN8dn+3UY+xDAkjD9saLK8WZUGJSLhVfjWXlqDyk/og==
X-Received: by 2002:a05:6902:20ca:b0:e8d:76ec:7faa with SMTP id 3f1490d57ef6-e8df1388e0bmr9352343276.25.1753634198366;
        Sun, 27 Jul 2025 09:36:38 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8df86ea200sm1422800276.35.2025.07.27.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:36:37 -0700 (PDT)
Date: Sun, 27 Jul 2025 12:36:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Liang <wangliang74@huawei.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, 
 pabeni@redhat.com, 
 davem@davemloft.net, 
 willemb@google.com, 
 atenart@kernel.org
Cc: yuehaibing@huawei.com, 
 zhangchangzhong@huawei.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 steffen.klassert@secunet.com, 
 tobias@strongswan.org
Message-ID: <68865594e28d8_9f93f29443@willemb.c.googlers.com.notmuch>
In-Reply-To: <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com>
References: <20250724083005.3918375-1-wangliang74@huawei.com>
 <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
 <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in
 virtio_net_hdr_to_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Wang Liang wrote:
> =

> =E5=9C=A8 2025/7/24 21:29, Willem de Bruijn =E5=86=99=E9=81=93:
> > Wang Liang wrote:
> >> When sending a packet with virtio_net_hdr to tun device, if the gso_=
type
> >> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udphd=
r
> >> size, below crash may happen.
> >>
> > gso_size is the size of the segment payload, excluding the transport
> > header.
> >
> > This is probably not the right approach.
> >
> > Not sure how a GSO skb can be built that is shorter than even the
> > transport header. Maybe an skb_dump of the GSO skb can be elucidating=
.
> >>   			return -EINVAL;
> >>   =

> >>   		/* Too small packets are not really GSO ones. */
> >> -- =

> >> 2.34.1
> >>
> =

> Thanks for your review!

Thanks for the dump and repro.

I can indeed reproduce, only with the UDP_ENCAP_ESPINUDP setsockopt.

> Here is the skb_dump result:
> =

>  =C2=A0=C2=A0=C2=A0 skb len=3D4 headroom=3D98 headlen=3D4 tailroom=3D28=
2
>  =C2=A0=C2=A0=C2=A0 mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98=

>  =C2=A0=C2=A0=C2=A0 shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D=
0 segs=3D0))
>  =C2=A0=C2=A0=C2=A0 csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 comp=
lete_sw=3D0 valid=3D1 level=3D0)

So this is as expected not the original GSO skb, but a segment,
after udp_rcv_segment from udp_queue_rcv_skb.

It is a packet with skb->data pointing to the transport header, and
only 4B length. So this is an illegal UDP packet with length shorter
than sizeof(struct udphdr).

The packet does not enter xfrm4_gro_udp_encap_rcv, so we can exclude
that.

It does enter __xfrm4_udp_encap_rcv, which will return 1 because the
pskb_may_pull will fail. There is a negative integer overflow just
before that:

        len =3D skb->len - sizeof(struct udphdr);
        if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)))
                return 1;

This is true for all the segments btw, not just the last one. On
return of 1 here, the packet does not enter encap_rcv but gets
passed to the socket as a normal UDP packet:

	/* If it's a keepalive packet, then just eat it.
	 * If it's an encapsulated packet, then pass it to the
	 * IPsec xfrm input.
	 * Returns 0 if skb passed to xfrm or was dropped.
	 * Returns >0 if skb should be passed to UDP.
	 * Returns <0 if skb should be resubmitted (-ret is protocol)
	 */
	int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)

But so the real bug, an skb with 4B in the UDP layer happens before
that.

An skb_dump in udp_queue_rcv_skb of the GSO skb shows

[  174.151409] skb len=3D190 headroom=3D64 headlen=3D190 tailroom=3D66
[  174.151409] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
[  174.151409] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D4 type=3D65538 =
segs=3D0))
[  174.151409] csum(0x8c start=3D140 offset=3D0 ip_summed=3D3 complete_sw=
=3D0 valid=3D1 level=3D0)
[  174.151409] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=3D8=

[  174.151409] priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_all=3D0x0
[  174.151409] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0, =
trans=3D0)
[  174.152101] dev name=3Dtun0 feat=3D0x00002000000048c1

And of segs[0] after segmentation

[  103.081442] skb len=3D38 headroom=3D64 headlen=3D38 tailroom=3D218
[  103.081442] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
[  103.081442] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=
=3D0))
[  103.081442] csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete_sw=
=3D0 valid=3D1 level=3D0)
[  103.081442] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=3D8=

[  103.081442] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
[  103.081442] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0, =
trans=3D0)

So here translen is already 38 - (98-64) =3D=3D 38 - 34 =3D=3D 4.

So the bug happens in segmentation.

[ongoing ..]=

