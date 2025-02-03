Return-Path: <netdev+bounces-162005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB47FA25201
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 06:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A84B1884947
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 05:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5F23597F;
	Mon,  3 Feb 2025 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JSe5di4b"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40A1863E
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738559874; cv=none; b=Tys4M4WHRV5CHv58qxVbrpdTdFWvRl5Xah6IZJIr2/6fo6GjBgX6/4Rm5ReQAoGSFz5ld7DybpjOksDoJNDOhBoGjWRtWnuNUMSQtkgrlqzBmHbflsQVwMEWsRsMB3+Tv14HzzGU/XzNsmo1b0dNv6GcaXEbTlFDwg3LlCI679o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738559874; c=relaxed/simple;
	bh=O9kr68QH/hy7+cDeJBAmV1SzbKHKh17im5iubQhVNas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=rs8hfp2i+d99XclhvxJQgWoF0LKA+PfUH9EXM+ikbxNL4MYHQjVNGf8JnLWd3SfAYqEePdvyUFNZGpZlFJ5GKydfN1Gw3z48tzKhLyyDGvMcttPAYi7DtlasozDeYPtWeOHNIuqg8WBqs6OPA2ymvJ3l5uPj0ZZQPtph6QqGS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JSe5di4b; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250203051744epoutp0210a781d49c918ff077bb689cc8e5f27e~gmvwvb9Fi1082410824epoutp02C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 05:17:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250203051744epoutp0210a781d49c918ff077bb689cc8e5f27e~gmvwvb9Fi1082410824epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738559864;
	bh=yrTEIfmowW7YlIccXl8UpCK3fMPomIq1KeF9u3Q1+PU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JSe5di4bt7NJhudcNtvkCOP7zmR53Z4YbaXyhpidbcBTlJt4hRbbKqt58SUnvFoda
	 km4P2qlj94px3lxtpHy7GBBB7NmaVUqy8LVk4d2VKMHh1HL3C2vj/1v/SqypYseymL
	 QkehkDHhLxFLJ2cZftP2UQDDNDV02U+Xk+sKue4Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20250203051743epcas2p17913c6cae27d38dae66c352bb5a6e7c7~gmvwK7obj1831618316epcas2p1o;
	Mon,  3 Feb 2025 05:17:43 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YmZWV5q7lz4x9Q1; Mon,  3 Feb
	2025 05:17:42 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.F1.32010.67150A76; Mon,  3 Feb 2025 14:17:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250203051742epcas2p4ee5b666e8f345146d219f76041a8fda7~gmvu7IcGg2794027940epcas2p4S;
	Mon,  3 Feb 2025 05:17:42 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250203051742epsmtrp1d10b83bf2799359b489f1cd3cf283740~gmvu6Ji2h3121131211epsmtrp16;
	Mon,  3 Feb 2025 05:17:42 +0000 (GMT)
X-AuditID: b6c32a4d-acffa70000007d0a-c5-67a051761dec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BC.29.23488.57150A76; Mon,  3 Feb 2025 14:17:41 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250203051741epsmtip2c741fd1c2528e70f704ace10d6ae3d0d~gmvuo3MGS0166801668epsmtip2r;
	Mon,  3 Feb 2025 05:17:41 +0000 (GMT)
Date: Mon, 3 Feb 2025 14:21:32 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	horms@kernel.org, guo88.liu@samsung.com, yiwang.cai@samsung.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com, "Dujeong.lee" <dujeong.lee@samsung.com>, Youngmin Nam
	<youngmin.nam@samsung.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <Z6BSXCRw/9Ne1eO1@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z42WaFf9+oNkoBKJ@perf>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmhW5Z4IJ0g4t3dCyu7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCn
	KymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyB
	ChOyM5acOsNecHYdY8WihqvMDYx/exm7GDk5JARMJK7+esHSxcjFISSwh1Fi6tHJbBDOJ0aJ
	X69bmCCcb4wSq5/NZYNpeXv/DiNEYi+jxPrZq9khnIeMEjsn/gCq4uBgEVCR+DM1G6SBTUBX
	YtuJf2D7RAQ0JO4uegDWzCywhVni/sKPLCD1wgLOEn/v2IKYvALKErd/hIKU8woISpyc+YQF
	xOYEmrjyfhvYQRICFzgk7q3/C9YqIeAi8W+HC8RtwhKvjm9hh7ClJF72t0HZxRIN928xQ/S2
	MEqcuv6CGSJhLDHrWTvYbcwCGRIL75xihZipLHHkFgtEmE+i4/Bfdogwr0RHmxBEp5rErykb
	oKEoI7F78QpmiBIPic+9KSBhIYE5LBLXZ4VNYJSbheSZWUh2zQLqYBbQlFi/Sx8irC2xbOFr
	ZoiwtMTyfxxIKhYwsq1ilEotKM5NT002KjDUzUsth0d3cn7uJkZwutby3cH4ev1fvUOMTByM
	hxglOJiVRHg5Ds9JF+JNSaysSi3Kjy8qzUktPsRoCoymicxSosn5wIyRVxJvaGJpYGJmZmhu
	ZGpgriTOW72jJV1IID2xJDU7NbUgtQimj4mDU6qBaT3/5PdCh+beniJtbbZlf7hiT8/OnmfJ
	HRrMhkVRt+bqrmLa/qHTNebCrCk31F6KH2ndsvWtpsE6oRueU73tDrJueC7d/Kmskt1Ejekx
	/6fbBQ5z1kju88/qq9A0fHz/0Z7PR0v69u++ap7qf3b6xmtP1T5IzK4+dlrvlc8sgW42Daes
	REU3Hs2+Oqt3M7wXvTNfKCz4RJc9J+/5/2gxBc60+Xu/J2+tlvETdJTl+zbPQ5qnOPJo/ZU3
	ewtq0+ul7Zb7yfHNfh32jEfokhTTkn1TvrNvbBWeJ9cRHT05Kf1caalko42Jy5/inU8mPZz8
	Rl28t3iG3ldzBpGHXHZX3Tb/PcZhu459/52rATFXlViKMxINtZiLihMB+Ti/u2AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvG5p4IJ0g4krrS2u7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUVw2Kak5mWWpRfp2CVwZH38uYC94vJqx4v2LA0wNjOu7GbsYOTkkBEwk3t6/A2RzcQgJ
	7GaUaFl9iwkiISNxe+VlVghbWOJ+yxFWiKL7jBJHnq5m6WLk4GARUJH4MzUbpIZNQFdi24l/
	YENFBDQk7i56ADaUWWAbs8St99fZQOqFBZwl/t6xBTF5BZQlbv8IhRg5j0Xi8qS9YHt5BQQl
	Ts58wgJiMwuoS/yZd4kZpJ5ZQFpi+T8OiLC2xLKFr5lBbE6gC1beb2OawCg4C0n3LCTdsxC6
	ZyHpXsDIsopRMrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzgKtTR2ML771qR/iJGJg/EQ
	owQHs5IIL8fhOelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVcaRqQLCaQnlqRmp6YWpBbBZJk4
	OKUamNKrzI5svLz8b0P94VuFPlrfPgksDkp2S5IIlGCdLvBEKUh8NkdB0oNGbw/2/WEbP+rZ
	yDnXr+Ds3NB2/tilHdfna33TPP+BQ2HuFtdTd++e53dSNUpmMpi3sP3GM0v/LfoirM32Dd9j
	1d9x/ZsffU8xT2W2d0sp19vHLUuOPF+jVieY6613yONBelBxwfytJx1v3uqdfUXSvW8aq5XW
	gx3r23W/LVr5+6i1esITe4PTpds6O281C27su/Vvy7fNb+LvhfSIRAT/y0i1ibXcxPmMe8+2
	Xbwvsg+W9akKK/F4p8V9Fj+gxZvR5ys5O/j9B6HvW3j7/+XLus5UaJrMX3/BrPHNfwYtHvX8
	9fEeSizFGYmGWsxFxYkA98eNrTEDAAA=
X-CMS-MailID: 20250203051742epcas2p4ee5b666e8f345146d219f76041a8fda7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----ccw_gG03MnwfJa887GQ3nyBQr5B3liVAvqyN4ARSYk7GwfOF=_4f250_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d
References: <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
	<20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
	<CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
	<009e01db4620$f08f42e0$d1adc8a0$@samsung.com>
	<CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
	<Z4nl0h1IZ5R/KDEc@perf>
	<CADVnQykZYT+CTWD3Ss46aGHPp5KtKMYqKjLxEmd5DDgdG3gfDA@mail.gmail.com>
	<CGME20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d@epcas2p1.samsung.com>
	<Z42WaFf9+oNkoBKJ@perf>

------ccw_gG03MnwfJa887GQ3nyBQr5B3liVAvqyN4ARSYk7GwfOF=_4f250_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, Jan 20, 2025 at 09:18:48AM +0900, Youngmin Nam wrote:
> On Fri, Jan 17, 2025 at 10:18:58AM -0500, Neal Cardwell wrote:
> > On Fri, Jan 17, 2025 at 12:04=E2=80=AFAM Youngmin Nam <youngmin.nam@sam=
sung.com> wrote:
> > >
> > > > Thanks for all the details! If the ramdump becomes available again =
at
> > > > some point, would it be possible to pull out the following values as
> > > > well:
> > > >
> > > > tp->mss_cache
> > > > inet_csk(sk)->icsk_pmtu_cookie
> > > > inet_csk(sk)->icsk_ca_state
> > > >
> > > > Thanks,
> > > > neal
> > > >
> > >
> > > Hi Neal. Happy new year.
> > >
> > > We are currently trying to capture a tcpdump during the problem situa=
tion
> > > to construct the Packetdrill script. However, this issue does not occ=
ur very often.
> > >
> > > By the way, we have a full ramdump, so we can provide the information=
 you requested.
> > >
> > > tp->packets_out =3D 0
> > > tp->sacked_out =3D 0
> > > tp->lost_out =3D 4
> > > tp->retrans_out =3D 1
> > > tcp_is_sack(tp) =3D 1
> > > tp->mss_cache =3D 1428
> > > inet_csk(sk)->icsk_ca_state =3D 4
> > > inet_csk(sk)->icsk_pmtu_cookie =3D 1500
> > >
> > > If you need any specific information from the ramdump, please let me =
know.
> >=20
> > The icsk_ca_state =3D 4 is interesting, since that's TCP_CA_Loss,
> > indicating RTO recovery. Perhaps the socket suffered many recurring
> > timeouts and timed out with ETIMEDOUT,
> > causing the tcp_write_queue_purge() call that reset packets_out to
> > 0... and then some race happened during the teardown process that
> > caused another incoming packet to be processed in this resulting
> > inconsistent state?
> >=20
> > Do you have a way to use GDB or a similar tool to print all the fields
> > of the socket? Like:
> >=20
> >   (gdb)  p *(struct tcp_sock*) some_hex_address_goes_here
> >=20
> > ?
> >=20
> > If so, that could be useful in extracting further hints about what
> > state this socket is in.
> >=20
> > If that's not possible, but a few extra fields are possible, would you
> > be able to pull out the following:
> >=20
> > tp->retrans_stamp
> > tp->tcp_mstamp
> > icsk->icsk_retransmits
> > icsk->icsk_backoff
> > icsk->icsk_rto
> >=20
> > thanks,
> > neal
> >=20
>=20
> Hi Neal,
> Thank you for looking into this issue.
> When we first encountered this issue, we also suspected that tcp_write_qu=
eue_purge() was being called.
> We can provide any information you would like to inspect.
>=20
> tp->retrans_stamp =3D 3339228
> tp->tcp_mstamp =3D 3552879949
> icsk->icsk_retransmits =3D 2
> icsk->icsk_backoff =3D 0
> icsk->icsk_rto =3D 16340
>=20
> Here is all the information about tcp_sock.
>=20
> (struct tcp_sock *) tp =3D 0xFFFFFF88C1053C00 -> (
>   (struct inet_connection_sock) inet_conn =3D ((struct inet_sock) icsk_in=
et =3D ((struct sock) sk =3D ((struct sock_common) __sk_common =3D ((__addr=
pair) skc_addrpair =3D 13979358786200921654, (__be32) skc_daddr =3D 2557148=
70, (__be32) skc_rcv_saddr =3D 3254823104, (unsigned int) skc_hash =3D 2234=
333897, (__u16 [2]) skc_u16hashes =3D (15049, 34093), (__portpair) skc_port=
pair =3D 3600464641, (__be16) skc_dport =3D 47873, (__u16) skc_num =3D 5493=
8, (unsigned short) skc_family =3D 10, (volatile unsigned char) skc_state =
=3D 4, (unsigned char:4) skc_reuse =3D 0, (unsigned char:1) skc_reuseport =
=3D 0, (unsigned char:1) skc_ipv6only =3D 0, (unsigned char:1) skc_net_refc=
nt =3D 1, (int) skc_bound_dev_if =3D 0, (struct hlist_node) skc_bind_node =
=3D ((struct hlist_node *) next =3D 0x0, (struct hlist_node * *) pprev =3D =
0xFFFFFF881CE60AC0), (struct hlist_node) skc_portaddr_node =3D ((struct hli=
st_node *) next =3D 0x0, (struct hlist_node * *) pprev =3D 0xFFFFFF881CE60A=
C0), (struct proto *) skc_prot =3D 0xFFFFFFD08322CFE0, (possible_net_t) skc=
_net =3D ((struct net *) net =3D 0xFFFFFFD083316600), (struct in6_addr) skc=
_v6_daddr =3D ((union) in6_u =3D ((__u8 [16]) u6_addr8 =3D (0, 0, 0, 0, 0, =
0, 0, 0, 0, 0, 255, 255, 54, 230, 61, 15), (__be16 [8]) u6_addr16 =3D (0, 0=
, 0, 0, 0, 65535, 58934, 3901), (__be32 [4]) u6_addr32 =3D (0, 0, 429490176=
0, 255714870))), (struct in6_addr) skc_v6_rcv_saddr =3D ((union) in6_u =3D =
((__u8 [16]) u6_addr8 =3D (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 192, 168=
, 0, 194), (__be16 [8]) u6_addr16 =3D (0, 0, 0, 0, 0, 65535, 43200, 49664),=
 (__be32 [4]) u6_addr32 =3D (0, 0, 4294901760, 3254823104))), (atomic64_t) =
skc_cookie =3D ((s64) counter =3D 6016), (unsigned long) skc_flags =3D 769,=
 (struct sock *) skc_listener =3D 0x0301, (struct inet_timewait_death_row *=
) skc_tw_dr =3D 0x0301, (int [0]) skc_dontcopy_begin =3D (), (struct hlist_=
node) skc_node =3D ((struct hlist_node *) next =3D 0x7593, (struct hlist_no=
de * *) pprev =3D 0xFFFFFF882D49D648), (struct hlist_nulls_node) skc_nulls_=
node =3D ((struct hlist_nulls_node *) next =3D 0x7593, (struct hlist_nulls_=
node * *) pprev =3D 0xFFFFFF882D49D648), (unsigned short) skc_tx_queue_mapp=
ing =3D 65535, (unsigned short) skc_rx_queue_mapping =3D 65535, (int) skc_i=
ncoming_cpu =3D 2, (u32) skc_rcv_wnd =3D 2, (u32) skc_tw_rcv_nxt =3D 2, (re=
fcount_t) skc_refcnt =3D ((atomic_t) refs =3D ((int) counter =3D 2)), (int =
[0]) skc_dontcopy_end =3D (), (u32) skc_rxhash =3D 0, (u32) skc_window_clam=
p =3D 0, (u32) skc_tw_snd_nxt =3D 0), (struct dst_entry *) sk_rx_dst =3D 0x=
FFFFFF8821384F00, (int) sk_rx_dst_ifindex =3D 14, (u32) sk_rx_dst_cookie =
=3D 0, (socket_lock_t) sk_lock =3D ((spinlock_t) slock =3D ((struct raw_spi=
nlock) rlock =3D ((arch_spinlock_t) raw_lock =3D ((atomic_t) val =3D ((int)=
 counter =3D 1), (u8) locked =3D 1, (u8) pending =3D 0, (u16) locked_pendin=
g =3D 1, (u16) tail =3D 0))), (int) owned =3D 0, (wait_queue_head_t) wq =3D=
 ((spinlock_t) lock =3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t)=
 raw_loc
>   (u16) tcp_header_len =3D 32,
>   (u16) gso_segs =3D 26,
>   (__be32) pred_flags =3D 2566918272,
>   (u64) bytes_received =3D 7950,
>   (u32) segs_in =3D 21,
>   (u32) data_segs_in =3D 12,
>   (u32) rcv_nxt =3D 2956372822,
>   (u32) copied_seq =3D 2956372822,
>   (u32) rcv_wup =3D 2956372822,
>   (u32) snd_nxt =3D 2253384964,
>   (u32) segs_out =3D 30,
>   (u32) data_segs_out =3D 13,
>   (u64) bytes_sent =3D 11381,
>   (u64) bytes_acked =3D 3841,
>   (u32) dsack_dups =3D 0,
>   (u32) snd_una =3D 2253381091,
>   (u32) snd_sml =3D 2253384964,
>   (u32) rcv_tstamp =3D 757520,
>   (u32) lsndtime =3D 768000,
>   (u32) last_oow_ack_time =3D 750065,
>   (u32) compressed_ack_rcv_nxt =3D 2956370839,
>   (u32) tsoffset =3D 1072186408,
>   (struct list_head) tsq_node =3D ((struct list_head *) next =3D 0xFFFFFF=
88C1054260, (struct list_head *) prev =3D 0xFFFFFF88C1054260),
>   (struct list_head) tsorted_sent_queue =3D ((struct list_head *) next =
=3D 0xFFFFFF88C1054270, (struct list_head *) prev =3D 0xFFFFFF88C1054270),
>   (u32) snd_wl1 =3D 2956372861,
>   (u32) snd_wnd =3D 78336,
>   (u32) max_window =3D 78336,
>   (u32) mss_cache =3D 1428,
>   (u32) window_clamp =3D 2752512,
>   (u32) rcv_ssthresh =3D 91439,
>   (u8) scaling_ratio =3D 84,
>   (struct tcp_rack) rack =3D ((u64) mstamp =3D 3312043553, (u32) rtt_us =
=3D 3103952, (u32) end_seq =3D 2253381091, (u32) last_delivered =3D 0, (u8)=
 reo_wnd_steps =3D 1, (u8:5) reo_wnd_persist =3D 0, (u8:1) dsack_seen =3D 0=
, (u8:1) advanced =3D 1),
>   (u16) advmss =3D 1448,
>   (u8) compressed_ack =3D 0,
>   (u8:2) dup_ack_counter =3D 2,
>   (u8:1) tlp_retrans =3D 1,
>   (u8:5) unused =3D 0,
>   (u32) chrono_start =3D 780636,
>   (u32 [3]) chrono_stat =3D (30386, 0, 0),
>   (u8:2) chrono_type =3D 1,
>   (u8:1) rate_app_limited =3D 1,
>   (u8:1) fastopen_connect =3D 0,
>   (u8:1) fastopen_no_cookie =3D 0,
>   (u8:1) is_sack_reneg =3D 0,
>   (u8:2) fastopen_client_fail =3D 0,
>   (u8:4) nonagle =3D 0,
>   (u8:1) thin_lto =3D 0,
>   (u8:1) recvmsg_inq =3D 0,
>   (u8:1) repair =3D 0,
>   (u8:1) frto =3D 1,
>   (u8) repair_queue =3D 0,
>   (u8:2) save_syn =3D 0,
>   (u8:1) syn_data =3D 0,
>   (u8:1) syn_fastopen =3D 0,
>   (u8:1) syn_fastopen_exp =3D 0,
>   (u8:1) syn_fastopen_ch =3D 0,
>   (u8:1) syn_data_acked =3D 0,
>   (u8:1) is_cwnd_limited =3D 1,
>   (u32) tlp_high_seq =3D 0,
>   (u32) tcp_tx_delay =3D 0,
>   (u64) tcp_wstamp_ns =3D 3371996070858,
>   (u64) tcp_clock_cache =3D 3552879949296,
>   (u64) tcp_mstamp =3D 3552879949,
>   (u32) srtt_us =3D 29633751,
>   (u32) mdev_us =3D 10160190,
>   (u32) mdev_max_us =3D 10160190,
>   (u32) rttvar_us =3D 12632227,
>   (u32) rtt_seq =3D 2253383947,
>   (struct minmax) rtt_min =3D ((struct minmax_sample [3]) s =3D (((u32) t=
 =3D 753091, (u32) v =3D 330326), ((u32) t =3D 753091, (u32) v =3D 330326),=
 ((u32) t =3D 753091, (u32) v =3D 330326))),
>   (u32) packets_out =3D 0,
>   (u32) retrans_out =3D 1,
>   (u32) max_packets_out =3D 4,
>   (u32) cwnd_usage_seq =3D 2253384964,
>   (u16) urg_data =3D 0,
>   (u8) ecn_flags =3D 0,
>   (u8) keepalive_probes =3D 0,
>   (u32) reordering =3D 3,
>   (u32) reord_seen =3D 0,
>   (u32) snd_up =3D 2253381091,
>   (struct tcp_options_received) rx_opt =3D ((int) ts_recent_stamp =3D 333=
0, (u32) ts_recent =3D 1119503967, (u32) rcv_tsval =3D 1119728668, (u32) rc=
v_tsecr =3D 3312043, (u16:1) saw_tstamp =3D 1, (u16:1) tstamp_ok =3D 1, (u1=
6:1) dsack =3D 0, (u16:1) wscale_ok =3D 1, (u16:3) sack_ok =3D 1, (u16:1) s=
mc_ok =3D 0, (u16:4) snd_wscale =3D 9, (u16:4) rcv_wscale =3D 9, (u8:1) saw=
_unknown =3D 0, (u8:7) unused =3D 0, (u8) num_sacks =3D 0, (u16) user_mss =
=3D 0, (u16) mss_clamp =3D 1440),
>   (u32) snd_ssthresh =3D 7,
>   (u32) snd_cwnd =3D 1,
>   (u32) snd_cwnd_cnt =3D 0,
>   (u32) snd_cwnd_clamp =3D 4294967295,
>   (u32) snd_cwnd_used =3D 0,
>   (u32) snd_cwnd_stamp =3D 768000,
>   (u32) prior_cwnd =3D 10,
>   (u32) prr_delivered =3D 0,
>   (u32) prr_out =3D 0,
>   (u32) delivered =3D 7,
>   (u32) delivered_ce =3D 0,
>   (u32) lost =3D 8,
>   (u32) app_limited =3D 8,
>   (u64) first_tx_mstamp =3D 3312043553,
>   (u64) delivered_mstamp =3D 3315147505,
>   (u32) rate_delivered =3D 1,
>   (u32) rate_interval_us =3D 330326,
>   (u32) rcv_wnd =3D 91648,
>   (u32) write_seq =3D 2253384964,
>   (u32) notsent_lowat =3D 0,
>   (u32) pushed_seq =3D 2253384963,
>   (u32) lost_out =3D 4,
>   (u32) sacked_out =3D 0,
>   (struct hrtimer) pacing_timer =3D ((struct timerqueue_node) node =3D ((=
struct rb_node) node =3D ((unsigned long) __rb_parent_color =3D 18446743561=
551823800, (struct rb_node *) rb_right =3D 0x0, (struct rb_node *) rb_left =
=3D 0x0), (ktime_t) expires =3D 0), (ktime_t) _softexpires =3D 0, (enum hrt=
imer_restart (*)()) function =3D 0xFFFFFFD081EA565C, (struct hrtimer_clock_=
base *) base =3D 0xFFFFFF8962589DC0, (u8) state =3D 0, (u8) is_rel =3D 0, (=
u8) is_soft =3D 1, (u8) is_hard =3D 0, (u64) android_kabi_reserved1 =3D 0),
>   (struct hrtimer) compressed_ack_timer =3D ((struct timerqueue_node) nod=
e =3D ((struct rb_node) node =3D ((unsigned long) __rb_parent_color =3D 184=
46743561551823872, (struct rb_node *) rb_right =3D 0x0, (struct rb_node *) =
rb_left =3D 0x0), (ktime_t) expires =3D 0), (ktime_t) _softexpires =3D 0, (=
enum hrtimer_restart (*)()) function =3D 0xFFFFFFD081EAE348, (struct hrtime=
r_clock_base *) base =3D 0xFFFFFF8962589DC0, (u8) state =3D 0, (u8) is_rel =
=3D 0, (u8) is_soft =3D 1, (u8) is_hard =3D 0, (u64) android_kabi_reserved1=
 =3D 0),
>   (struct sk_buff *) lost_skb_hint =3D 0x0,
>   (struct sk_buff *) retransmit_skb_hint =3D 0x0,
>   (struct rb_root) out_of_order_queue =3D ((struct rb_node *) rb_node =3D=
 0x0),
>   (struct sk_buff *) ooo_last_skb =3D 0xFFFFFF891768FB00,
>   (struct tcp_sack_block [1]) duplicate_sack =3D (((u32) start_seq =3D 29=
56372143, (u32) end_seq =3D 2956372822)),
>   (struct tcp_sack_block [4]) selective_acks =3D (((u32) start_seq =3D 29=
56371078, (u32) end_seq =3D 2956372143), ((u32) start_seq =3D 0, (u32) end_=
seq =3D 0), ((u32) start_seq =3D 0, (u32) end_seq =3D 0), ((u32) start_seq =
=3D 0, (u32) end_seq =3D 0)),
>   (struct tcp_sack_block [4]) recv_sack_cache =3D (((u32) start_seq =3D 0=
, (u32) end_seq =3D 0), ((u32) start_seq =3D 0, (u32) end_seq =3D 0), ((u32=
) start_seq =3D 0, (u32) end_seq =3D 0), ((u32) start_seq =3D 0, (u32) end_=
seq =3D 0)),
>   (struct sk_buff *) highest_sack =3D 0x0,
>   (int) lost_cnt_hint =3D 0,
>   (u32) prior_ssthresh =3D 2147483647,
>   (u32) high_seq =3D 2253384964,
>   (u32) retrans_stamp =3D 3339228,
>   (u32) undo_marker =3D 2253381091,
>   (int) undo_retrans =3D 3,
>   (u64) bytes_retrans =3D 3669,
>   (u32) total_retrans =3D 6,
>   (u32) urg_seq =3D 0,
>   (unsigned int) keepalive_time =3D 0,
>   (unsigned int) keepalive_intvl =3D 0,
>   (int) linger2 =3D 0,
>   (u8) bpf_sock_ops_cb_flags =3D 0,
>   (u8:1) bpf_chg_cc_inprogress =3D 0,
>   (u16) timeout_rehash =3D 5,
>   (u32) rcv_ooopack =3D 2,
>   (u32) rcv_rtt_last_tsecr =3D 3312043,
>   (struct) rcv_rtt_est =3D ((u32) rtt_us =3D 0, (u32) seq =3D 2956431836,=
 (u64) time =3D 3301136665),
>   (struct) rcvq_space =3D ((u32) space =3D 14480, (u32) seq =3D 295636487=
2, (u64) time =3D 3300257291),
>   (struct) mtu_probe =3D ((u32) probe_seq_start =3D 0, (u32) probe_seq_en=
d =3D 0),
>   (u32) plb_rehash =3D 0,
>   (u32) mtu_info =3D 0,
>   (struct tcp_fastopen_request *) fastopen_req =3D 0x0,
>   (struct request_sock *) fastopen_rsk =3D 0x0,
>   (struct saved_syn *) saved_syn =3D 0x0,
>   (u64) android_oem_data1 =3D 0,
>   (u64) android_kabi_reserved1 =3D 0)
>=20
> And here are the details of inet_connection_sock.
>=20
> (struct tcp_sock *) tp =3D 0xFFFFFF88C1053C00 -> (
>   (struct inet_connection_sock) inet_conn =3D (
>     (struct inet_sock) icsk_inet =3D ((struct sock) sk =3D ((struct sock_=
common) __sk_common =3D ((__addrpair) skc_addrpair =3D 13979358786200921654=
, (__be32) skc_daddr =3D 255714870, (__be32) skc_rcv_saddr =3D 3254823104, =
(unsigned int) skc_hash =3D 2234333897, (__u16 [2]) skc_u16hashes =3D (1504=
9, 34093), (__portpair) skc_portpair =3D 3600464641, (__be16) skc_dport =3D=
 47873, (__u16) skc_num =3D 54938, (unsigned short) skc_family =3D 10, (vol=
atile unsigned char) skc_state =3D 4, (unsigned char:4) skc_reuse =3D 0, (u=
nsigned char:1) skc_reuseport =3D 0, (unsigned char:1) skc_ipv6only =3D 0, =
(unsigned char:1) skc_net_refcnt =3D 1, (int) skc_bound_dev_if =3D 0, (stru=
ct hlist_node) skc_bind_node =3D ((struct hlist_node *) next =3D 0x0, (stru=
ct hlist_node * *) pprev =3D 0xFFFFFF881CE60AC0), (struct hlist_node) skc_p=
ortaddr_node =3D ((struct hlist_node *) next =3D 0x0, (struct hlist_node * =
*) pprev =3D 0xFFFFFF881CE60AC0), (struct proto *) skc_prot =3D 0xFFFFFFD08=
322CFE0, (possible_net_t) skc_net =3D ((struct net *) net =3D 0xFFFFFFD0833=
16600), (struct in6_addr) skc_v6_daddr =3D ((union) in6_u =3D ((__u8 [16]) =
u6_addr8 =3D (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 54, 230, 61, 15), (__=
be16 [8]) u6_addr16 =3D (0, 0, 0, 0, 0, 65535, 58934, 3901), (__be32 [4]) u=
6_addr32 =3D (0, 0, 4294901760, 255714870))), (struct in6_addr) skc_v6_rcv_=
saddr =3D ((union) in6_u =3D ((__u8 [16]) u6_addr8 =3D (0, 0, 0, 0, 0, 0, 0=
, 0, 0, 0, 255, 255, 192, 168, 0, 194), (__be16 [8]) u6_addr16 =3D (0, 0, 0=
, 0, 0, 65535, 43200, 49664), (__be32 [4]) u6_addr32 =3D (0, 0, 4294901760,=
 3254823104))), (atomic64_t) skc_cookie =3D ((s64) counter =3D 6016), (unsi=
gned long) skc_flags =3D 769, (struct sock *) skc_listener =3D 0x0301, (str=
uct inet_timewait_death_row *) skc_tw_dr =3D 0x0301, (int [0]) skc_dontcopy=
_begin =3D (), (struct hlist_node) skc_node =3D ((struct hlist_node *) next=
 =3D 0x7593, (struct hlist_node * *) pprev =3D 0xFFFFFF882D49D648), (struct=
 hlist_nulls_node) skc_nulls_node =3D ((struct hlist_nulls_node *) next =3D=
 0x7593, (struct hlist_nulls_node * *) pprev =3D 0xFFFFFF882D49D648), (unsi=
gned short) skc_tx_queue_mapping =3D 65535, (unsigned short) skc_rx_queue_m=
apping =3D 65535, (int) skc_incoming_cpu =3D 2, (u32) skc_rcv_wnd =3D 2, (u=
32) skc_tw_rcv_nxt =3D 2, (refcount_t) skc_refcnt =3D ((atomic_t) refs =3D =
((int) counter =3D 2)), (int [0]) skc_dontcopy_end =3D (), (u32) skc_rxhash=
 =3D 0, (u32) skc_window_clamp =3D 0, (u32) skc_tw_snd_nxt =3D 0), (struct =
dst_entry *) sk_rx_dst =3D 0xFFFFFF8821384F00, (int) sk_rx_dst_ifindex =3D =
14, (u32) sk_rx_dst_cookie =3D 0, (socket_lock_t) sk_lock =3D ((spinlock_t)=
 slock =3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D=
 ((atomic_t) val =3D ((int) counter =3D 1), (u8) locked =3D 1, (u8) pending=
 =3D 0, (u16) locked_pending =3D 1, (u16) tail =3D 0))), (int) owned =3D 0,=
 (wait_queue_head_t) wq =3D ((spinlock_t) lock =3D ((struct raw_spinlock) r=
lock =3D ((arch_spinlock_t) raw_lock =3D ((atomic_t) val =3D ((int) counter=
 =3D 0), (u8) locked =3D 0, (u8) pending =3D 0, (u16) locked_pending =3D 0,=
 (u16) tail =3D 0))), (struct list_head) head =3D ((struct list_head *) nex=
t =3D 0xFFFFFF88C1053CA8, (struct list_head *) prev =3D 0xFFFFFF88C1053CA8)=
)), (atomic_t) sk_drops =3D ((int) counter =3D 7), (int) sk_rcvlowat =3D 1,=
 (struct sk_buff_head) sk_error_queue =3D ((struct sk_buff *) next =3D 0xFF=
FFFF88C1053CC0, (struct sk_buff *) prev =3D 0xFFFFFF88C1053CC0, (struct sk_=
buff_list) list =3D ((struct sk_buff *) next =3D 0xFFFFFF88C1053CC0, (struc=
t sk_buff *) prev =3D 0xFFFFFF88C1053CC0), (__u32) qlen =3D 0, (spinlock_t)=
 lock =3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D =
((atomic_t) val =3D ((int) counter =3D 0), (u8) locked =3D 0, (u8) pending =
=3D 0, (u16) locked_pending =3D 0, (u16) tail =3D 0)))), (struct sk_buff_he=
ad) sk_receive_queue =3D ((struct sk_buff *) next =3D 0xFFFFFF88C1053CD8, (=
struct sk_buff *) prev =3D 0xFFFFFF88C1053CD8, (struct sk_buff_list) list =
=3D ((struct sk_buff *) next =3D 0xFFFFFF88C1053CD8, (struct sk_buff *) pre=
v =3D 0xFFFFFF88C1053CD8), (__u32) qlen =3D 0, (spinlock_t) lock =3D ((stru=
ct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D ((atomic_t) val =
=3D ((int) counter =3D 0), (u8) locked =3D 0, (u8) pending =3D 0, (u16) loc=
ked_pending =3D 0, (u16) tail =3D 0)))), (struct) sk_backlog =3D ((at
>     (struct request_sock_queue) icsk_accept_queue =3D ((spinlock_t) rskq_=
lock =3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D (=
(atomic_t) val =3D ((int) counter =3D 0), (u8) locked =3D 0, (u8) pending =
=3D 0, (u16) locked_pending =3D 0, (u16) tail =3D 0))), (u8) rskq_defer_acc=
ept =3D 0, (u32) synflood_warned =3D 0, (atomic_t) qlen =3D ((int) counter =
=3D 0), (atomic_t) young =3D ((int) counter =3D 0), (struct request_sock *)=
 rskq_accept_head =3D 0x0, (struct request_sock *) rskq_accept_tail =3D 0x0=
, (struct fastopen_queue) fastopenq =3D ((struct request_sock *) rskq_rst_h=
ead =3D 0x0, (struct request_sock *) rskq_rst_tail =3D 0x0, (spinlock_t) lo=
ck =3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D ((a=
tomic_t) val =3D ((int) counter =3D 0), (u8) locked =3D 0, (u8) pending =3D=
 0, (u16) locked_pending =3D 0, (u16) tail =3D 0))), (int) qlen =3D 0, (int=
) max_qlen =3D 0, (struct tcp_fastopen_context *) ctx =3D 0x0)),
>     (struct inet_bind_bucket *) icsk_bind_hash =3D 0xFFFFFF881CE60A80,
>     (struct inet_bind2_bucket *) icsk_bind2_hash =3D 0xFFFFFF881B1FD500,
>     (unsigned long) icsk_timeout =3D 4295751636,
>     (struct timer_list) icsk_retransmit_timer =3D ((struct hlist_node) en=
try =3D ((struct hlist_node *) next =3D 0xDEAD000000000122, (struct hlist_n=
ode * *) pprev =3D 0x0), (unsigned long) expires =3D 4295751636, (void (*)(=
)) function =3D 0xFFFFFFD081EADE28, (u32) flags =3D 1056964613, (u64) andro=
id_kabi_reserved1 =3D 0, (u64) android_kabi_reserved2 =3D 0),
>     (struct timer_list) icsk_delack_timer =3D ((struct hlist_node) entry =
=3D ((struct hlist_node *) next =3D 0xDEAD000000000122, (struct hlist_node =
* *) pprev =3D 0x0), (unsigned long) expires =3D 4295721093, (void (*)()) f=
unction =3D 0xFFFFFFD081EADF60, (u32) flags =3D 25165829, (u64) android_kab=
i_reserved1 =3D 0, (u64) android_kabi_reserved2 =3D 0),
>     (__u32) icsk_rto_=3D_16340,
>     (__u32) icsk_rto_min =3D 50,
>     (__u32) icsk_delack_max =3D 50,
>     (__u32) icsk_pmtu_cookie =3D 1500,
>     (const struct tcp_congestion_ops *) icsk_ca_ops =3D 0xFFFFFFD0830A944=
0,
>     (const struct inet_connection_sock_af_ops *) icsk_af_ops =3D 0xFFFFFF=
D082290FC8,
>     (const struct tcp_ulp_ops *) icsk_ulp_ops =3D 0x0,
>     (void *) icsk_ulp_data =3D 0x0,
>     (void (*)()) icsk_clean_acked =3D 0x0,
>     (unsigned int (*)()) icsk_sync_mss =3D 0xFFFFFFD081EA60EC,
>     (__u8:5) icsk_ca_state =3D 4,
>     (__u8:1) icsk_ca_initialized =3D 1,
>     (__u8:1) icsk_ca_setsockopt =3D 0,
>     (__u8:1) icsk_ca_dst_locked =3D 0,
>     (__u8) icsk_retransmits =3D 2,
>     (__u8) icsk_pending =3D 0,
>     (__u8) icsk_backoff =3D 0,
>     (__u8) icsk_syn_retries =3D 0,
>     (__u8) icsk_probes_out =3D 0,
>     (__u16) icsk_ext_hdr_len =3D 0,
>     (struct) icsk_ack =3D ((__u8) pending =3D 0, (__u8) quick =3D 15, (__=
u8) pingpong =3D 0, (__u8) retry =3D 0, (__u32) ato =3D 10, (unsigned long)=
 timeout =3D 4295721093, (__u32) lrcvtime =3D 753787, (__u16) last_seg_size=
 =3D 0, (__u16) rcv_mss =3D 1428),
>     (struct) icsk_mtup =3D ((int) search_high =3D 1480, (int) search_low =
=3D 1076, (u32:31) probe_size =3D 0, (u32:1) enabled =3D 0, (u32) probe_tim=
estamp =3D 0),
>     (u32) icsk_probes_tstamp =3D 0,
>     (u32) icsk_user_timeout =3D 0,
>     (u64) android_kabi_reserved1 =3D 0,
>     (u64 [13]) icsk_ca_priv =3D (0, 0, 0, 0, 0, 14482612842890526720, 144=
82612845143911684, 4294967295, 0, 0, 0, 0, 0)),

Hi Neal.

When you have a chance, could you take a look at this ramdump snapshot?

------ccw_gG03MnwfJa887GQ3nyBQr5B3liVAvqyN4ARSYk7GwfOF=_4f250_
Content-Type: text/plain; charset="utf-8"


------ccw_gG03MnwfJa887GQ3nyBQr5B3liVAvqyN4ARSYk7GwfOF=_4f250_--

