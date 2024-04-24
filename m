Return-Path: <netdev+bounces-90767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293BD8B003E
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 05:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D01F23A7D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 03:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC113BC16;
	Wed, 24 Apr 2024 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSC4oSBq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C0139CEB
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930940; cv=none; b=oARvgtV5ULXylLte0kzdfLZ/sPtsCdSQrroOBaR83Y01CJBxyFhetDToV0l46OSjAqave7NqdMeOGKoxL1CU8lwofxwCTQ+F3uRElRz9qQorK1NwZlTzZfTgzWmXVeRCQjOxlYi9wYVzHUBr2qk6aPRB0+UWtESOtRXc3exEkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930940; c=relaxed/simple;
	bh=KKcgxasDyJFXqv/hgRIywTzUidpY5yGFOfGd8BXBmas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSeXMOwJbfsJ1vsLvbdP2a7887f/7qnC3HjT+7OkFTGLvg+8HpTBDxBq5+4u37UnMJWeD0NNr5/7JqxfctLeX+XBDczrdCJAipNq6Mwm7jQNZupccdoL2bYHGKjJjW+jKiDj36xwCqckZSVL0qaDUUEfdaQocHj9U1uwBM4Ef3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSC4oSBq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pzndRW90+wqE5EwVxS+cBCK5mYVppdbl6Yx4ow+tjY=;
	b=RSC4oSBqXty50/kp0tewl1tu8bXMjKWtLu3BdvjkGA84D1ZU0KxBjw0axBbDxcfElvNqQj
	qwwvkllkgvUlKf/4KcxmKfpDu9ED/yfyRhNR6lAoMHiheDJDz+a32C0ciDj++Vl21j1LZ7
	vaycnXbR8q507N7IMw8QS5mZOlTCHGY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-4FsdwDi_OCaBoanF2mdQEA-1; Tue, 23 Apr 2024 23:55:36 -0400
X-MC-Unique: 4FsdwDi_OCaBoanF2mdQEA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e2c0d3eadeso76017575ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 20:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930936; x=1714535736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pzndRW90+wqE5EwVxS+cBCK5mYVppdbl6Yx4ow+tjY=;
        b=ddQe3XbzMqJn9mE6vGaev+2lJa1fm6+IucEnl/V5lp8zsm9vDGnYQLXeUdslVl8Du1
         JMsMg0+eVKlz34k/9ZlkvWR3kZpCvj2mIg1As2Xti2nJQkZKrIxQfTC5QIZ88uCzpIuQ
         9PonR3xcx84go26WNhGGo/PBV+MdHm1lcnrEcrAZKMx6v46mclsc0c0yhzdzvjuRbZcv
         hTqtXOa6lTHAnKqQYNRPpFVOkIA9cCZcy7lZ6HVaKFtJk8nTGZFy7Nj6+PI8DfLUv0me
         sYBrg60NpVMrwfiRf7uO2qEE8kqTd3GAuFZISB8375mJ55VJ6czyxLDFMlDIAOFzq3IG
         7Qqg==
X-Gm-Message-State: AOJu0YwpRS9+CStDVbb8zOuZj03GqK//dKgrxfV29OPORSni5NsD3XtM
	SVSk3mcb/H/F24BSA5zmu83c+DqsJq/G2seDxYBT5L+6jaSXjQfdmdR0mYbvvBSilRZxYrwVTip
	NUzerYMmACDQLthG2OViIKS0X7uE06NdIZttpEoyEn5Mk1f6QHdkMCxZpBn4XmgkOLlrJ8OjEM2
	5I+zFBS1gipMppRxeZe06+/PiqtmDZ
X-Received: by 2002:a17:902:9897:b0:1e2:82fc:bf71 with SMTP id s23-20020a170902989700b001e282fcbf71mr1296392plp.22.1713930935681;
        Tue, 23 Apr 2024 20:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgSdtzrZUnBDlB/5t9CYlcaU1yJjdPtWZ7q9A2G3rYLw3S9Y2o9HHDb07alKkZ1waM2Madn5EeKEjJMNpAHkY=
X-Received: by 2002:a17:902:9897:b0:1e2:82fc:bf71 with SMTP id
 s23-20020a170902989700b001e282fcbf71mr1296382plp.22.1713930935374; Tue, 23
 Apr 2024 20:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com> <20240423113141.1752-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240423113141.1752-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:55:24 +0800
Message-ID: <CACGkMEvoOqcazXxAt6KwShwJxtn=Z-sF7-yZr+JcUGL3Vk=S7g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 6/8] virtio_net: rename stat tx_timeout to timeout
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we have this:
>
>     tx_queue_0_tx_timeouts
>
> This is used to record the tx schedule timeout.
> But this has two "tx". I think the below is enough.
>
>     tx_queue_0_timeouts
>
> So I rename this field.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8a4d22f5f5b1..51ce2308f4f5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -87,7 +87,7 @@ struct virtnet_sq_stats {
>         u64_stats_t xdp_tx;
>         u64_stats_t xdp_tx_drops;
>         u64_stats_t kicks;
> -       u64_stats_t tx_timeouts;
> +       u64_stats_t timeouts;
>  };
>
>  struct virtnet_rq_stats {
> @@ -111,7 +111,7 @@ static const struct virtnet_stat_desc virtnet_sq_stat=
s_desc[] =3D {
>         VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
>         VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
>         VIRTNET_SQ_STAT("kicks",        kicks),
> -       VIRTNET_SQ_STAT("tx_timeouts",  tx_timeouts),
> +       VIRTNET_SQ_STAT("timeouts",     timeouts),

Not sure if it is too late to do this as it is noticeable by the userspace.

Thanks

>  };
>
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] =3D {
> @@ -2691,7 +2691,7 @@ static void virtnet_stats(struct net_device *dev,
>                         start =3D u64_stats_fetch_begin(&sq->stats.syncp)=
;
>                         tpackets =3D u64_stats_read(&sq->stats.packets);
>                         tbytes   =3D u64_stats_read(&sq->stats.bytes);
> -                       terrors  =3D u64_stats_read(&sq->stats.tx_timeout=
s);
> +                       terrors  =3D u64_stats_read(&sq->stats.timeouts);
>                 } while (u64_stats_fetch_retry(&sq->stats.syncp, start));
>
>                 do {
> @@ -4639,7 +4639,7 @@ static void virtnet_tx_timeout(struct net_device *d=
ev, unsigned int txqueue)
>         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, txqueue);
>
>         u64_stats_update_begin(&sq->stats.syncp);
> -       u64_stats_inc(&sq->stats.tx_timeouts);
> +       u64_stats_inc(&sq->stats.timeouts);
>         u64_stats_update_end(&sq->stats.syncp);
>
>         netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, name:=
 %s, %u usecs ago\n",
> --
> 2.32.0.3.g01195cf9f
>


