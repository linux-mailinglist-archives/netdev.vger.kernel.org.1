Return-Path: <netdev+bounces-135492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D775B99E1C4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FACB21DE6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3A1D0942;
	Tue, 15 Oct 2024 08:57:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0481CDA36
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982620; cv=none; b=kyzljmgnI6d78DOPN3pzpGLibIsr24yxUToUU6POfenZgab0dY12AlPAFcSN8Ss00eJks1fQEc1il0VcNBZO7FUpmEs4F9hZQfhFh0ZyyUazU+U4MvAwgJ4QQTtS34oqWR9qv/rlHkLIW8e4Y2Z99BTowSZAOGRFt7vOFr6CZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982620; c=relaxed/simple;
	bh=xWYT42Mk4N6nTMeYLFExYUxKwsbVSPSIqOH2DV1hxsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uDouOF2xoY4FJ23rlkU4w7le5kJffnFJalJ4ISa+8uo/yTnU7wlCZpDr0c1ppdMcoisli/YXL+HARXeUcHXzzlprcS/ljs8vi7sc//yonfSOAkKJASu+NAKXPbDUoWacubSHEe8Xj3+yU1J+Uk/4P8SRyXiCcEtXdCWnBbx0CO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-f18wAixrMhmte5s3R_P7_g-1; Tue,
 15 Oct 2024 04:56:45 -0400
X-MC-Unique: f18wAixrMhmte5s3R_P7_g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51D851955F2C;
	Tue, 15 Oct 2024 08:56:43 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39F471956056;
	Tue, 15 Oct 2024 08:56:38 +0000 (UTC)
Date: Tue, 15 Oct 2024 10:56:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>, Chris Mi <cmi@nvidia.com>
Subject: Re: [PATCH net] macsec: Fix use-after-free while sending the
 offloading packet
Message-ID: <Zw4uRHzqS05UBMCg@hog>
References: <20241014090720.189898-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241014090720.189898-1-tariqt@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-10-14, 12:07:20 +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
>=20
> KASAN reports the following UAF. The metadata_dst, which is used to
> store the SCI value for macsec offload, is already freed by
> metadata_dst_free() in macsec_free_netdev(), while driver still use it
> for sending the packet.
>=20
> To fix this issue, dst_release() is used instead to release
> metadata_dst. So it is not freed instantly in macsec_free_netdev() if
> still referenced by skb.

Ok. Then that packet is going to get dropped when it reaches the
driver, right? At this point the TXSA we need shouldn't be configured
anymore, so the driver/NIC won't be able to handle that skb. It would
be bad if we just sent the packet unencrypted.


> Fixes: 0a28bfd4971f ("net/macsec: Add MACsec skb_metadata_dst Tx Data pat=
h support")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Chris Mi <cmi@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/macsec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 12d1b205f6d1..7076dedfa3be 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -3817,7 +3817,7 @@ static void macsec_free_netdev(struct net_device *d=
ev)
>  =09struct macsec_dev *macsec =3D macsec_priv(dev);
> =20
>  =09if (macsec->secy.tx_sc.md_dst)

nit: dst_release checks that dst is not NULL, so we don't need this
test that I added in commit c52add61c27e ("macsec: don't free NULL
metadata_dst")

> -=09=09metadata_dst_free(macsec->secy.tx_sc.md_dst);
> +=09=09dst_release(&macsec->secy.tx_sc.md_dst->dst);
>  =09free_percpu(macsec->stats);
>  =09free_percpu(macsec->secy.tx_sc.stats);
> =20
> --=20
> 2.44.0
>=20

--=20
Sabrina


