Return-Path: <netdev+bounces-49443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CDD7F2138
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17388B217AC
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB63AC2C;
	Mon, 20 Nov 2023 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB694A2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:06:02 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-mKJTscJhOwGp8gJ0jCmz6w-1; Mon, 20 Nov 2023 18:05:58 -0500
X-MC-Unique: mKJTscJhOwGp8gJ0jCmz6w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C3BF185A780;
	Mon, 20 Nov 2023 23:05:58 +0000 (UTC)
Received: from hog (unknown [10.39.192.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E08492BFA;
	Mon, 20 Nov 2023 23:05:57 +0000 (UTC)
Date: Tue, 21 Nov 2023 00:05:56 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 4/8] iptfs: sysctl: allow configuration of
 global default values
Message-ID: <ZVvmVM3E7dtRK_Ei@hog>
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-5-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231113035219.920136-5-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-12, 22:52:15 -0500, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
>=20
> Add sysctls for the changing the IPTFS default SA values.
>=20
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  Documentation/networking/xfrm_sysctl.rst | 29 ++++++++++++++++++
>  include/net/netns/xfrm.h                 |  6 ++++
>  include/net/xfrm.h                       |  7 +++++
>  net/xfrm/xfrm_sysctl.c                   | 38 ++++++++++++++++++++++++
>  4 files changed, 80 insertions(+)
>=20
> diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/net=
working/xfrm_sysctl.rst
> index 47b9bbdd0179..9e628806c110 100644
> --- a/Documentation/networking/xfrm_sysctl.rst
> +++ b/Documentation/networking/xfrm_sysctl.rst
> @@ -9,3 +9,32 @@ XFRM Syscall
> =20
>  xfrm_acq_expires - INTEGER
>  =09default 30 - hard timeout in seconds for acquire requests
> +
> +xfrm_iptfs_maxqsize - UNSIGNED INTEGER
> +        The default IPTFS max output queue size in octets. The output qu=
eue is
> +        where received packets destined for output over an IPTFS tunnel =
are
> +        stored prior to being output in aggregated/fragmented form over =
the
> +        IPTFS tunnel.
> +
> +        Default 1M.
> +
> +xfrm_iptfs_drptime - UNSIGNED INTEGER

nit: Can we make those names a bit more human-readable?
xfrm_iptfs_droptime, or possibly xfrm_iptfs_drop_time for better
consistency with the netlink API.

> +        The default IPTFS drop time in microseconds. The drop time is th=
e amount
> +        of time before a missing out-of-order IPTFS tunnel packet is con=
sidered
> +        lost. See also the reorder window.
> +
> +        Default 1s (1000000).
> +
> +xfrm_iptfs_idelay - UNSIGNED INTEGER

I would suggest xfrm_iptfs_initial_delay (or at least init_delay like
the netlink attribute).

> +        The default IPTFS initial output delay in microseconds. The init=
ial
> +        output delay is the amount of time prior to servicing the output=
 queue
> +        after queueing the first packet on said queue.

Does that also apply if the queue was fully drained (no traffic for a
while) and starts being used again? That might be worth documenting
either way (sorry, I haven't processed the main patch far enough to
answer this question myself yet).

And it might be worth mentioning that all these sysctls can be
overridden per SA via the netlink API.

> +        Default 0.
> +
> +xfrm_iptfs_rewin - UNSIGNED INTEGER

xfrm_iptfs_reorderwin (or reorder_win, or reorder_window)?
I'd also make the equivalent netlink attribute's name a bit longer (at
least spell out REORDER, I can live with WIN for WINDOW).


[...]
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index c9bb0f892f55..d2e87344d175 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -2190,4 +2190,11 @@ static inline int register_xfrm_interface_bpf(void=
)
> =20
>  #endif
> =20
> +#if IS_ENABLED(CONFIG_XFRM_IPTFS)
> +#define XFRM_IPTFS_DEFAULT_MAX_QUEUE_SIZE (1024 * 1024)
> +#define XFRM_IPTFS_DEFAULT_INIT_DELAY_USECS (0)
> +#define XFRM_IPTFS_DEFAULT_DROP_TIME_USECS (1000000)
> +#define XFRM_IPTFS_DEFAULT_REORDER_WINDOW (3)
> +#endif

nit: move those to net/xfrm/xfrm_sysctl.c ? they're only used in that file.


> diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
> index 7fdeafc838a7..bf8e73a6c38e 100644
> --- a/net/xfrm/xfrm_sysctl.c
> +++ b/net/xfrm/xfrm_sysctl.c
[...]
> @@ -55,6 +87,12 @@ int __net_init xfrm_sysctl_init(struct net *net)
>  =09table[1].data =3D &net->xfrm.sysctl_aevent_rseqth;
>  =09table[2].data =3D &net->xfrm.sysctl_larval_drop;
>  =09table[3].data =3D &net->xfrm.sysctl_acq_expires;
> +#if IS_ENABLED(CONFIG_XFRM_IPTFS)
> +=09table[4].data =3D &net->xfrm.sysctl_iptfs_drptime;
> +=09table[5].data =3D &net->xfrm.sysctl_iptfs_idelay;
> +=09table[6].data =3D &net->xfrm.sysctl_iptfs_maxqsize;
> +=09table[7].data =3D &net->xfrm.sysctl_iptfs_rewin;
> +#endif

Is it time to switch to a loop like in ipv6_sysctl_net_init? See
commit d2f7e56d1e40 ("ipv6: Use math to point per net sysctls into the
appropriate struct net"). OTOH we don't add sysctls for xfrm very
often so it's not critical.

--=20
Sabrina


