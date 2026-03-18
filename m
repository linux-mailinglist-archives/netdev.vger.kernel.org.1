Return-Path: <netdev+bounces-268878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDEzCZYlumk3SAIAu9opvQ
	(envelope-from <netdev+bounces-268878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 05:09:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 973CF2B5B73
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 05:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7F5930FA9BE
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1233B6D3;
	Wed, 18 Mar 2026 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq70Wrbk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiMFCpRp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0AF3321A2
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806860; cv=pass; b=rgQ+cuaxIQdM5QWnSrbCYEEQyZOvFQmVPr7RP8iI0to/pN2Y501WDAJd8Xt8xyehGZPTwbrYODYQ5C5IHqYctzt/+WjRya4XRvflwCc/lExlcOoGw/ngh4CjiDCpkraONzE1ZpkiTE97FeAnu7lbUTChM6RdY8qihjA9uFkigO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806860; c=relaxed/simple;
	bh=JX+9CyYQ4c/fJkbA8EsOY6w2X95NTS5oBY8zRj99JYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrT3vI4Au+49OBuxMgwapfSYObHMC9Mr8wWPGfOQjWqx4JVRuM2UqB6qZMFtsLgtfN+P+YcN3psOvwlw7Qti+RP6bIyhh8h/tGkuwlfOM/RMidSC7vkaVICYMorFSeW8HO7UIHlOVFoVPlgr03ysvvK90kCnmTZKJuYSv/rttdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aq70Wrbk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiMFCpRp; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773806856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APhLTSVpyDz2QsZIVwNmejono8SLyJjyFG68OMebBo4=;
	b=Aq70WrbkkUDgfX78Vvm47svJDNKTtEHaOgwxWjupH9nFdjMn2/OsaM3Uu6e+V0rqdPMUHW
	gZjS4ZXVdOCwouYdmsJlXwxaL5LuNDr1+n8AbRYFDaAERbJsfKinFZw7L5seWo8PrWIu0o
	RF/0ETpaOKIle1I5A1ES9CEKvJ3QzCc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-588Q7dRFPxiDQfkVufYXkA-1; Wed, 18 Mar 2026 00:07:33 -0400
X-MC-Unique: 588Q7dRFPxiDQfkVufYXkA-1
X-Mimecast-MFC-AGG-ID: 588Q7dRFPxiDQfkVufYXkA_1773806852
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so849884a91.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773806852; cv=none;
        d=google.com; s=arc-20240605;
        b=RrqwLFAlNsFVSIyOzx9Cy1hjFRlUnFml5xhSR4Lk7hrPOeBlfxCF9us3SJ343W/n/e
         Fmzh1mujf7Xb3afyXDBgxQd/nDPv9CmoD+9lSkSJRzQ2PWJ6OkIkcfLcPiFQuEDy7psg
         SgJcL4OL34JruLgC849+cLMnZEmhzmFhc1iblYVz4C9c6QerdUjm7nh0IRUwovjRzQOW
         SWZbhB7ZLde7oC4oCRPKdbZ94l2ioPQVxibrllTT4azWPFOSmd/tXQGA7WpSwNr4lKmJ
         lQWExBp8loLa2VmReXLmR9R1YxXeRfjyLM3HQ1O3p+SOMjaVB2O0Da95irEBx9Ik1giX
         E1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=APhLTSVpyDz2QsZIVwNmejono8SLyJjyFG68OMebBo4=;
        fh=LLqbKS3O/TWLpPiiyZepelxXjuLs+xOBTKZLLydgE2g=;
        b=Lhby69MuIuPkEXDfFKZkkXCK+HqRjzWnq8sCAL8t18OlGHvKVU9CVt/kFtm0NX97Cr
         VoPXGWqjDytpwHMrCibzHGJwWmOM8nh4Bh094yTIBuVvd6PYiGZzGl+F7WffGB//dcHw
         wJ+dKz9heLnZvoQD5C0T+cb8D7oHwgc0wzezjHjmdpRTNppL2Iz6k/aXPRKHxJYwA+XV
         WpP9bp+RZ7JpYscV/PhaVUIG/Ls+GdLVnBashAym9aisGXnDozz7l8LdkjEr7JSruUeA
         9ibD6a+ukGDpAq5AiBdNH3bLyIOlSW7BIIA1R3CHIccWYpOWRZu9Par5pzInZSsLYhtP
         giEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773806852; x=1774411652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APhLTSVpyDz2QsZIVwNmejono8SLyJjyFG68OMebBo4=;
        b=KiMFCpRp1vub8i/sh18AWXMxpriU2ytChpF7bCqORwKILL+WhWuFsvNvCRWP94lqU2
         IEpK4SAbwNQdudxungxz5N64UU8AKe2zNo/AIascIxwOp1bbBC8lo0QIxQh/kHahS6/T
         Pz1vucbKFJE7Sh8klkDagW5/hsQjuIv/QRHCN7prpLUovWsyNouiNn8pkyAVCrGt769K
         PsLtPp2SY4I2U76/0eILNQOfefqFOi9yAtEbb2yJIAVCLB2OjLHcd1NT6K7Gy5PsI3U9
         RM0IWyJnhrqUUAcfXOyLiQFMZkj1tO2k+7U4WZHXOKMXhd5cja0oWnlUt/i6j9G45U+i
         35cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773806852; x=1774411652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=APhLTSVpyDz2QsZIVwNmejono8SLyJjyFG68OMebBo4=;
        b=GouSbZheqw8ij+qYBPX4xTodfa4vvrS7dTqOSwtsn+e1e0JuCx1H/b1C/K9Qb2NNYR
         YDv44rRjnTV54JXU8hoj5/NaWSKsqLIFt8YBAxuuQFiA4qcHI9joM1+Yi4O8xu5B4ShP
         2fUQm0I3ggs+7jvTPJhBoNfm7f5Vw8ol3d0491HKquk46JEyc5TlhVTyL1u8j05Uu2JW
         F1V2P5uKUo0Nhb+xPo0TDf/zB3dGmYad+lzJ6hjzwlQXYF4AvruABxK6/V43W6IM737W
         zgNIdj6mbrOmbyBtcb6WAEcmUUKUC/ubH2UBWPr+jojiqtIt4gP0z397R5HAJBHHP3l+
         b4jg==
X-Gm-Message-State: AOJu0Yz1MCcLiodphYOoVCXSneT6jS4rHUPc6hKTgpxMLtnSlQvFMqKO
	OVj7c4ukGZGn+X7eQ3HpS10hSH4mHXta7XIAviQ/Teq+bGtHG9uBHZvICvefZTJfmriLs+wVY13
	1dGYos+xlKYI4Nu/Y2j2wTdxN4dEigEN4nncUg9caaNjx0Z5Kh2CC04Cc7xGblI6vgQYLkkMM+A
	O3sQu38JkOsiksUqozHIaY3pd7TxCISC/E
X-Gm-Gg: ATEYQzx785le2Tqn1meK3/3fmagUA+vDLO4BvFIxtHENOlpqfpeYNVaePQRrZwP52J2
	4OfU2G7lAUtN6shHIVUxX19GSm1Ox6JGB3QH5KE9/RkaCCcKAyVVBzdwjj/Ub3uStigDWQey6Ju
	EI6zes0aHKBhhEGJlN1e5rbh+RWMv8Gr3m90DSdVnTmKUPmJx69meEY3gFZwYgl94Rij9BGYyS4
	1+5X6Y=
X-Received: by 2002:a17:90b:3b51:b0:35b:973d:147b with SMTP id 98e67ed59e1d1-35badb6eff8mr5562559a91.11.1773806852020;
        Tue, 17 Mar 2026 21:07:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3b51:b0:35b:973d:147b with SMTP id
 98e67ed59e1d1-35badb6eff8mr5562513a91.11.1773806851408; Tue, 17 Mar 2026
 21:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com> <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Mar 2026 12:07:20 +0800
X-Gm-Features: AaiRm50Xknu0MCBnszjwTaJQwPGWMPOiXu5MnonVMdLi0fc3xFlUBMQ8E_CsCTQ
Message-ID: <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268878-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,solid-run.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 973CF2B5B73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
>
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
>
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
>
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gues=
t feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/tun_vnet.h     |  2 +-
>  drivers/net/virtio_net.c   |  6 +++++-
>  include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
>  3 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index a5f93b6c4482..fa5cab9d3e55 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>
>         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>                                         tun_vnet_is_little_endian(flags),
> -                                       vlan_hlen, true)) {
> +                                       vlan_hlen, true, false)) {
>                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hdr;
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..7106333ef904 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>         struct virtio_net_hdr_v1_hash_tunnel *hdr;
>         int num_sg;
>         unsigned hdr_len =3D vi->hdr_len;
> +       bool feature_hdrlen;
>         bool can_push;
>
> +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> +                                           VIRTIO_NET_F_GUEST_HDRLEN);
> +
>         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
>         /* Make sure it's safe to cast between formats */
> @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb, bool orphan)
>
>         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
>                                         virtio_is_little_endian(vi->vdev)=
, 0,
> -                                       false))
> +                                       false, feature_hdrlen))
>                 return -EPROTO;
>
>         if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 75dabb763c65..48de4a16a96a 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_bu=
ff *skb,
>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_=
type);
>  }
>
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +                                        struct virtio_net_hdr *hdr,
> +                                        bool little_endian)
> +{
> +       u16 hdr_len;
> +
> +       hdr_len =3D skb_transport_offset(skb);
> +
> +       if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> +               hdr_len +=3D sizeof(struct udphdr);
> +       else
> +               hdr_len +=3D tcp_hdrlen(skb);

Ok, I think this depends on the logic inside virtio_net_hdr_from_skb()

                if (sinfo->gso_type & SKB_GSO_TCPV4)
                        hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
                else if (sinfo->gso_type & SKB_GSO_TCPV6)
                        hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
                else if (sinfo->gso_type & SKB_GSO_UDP_L4)
                        hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
        else
                        return -EINVAL;

To be more robust, I'd suggest moving it there.

But I have another question, the logic above depends on the headlen is
correctly set:

                /* This is a hint as to how much should be linear. */
                hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
                                                 skb_headlen(skb));

Is the headlen guaranteed to be correct in all cases (e.g for nested
setups or dodgy packets?)

Thanks

> +
> +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> +}
> +
>  static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>                                           struct virtio_net_hdr *hdr,
>                                           bool little_endian,
> @@ -385,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>                             bool tnl_hdr_negotiated,
>                             bool little_endian,
>                             int vlan_hlen,
> -                           bool has_data_valid)
> +                           bool has_data_valid,
> +                           bool feature_hdrlen)
>  {
>         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
>         unsigned int inner_nh, outer_th;
> @@ -394,9 +411,17 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *sk=
b,
>
>         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL =
|
>                                                     SKB_GSO_UDP_TUNNEL_CS=
UM);
> -       if (!tnl_gso_type)
> -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> -                                              has_data_valid, vlan_hlen)=
;
> +       if (!tnl_gso_type) {
> +               ret =3D virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                             has_data_valid, vlan_hlen);
> +               if (ret)
> +                       return ret;
> +
> +               if (feature_hdrlen && hdr->hdr_len)
> +                       virtio_net_set_hdrlen(skb, hdr, little_endian);
> +
> +               return ret;
> +       }
>
>         /* Tunnel support not negotiated but skb ask for it. */
>         if (!tnl_hdr_negotiated)
> --
> 2.32.0.3.g01195cf9f
>


