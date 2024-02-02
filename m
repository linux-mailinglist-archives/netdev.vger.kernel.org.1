Return-Path: <netdev+bounces-68294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB998466C4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 05:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AAA28E40F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 04:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3FCA71;
	Fri,  2 Feb 2024 04:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSF2VPLD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC1313AE9
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846722; cv=none; b=OVUmigAKFWroZ07/OrfZtaUrDaMOUhrA97NHvWPBfdZExh8MfZJSnK5nk5pEXeZq+oDCSsnGjwrxaBgaXEM3aHGqaMMlRdEY5i/X+3RD8c81/X8VEgwYGGZgH+RZ+wAuzzE0duapk4DZtJ1FGm1hVaEyhFCdn5qp6tDvbPBR4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846722; c=relaxed/simple;
	bh=dWXvi333COFPwchlTW8ExA3ESq60zjHHpDLkxnG1M4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blXF4VmuyhbxoTkEyd84teqaumic6YwldjdeAz43SWWZpxfY/PWguS5gR7NvBoH6Pp5ZO/UxcBlFXVHRoSFwg/eayZXprk0D/bYzVXEFNTyNmPZ2gWud1T67yYh+EXNIl+Jdm74+iktJkYZPEKqcloPbI+6CiPAN1uGWmyvefqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSF2VPLD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706846719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1Iy4SrxzFk/JaS8F9chL+yj9ZQHoLBQ78gaOojkWw0=;
	b=KSF2VPLDzra9WkysDz4TMHDm7EeXu2WqfJ3T+y0cQzX+w4AP1O0IAv8lWDoCdVBm67YpNV
	WIwPqaRv1RqwJu4M8aIi714vLxAPIqZma73EkS5wX5YA8oZYvv+pzEJ5aMJzyXhSRPq0Nk
	aETnQ0SO/YABWfCwZuYIRrO2hkhHYxQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-cqyKstj_OpO6hvfgPz9uzQ-1; Thu, 01 Feb 2024 23:05:17 -0500
X-MC-Unique: cqyKstj_OpO6hvfgPz9uzQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6da57e2d2b9so1711264b3a.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 20:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706846716; x=1707451516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1Iy4SrxzFk/JaS8F9chL+yj9ZQHoLBQ78gaOojkWw0=;
        b=m78sStt9cglNHV3tIA0VFlkbv+Gyj3FDUwtZOm6KP8B//QyGVbwWyVk2eBMYOVcnET
         BR73leHvM/JqNvPp9zs2WWZZeGM3ETOpauOA1BVgWVBdMPBpnU8E1nSAkm1JFA1l5eLf
         QaQal0dg3H9DGMfJfe3W6LvcSiLIuqICLlD0QhZJI15Jtw+If7IBCLG36yORwGWMELd0
         1UD+BdmgGA2LzfDODLVDV+SLXDQ9eWIXzmkX6Xl4QrmllWLPtNC4/Hvgh17xI8zH+ySE
         juSddMmrYMvRsYfttnVz5uWe6QlJZEL4p0dcTFBSawH0nIDbzKewmGbHnXt2Pc8ZrcD6
         3ljQ==
X-Gm-Message-State: AOJu0Yy5Xk1IHhACPmakT3aogWy8iHWtFCxw4WYtdkJ4/Op8MvnnLvUQ
	0ZN3VuZPnFCBZwtag+K0e7YBLkfn7LM+gaiv18mgA68pHYJGdhEm9pBFfqoQNchkwywK+plGzSd
	tNAvbWFOLPT98MfbAIoDU0EikUWZ+7jo/1eeht2QfCaH+YPGQGn2v8T4B8yXhVENFSvM2qCG/DN
	r8t1CvNRl+l149j2cXTWO5QvDQ7NIE
X-Received: by 2002:aa7:85cd:0:b0:6dd:9e89:8dd1 with SMTP id z13-20020aa785cd000000b006dd9e898dd1mr6449093pfn.13.1706846716576;
        Thu, 01 Feb 2024 20:05:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB/B9z53yKpfYhDE16fsF2ktWWl8kBF/L8FnujA8nVhApM6VsmChgkOptsfobuajZdyN8GK/5HguEYjom5Czg=
X-Received: by 2002:aa7:85cd:0:b0:6dd:9e89:8dd1 with SMTP id
 z13-20020aa785cd000000b006dd9e898dd1mr6449082pfn.13.1706846716170; Thu, 01
 Feb 2024 20:05:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130113710.34511-1-linyunsheng@huawei.com> <20240130113710.34511-6-linyunsheng@huawei.com>
In-Reply-To: <20240130113710.34511-6-linyunsheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Feb 2024 12:05:04 +0800
Message-ID: <CACGkMEsJq1Fg6T+9YLPzE16027sBHRZodk2+b1ySa9MeMcGjMA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/5] tools: virtio: introduce vhost_net_test
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:38=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> introduce vhost_net_test basing on virtio_test to test
> vhost_net changing in the kernel.

Let's describe what kind of test is being done and how it is done here.

>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  tools/virtio/.gitignore       |   1 +
>  tools/virtio/Makefile         |   8 +-
>  tools/virtio/vhost_net_test.c | 576 ++++++++++++++++++++++++++++++++++
>  3 files changed, 582 insertions(+), 3 deletions(-)
>  create mode 100644 tools/virtio/vhost_net_test.c
>
> diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
> index 9934d48d9a55..7e47b281c442 100644
> --- a/tools/virtio/.gitignore
> +++ b/tools/virtio/.gitignore
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  *.d
>  virtio_test
> +vhost_net_test
>  vringh_test
>  virtio-trace/trace-agent
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index d128925980e0..e25e99c1c3b7 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -1,8 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  all: test mod
> -test: virtio_test vringh_test
> +test: virtio_test vringh_test vhost_net_test
>  virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
> +vhost_net_test: virtio_ring.o vhost_net_test.o
>
>  try-run =3D $(shell set -e;              \
>         if ($(1)) >/dev/null 2>&1;      \
> @@ -49,6 +50,7 @@ oot-clean: OOT_BUILD+=3Dclean
>
>  .PHONY: all test mod clean vhost oot oot-clean oot-build
>  clean:
> -       ${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cm=
d \
> -              vhost_test/Module.symvers vhost_test/modules.order *.d
> +       ${RM} *.o vringh_test virtio_test vhost_net_test vhost_test/*.o \
> +              vhost_test/.*.cmd vhost_test/Module.symvers \
> +              vhost_test/modules.order *.d
>  -include *.d
> diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.=
c
> new file mode 100644
> index 000000000000..e336792a0d77
> --- /dev/null
> +++ b/tools/virtio/vhost_net_test.c
> @@ -0,0 +1,576 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <getopt.h>
> +#include <limits.h>
> +#include <string.h>
> +#include <poll.h>
> +#include <sys/eventfd.h>
> +#include <stdlib.h>
> +#include <assert.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <linux/virtio_types.h>
> +#include <linux/vhost.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/if.h>
> +#include <linux/if_tun.h>
> +#include <linux/in.h>
> +#include <linux/if_packet.h>
> +#include <netinet/ether.h>
> +
> +#define RANDOM_BATCH   -1
> +#define HDR_LEN                12
> +#define TEST_BUF_LEN   256
> +#define TEST_PTYPE     ETH_P_LOOPBACK
> +
> +/* Used by implementation of kmalloc() in tools/virtio/linux/kernel.h */
> +void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> +
> +struct vq_info {
> +       int kick;
> +       int call;
> +       int idx;
> +       long started;
> +       long completed;
> +       struct pollfd fds;
> +       void *ring;
> +       /* copy used for control */
> +       struct vring vring;
> +       struct virtqueue *vq;
> +};
> +
> +struct vdev_info {
> +       struct virtio_device vdev;
> +       int control;
> +       struct vq_info vqs[2];
> +       int nvqs;
> +       void *buf;
> +       size_t buf_size;
> +       char *test_buf;
> +       char *res_buf;
> +       struct vhost_memory *mem;
> +       int sock;
> +       int ifindex;
> +       unsigned char mac[ETHER_ADDR_LEN];
> +};
> +
> +static int tun_alloc(struct vdev_info *dev)
> +{
> +       struct ifreq ifr;
> +       int len =3D HDR_LEN;

Any reason you can't just use the virtio_net uapi?

> +       int fd, e;
> +
> +       fd =3D open("/dev/net/tun", O_RDWR);
> +       if (fd < 0) {
> +               perror("Cannot open /dev/net/tun");
> +               return fd;
> +       }
> +
> +       memset(&ifr, 0, sizeof(ifr));
> +
> +       ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
> +
> +       e =3D ioctl(fd, TUNSETIFF, &ifr);
> +       if (e < 0) {
> +               perror("ioctl[TUNSETIFF]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       e =3D ioctl(fd, TUNSETVNETHDRSZ, &len);
> +       if (e < 0) {
> +               perror("ioctl[TUNSETVNETHDRSZ]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       e =3D ioctl(fd, SIOCGIFHWADDR, &ifr);
> +       if (e < 0) {
> +               perror("ioctl[SIOCGIFHWADDR]");
> +               close(fd);
> +               return e;
> +       }
> +
> +       memcpy(dev->mac, &ifr.ifr_hwaddr.sa_data, ETHER_ADDR_LEN);
> +       return fd;
> +}
> +
> +static void vdev_create_socket(struct vdev_info *dev)
> +{
> +       struct ifreq ifr;
> +
> +       dev->sock =3D socket(AF_PACKET, SOCK_RAW, htons(TEST_PTYPE));
> +       assert(dev->sock !=3D -1);
> +
> +       snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());

Nit: it might be better to accept the device name instead of repeating
the snprintf trick here, this would facilitate the future changes.

> +       assert(ioctl(dev->sock, SIOCGIFINDEX, &ifr) >=3D 0);
> +
> +       dev->ifindex =3D ifr.ifr_ifindex;
> +
> +       /* Set the flags that bring the device up */
> +       assert(ioctl(dev->sock, SIOCGIFFLAGS, &ifr) >=3D 0);
> +       ifr.ifr_flags |=3D (IFF_UP | IFF_RUNNING);
> +       assert(ioctl(dev->sock, SIOCSIFFLAGS, &ifr) >=3D 0);
> +}
> +
> +static void vdev_send_packet(struct vdev_info *dev)
> +{
> +       char *sendbuf =3D dev->test_buf + HDR_LEN;
> +       struct sockaddr_ll saddrll =3D {0};
> +       int sockfd =3D dev->sock;
> +       int ret;
> +
> +       saddrll.sll_family =3D PF_PACKET;
> +       saddrll.sll_ifindex =3D dev->ifindex;
> +       saddrll.sll_halen =3D ETH_ALEN;
> +       saddrll.sll_protocol =3D htons(TEST_PTYPE);
> +
> +       ret =3D sendto(sockfd, sendbuf, TEST_BUF_LEN, 0,
> +                    (struct sockaddr *)&saddrll,
> +                    sizeof(struct sockaddr_ll));
> +       assert(ret >=3D 0);
> +}
> +
> +static bool vq_notify(struct virtqueue *vq)
> +{
> +       struct vq_info *info =3D vq->priv;
> +       unsigned long long v =3D 1;
> +       int r;
> +
> +       r =3D write(info->kick, &v, sizeof(v));
> +       assert(r =3D=3D sizeof(v));
> +
> +       return true;
> +}
> +
> +static void vq_callback(struct virtqueue *vq)
> +{
> +}
> +
> +static void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
> +{
> +       struct vhost_vring_addr addr =3D {
> +               .index =3D info->idx,
> +               .desc_user_addr =3D (uint64_t)(unsigned long)info->vring.=
desc,
> +               .avail_user_addr =3D (uint64_t)(unsigned long)info->vring=
.avail,
> +               .used_user_addr =3D (uint64_t)(unsigned long)info->vring.=
used,
> +       };
> +       struct vhost_vring_state state =3D { .index =3D info->idx };
> +       struct vhost_vring_file file =3D { .index =3D info->idx };
> +       int r;
> +
> +       state.num =3D info->vring.num;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
> +       assert(r >=3D 0);
> +
> +       state.num =3D 0;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_BASE, &state);
> +       assert(r >=3D 0);
> +
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_ADDR, &addr);
> +       assert(r >=3D 0);
> +
> +       file.fd =3D info->kick;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_KICK, &file);
> +       assert(r >=3D 0);
> +
> +       file.fd =3D info->call;
> +       r =3D ioctl(dev->control, VHOST_SET_VRING_CALL, &file);
> +       assert(r >=3D 0);
> +}
> +
> +static void vq_reset(struct vq_info *info, int num, struct virtio_device=
 *vdev)
> +{
> +       if (info->vq)
> +               vring_del_virtqueue(info->vq);
> +
> +       memset(info->ring, 0, vring_size(num, 4096));
> +       vring_init(&info->vring, num, info->ring, 4096);
> +       info->vq =3D vring_new_virtqueue(info->idx, num, 4096, vdev, true=
, false,
> +                                      info->ring, vq_notify, vq_callback=
, "test");
> +       assert(info->vq);
> +       info->vq->priv =3D info;
> +}
> +
> +static void vq_info_add(struct vdev_info *dev, int idx, int num, int fd)
> +{
> +       struct vhost_vring_file backend =3D { .index =3D idx, .fd =3D fd =
};
> +       struct vq_info *info =3D &dev->vqs[idx];
> +       int r;
> +
> +       info->idx =3D idx;
> +       info->kick =3D eventfd(0, EFD_NONBLOCK);
> +       info->call =3D eventfd(0, EFD_NONBLOCK);

If we don't care about the callback, let's just avoid to set the call here?

(As I see vq_callback is a NULL)

> +       r =3D posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> +       assert(r >=3D 0);
> +       vq_reset(info, num, &dev->vdev);
> +       vhost_vq_setup(dev, info);
> +       info->fds.fd =3D info->call;
> +       info->fds.events =3D POLLIN;
> +
> +       r =3D ioctl(dev->control, VHOST_NET_SET_BACKEND, &backend);
> +       assert(!r);
> +}
> +
> +static void vdev_info_init(struct vdev_info *dev, unsigned long long fea=
tures)
> +{
> +       struct ether_header *eh;
> +       int i, r;
> +
> +       dev->vdev.features =3D features;
> +       INIT_LIST_HEAD(&dev->vdev.vqs);
> +       spin_lock_init(&dev->vdev.vqs_list_lock);
> +
> +       dev->buf_size =3D (HDR_LEN + TEST_BUF_LEN) * 2;
> +       dev->buf =3D malloc(dev->buf_size);
> +       assert(dev->buf);
> +       dev->test_buf =3D dev->buf;
> +       dev->res_buf =3D dev->test_buf + HDR_LEN + TEST_BUF_LEN;
> +
> +       memset(dev->test_buf, 0, HDR_LEN + TEST_BUF_LEN);
> +       eh =3D (struct ether_header *)(dev->test_buf + HDR_LEN);
> +       eh->ether_type =3D htons(TEST_PTYPE);
> +       memcpy(eh->ether_dhost, dev->mac, ETHER_ADDR_LEN);
> +       memcpy(eh->ether_shost, dev->mac, ETHER_ADDR_LEN);
> +
> +       for (i =3D sizeof(*eh); i < TEST_BUF_LEN; i++)
> +               dev->test_buf[i + HDR_LEN] =3D (char)i;
> +
> +       dev->control =3D open("/dev/vhost-net", O_RDWR);
> +       assert(dev->control >=3D 0);
> +
> +       r =3D ioctl(dev->control, VHOST_SET_OWNER, NULL);
> +       assert(r >=3D 0);
> +
> +       dev->mem =3D malloc(offsetof(struct vhost_memory, regions) +
> +                         sizeof(dev->mem->regions[0]));
> +       assert(dev->mem);
> +       memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
> +              sizeof(dev->mem->regions[0]));
> +       dev->mem->nregions =3D 1;
> +       dev->mem->regions[0].guest_phys_addr =3D (long)dev->buf;
> +       dev->mem->regions[0].userspace_addr =3D (long)dev->buf;
> +       dev->mem->regions[0].memory_size =3D dev->buf_size;
> +
> +       r =3D ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
> +       assert(r >=3D 0);
> +
> +       r =3D ioctl(dev->control, VHOST_SET_FEATURES, &features);
> +       assert(r >=3D 0);
> +
> +       dev->nvqs =3D 2;
> +}
> +
> +static void wait_for_interrupt(struct vq_info *vq)
> +{
> +       unsigned long long val;
> +
> +       poll(&vq->fds, 1, -1);
> +
> +       if (vq->fds.revents & POLLIN)
> +               read(vq->fds.fd, &val, sizeof(val));
> +}
> +
> +static void verify_res_buf(char *res_buf)
> +{
> +       int i;
> +
> +       for (i =3D ETHER_HDR_LEN; i < TEST_BUF_LEN; i++)
> +               assert(res_buf[i] =3D=3D (char)i);
> +}
> +
> +static void run_tx_test(struct vdev_info *dev, struct vq_info *vq,
> +                       bool delayed, int batch, int bufs)

It might be better to describe the test design briefly above as a
comment. Or we can start from simple test logic and add sophisticated
ones on top.

> +{
> +       const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
> +       long long spurious =3D 0;
> +       struct scatterlist sl;
> +       unsigned int len;
> +       int r;
> +
> +       for (;;) {
> +               long started_before =3D vq->started;
> +               long completed_before =3D vq->completed;
> +
> +               virtqueue_disable_cb(vq->vq);
> +               do {
> +                       if (random_batch)
> +                               batch =3D (random() % vq->vring.num) + 1;
> +
> +                       while (vq->started < bufs &&
> +                              (vq->started - vq->completed) < batch) {
> +                               sg_init_one(&sl, dev->test_buf, HDR_LEN +=
 TEST_BUF_LEN);
> +                               r =3D virtqueue_add_outbuf(vq->vq, &sl, 1=
,
> +                                                        dev->test_buf + =
vq->started,
> +                                                        GFP_ATOMIC);
> +                               if (unlikely(r !=3D 0)) {
> +                                       if (r =3D=3D -ENOSPC &&
> +                                           vq->started > started_before)
> +                                               r =3D 0;
> +                                       else
> +                                               r =3D -1;
> +                                       break;
> +                               }
> +
> +                               ++vq->started;
> +
> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
> +                                       r =3D -1;
> +                                       break;
> +                               }
> +                       }
> +
> +                       if (vq->started >=3D bufs)
> +                               r =3D -1;
> +
> +                       /* Flush out completed bufs if any */
> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> +                               int n;
> +
> +                               n =3D recvfrom(dev->sock, dev->res_buf, T=
EST_BUF_LEN, 0, NULL, NULL);
> +                               assert(n =3D=3D TEST_BUF_LEN);
> +                               verify_res_buf(dev->res_buf);
> +
> +                               ++vq->completed;
> +                               r =3D 0;
> +                       }
> +               } while (r =3D=3D 0);
> +
> +               if (vq->completed =3D=3D completed_before && vq->started =
=3D=3D started_before)
> +                       ++spurious;
> +
> +               assert(vq->completed <=3D bufs);
> +               assert(vq->started <=3D bufs);
> +               if (vq->completed =3D=3D bufs)
> +                       break;
> +
> +               if (delayed) {
> +                       if (virtqueue_enable_cb_delayed(vq->vq))
> +                               wait_for_interrupt(vq);
> +               } else {
> +                       if (virtqueue_enable_cb(vq->vq))
> +                               wait_for_interrupt(vq);
> +               }
> +       }
> +       printf("TX spurious wakeups: 0x%llx started=3D0x%lx completed=3D0=
x%lx\n",
> +              spurious, vq->started, vq->completed);
> +}
> +
> +static void run_rx_test(struct vdev_info *dev, struct vq_info *vq,
> +                       bool delayed, int batch, int bufs)
> +{
> +       const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
> +       long long spurious =3D 0;
> +       struct scatterlist sl;
> +       unsigned int len;
> +       int r;
> +
> +       for (;;) {
> +               long started_before =3D vq->started;
> +               long completed_before =3D vq->completed;
> +
> +               do {
> +                       if (random_batch)
> +                               batch =3D (random() % vq->vring.num) + 1;
> +
> +                       while (vq->started < bufs &&
> +                              (vq->started - vq->completed) < batch) {
> +                               sg_init_one(&sl, dev->res_buf, HDR_LEN + =
TEST_BUF_LEN);
> +
> +                               r =3D virtqueue_add_inbuf(vq->vq, &sl, 1,
> +                                                       dev->res_buf + vq=
->started,
> +                                                       GFP_ATOMIC);
> +                               if (unlikely(r !=3D 0)) {
> +                                       if (r =3D=3D -ENOSPC &&

Drivers usually maintain a #free_slots, this can help to avoid the
trick for checking ENOSPC?

> +                                           vq->started > started_before)
> +                                               r =3D 0;
> +                                       else
> +                                               r =3D -1;
> +                                       break;
> +                               }
> +
> +                               ++vq->started;
> +
> +                               vdev_send_packet(dev);
> +
> +                               if (unlikely(!virtqueue_kick(vq->vq))) {
> +                                       r =3D -1;
> +                                       break;
> +                               }
> +                       }
> +
> +                       if (vq->started >=3D bufs)
> +                               r =3D -1;
> +
> +                       /* Flush out completed bufs if any */
> +                       while (virtqueue_get_buf(vq->vq, &len)) {
> +                               struct ether_header *eh;
> +
> +                               eh =3D (struct ether_header *)(dev->res_b=
uf + HDR_LEN);
> +
> +                               /* tun netdev is up and running, ignore t=
he
> +                                * non-TEST_PTYPE packet.
> +                                */

I wonder if it's better to set up some kind of qdisc to avoid the
unexpected packet here, or is it too complicated?

Thanks


