Return-Path: <netdev+bounces-159659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B8FA16492
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 01:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E667E3A4ED8
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 00:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B362810E5;
	Mon, 20 Jan 2025 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EtxXYrCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300D137E
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737332117; cv=none; b=ScKnRA1JE8i5D9aPahQAT/jQ1/IHPDGr3T+0Te3g6e/rarzFeBsbXYCUVgW3nx7eyI9uplcg+9W6+8QtKWKyz+C0Hy/9cFtN/b2HcwsGudLEI96spq6jdsbbvjiywOWVOtBtOXe5obtpYapNQLRwMI0cPZ+jGSGjqTTLIFy0wJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737332117; c=relaxed/simple;
	bh=P8ujlkP1Ho2oam4AiphCApq5V0+RMyDaBMURZ4r2kUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=r48GuNqdTkUZHL0rFK/adtcDQ4f9LJZJ3lmicljd3E/rtwO/l1EWtkP/Zde6vMhcnIlShTlHMdW8l7MgkZZv0IjAQY9dm41gq/u2FM55qTieCvwWoeehVpWjV+gU9CKeoRrLH1VFA1043zTSP7TNykcShd/iyV0oFCX/TCyyCbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EtxXYrCQ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250120001506epoutp0466f42698d576a41b871d04e6f143acf1~cPlinIuiY0915209152epoutp04P
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 00:15:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250120001506epoutp0466f42698d576a41b871d04e6f143acf1~cPlinIuiY0915209152epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737332106;
	bh=K1I5770dfgNBxDuTMM8RDlFjZa8J7009T+UeriNxlXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EtxXYrCQ1Xnw5LpHVBgSE39uYHga/ydYUdlV/2G6FTCZlyPK7ekzaDW9dDLLKGhG9
	 HmOmXXiA+LIY2yXsenx09kEZ9ruchWhSj7uoFr7NJ522c2fqC55vbj7NmkbATTVPKx
	 JUMt6nYGg/ei5UMbqCpL/vlTKrGb1tWf7kEXZjx0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250120001505epcas2p3bba6451ed7017fde00b8be6299d87e22~cPlh5KZHQ2167921679epcas2p3J;
	Mon, 20 Jan 2025 00:15:05 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YbrSn2slGz4x9Pv; Mon, 20 Jan
	2025 00:15:05 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	F8.BB.22094.9859D876; Mon, 20 Jan 2025 09:15:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d~cPlg2eIm10808708087epcas2p1f;
	Mon, 20 Jan 2025 00:15:04 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250120001504epsmtrp17b3d79d58c2ea7937359f0bee1d00844~cPlg1nGgH1942219422epsmtrp1J;
	Mon, 20 Jan 2025 00:15:04 +0000 (GMT)
X-AuditID: b6c32a46-484397000000564e-ea-678d9589e9f2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.AB.23488.8859D876; Mon, 20 Jan 2025 09:15:04 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250120001504epsmtip11abd61177a117faa57dfa6c91fe754d2~cPlghle6V1216412164epsmtip1h;
	Mon, 20 Jan 2025 00:15:04 +0000 (GMT)
Date: Mon, 20 Jan 2025 09:18:48 +0900
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
Message-ID: <Z42WaFf9+oNkoBKJ@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADVnQykZYT+CTWD3Ss46aGHPp5KtKMYqKjLxEmd5DDgdG3gfDA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmuW7n1N50gye9ghbX9k5kt5hzvoXF
	Yt2uViaLZwtmsFg8PfaI3WLyFEaLpv2XmC0e9Z9gs7i6+x2zxYVtfawWl3fNYbPouLOXxeLY
	AjGLb6ffMFq0Pv7MbvHxeBO7xeIDn9gdBD22rLzJ5LFgU6nHplWdbB7v911l8+jbsorR4/Mm
	uQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDT
	lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZA
	hQnZGZO6vzIXLFvJWHH+43+WBsbvXYxdjJwcEgImEnOu7WHvYuTiEBLYwSjxeeMxZgjnE6PE
	xt+3oJxvjBKrV09lhWk59PcXC0RiL6PE25P3ofofMkqsPfiWBaSKRUBV4vP1t2AdbAK6EttO
	/ANbKCKgIXF30QNGkAZmgS3MEvcXfgRq4OAQFnCW+HvHFqSGV0BZom/PH3YIW1Di5MwnYDM5
	BQIl+rbfBVsmIXCFQ+LQzpdsECe5SLT1NLND2MISr45vgbKlJF72t0HZxRIN9yH+kRBoYZQ4
	df0FM0TCWGLWs3aw65gFMiUerznKCHKQBNAVR26xQIT5JDoO/2WHCPNKdLQJQXSqSfyasgEa
	kDISuxevYIYo8ZD43JsCCZP/LBKTHm1mmcAoNwvJO7OQLJsF1MIsoCmxfpc+RFhbYtnC18wQ
	YWmJ5f84kFQsYGRbxSiWWlCcm55abFRgBI/u5PzcTYzgdK3ltoNxytsPeocYmTgYDzFKcDAr
	ifCKfuhJF+JNSaysSi3Kjy8qzUktPsRoCoymicxSosn5wIyRVxJvaGJpYGJmZmhuZGpgriTO
	W72jJV1IID2xJDU7NbUgtQimj4mDU6qBSVb+6IUdWR1f902/1WPsxTtTmWdtG8v24LMZfzj3
	udv/qNxqIhlX8aX2jrzPnvOXUwWk5rM73D0U/JnP9UuewesyPaPIt0ebPjpLGtol/frN5yFl
	7xnop/TTpmxvYWbjGr3vWS9uuLo/njdVnDMvS3iLddOazKMHHk79ybfh+eoY2V3tch+sfylG
	TY5eLXLILN6z74m+6ZvFE749Ugyxyf3H/srzf2plIL/viQMBhvMt/u59IagUXuN4RnTaBNmp
	zYv17jyyL9gvNO/r3JKzykfuzZLJeFm58snTQD4FnsVtZ1uU0xt2tFgtOMPy88CV2qtaASJr
	Hz29V2sd3ML0eYHj51VnNG1y10i8vbx7nRJLcUaioRZzUXEiAHZT6+BgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnG7H1N50g7lbNCyu7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUVw2Kak5mWWpRfp2CVwZvWv6GAt2LmOseHD7AEsD47IOxi5GTg4JAROJQ39/sXQxcnEI
	CexmlNjdu4IZIiEjcXvlZVYIW1jifssRVoii+4wS53feYANJsAioSny+/hasiE1AV2LbiX9g
	U0UENCTuLnrACNLALLCNWeLW++tADRwcwgLOEn/v2ILU8AooS/Tt+cMOMXQti8TSSc+YIRKC
	EidnPmEBsZkF1CX+zLvEDNLLLCAtsfwfB0RYW2LZwtdg5ZwCgRJ92++yT2AUnIWkexaS7lkI
	3bOQdC9gZFnFKJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iREciVoaOxjffWvSP8TIxMF4
	iFGCg1lJhFf0Q0+6EG9KYmVValF+fFFpTmrxIUZpDhYlcd6VhhHpQgLpiSWp2ampBalFMFkm
	Dk6pBqacNzMnOC6NThSXmHX61oSyq+pKh8IvHl/UVpTtOC3qTUv14jR1CZeoy6KuB15efu62
	asXic3YVB16fDjFujtETahMTv+V08ZyB86kXbPOyzO9dv6d287yRop7F5Y9qEh+S5Q5aO2Ql
	ScsxVrwS/jNXbZpkn3XAkq+5/1ZP2TF9U3HPh+TFiVuiNPIZOKY8Pjwh7IdkYLfjh6XbJJsN
	Ml6VTJz1+sl6ruuXMoQfRxy5vaJkzsmirQJWD513+vAKK0QH7Myx7jnSnFT94ZXHYmbXGwyP
	U3NOMUxemRu1XqBIJFgzgVtydWmQzN5dvfKZq/IFY4QFOQsMNjQcN/gkuldULTs0adWeir3T
	5jrxlCuxFGckGmoxFxUnAgA1fNYrMwMAAA==
X-CMS-MailID: 20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----SrcW7MrhOsxo73KRAJKcKX_htP0vyS5nihip0MIRddcmiWbS=_2985c1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d
References: <20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
	<20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
	<CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
	<009e01db4620$f08f42e0$d1adc8a0$@samsung.com>
	<CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
	<Z4nl0h1IZ5R/KDEc@perf>
	<CADVnQykZYT+CTWD3Ss46aGHPp5KtKMYqKjLxEmd5DDgdG3gfDA@mail.gmail.com>
	<CGME20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d@epcas2p1.samsung.com>

------SrcW7MrhOsxo73KRAJKcKX_htP0vyS5nihip0MIRddcmiWbS=_2985c1_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, Jan 17, 2025 at 10:18:58AM -0500, Neal Cardwell wrote:
> On Fri, Jan 17, 2025 at 12:04=E2=80=AFAM Youngmin Nam <youngmin.nam@samsu=
ng.com> wrote:
> >
> > > Thanks for all the details! If the ramdump becomes available again at
> > > some point, would it be possible to pull out the following values as
> > > well:
> > >
> > > tp->mss_cache
> > > inet_csk(sk)->icsk_pmtu_cookie
> > > inet_csk(sk)->icsk_ca_state
> > >
> > > Thanks,
> > > neal
> > >
> >
> > Hi Neal. Happy new year.
> >
> > We are currently trying to capture a tcpdump during the problem situati=
on
> > to construct the Packetdrill script. However, this issue does not occur=
 very often.
> >
> > By the way, we have a full ramdump, so we can provide the information y=
ou requested.
> >
> > tp->packets_out =3D 0
> > tp->sacked_out =3D 0
> > tp->lost_out =3D 4
> > tp->retrans_out =3D 1
> > tcp_is_sack(tp) =3D 1
> > tp->mss_cache =3D 1428
> > inet_csk(sk)->icsk_ca_state =3D 4
> > inet_csk(sk)->icsk_pmtu_cookie =3D 1500
> >
> > If you need any specific information from the ramdump, please let me kn=
ow.
>=20
> The icsk_ca_state =3D 4 is interesting, since that's TCP_CA_Loss,
> indicating RTO recovery. Perhaps the socket suffered many recurring
> timeouts and timed out with ETIMEDOUT,
> causing the tcp_write_queue_purge() call that reset packets_out to
> 0... and then some race happened during the teardown process that
> caused another incoming packet to be processed in this resulting
> inconsistent state?
>=20
> Do you have a way to use GDB or a similar tool to print all the fields
> of the socket? Like:
>=20
>   (gdb)  p *(struct tcp_sock*) some_hex_address_goes_here
>=20
> ?
>=20
> If so, that could be useful in extracting further hints about what
> state this socket is in.
>=20
> If that's not possible, but a few extra fields are possible, would you
> be able to pull out the following:
>=20
> tp->retrans_stamp
> tp->tcp_mstamp
> icsk->icsk_retransmits
> icsk->icsk_backoff
> icsk->icsk_rto
>=20
> thanks,
> neal
>=20

Hi Neal,
Thank you for looking into this issue.
When we first encountered this issue, we also suspected that tcp_write_queu=
e_purge() was being called.
We can provide any information you would like to inspect.

tp->retrans_stamp =3D 3339228
tp->tcp_mstamp =3D 3552879949
icsk->icsk_retransmits =3D 2
icsk->icsk_backoff =3D 0
icsk->icsk_rto =3D 16340

Here is all the information about tcp_sock.

(struct tcp_sock *) tp =3D 0xFFFFFF88C1053C00 -> (
  (struct inet_connection_sock) inet_conn =3D ((struct inet_sock) icsk_inet=
 =3D ((struct sock) sk =3D ((struct sock_common) __sk_common =3D ((__addrpa=
ir) skc_addrpair =3D 13979358786200921654, (__be32) skc_daddr =3D 255714870=
, (__be32) skc_rcv_saddr =3D 3254823104, (unsigned int) skc_hash =3D 223433=
3897, (__u16 [2]) skc_u16hashes =3D (15049, 34093), (__portpair) skc_portpa=
ir =3D 3600464641, (__be16) skc_dport =3D 47873, (__u16) skc_num =3D 54938,=
 (unsigned short) skc_family =3D 10, (volatile unsigned char) skc_state =3D=
 4, (unsigned char:4) skc_reuse =3D 0, (unsigned char:1) skc_reuseport =3D =
0, (unsigned char:1) skc_ipv6only =3D 0, (unsigned char:1) skc_net_refcnt =
=3D 1, (int) skc_bound_dev_if =3D 0, (struct hlist_node) skc_bind_node =3D =
((struct hlist_node *) next =3D 0x0, (struct hlist_node * *) pprev =3D 0xFF=
FFFF881CE60AC0), (struct hlist_node) skc_portaddr_node =3D ((struct hlist_n=
ode *) next =3D 0x0, (struct hlist_node * *) pprev =3D 0xFFFFFF881CE60AC0),=
 (struct proto *) skc_prot =3D 0xFFFFFFD08322CFE0, (possible_net_t) skc_net=
 =3D ((struct net *) net =3D 0xFFFFFFD083316600), (struct in6_addr) skc_v6_=
daddr =3D ((union) in6_u =3D ((__u8 [16]) u6_addr8 =3D (0, 0, 0, 0, 0, 0, 0=
, 0, 0, 0, 255, 255, 54, 230, 61, 15), (__be16 [8]) u6_addr16 =3D (0, 0, 0,=
 0, 0, 65535, 58934, 3901), (__be32 [4]) u6_addr32 =3D (0, 0, 4294901760, 2=
55714870))), (struct in6_addr) skc_v6_rcv_saddr =3D ((union) in6_u =3D ((__=
u8 [16]) u6_addr8 =3D (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 192, 168, 0,=
 194), (__be16 [8]) u6_addr16 =3D (0, 0, 0, 0, 0, 65535, 43200, 49664), (__=
be32 [4]) u6_addr32 =3D (0, 0, 4294901760, 3254823104))), (atomic64_t) skc_=
cookie =3D ((s64) counter =3D 6016), (unsigned long) skc_flags =3D 769, (st=
ruct sock *) skc_listener =3D 0x0301, (struct inet_timewait_death_row *) sk=
c_tw_dr =3D 0x0301, (int [0]) skc_dontcopy_begin =3D (), (struct hlist_node=
) skc_node =3D ((struct hlist_node *) next =3D 0x7593, (struct hlist_node *=
 *) pprev =3D 0xFFFFFF882D49D648), (struct hlist_nulls_node) skc_nulls_node=
 =3D ((struct hlist_nulls_node *) next =3D 0x7593, (struct hlist_nulls_node=
 * *) pprev =3D 0xFFFFFF882D49D648), (unsigned short) skc_tx_queue_mapping =
=3D 65535, (unsigned short) skc_rx_queue_mapping =3D 65535, (int) skc_incom=
ing_cpu =3D 2, (u32) skc_rcv_wnd =3D 2, (u32) skc_tw_rcv_nxt =3D 2, (refcou=
nt_t) skc_refcnt =3D ((atomic_t) refs =3D ((int) counter =3D 2)), (int [0])=
 skc_dontcopy_end =3D (), (u32) skc_rxhash =3D 0, (u32) skc_window_clamp =
=3D 0, (u32) skc_tw_snd_nxt =3D 0), (struct dst_entry *) sk_rx_dst =3D 0xFF=
FFFF8821384F00, (int) sk_rx_dst_ifindex =3D 14, (u32) sk_rx_dst_cookie =3D =
0, (socket_lock_t) sk_lock =3D ((spinlock_t) slock =3D ((struct raw_spinloc=
k) rlock =3D ((arch_spinlock_t) raw_lock =3D ((atomic_t) val =3D ((int) cou=
nter =3D 1), (u8) locked =3D 1, (u8) pending =3D 0, (u16) locked_pending =
=3D 1, (u16) tail =3D 0))), (int) owned =3D 0, (wait_queue_head_t) wq =3D (=
(spinlock_t) lock =3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t) r=
aw_loc
  (u16) tcp_header_len =3D 32,
  (u16) gso_segs =3D 26,
  (__be32) pred_flags =3D 2566918272,
  (u64) bytes_received =3D 7950,
  (u32) segs_in =3D 21,
  (u32) data_segs_in =3D 12,
  (u32) rcv_nxt =3D 2956372822,
  (u32) copied_seq =3D 2956372822,
  (u32) rcv_wup =3D 2956372822,
  (u32) snd_nxt =3D 2253384964,
  (u32) segs_out =3D 30,
  (u32) data_segs_out =3D 13,
  (u64) bytes_sent =3D 11381,
  (u64) bytes_acked =3D 3841,
  (u32) dsack_dups =3D 0,
  (u32) snd_una =3D 2253381091,
  (u32) snd_sml =3D 2253384964,
  (u32) rcv_tstamp =3D 757520,
  (u32) lsndtime =3D 768000,
  (u32) last_oow_ack_time =3D 750065,
  (u32) compressed_ack_rcv_nxt =3D 2956370839,
  (u32) tsoffset =3D 1072186408,
  (struct list_head) tsq_node =3D ((struct list_head *) next =3D 0xFFFFFF88=
C1054260, (struct list_head *) prev =3D 0xFFFFFF88C1054260),
  (struct list_head) tsorted_sent_queue =3D ((struct list_head *) next =3D =
0xFFFFFF88C1054270, (struct list_head *) prev =3D 0xFFFFFF88C1054270),
  (u32) snd_wl1 =3D 2956372861,
  (u32) snd_wnd =3D 78336,
  (u32) max_window =3D 78336,
  (u32) mss_cache =3D 1428,
  (u32) window_clamp =3D 2752512,
  (u32) rcv_ssthresh =3D 91439,
  (u8) scaling_ratio =3D 84,
  (struct tcp_rack) rack =3D ((u64) mstamp =3D 3312043553, (u32) rtt_us =3D=
 3103952, (u32) end_seq =3D 2253381091, (u32) last_delivered =3D 0, (u8) re=
o_wnd_steps =3D 1, (u8:5) reo_wnd_persist =3D 0, (u8:1) dsack_seen =3D 0, (=
u8:1) advanced =3D 1),
  (u16) advmss =3D 1448,
  (u8) compressed_ack =3D 0,
  (u8:2) dup_ack_counter =3D 2,
  (u8:1) tlp_retrans =3D 1,
  (u8:5) unused =3D 0,
  (u32) chrono_start =3D 780636,
  (u32 [3]) chrono_stat =3D (30386, 0, 0),
  (u8:2) chrono_type =3D 1,
  (u8:1) rate_app_limited =3D 1,
  (u8:1) fastopen_connect =3D 0,
  (u8:1) fastopen_no_cookie =3D 0,
  (u8:1) is_sack_reneg =3D 0,
  (u8:2) fastopen_client_fail =3D 0,
  (u8:4) nonagle =3D 0,
  (u8:1) thin_lto =3D 0,
  (u8:1) recvmsg_inq =3D 0,
  (u8:1) repair =3D 0,
  (u8:1) frto =3D 1,
  (u8) repair_queue =3D 0,
  (u8:2) save_syn =3D 0,
  (u8:1) syn_data =3D 0,
  (u8:1) syn_fastopen =3D 0,
  (u8:1) syn_fastopen_exp =3D 0,
  (u8:1) syn_fastopen_ch =3D 0,
  (u8:1) syn_data_acked =3D 0,
  (u8:1) is_cwnd_limited =3D 1,
  (u32) tlp_high_seq =3D 0,
  (u32) tcp_tx_delay =3D 0,
  (u64) tcp_wstamp_ns =3D 3371996070858,
  (u64) tcp_clock_cache =3D 3552879949296,
  (u64) tcp_mstamp =3D 3552879949,
  (u32) srtt_us =3D 29633751,
  (u32) mdev_us =3D 10160190,
  (u32) mdev_max_us =3D 10160190,
  (u32) rttvar_us =3D 12632227,
  (u32) rtt_seq =3D 2253383947,
  (struct minmax) rtt_min =3D ((struct minmax_sample [3]) s =3D (((u32) t =
=3D 753091, (u32) v =3D 330326), ((u32) t =3D 753091, (u32) v =3D 330326), =
((u32) t =3D 753091, (u32) v =3D 330326))),
  (u32) packets_out =3D 0,
  (u32) retrans_out =3D 1,
  (u32) max_packets_out =3D 4,
  (u32) cwnd_usage_seq =3D 2253384964,
  (u16) urg_data =3D 0,
  (u8) ecn_flags =3D 0,
  (u8) keepalive_probes =3D 0,
  (u32) reordering =3D 3,
  (u32) reord_seen =3D 0,
  (u32) snd_up =3D 2253381091,
  (struct tcp_options_received) rx_opt =3D ((int) ts_recent_stamp =3D 3330,=
 (u32) ts_recent =3D 1119503967, (u32) rcv_tsval =3D 1119728668, (u32) rcv_=
tsecr =3D 3312043, (u16:1) saw_tstamp =3D 1, (u16:1) tstamp_ok =3D 1, (u16:=
1) dsack =3D 0, (u16:1) wscale_ok =3D 1, (u16:3) sack_ok =3D 1, (u16:1) smc=
_ok =3D 0, (u16:4) snd_wscale =3D 9, (u16:4) rcv_wscale =3D 9, (u8:1) saw_u=
nknown =3D 0, (u8:7) unused =3D 0, (u8) num_sacks =3D 0, (u16) user_mss =3D=
 0, (u16) mss_clamp =3D 1440),
  (u32) snd_ssthresh =3D 7,
  (u32) snd_cwnd =3D 1,
  (u32) snd_cwnd_cnt =3D 0,
  (u32) snd_cwnd_clamp =3D 4294967295,
  (u32) snd_cwnd_used =3D 0,
  (u32) snd_cwnd_stamp =3D 768000,
  (u32) prior_cwnd =3D 10,
  (u32) prr_delivered =3D 0,
  (u32) prr_out =3D 0,
  (u32) delivered =3D 7,
  (u32) delivered_ce =3D 0,
  (u32) lost =3D 8,
  (u32) app_limited =3D 8,
  (u64) first_tx_mstamp =3D 3312043553,
  (u64) delivered_mstamp =3D 3315147505,
  (u32) rate_delivered =3D 1,
  (u32) rate_interval_us =3D 330326,
  (u32) rcv_wnd =3D 91648,
  (u32) write_seq =3D 2253384964,
  (u32) notsent_lowat =3D 0,
  (u32) pushed_seq =3D 2253384963,
  (u32) lost_out =3D 4,
  (u32) sacked_out =3D 0,
  (struct hrtimer) pacing_timer =3D ((struct timerqueue_node) node =3D ((st=
ruct rb_node) node =3D ((unsigned long) __rb_parent_color =3D 1844674356155=
1823800, (struct rb_node *) rb_right =3D 0x0, (struct rb_node *) rb_left =
=3D 0x0), (ktime_t) expires =3D 0), (ktime_t) _softexpires =3D 0, (enum hrt=
imer_restart (*)()) function =3D 0xFFFFFFD081EA565C, (struct hrtimer_clock_=
base *) base =3D 0xFFFFFF8962589DC0, (u8) state =3D 0, (u8) is_rel =3D 0, (=
u8) is_soft =3D 1, (u8) is_hard =3D 0, (u64) android_kabi_reserved1 =3D 0),
  (struct hrtimer) compressed_ack_timer =3D ((struct timerqueue_node) node =
=3D ((struct rb_node) node =3D ((unsigned long) __rb_parent_color =3D 18446=
743561551823872, (struct rb_node *) rb_right =3D 0x0, (struct rb_node *) rb=
_left =3D 0x0), (ktime_t) expires =3D 0), (ktime_t) _softexpires =3D 0, (en=
um hrtimer_restart (*)()) function =3D 0xFFFFFFD081EAE348, (struct hrtimer_=
clock_base *) base =3D 0xFFFFFF8962589DC0, (u8) state =3D 0, (u8) is_rel =
=3D 0, (u8) is_soft =3D 1, (u8) is_hard =3D 0, (u64) android_kabi_reserved1=
 =3D 0),
  (struct sk_buff *) lost_skb_hint =3D 0x0,
  (struct sk_buff *) retransmit_skb_hint =3D 0x0,
  (struct rb_root) out_of_order_queue =3D ((struct rb_node *) rb_node =3D 0=
x0),
  (struct sk_buff *) ooo_last_skb =3D 0xFFFFFF891768FB00,
  (struct tcp_sack_block [1]) duplicate_sack =3D (((u32) start_seq =3D 2956=
372143, (u32) end_seq =3D 2956372822)),
  (struct tcp_sack_block [4]) selective_acks =3D (((u32) start_seq =3D 2956=
371078, (u32) end_seq =3D 2956372143), ((u32) start_seq =3D 0, (u32) end_se=
q =3D 0), ((u32) start_seq =3D 0, (u32) end_seq =3D 0), ((u32) start_seq =
=3D 0, (u32) end_seq =3D 0)),
  (struct tcp_sack_block [4]) recv_sack_cache =3D (((u32) start_seq =3D 0, =
(u32) end_seq =3D 0), ((u32) start_seq =3D 0, (u32) end_seq =3D 0), ((u32) =
start_seq =3D 0, (u32) end_seq =3D 0), ((u32) start_seq =3D 0, (u32) end_se=
q =3D 0)),
  (struct sk_buff *) highest_sack =3D 0x0,
  (int) lost_cnt_hint =3D 0,
  (u32) prior_ssthresh =3D 2147483647,
  (u32) high_seq =3D 2253384964,
  (u32) retrans_stamp =3D 3339228,
  (u32) undo_marker =3D 2253381091,
  (int) undo_retrans =3D 3,
  (u64) bytes_retrans =3D 3669,
  (u32) total_retrans =3D 6,
  (u32) urg_seq =3D 0,
  (unsigned int) keepalive_time =3D 0,
  (unsigned int) keepalive_intvl =3D 0,
  (int) linger2 =3D 0,
  (u8) bpf_sock_ops_cb_flags =3D 0,
  (u8:1) bpf_chg_cc_inprogress =3D 0,
  (u16) timeout_rehash =3D 5,
  (u32) rcv_ooopack =3D 2,
  (u32) rcv_rtt_last_tsecr =3D 3312043,
  (struct) rcv_rtt_est =3D ((u32) rtt_us =3D 0, (u32) seq =3D 2956431836, (=
u64) time =3D 3301136665),
  (struct) rcvq_space =3D ((u32) space =3D 14480, (u32) seq =3D 2956364872,=
 (u64) time =3D 3300257291),
  (struct) mtu_probe =3D ((u32) probe_seq_start =3D 0, (u32) probe_seq_end =
=3D 0),
  (u32) plb_rehash =3D 0,
  (u32) mtu_info =3D 0,
  (struct tcp_fastopen_request *) fastopen_req =3D 0x0,
  (struct request_sock *) fastopen_rsk =3D 0x0,
  (struct saved_syn *) saved_syn =3D 0x0,
  (u64) android_oem_data1 =3D 0,
  (u64) android_kabi_reserved1 =3D 0)

And here are the details of inet_connection_sock.

(struct tcp_sock *) tp =3D 0xFFFFFF88C1053C00 -> (
  (struct inet_connection_sock) inet_conn =3D (
    (struct inet_sock) icsk_inet =3D ((struct sock) sk =3D ((struct sock_co=
mmon) __sk_common =3D ((__addrpair) skc_addrpair =3D 13979358786200921654, =
(__be32) skc_daddr =3D 255714870, (__be32) skc_rcv_saddr =3D 3254823104, (u=
nsigned int) skc_hash =3D 2234333897, (__u16 [2]) skc_u16hashes =3D (15049,=
 34093), (__portpair) skc_portpair =3D 3600464641, (__be16) skc_dport =3D 4=
7873, (__u16) skc_num =3D 54938, (unsigned short) skc_family =3D 10, (volat=
ile unsigned char) skc_state =3D 4, (unsigned char:4) skc_reuse =3D 0, (uns=
igned char:1) skc_reuseport =3D 0, (unsigned char:1) skc_ipv6only =3D 0, (u=
nsigned char:1) skc_net_refcnt =3D 1, (int) skc_bound_dev_if =3D 0, (struct=
 hlist_node) skc_bind_node =3D ((struct hlist_node *) next =3D 0x0, (struct=
 hlist_node * *) pprev =3D 0xFFFFFF881CE60AC0), (struct hlist_node) skc_por=
taddr_node =3D ((struct hlist_node *) next =3D 0x0, (struct hlist_node * *)=
 pprev =3D 0xFFFFFF881CE60AC0), (struct proto *) skc_prot =3D 0xFFFFFFD0832=
2CFE0, (possible_net_t) skc_net =3D ((struct net *) net =3D 0xFFFFFFD083316=
600), (struct in6_addr) skc_v6_daddr =3D ((union) in6_u =3D ((__u8 [16]) u6=
_addr8 =3D (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 54, 230, 61, 15), (__be=
16 [8]) u6_addr16 =3D (0, 0, 0, 0, 0, 65535, 58934, 3901), (__be32 [4]) u6_=
addr32 =3D (0, 0, 4294901760, 255714870))), (struct in6_addr) skc_v6_rcv_sa=
ddr =3D ((union) in6_u =3D ((__u8 [16]) u6_addr8 =3D (0, 0, 0, 0, 0, 0, 0, =
0, 0, 0, 255, 255, 192, 168, 0, 194), (__be16 [8]) u6_addr16 =3D (0, 0, 0, =
0, 0, 65535, 43200, 49664), (__be32 [4]) u6_addr32 =3D (0, 0, 4294901760, 3=
254823104))), (atomic64_t) skc_cookie =3D ((s64) counter =3D 6016), (unsign=
ed long) skc_flags =3D 769, (struct sock *) skc_listener =3D 0x0301, (struc=
t inet_timewait_death_row *) skc_tw_dr =3D 0x0301, (int [0]) skc_dontcopy_b=
egin =3D (), (struct hlist_node) skc_node =3D ((struct hlist_node *) next =
=3D 0x7593, (struct hlist_node * *) pprev =3D 0xFFFFFF882D49D648), (struct =
hlist_nulls_node) skc_nulls_node =3D ((struct hlist_nulls_node *) next =3D =
0x7593, (struct hlist_nulls_node * *) pprev =3D 0xFFFFFF882D49D648), (unsig=
ned short) skc_tx_queue_mapping =3D 65535, (unsigned short) skc_rx_queue_ma=
pping =3D 65535, (int) skc_incoming_cpu =3D 2, (u32) skc_rcv_wnd =3D 2, (u3=
2) skc_tw_rcv_nxt =3D 2, (refcount_t) skc_refcnt =3D ((atomic_t) refs =3D (=
(int) counter =3D 2)), (int [0]) skc_dontcopy_end =3D (), (u32) skc_rxhash =
=3D 0, (u32) skc_window_clamp =3D 0, (u32) skc_tw_snd_nxt =3D 0), (struct d=
st_entry *) sk_rx_dst =3D 0xFFFFFF8821384F00, (int) sk_rx_dst_ifindex =3D 1=
4, (u32) sk_rx_dst_cookie =3D 0, (socket_lock_t) sk_lock =3D ((spinlock_t) =
slock =3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D =
((atomic_t) val =3D ((int) counter =3D 1), (u8) locked =3D 1, (u8) pending =
=3D 0, (u16) locked_pending =3D 1, (u16) tail =3D 0))), (int) owned =3D 0, =
(wait_queue_head_t) wq =3D ((spinlock_t) lock =3D ((struct raw_spinlock) rl=
ock =3D ((arch_spinlock_t) raw_lock =3D ((atomic_t) val =3D ((int) counter =
=3D 0), (u8) locked =3D 0, (u8) pending =3D 0, (u16) locked_pending =3D 0, =
(u16) tail =3D 0))), (struct list_head) head =3D ((struct list_head *) next=
 =3D 0xFFFFFF88C1053CA8, (struct list_head *) prev =3D 0xFFFFFF88C1053CA8))=
), (atomic_t) sk_drops =3D ((int) counter =3D 7), (int) sk_rcvlowat =3D 1, =
(struct sk_buff_head) sk_error_queue =3D ((struct sk_buff *) next =3D 0xFFF=
FFF88C1053CC0, (struct sk_buff *) prev =3D 0xFFFFFF88C1053CC0, (struct sk_b=
uff_list) list =3D ((struct sk_buff *) next =3D 0xFFFFFF88C1053CC0, (struct=
 sk_buff *) prev =3D 0xFFFFFF88C1053CC0), (__u32) qlen =3D 0, (spinlock_t) =
lock =3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D (=
(atomic_t) val =3D ((int) counter =3D 0), (u8) locked =3D 0, (u8) pending =
=3D 0, (u16) locked_pending =3D 0, (u16) tail =3D 0)))), (struct sk_buff_he=
ad) sk_receive_queue =3D ((struct sk_buff *) next =3D 0xFFFFFF88C1053CD8, (=
struct sk_buff *) prev =3D 0xFFFFFF88C1053CD8, (struct sk_buff_list) list =
=3D ((struct sk_buff *) next =3D 0xFFFFFF88C1053CD8, (struct sk_buff *) pre=
v =3D 0xFFFFFF88C1053CD8), (__u32) qlen =3D 0, (spinlock_t) lock =3D ((stru=
ct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D ((atomic_t) val =
=3D ((int) counter =3D 0), (u8) locked =3D 0, (u8) pending =3D 0, (u16) loc=
ked_pending =3D 0, (u16) tail =3D 0)))), (struct) sk_backlog =3D ((at
    (struct request_sock_queue) icsk_accept_queue =3D ((spinlock_t) rskq_lo=
ck =3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D ((a=
tomic_t) val =3D ((int) counter =3D 0), (u8) locked =3D 0, (u8) pending =3D=
 0, (u16) locked_pending =3D 0, (u16) tail =3D 0))), (u8) rskq_defer_accept=
 =3D 0, (u32) synflood_warned =3D 0, (atomic_t) qlen =3D ((int) counter =3D=
 0), (atomic_t) young =3D ((int) counter =3D 0), (struct request_sock *) rs=
kq_accept_head =3D 0x0, (struct request_sock *) rskq_accept_tail =3D 0x0, (=
struct fastopen_queue) fastopenq =3D ((struct request_sock *) rskq_rst_head=
 =3D 0x0, (struct request_sock *) rskq_rst_tail =3D 0x0, (spinlock_t) lock =
=3D ((struct raw_spinlock) rlock =3D ((arch_spinlock_t) raw_lock =3D ((atom=
ic_t) val =3D ((int) counter =3D 0), (u8) locked =3D 0, (u8) pending =3D 0,=
 (u16) locked_pending =3D 0, (u16) tail =3D 0))), (int) qlen =3D 0, (int) m=
ax_qlen =3D 0, (struct tcp_fastopen_context *) ctx =3D 0x0)),
    (struct inet_bind_bucket *) icsk_bind_hash =3D 0xFFFFFF881CE60A80,
    (struct inet_bind2_bucket *) icsk_bind2_hash =3D 0xFFFFFF881B1FD500,
    (unsigned long) icsk_timeout =3D 4295751636,
    (struct timer_list) icsk_retransmit_timer =3D ((struct hlist_node) entr=
y =3D ((struct hlist_node *) next =3D 0xDEAD000000000122, (struct hlist_nod=
e * *) pprev =3D 0x0), (unsigned long) expires =3D 4295751636, (void (*)())=
 function =3D 0xFFFFFFD081EADE28, (u32) flags =3D 1056964613, (u64) android=
_kabi_reserved1 =3D 0, (u64) android_kabi_reserved2 =3D 0),
    (struct timer_list) icsk_delack_timer =3D ((struct hlist_node) entry =
=3D ((struct hlist_node *) next =3D 0xDEAD000000000122, (struct hlist_node =
* *) pprev =3D 0x0), (unsigned long) expires =3D 4295721093, (void (*)()) f=
unction =3D 0xFFFFFFD081EADF60, (u32) flags =3D 25165829, (u64) android_kab=
i_reserved1 =3D 0, (u64) android_kabi_reserved2 =3D 0),
    (__u32) icsk_rto_=3D_16340,
    (__u32) icsk_rto_min =3D 50,
    (__u32) icsk_delack_max =3D 50,
    (__u32) icsk_pmtu_cookie =3D 1500,
    (const struct tcp_congestion_ops *) icsk_ca_ops =3D 0xFFFFFFD0830A9440,
    (const struct inet_connection_sock_af_ops *) icsk_af_ops =3D 0xFFFFFFD0=
82290FC8,
    (const struct tcp_ulp_ops *) icsk_ulp_ops =3D 0x0,
    (void *) icsk_ulp_data =3D 0x0,
    (void (*)()) icsk_clean_acked =3D 0x0,
    (unsigned int (*)()) icsk_sync_mss =3D 0xFFFFFFD081EA60EC,
    (__u8:5) icsk_ca_state =3D 4,
    (__u8:1) icsk_ca_initialized =3D 1,
    (__u8:1) icsk_ca_setsockopt =3D 0,
    (__u8:1) icsk_ca_dst_locked =3D 0,
    (__u8) icsk_retransmits =3D 2,
    (__u8) icsk_pending =3D 0,
    (__u8) icsk_backoff =3D 0,
    (__u8) icsk_syn_retries =3D 0,
    (__u8) icsk_probes_out =3D 0,
    (__u16) icsk_ext_hdr_len =3D 0,
    (struct) icsk_ack =3D ((__u8) pending =3D 0, (__u8) quick =3D 15, (__u8=
) pingpong =3D 0, (__u8) retry =3D 0, (__u32) ato =3D 10, (unsigned long) t=
imeout =3D 4295721093, (__u32) lrcvtime =3D 753787, (__u16) last_seg_size =
=3D 0, (__u16) rcv_mss =3D 1428),
    (struct) icsk_mtup =3D ((int) search_high =3D 1480, (int) search_low =
=3D 1076, (u32:31) probe_size =3D 0, (u32:1) enabled =3D 0, (u32) probe_tim=
estamp =3D 0),
    (u32) icsk_probes_tstamp =3D 0,
    (u32) icsk_user_timeout =3D 0,
    (u64) android_kabi_reserved1 =3D 0,
    (u64 [13]) icsk_ca_priv =3D (0, 0, 0, 0, 0, 14482612842890526720, 14482=
612845143911684, 4294967295, 0, 0, 0, 0, 0)),

------SrcW7MrhOsxo73KRAJKcKX_htP0vyS5nihip0MIRddcmiWbS=_2985c1_
Content-Type: text/plain; charset="utf-8"


------SrcW7MrhOsxo73KRAJKcKX_htP0vyS5nihip0MIRddcmiWbS=_2985c1_--

