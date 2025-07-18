Return-Path: <netdev+bounces-208105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2ACB09E15
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 10:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE0A7B9BF6
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 08:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4182949E5;
	Fri, 18 Jul 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Akv67P4g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A924293C71
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827555; cv=none; b=e3a0Sxu0h8HOZgHI1pJz01kvet5u6PwuVtX/tPaQvFiqyxaXAF3TEZAeyjfUcgdsOuflGTnuupDD3KrxbinssUI3QRloKEOPJ7l4e4z9eoBwHaRN7tHMoX5Bb6J35ArBmcJMRLuIyuPM8OBA8m05gQ2yfJKcRQ8Im+czFaavD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827555; c=relaxed/simple;
	bh=u+hOpWXYGqQzlXztN0daxiDWMdTwEOshtpHvQqgxZTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBLQPOretDR1GueoP90f010Eqhve1CxcqCjcdYnzT12RSfSDjtloDxVNHMmN9vexm2e7U0VLAjmqfqNZmd6Y7sZcXqfttTSjBY0uJqM8Si0czFeNcVfS/H0Zibdip9lgb9h3UiapidDMXzPZ2HMcuN6hcrEnv36ubT4lXBIynf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Akv67P4g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752827552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClO7vf6ZBePINFWsPRFr/+WGIgiWW+sfd60JVlzDBe8=;
	b=Akv67P4gdWrlXT3el9DcBoVd/2viIeArNvghPStEE8NL3oJ3osueu62w72Ybg2pIcQU6CF
	QMvqmGhXIQD/zHkXbAZJZFJ8K0mWz10wZLVdpn+bTyEUspxRoJR/juRgdxJOa4dma+6SUv
	mbl8bz1BiRKwsVnWnhr3uTDfzAAjTeM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Q7yF6pkfNWidu0whqsi9AA-1; Fri, 18 Jul 2025 04:32:30 -0400
X-MC-Unique: Q7yF6pkfNWidu0whqsi9AA-1
X-Mimecast-MFC-AGG-ID: Q7yF6pkfNWidu0whqsi9AA_1752827550
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aec53d77a78so106758866b.1
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 01:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752827549; x=1753432349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClO7vf6ZBePINFWsPRFr/+WGIgiWW+sfd60JVlzDBe8=;
        b=qaRSEEE6ArssEqxuH9+n0TUF7XeGH2Zq/hIQqCsAZPtNqgWR40OZuh0H8+MqJNGUjY
         j/qk/+u6eUj1xAbGoREyc/OPw7tuDuqjLKsYgM8215achQGgQmDowKErzTGcxBNSEPvo
         h8EBhTnZuryfbaiL6+EzoyY759UPfz38+TzOFkoh7L7JDmP/k8s5MpZ/d9gfSj22yatl
         yE17yVDxG5jK6ja19AyEnHvpe2X0M6Rr5CEeB3XM98IZTIs3MPzf2TgJWG1MeUAeEK4W
         1I1RKkz96tSozX1UVk275xBVs634BPeIUKeV2HgUa3+ofBXR07DrGcRxmWL1YaxDq79p
         G+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1MTVn3AKB1lwumejT1cYb/n1KEscsqg470sVawrs1SNbqZwVbSW1PtX/mt0ffmSilxdDxqX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/dBLWu9YU9rZeBlz/AqC+NW3mOFXJ1e6GW8745rPvkXVBKkTb
	1HzIevj0nOLXg7lRxTcIn+2CHFKArkS+zQ9c6QzABfo7ib51egy2sioMpxrf5TEqwkgEpKND3jO
	M3+gg2zeBqkuNMn4vPrUOfdZnMF4I+vpJ13Xp2hmtEaDqGQjvzCQXQzWLdvJ7///z4yi9qBZfLJ
	2wkRjbERmI5KC3eFupSqE67ZOWq7rVPgMe
X-Gm-Gg: ASbGncs48685eiKqKl2InTYZONyldVVQCRBdglZ9j5xJJMsKpPEMRzMDHNSWRJSJTcj
	QsRYL1NYL3GogyVx+tOGCbdCtVi6Drf7xAtUgpCpykamXFxK886JHu5/y06Z2TVktpxoLT/j74H
	OvEkQb3HxMN/OD8DKap30/fQ==
X-Received: by 2002:a17:907:da4:b0:aec:5a33:1573 with SMTP id a640c23a62f3a-aec5a3354femr462487566b.41.1752827549542;
        Fri, 18 Jul 2025 01:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZRbZf1CSxDdcr2KaS1fw9e3BgI0jPEf8QS4qDJaocQ3CHMAkyjsYYe2SLqnUm1+1w/XSVLxztz/eFpNmyZDs=
X-Received: by 2002:a17:907:da4:b0:aec:5a33:1573 with SMTP id
 a640c23a62f3a-aec5a3354femr462485166b.41.1752827549130; Fri, 18 Jul 2025
 01:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716162243.1401676-1-kniv@yandex-team.ru>
In-Reply-To: <20250716162243.1401676-1-kniv@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 18 Jul 2025 16:31:52 +0800
X-Gm-Features: Ac12FXz3P7sVlSAVAM9be3FkuV1rX0FLSe-KqiVKeDU_xg3yE_St4sNLJJ0dYVg
Message-ID: <CAPpAL=xE4ZCyAhc+fkZwREo-cDHS4CG4fq4+sebazJgRzZoDHg@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: Replace wait_queue with completion in ubufs reference
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, stable@vger.kernel.org, 
	Andrey Ryabinin <arbn@yandex-team.com>, Andrey Smetanin <asmetanin@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Thu, Jul 17, 2025 at 12:24=E2=80=AFAM Nikolay Kuratov <kniv@yandex-team.=
ru> wrote:
>
> When operating on struct vhost_net_ubuf_ref, the following execution
> sequence is theoretically possible:
> CPU0 is finalizing DMA operation                   CPU1 is doing VHOST_NE=
T_SET_BACKEND
>                              // &ubufs->refcount =3D=3D 2
> vhost_net_ubuf_put()                               vhost_net_ubuf_put_wai=
t_and_free(oldubufs)
>                                                      vhost_net_ubuf_put_a=
nd_wait()
>                                                        vhost_net_ubuf_put=
()
>                                                          int r =3D atomic=
_sub_return(1, &ubufs->refcount);
>                                                          // r =3D 1
> int r =3D atomic_sub_return(1, &ubufs->refcount);
> // r =3D 0
>                                                       wait_event(ubufs->w=
ait, !atomic_read(&ubufs->refcount));
>                                                       // no wait occurs h=
ere because condition is already true
>                                                     kfree(ubufs);
> if (unlikely(!r))
>   wake_up(&ubufs->wait);  // use-after-free
>
> This leads to use-after-free on ubufs access. This happens because CPU1
> skips waiting for wake_up() when refcount is already zero.
>
> To prevent that use a completion instead of wait_queue as the ubufs
> notification mechanism. wait_for_completion() guarantees that there will
> be complete() call prior to its return.
>
> We also need to reinit completion because refcnt =3D=3D 0 does not mean
> freeing in case of vhost_net_flush() - it then sets refcnt back to 1.
> AFAIK concurrent calls to vhost_net_ubuf_put_and_wait() with the same
> ubufs object aren't possible since those calls (through vhost_net_flush()
> or vhost_net_set_backend()) are protected by the device mutex.
> So reinit_completion() right after wait_for_completion() should be fine.
>
> Cc: stable@vger.kernel.org
> Fixes: 0ad8b480d6ee9 ("vhost: fix ref cnt checking deadlock")
> Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
> Suggested-by: Andrey Smetanin <asmetanin@yandex-team.ru>
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  drivers/vhost/net.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..454d179fffeb 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
>          * >1: outstanding ubufs
>          */
>         atomic_t refcount;
> -       wait_queue_head_t wait;
> +       struct completion wait;
>         struct vhost_virtqueue *vq;
>  };
>
> @@ -240,7 +240,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool=
 zcopy)
>         if (!ubufs)
>                 return ERR_PTR(-ENOMEM);
>         atomic_set(&ubufs->refcount, 1);
> -       init_waitqueue_head(&ubufs->wait);
> +       init_completion(&ubufs->wait);
>         ubufs->vq =3D vq;
>         return ubufs;
>  }
> @@ -249,14 +249,15 @@ static int vhost_net_ubuf_put(struct vhost_net_ubuf=
_ref *ubufs)
>  {
>         int r =3D atomic_sub_return(1, &ubufs->refcount);
>         if (unlikely(!r))
> -               wake_up(&ubufs->wait);
> +               complete_all(&ubufs->wait);
>         return r;
>  }
>
>  static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs=
)
>  {
>         vhost_net_ubuf_put(ubufs);
> -       wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
> +       wait_for_completion(&ubufs->wait);
> +       reinit_completion(&ubufs->wait);
>  }
>
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *=
ubufs)
> --
> 2.34.1
>
>


