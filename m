Return-Path: <netdev+bounces-176634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03641A6B250
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 01:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6797A485684
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01EB1E48A;
	Fri, 21 Mar 2025 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2orQe5Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94D182B4
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517348; cv=none; b=APvsfBnWGHP8DCoR4p515nNt554KdBBB3oaZAJ7xx5EOxPB4HQL587iQPRGG6RE3nQViEC5eXGDsvhpKQjqD7hYAtL4UYu69lSnWWYLSqlZs+iKvM863/tI5D7RmVzuLWAEKShSFcJO4uZS7+vatx2GxRR4taNgoxlHTcupy8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517348; c=relaxed/simple;
	bh=273TUtZOkDNprZ+d4cpXjAiRXMF+Y0E1I59Vt3xBkQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okrwDrJ2CUOuH8Krw2Y1o8EzGrTLDcfuX0dOHdNB+2/IsO7FNC0hdtFpQu/yisP+jKk0q/ARCA3JHZALN0Zpu/W7/KdiDZilvXVxj4sJOQgJkAfaw+WffcrBnAudfBqtoU9VA8f0FSMt3TRygRZO28ZrXjMafUAJUV0WVtgCVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2orQe5Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742517344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OA4V63ZGUAgWmPiNQPPhhRaucjTZk78HyfsYacpplso=;
	b=Y2orQe5Y7R0SgdoW58uycKM5ta1Lz7xAptJYyiuYIF645SoLYD54KPY9OaUegK4ZTUtIX/
	OAn/Ygas0hBXBdV8nTDexSFzEG9YrC8jbN7t0j/1AtveUrwTdC5qCOGG0TU3M37oTawvHm
	m1yC+ZOiZwlyZ+oBF+cds0KV/Lvb7MQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-7ancC7xJOLaK-s3FXEbFMQ-1; Thu, 20 Mar 2025 20:35:43 -0400
X-MC-Unique: 7ancC7xJOLaK-s3FXEbFMQ-1
X-Mimecast-MFC-AGG-ID: 7ancC7xJOLaK-s3FXEbFMQ_1742517342
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so2215387a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 17:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742517342; x=1743122142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA4V63ZGUAgWmPiNQPPhhRaucjTZk78HyfsYacpplso=;
        b=jQb828+bnH8dl6YilXJju93uD21VaAZSbhjIryNUrPr7pRy19ctD+A7mYsUudIDb54
         zhpelrV5qjypSntQD9nJCU5VCWGNy2BdDuNPXF3YggOaERyzKjVUE2768g/byFN58bKr
         RMXjf6YmyMny6A/iBPBGoFlX1xiIEdaJbVZ1Z25GVdpGodv2B3n5ME4h9OdLhLEbQzct
         8fiPB+6WMClo6B0FUmqnHY77elKFkv/DuAzRMog/VVDp5c4ZImLtTvIIs6yBI6wz+Tea
         CCUEDTAFCbuA2ueIY8gGid49w5/LzKz40Fcy4ndsJhenp6tE+m3VTmp2NMND9eozfgRO
         y9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU8gkFeFARsaQ/ukxTJsSkAYCfs9KemN6qYlxQFsYm4otQ+GbJMidCje2fZZcnsVapWY3z2pyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWQUwlrPzYrtp7RpP8MQMAY4kPxixyqqkJdjIRJ8Q00ssOi0m
	ixuWKPXaXI2DmKV4MLJTrMV3dlDDQVlEpc9A42URy6fTVNUFTJkuG76usqfQGl4x1cp1DfCo57F
	zc7rlU+vvi0THpKt/8iqm1FuEvwCB5QgTO+YMV6mtfteT1KsZGmrnXrwHf5RtJ4f8yd+4MR9xZV
	1zxQEz96Ldz2xtfw7MnRrTchN72v6B
X-Gm-Gg: ASbGncu7oXJaFtXSoeA6xJ7B9XlyscB24pnNjMTb1w/bw/Ij+ZjcSH4pEA1n4JVTLi/
	0tsvAxKTOM0j0Mblx54VoVn2ldiHDvIUH/v6N0IBjm87YlWpc3xJORyGW/JVrQekd2FM3zrOy
X-Received: by 2002:a17:90b:384a:b0:2ff:618c:a1e0 with SMTP id 98e67ed59e1d1-3031001ac52mr1754836a91.29.1742517341852;
        Thu, 20 Mar 2025 17:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUQF4bISL2OoX6sGemq4dhE0rZIZguY6s2UGVwmflSEWjcqRNcsQJo0E7Afee91RBfYl+2PEiU5rUsP5w49sk=
X-Received: by 2002:a17:90b:384a:b0:2ff:618c:a1e0 with SMTP id
 98e67ed59e1d1-3031001ac52mr1754789a91.29.1742517341369; Thu, 20 Mar 2025
 17:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com> <20250318-virtio-v1-3-344caf336ddd@daynix.com>
 <CACGkMEv1TTXHd_JGb_vyN8pfTAMLbsTE6oU9_phrdpaZBrE97Q@mail.gmail.com>
 <b6eec81d-618f-4a59-8680-8e22f1a798bf@daynix.com> <CACGkMEsEaUzAeEaBzX6zQC-gVMjS_0tSegBKUrhX4R6c3MW2hQ@mail.gmail.com>
 <83a5ab7b-7b29-413e-a854-31c7893f3c4a@daynix.com>
In-Reply-To: <83a5ab7b-7b29-413e-a854-31c7893f3c4a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Mar 2025 08:35:28 +0800
X-Gm-Features: AQ5f1JrvPEW6iH4RzpcaiFl6aE6YaN-eUizL3Fnk6cMpliCATPPWmNnlcFJ9MIs
Message-ID: <CACGkMEvbs9NnHhjaiiD4hc-bOAm9+-ry3xfdZET3HqJ=_1k6Lg@mail.gmail.com>
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

On Thu, Mar 20, 2025 at 1:36=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/20 10:50, Jason Wang wrote:
> > On Wed, Mar 19, 2025 at 12:48=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2025/03/19 10:43, Jason Wang wrote:
> >>> On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> The new RSS configuration structures allow easily constructing data =
for
> >>>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of d=
ata
> >>>> for the command.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> ---
> >>>>    drivers/net/virtio_net.c | 117 +++++++++++++++++-----------------=
-------------
> >>>>    1 file changed, 43 insertions(+), 74 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>> index d1ed544ba03a..4153a0a5f278 100644
> >>>> --- a/drivers/net/virtio_net.c
> >>>> +++ b/drivers/net/virtio_net.c
> >>>> @@ -360,24 +360,7 @@ struct receive_queue {
> >>>>           struct xdp_buff **xsk_buffs;
> >>>>    };
> >>>>
> >>>> -/* This structure can contain rss message with maximum settings for=
 indirection table and keysize
> >>>> - * Note, that default structure that describes RSS configuration vi=
rtio_net_rss_config
> >>>> - * contains same info but can't handle table values.
> >>>> - * In any case, structure would be passed to virtio hw through sg_b=
uf split by parts
> >>>> - * because table sizes may be differ according to the device config=
uration.
> >>>> - */
> >>>>    #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> >>>> -struct virtio_net_ctrl_rss {
> >>>> -       __le32 hash_types;
> >>>> -       __le16 indirection_table_mask;
> >>>> -       __le16 unclassified_queue;
> >>>> -       __le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net=
_hash_config for details) */
> >>>> -       __le16 max_tx_vq;
> >>>> -       u8 hash_key_length;
> >>>> -       u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>> -
> >>>> -       __le16 *indirection_table;
> >>>> -};
> >>>>
> >>>>    /* Control VQ buffers: protected by the rtnl lock */
> >>>>    struct control_buf {
> >>>> @@ -421,7 +404,9 @@ struct virtnet_info {
> >>>>           u16 rss_indir_table_size;
> >>>>           u32 rss_hash_types_supported;
> >>>>           u32 rss_hash_types_saved;
> >>>> -       struct virtio_net_ctrl_rss rss;
> >>>> +       struct virtio_net_rss_config_hdr *rss_hdr;
> >>>> +       struct virtio_net_rss_config_trailer rss_trailer;
> >>>> +       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>>
> >>>>           /* Has control virtqueue */
> >>>>           bool has_cvq;
> >>>> @@ -523,23 +508,16 @@ enum virtnet_xmit_type {
> >>>>           VIRTNET_XMIT_TYPE_XSK,
> >>>>    };
> >>>>
> >>>> -static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *=
rss, u16 indir_table_size)
> >>>> +static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
> >>>>    {
> >>>> -       if (!indir_table_size) {
> >>>> -               rss->indirection_table =3D NULL;
> >>>> -               return 0;
> >>>> -       }
> >>>> +       u16 indir_table_size =3D vi->has_rss ? vi->rss_indir_table_s=
ize : 1;
> >>>>
> >>>> -       rss->indirection_table =3D kmalloc_array(indir_table_size, s=
izeof(u16), GFP_KERNEL);
> >>>> -       if (!rss->indirection_table)
> >>>> -               return -ENOMEM;
> >>>> -
> >>>> -       return 0;
> >>>> +       return struct_size(vi->rss_hdr, indirection_table, indir_tab=
le_size);
> >>>>    }
> >>>>
> >>>> -static void rss_indirection_table_free(struct virtio_net_ctrl_rss *=
rss)
> >>>> +static size_t virtnet_rss_trailer_size(const struct virtnet_info *v=
i)
> >>>>    {
> >>>> -       kfree(rss->indirection_table);
> >>>> +       return struct_size(&vi->rss_trailer, hash_key_data, vi->rss_=
key_size);
> >>>>    }
> >>>>
> >>>>    /* We use the last two bits of the pointer to distinguish the xmi=
t type. */
> >>>> @@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(str=
uct virtnet_info *vi, u16 queue_pair
> >>>>
> >>>>           for (; i < vi->rss_indir_table_size; ++i) {
> >>>>                   indir_val =3D ethtool_rxfh_indir_default(i, queue_=
pairs);
> >>>> -               vi->rss.indirection_table[i] =3D cpu_to_le16(indir_v=
al);
> >>>> +               vi->rss_hdr->indirection_table[i] =3D cpu_to_le16(in=
dir_val);
> >>>>           }
> >>>> -       vi->rss.max_tx_vq =3D cpu_to_le16(queue_pairs);
> >>>> +       vi->rss_trailer.max_tx_vq =3D cpu_to_le16(queue_pairs);
> >>>>    }
> >>>>
> >>>>    static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_=
pairs)
> >>>>    {
> >>>>           struct virtio_net_ctrl_mq *mq __free(kfree) =3D NULL;
> >>>> -       struct virtio_net_ctrl_rss old_rss;
> >>>> +       struct virtio_net_rss_config_hdr *old_rss_hdr;
> >>>> +       struct virtio_net_rss_config_trailer old_rss_trailer;
> >>>>           struct net_device *dev =3D vi->dev;
> >>>>           struct scatterlist sg;
> >>>>
> >>>> @@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtnet=
_info *vi, u16 queue_pairs)
> >>>>            * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and retu=
rn directly.
> >>>>            */
> >>>>           if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
> >>>> -               memcpy(&old_rss, &vi->rss, sizeof(old_rss));
> >>>> -               if (rss_indirection_table_alloc(&vi->rss, vi->rss_in=
dir_table_size)) {
> >>>> -                       vi->rss.indirection_table =3D old_rss.indire=
ction_table;
> >>>> +               old_rss_hdr =3D vi->rss_hdr;
> >>>> +               old_rss_trailer =3D vi->rss_trailer;
> >>>> +               vi->rss_hdr =3D kmalloc(virtnet_rss_hdr_size(vi), GF=
P_KERNEL);
> >>>> +               if (!vi->rss_hdr) {
> >>>> +                       vi->rss_hdr =3D old_rss_hdr;
> >>>>                           return -ENOMEM;
> >>>>                   }
> >>>>
> >>>> +               *vi->rss_hdr =3D *old_rss_hdr;
> >>>>                   virtnet_rss_update_by_qpairs(vi, queue_pairs);
> >>>>
> >>>>                   if (!virtnet_commit_rss_command(vi)) {
> >>>>                           /* restore ctrl_rss if commit_rss_command =
failed */
> >>>> -                       rss_indirection_table_free(&vi->rss);
> >>>> -                       memcpy(&vi->rss, &old_rss, sizeof(old_rss));
> >>>> +                       kfree(vi->rss_hdr);
> >>>> +                       vi->rss_hdr =3D old_rss_hdr;
> >>>> +                       vi->rss_trailer =3D old_rss_trailer;
> >>>>
> >>>>                           dev_warn(&dev->dev, "Fail to set num of qu=
eue pairs to %d, because committing RSS failed\n",
> >>>>                                    queue_pairs);
> >>>>                           return -EINVAL;
> >>>>                   }
> >>>> -               rss_indirection_table_free(&old_rss);
> >>>> +               kfree(old_rss_hdr);
> >>>>                   goto succ;
> >>>>           }
> >>>>
> >>>> @@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct net_=
device *dev,
> >>>>    static bool virtnet_commit_rss_command(struct virtnet_info *vi)
> >>>>    {
> >>>>           struct net_device *dev =3D vi->dev;
> >>>> -       struct scatterlist sgs[4];
> >>>> -       unsigned int sg_buf_size;
> >>>> +       struct scatterlist sgs[2];
> >>>>
> >>>>           /* prepare sgs */
> >>>> -       sg_init_table(sgs, 4);
> >>>> -
> >>>> -       sg_buf_size =3D offsetof(struct virtio_net_ctrl_rss, hash_cf=
g_reserved);
> >>>> -       sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
> >>>> -
> >>>> -       if (vi->has_rss) {
> >>>> -               sg_buf_size =3D sizeof(uint16_t) * vi->rss_indir_tab=
le_size;
> >>>> -               sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_bu=
f_size);
> >>>> -       } else {
> >>>> -               sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, size=
of(uint16_t));
> >>>> -       }
> >>>> -
> >>>> -       sg_buf_size =3D offsetof(struct virtio_net_ctrl_rss, key)
> >>>> -                       - offsetof(struct virtio_net_ctrl_rss, max_t=
x_vq);
> >>>> -       sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
> >>>> -
> >>>> -       sg_buf_size =3D vi->rss_key_size;
> >>>> -       sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
> >>>> +       sg_init_table(sgs, 2);
> >>>> +       sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
> >>>> +       sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_si=
ze(vi));
> >>>
> >>> So I still see this:
> >>>
> >>>           if (vi->has_rss || vi->has_rss_hash_report) {
> >>>                   if (!virtnet_commit_rss_command(vi)) {
> >>>
> >>> Should we introduce a hash config helper instead?
> >>
> >> I think it's fine to use virtnet_commit_rss_command() for hash
> >> reporting. struct virtio_net_hash_config and struct
> >> virtio_net_rss_config are defined to have a common layout to allow
> >> sharing this kind of logic.
> >
> > Well, this trick won't work if the reserved field in hash_config is
> > used in the future.
>
> Right, but we can add a hash config helper when that happens. It will
> only result in a duplication of logic for now.
>
> Regards,
> Akihiko Odaki

That's tricky as the cvq commands were designed to be used separately.
Let's use a separate helper and virtio_net_hash_config uAPIs now.

Thanks

>
> >
> > Thanks
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Thanks
> >>>
> >>
> >
>


