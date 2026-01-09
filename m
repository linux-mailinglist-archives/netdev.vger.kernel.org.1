Return-Path: <netdev+bounces-248326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 700E5D06F88
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 04:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F33302CBA1
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 03:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B8215ADB4;
	Fri,  9 Jan 2026 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G83d1tkl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggedIn/x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3A500971
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928621; cv=none; b=ovsQfQUW0vmCehH6e140rMV01nwKdr2W6p1X/koNbGI2rsJUeOnIfLBw1Frk2FsRrUR2R+f3XFG28FUydw2qgrdiEmLkw/DINBOAmQ4/tCWEjQY4H2kPeiZgtqaV65gSip9TUcPnDDhAzxId96hrhVPgTDMKpbJJIEPK7R/FW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928621; c=relaxed/simple;
	bh=mx/kw2F0cO0kPD/dwKQZZ9WWUUSWrNFV/LgJPTfEvLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eB9N5BbrlE0uyoElh6/dXAfsUU/7qCm3RenFmXwyIlb23ZxUwRKzBDlTn4TzVv623DGnjQju4ElBubAs2fVXomPRBCeD5zRoa2rQLMkuS84IgQB2pZpMZD1mVgQ88T8AslqqpyuPn2FufvTNv4bukBG6Wcsdmz4i8oEiPNWoDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G83d1tkl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggedIn/x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767928618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miIvJ0NSyCC0/poCNDylVOS4rdzSSRcqf0y6tbJAnss=;
	b=G83d1tklivCQje8Z6DLREqcyVISSY35OgTt9L833hiNdKo+Clydn3dfnVLtYmfBAXUYty9
	I/9+vKKSKYlDXHzbpco3SMeTMfrv4AFYk8TzxQnJeV+EqvgJR9b762gVuD/NbUUfi/icVq
	BhpFdNMDodL/3fcunZY7iw/+voRBuC4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343---zqsnSnPtOM1hKGpCcTfw-1; Thu, 08 Jan 2026 22:16:57 -0500
X-MC-Unique: --zqsnSnPtOM1hKGpCcTfw-1
X-Mimecast-MFC-AGG-ID: --zqsnSnPtOM1hKGpCcTfw_1767928616
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ec823527eso5924004a91.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 19:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767928616; x=1768533416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miIvJ0NSyCC0/poCNDylVOS4rdzSSRcqf0y6tbJAnss=;
        b=ggedIn/xO2OQgy2il8RdzQQUlM6qRuHe8/W4aXrlf9QbwM5kRFivFO0vD4hFmJulNM
         z2mW5+cT//j283kkCkHcGTvX84bAVuEI42X5ypeTMD1It++wvKSbSizFRRsZ1TgHwc/O
         4oesuLks/tQtaC7ckEZ4BOrdCa4tHeRO08F1HKJzvF8imRMtjS6FAbU514EwpuojD79g
         Ab+YPRTLyPYVY71f+5cFk5c3g0UMNN8vCe/wH2JjJc8Il+NjVHO/IEnL71OHpgFJaDZ8
         OpxjzmzFbHtSoykVVMxAHtPq1f0XC+3Q7cTmgiVUBLPViih1PfEzOkXEBpTBTDvR0/e8
         2oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767928616; x=1768533416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miIvJ0NSyCC0/poCNDylVOS4rdzSSRcqf0y6tbJAnss=;
        b=YDHBgOacd8mr0heYzwyu3p1mPCdDN090ZDj5CjwPGuXQiNRVnXz4Au0XeNtVJIss4B
         4jQxCRW1ie43krHT1gEzkRt9n4MPjpvhZW4CXi0JB6SueTZKpZgM2wMfAoYL2tPDnOZV
         A1tCcLsu8YPbSY7Oh9JRBNIZaGfk190bhMCVFKORvf/IPnA/YviW3yh/jZdLe5F6vVN5
         GNpH5bvvOS3uUqfNwiSjh8CRT+76hJV+M5tZzS7hTMEsBAYTg27uhZO+hEjGS1RVk/Tm
         ZTveG2LNWrHw8PeaG2WZh4WoKjbQaXVibp2f7Y1lLEsqSCFGcpCyS3r/WjUSiDB1g0Qk
         miUA==
X-Forwarded-Encrypted: i=1; AJvYcCUKZF32ZeoKFAYCyneYSwrouArPpFIYbL6qwNCm2gkC9IqM2oPQy6rPLJkSKSVi+XYIp+14jI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hIAgZW0bRkmkXbX319Xx6RGAClA0kcOmAzw9L0gQto9Axv0U
	Ibb1Jmx/1D6amvGjjD8xeLjMY26w01OlIb+eoFR5CFyD6Xoi2BxKEjIkbkEmYYOwk92B80ilPP9
	LL9UcWMjcqeXZtXdgfJeqR6Yd0F/K9p9ZX+ccKMJmNwMP8BsjpvPcPXVjHvqv4Whzt7ycnz26m6
	VHxIQPCqcMaot2Wsi84JNBo38yhhxej94h
X-Gm-Gg: AY/fxX5baGC75QVwKzHiemGc+QtMQcuVTX8xwYVozE5LBSY+/kDCrS2UByzUw8f1QGB
	KUkf8WI6DToSFVVnLtuFNfvLCpI3L1w2hp8XhjfcEo6m+VTf4iTHje8GyiGP+RmYvE9WTbgeJx5
	NcEYmDzLDSOmYG/0LLxWQuF7WuSS0Lr5ntPra9z/KWnyysjYdOtCa3DLBYr8DFHHo=
X-Received: by 2002:a17:90b:5745:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-34f68c629ccmr7917818a91.27.1767928615626;
        Thu, 08 Jan 2026 19:16:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6dEzgl9A3Uq5Z054ylWDstwv71wcEXORpgJL5aUloG3quADnc+qJjeq2aZToAZj2zSKl9JgqvWfr0OCkT7eQ=
X-Received: by 2002:a17:90b:5745:b0:32d:db5b:7636 with SMTP id
 98e67ed59e1d1-34f68c629ccmr7917787a91.27.1767928614987; Thu, 08 Jan 2026
 19:16:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106221924.123856-1-vishs@meta.com> <20260106221924.123856-2-vishs@meta.com>
 <CACGkMEsfvG5NHd0ShC3DoQEfGH8FeUXDD7FFdb64wK_CkbgQ=g@mail.gmail.com> <bba34d18-6b90-4454-ab61-6769342d9114@meta.com>
In-Reply-To: <bba34d18-6b90-4454-ab61-6769342d9114@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jan 2026 11:16:39 +0800
X-Gm-Features: AQt7F2qAOn_CTh_3UhCCHSprjBtkwHVAeSjD1W27XzE7JZwyGstfOWSkr7bd6ww
Message-ID: <CACGkMEuChs5WHg5916e=odvLU09r8ER-1+VXi5rp+LLo0s6UUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: add page pool support for buffer allocation
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 2:24=E2=80=AFPM Vishwanath Seshagiri <vishs@meta.com=
> wrote:
>
> On 1/7/26 7:16 PM, Jason Wang wrote:
> > On Wed, Jan 7, 2026 at 6:19=E2=80=AFAM Vishwanath Seshagiri <vishs@meta=
.com> wrote:
> >>
> >> Use page_pool for RX buffer allocation in mergeable and small buffer
> >> modes. skb_mark_for_recycle() enables page reuse.
> >>
> >> Big packets mode is unchanged because it uses page->private for linked
> >> list chaining of multiple pages per buffer, which conflicts with
> >> page_pool's internal use of page->private.
> >>
> >> Page pools are created in ndo_open and destroyed in remove (not
> >> ndo_close). This follows existing driver behavior where RX buffers
> >> remain in the virtqueue across open/close cycles and are only freed
> >> on device removal.
> >>
> >> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
> >> sending control virtqueue commands while ndo_close is tearing down
> >> device state. With MEM_TYPE_PAGE_POOL, xdp_rxq_info_unreg() calls
> >> page_pool_destroy() during close, and concurrent rx_mode_work can
> >> cause virtqueue corruption. The check is after rtnl_lock() to
> >> synchronize with ndo_close(), which sets the flag under the same lock.
> >>
> >> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> >> ---
> >>   drivers/net/virtio_net.c | 246 ++++++++++++++++++++++++++++++++-----=
--
> >>   1 file changed, 205 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 22d894101c01..c36663525c17 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -26,6 +26,7 @@
> >>   #include <net/netdev_rx_queue.h>
> >>   #include <net/netdev_queues.h>
> >>   #include <net/xdp_sock_drv.h>
> >> +#include <net/page_pool/helpers.h>
> >>
> >>   static int napi_weight =3D NAPI_POLL_WEIGHT;
> >>   module_param(napi_weight, int, 0444);
> >> @@ -359,6 +360,8 @@ struct receive_queue {
> >>          /* Page frag for packet buffer allocation. */
> >>          struct page_frag alloc_frag;
> >>
> >> +       struct page_pool *page_pool;
> >> +
> >>          /* RX: fragments + linear part + virtio header */
> >>          struct scatterlist sg[MAX_SKB_FRAGS + 2];
> >>
> >> @@ -524,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *=
xdp_prog, struct xdp_buff *xdp,
> >>                                 struct virtnet_rq_stats *stats);
> >>   static void virtnet_receive_done(struct virtnet_info *vi, struct rec=
eive_queue *rq,
> >>                                   struct sk_buff *skb, u8 flags);
> >> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_s=
kb,
> >> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *=
rq,
> >> +                                              struct sk_buff *head_sk=
b,
> >>                                                 struct sk_buff *curr_s=
kb,
> >>                                                 struct page *page, voi=
d *buf,
> >>                                                 int len, int truesize)=
;
> >>   static void virtnet_xsk_completed(struct send_queue *sq, int num);
> >> +static void free_unused_bufs(struct virtnet_info *vi);
> >>
> >>   enum virtnet_xmit_type {
> >>          VIRTNET_XMIT_TYPE_SKB,
> >> @@ -709,15 +714,24 @@ static struct page *get_a_page(struct receive_qu=
eue *rq, gfp_t gfp_mask)
> >>          return p;
> >>   }
> >>
> >> +static void virtnet_put_page(struct receive_queue *rq, struct page *p=
age,
> >> +                            bool allow_direct)
> >> +{
> >> +       if (rq->page_pool)
> >> +               page_pool_put_page(rq->page_pool, page, -1, allow_dire=
ct);
> >> +       else
> >> +               put_page(page);
> >> +}
> >> +
> >>   static void virtnet_rq_free_buf(struct virtnet_info *vi,
> >>                                  struct receive_queue *rq, void *buf)
> >>   {
> >>          if (vi->mergeable_rx_bufs)
> >> -               put_page(virt_to_head_page(buf));
> >> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
> >>          else if (vi->big_packets)
> >>                  give_pages(rq, buf);
> >>          else
> >> -               put_page(virt_to_head_page(buf));
> >> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
> >>   }
> >>
> >>   static void enable_delayed_refill(struct virtnet_info *vi)
> >> @@ -894,9 +908,11 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> >>                  if (unlikely(!skb))
> >>                          return NULL;
> >>
> >> -               page =3D (struct page *)page->private;
> >> -               if (page)
> >> -                       give_pages(rq, page);
> >> +               if (!rq->page_pool) {
> >> +                       page =3D (struct page *)page->private;
> >> +                       if (page)
> >> +                               give_pages(rq, page);
> >> +               }
> >>                  goto ok;
> >>          }
> >>
> >> @@ -931,7 +947,10 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> >>                  skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,=
 offset,
> >>                                  frag_size, truesize);
> >>                  len -=3D frag_size;
> >> -               page =3D (struct page *)page->private;
> >> +               if (!rq->page_pool)
> >> +                       page =3D (struct page *)page->private;
> >> +               else
> >> +                       page =3D NULL;
> >>                  offset =3D 0;
> >>          }
> >>
> >> @@ -942,7 +961,7 @@ static struct sk_buff *page_to_skb(struct virtnet_=
info *vi,
> >>          hdr =3D skb_vnet_common_hdr(skb);
> >>          memcpy(hdr, hdr_p, hdr_len);
> >>          if (page_to_free)
> >> -               put_page(page_to_free);
> >> +               virtnet_put_page(rq, page_to_free, true);
> >>
> >>          return skb;
> >>   }
> >> @@ -982,15 +1001,10 @@ static void virtnet_rq_unmap(struct receive_que=
ue *rq, void *buf, u32 len)
> >>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, =
void **ctx)
> >>   {
> >>          struct virtnet_info *vi =3D rq->vq->vdev->priv;
> >> -       void *buf;
> >>
> >>          BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> >>
> >> -       buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> >> -       if (buf)
> >> -               virtnet_rq_unmap(rq, buf, *len);
> >> -
> >> -       return buf;
> >> +       return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> >>   }
> >>
> >>   static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *b=
uf, u32 len)
> >> @@ -1084,9 +1098,6 @@ static void virtnet_rq_unmap_free_buf(struct vir=
tqueue *vq, void *buf)
> >>                  return;
> >>          }
> >>
> >> -       if (!vi->big_packets || vi->mergeable_rx_bufs)
> >> -               virtnet_rq_unmap(rq, buf, 0);
> >> -
> >>          virtnet_rq_free_buf(vi, rq, buf);
> >>   }
> >>
> >> @@ -1352,7 +1363,7 @@ static int xsk_append_merge_buffer(struct virtne=
t_info *vi,
> >>
> >>                  truesize =3D len;
> >>
> >> -               curr_skb  =3D virtnet_skb_append_frag(head_skb, curr_s=
kb, page,
> >> +               curr_skb  =3D virtnet_skb_append_frag(rq, head_skb, cu=
rr_skb, page,
> >>                                                      buf, len, truesiz=
e);
> >>                  if (!curr_skb) {
> >>                          put_page(page);
> >> @@ -1788,7 +1799,7 @@ static int virtnet_xdp_xmit(struct net_device *d=
ev,
> >>          return ret;
> >>   }
> >>
> >> -static void put_xdp_frags(struct xdp_buff *xdp)
> >> +static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue =
*rq)
> >>   {
> >>          struct skb_shared_info *shinfo;
> >>          struct page *xdp_page;
> >> @@ -1798,7 +1809,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
> >>                  shinfo =3D xdp_get_shared_info_from_buff(xdp);
> >>                  for (i =3D 0; i < shinfo->nr_frags; i++) {
> >>                          xdp_page =3D skb_frag_page(&shinfo->frags[i])=
;
> >> -                       put_page(xdp_page);
> >> +                       virtnet_put_page(rq, xdp_page, true);
> >>                  }
> >>          }
> >>   }
> >> @@ -1914,7 +1925,7 @@ static struct page *xdp_linearize_page(struct ne=
t_device *dev,
> >>                  off =3D buf - page_address(p);
> >>
> >>                  if (check_mergeable_len(dev, ctx, buflen)) {
> >> -                       put_page(p);
> >> +                       virtnet_put_page(rq, p, true);
> >>                          goto err_buf;
> >>                  }
> >>
> >> @@ -1922,14 +1933,14 @@ static struct page *xdp_linearize_page(struct =
net_device *dev,
> >>                   * is sending packet larger than the MTU.
> >>                   */
> >>                  if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> >> -                       put_page(p);
> >> +                       virtnet_put_page(rq, p, true);
> >>                          goto err_buf;
> >>                  }
> >>
> >>                  memcpy(page_address(page) + page_off,
> >>                         page_address(p) + off, buflen);
> >>                  page_off +=3D buflen;
> >> -               put_page(p);
> >> +               virtnet_put_page(rq, p, true);
> >>          }
> >>
> >>          /* Headroom does not contribute to packet length */
> >> @@ -1979,7 +1990,7 @@ static struct sk_buff *receive_small_xdp(struct =
net_device *dev,
> >>          unsigned int headroom =3D vi->hdr_len + header_offset;
> >>          struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf + header_offset;
> >>          struct page *page =3D virt_to_head_page(buf);
> >> -       struct page *xdp_page;
> >> +       struct page *xdp_page =3D NULL;
> >>          unsigned int buflen;
> >>          struct xdp_buff xdp;
> >>          struct sk_buff *skb;
> >> @@ -2013,7 +2024,7 @@ static struct sk_buff *receive_small_xdp(struct =
net_device *dev,
> >>                          goto err_xdp;
> >>
> >>                  buf =3D page_address(xdp_page);
> >> -               put_page(page);
> >> +               virtnet_put_page(rq, page, true);
> >>                  page =3D xdp_page;
> >>          }
> >>
> >> @@ -2045,13 +2056,19 @@ static struct sk_buff *receive_small_xdp(struc=
t net_device *dev,
> >>          if (metasize)
> >>                  skb_metadata_set(skb, metasize);
> >>
> >> +       if (rq->page_pool && !xdp_page)
> >> +               skb_mark_for_recycle(skb);
> >> +
> >>          return skb;
> >>
> >>   err_xdp:
> >>          u64_stats_inc(&stats->xdp_drops);
> >>   err:
> >>          u64_stats_inc(&stats->drops);
> >> -       put_page(page);
> >> +       if (xdp_page)
> >> +               put_page(page);
> >> +       else
> >> +               virtnet_put_page(rq, page, true);
> >>   xdp_xmit:
> >>          return NULL;
> >>   }
> >> @@ -2099,12 +2116,15 @@ static struct sk_buff *receive_small(struct ne=
t_device *dev,
> >>          }
> >>
> >>          skb =3D receive_small_build_skb(vi, xdp_headroom, buf, len);
> >> -       if (likely(skb))
> >> +       if (likely(skb)) {
> >> +               if (rq->page_pool)
> >> +                       skb_mark_for_recycle(skb);
> >>                  return skb;
> >> +       }
> >>
> >>   err:
> >>          u64_stats_inc(&stats->drops);
> >> -       put_page(page);
> >> +       virtnet_put_page(rq, page, true);
> >>          return NULL;
> >>   }
> >>
> >> @@ -2159,7 +2179,7 @@ static void mergeable_buf_free(struct receive_qu=
eue *rq, int num_buf,
> >>                  }
> >>                  u64_stats_add(&stats->bytes, len);
> >>                  page =3D virt_to_head_page(buf);
> >> -               put_page(page);
> >> +               virtnet_put_page(rq, page, true);
> >>          }
> >>   }
> >>
> >> @@ -2270,7 +2290,7 @@ static int virtnet_build_xdp_buff_mrg(struct net=
_device *dev,
> >>                  offset =3D buf - page_address(page);
> >>
> >>                  if (check_mergeable_len(dev, ctx, len)) {
> >> -                       put_page(page);
> >> +                       virtnet_put_page(rq, page, true);
> >>                          goto err;
> >>                  }
> >>
> >> @@ -2289,7 +2309,7 @@ static int virtnet_build_xdp_buff_mrg(struct net=
_device *dev,
> >>          return 0;
> >>
> >>   err:
> >> -       put_xdp_frags(xdp);
> >> +       put_xdp_frags(xdp, rq);
> >>          return -EINVAL;
> >>   }
> >>
> >> @@ -2364,7 +2384,7 @@ static void *mergeable_xdp_get_buf(struct virtne=
t_info *vi,
> >>
> >>          *frame_sz =3D PAGE_SIZE;
> >>
> >> -       put_page(*page);
> >> +       virtnet_put_page(rq, *page, true);
> >>
> >>          *page =3D xdp_page;
> >>
> >> @@ -2386,6 +2406,7 @@ static struct sk_buff *receive_mergeable_xdp(str=
uct net_device *dev,
> >>          struct page *page =3D virt_to_head_page(buf);
> >>          int offset =3D buf - page_address(page);
> >>          unsigned int xdp_frags_truesz =3D 0;
> >> +       struct page *org_page =3D page;
> >>          struct sk_buff *head_skb;
> >>          unsigned int frame_sz;
> >>          struct xdp_buff xdp;
> >> @@ -2410,6 +2431,8 @@ static struct sk_buff *receive_mergeable_xdp(str=
uct net_device *dev,
> >>                  head_skb =3D build_skb_from_xdp_buff(dev, vi, &xdp, x=
dp_frags_truesz);
> >>                  if (unlikely(!head_skb))
> >>                          break;
> >> +               if (rq->page_pool && page =3D=3D org_page)
> >> +                       skb_mark_for_recycle(head_skb);
> >>                  return head_skb;
> >>
> >>          case XDP_TX:
> >> @@ -2420,10 +2443,13 @@ static struct sk_buff *receive_mergeable_xdp(s=
truct net_device *dev,
> >>                  break;
> >>          }
> >>
> >> -       put_xdp_frags(&xdp);
> >> +       put_xdp_frags(&xdp, rq);
> >>
> >>   err_xdp:
> >> -       put_page(page);
> >> +       if (page !=3D org_page)
> >> +               put_page(page);
> >> +       else
> >> +               virtnet_put_page(rq, page, true);
> >>          mergeable_buf_free(rq, num_buf, dev, stats);
> >>
> >>          u64_stats_inc(&stats->xdp_drops);
> >> @@ -2431,7 +2457,8 @@ static struct sk_buff *receive_mergeable_xdp(str=
uct net_device *dev,
> >>          return NULL;
> >>   }
> >>
> >> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_s=
kb,
> >> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *=
rq,
> >> +                                              struct sk_buff *head_sk=
b,
> >>                                                 struct sk_buff *curr_s=
kb,
> >>                                                 struct page *page, voi=
d *buf,
> >>                                                 int len, int truesize)
> >> @@ -2463,7 +2490,7 @@ static struct sk_buff *virtnet_skb_append_frag(s=
truct sk_buff *head_skb,
> >>
> >>          offset =3D buf - page_address(page);
> >>          if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) =
{
> >> -               put_page(page);
> >> +               virtnet_put_page(rq, page, true);
> >>                  skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
> >>                                       len, truesize);
> >>          } else {
> >> @@ -2512,10 +2539,13 @@ static struct sk_buff *receive_mergeable(struc=
t net_device *dev,
> >>          }
> >>
> >>          head_skb =3D page_to_skb(vi, rq, page, offset, len, truesize,=
 headroom);
> >> +       if (unlikely(!head_skb))
> >> +               goto err_skb;
> >> +
> >>          curr_skb =3D head_skb;
> >>
> >> -       if (unlikely(!curr_skb))
> >> -               goto err_skb;
> >> +       if (rq->page_pool)
> >> +               skb_mark_for_recycle(head_skb);
> >>          while (--num_buf) {
> >>                  buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
> >>                  if (unlikely(!buf)) {
> >> @@ -2534,7 +2564,7 @@ static struct sk_buff *receive_mergeable(struct =
net_device *dev,
> >>                          goto err_skb;
> >>
> >>                  truesize =3D mergeable_ctx_to_truesize(ctx);
> >> -               curr_skb  =3D virtnet_skb_append_frag(head_skb, curr_s=
kb, page,
> >> +               curr_skb  =3D virtnet_skb_append_frag(rq, head_skb, cu=
rr_skb, page,
> >>                                                      buf, len, truesiz=
e);
> >>                  if (!curr_skb)
> >>                          goto err_skb;
> >> @@ -2544,7 +2574,7 @@ static struct sk_buff *receive_mergeable(struct =
net_device *dev,
> >>          return head_skb;
> >>
> >>   err_skb:
> >> -       put_page(page);
> >> +       virtnet_put_page(rq, page, true);
> >>          mergeable_buf_free(rq, num_buf, dev, stats);
> >>
> >>   err_buf:
> >> @@ -2683,6 +2713,8 @@ static void receive_buf(struct virtnet_info *vi,=
 struct receive_queue *rq,
> >>   static int add_recvbuf_small(struct virtnet_info *vi, struct receive=
_queue *rq,
> >>                               gfp_t gfp)
> >>   {
> >> +       unsigned int offset;
> >> +       struct page *page;
> >>          char *buf;
> >>          unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
> >>          void *ctx =3D (void *)(unsigned long)xdp_headroom;
> >> @@ -2692,6 +2724,24 @@ static int add_recvbuf_small(struct virtnet_inf=
o *vi, struct receive_queue *rq,
> >>          len =3D SKB_DATA_ALIGN(len) +
> >>                SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >>
> >> +       if (rq->page_pool) {
> >
> > I think it would be a burden if we maintain two different data paths.
>
> I will move it to probe in v2.
>
> > And what's more, I see this patch doesn't require DMA mapping for the
> > page pool. This basically defeats the pre mapping logic introduced in
> > 31f3cd4e5756b("virtio-net: rq submits premapped per-buffer"). Lastly,
> > it seems we should make VIRTIO_NET select PAGE_POOL.
>
> I intentionally used flags=3D0 and virtqueue_add_inbuf_ctx() to keep the
> initial patch simple, following the pattern of xen-netfront which also
> used flags=3D0 due to its custom DMA mechanism (grant tables).
>
> My concern was that virtio has its own DMA abstraction
> vdev->map->map_page() (used by VDUSE), and I wasn't sure if page_pool's
> standard dma_map_page() would be compatible with all virtio backends.

You are right, DMA is unware about virtio mappings, so we can't use that.

>
> To preserve the premapping optimization, I see two options:
> 1. Use PP_FLAG_DMA_MAP with virtqueue_dma_dev() as the DMA device. This
> is simpler but uses the standard DMA API, which may not work corerctly
> with VDUSE.
> 2. Integrate page_pool allocation with virtio's existing DMA infra -
> allocate pages from page_pool, but DMA map using
> virtqueue_map_single_attrs(), then use virtqueue_add_inbuf_premapped().
> This preserves the compatibility but requires tracking DMA mapping per
> page.
>
> Which would be better? Or, is there anything simpler that I'm missing?
>

2 would be better.

> Will add PAGE_POOL in kConfig for VIRTIO_NET in v2.
>
> >
> >> +               page =3D page_pool_alloc_frag(rq->page_pool, &offset, =
len, gfp);
> >> +               if (unlikely(!page))
> >> +                       return -ENOMEM;
> >> +
> >> +               buf =3D page_address(page) + offset;
> >> +               buf +=3D VIRTNET_RX_PAD + xdp_headroom;
> >> +
> >> +               sg_init_table(rq->sg, 1);
> >> +               sg_set_buf(&rq->sg[0], buf, vi->hdr_len + GOOD_PACKET_=
LEN);
> >> +
> >> +               err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf=
, ctx, gfp);
> >> +               if (err < 0)
> >> +                       page_pool_put_page(rq->page_pool,
> >> +                                          virt_to_head_page(buf), -1,=
 false);
> >> +               return err;
> >> +       }
> >> +
> >>          if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)=
))
> >>                  return -ENOMEM;
> >>
> >> @@ -2786,6 +2836,8 @@ static int add_recvbuf_mergeable(struct virtnet_=
info *vi,
> >>          unsigned int tailroom =3D headroom ? sizeof(struct skb_shared=
_info) : 0;
> >>          unsigned int room =3D SKB_DATA_ALIGN(headroom + tailroom);
> >>          unsigned int len, hole;
> >> +       unsigned int offset;
> >> +       struct page *page;
> >>          void *ctx;
> >>          char *buf;
> >>          int err;
> >> @@ -2796,6 +2848,39 @@ static int add_recvbuf_mergeable(struct virtnet=
_info *vi,
> >>           */
> >>          len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room)=
;
> >>
> >> +       if (rq->page_pool) {
> >> +               page =3D page_pool_alloc_frag(rq->page_pool, &offset,
> >> +                                           len + room, gfp);
> >> +               if (unlikely(!page))
> >> +                       return -ENOMEM;
> >> +
> >> +               buf =3D page_address(page) + offset;
> >> +               buf +=3D headroom; /* advance address leaving hole at =
front of pkt */
> >> +
> >> +               hole =3D PAGE_SIZE - (offset + len + room);
> >> +               if (hole < len + room) {
> >> +                       /* To avoid internal fragmentation, if there i=
s very likely not
> >> +                        * enough space for another buffer, add the re=
maining space to
> >> +                        * the current buffer.
> >> +                        * XDP core assumes that frame_size of xdp_buf=
f and the length
> >> +                        * of the frag are PAGE_SIZE, so we disable th=
e hole mechanism.
> >> +                        */
> >> +                       if (!headroom)
> >> +                               len +=3D hole;
> >> +               }
> >> +
> >> +               ctx =3D mergeable_len_to_ctx(len + room, headroom);
> >> +
> >> +               sg_init_table(rq->sg, 1);
> >> +               sg_set_buf(&rq->sg[0], buf, len);
> >> +
> >> +               err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf=
, ctx, gfp);
> >> +               if (err < 0)
> >> +                       page_pool_put_page(rq->page_pool,
> >> +                                          virt_to_head_page(buf), -1,=
 false);
> >> +               return err;
> >> +       }
> >> +
> >>          if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gf=
p)))
> >>                  return -ENOMEM;
> >>
> >> @@ -3181,7 +3266,10 @@ static int virtnet_enable_queue_pair(struct vir=
tnet_info *vi, int qp_index)
> >>                  return err;
> >>
> >>          err =3D xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
> >> -                                        MEM_TYPE_PAGE_SHARED, NULL);
> >> +                                        vi->rq[qp_index].page_pool ?
> >> +                                               MEM_TYPE_PAGE_POOL :
> >> +                                               MEM_TYPE_PAGE_SHARED,
> >> +                                        vi->rq[qp_index].page_pool);
> >>          if (err < 0)
> >>                  goto err_xdp_reg_mem_model;
> >>
> >> @@ -3221,11 +3309,77 @@ static void virtnet_update_settings(struct vir=
tnet_info *vi)
> >>                  vi->duplex =3D duplex;
> >>   }
> >>
> >> +static int virtnet_create_page_pools(struct virtnet_info *vi)
> >> +{
> >> +       int i, err;
> >> +
> >> +       for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> >> +               struct receive_queue *rq =3D &vi->rq[i];
> >> +               struct page_pool_params pp_params =3D { 0 };
> >> +
> >> +               if (rq->page_pool)
> >> +                       continue;
> >> +
> >> +               if (rq->xsk_pool)
> >> +                       continue;
> >> +
> >> +               if (!vi->mergeable_rx_bufs && vi->big_packets)
> >> +                       continue;
> >> +
> >> +               pp_params.order =3D 0;
> >> +               pp_params.pool_size =3D virtqueue_get_vring_size(rq->v=
q);
> >> +               pp_params.nid =3D dev_to_node(vi->vdev->dev.parent);
> >> +               pp_params.dev =3D vi->vdev->dev.parent;
> >> +               pp_params.netdev =3D vi->dev;
> >> +               pp_params.napi =3D &rq->napi;
> >> +               pp_params.flags =3D 0;
> >> +
> >> +               rq->page_pool =3D page_pool_create(&pp_params);
> >> +               if (IS_ERR(rq->page_pool)) {
> >> +                       err =3D PTR_ERR(rq->page_pool);
> >> +                       rq->page_pool =3D NULL;
> >> +                       goto err_cleanup;
> >> +               }
> >> +       }
> >> +       return 0;
> >> +
> >> +err_cleanup:
> >> +       while (--i >=3D 0) {
> >> +               struct receive_queue *rq =3D &vi->rq[i];
> >> +
> >> +               if (rq->page_pool) {
> >> +                       page_pool_destroy(rq->page_pool);
> >> +                       rq->page_pool =3D NULL;
> >> +               }
> >> +       }
> >> +       return err;
> >> +}
> >> +
> >> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >> +               struct receive_queue *rq =3D &vi->rq[i];
> >> +
> >> +               if (rq->page_pool) {
> >> +                       page_pool_destroy(rq->page_pool);
> >> +                       rq->page_pool =3D NULL;
> >> +               }
> >> +       }
> >> +}
> >> +
> >>   static int virtnet_open(struct net_device *dev)
> >>   {
> >>          struct virtnet_info *vi =3D netdev_priv(dev);
> >>          int i, err;
> >>
> >> +       err =3D virtnet_create_page_pools(vi);
> >
> > Any reason those page pools were not created during the probe?
>
> No good reason. I will add it in v2.
>

Thanks


