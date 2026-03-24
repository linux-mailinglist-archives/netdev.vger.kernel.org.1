Return-Path: <netdev+bounces-270825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CgbKuDcwWnxXQQAu9opvQ
	(envelope-from <netdev+bounces-270825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:37:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2235E2FFC38
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89D523024440
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4A33B6F9;
	Tue, 24 Mar 2026 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjTf+Ms9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrNSQsUj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8F1A681A
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312487; cv=pass; b=OzhpZ45uHDDJEeJEpPtAtEqa7+XapInOW2B6TaC2C/uDJsXdwo/l6O9ZYf4OH4qy39msFXJKknzSelAyXe2oZLX8VAjwaW1j4kMb5Zvdru6JttkpvkHLicPaoavyMbi5AutSfht3dQ1nBhsAtqEwzn8At3/nNwcQpLImYm93Zj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312487; c=relaxed/simple;
	bh=NmX6aq1AjJs12Yq+PWPzbIZnkkSYYGFdr1l5n18R484=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnLXVSNClH3arHpGxxyVSv6QesMhlVt/wNOTU4iThps7CExIdEcZC/7ks0rs5NJnbSP4aPG9ZMWArPD+MTXqHsWHZisQYL1rcNadK2ekTtWHgqHT5Q7GyJF9ftRfD1wCG1VDLCSOcWrlpCWbc7EWlgQvBUy8D8clO7dwMZKOxQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjTf+Ms9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrNSQsUj; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774312484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saGQT6VbC9RUqD0YOp9yO8+1VRHnufK9WLW/Cpl18Rg=;
	b=cjTf+Ms9DNQVzc8WNXlhJ5bNIGklxwJIQE4odXiXNHt6v7Cfq7hgIii2juWOpoQjWY0woY
	4qEPkRA7oVdahUaXPeiAUh8nCxxIZ0VhdVNErqRhfrpMdryTFSaObGVGsBb9AO0uLFtws0
	WHSo8H8zExNm/7KCmOU8dK4wBaoPTgQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-p4UYPE3MOeuZScvCEud0UA-1; Mon, 23 Mar 2026 20:34:42 -0400
X-MC-Unique: p4UYPE3MOeuZScvCEud0UA-1
X-Mimecast-MFC-AGG-ID: p4UYPE3MOeuZScvCEud0UA_1774312481
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b061868724so5497805ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774312481; cv=none;
        d=google.com; s=arc-20240605;
        b=DQrcGRxa2Ok+o3gddNNVjQ5BOS5r3YK+C/g1L0pPDeQDii045DOyMKqR3Ul8rEo677
         EXOLkIBAJekftURvhDlruClLdr/O2h/VBvrzvxf9opsePaFvvXD5JZHkuM0/cYgTs6vm
         7cNXRgDAnBlNz7iUlyzp4wS3BrJ6JjEdzLDLz/u4BNlpcp2Ydk1ag36rZGfR8TdtTTLw
         SlkO+Kzv4TkKR+UylxKwNccJF9HLCqNswoOIUXZzCnoBZHi/a286WJZv9Z/OvNKwGHcN
         4LFreylRv/Fwg01DcqxDDbDIb5En225WwSsKfBTJp7oVdQn7MULzOAWHCX1w5XH48q3A
         o+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=saGQT6VbC9RUqD0YOp9yO8+1VRHnufK9WLW/Cpl18Rg=;
        fh=pDgX31h2hBwcnse4RFCaMlHNThCiuWYRF/DzhJO2aCQ=;
        b=E4LuQb8Y+g9uZC24hKwx7jKxsSr9AW/O0qOFF1pBAWGWStsMz0xyRfbouJM/qVpORo
         tOEIbuwNal3x9oxBs1k2CJ4IWW60OfasWok/J+aFhm/HCcaw80TlkSVc+zyh3y9FkeEc
         WlCC3smuxp5oKjZdpfiJYveRPmrHV7Eh1kfupym1GGz2V4d1BwAwuI5//rRtFg4O2Q4A
         iYCPGdVva0MwP2azIMM/VXUwpaKa32MtzsuhHX+6yX8prA4OFRr8GWl7dj85a6XBYRoW
         w5KbEFbA9gU0Og+ncj3tq5cCXaKHFpzXXuEcEcYLyZ/9j0P0WklZC5QP3qbnM5dNOs0O
         VEwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774312481; x=1774917281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saGQT6VbC9RUqD0YOp9yO8+1VRHnufK9WLW/Cpl18Rg=;
        b=DrNSQsUjIgj127OfK5LhRPhFAr2xw7XFfmRt+y3+TTbb6bRpWhYd08bFSxbUeeWNv6
         mzaxuJw4s0NKBvX5UV6DRXxnpglrCpOKq4oSyKB+RFHh6B4iU8FPAPnkny1muZpN0jbt
         1VGSJmz/s6xJGYUGCOeyuqTgVH2LtrM762UJCx26g3OQyQu2thTxrHXAUon07p+AvnWA
         BJAbykCFhzhWlGyTnisvIg2JYVxXe0dkZQo4w1LIo0Q63BTYJMMZM8HXwt6ypCyf+77P
         bV7gL2BQ6v1jXtzxns8IPsZJe+K6AuGoK5bFk0a+KNUrCAzgoti3dxCHn67UZCN7RJhy
         GMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312481; x=1774917281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=saGQT6VbC9RUqD0YOp9yO8+1VRHnufK9WLW/Cpl18Rg=;
        b=NRiPOd/WRfITQi+CHwWhxAjz/rMqzRPekPJXZVeMeoclCV/Gr2NAIuE3FF5NBo77+b
         LgfcwKMBuXUgWHZMXN34HPNbNb1DU8NjFqC5dMLCqgTxNPL+2eUug3jXFw3EwYe4/adc
         lNXIK55IjQ2M3iCxfxQL7SHy6d3xRUWT37Krkak+LQtVD4otjUz+0dBG3oANdLtbAqMY
         nsACroD0iHvPGCFWsBhOfl5YbjsSQPz4/JKYu7luVMm7hdjX07+a369mCGOzBLmZYXiz
         UyfpPPla+Bea4PxytyFUIy4N6T8Z9zB4kTJuKH9NFU2YrnRNbhGWXuGUyOcw8Eo/wZp/
         BF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCl/ySc10xASWmKQsAAcBN704kPzI88GJ9mANOT4ZWwY9pk1zcEwg8juspGcWAQxDloX9Yqyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwehTjVatmyFJfkwPo7RXn1geS8CTxn+kQHW/7A4eqUZRorxjYY
	I7OonFMQrr0P9YkkuhoplR3oD0JYUWDAYMYBS6waaRXeI0lSzTg+okjhQ662IBQueG3cetet/Py
	Zf9Yt0daUOyz5mWPaxeciWY9Yfao9TGleKtN4uRtv/cwe4Y2rEpXS8p0WQjpIiXWF+rLZvhLJMp
	3QrINS0gQvVNaOKTlPHnIvUrF10J2cRWA7
X-Gm-Gg: ATEYQzySoWVToI7otWAQ+mpPawEp9vOfYjJjs/XH2yELPKWY4tzIbAyIRCV30qL9Qbf
	ot+/euiepbG/RDjJlJ9znqQ3pmpqqmfHpG7S995SU2fswlDnIsFRhqPPG0RsH4oIwH+WPAZUEK/
	hAcwaZYlXGYGor6B+ObFerXj5e4kySNNOH+KZi4EacVRoTA16j1xcH7dE++oy6ULCOR1iRUSqEs
	HAE
X-Received: by 2002:a17:902:d4c5:b0:2ad:dfb8:8ed3 with SMTP id d9443c01a7336-2b0826d7570mr125521055ad.8.1774312481449;
        Mon, 23 Mar 2026 17:34:41 -0700 (PDT)
X-Received: by 2002:a17:902:d4c5:b0:2ad:dfb8:8ed3 with SMTP id
 d9443c01a7336-2b0826d7570mr125520745ad.8.1774312481005; Mon, 23 Mar 2026
 17:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310183107.2822016-1-vishs@meta.com> <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org> <20260323122728-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260323122728-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Mar 2026 08:34:29 +0800
X-Gm-Features: AaiRm52xN2lo_tVFI0DDvUo4ivVlfAirVP3edMWUgEftkLvUyxZ5RHdMesVost0
Message-ID: <CACGkMEtUcdwhDYSZPfzc4noSFjgvS7exS0rYcCSscoMiMPvrHA@mail.gmail.com>
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer allocation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Omar Elghoul <oelghoul@linux.ibm.com>, vishs@meta.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, dw@davidwei.uk, edumazet@google.com, eperezma@redhat.com, 
	ilias.apalodimas@linaro.org, kernel-team@meta.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	technoboy85@gmail.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270825-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,meta.com,lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2235E2FFC38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 12:58=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Mar 23, 2026 at 11:52:34AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> > > Hi,
> > >
> > > I've been testing linux-next (tags later than 03/17) and hit new issu=
es in
> > > virtio-net on s390x. I bisected the issue, and I found this patch to =
be the
> > > first buggy commit.
> > >
> > > The issue seems to only be reproducible when running in Secure Execut=
ion.
> > > Tested in a KVM guest, the virtio-net performance appears greatly red=
uced,
> > > and the dmesg output shows many instances of the following error mess=
ages.
> > >
> > > Partial relevant logs
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [   49.332028] macvtap0: bad gso: type: 0, size: 0, flags 1 tunnel 0 =
tnl csum 0
> > > [   74.365668] macvtap0: bad gso: type: 2e, size: 27948, flags 0 tunn=
el 0 tnl csum 0
> > > [  403.302168] macvtap0: bad csum: flags: 2, gso_type: 23 rx_tnl_csum=
 0
> > > [  403.302271] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum=
 0
> > > [  403.302279] macvtap0: bad csum: flags: 2, gso_type: e1 rx_tnl_csum=
 0
> > > [  403.309492] macvtap0: bad csum: flags: 2, gso_type: 4c rx_tnl_csum=
 0
> > > [  403.317029] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum=
 0
> > >
> > > Steps to reproduce
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > 1. Boot a Linux guest implementing this patch under QEMU/KVM (*) with=
 SE
> > >    enabled and a virtio-net-ccw device attached.
> > > 2. Run dmesg. The error message is usually already present at boot ti=
me,
> > >    but if not, it can be reproduced by creating any network traffic.
> > >
> > > (*) This patch was not tested in a non-KVM hypervisor environment.
> > >
> > > I've further confirmed that reverting this patch onto its parent comm=
it
> > > resolves the issue. Please let me know if you'd like me to test a fix=
 or if
> > > you would need more information.
> > >
> > > Thanks in advance.
> > >
> > > Best,
> > > Omar
> >
> > Well... I am not sure how I missed it. Obvious in hindsight:
> >
> > static void receive_buf(struct virtnet_info *vi, struct receive_queue *=
rq,
> >                         void *buf, unsigned int len, void **ctx,
> >                         unsigned int *xdp_xmit,
> >                         struct virtnet_rq_stats *stats)
> > {
> >         struct net_device *dev =3D vi->dev;
> >         struct sk_buff *skb;
> >         u8 flags;
> >
> >         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >                 pr_debug("%s: short packet %i\n", dev->name, len);
> >                 DEV_STATS_INC(dev, rx_length_errors);
> >                 virtnet_rq_free_buf(vi, rq, buf);
> >                 return;
> >         }
> >
> >         /* About the flags below:
> >          * 1. Save the flags early, as the XDP program might overwrite =
them.
> >          * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_V=
ALID
> >          * stay valid after XDP processing.
> >          * 2. XDP doesn't work with partially checksummed packets (refe=
r to
> >          * virtnet_xdp_set()), so packets marked as
> >          * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processin=
g.
> >          */
> >
> >         if (vi->mergeable_rx_bufs) {
> >                 flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.fl=
ags;
> >                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, x=
dp_xmit,
> >                                         stats);
> >         } else if (vi->big_packets) {
> >                 void *p =3D page_address((struct page *)buf);
> >
> >                 flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flag=
s;
> >                 skb =3D receive_big(dev, vi, rq, buf, len, stats);
> >         } else {
> >                 flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.fl=
ags;
> >                 skb =3D receive_small(dev, vi, rq, buf, ctx, len, xdp_x=
mit, stats);
> >         }
> >
> >
> > So we are reading the header, before dma sync, which is within
> > receive_mergeable and friends:
> >
> > static struct sk_buff *receive_mergeable(struct net_device *dev,
> >                                          struct virtnet_info *vi,
> >                                          struct receive_queue *rq,
> >                                          void *buf,
> >                                          void *ctx,
> >                                          unsigned int len,
> >                                          unsigned int *xdp_xmit,
> >                                          struct virtnet_rq_stats *stats=
)
> > {
> >         struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf;
> >         int num_buf =3D virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> >         struct page *page =3D virt_to_head_page(buf);
> >         int offset =3D buf - page_address(page);
> >         struct sk_buff *head_skb, *curr_skb;
> >         unsigned int truesize =3D mergeable_ctx_to_truesize(ctx);
> >         unsigned int headroom =3D mergeable_ctx_to_headroom(ctx);
> >
> >         head_skb =3D NULL;
> >
> >         if (rq->use_page_pool_dma)
> >                 page_pool_dma_sync_for_cpu(rq->page_pool, page, offset,=
 len);
> >
> >
> >
> > Just as a test, the below should fix it (compiled only), but the real
> > fix is more complex since we need to be careful to avoid expensive sync=
ing
> > twice.
> >
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 97035b49bae7..57b4f5954bed 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_=
info *vi,
> >
> >  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, vo=
id **ctx)
> >  {
> > +     void *buf;
> > +
> >       BUG_ON(!rq->page_pool);
> >
> > -     return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > +     buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > +     if (buf && rq->use_page_pool_dma && *len) {
> > +             struct page *page =3D virt_to_head_page(buf);
> > +             int offset =3D buf - page_address(page);
> > +
> > +             page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *=
len);
> > +     }
> > +
> > +     return buf;
> >  }
> >
> >  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> >
> >
> >
> >
> > --
> > MST
>
> or maybe like this:
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 97035b49bae7..835f52651006 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_de=
vice *dev,
>          */
>         buf -=3D VIRTNET_RX_PAD + xdp_headroom;
>
> -       if (rq->use_page_pool_dma) {
> -               int offset =3D buf - page_address(page) +
> -                            VIRTNET_RX_PAD + xdp_headroom;
> -
> -               page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, l=
en);
> -       }
> -
>         len -=3D vi->hdr_len;
>         u64_stats_add(&stats->bytes, len);
>
> @@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>
>         head_skb =3D NULL;
>
> -       if (rq->use_page_pool_dma)
> -               page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, l=
en);
> -
>         u64_stats_add(&stats->bytes, len - vi->hdr_len);
>
>         if (check_mergeable_len(dev, ctx, len))
> @@ -2563,6 +2553,13 @@ static void receive_buf(struct virtnet_info *vi, s=
truct receive_queue *rq,
>                 return;
>         }
>
> +       if (rq->use_page_pool_dma) {
> +               struct page *page =3D virt_to_head_page(buf);
> +               int offset =3D buf - page_address(page);
> +
> +               page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, l=
en);
> +       }
> +
>         /* About the flags below:
>          * 1. Save the flags early, as the XDP program might overwrite th=
em.
>          * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VAL=
ID
>

This looks better.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


