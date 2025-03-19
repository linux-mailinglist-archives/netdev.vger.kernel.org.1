Return-Path: <netdev+bounces-175980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B28A682D2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 02:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78F33BF868
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253524EAAF;
	Wed, 19 Mar 2025 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOumYgIb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DA24EA99
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742348603; cv=none; b=K+2PMNVHiHHMa4IOdRA/LrAb5XMmbnWwnywZidcrbPa2HysI9PtEkGcx3iFA/gV3KccgNKX4TNAGNwE80oyyNYyMHZzALuy+fzeaYjyWSmQi1KyBpxKnaMkuL0ui719CMaC/qHR+RLjQi+8GwNJkFP6Z670cVuXu0cq6bR5d5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742348603; c=relaxed/simple;
	bh=DM1sjxHj6c3Pf1kUXdVoVBRJY/xWByHO9hNZFXGBUr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHc3vGHy7wIIcmHUGBkXIBikAQCSbzyuSyl8VufVdeG+pHTIDsBE6JeZBZ+KwcMfVlfYUItkLj2Ya5Vruz9mu711isGpwPc2KqGdScqwhpHIc90TyLTPcj834EAWRzL+0lsR7UQ4DnUPrNKpO/NZZBvpKZUt0bw07K65/WbW/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOumYgIb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742348600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZgrK+3GtZkVbin2+qwkk9k9pp2awWpPEaUr1JvfH1w=;
	b=WOumYgIbKc3eeruzliJcdkSoQNsqUqfoRGGdF4HxMA9gGKONVdII8wtc2f0X9y95Jv7zhP
	zd7+EyLl5QLObSlFAlg9p5aJjR9NO5jP7TuMdruzVFr0sBzuAmA+ML/jFEdWMr4/AW3olI
	iHPnxY6j2WcanFVi0liBzvL8PwLSubw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-SPso9EK5M2aWwd2YyGKf1g-1; Tue, 18 Mar 2025 21:43:18 -0400
X-MC-Unique: SPso9EK5M2aWwd2YyGKf1g-1
X-Mimecast-MFC-AGG-ID: SPso9EK5M2aWwd2YyGKf1g_1742348598
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so6444882a91.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 18:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742348598; x=1742953398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZgrK+3GtZkVbin2+qwkk9k9pp2awWpPEaUr1JvfH1w=;
        b=AZBWfbv6uHrIRdZktwMlDpIJyenRph4c/I2NOpsrTATAEWfLM8wQI5cqUwIQSjk1vV
         1WnofKCZpc8hDr87PIvQA7/F8Ho7GxboXqYyOEYaV+mlyX/8bCtiNlgNxwM07obUoGhb
         JxWnR5BxLhGwH/rRiD8DqUHFEZngYuZuwMh6lOuYJjuvQGQJ4MXCgEQMDT1rd5to/LGI
         K99MrlwbzgIFhbuTRlu/zcZrTf92eZ9Q0uEDoL/bYDXBFuBdWqYwi+BCqS31pBWRNDJX
         04GeQmGwBmsI6stx9fnZIVemBRIEHMU0qKhEjcqdBNDkECtovtQpyiRa5BEbunaKhjDh
         Elpw==
X-Forwarded-Encrypted: i=1; AJvYcCWZXHPwejtZrXDtIU7QIrabh6yKJhbhV0rRz20wwy6M+XzhqkFiGkMuAlJQo/CsR8qhpyDPzGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3P9vLgJpZwKB90NLlpR7Epsue5WXD6NWN8XKALMnDNeVUdz7I
	exxbPupWg1/J3sp8OWCC8bLO1oec2bG+X62l6NA8B8um1XQ5S2c4kmBNLhK9cVR3/zNbsINsFco
	HBRppu9MlI2wkpUSiYkT5Zo87mGCUSicTa4+8NeUBd1TGgLHa2jRB9Pk1CwsTFLdQzbT8fDqg7r
	awNN7c1FY6zjk5sfOpTBiQT/b5pw/3
X-Gm-Gg: ASbGncv4Ro7MhWSsOS1e7f6ZO2qJ9tdG2jtTEv4Mo8mo+XI+U1XI2r1p7YO3wEPtVRP
	sCDhtLGVghIJOasGnj0l7QyNZ1NdC6yJTGNKkyNcG8P2jyxy8fWwB8d/zcdP7YBz3Vy2bnrwV
X-Received: by 2002:a17:90b:3bcb:b0:2f9:c144:9d13 with SMTP id 98e67ed59e1d1-301be205a51mr1751495a91.24.1742348597783;
        Tue, 18 Mar 2025 18:43:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyn4swCCtOZ1yIyXhBtSU7xz3IAAfiecl6jcpp+UVtbsjgMYzmLopXHaoCCORabGStDQVYxAruqCYWovaL/yQ=
X-Received: by 2002:a17:90b:3bcb:b0:2f9:c144:9d13 with SMTP id
 98e67ed59e1d1-301be205a51mr1751468a91.24.1742348597412; Tue, 18 Mar 2025
 18:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-3-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-3-344caf336ddd@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Mar 2025 09:43:05 +0800
X-Gm-Features: AQ5f1Jr5ZYqx0TC7LN0lZJndfhyRMcwvn4uWp9QFf0iToSAAGNmN10J7nHD8hBc
Message-ID: <CACGkMEv1TTXHd_JGb_vyN8pfTAMLbsTE6oU9_phrdpaZBrE97Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] virtio_net: Use new RSS config structs
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> The new RSS configuration structures allow easily constructing data for
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
> for the command.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------=
------
>  1 file changed, 43 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d1ed544ba03a..4153a0a5f278 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -360,24 +360,7 @@ struct receive_queue {
>         struct xdp_buff **xsk_buffs;
>  };
>
> -/* This structure can contain rss message with maximum settings for indi=
rection table and keysize
> - * Note, that default structure that describes RSS configuration virtio_=
net_rss_config
> - * contains same info but can't handle table values.
> - * In any case, structure would be passed to virtio hw through sg_buf sp=
lit by parts
> - * because table sizes may be differ according to the device configurati=
on.
> - */
>  #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> -struct virtio_net_ctrl_rss {
> -       __le32 hash_types;
> -       __le16 indirection_table_mask;
> -       __le16 unclassified_queue;
> -       __le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash=
_config for details) */
> -       __le16 max_tx_vq;
> -       u8 hash_key_length;
> -       u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> -
> -       __le16 *indirection_table;
> -};
>
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
> @@ -421,7 +404,9 @@ struct virtnet_info {
>         u16 rss_indir_table_size;
>         u32 rss_hash_types_supported;
>         u32 rss_hash_types_saved;
> -       struct virtio_net_ctrl_rss rss;
> +       struct virtio_net_rss_config_hdr *rss_hdr;
> +       struct virtio_net_rss_config_trailer rss_trailer;
> +       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>
>         /* Has control virtqueue */
>         bool has_cvq;
> @@ -523,23 +508,16 @@ enum virtnet_xmit_type {
>         VIRTNET_XMIT_TYPE_XSK,
>  };
>
> -static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, =
u16 indir_table_size)
> +static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
>  {
> -       if (!indir_table_size) {
> -               rss->indirection_table =3D NULL;
> -               return 0;
> -       }
> +       u16 indir_table_size =3D vi->has_rss ? vi->rss_indir_table_size :=
 1;
>
> -       rss->indirection_table =3D kmalloc_array(indir_table_size, sizeof=
(u16), GFP_KERNEL);
> -       if (!rss->indirection_table)
> -               return -ENOMEM;
> -
> -       return 0;
> +       return struct_size(vi->rss_hdr, indirection_table, indir_table_si=
ze);
>  }
>
> -static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
> +static size_t virtnet_rss_trailer_size(const struct virtnet_info *vi)
>  {
> -       kfree(rss->indirection_table);
> +       return struct_size(&vi->rss_trailer, hash_key_data, vi->rss_key_s=
ize);
>  }
>
>  /* We use the last two bits of the pointer to distinguish the xmit type.=
 */
> @@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(struct v=
irtnet_info *vi, u16 queue_pair
>
>         for (; i < vi->rss_indir_table_size; ++i) {
>                 indir_val =3D ethtool_rxfh_indir_default(i, queue_pairs);
> -               vi->rss.indirection_table[i] =3D cpu_to_le16(indir_val);
> +               vi->rss_hdr->indirection_table[i] =3D cpu_to_le16(indir_v=
al);
>         }
> -       vi->rss.max_tx_vq =3D cpu_to_le16(queue_pairs);
> +       vi->rss_trailer.max_tx_vq =3D cpu_to_le16(queue_pairs);
>  }
>
>  static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  {
>         struct virtio_net_ctrl_mq *mq __free(kfree) =3D NULL;
> -       struct virtio_net_ctrl_rss old_rss;
> +       struct virtio_net_rss_config_hdr *old_rss_hdr;
> +       struct virtio_net_rss_config_trailer old_rss_trailer;
>         struct net_device *dev =3D vi->dev;
>         struct scatterlist sg;
>
> @@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtnet_info=
 *vi, u16 queue_pairs)
>          * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return dire=
ctly.
>          */
>         if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
> -               memcpy(&old_rss, &vi->rss, sizeof(old_rss));
> -               if (rss_indirection_table_alloc(&vi->rss, vi->rss_indir_t=
able_size)) {
> -                       vi->rss.indirection_table =3D old_rss.indirection=
_table;
> +               old_rss_hdr =3D vi->rss_hdr;
> +               old_rss_trailer =3D vi->rss_trailer;
> +               vi->rss_hdr =3D kmalloc(virtnet_rss_hdr_size(vi), GFP_KER=
NEL);
> +               if (!vi->rss_hdr) {
> +                       vi->rss_hdr =3D old_rss_hdr;
>                         return -ENOMEM;
>                 }
>
> +               *vi->rss_hdr =3D *old_rss_hdr;
>                 virtnet_rss_update_by_qpairs(vi, queue_pairs);
>
>                 if (!virtnet_commit_rss_command(vi)) {
>                         /* restore ctrl_rss if commit_rss_command failed =
*/
> -                       rss_indirection_table_free(&vi->rss);
> -                       memcpy(&vi->rss, &old_rss, sizeof(old_rss));
> +                       kfree(vi->rss_hdr);
> +                       vi->rss_hdr =3D old_rss_hdr;
> +                       vi->rss_trailer =3D old_rss_trailer;
>
>                         dev_warn(&dev->dev, "Fail to set num of queue pai=
rs to %d, because committing RSS failed\n",
>                                  queue_pairs);
>                         return -EINVAL;
>                 }
> -               rss_indirection_table_free(&old_rss);
> +               kfree(old_rss_hdr);
>                 goto succ;
>         }
>
> @@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
>  static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>  {
>         struct net_device *dev =3D vi->dev;
> -       struct scatterlist sgs[4];
> -       unsigned int sg_buf_size;
> +       struct scatterlist sgs[2];
>
>         /* prepare sgs */
> -       sg_init_table(sgs, 4);
> -
> -       sg_buf_size =3D offsetof(struct virtio_net_ctrl_rss, hash_cfg_res=
erved);
> -       sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
> -
> -       if (vi->has_rss) {
> -               sg_buf_size =3D sizeof(uint16_t) * vi->rss_indir_table_si=
ze;
> -               sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_siz=
e);
> -       } else {
> -               sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof(ui=
nt16_t));
> -       }
> -
> -       sg_buf_size =3D offsetof(struct virtio_net_ctrl_rss, key)
> -                       - offsetof(struct virtio_net_ctrl_rss, max_tx_vq)=
;
> -       sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
> -
> -       sg_buf_size =3D vi->rss_key_size;
> -       sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
> +       sg_init_table(sgs, 2);
> +       sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
> +       sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_size(vi=
));

So I still see this:

        if (vi->has_rss || vi->has_rss_hash_report) {
                if (!virtnet_commit_rss_command(vi)) {

Should we introduce a hash config helper instead?

Thanks


