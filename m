Return-Path: <netdev+bounces-49275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EB37F1746
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E092B1F24EA8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3E1D547;
	Mon, 20 Nov 2023 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77441BE
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 07:29:02 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-siBa_UR8NqG7mgPxKRS1aQ-1; Mon, 20 Nov 2023 10:28:57 -0500
X-MC-Unique: siBa_UR8NqG7mgPxKRS1aQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8BC683B8E7;
	Mon, 20 Nov 2023 15:28:56 +0000 (UTC)
Received: from hog (unknown [10.39.192.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DBD0440C6EBB;
	Mon, 20 Nov 2023 15:28:55 +0000 (UTC)
Date: Mon, 20 Nov 2023 16:28:54 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 2/8] iptfs: uapi: ip: add ip_tfs_*_hdr packet
 formats
Message-ID: <ZVt7Nud5U5FbUJ3f@hog>
References: <20231113035219.920136-1-chopps@chopps.org>
 <20231113035219.920136-3-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231113035219.920136-3-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-12, 22:52:13 -0500, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
>=20
> Add the on-wire basic and congestion-control IP-TFS packet headers.
>=20
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  include/uapi/linux/ip.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/uapi/linux/ip.h b/include/uapi/linux/ip.h
> index 283dec7e3645..cc83878ecf08 100644
> --- a/include/uapi/linux/ip.h
> +++ b/include/uapi/linux/ip.h
> @@ -137,6 +137,23 @@ struct ip_beet_phdr {
>  =09__u8 reserved;
>  };
> =20
> +struct ip_iptfs_hdr {
> +=09__u8 subtype;=09=09/* 0*: basic, 1: CC */
> +=09__u8 flags;
> +=09__be16 block_offset;
> +};
> +
> +struct ip_iptfs_cc_hdr {
> +=09__u8 subtype;=09=09/* 0: basic, 1*: CC */
> +=09__u8 flags;
> +=09__be16 block_offset;
> +=09__be32 loss_rate;
> +=09__u8 rtt_and_adelay1[4];
> +=09__u8 adelay2_and_xdelay[4];

Given how the fields are split, wouldn't it be more convenient to have
a single __be64, rather than reading some bits from multiple __u8?

> +=09__be32 tval;
> +=09__be32 techo;
> +};

I don't think these need to be part of uapi. Can we move them to
include/net/iptfs.h (or possibly net/xfrm/xfrm_iptfs.c)? It would also
make more sense to have them near the definitions for
IPTFS_SUBTYPE_*. And it would be easier to change how we split and
name fields for kernel consumption if we're not stuck with whatever we
put in uapi.

--=20
Sabrina


