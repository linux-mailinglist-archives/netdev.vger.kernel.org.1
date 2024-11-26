Return-Path: <netdev+bounces-147489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104F9D9D3B
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA381641B8
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DB61DB55C;
	Tue, 26 Nov 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLAH41PZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D0BA3F
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644971; cv=none; b=aMTyFPn+aQp95W9TUyV4HN5IoQSuYnqHX67JbdWsmvmoUFETn7G7YBVT+Ln6ladNzYsiMyxeTlpXvzjdbq676qe54w6ec+h02iIOxwhjp2snyZyUIDmVMMX7OQ0hZI1bgN8tbhoDm5PlOxt45zFCQFn0dzj7HXXg5Qf4JEERRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644971; c=relaxed/simple;
	bh=kZVQM9xBrwh6IK4X4iq+YiO//9mc5zYtX5MPMs2B5Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGvumqGOUuhWgoTpTCwLReF+6g3pm8ldGH3jIgpIGlJDUKdd9s/rYZF0kYhHbppmSUgiPjM1BlkR/xCIJSHLlexsxSJuO5Ia6PHETXz4hT7o4vCCNbHVPz1F6W/yDgkbZHCGmojRwgvcusuO/X3XDhWLFTgOUXT5vSAzXC88XJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLAH41PZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732644968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f8G9ISwVZXa5JJ9k1DSJBqn0E7TUnWgpcZYyV9NgZ8E=;
	b=DLAH41PZecr9CmHisw+nlwEPApbaJs6tpfx6EE98lGRr+W1Up2AUCT4h99DwtydJOWv3dN
	D6JBSDoX+Zogrc6ACShfSncVh0hiOFj7TdFOH/dw7CZLQdxPndZodSE4vsLG6VipxXlf7T
	J7KKqOrpJz6js4C+J7MRexzG/ON78B8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-QmcVJxOcPv2XrxipVy2H-Q-1; Tue, 26 Nov 2024 13:16:03 -0500
X-MC-Unique: QmcVJxOcPv2XrxipVy2H-Q-1
X-Mimecast-MFC-AGG-ID: QmcVJxOcPv2XrxipVy2H-Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38233ea8c1bso19987f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 10:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644962; x=1733249762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8G9ISwVZXa5JJ9k1DSJBqn0E7TUnWgpcZYyV9NgZ8E=;
        b=jqo6hIkcjec24h+eHnbXiSBRD11x8+uRu9VI+aKV60cSRrsqKX3e4SCfC+qo6HYRNL
         vjLsJ1uPjRjD1y2+8p+IHu9LcveLstwVUNi75qBcwwfi/amKAyB/5TXQnvSQuT6tJxlT
         5kaW9TqrTIpp2zqiRY9lR5TA8I5cl8FOLIOZu0kRtIpK3XASrjgBqs0ddKRD9DA0zogK
         aZmHmzIjL0lBx+doUOduAffAl9w4+wFouldUN5zQPd2e4qHhvPTvYwCIvEAb3qEDqOx7
         mcL2OBjeIYmnJ0/YPW6ld9dfJnNbpvNRBTJYsLZl5SPl26yGCcI8M5Y9ySQ13U+JWY9W
         FGxg==
X-Forwarded-Encrypted: i=1; AJvYcCXDweoQANOXmyT9cjOWY/X+tVHkSY2kEToxqejjgUYsviuVdXtILxsImJRD5lm7pIFIc1/mj9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA17B68m4JFulnZGHy9UbLmnKkT6esMo+x6EDtOupHfV0FmheQ
	cxlyy1QZPEyeiBPQ4MzhEC7wPOMjWLwo47n7Mh9AspZTXo55q98mIKx9htnaUqDoi1FMgbdhZBQ
	3hvRngiP6nGRKccQcpvrkCaAk27c9Ouo2iBVNhV2zRmyLSfPzzu4Cnw==
X-Gm-Gg: ASbGnctgr45o2yKHwyNRSYoMu8MNJU+yP9SU8DJ/S331Z0ORk0yvckDPVgggEzhG3SN
	Va4gpdUAf4qjnhr0i6muV/HiSOThyh0nywKzLXjgTKYph1WK7Tr22OCGWNhksp8Wn2r3o27kb5T
	wKZ7ehAM/qfpgwhICCARAuBm5Vnmci2i+MrIpCBu5CuVApxWuQINOlLnywpXxR+CI+f8TGYV+xr
	wy47rcmyQiq3//QI9wlTqQQtoCnzjDfC533qVCJuemiopsJU5gP4iASbwlAEUJK8KpmmCBGEAmW
	c9v6ruopWHmqV/YAJDvm7g==
X-Received: by 2002:a5d:6484:0:b0:382:5a29:199 with SMTP id ffacd0b85a97d-385bfae8583mr3933272f8f.11.1732644962504;
        Tue, 26 Nov 2024 10:16:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1yhFPUkHGrcDD2n2g/govLWYhFZ1U+H7BCWuWoeOCQMP3qng9A9eE4WHuBMOc/cwhow55ww==
X-Received: by 2002:a5d:6484:0:b0:382:5a29:199 with SMTP id ffacd0b85a97d-385bfae8583mr3933234f8f.11.1732644962089;
        Tue, 26 Nov 2024 10:16:02 -0800 (PST)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a02f2ea1sm74630915e9.34.2024.11.26.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:16:01 -0800 (PST)
Date: Tue, 26 Nov 2024 19:16:00 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Til Kaiser <mail@tk154.de>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] mediathek: mtk_eth_soc: fix netdev inside
 xdp_rxq_info
Message-ID: <Z0YQYKgUyLt8w4va@lore-desk>
References: <20241126134707.253572-1-mail@tk154.de>
 <20241126134707.253572-2-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uvb7q/nk1Bce8w0/"
Content-Disposition: inline
In-Reply-To: <20241126134707.253572-2-mail@tk154.de>


--uvb7q/nk1Bce8w0/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Currently, the network device isn't set inside the xdp_rxq_info
> of the mtk_rx_ring, which means that an XDP program attached to
> the Mediathek ethernet driver cannot retrieve the index of the
> interface that received the package since it's always 0 inside
> the xdp_md struct.
>=20
> This patch sets the network device pointer inside the
> xdp_rxq_info struct, which is later used to initialize
> the xdp_buff struct via xdp_init_buff.
>=20
> This was tested using the following eBPF/XDP program attached
> to a network interface of the mtk_eth_soc driver. As said before,
> ingress_ifindex always had a value of zero. After applying the
> patch, ingress_ifindex holds the correct interface index.
>=20
> 	#include <linux/bpf.h>
> 	#include <bpf/bpf_helpers.h>
>=20
> 	SEC("pass")
> 	int pass_func(struct xdp_md *xdp) {
>     		bpf_printk("ingress_ifindex: %u",
> 			xdp->ingress_ifindex);
>=20
> 		return XDP_PASS;
> 	}
>=20
> 	char _license[] SEC("license") =3D "GPL";
>=20
> Signed-off-by: Til Kaiser <mail@tk154.de>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index 53485142938c..9c6d4477e536 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2069,6 +2069,7 @@ static int mtk_poll_rx(struct napi_struct *napi, in=
t budget,
> =20
>  		netdev =3D eth->netdev[mac];
>  		ppe_idx =3D eth->mac[mac]->ppe_idx;
> +		ring->xdp_q.dev =3D netdev;

I guess you can set it just before running xdp_init_buff(), but the change =
is fine.

Regards,
Lorenzo

> =20
>  		if (unlikely(test_bit(MTK_RESETTING, &eth->state)))
>  			goto release_desc;
> --=20
> 2.47.1
>=20
>=20

--uvb7q/nk1Bce8w0/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ0YQYAAKCRA6cBh0uS2t
rE83AP9aWzKM/1L4n1BoEJE/YnvJ0ZgCt/qRO9Ic6wvncBspJgD/f2wyeQqB4c3c
RCA/I9kBkH0M1sI3s/WtbGbWzaU/0Ak=
=Et90
-----END PGP SIGNATURE-----

--uvb7q/nk1Bce8w0/--


