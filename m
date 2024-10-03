Return-Path: <netdev+bounces-131793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD798F990
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E72281517
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703271C2DB2;
	Thu,  3 Oct 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyxE4fGi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08651C6F48
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993288; cv=none; b=fQnM7FEyNkP25KwK+YZGIUBdoNE1xJFK7GW0apmk/ZhFU8dFAwTcnQYoK/krXnTD/8QeSe3VQKdyDEH1/WJHg+z1E1AbsmRQmBg+y+RMxSmHvlk0POmaevhN42qdJUaiCFsfxiDM4tFtbvZDi8FB0kPmC83w0AwKNR+xrlUCvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993288; c=relaxed/simple;
	bh=hSVGVNnVsSLmvAmwOs3/m5Qq4Ax8LuV38IZFdKIaMq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZC1rLx10HUj0GpFXHJOtHo9UvKBZu5Ol2D3JwoPTYTvAmejHaHLLrGzPqT26ZmeVrzQ+7/KXUkBCkIPiql9swKefkJZIQtaIVqzbjqSL/dmTI2T+kV96UxqnPgVqz68UmtlGvWeWldfcPIgB/JFVFJprqtU15ynkPuHtfz+Sl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyxE4fGi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71971d2099cso1366653b3a.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993286; x=1728598086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tx28KCMixzMvwWc0E1mLZbT0yJKnZ20+UvA7uKtEONY=;
        b=lyxE4fGiMfAs9hzkvx5aNxeIAlKO+U/utpNnXNM/zSb1BapSgEfZiH5YQ40TIW3Zce
         DtQY4L0pMzRcM8jd5D/VlBm+CdqImP8aAywD/nmXzVwZ4M/RdC4FrJ/E8FiQzXMJvTB/
         DM05QcBiTJR5BdkIawOSgIKQR/P3T3gNGduypGrHyMbEJFl2MDemZziPJ0LtsKNT1kgZ
         37DWJSogOCR68M+ThXWb1Ykc9mUnTnoEEZtmKkq5lzKjQUroOR34KgsVMt9q6mk1Vvip
         eqsHYtBuny2Vn+tm86K2QqVQ1C6Be0SklMjrgmOpEteEmanNHJCScNYY5hwiduG1kdRx
         Y5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993286; x=1728598086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx28KCMixzMvwWc0E1mLZbT0yJKnZ20+UvA7uKtEONY=;
        b=P58F/pRIRUrOj/nE6v/Bg2815Vqw/1Cu52XA0KVlKx74CsQhU76IqQpK8jqi1MUJZA
         64kjnIQrp/047uZobDR/E4uq0PkElIO7AN2q94vQjYnBGOlwDZ3ziV9Ds+GpU8kCQ8m7
         cvVTxBMN+wnMlipZ9Z/F2nzCDrvnWc8S10LmXvcfnUhNnXBhnL5aVlQzAWxKR5DNjBzQ
         zKycznKM3XSNVNbHYJo2NrFKr4n+HIc/IoKx/F5m3veQMeY7jNVhhNlihKQhK04d/8+s
         sKxLNLmWqn0+NzXWGSDSkCYe0zZyPUiQvTcOL9k3wdqacGd+v3xJUnE+GNxsxMVdcpja
         Rjug==
X-Forwarded-Encrypted: i=1; AJvYcCXgiMh1KiLrSCiDRg9fAxZxLjkYrplB9RHJvK0PQaB0b57Wk7rLn5qatWT5mOWJhdlB+Q87Wik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgHfjCHL5C4JflorpE3heQV+hTOValK2Navx/LXOV5EguQaua
	grYsWdt+d1mGe1LvNIt4LWVz/y76P/RQvhDfBurIuzsjzkI5oi8FMSoYKx8=
X-Google-Smtp-Source: AGHT+IF2uS51C/oYG6GU2kxtkfdBnmxk8VYWjmFobd9Dnb0lJ6KdH5RQtorugqiUOqXv43AcB2+RnQ==
X-Received: by 2002:a05:6a00:1408:b0:70d:323f:d0c6 with SMTP id d2e1a72fcca58-71de24720b7mr1007226b3a.24.1727993285766;
        Thu, 03 Oct 2024 15:08:05 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddbab9sm1874895b3a.115.2024.10.03.15.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:08:05 -0700 (PDT)
Date: Thu, 3 Oct 2024 15:08:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 02/12] selftests: ncdevmem: Separate out
 dmabuf provider
Message-ID: <Zv8VxOJiEWHmcWpj@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-3-sdf@fomichev.me>
 <CAHS8izNGphJPD6-PkATnOETj-LFLadSAKTe_A+FiJ_3Cax35ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNGphJPD6-PkATnOETj-LFLadSAKTe_A+FiJ_3Cax35ZA@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > So we can plug the other ones in the future if needed.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Feedback is minor, so with or without it:
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 215 +++++++++++++++----------
> >  1 file changed, 134 insertions(+), 81 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 9245d3f158dd..557175c3bf02 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -71,17 +71,118 @@ static char *ifname = "eth1";
> >  static unsigned int ifindex;
> >  static unsigned int dmabuf_id;
> >
> > -void print_bytes(void *ptr, size_t size)
> > +struct memory_buffer {
> > +       int fd;
> > +       size_t size;
> > +
> > +       int devfd;
> > +       int memfd;
> > +       char *buf_mem;
> > +};
> > +
> > +struct memory_provider {
> > +       struct memory_buffer *(*alloc)(size_t size);
> > +       void (*free)(struct memory_buffer *ctx);
> > +       void (*memcpy_to_device)(struct memory_buffer *dst, size_t off,
> > +                                void *src, int n);
> 
> AFAICT all this code in this api and its implementation is unused. I'm
> guessing this is for the future TX path testing?
> 
> If you get the chance to slice these changes out of this patch and
> punting them for when the TX changes are ready, please do. Just to
> minimize dead code until TX path is added, but since these are tests,
> dead code is not a huge deal.

Ah, yes, I'll remove it for now.

> > +       void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
> > +                                  size_t off, int n);
> > +};
> > +
> > +static struct memory_buffer *udmabuf_alloc(size_t size)
> >  {
> > -       unsigned char *p = ptr;
> > -       int i;
> > +       struct udmabuf_create create;
> > +       struct memory_buffer *ctx;
> > +       int ret;
> >
> > -       for (i = 0; i < size; i++)
> > -               printf("%02hhX ", p[i]);
> > -       printf("\n");
> > +       ctx = malloc(sizeof(*ctx));
> > +       if (!ctx)
> > +               error(1, ENOMEM, "malloc failed");
> > +
> > +       ctx->size = size;
> > +
> > +       ctx->devfd = open("/dev/udmabuf", O_RDWR);
> > +       if (ctx->devfd < 0)
> > +               error(1, errno,
> > +                     "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
> > +                     TEST_PREFIX);
> > +
> > +       ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> > +       if (ctx->memfd < 0)
> > +               error(1, errno, "%s: [skip,no-memfd]\n", TEST_PREFIX);
> > +
> > +       ret = fcntl(ctx->memfd, F_ADD_SEALS, F_SEAL_SHRINK);
> > +       if (ret < 0)
> > +               error(1, errno, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
> > +
> > +       ret = ftruncate(ctx->memfd, size);
> > +       if (ret == -1)
> > +               error(1, errno, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
> > +
> > +       memset(&create, 0, sizeof(create));
> > +
> > +       create.memfd = ctx->memfd;
> > +       create.offset = 0;
> > +       create.size = size;
> > +       ctx->fd = ioctl(ctx->devfd, UDMABUF_CREATE, &create);
> > +       if (ctx->fd < 0)
> > +               error(1, errno, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
> > +
> > +       ctx->buf_mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
> > +                           ctx->fd, 0);
> > +       if (ctx->buf_mem == MAP_FAILED)
> > +               error(1, errno, "%s: [FAIL, map udmabuf]\n", TEST_PREFIX);
> > +
> > +       return ctx;
> > +}
> > +
> > +static void udmabuf_free(struct memory_buffer *ctx)
> > +{
> > +       munmap(ctx->buf_mem, ctx->size);
> > +       close(ctx->fd);
> > +       close(ctx->memfd);
> > +       close(ctx->devfd);
> > +       free(ctx);
> > +}
> > +
> > +static void udmabuf_memcpy_to_device(struct memory_buffer *dst, size_t off,
> > +                                    void *src, int n)
> > +{
> > +       struct dma_buf_sync sync = {};
> > +
> > +       sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_WRITE;
> > +       ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> > +
> > +       memcpy(dst->buf_mem + off, src, n);
> > +
> > +       sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_WRITE;
> > +       ioctl(dst->fd, DMA_BUF_IOCTL_SYNC, &sync);
> > +}
> > +
> > +static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
> > +                                      size_t off, int n)
> > +{
> > +       struct dma_buf_sync sync = {};
> > +
> > +       sync.flags = DMA_BUF_SYNC_START;
> > +       ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
> > +
> > +       memcpy(dst, src->buf_mem + off, n);
> > +
> > +       sync.flags = DMA_BUF_SYNC_END;
> > +       ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
> >  }
> >
> > -void print_nonzero_bytes(void *ptr, size_t size)
> > +static struct memory_provider udmabuf_memory_provider = {
> > +       .alloc = udmabuf_alloc,
> > +       .free = udmabuf_free,
> > +       .memcpy_to_device = udmabuf_memcpy_to_device,
> > +       .memcpy_from_device = udmabuf_memcpy_from_device,
> > +};
> > +
> > +static struct memory_provider *provider = &udmabuf_memory_provider;
> > +
> > +static void print_nonzero_bytes(void *ptr, size_t size)
> >  {
> >         unsigned char *p = ptr;
> >         unsigned int i;
> > @@ -201,42 +302,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
> >         return -1;
> >  }
> >
> > -static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmabuf_size)
> > -{
> > -       struct udmabuf_create create;
> > -       int ret;
> > -
> > -       *devfd = open("/dev/udmabuf", O_RDWR);
> > -       if (*devfd < 0) {
> > -               error(70, 0,
> > -                     "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
> > -                     TEST_PREFIX);
> > -       }
> > -
> > -       *memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> > -       if (*memfd < 0)
> > -               error(70, 0, "%s: [skip,no-memfd]\n", TEST_PREFIX);
> > -
> > -       /* Required for udmabuf */
> > -       ret = fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
> > -       if (ret < 0)
> > -               error(73, 0, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
> > -
> > -       ret = ftruncate(*memfd, dmabuf_size);
> > -       if (ret == -1)
> > -               error(74, 0, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
> > -
> > -       memset(&create, 0, sizeof(create));
> > -
> > -       create.memfd = *memfd;
> > -       create.offset = 0;
> > -       create.size = dmabuf_size;
> > -       *buf = ioctl(*devfd, UDMABUF_CREATE, &create);
> > -       if (*buf < 0)
> > -               error(75, 0, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
> > -}
> > -
> > -int do_server(void)
> > +int do_server(struct memory_buffer *mem)
> >  {
> >         char ctrl_data[sizeof(int) * 20000];
> >         struct netdev_queue_id *queues;
> > @@ -244,23 +310,18 @@ int do_server(void)
> >         struct sockaddr_in client_addr;
> >         struct sockaddr_in server_sin;
> >         size_t page_aligned_frags = 0;
> > -       int devfd, memfd, buf, ret;
> >         size_t total_received = 0;
> >         socklen_t client_addr_len;
> >         bool is_devmem = false;
> > -       char *buf_mem = NULL;
> > +       char *tmp_mem = NULL;
> >         struct ynl_sock *ys;
> > -       size_t dmabuf_size;
> >         char iobuf[819200];
> >         char buffer[256];
> >         int socket_fd;
> >         int client_fd;
> >         size_t i = 0;
> >         int opt = 1;
> > -
> > -       dmabuf_size = getpagesize() * NUM_PAGES;
> > -
> > -       create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
> > +       int ret;
> >
> >         if (reset_flow_steering())
> >                 error(1, 0, "Failed to reset flow steering\n");
> > @@ -284,13 +345,12 @@ int do_server(void)
> >                 queues[i].id = start_queue + i;
> >         }
> >
> > -       if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
> > +       if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
> >                 error(1, 0, "Failed to bind\n");
> >
> > -       buf_mem = mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> > -                      buf, 0);
> > -       if (buf_mem == MAP_FAILED)
> > -               error(1, 0, "mmap()");
> > +       tmp_mem = malloc(mem->size);
> > +       if (!tmp_mem)
> > +               error(1, ENOMEM, "malloc failed");
> >
> >         server_sin.sin_family = AF_INET;
> >         server_sin.sin_port = htons(atoi(port));
> > @@ -341,7 +401,6 @@ int do_server(void)
> >                 struct iovec iov = { .iov_base = iobuf,
> >                                      .iov_len = sizeof(iobuf) };
> >                 struct dmabuf_cmsg *dmabuf_cmsg = NULL;
> > -               struct dma_buf_sync sync = { 0 };
> >                 struct cmsghdr *cm = NULL;
> >                 struct msghdr msg = { 0 };
> >                 struct dmabuf_token token;
> > @@ -410,22 +469,17 @@ int do_server(void)
> >                         else
> >                                 page_aligned_frags++;
> >
> > -                       sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
> > -                       ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
> > +                       provider->memcpy_from_device(tmp_mem, mem,
> > +                                                    dmabuf_cmsg->frag_offset,
> > +                                                    dmabuf_cmsg->frag_size);
> >
> >                         if (do_validation)
> >                                 validate_buffer(
> > -                                       ((unsigned char *)buf_mem) +
> > +                                       ((unsigned char *)tmp_mem) +
> >                                                 dmabuf_cmsg->frag_offset,
> >                                         dmabuf_cmsg->frag_size);
> >                         else
> > -                               print_nonzero_bytes(
> > -                                       ((unsigned char *)buf_mem) +
> > -                                               dmabuf_cmsg->frag_offset,
> > -                                       dmabuf_cmsg->frag_size);
> > -
> > -                       sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_END;
> > -                       ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
> > +                               print_nonzero_bytes(tmp_mem, dmabuf_cmsg->frag_size);
> >
> >                         ret = setsockopt(client_fd, SOL_SOCKET,
> >                                          SO_DEVMEM_DONTNEED, &token,
> > @@ -450,12 +504,9 @@ int do_server(void)
> >
> >  cleanup:
> >
> > -       munmap(buf_mem, dmabuf_size);
> > +       free(tmp_mem);
> >         close(client_fd);
> >         close(socket_fd);
> > -       close(buf);
> > -       close(memfd);
> > -       close(devfd);
> >         ynl_sock_destroy(ys);
> >
> >         return 0;
> > @@ -464,14 +515,11 @@ int do_server(void)
> >  void run_devmem_tests(void)
> >  {
> >         struct netdev_queue_id *queues;
> > -       int devfd, memfd, buf;
> > +       struct memory_buffer *mem;
> >         struct ynl_sock *ys;
> > -       size_t dmabuf_size;
> >         size_t i = 0;
> >
> > -       dmabuf_size = getpagesize() * NUM_PAGES;
> > -
> > -       create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
> > +       mem = provider->alloc(getpagesize() * NUM_PAGES);
> >
> 
> There is some weirdness here where run_devmem_tests() allocates its
> own provider, but do_server() uses a provider allocated in main(). Any
> reason these are not symmetric? I would marginally prefer do_server()
> to allocate its own provider just like run_devmem_tests(), or at least
> make them both match, if possible.

I wanted to keep them separate in case we end up adding more to
the selftest part. For example, not sure what would happen now if we pass
a udmabuf with just one page? Do we need some test for the drivers
to make sure they handle this case?

