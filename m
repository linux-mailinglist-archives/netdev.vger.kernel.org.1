Return-Path: <netdev+bounces-237110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C863CC453C9
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732FC188360D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193FE2EBBA1;
	Mon, 10 Nov 2025 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D94ANrbM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rRIOkpgq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F801FF1C4
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760408; cv=none; b=Ee98xdAtcyHY7/k5CC4ZQmjol1OXWf6x/isxfWq/D2pahuzsKHWyEBoQaqK/CgOKgGrYusRrOsqiGGLqzhSLASZJbZ9No8B+9I4jGCBEYsccp6kLwphbuPBVzC53CmHwMmc9JaOns0ZPG53r9B+uLwqrk8oXwFpaIgJ4Vq/I4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760408; c=relaxed/simple;
	bh=nXUsL3pd42Tuep6RruSB+1iDVpue0OZhhCe98VFS0mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwdfFYtsVBHGtuXtBjOQFjssVsaHcdZaM/GtNvxG89VlbQBD6vUpzkJnS6KiZ/DDeZTPHm9DL7zP5YSm2BjnvpuanpfbbBPOS6twRztAxKSrm73Y+hZuGnpDLQPvAtA31hzDR1lGgX3nodNQBazuI1ytlxunBMcq1C5ForFzVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D94ANrbM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rRIOkpgq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762760405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXUsL3pd42Tuep6RruSB+1iDVpue0OZhhCe98VFS0mU=;
	b=D94ANrbMijoCKIAJFLG/nK7LgMg4nAw1gNdAREu78Za1tc6KseXlv2KHEY7EbBbBM4NGF7
	b8tWOZQhZXgzIEYiUsWvMb1OO13LmHgFglYjYK69YcRa/RmzVa3Wsk7paJVwUuWV8A4qsq
	dZWeMq6EdwJjPChmNIaonfyY6AhXxgw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-sAh7pEw2NEykl8tokM5ItQ-1; Mon, 10 Nov 2025 02:40:03 -0500
X-MC-Unique: sAh7pEw2NEykl8tokM5ItQ-1
X-Mimecast-MFC-AGG-ID: sAh7pEw2NEykl8tokM5ItQ_1762760402
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33da21394adso2930455a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 23:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762760402; x=1763365202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXUsL3pd42Tuep6RruSB+1iDVpue0OZhhCe98VFS0mU=;
        b=rRIOkpgqVLe7GGg84wUnGbC9qZFm5EiOsR5ZSd4Ioihf9fKnfxaSuV2sPUObpXHbw/
         ZNm5AhHLSSGA2sn3QHcGv/PqpWVxGcdbEYNNO/oCwLBo6v5/ej4v58Sa1T4J5k/6pZqp
         jtkhUR0Ou7o+Pgzpiru8VooYqXPct15hGCd6sGKRyHiIq7kcHY0KG603RAa0JmrswL70
         sJYlnRE4G+DfnDU0cc8FT28kkgg81oiPVKUcJ/ckOHbq1sOshZsr7L9oZ4OeiDiQgk83
         U9OJeTD2xHCCjuG2u+dMAKrWsiEWG1wlaGSQeWjsbkcKg/taDz39hh8GNh5epm1YukDS
         ZRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762760402; x=1763365202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXUsL3pd42Tuep6RruSB+1iDVpue0OZhhCe98VFS0mU=;
        b=ColBKKi2M5mFGkE59vU2cBqWCimOTMhIhrxG2H7tKw1j/0IxUxyGytV471FP+AwEHU
         lloReHDGBKjGfWvlLsu6NoEg4bTN55P4asw2NjrsaE4Bylxt/6u4tR5AUPLvAnTfl3w7
         m9791twXjYZpiVd4drRXVZwfI8vpm4gAesd6ZyT5/Ub87KzkKuHZAC7fgK5sJmiqVNhT
         9i44lCP5cnn7jGfKbyHicuxMXYJJsuuAwgCCn+CSlbN9MnYJo8UbysG+8jlGAqBVKmhU
         WblFxdNJY3HB3trVGBAp6Y+WwHAARm0GtC1WLn6AA4MuI1zt8kJafhx8bUK4XlqNrA2X
         DAbw==
X-Forwarded-Encrypted: i=1; AJvYcCXitTDLpn9Hw2VVH+PJMyGQf45A2IV58xjz8ZgMLz00yfOgxWcRTwOzmuGqQTZrE0JbIiKy4zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAa7pzfoWj5Q/q4hkom7HOb2haZGuk8fNC9JhqlJQtiaWKdyd
	Rky//FTy/u32LEOupVq5tu+j+ricePpHxrqO2dIY890SFo1jU+tNyRPBrs6ptM7UcMguIAOZePK
	Y8/uJb+ibu8w+8afHKu+4b7ehLA/KoNKGdO2/0LdSZJUknp76BxN94wyyixSiKZ1XoXOtd121B0
	AOz5mkh+sokkemw2EmgqTova3fqkeOceUY
X-Gm-Gg: ASbGnctmNhZBet2yQkAcPO2xR1vDw7A24Ldb+nUqzTBa0OGe2z0m52QxAMYapT/On0W
	je7Lf8WI4X2VGnHaI4LZChHoD/goC37F3TWtlf0YzMnkBxPtHbwbyyuv/an5KwQkAq0vDh6NVpS
	rmI/cMHeVlA/YC4YJAzfbtrP9NtUTT2CRFYtpzX+d+QWAuwhOCKrAv
X-Received: by 2002:a17:90b:3b84:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-3436cd0f021mr8151414a91.33.1762760402379;
        Sun, 09 Nov 2025 23:40:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpZv4/GqlxGQNFyCLng8oTk+dP+M0w4ibTMZFdafThizDamPVmq0k7Ru5Fk/gcw2HySNAQRTdsddDt/AZwDuM=
X-Received: by 2002:a17:90b:3b84:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-3436cd0f021mr8151372a91.33.1762760401914; Sun, 09 Nov 2025
 23:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com> <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org> <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
 <20251110022550-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251110022550-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Nov 2025 15:39:50 +0800
X-Gm-Features: AWmQ_blnEJl7cPeCvJMqReQfNUsbW7dyqVeRIgseANe1h5mGpbCdQEhT5aHtNXY
Message-ID: <CACGkMEt+czNGi_KFgnHkZteNVNmBc7ND_xh7R=uNDo-ZumFEfA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 10, 2025 at 03:16:08PM +0800, Jason Wang wrote:
> > On Mon, Nov 10, 2025 at 5:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > > > On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > The commit be50da3e9d4a ("net: virtio_net: implement exact header=
 length
> > > > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDR=
LEN
> > > > > feature in virtio-net.
> > > > >
> > > > > This feature requires virtio-net to set hdr_len to the actual hea=
der
> > > > > length of the packet when transmitting, the number of
> > > > > bytes from the start of the packet to the beginning of the
> > > > > transport-layer payload.
> > > > >
> > > > > However, in practice, hdr_len was being set using skb_headlen(skb=
),
> > > > > which is clearly incorrect. This commit fixes that issue.
> > > >
> > > > I still think it would be more safe to check the feature
> > >
> > > which feature VIRTIO_NET_F_GUEST_HDRLEN ?
> > >
> >
> > Yes.
> >
> > Thanks
>
> Seems more conservative for sure, though an extra mode to maintain isn't
> great. Hmm?

Considering it's not a lot of code, it might be worth it to reduce the risk=
.

But I'm fine if you think we can go with this patch.

Thanks

>
> --
> MST
>


