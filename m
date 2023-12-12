Return-Path: <netdev+bounces-56227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E0880E35A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD02282D6F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF328F0;
	Tue, 12 Dec 2023 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc5vElki"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0780E8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702355718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VntsOLPXuWJtx6zQj2tvFN5GConn9kSc0M72tw246g=;
	b=Cc5vElkisxoK69ivsjqSWMAO8XihsssD89GJlz2F/iOPTlG68FZI0MLdZrTQdZJ9v8881+
	3mfbQ7R9mC3wVVExoKqYkoS80lxRw6oThwULWX02SrD5v5/siUhAk4tjBr9OYkZSym233v
	Dtg2wzvT9iO3HH4coAjPVPtjC+4dCXk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-iQilhSjWNku_mdd6N64_Iw-1; Mon, 11 Dec 2023 23:35:16 -0500
X-MC-Unique: iQilhSjWNku_mdd6N64_Iw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77f74245de3so253561685a.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702355716; x=1702960516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VntsOLPXuWJtx6zQj2tvFN5GConn9kSc0M72tw246g=;
        b=mNC7b+vfv1sahI/EhoLiqbfAVu31nHHyjknNGQR2U/TpKB5zOHlA4v4rhwIR5Z/9Vf
         lEg29qe43aFdXSQhuugNNSQuyw27SLR9sPgvU+VLlXRYowByF/H/98yOSASrZ1oKfeJY
         22nRzq6aGhpBQtxEcYj/voND5H13EoDqcwg9YFsgwfwOhWI4fOooGnvlEaKRhqb2Mzlj
         NrkeAAGC9U3Tj9NWC/cqFlB6Gy6brcWo6TDR/Uen33wjUuRMSpYHiUy7gum97nZwz4cw
         hVG6hGmCuBjoTzNtxN5HF0TZinvUvo3rUGyKoNHwQyGoqJ5ZEtc++33gR2toVF0HfvZy
         OJZA==
X-Gm-Message-State: AOJu0Ywiz+/8lHUsOkxi+KK4O9SuD4AZydF/DaQMEhEHHsXP2kioR+vb
	g1zmg9wr6AyXWJLGzpWlIRd8rCTQoE65jbhvPhOArucUo31lcFXtuAWB+TPjJyPulpxkGxH5qrO
	GTqVxRmy9ZNfp1hi0K6N08jvm9a2E/o1w
X-Received: by 2002:a05:620a:4614:b0:77f:6dd:4dba with SMTP id br20-20020a05620a461400b0077f06dd4dbamr8523580qkb.96.1702355716175;
        Mon, 11 Dec 2023 20:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrOyuf1Odoaak2ZYdtgyzyZFIpFfyG35pal8NbvcJN0xXVIGcCgktqW+IfyPOYVkS+zor94oNUfe4BlGyRZ3A=
X-Received: by 2002:a05:620a:4614:b0:77f:6dd:4dba with SMTP id
 br20-20020a05620a461400b0077f06dd4dbamr8523573qkb.96.1702355715908; Mon, 11
 Dec 2023 20:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com>
 <20231205113444.63015-7-linyunsheng@huawei.com> <CACGkMEvVezZnHK-gRWY+MUd_6awnprb024scqPNmMQ05P8rWTQ@mail.gmail.com>
 <424670ab-23d8-663b-10cb-d88906767956@huawei.com>
In-Reply-To: <424670ab-23d8-663b-10cb-d88906767956@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Dec 2023 12:35:04 +0800
Message-ID: <CACGkMEsMdP1B-9RaqibJYfFsd_qJpB+Kta5BnyD_WXH=W2w_OQ@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 7:28=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/12/7 14:00, Jason Wang wrote:
> > On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> ...
>
> >> +
> >> +static int tun_alloc(void)
> >> +{
> >> +       struct ifreq ifr;
> >> +       int fd, e;
> >> +
> >> +       fd =3D open("/dev/net/tun", O_RDWR);
> >> +       if (fd < 0) {
> >> +               perror("Cannot open /dev/net/tun");
> >> +               return fd;
> >> +       }
> >> +
> >> +       memset(&ifr, 0, sizeof(ifr));
> >> +
> >> +       ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
> >
> > Why did you use IFF_TUN but not IFF_TAP here?
>
> To be honest, no particular reason, I just picked IFF_TUN and it happened
> to work for me to test changing in vhost_net_build_xdp().
>
> Is there a particular reason you perfer the IFF_TAP over IFF_TUN?

No preference here. It only matters if you want to test L2 or L3.


>
> >
> >> +       strncpy(ifr.ifr_name, "tun0", IFNAMSIZ);
> >
> > tun0 is pretty common if there's a VPN. Do we need some randomized name=
 here?
>
> How about something like below?
>
> snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
>
> >
> >
> >> +
> >> +       e =3D ioctl(fd, TUNSETIFF, (void *) &ifr);
> >> +       if (e < 0) {
> >> +               perror("ioctl[TUNSETIFF]");
> >> +               close(fd);
> >> +               return e;
> >> +       }
> >> +
> >> +       return fd;
> >> +}
> >> +
> >> +/* Unused */
> >> +void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> >
> > Why do we need trick like these here?
>
> That is because of the below error:
> tools/virtio/./linux/kernel.h:58: undefined reference to `__kmalloc_fake'
>
> when virtio_ring.c is compiled in the userspace, the kmalloc raleted func=
tion
> is implemented in tools/virtio/./linux/kernel.h, which requires those var=
ibles
> to be defined.
>
> >
> >> +
> >> +struct vq_info {
> >> +       int kick;
> >> +       int call;
> >> +       int num;
> >> +       int idx;
> >> +       void *ring;
> >> +       /* copy used for control */
> >> +       struct vring vring;
> >> +       struct virtqueue *vq;
> >> +};
> >> +
> >> +struct vdev_info {
> >> +       struct virtio_device vdev;
> >> +       int control;
> >> +       struct pollfd fds[1];
> >> +       struct vq_info vqs[1];
> >> +       int nvqs;
> >> +       void *buf;
> >> +       size_t buf_size;
> >> +       struct vhost_memory *mem;
> >> +};
> >> +
> >> +static struct vhost_vring_file no_backend =3D { .index =3D 1, .fd =3D=
 -1 },
> >> +                                    backend =3D { .index =3D 1, .fd =
=3D 1 };
> >
> > A magic number like fd =3D 1 is pretty confusing.
> >
> > And I don't see why we need global variables here.
>
> I was using the virtio_test.c as reference, will try to remove it
> if it is possible.
>
> >
> >> +static const struct vhost_vring_state null_state =3D {};
> >> +
>
> ..
>
> >> +
> >> +done:
> >> +       backend.fd =3D tun_alloc();
> >> +       assert(backend.fd >=3D 0);
> >> +       vdev_info_init(&dev, features);
> >> +       vq_info_add(&dev, 256);
> >> +       run_test(&dev, &dev.vqs[0], delayed, batch, reset, nbufs);
> >
> > I'd expect we are testing some basic traffic here. E.g can we use a
> > packet socket then we can test both tx and rx?
>
> Yes, only rx for tun is tested.
> Do you have an idea how to test the tx too? As I am not familar enough
> with vhost_net and tun yet.

Maybe you can have a packet socket to bind to the tun/tap. Then you can tes=
t:

1) TAP RX: by write a packet via virtqueue through vhost_net and read
it from packet socket
2) TAP TX:  by write via packet socket and read it from the virtqueue
through vhost_net

Thanks

>
> >
> > Thanks
>


