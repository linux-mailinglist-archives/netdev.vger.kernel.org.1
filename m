Return-Path: <netdev+bounces-169260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBEDA43179
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 01:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3771731E9
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7158634;
	Tue, 25 Feb 2025 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOQmktFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B941CD0C
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441637; cv=none; b=r8z9O6MSlWxSy7LdRNSxIxQUnaRig4qV924p2kEloZpY4c7gipnhVlgoh2LEggHLZJnFFg8LQ8OflvzHV6FYz7WrMa+GfblQZghWtv7kgJmRZ6R4suNql55ZdKRgFwTXLi0EyJ82gQIEGTnxf8MbK+/P9hnW4+7Y6OWkp1bLEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441637; c=relaxed/simple;
	bh=I+8UEKYa5zHtcb/AdsKpWdbvUrJvsMU9jCu3xO3kvKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZbxEl8UHYVeaAXOKjeypKRvQ5UM+99XiYQKZInCrOIceroaa/vXBT5X6zv9fIA6PLP8pH6quWJNzRNWJY35ACpYbmGzcVruqiwyRKvVnwn3DXwcFn87yUrfBvgW+AQ2OD/U7g8P4LzospMKHCyanmjbvs/bLqfibWoOllHTiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOQmktFc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43994ef3872so30344465e9.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740441634; x=1741046434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jy7xOj5szQjDRyCLfpG+V3H7yadGVLlSEZsu+BCm0E=;
        b=hOQmktFcPYMx6aayOkzP+BaR2xLjlciw9pMdiQZgVX4r2KyFQHv8t3Nd6Armj/pEUQ
         NspVqNxLEU9c8b29/+PHcZ6xYJrZGNAp5jMbj1fB8V/nA3hkgNwUEtZYsISMuL3BopVN
         Z/ReB4EYk9WthHrAUTjBDJC/LoY3l+g/VtILCUXjbAX9QM4K4pQoYmrm9E7uhO2aaFPP
         3h+HkpQSVK/asTl6FjnZRCOb3VD6OO8DXNmiaY5sImF95M+SezHzXO5JUK+nUZsXfrGb
         5VShuPo8QgJP7q1IJS12HNhOTEonvB+glNa9NJXQ7tNmCvs9JUDQTkx6zMHvMrDAE7b4
         LwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740441634; x=1741046434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Jy7xOj5szQjDRyCLfpG+V3H7yadGVLlSEZsu+BCm0E=;
        b=YRhbMB1EcCALa3eUSRyZ9bq9zJ6FUQr4991CG0/c18awVTSl40coh1ORVz7ran7qxU
         81cUeC0/bZFn5gCc6a2/2tkXNPIRIf6YL2yo2CQy6cm2pU/ICaDFQsYk9DKQqpMq36g0
         h5ajFKlZzJU7F36RBpAnNy1lg1sCXxXaWuV/lXwYXRXbXy8heAYQOyxi/bH2TNBaun2E
         T9LU1DL8k7oYST1oSBPi71Q+WI3ijYlXRE6PLTH9A+decTzLhWOE+iyOBZ8OTfjWVRh+
         U8Ut6g+nta6oJ59u1Mar+pfTBmE9WHoGzvpoAfYGFxKRoMvawj7zH6qIVlRKwvRjk43a
         64Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXy9S69MfXiMRYp2R3BJ+rCvHikaiS+dpppDM2KYFPLufsJvStYM4jXLZCU4cLKfmYiJklq6L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgzx/V9xZLJEeyKcHdcXhxk3jt0/g6PfCFI+NYLPY1oTLtygfc
	3hJreKyaFisNXZZ7vxYwN7X+EqbDDomIjMu8tgbXGWpCxZmTrpEOaOdJx8+7QqW+bWRklRqcRWj
	wJ4/Hx1f5HDHsrOITYE0hAtnzzFg=
X-Gm-Gg: ASbGnctF+wneK5HRj6qAI039P42ca2xmP8Jp4OdvdJElyTvuhQ7sTFhf3ElpOnqH89U
	OqdwdVthJzL+f8/JqLHoH6JUP4xRFNgEEs845zOGSke6bAUyqNHHRdBWGvmoGC/oNb1BH1KwVd2
	LOAWGMkSlVi7Wt9yjpNTqdtOfXMU5HzXCjQQJfGrUa
X-Google-Smtp-Source: AGHT+IF66KwYqmKpzZ/tuygT66CKz5vmP6ONp1fRdves1NbBVf/bo9Kxgn2HFN95ufp6gw962rUC7oDf+7r2sysuN2s=
X-Received: by 2002:a05:600c:4446:b0:439:9bed:9cfd with SMTP id
 5b1f17b1804b1-43ab0f311f9mr10455625e9.11.1740441633677; Mon, 24 Feb 2025
 16:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530022632.17938-1-mengyuanlou@net-swift.com>
 <20230530022632.17938-8-mengyuanlou@net-swift.com> <3dc42e5c-2944-47d9-9082-9dc347a70802@redhat.com>
In-Reply-To: <3dc42e5c-2944-47d9-9082-9dc347a70802@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 24 Feb 2025 15:59:57 -0800
X-Gm-Features: AQ5f1JpKfuNY35Hct7tYSIixQxSstnZgKfqTSsdDl9WhWbXlDgDfNfSuZUD-MQQ
Message-ID: <CAKgT0UeEgLiRzqNkd08B4HP2=CFc_=+p14V5ASkFPwMN6VYRKg@mail.gmail.com>
Subject: Re: [RESEND,PATCH net-next v7 7/8] net: txgbe: Add netdev features support
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	jiawenwu@trustnetic.com, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> I just stumbled upon the following while working on something slightly
> related. Adding a bunch of people hopefully interested.
>
> On 5/30/23 4:26 AM, Mengyuan Lou wrote:
> > Add features and hw_features that ngbe can support.
> >
> > Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> > ---
> > @@ -596,11 +597,25 @@ static int txgbe_probe(struct pci_dev *pdev,
> >               goto err_free_mac_table;
> >       }
> >
> > -     netdev->features |=3D NETIF_F_HIGHDMA;
> > -     netdev->features =3D NETIF_F_SG;
> > -
> > +     netdev->features =3D NETIF_F_SG |
> > +                        NETIF_F_TSO |
> > +                        NETIF_F_TSO6 |
> > +                        NETIF_F_RXHASH |
> > +                        NETIF_F_RXCSUM |
> > +                        NETIF_F_HW_CSUM;
> > +
> > +     netdev->gso_partial_features =3D  NETIF_F_GSO_ENCAP_ALL;
> > +     netdev->features |=3D netdev->gso_partial_features;
> > +     netdev->features |=3D NETIF_F_SCTP_CRC;
> > +     netdev->vlan_features |=3D netdev->features | NETIF_F_TSO_MANGLEI=
D;
> > +     netdev->hw_enc_features |=3D netdev->vlan_features;
>
> This driver does not implement the .ndo_features_check callback, meaning
> it will happily accept TSO_V4 over any IP tunnel, even when ID mangling
> is explicitly not allowed.
>
> The above in turn looks inconsistent. If the device is able to update
> the (outer) IP (and IP csum) while performing TSO, than it should be
> able to fully offload NETIF_F_GSO_GRE: such offload should not be
> included in the partial ones.
>
> Otherwise, if the device is not able to perform the mentioned tasks, the
> driver should implement a suitable ndo_features_check op, stripping
> NETIF_F_TSO for tunneled packet that could be potentially fragmented,
> that is, when `features` lacks the `NETIF_F_TSO_MANGLEID` bit.
>
> Alike what several intel drivers (ixgbe, igc, etc.) do.
>
> Assuming I did not misread something relevant, and the above is somewhat
> correct, I'm wondering if we should move the mentioned check into the
> core; preventing future similar errors and avoiding some driver code
> duplication.
>
> Something alike the following, completely untested:
> ---
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d5ab9a4b318e..2fdfcddf9c3b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3668,15 +3668,6 @@ static netdev_features_t gso_features_check(const
> struct sk_buff *skb,
>                 return features & ~NETIF_F_GSO_MASK;
>         }
>
> -       /* Support for GSO partial features requires software
> -        * intervention before we can actually process the packets
> -        * so we need to strip support for any partial features now
> -        * and we can pull them back in after we have partially
> -        * segmented the frame.
> -        */
> -       if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL))
> -               features &=3D ~dev->gso_partial_features;
> -
>         /* Make sure to clear the IPv4 ID mangling feature if the
>          * IPv4 header has the potential to be fragmented.
>          */
> @@ -3684,10 +3675,24 @@ static netdev_features_t
> gso_features_check(const struct sk_buff *skb,
>                 struct iphdr *iph =3D skb->encapsulation ?
>                                     inner_ip_hdr(skb) : ip_hdr(skb);
>
> -               if (!(iph->frag_off & htons(IP_DF)))
> +               if (!(iph->frag_off & htons(IP_DF))) {
>                         features &=3D ~NETIF_F_TSO_MANGLEID;
> +                       if (features & dev->gso_partial_features &
> +                           (NETIF_F_GSO_GRE | NETIF_F_GSO_IPXIP4 |
> +                            NETIF_F_GSO_IPXIP6 | NETIF_F_GSO_UDP_TUNNEL)=
)
> +                               features &=3D ~NETIF_F_TSO;
> +               }
>         }
>

My main concern would be that there might be implementations of
partial that are capable of doing a partial offload without the
MANGLEID feature that would be impacted.

If I recall I think for the i40e it may have supported some logic to
do the proper things while not knowing how to deal with the tunnel
headers but correctly handling the IP headers.

> +       /* Support for GSO partial features requires software
> +        * intervention before we can actually process the packets
> +        * so we need to strip support for any partial features now
> +        * and we can pull them back in after we have partially
> +        * segmented the frame.
> +        */
> +       if (!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL))
> +               features &=3D ~dev->gso_partial_features;
> +

Why move this? I'm not sure it gains you anything if it is either
before or after the result should be the same.

>         return features;
>  }

