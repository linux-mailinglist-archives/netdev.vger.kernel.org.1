Return-Path: <netdev+bounces-297530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GiFYLHQhKWqvRAMAu9opvQ
	(envelope-from <netdev+bounces-297530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:33:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A1667367
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:33:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=b+43dZNu;
	dkim=pass header.d=redhat.com header.s=google header.b="b9rkc/nJ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297530-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297530-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEA8E3071C19
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977C43A961B;
	Wed, 10 Jun 2026 08:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B43A75A2
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:28:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080091; cv=pass; b=KPu1rwUm16lM7fsVSzxzCa1/jdw/y6/2P0d00FlEN/6qX0VIBgyOXSw+XWxkZ4440bqb5XYX7ze4z2SlxqIYXmQxe0hgr7twYwwmYRo2hSqN1T/sWhhABzfCq1T6lJ0u6F07PUdclVFzARI6V1GLJjSrzhLmTuBkw3JWOPmlVjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080091; c=relaxed/simple;
	bh=gNELbO8qe9PmTJbD0VSp0KcGVTlNaeuYAPwDbT//UMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQImII/qjjUzcsCXQaTx7Nz3nsvfVSEpVHe7xtpBv6T9/Nhyj55Gr9FlJrIiEzaL5qBqWUAIrswoIJi7fRa5TSVwT0DswoPZ9dBGZnoMPmtkPTw+UdYOsEzM7Kbe4X+SiFUpDDQREy6ZNIcDtFQgpX9Tpd/d7CrSvThzUOwT9i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+43dZNu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9rkc/nJ; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781080089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB8F8zX7dRu2b8YaeiMKfygD+Y+62k1+ixQsacU6UGQ=;
	b=b+43dZNuIv7D5mk8qJLs7zUWW30ET1zgaYQuThsQ6OKc1ODTTTC+q22DL0r2maNLchO/+x
	VXImm025qlN3x1zsF1XQO0HdEnucU3S14TapquYKg6gI/imDd6lh0jj8gZxjlq1oQjarwU
	ACV1S4fjbRakpmJCeMwU2/4uca2Xvc0=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-vSgrCv5oMeO2lT5yXFkbCw-1; Wed, 10 Jun 2026 04:28:07 -0400
X-MC-Unique: vSgrCv5oMeO2lT5yXFkbCw-1
X-Mimecast-MFC-AGG-ID: vSgrCv5oMeO2lT5yXFkbCw_1781080087
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66055c0ceb3so5782003d50.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781080087; cv=none;
        d=google.com; s=arc-20240605;
        b=MxjzC9sG+ffIOgTiVhIi8Zyu+1z9oSJaAAPpEuOzq0pb3yMtJWTrDjmScIeNk+ouLh
         iQ6Wtjbv9cMBQOgACp5JCmx7b79qq6askMmq0a/UGr82FzDuIXKtbNjHBR4j4VJDLl9H
         xycP6KOdOwRTDIhQ6Pz0aJW8HVpqxZn0H9qqK5cdH+MP5mM0fdx6pnRJaNri/ap8nNPJ
         tjLd/DvBl5oFnZQdvTJ24d3UJiiNGIebx6mE6Is+vMTS+iqFETGJIA1i0JoLJGKyZUM7
         hgL0VtuL9P+q/iW+N1XjzRgG2vxzw3aZpyXbRKbhKGJTjREAVqKH/NgDC7zOQn0OTsmx
         Ql0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZB8F8zX7dRu2b8YaeiMKfygD+Y+62k1+ixQsacU6UGQ=;
        fh=SuJ8aBasWeZcHFRzWwDioSxcfxJUkhCtKT/1e6ZxQRg=;
        b=aP2QwMDSPEApRjgN81jLqz52STMpj4ClyRkoBqfdc8j+4eM2zGs90nJwlKyfPLoM/i
         J6zqhln4cJqBSh6iJYEnhSSKYLgp1v1uK4MnHqfJyQs9VhCbvboK6gVWJawiuHufRywA
         mmm0ahywWQmh1qYJViGLpLpwiaSibKCZZS3ZHFNjS/gHNXTZwhuqIaVV0WFXOUa6skZV
         7lM7LMKSFHPM6meeT0KIqWXw3B1ne8lekmZXh3bH+KzPEaDm3fAQYmC3PblhsHgEq/Y+
         0kOwRg2qk7IO44EMcRpkd8i1SLnkuOAZIC7Hfl8G1qdN6rAfu0FCWS806ZPY8BmxQDSU
         V6bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781080087; x=1781684887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB8F8zX7dRu2b8YaeiMKfygD+Y+62k1+ixQsacU6UGQ=;
        b=b9rkc/nJbLaY5H1HfDBTDYbjvHJC0Q6v4R6PW+MYJ/jL5xcOTEHizmqfq29kh+llkH
         Cmmi1l9hglU2benN92cMZAHBmjWLSMfTLqMeWFTI5i9Lp1aOIArO36cxr5ODqPezEK67
         fF4PdBYGfuSdMq5UtWDEp4qU7DL3MXWL5pdIM9TmUJynlNOh2O0EZTh45u2AC/xjGbqJ
         jVJg4Fw573CmOEWEA1TNYQPgtPFyWyCJlfC7/nmjetwUX/2X39tMT5xJ5doU5mpyC7Gp
         Kzy5RlRWtW1zpGKCN9HtRgIDUt+7NPKUGUJmPjPJYQRNjly8IhUNJcTArlShdYAlmdIP
         XpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080087; x=1781684887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZB8F8zX7dRu2b8YaeiMKfygD+Y+62k1+ixQsacU6UGQ=;
        b=eg42IzJp7P46S2ccudMsyloDBc1Sr3OEiceamePxDnICDHL7EJwTRlKNqk07c7zvnI
         LJVGWYLSzzRqIReRDQhzdZ1ofJLTO1yRtEzb/rfxh+SnHrtSPzl6O3Ccz2VA83sxH1eO
         m8r5kXOTS5QcHlBIRBtKUp6ynOH2Jmjt37jnS50LBoVN54WBRumx8c/rMpSdd4EXMN1T
         yhVAUIDZgvaJ8VJi9hByDPYzdhzfWwiyROErI8jLhKXbeob/at1Tuf6+EtoagDh9iW06
         2rFRIy7P7jATTUx9rNVC/Mo9Zkzugnm/mqBIjo8mQhG6UekTDnpu4scDHYbUceoUZqCT
         /f4g==
X-Forwarded-Encrypted: i=1; AFNElJ9p8efCvlk35HfXaqFHZjcG4Wh/esaFKx6ZS6k4lezwVyH2SKaj4OTH5jjetIiuAsrAvguye4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+XZUS9d2LgVLcq7uynMn/H68tQd8PthIjjy8Q8mABUoWGizH
	72gaPV620RBkvVa5Rg6IGgjaJwwnZuG3ln+MMy5dM6HB9mUtu/8EY7+FbrD+dLgX+eY5w1ySDNK
	dDz2I2zXuNB9EHGsMUd5xIR62VS5z7roMssX8C/xAA2m6tYC2q7KDQP3OVPle6cwgiKA7wjt0HG
	UWlmqYdUcPoixDMY26xUnVOH+ThwOvHBWW
X-Gm-Gg: Acq92OHYFnUdPIEzpyEHgjM7+V0/otVen/wnsp7J4Vpd6MvuDHK+Ka5q/UVVGR4elUZ
	A6M/KHOLxiKkRQxKD877Vx9wUtpZmdai20kJxmEeA0f8tGxcsefnNiCUCgQh4MXYSRsnWwhM3/O
	c9oQ4XnbgOlHijzNwUrGvOhos+0/Nrl/P2JZRkQtW4lXIyYMlSccGJIQAVKvjRoxt0dHr+NcEoi
	kV02MYHvo4756/7
X-Received: by 2002:a05:690e:1242:b0:660:74f5:7e19 with SMTP id 956f58d0204a3-66106942890mr20633078d50.0.1781080086807;
        Wed, 10 Jun 2026 01:28:06 -0700 (PDT)
X-Received: by 2002:a05:690e:1242:b0:660:74f5:7e19 with SMTP id
 956f58d0204a3-66106942890mr20633037d50.0.1781080086202; Wed, 10 Jun 2026
 01:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 10 Jun 2026 10:27:28 +0200
X-Gm-Features: AVVi8CcfYFsKQnOe4E8gEOU8WNwyNAYJQQd-Lf6-GzdkgBEZs4Y0nsc-FVAqBQ4
Message-ID: <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297530-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eperezma@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eperezma@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 516A1667367

On Wed, Jun 10, 2026 at 10:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net=
.
> Take the tx path for example, we set xsk_set_tx_need_wakeup() in
> virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> anywhere, which means the user will call send() for every packet.
>
> For the tx path, we will call xsk_set_tx_need_wakeup() after
> virtnet_xsk_xmit_batch() if sq->vq is empty, as we can't be wakeup by the
> skb_xmit_done() in this case. Otherwise, we will clear the wakeup flag.
>
> For the rx path, we will call xsk_set_rx_need_wakeup() if we have free
> buffers in rq->vq.
>
> Race condition is considered for both rx and tx path.
>

I didn't review the code itself, but the patch message lacks a Fixes:
tag. And the From and Signed-off-by emails don't match, which I'm not
sure is valid.

> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/virtio_net.c | 52 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9b3da9f9786c..25e895b849a6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet=
_info *vi, struct receive_queue
>                                    struct xsk_buff_pool *pool, gfp_t gfp)
>  {
>         struct xdp_buff **xsk_buffs;
> +       bool need_wakeup;
>         dma_addr_t addr;
>         int err =3D 0;
>         u32 len, i;
>         int num;
>
> +       need_wakeup =3D xsk_uses_need_wakeup(pool);
>         xsk_buffs =3D rq->xsk_buffs;
>
> +       /* If both rq->vq and fill ring are empty, and then the user subm=
it
> +        * all the chunks to the fill ring and check the wake up flag
> +        * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup=
(),
> +        * we will lose the chance to wake up the rx napi, so we have to
> +        * set the need_wakeup flag here.
> +        */
> +       if (need_wakeup && virtqueue_get_vring_size(rq->vq) =3D=3D rq->vq=
->num_free)
> +               xsk_set_rx_need_wakeup(pool);
> +
>         num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>         if (!num) {
> -               if (xsk_uses_need_wakeup(pool)) {
> +               if (need_wakeup) {
>                         xsk_set_rx_need_wakeup(pool);
>                         /* Return 0 instead of -ENOMEM so that NAPI is
>                          * descheduled.
> @@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_i=
nfo *vi, struct receive_queue
>                 }
>
>                 return -ENOMEM;
> -       } else {
> -               xsk_clear_rx_need_wakeup(pool);
>         }
>
>         len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> @@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_=
info *vi, struct receive_queue
>                         goto err;
>         }
>
> +       if (need_wakeup) {
> +               if (rq->vq->num_free)
> +                       /* We have free buffers, so we'd better wake up t=
he
> +                        * rx napi as soon as possible.
> +                        */
> +                       xsk_set_rx_need_wakeup(pool);
> +               else
> +                       xsk_clear_rx_need_wakeup(pool);
> +       }
> +
>         return num;
>
>  err:
> @@ -1440,8 +1459,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq,=
 struct xsk_buff_pool *pool,
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         struct virtnet_sq_free_stats stats =3D {};
>         struct net_device *dev =3D vi->dev;
> +       int sent, vring_size;
> +       bool need_wakeup;
>         u64 kicks =3D 0;
> -       int sent;
>
>         /* Avoid to wakeup napi meanless, so call __free_old_xmit instead=
 of
>          * free_old_xmit().
> @@ -1451,8 +1471,29 @@ static bool virtnet_xsk_xmit(struct send_queue *sq=
, struct xsk_buff_pool *pool,
>         if (stats.xsk)
>                 xsk_tx_completed(sq->xsk_pool, stats.xsk);
>
> +       vring_size =3D virtqueue_get_vring_size(sq->vq);
> +       need_wakeup =3D xsk_uses_need_wakeup(pool);
> +       /* If the sq->vq is empty, and the tx ring is empty, and the user
> +        * submit an entry to the tx ring after virtnet_xsk_xmit_batch() =
and
> +        * before xsk_set_tx_need_wakeup(), we will lose the chance to wa=
ke
> +        * up the tx napi, so we have to set the need_wakeup flag here.
> +        */
> +       if (need_wakeup && vring_size =3D=3D sq->vq->num_free)
> +               xsk_set_tx_need_wakeup(pool);
> +
>         sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
>
> +       if (need_wakeup) {
> +               if (vring_size =3D=3D sq->vq->num_free)
> +                       /* we can't wake up by ourself, and it should be =
done
> +                        * by the user.
> +                        */
> +                       xsk_set_tx_need_wakeup(pool);
> +               else
> +                       /* we can wake up from skb_xmit_done() */
> +                       xsk_clear_tx_need_wakeup(pool);
> +       }
> +
>         if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
>                 check_sq_full_and_disable(vi, vi->dev, sq);
>
> @@ -1470,9 +1511,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq,=
 struct xsk_buff_pool *pool,
>         u64_stats_add(&sq->stats.xdp_tx,  sent);
>         u64_stats_update_end(&sq->stats.syncp);
>
> -       if (xsk_uses_need_wakeup(pool))
> -               xsk_set_tx_need_wakeup(pool);
> -
>         return sent;
>  }
>
> --
> 2.54.0
>


