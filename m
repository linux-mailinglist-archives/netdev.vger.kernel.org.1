Return-Path: <netdev+bounces-131726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2A698F5A1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18252831B5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532A91AAE18;
	Thu,  3 Oct 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5MrWjrJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3751AAE0D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978238; cv=none; b=kp4GM/rX6l5NxAuzFQTDjGrh8wiOmPL7v0ykaxu+Z4DMFCFHdX1tMpepmiajZ4mnJCvWqaefH66hAma23IF0/7QE4EqIqSfZr5p53nGtytG9RO7+/1PWcu0dMwLB0844mVeBNuB51byKqw/QiuKBFqwHm+UN4UZPAvzelL28j0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978238; c=relaxed/simple;
	bh=3ZyO3IcmTQ/SSUGQQ/NejP5t1A1kJy6ot7wJCZZfiIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEghVMp/pPQ1WzVHaPZISFvR6NT0s5BFzoDGX2GZX6KSV7qh7YUqSHSntxlku2jnOuyI9G2JqtK5z2FAP6Fhmslk782KMZ+Tn9eg1bpJN3yQnv7uiJuOrSyi6W6XtjXhFBfwA1xztXvoMiO3txGZeW5BH0u8HlocYYT9C72oYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5MrWjrJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4581cec6079so28941cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727978235; x=1728583035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdWNAC3GxqX0HrJF6JJgcWqy3baw26VoIN4X1LXVnns=;
        b=A5MrWjrJvQBMOfvAX2HZpvDP6m0+h+TIkui4Dw8NwU73AlOgBJfGonrUpAfmf9ST+N
         THpIGlY0tXv8hZR17P7N3GNbdFq/eXe+dOr8Hd+HYG6Yz/ok17CePrzF1Iy3rLdcI/a+
         F0T33mTw6IyKmrjB2etffVtukik5K4b6M1ziW8M9wScPC3155bXKOOjBiD8StIZtIwzb
         GGnbN9RuDI7ZourMbXiuVruzU6eASSeB0Uli8QRGvOOQSeOTxTiv2JMK9tBLnWwcP6pe
         HF9dMjJ9GZLi3iICqj3wf58Tir0yUeMR3yQMgJYCmAOH0PO8ThXTH04oL0acl5zQBOkW
         TkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727978235; x=1728583035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdWNAC3GxqX0HrJF6JJgcWqy3baw26VoIN4X1LXVnns=;
        b=shDqsY6sCjTo3HqcNesA9sU0lzfi9aNiXXRBoBnyMn+HLHBjdYy/RzwBVDO0SoPSQA
         wBg8uSBa0afi0N43SIXVmOkyhH8T83BujNqK0pXakoOBzokniAAsRJ8QEQAz2bHGJx4z
         l7iYw5wF3AWxMlgjA124OH69AuC0FbfmzYKFMvc5FPfBR+etAIzEI6/nndIB0VPQaIiV
         wH98AdESEjpo3O4XzqB8yGdWd2bjn2+n32ghr3txEu4kthhgkD/Y7kYn+wac75r8dWeW
         RXgf24jNhkRn/SQ+bRUJo8viHFnDKDoy8iIwOiAEo5vzYBiWOxavByEkBVZ8orTmBTvJ
         p+HQ==
X-Gm-Message-State: AOJu0Yzc6SI/qIhX/etfdMzEJVZePCVNi2+W6fekPre0Y7D1+DDWyu7j
	9PhK4FCuMhj+VpTQiL9xXEQ2pFzxaClji13zFnLPi8pwvceigI0Hjm39FVMisXLV3759VutwQ8T
	PQpt886mUzclELx3keId9gIbdY4LpP9n2QOJL
X-Google-Smtp-Source: AGHT+IHNscbR/fMFOQcZQYBsgeg+GPjFrF5NZM9Sj+QAKWFDJ+GhYvSOHV1i7Z2Gw6BLbdMuMqVramfK+gSnF+2HTGk=
X-Received: by 2002:a05:622a:a18b:b0:447:e0a6:9163 with SMTP id
 d75a77b69052e-45d9b44deb6mr133891cf.14.1727978235039; Thu, 03 Oct 2024
 10:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-3-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-3-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 10:57:00 -0700
Message-ID: <CAHS8izNGphJPD6-PkATnOETj-LFLadSAKTe_A+FiJ_3Cax35ZA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] selftests: ncdevmem: Separate out
 dmabuf provider
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> So we can plug the other ones in the future if needed.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Feedback is minor, so with or without it:

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  tools/testing/selftests/net/ncdevmem.c | 215 +++++++++++++++----------
>  1 file changed, 134 insertions(+), 81 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 9245d3f158dd..557175c3bf02 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -71,17 +71,118 @@ static char *ifname =3D "eth1";
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
>
> -void print_bytes(void *ptr, size_t size)
> +struct memory_buffer {
> +       int fd;
> +       size_t size;
> +
> +       int devfd;
> +       int memfd;
> +       char *buf_mem;
> +};
> +
> +struct memory_provider {
> +       struct memory_buffer *(*alloc)(size_t size);
> +       void (*free)(struct memory_buffer *ctx);
> +       void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
> +                                void *src, int n);

AFAICT all this code in this api and its implementation is unused. I'm
guessing this is for the future TX path testing?

If you get the chance to slice these changes out of this patch and
punting them for when the TX changes are ready, please do. Just to
minimize dead code until TX path is added, but since these are tests,
dead code is not a huge deal.

> +       void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
> +                                  size_t off, int n);
> +};
> +
> +static struct memory_buffer *udmabuf_alloc(size_t size)
>  {
> -       unsigned char *p =3D ptr;
> -       int i;
> +       struct udmabuf_create create;
> +       struct memory_buffer *ctx;
> +       int ret;
>
> -       for (i =3D 0; i < size; i++)
> -               printf("%02hhX ", p[i]);
> -       printf("\n");
> +       ctx =3D malloc(sizeof(*ctx));
> +       if (!ctx)
> +               error(1, ENOMEM, "malloc failed");
> +
> +       ctx->size =3D size;
> +
> +       ctx->devfd =3D open("/dev/udmabuf", O_RDWR);
> +       if (ctx->devfd < 0)
> +               error(1, errno,
> +                     "%s: [skip,no-udmabuf: Unable to access DMA buffer =
device file]\n",
> +                     TEST_PREFIX);
> +
> +       ctx->memfd =3D memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> +       if (ctx->memfd < 0)
> +               error(1, errno, "%s: [skip,no-memfd]\n", TEST_PREFIX);
> +
> +       ret =3D fcntl(ctx->memfd, F_ADD_SEALS, F_SEAL_SHRINK);
> +       if (ret < 0)
> +               error(1, errno, "%s: [skip,fcntl-add-seals]\n", TEST_PREF=
IX);
> +
> +       ret =3D ftruncate(ctx->memfd, size);
> +       if (ret =3D=3D -1)
> +               error(1, errno, "%s: [FAIL,memfd-truncate]\n", TEST_PREFI=
X);
> +
> +       memset(&create, 0, sizeof(create));
> +
> +       create.memfd =3D ctx->memfd;
> +       create.offset =3D 0;
> +       create.size =3D size;
> +       ctx->fd =3D ioctl(ctx->devfd, UDMABUF_CREATE, &create);
> +       if (ctx->fd < 0)
> +               error(1, errno, "%s: [FAIL, create udmabuf]\n", TEST_PREF=
IX);
> +
> +       ctx->buf_mem =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHA=
RED,
> +                           ctx->fd, 0);
> +       if (ctx->buf_mem =3D=3D MAP_FAILED)
> +               error(1, errno, "%s: [FAIL, map udmabuf]\n", TEST_PREFIX)=
;
> +
> +       return ctx;
> +}
> +
> +static void udmabuf_free(struct memory_buffer *ctx)
> +{
> +       munmap(ctx->buf_mem, ctx->size);
> +       close(ctx->fd);
> +       close(ctx->memfd);
> +       close(ctx->devfd);
> +       free(ctx);
> +}
> +
> +static void udmabuf_memcpy_to_device(struct memory_buffer *dst, size_t o=
ff,
> +                                    void *src, int n)
> +{
> +       struct dma_buf_sync sync =3D {};
> +
> +       sync.flags =3D DMA_BUF_SYNC_START | DMA_BUF_SYNC_WRITE;
> +       ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> +
> +       memcpy(dst->buf_mem + off, src, n);
> +
> +       sync.flags =3D DMA_BUF_SYNC_END | DMA_BUF_SYNC_WRITE;
> +       ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> +}
> +
> +static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *=
src,
> +                                      size_t off, int n)
> +{
> +       struct dma_buf_sync sync =3D {};
> +
> +       sync.flags =3D DMA_BUF_SYNC_START;
> +       ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
> +
> +       memcpy(dst, src->buf_mem + off, n);
> +
> +       sync.flags =3D DMA_BUF_SYNC_END;
> +       ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
>  }
>
> -void print_nonzero_bytes(void *ptr, size_t size)
> +static struct memory_provider udmabuf_memory_provider =3D {
> +       .alloc =3D udmabuf_alloc,
> +       .free =3D udmabuf_free,
> +       .memcpy_to_device =3D udmabuf_memcpy_to_device,
> +       .memcpy_from_device =3D udmabuf_memcpy_from_device,
> +};
> +
> +static struct memory_provider *provider =3D &udmabuf_memory_provider;
> +
> +static void print_nonzero_bytes(void *ptr, size_t size)
>  {
>         unsigned char *p =3D ptr;
>         unsigned int i;
> @@ -201,42 +302,7 @@ static int bind_rx_queue(unsigned int ifindex, unsig=
ned int dmabuf_fd,
>         return -1;
>  }
>
> -static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmab=
uf_size)
> -{
> -       struct udmabuf_create create;
> -       int ret;
> -
> -       *devfd =3D open("/dev/udmabuf", O_RDWR);
> -       if (*devfd < 0) {
> -               error(70, 0,
> -                     "%s: [skip,no-udmabuf: Unable to access DMA buffer =
device file]\n",
> -                     TEST_PREFIX);
> -       }
> -
> -       *memfd =3D memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> -       if (*memfd < 0)
> -               error(70, 0, "%s: [skip,no-memfd]\n", TEST_PREFIX);
> -
> -       /* Required for udmabuf */
> -       ret =3D fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
> -       if (ret < 0)
> -               error(73, 0, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX)=
;
> -
> -       ret =3D ftruncate(*memfd, dmabuf_size);
> -       if (ret =3D=3D -1)
> -               error(74, 0, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
> -
> -       memset(&create, 0, sizeof(create));
> -
> -       create.memfd =3D *memfd;
> -       create.offset =3D 0;
> -       create.size =3D dmabuf_size;
> -       *buf =3D ioctl(*devfd, UDMABUF_CREATE, &create);
> -       if (*buf < 0)
> -               error(75, 0, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX)=
;
> -}
> -
> -int do_server(void)
> +int do_server(struct memory_buffer *mem)
>  {
>         char ctrl_data[sizeof(int) * 20000];
>         struct netdev_queue_id *queues;
> @@ -244,23 +310,18 @@ int do_server(void)
>         struct sockaddr_in client_addr;
>         struct sockaddr_in server_sin;
>         size_t page_aligned_frags =3D 0;
> -       int devfd, memfd, buf, ret;
>         size_t total_received =3D 0;
>         socklen_t client_addr_len;
>         bool is_devmem =3D false;
> -       char *buf_mem =3D NULL;
> +       char *tmp_mem =3D NULL;
>         struct ynl_sock *ys;
> -       size_t dmabuf_size;
>         char iobuf[819200];
>         char buffer[256];
>         int socket_fd;
>         int client_fd;
>         size_t i =3D 0;
>         int opt =3D 1;
> -
> -       dmabuf_size =3D getpagesize() * NUM_PAGES;
> -
> -       create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
> +       int ret;
>
>         if (reset_flow_steering())
>                 error(1, 0, "Failed to reset flow steering\n");
> @@ -284,13 +345,12 @@ int do_server(void)
>                 queues[i].id =3D start_queue + i;
>         }
>
> -       if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
> +       if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
>                 error(1, 0, "Failed to bind\n");
>
> -       buf_mem =3D mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_S=
HARED,
> -                      buf, 0);
> -       if (buf_mem =3D=3D MAP_FAILED)
> -               error(1, 0, "mmap()");
> +       tmp_mem =3D malloc(mem->size);
> +       if (!tmp_mem)
> +               error(1, ENOMEM, "malloc failed");
>
>         server_sin.sin_family =3D AF_INET;
>         server_sin.sin_port =3D htons(atoi(port));
> @@ -341,7 +401,6 @@ int do_server(void)
>                 struct iovec iov =3D { .iov_base =3D iobuf,
>                                      .iov_len =3D sizeof(iobuf) };
>                 struct dmabuf_cmsg *dmabuf_cmsg =3D NULL;
> -               struct dma_buf_sync sync =3D { 0 };
>                 struct cmsghdr *cm =3D NULL;
>                 struct msghdr msg =3D { 0 };
>                 struct dmabuf_token token;
> @@ -410,22 +469,17 @@ int do_server(void)
>                         else
>                                 page_aligned_frags++;
>
> -                       sync.flags =3D DMA_BUF_SYNC_READ | DMA_BUF_SYNC_S=
TART;
> -                       ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
> +                       provider->memcpy_from_device(tmp_mem, mem,
> +                                                    dmabuf_cmsg->frag_of=
fset,
> +                                                    dmabuf_cmsg->frag_si=
ze);
>
>                         if (do_validation)
>                                 validate_buffer(
> -                                       ((unsigned char *)buf_mem) +
> +                                       ((unsigned char *)tmp_mem) +
>                                                 dmabuf_cmsg->frag_offset,
>                                         dmabuf_cmsg->frag_size);
>                         else
> -                               print_nonzero_bytes(
> -                                       ((unsigned char *)buf_mem) +
> -                                               dmabuf_cmsg->frag_offset,
> -                                       dmabuf_cmsg->frag_size);
> -
> -                       sync.flags =3D DMA_BUF_SYNC_READ | DMA_BUF_SYNC_E=
ND;
> -                       ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
> +                               print_nonzero_bytes(tmp_mem, dmabuf_cmsg-=
>frag_size);
>
>                         ret =3D setsockopt(client_fd, SOL_SOCKET,
>                                          SO_DEVMEM_DONTNEED, &token,
> @@ -450,12 +504,9 @@ int do_server(void)
>
>  cleanup:
>
> -       munmap(buf_mem, dmabuf_size);
> +       free(tmp_mem);
>         close(client_fd);
>         close(socket_fd);
> -       close(buf);
> -       close(memfd);
> -       close(devfd);
>         ynl_sock_destroy(ys);
>
>         return 0;
> @@ -464,14 +515,11 @@ int do_server(void)
>  void run_devmem_tests(void)
>  {
>         struct netdev_queue_id *queues;
> -       int devfd, memfd, buf;
> +       struct memory_buffer *mem;
>         struct ynl_sock *ys;
> -       size_t dmabuf_size;
>         size_t i =3D 0;
>
> -       dmabuf_size =3D getpagesize() * NUM_PAGES;
> -
> -       create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
> +       mem =3D provider->alloc(getpagesize() * NUM_PAGES);
>

There is some weirdness here where run_devmem_tests() allocates its
own provider, but do_server() uses a provider allocated in main(). Any
reason these are not symmetric? I would marginally prefer do_server()
to allocate its own provider just like run_devmem_tests(), or at least
make them both match, if possible.


--=20
Thanks,
Mina

