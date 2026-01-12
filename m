Return-Path: <netdev+bounces-248871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCC6D10640
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA5E8300D80A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA23C306480;
	Mon, 12 Jan 2026 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGsjwKtK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gH7TZSqp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5972F3C3F
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186471; cv=none; b=KaSASm1sIDTGr50R3iDq8e1gaT/gPW1cNCirU+T5BDIe8cMZB5YvAfe+1KFxKcMwqxnbbLahBnmrfagMfi4sHGQlP1gPXLbg3Zn2HzRUUbmEBYWTMhSRCWdqdFj4RPOawXOj+HY48nxR22y7lo5RKjKctdzuR4VkJACPiYlSwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186471; c=relaxed/simple;
	bh=zGRMpYKy7NCfokFDjEXNjbo5Ew8CX3dBTGlMCpqTu7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAdodyjSq5f8U30f832BT6am2wVYch743sqw3TmBC5YuLIh1NgJJblltuTmea80DaG0dnkMopXnhy/6yBPS0uhaAXs8FIbM3DnGbKIYgPcjg1lBodCNBuWpmta+3kyAHV/Cn/K1/9CkbpyHyMAzacASF3bjT/HAZKmCBsK0GaG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGsjwKtK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gH7TZSqp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768186469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDyfAYjuPwMDl+ZxFK0vKOD/U0p/YZ18QWUvbiOWh/A=;
	b=MGsjwKtKBawJUjWaNS9NC7eo9r1Y2HGxSgSGpCB6uSaXM8t/JPiAOd7TA5tKgXEbIuP9Oz
	lSDoCfXdqATO9QIfLiK3FoQxFL0tOOrtpUAEjrerMP9ebs6hVCf3zcX+IpBC88gqtFvKGb
	s6ITKpnJJc5KnUc35pIgL+Yen+vcaDI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-LKtw6JsKPlOgkYOg6pJ3iw-1; Sun, 11 Jan 2026 21:54:27 -0500
X-MC-Unique: LKtw6JsKPlOgkYOg6pJ3iw-1
X-Mimecast-MFC-AGG-ID: LKtw6JsKPlOgkYOg6pJ3iw_1768186467
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34aa1d06456so7478436a91.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 18:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768186467; x=1768791267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDyfAYjuPwMDl+ZxFK0vKOD/U0p/YZ18QWUvbiOWh/A=;
        b=gH7TZSqpxdAhEekq8twuVKP2gG6cHZzkqCJaXVDLoSEZSTUMZcu5geKD7YBemmXEKd
         sKPmgvh6QEbnoKyZIgc+Pnj0R91T9FJGOyRtqIyV1zJBHRgrkRzvMy9YyFIlUdWohl3g
         /Z0vHEQNOeTyG9sEG4jDZ7az6p/4Qx8qzJ8dtZOKSgyC6yyQlYLP+RE+D2artEK/5ZQ2
         /7WuvOv4zT1Kq4hfNCrjTZPZWwvBJdTur9CZrfLH99Dtjy7vCjNbHkg/SQ05ZWTeKAUE
         TwhJML+rc3yk6yT53dzD+iYA9D7WcIKSd87ctYBgUqqi2qv0w+LunCFnoTmqZB/3XIPu
         P+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768186467; x=1768791267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDyfAYjuPwMDl+ZxFK0vKOD/U0p/YZ18QWUvbiOWh/A=;
        b=if64LF4SiltW+ZuP5oVWRi9lYThP8tw71ls0VCKcHI+P6Th1xwmFKPQxXVNfr7Eau0
         ms8vlt6audIJkGrlknneShSVqUMQOYh2AE5xnvPdecX4hFjDwSmNraiNZI4w/ZRHg9uM
         HUBBPSo9JQr/gPnbDNzTaos7n2wteMS9kYlylDtH03lDdnNta61lzhz+M4luZhdCjZYH
         qPa3HDwHniiAUYXZBB+12GslSyXCOiUwQ8jiN2CovCqYEGehNBY+/QYoZrFhP5pCnRTB
         Ndj3qo3zC81VNI/BhUT/tfhE8Q/YQuYNJ36C/xL9DMSWOwGnr2QczfpzmWXqNU3qWMhk
         AliA==
X-Forwarded-Encrypted: i=1; AJvYcCXlWUs/R0KHW2Rxiy3NeDReTClqMrYyVATIhQA5LLOWqQOC/MPN0g90wiKk2kyasW2QZjdXhjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKSzowW1aWvrXePakjtzNj2k/BwgsTONGs7CLyhnLqL4L7jdby
	iE12s4S9glIwprt60ufQ5Wc3Dk3tMR4S6zskLAhU7ST0Oclj/pADDsZKE0LXgluAghiiP+dOMVg
	nxhcpUEmHc7Drt6gLQhd7xwTm7/WOONS6JWF4X7AF4FbTWlZkE+g8zxDNpvfQnRlLISNNhp4ao3
	SzH7nWS2WOXgWuIRA2d3dk94EAS7eM0X6k
X-Gm-Gg: AY/fxX4xpKlCPu/Y3oC/V1R3vBaj88r7ODslOkIAdluDBtFH7O1YSHgIzvXRz2aZEpR
	c4YX2/njy8mF1a4GN14DOm5ep7KtUON7/o0U5ACF36QfDm7si37zJY/hv5Tzru0jGhIz2/ZKh5c
	6X45W3zneUYRINgI6SFtFmXGVVtYa5V9xHJ3As2k/xHEsjMmJZNFKrE+uehpu2xCgdnyE=
X-Received: by 2002:a17:90b:578f:b0:34f:6312:f22c with SMTP id 98e67ed59e1d1-34f68aed27bmr14111542a91.0.1768186466685;
        Sun, 11 Jan 2026 18:54:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGXzUyZmp1tWX++x0G65O3OR3ED7oEjlI25F4JANfILTteUWkwPCmSotiUwilA3S2tZsCRJQcG1meJ8mKehq8=
X-Received: by 2002:a17:90b:578f:b0:34f:6312:f22c with SMTP id
 98e67ed59e1d1-34f68aed27bmr14111529a91.0.1768186466287; Sun, 11 Jan 2026
 18:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-8-simon.schippers@tu-dortmund.de> <CACGkMEtndGm+GX+3Kn5AWTkEc+PK0Fo1=VSZzhgBQoYRQbicQw@mail.gmail.com>
 <5961e982-9c52-4e7a-b1ca-caaf4c4d0291@tu-dortmund.de> <CACGkMEsKFcsumyNU6vVgBE4LjYWNb2XQNaThwd9H5eZ+RjSwfQ@mail.gmail.com>
 <0ae9071b-6d76-4336-8aee-d0338eecc6f5@tu-dortmund.de>
In-Reply-To: <0ae9071b-6d76-4336-8aee-d0338eecc6f5@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Jan 2026 10:54:15 +0800
X-Gm-Features: AZwV_QiDbqKshtfzYu2XaNQcD4zIgEOkEtzvAYmkzLCTpPxpz5hLy6ho4yA73K0
Message-ID: <CACGkMEsC0-d4oS54BHNdFVKS+74P7SdnNHPHe_d0pmo-_86ipg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 7/9] vhost-net: vhost-net: replace rx_ring
 with tun/tap ring wrappers
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:57=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/9/26 07:04, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 3:48=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/8/26 05:38, Jason Wang wrote:
> >>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> Replace the direct use of ptr_ring in the vhost-net virtqueue with
> >>>> tun/tap ring wrapper helpers. Instead of storing an rx_ring pointer,
> >>>> the virtqueue now stores the interface type (IF_TUN, IF_TAP, or IF_N=
ONE)
> >>>> and dispatches to the corresponding tun/tap helpers for ring
> >>>> produce, consume, and unconsume operations.
> >>>>
> >>>> Routing ring operations through the tun/tap helpers enables netdev
> >>>> queue wakeups, which are required for upcoming netdev queue flow
> >>>> control support shared by tun/tap and vhost-net.
> >>>>
> >>>> No functional change is intended beyond switching to the wrapper
> >>>> helpers.
> >>>>
> >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Co-developed by: Jon Kohler <jon@nutanix.com>
> >>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>> ---
> >>>>  drivers/vhost/net.c | 92 +++++++++++++++++++++++++++++-------------=
---
> >>>>  1 file changed, 60 insertions(+), 32 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>>> index 7f886d3dba7d..215556f7cd40 100644
> >>>> --- a/drivers/vhost/net.c
> >>>> +++ b/drivers/vhost/net.c
> >>>> @@ -90,6 +90,12 @@ enum {
> >>>>         VHOST_NET_VQ_MAX =3D 2,
> >>>>  };
> >>>>
> >>>> +enum if_type {
> >>>> +       IF_NONE =3D 0,
> >>>> +       IF_TUN =3D 1,
> >>>> +       IF_TAP =3D 2,
> >>>> +};
> >>>
> >>> This looks not elegant, can we simply export objects we want to use t=
o
> >>> vhost like get_tap_socket()?
> >>
> >> No, we cannot do that. We would need access to both the ptr_ring and t=
he
> >> net_device. However, the net_device is protected by an RCU lock.
> >>
> >> That is why {tun,tap}_ring_consume_batched() are used:
> >> they take the appropriate locks and handle waking the queue.
> >
> > How about introducing a callback in the ptr_ring itself, so vhost_net
> > only need to know about the ptr_ring?
>
> That would be great, but I'm not sure whether this should be the
> responsibility of the ptr_ring.
>
> If the ptr_ring were to keep track of the netdev queue, it could handle
> all the management itself - stopping the queue when full and waking it
> again once space becomes available.
>
> What would be your idea for implementing this?

During ptr_ring_init() register a callback, the callback will be
trigger during ptr_ring_consume() or ptr_ring_consume_batched() when
ptr_ring find there's a space for ptr_ring_produce().

Thanks

>
> >
> > Thanks
> >
> >>
> >>>
> >>> Thanks
> >>>
> >>
> >
>


