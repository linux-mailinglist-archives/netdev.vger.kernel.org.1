Return-Path: <netdev+bounces-143651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BD99C37B2
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 06:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238371C20A38
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAF81798F;
	Mon, 11 Nov 2024 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbPlCn+0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82A2914;
	Mon, 11 Nov 2024 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731301276; cv=none; b=hS6BzMIlicw3jvw16EE1HY50P0f8yzSqW4fLMRsmxJlH92tnU5Vw3e5yoCo3t4Czi4tWa080hpxeDKAJv8YEX7JKfr+YI0JdZH547a6zNBqYfZnR7eSeZEFjvb9yEpRkmjepYrHxqAcH/ulK3TkVbXwbBSfgMJZhJll6xE8Vxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731301276; c=relaxed/simple;
	bh=3arkq7638H4IilkfZbAgU0tgdqMrXuANsnaupj7e7Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqjx2MrhsQ7ipBiQFJpVDwDOZ4O3EVocRTwo6vgHjE1v4OlVXvzrmo5B8VD53TCZWq8uLvBJTiLrrwYwCGcQllh0w4jlkJdgC8cmVywuk7eGgePHvE5+7Tdpk6DLRxOrUKx/rz/whZdww50GgjsV4wFCefRRv+NkFH5Z1nK9Xw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbPlCn+0; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so3812940276.3;
        Sun, 10 Nov 2024 21:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731301274; x=1731906074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ni3sjd0GgQM8D+VN0XBKPh7z2yCdmovy8zUPvmic4m8=;
        b=LbPlCn+0WdOu/FZ4p3Kd1f+sqlU63DMzu+892+AdnHqbSSX6mOf0kImgQarfGhs8tU
         aHVdKmxAPiFQCooNSxuSOwXm+bmNs28+7Ap+6yFgTfi9geZtUZa2FbKr+3K3ytKXukYp
         J68S1Bq0RuGqju5XFG13JGpmYVs70OSFBBBHAaXOuvokurn3xRKfaQgn7LqeUp6XPwSh
         k+waYINnlrJNzgUSRE/4ILOkI/f6XlkMiPnn8t8gPv3JVdhyZ7qiaXa45AgyZFTqPPW2
         GvP+a31YlLubF89uqz6HUIn5+jWDxFGzm09cjgoukSiP1gBlpYeHv9DfOO2/h21cDhUE
         tdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731301274; x=1731906074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ni3sjd0GgQM8D+VN0XBKPh7z2yCdmovy8zUPvmic4m8=;
        b=m2RJWP2UhAhPsBprkEee/f/9FwmSyoouH9G1jmG0SB3qfuHFqY8EedEUXAsJkDlb68
         QE6i4IyC3njNl2uM06bGB36bTRYAVX/xQi+kSG59ZpP8JLl2Ekw21ZGl/Hrp4a35qGte
         KAnPv2Ilg7SP8e2Ckc+ZcC8SMnYRNyb0RI7FwMaOjB80EgTThfM74T5gvWETp5Y+a/Gw
         5Auhlb4oWbniWSjZA1/0sVEhAIKOHG92ltyI8t8d6XWnU4L8EZS3DQSbS6bKrfs6a0Z2
         8clP8qtyV3u7Pf9JtS1FN/uUQGxS1ZZgGBbG56zfDyTWZFeVZzqZidt/ZTsvmAp52M+G
         0ZFw==
X-Forwarded-Encrypted: i=1; AJvYcCUglHTFQJuX4ZQpTHFJtUOkQDhHTZ0Ush+XwVi0r3H6gBJQYYb2iQf7tnYD01GqVc+bhWTkmRYy@vger.kernel.org, AJvYcCVnpq9zpYFZBWttp7m3L9B4oFGUM1ocYFNSSSrGJq8zsN1t6Uk0BWxbad5iKuvvvXdJYdIsos7UPFSBpdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZuQrjeDrsYTbqMjWxJbTVJqozyYLXeABlogFn6pNhaJN5PWo
	c65srHo79XzzP0gs+lbbXvDz+zg9dF1yKxyLITBwWbaOGW7vyevIi7nhq1NoK43h4IxAwM7DmfI
	UMEUb/sWVEiyWQMdl1AnumyXnjWs=
X-Google-Smtp-Source: AGHT+IEwiay3LBEyByNNn7h3wXUmrQsX+pXLH1gKjxZvNaazQjnFDwpcQo3j9OOJONApGI7H7MReJQdpiGxxImWXYRQ=
X-Received: by 2002:a05:690c:9b08:b0:6e2:aa89:9d0 with SMTP id
 00721157ae682-6eaddda0524mr101891467b3.10.1731301274114; Sun, 10 Nov 2024
 21:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-2-bbhushan2@marvell.com> <20241110142303.GA50588@unreal>
In-Reply-To: <20241110142303.GA50588@unreal>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Mon, 11 Nov 2024 10:31:02 +0530
Message-ID: <CAAeCc_nPP7FU7KUZoW+9AVPdaqTpVopEKQGVpzHgXkBUzfa1xQ@mail.gmail.com>
Subject: Re: [net-next PATCH v9 1/8] octeontx2-pf: map skb data as device writeable
To: Leon Romanovsky <leon@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, ndabilpuram@marvell.com, sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 7:53=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Fri, Nov 08, 2024 at 10:27:01AM +0530, Bharat Bhushan wrote:
> > Crypto hardware need write permission for in-place encrypt
> > or decrypt operation on skb-data to support IPsec crypto
> > offload. That patch uses skb_unshare to make skb data writeable
> > for ipsec crypto offload and map skb fragment memory as
> > device read-write.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> > v7->v8:
> >  - spell correction (s/sdk/skb) in description
> >
> > v6->v7:
> >  - skb data was mapped as device writeable but it was not ensured
> >    that skb is writeable. This version calls skb_unshare() to make
> >    skb data writeable.
> >
> >  .../ethernet/marvell/octeontx2/nic/otx2_txrx.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > index 7aaf32e9aa95..49b6b091ba41 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/bpf.h>
> >  #include <linux/bpf_trace.h>
> >  #include <net/ip6_checksum.h>
> > +#include <net/xfrm.h>
> >
> >  #include "otx2_reg.h"
> >  #include "otx2_common.h"
> > @@ -83,10 +84,17 @@ static unsigned int frag_num(unsigned int i)
> >  static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
> >                                       struct sk_buff *skb, int seg, int=
 *len)
> >  {
> > +     enum dma_data_direction dir =3D DMA_TO_DEVICE;
> >       const skb_frag_t *frag;
> >       struct page *page;
> >       int offset;
> >
> > +     /* Crypto hardware need write permission for ipsec crypto offload=
 */
> > +     if (unlikely(xfrm_offload(skb))) {
> > +             dir =3D DMA_BIDIRECTIONAL;
> > +             skb =3D skb_unshare(skb, GFP_ATOMIC);
> > +     }
> > +
> >       /* First segment is always skb->data */
> >       if (!seg) {
> >               page =3D virt_to_page(skb->data);
> > @@ -98,16 +106,22 @@ static dma_addr_t otx2_dma_map_skb_frag(struct otx=
2_nic *pfvf,
> >               offset =3D skb_frag_off(frag);
> >               *len =3D skb_frag_size(frag);
> >       }
> > -     return otx2_dma_map_page(pfvf, page, offset, *len, DMA_TO_DEVICE)=
;
> > +     return otx2_dma_map_page(pfvf, page, offset, *len, dir);
>
> Did I read correctly and you perform DMA mapping on every SKB in data pat=
h?
> How bad does it perform if you enable IOMMU?

Yes Leon, currently DMA mapping is done with each SKB, That's true
even with non-ipsec cases.
Performance is not good with IOMMU enabled. Given the context of this
series, it just extends the same for ipsec use cases.

Thanks
-Bharat

>
> Thanks
>
> >  }
> >
> >  static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_=
list *sg)
> >  {
> > +     enum dma_data_direction dir =3D DMA_TO_DEVICE;
> > +     struct sk_buff *skb =3D NULL;
> >       int seg;
> >
> > +     skb =3D (struct sk_buff *)sg->skb;
> > +     if (unlikely(xfrm_offload(skb)))
> > +             dir =3D DMA_BIDIRECTIONAL;
> > +
> >       for (seg =3D 0; seg < sg->num_segs; seg++) {
> >               otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
> > -                                 sg->size[seg], DMA_TO_DEVICE);
> > +                                 sg->size[seg], dir);
> >       }
> >       sg->num_segs =3D 0;
> >  }
> > --
> > 2.34.1
> >
> >
>

