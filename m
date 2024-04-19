Return-Path: <netdev+bounces-89541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DD8AA9EA
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A961C21ADD
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD094EB43;
	Fri, 19 Apr 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cK8Lbufg"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0E4AED9
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514513; cv=none; b=mgcrxyc4eOW67Uy6ZhxeZWgqBdm8WZL6ocayxzY4S7aVEbj/1QN3tdbFaR6SPI5fRUl0t1o7WQw0jdegplW1ys5ahlD7azwaNKUFSldd0bITZImmiHyNkEyCjZ9xMqhLUUTH92t8+eDqSnlnrQecImQ6N868BWlM21GIIgNsThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514513; c=relaxed/simple;
	bh=W6O1N8q8160ivDtBwYT5ybDM6oi1sXpWvlup6bOebvo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=r07MwC+IaAEdddQ29cyp0bqKSp4O7wgKzaoBy33qcOSZ7r0HfEb6GddFPHmiwHdDwByJVXl+ihr1GKVQl2ndLUh14PN1ELKG1gixhyp5gRUlYPwS0xGWsI4LwXHzuIvt1EHHEa2AsP9VeTt92T9uDsVFZzBUSXi2k1Z4hMZwYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cK8Lbufg; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713514503; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=SsTvPpb3tY0YMGgwwpXAnb7QNWsQY/02fECcwa2Vi/w=;
	b=cK8LbufgvSiroPb5qRSz5CsL9V/gt5KAJ1wulWUevdE5e+txhVkEjrLNFSa3ubM0Fq8Lp8qmqV8p94piwPArauX+y77LFZ68BICb4Jw1NjuobEBzpYY0pjCr8Wy5X0fddrgzoJJSP+6CzurJSxZu34WhH0JtvRqUwoZGzqfkt3s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4rWc88_1713514501;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4rWc88_1713514501)
          by smtp.aliyun-inc.com;
          Fri, 19 Apr 2024 16:15:02 +0800
Message-ID: <1713514442.7951615-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
Date: Fri, 19 Apr 2024 16:14:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEvhejnVM=x2+PxnKXcyC4W4nAbhkt4-reWb-7=fYQ6qKw@mail.gmail.com>
 <1713428960.80807-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvDQ1Zs3Ya0TR1O8SANDEmBQ-+_2iFt7dpBDeE=i+PExQ@mail.gmail.com>
 <1713500472.3614385-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsDB+tMFEvRtyDAz83dkd9fpuh51u=KyUZkgh+gizmK7g@mail.gmail.com>
 <1713510204.1357317-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvconuYjrg1Oi6mgLAWCw5Pq=i_CrivnzTJ+ONavV8Rzw@mail.gmail.com>
 <1713511597.5359378-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEu-SXDrnUX2jcVepxOo-QYo7QhwDRs-4_Rrc3Pf1K1Q6g@mail.gmail.com>
In-Reply-To: <CACGkMEu-SXDrnUX2jcVepxOo-QYo7QhwDRs-4_Rrc3Pf1K1Q6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 19 Apr 2024 16:12:15 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Apr 19, 2024 at 3:28=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Fri, 19 Apr 2024 15:24:25 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Apr 19, 2024 at 3:07=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Fri, 19 Apr 2024 13:46:25 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Fri, Apr 19, 2024 at 12:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > >
> > > > > > On Fri, 19 Apr 2024 08:43:43 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Thu, Apr 18, 2024 at 4:35=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, 18 Apr 2024 14:25:06 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanz=
huo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > In big mode, pre-mapping DMA is beneficial because if t=
he pages are not
> > > > > > > > > > used, we can reuse them without needing to unmap and re=
map.
> > > > > > > > > >
> > > > > > > > > > We require space to store the DMA address. I use the pa=
ge.dma_addr to
> > > > > > > > > > store the DMA address from the pp structure inside the =
page.
> > > > > > > > > >
> > > > > > > > > > Every page retrieved from get_a_page() is mapped, and i=
ts DMA address is
> > > > > > > > > > stored in page.dma_addr. When a page is returned to the=
 chain, we check
> > > > > > > > > > the DMA status; if it is not mapped (potentially having=
 been unmapped),
> > > > > > > > > > we remap it before returning it to the chain.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/net/virtio_net.c | 98 ++++++++++++++++++++++++=
+++++++++-------
> > > > > > > > > >  1 file changed, 81 insertions(+), 17 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/vir=
tio_net.c
> > > > > > > > > > index 4446fb54de6d..7ea7e9bcd5d7 100644
> > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > @@ -50,6 +50,7 @@ module_param(napi_tx, bool, 0644);
> > > > > > > > > >
> > > > > > > > > >  #define page_chain_next(p)     ((struct page *)((p)->p=
p))
> > > > > > > > > >  #define page_chain_add(p, n)   ((p)->pp =3D (void *)n)
> > > > > > > > > > +#define page_dma_addr(p)       ((p)->dma_addr)
> > > > > > > > > >
> > > > > > > > > >  /* RX packet size EWMA. The average packet size is use=
d to determine the packet
> > > > > > > > > >   * buffer size when refilling RX rings. As the entire =
RX ring may be refilled
> > > > > > > > > > @@ -434,6 +435,46 @@ skb_vnet_common_hdr(struct sk_buff=
 *skb)
> > > > > > > > > >         return (struct virtio_net_common_hdr *)skb->cb;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static void sg_fill_dma(struct scatterlist *sg, dma_ad=
dr_t addr, u32 len)
> > > > > > > > > > +{
> > > > > > > > > > +       sg->dma_address =3D addr;
> > > > > > > > > > +       sg->length =3D len;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void page_chain_unmap(struct receive_queue *rq,=
 struct page *p)
> > > > > > > > > > +{
> > > > > > > > > > +       virtqueue_dma_unmap_page_attrs(rq->vq, page_dma=
_addr(p), PAGE_SIZE,
> > > > > > > > > > +                                      DMA_FROM_DEVICE,=
 0);
> > > > > > > > > > +
> > > > > > > > > > +       page_dma_addr(p) =3D DMA_MAPPING_ERROR;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int page_chain_map(struct receive_queue *rq, st=
ruct page *p)
> > > > > > > > > > +{
> > > > > > > > > > +       dma_addr_t addr;
> > > > > > > > > > +
> > > > > > > > > > +       addr =3D virtqueue_dma_map_page_attrs(rq->vq, p=
, 0, PAGE_SIZE, DMA_FROM_DEVICE, 0);
> > > > > > > > > > +       if (virtqueue_dma_mapping_error(rq->vq, addr))
> > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > +
> > > > > > > > > > +       page_dma_addr(p) =3D addr;
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void page_chain_release(struct receive_queue *r=
q)
> > > > > > > > > > +{
> > > > > > > > > > +       struct page *p, *n;
> > > > > > > > > > +
> > > > > > > > > > +       for (p =3D rq->pages; p; p =3D n) {
> > > > > > > > > > +               n =3D page_chain_next(p);
> > > > > > > > > > +
> > > > > > > > > > +               page_chain_unmap(rq, p);
> > > > > > > > > > +               __free_pages(p, 0);
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       rq->pages =3D NULL;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  /*
> > > > > > > > > >   * put the whole most recent used list in the beginnin=
g for reuse
> > > > > > > > > >   */
> > > > > > > > > > @@ -441,6 +482,13 @@ static void give_pages(struct rece=
ive_queue *rq, struct page *page)
> > > > > > > > > >  {
> > > > > > > > > >         struct page *end;
> > > > > > > > > >
> > > > > > > > > > +       if (page_dma_addr(page) =3D=3D DMA_MAPPING_ERRO=
R) {
> > > > > > > > >
> > > > > > > > > This looks strange, the map should be done during allocat=
ion. Under
> > > > > > > > > which condition could we hit this?
> > > > > > > >
> > > > > > > > This first page is umapped before we call page_to_skb().
> > > > > > > > The page can be put back to the link in case of failure.
> > > > > > >
> > > > > > > See below.
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > +               if (page_chain_map(rq, page)) {
> > > > > > > > > > +                       __free_pages(page, 0);
> > > > > > > > > > +                       return;
> > > > > > > > > > +               }
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > >         /* Find end of list, sew whole thing into vi->r=
q.pages. */
> > > > > > > > > >         for (end =3D page; page_chain_next(end); end =
=3D page_chain_next(end));
> > > > > > > > > >
> > > > > > > > > > @@ -456,8 +504,15 @@ static struct page *get_a_page(str=
uct receive_queue *rq, gfp_t gfp_mask)
> > > > > > > > > >                 rq->pages =3D page_chain_next(p);
> > > > > > > > > >                 /* clear chain here, it is used to chai=
n pages */
> > > > > > > > > >                 page_chain_add(p, NULL);
> > > > > > > > > > -       } else
> > > > > > > > > > +       } else {
> > > > > > > > > >                 p =3D alloc_page(gfp_mask);
> > > > > > > > > > +
> > > > > > > > > > +               if (page_chain_map(rq, p)) {
> > > > > > > > > > +                       __free_pages(p, 0);
> > > > > > > > > > +                       return NULL;
> > > > > > > > > > +               }
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > >         return p;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > @@ -613,8 +668,6 @@ static struct sk_buff *page_to_skb(=
struct virtnet_info *vi,
> > > > > > > > > >                         return NULL;
> > > > > > > > > >
> > > > > > > > > >                 page =3D page_chain_next(page);
> > > > > > > > > > -               if (page)
> > > > > > > > > > -                       give_pages(rq, page);
> > > > > > > > > >                 goto ok;
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > > @@ -640,6 +693,7 @@ static struct sk_buff *page_to_skb(=
struct virtnet_info *vi,
> > > > > > > > > >                         skb_add_rx_frag(skb, 0, page, o=
ffset, len, truesize);
> > > > > > > > > >                 else
> > > > > > > > > >                         page_to_free =3D page;
> > > > > > > > > > +               page =3D NULL;
> > > > > > > > > >                 goto ok;
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > > @@ -657,6 +711,11 @@ static struct sk_buff *page_to_skb=
(struct virtnet_info *vi,
> > > > > > > > > >         BUG_ON(offset >=3D PAGE_SIZE);
> > > > > > > > > >         while (len) {
> > > > > > > > > >                 unsigned int frag_size =3D min((unsigne=
d)PAGE_SIZE - offset, len);
> > > > > > > > > > +
> > > > > > > > > > +               /* unmap the page before using it. */
> > > > > > > > > > +               if (!offset)
> > > > > > > > > > +                       page_chain_unmap(rq, page);
> > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > This sounds strange, do we need a virtqueue_sync_for_cpu(=
) helper here?
> > > > > > > >
> > > > > > > > I think we do not need that. Because the umap api does it.
> > > > > > > > We do not work with DMA_SKIP_SYNC;
> > > > > > >
> > > > > > > Well, the problem is unmap is too heavyweight and it reduces =
the
> > > > > > > effort of trying to avoid map/umaps as much as possible.
> > > > > > >
> > > > > > > For example, for most of the case DMA sync is just a nop. And=
 such
> > > > > > > unmap() cause strange code in give_pages() as we discuss abov=
e?
> > > > > >
> > > > > > YES. You are right. For the first page, we just need to sync fo=
r cpu.
> > > > > > And we do not need to check the dma status.
> > > > > > But here (in page_to_skb), we need to call unmap, because this =
page is put
> > > > > > to the skb.
> > > > >
> > > > > Right, but issue still,
> > > > >
> > > > > The only case that we may hit
> > > > >
> > > > >         if (page_dma_addr(page) =3D=3D DMA_MAPPING_ERROR)
> > > > >
> > > > > is when the packet is smaller than GOOD_COPY_LEN.
> > > > >
> > > > > So if we sync_for_cpu for the head page, we don't do:
> > > > >
> > > > > 1) unmap in the receive_big()
> > > > > 2) do snyc_for_cpu() just before skb_put_data(), so the page coul=
d be
> > > > > recycled to the pool without unmapping?
> > > >
> > > >
> > > > I do not get.
> > >
> > > I meant something like e1000_copybreak().
> > >
> > > >
> > > > I think we can remove the code "if (page_dma_addr(page) =3D=3D DMA_=
MAPPING_ERROR)"
> > > > from give_pages(). We just do unmap when the page is leaving virtio=
-net.
> > >
> > > That's the point.
> > >
> > > >
> > > > >
> > > > > And I think we should do something similar for the mergeable case?
> > > >
> > > > Do what?
> > > >
> > > > We have used the sync api for mergeable case.
> > >
> > > Where?
> > >
> > > I see virtnet_rq_get_buf which did sync but it is done after the page=
_to_skb().
> >
> > What means "done"?
> >
> > Do you want to reuse the buffer?
>
> Nope, I think I misread the code. Mergeable buffers should be fine as
> the unmap were during virtnet_receive().
>
> But the code might needs some tweak in the future
>
> in virtnet_receive() we had:
>
> if (!vi->big_packets || vi->mergeable_rx_bufs) {
>         virtnet_rq_get_buf
>         receive_buf()
> } else {
>         virtqueue_get_buf()
> }
>
> but there's another switch in receive_buf():
>
> if (vi->mergeable_rx_bufs)
> else if (vi->big_packets)
> else
> ...
>
> Which is kind of a mess somehow.

YES. I will change this in the AF_XDP patch set.

Thanks.


>
> Thanks
> >
> > Thanks.
> >
> > >
> > > >
> > > >
> > > > >
> > > > > Btw, I found one the misleading comment introduced by f80bd740cb7=
c9
> > > > >
> > > > >         /* copy small packet so we can reuse these pages */
> > > > >         if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >=3D=
 shinfo_size) {
> > > > >
> > > > > We're not copying but building skb around the head page.
> > > >
> > > > Will fix.
> > > >
> > > > Thanks.
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

