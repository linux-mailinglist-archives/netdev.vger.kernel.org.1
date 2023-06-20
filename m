Return-Path: <netdev+bounces-12346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB76737265
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BE21C20BE7
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1AC2AB3E;
	Tue, 20 Jun 2023 17:12:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1C2AB3A
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 17:12:41 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960CCD
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 10:12:39 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-Izxe4cpJMDmCWSuzrGaxAg-1; Tue, 20 Jun 2023 13:12:35 -0400
X-MC-Unique: Izxe4cpJMDmCWSuzrGaxAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83DC190A904;
	Tue, 20 Jun 2023 17:12:34 +0000 (UTC)
Received: from hog (unknown [10.39.195.41])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E3B714682F7;
	Tue, 20 Jun 2023 17:12:33 +0000 (UTC)
Date: Tue, 20 Jun 2023 19:12:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
Message-ID: <ZJHd_2g-3-e8TNQU@hog>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-3-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230620102856.56074-3-hare@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-20, 12:28:54 +0200, Hannes Reinecke wrote:
> tls_push_data() MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails
> out on MSG_EOR.
> But seeing that MSG_EOR is basically the opposite of
> MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
> MSG_EOR by treating it as the absence of MSG_MORE.
> Consequently we should return an error when both are set.
>=20
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  net/tls/tls_device.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index b82770f68807..ebefd148ecf5 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -440,11 +440,6 @@ static int tls_push_data(struct sock *sk,
>  =09int copy, rc =3D 0;
>  =09long timeo;
> =20
> -=09if (flags &
> -=09    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST |
> -=09      MSG_SPLICE_PAGES))
> -=09=09return -EOPNOTSUPP;
> -
>  =09if (unlikely(sk->sk_err))
>  =09=09return -sk->sk_err;
> =20
> @@ -536,6 +531,10 @@ static int tls_push_data(struct sock *sk,
>  =09=09=09=09more =3D true;
>  =09=09=09=09break;
>  =09=09=09}
> +=09=09=09if (flags & MSG_EOR) {
> +=09=09=09=09more =3D false;
> +=09=09=09=09break;

Why the break here? We don't want to close and push the record in that
case? (the "if (done || ...)" block just below)


> +=09=09=09}
> =20
>  =09=09=09done =3D true;
>  =09=09}

Thanks,

--=20
Sabrina


