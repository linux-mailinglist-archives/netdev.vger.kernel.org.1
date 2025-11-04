Return-Path: <netdev+bounces-235366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B2C2F4F3
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 05:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8618B189D2E1
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 04:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E018FDDE;
	Tue,  4 Nov 2025 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIlmGZGT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8cUQWoz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7512E2609D6
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230971; cv=none; b=H52g8hz5YLgmNguGwhB6wjGVcB6530xnCX/n9vnewBpb0jzSJOXt1Vc8M1JSQM5gDH6dVczy4y9ukHXi5nYahOO4omdsE6o7RVo1CWIBxo1kDFhRGXByyOFu2VEs2NshNBy/lChez8oQmPfKH8xNFg2aFAfgdPNRuInSwItLPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230971; c=relaxed/simple;
	bh=yCrStC4YpQgBIxw78bx6aHRmVXxUUgdVIwCLnEwIxZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlqRkKbF6GJo6jx90voE52WATjQlAk1TM54a0til7pIhP/2JzK+624fBP/fksv0Zg1pZgoiCjs0RG7z9amThj1piVLFYs4qe+4mZtLPzty8wHv5Yr67tE0sIIoKgelmxEC06SJprmZwjSuHeYj3zOargolu9h00yv/r4J3yzC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIlmGZGT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8cUQWoz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762230968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMEgALT3vYkI3BPRmrl7x3ijGxSzQd/8KF3u3X+wKTQ=;
	b=fIlmGZGTUc01n+WlE9C4dTai54X7luXp5NS8USgaTh8WbYK6Vno8p85Yry/g7h1SCFkcQ0
	NToN921OjB0sAF7xFSKx1AMXZkJtsrIx93RZl6ei+5bvn8wNUKivpWnMoZOeW5xQYecvKd
	B7deHrzS9JS/ROqNPVZj1HGQvdBTTNw=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-DkNtodQcN0C9ggsfhCa8nw-1; Mon, 03 Nov 2025 23:36:07 -0500
X-MC-Unique: DkNtodQcN0C9ggsfhCa8nw-1
X-Mimecast-MFC-AGG-ID: DkNtodQcN0C9ggsfhCa8nw_1762230966
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-92ec2826d66so11120708241.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 20:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762230964; x=1762835764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMEgALT3vYkI3BPRmrl7x3ijGxSzQd/8KF3u3X+wKTQ=;
        b=i8cUQWoz37U3t4DqmTacOBuxa2zymMxzP+39nDXQB+w3yzF8M3v7N1nZT9lw3nv93v
         kVt3q/FBwLUqUC9qpnE/9aXRrAK7SCD5b7IG+gTK8ZNz0u+7496Xayu43EOlGAbQMOWx
         1P1sD1I/3AfgoPMmDEMWBL1kaOTV5L7i/ct9AxvpxDMhNvIiZ8yf+hfoxQQfCSdCW9Sq
         +jp4aJJRPw5wRImNG4OwJ4QXYVmCqV69k2+yqY2miBuZLV/JQXTTY7mEHkAvpvptlm5K
         OckaVB2wLw/sz7z3MICYTjC/+fVe6t2M4HpQGocmhXuWubgm1eMzuGMrU0K/Bg83j/U5
         ABWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762230964; x=1762835764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMEgALT3vYkI3BPRmrl7x3ijGxSzQd/8KF3u3X+wKTQ=;
        b=dNmAt/YpNSsF4z1n1pb7fSuNjV8vgrS7PmTKJrhCpcrmNQy7Iz5NzbCIxvaAoTbrmn
         HBXMWHff6ZrIOKNEo9w2WMCVBD7oN4E3ZSNJ9rcrwOR4zk0n1WxMMAV5qjUBB4e6CqQU
         sTSLzWxecppB8J4b9ftq8p9gxHnG+aFRdNm3xMAwrojdBLgWUmWfkrqz7NeBUttjRylv
         KgsjoWmLkQWa9kTZdsli4rx0m3Dx+7EKJNfLDniXD58Pcm7MtxsI1tSJa/Sw8+EdG5eS
         3XZ65Fwv1/bHd+9STHSX3NeVFl8h8LwdzkFy/IAR/fCjEzGIDvu1ksNmyJK0T1cEGwIk
         HpBw==
X-Gm-Message-State: AOJu0Yzv6DO0l9PYhqGFqOl4RL/W0zTNStMndvGJUgHgC6f5Rt7TOxZR
	pivjEOvN+05+Q5iPAQni15iECT2sOQsQLciEboxfZIQi+mKyIDZq46/2zAakM0lHYa6eXAc9O4p
	8lh6bVd7b0owQTgSSYuC7sM0zpL/ji7HRulH4IaYmUaNF40BX8y+JzaL+dqxBzAc+23mP1xCKYP
	8+R9Qq7JcBW6ZPXsdr8Fq8vwGoeZH/SRPspM2g5TzG0xQ=
X-Gm-Gg: ASbGncvjeceYJz2a5SwX6ZRRVIzGz5IYUe1L0WP2S3b6TFFL9SAjRu//mUaxuHaHrfK
	eRBc1BDGjwLf41LSbz1Jw1oXB+/armsMm8ZJI85BkCabvNh0wtOKOkXL1i5pLsXYEVe8xMX2yIP
	gwFaT/sGjptNyxJe2n//KuUS4kB2Op8djAKlIpOoL3uGAfIgX6abib6hOM
X-Received: by 2002:a05:6102:292a:b0:5db:fddb:3155 with SMTP id ada2fe7eead31-5dbfddb34bamr214507137.17.1762230963994;
        Mon, 03 Nov 2025 20:36:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFRW6KkXajXhV04APlxXz+gy1FqV5c0nq7g6USx0JM1aAfKDHqf43nWjYmEUhnInaP7fzfa3SuxEnx6iDC3x0=
X-Received: by 2002:a05:6102:292a:b0:5db:fddb:3155 with SMTP id
 ada2fe7eead31-5dbfddb34bamr214502137.17.1762230963620; Mon, 03 Nov 2025
 20:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103225514.2185-1-danielj@nvidia.com> <20251103225514.2185-10-danielj@nvidia.com>
In-Reply-To: <20251103225514.2185-10-danielj@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Nov 2025 12:35:50 +0800
X-Gm-Features: AWmQ_bnTyxts-_nG6FYbdQYkJWj3FPKz4FkkPVV3zWU9Rotlr6GeQtv3lh-ZypI
Message-ID: <CACGkMEvNPzVkD8RQ84bU0yTSJeVNiq63jYbxCKhLQLpMPd0tZA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 09/12] virtio_net: Implement IPv4 ethtool flow rules
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:56=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com> =
wrote:
>
> Add support for IP_USER type rules from ethtool.
>
> Example:
> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
> Added rule with ID 1
>
> The example rule will drop packets with the source IP specified.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4:
>     - Fixed bug in protocol check of parse_ip4
>     - (u8 *) to (void *) casting.
>     - Alignment issues.
> ---
>  drivers/net/virtio_net.c | 122 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 115 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a0e94771a39e..865a27165365 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6889,6 +6889,34 @@ static bool validate_eth_mask(const struct virtnet=
_ff *ff,
>         return true;
>  }
>
> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
> +                             const struct virtio_net_ff_selector *sel,
> +                             const struct virtio_net_ff_selector *sel_ca=
p)
> +{
> +       bool partial_mask =3D !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PA=
RTIAL_MASK);
> +       struct iphdr *cap, *mask;
> +
> +       cap =3D (struct iphdr *)&sel_cap->mask;
> +       mask =3D (struct iphdr *)&sel->mask;
> +
> +       if (mask->saddr &&
> +           !check_mask_vs_cap(&mask->saddr, &cap->saddr,
> +                              sizeof(__be32), partial_mask))
> +               return false;
> +
> +       if (mask->daddr &&
> +           !check_mask_vs_cap(&mask->daddr, &cap->daddr,
> +                              sizeof(__be32), partial_mask))
> +               return false;
> +
> +       if (mask->protocol &&
> +           !check_mask_vs_cap(&mask->protocol, &cap->protocol,
> +                              sizeof(u8), partial_mask))
> +               return false;
> +
> +       return true;
> +}
> +
>  static bool validate_mask(const struct virtnet_ff *ff,
>                           const struct virtio_net_ff_selector *sel)
>  {
> @@ -6900,11 +6928,36 @@ static bool validate_mask(const struct virtnet_ff=
 *ff,
>         switch (sel->type) {
>         case VIRTIO_NET_FF_MASK_TYPE_ETH:
>                 return validate_eth_mask(ff, sel, sel_cap);
> +
> +       case VIRTIO_NET_FF_MASK_TYPE_IPV4:
> +               return validate_ip4_mask(ff, sel, sel_cap);
>         }
>
>         return false;
>  }
>
> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> +                     const struct ethtool_rx_flow_spec *fs)
> +{
> +       const struct ethtool_usrip4_spec *l3_mask =3D &fs->m_u.usr_ip4_sp=
ec;
> +       const struct ethtool_usrip4_spec *l3_val  =3D &fs->h_u.usr_ip4_sp=
ec;
> +
> +       mask->saddr =3D l3_mask->ip4src;
> +       mask->daddr =3D l3_mask->ip4dst;
> +       key->saddr =3D l3_val->ip4src;
> +       key->daddr =3D l3_val->ip4dst;
> +
> +       if (l3_mask->proto) {
> +               mask->protocol =3D l3_mask->proto;
> +               key->protocol =3D l3_val->proto;
> +       }
> +}
> +
> +static bool has_ipv4(u32 flow_type)
> +{
> +       return flow_type =3D=3D IP_USER_FLOW;
> +}
> +
>  static int setup_classifier(struct virtnet_ff *ff,
>                             struct virtnet_classifier **c)
>  {
> @@ -7039,6 +7092,7 @@ static bool supported_flow_type(const struct ethtoo=
l_rx_flow_spec *fs)
>  {
>         switch (fs->flow_type) {
>         case ETHER_FLOW:
> +       case IP_USER_FLOW:
>                 return true;
>         }
>
> @@ -7067,11 +7121,23 @@ static int validate_flow_input(struct virtnet_ff =
*ff,
>  }
>
>  static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
> -                                size_t *key_size, size_t *classifier_siz=
e,
> -                                int *num_hdrs)
> +                               size_t *key_size, size_t *classifier_size=
,
> +                               int *num_hdrs)
>  {
> +       size_t size =3D sizeof(struct ethhdr);
> +
>         *num_hdrs =3D 1;
>         *key_size =3D sizeof(struct ethhdr);
> +
> +       if (fs->flow_type =3D=3D ETHER_FLOW)
> +               goto done;
> +
> +       ++(*num_hdrs);
> +       if (has_ipv4(fs->flow_type))
> +               size +=3D sizeof(struct iphdr);
> +
> +done:
> +       *key_size =3D size;
>         /*
>          * The classifier size is the size of the classifier header, a se=
lector
>          * header for each type of header in the match criteria, and each=
 header
> @@ -7083,8 +7149,9 @@ static void calculate_flow_sizes(struct ethtool_rx_=
flow_spec *fs,
>  }
>
>  static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *select=
or,
> -                                  u8 *key,
> -                                  const struct ethtool_rx_flow_spec *fs)
> +                                 u8 *key,
> +                                 const struct ethtool_rx_flow_spec *fs,
> +                                 int num_hdrs)
>  {
>         struct ethhdr *eth_m =3D (struct ethhdr *)&selector->mask;
>         struct ethhdr *eth_k =3D (struct ethhdr *)key;
> @@ -7092,8 +7159,33 @@ static void setup_eth_hdr_key_mask(struct virtio_n=
et_ff_selector *selector,
>         selector->type =3D VIRTIO_NET_FF_MASK_TYPE_ETH;
>         selector->length =3D sizeof(struct ethhdr);
>
> -       memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
> -       memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
> +       if (num_hdrs > 1) {
> +               eth_m->h_proto =3D cpu_to_be16(0xffff);
> +               eth_k->h_proto =3D cpu_to_be16(ETH_P_IP);

Do we need to check IPV6 here?

Thanks


