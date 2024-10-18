Return-Path: <netdev+bounces-136878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A261D9A3716
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CC61C20A5F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0653187322;
	Fri, 18 Oct 2024 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXxgTdmV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626420E33B
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236373; cv=none; b=hp2emTLQ5cJYJB81hAixajM6IYpvYk+flJ/l3/6eHI+SAHL5CskuKEyOGiwiAEIO7Qi1C7QWmwsA8rM1ONlnFeLJnc5RJfoLbsn7fPRhgg7r41sdyH7tiqd9yMULXp40qkvad3It9XkPM7gO4mu/WxWuQBUlbh8elt+L9T6/k64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236373; c=relaxed/simple;
	bh=LZGlQi4Ots25+3q3H3yKCowVnh/ThYR0x7Q/xfRUe0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUYDg2qg1Mgp2P3viskduYygpHbB6PobO1O0+aJFMUAkXw5Z3X/QZ4Ayesr79bXISNdg3exx/sdai9LeCkzrk6AobAmtNrgP9R3vnsm0whczZQ+Eo/FjQvW+2Np7Hs4BnJWMw4p2SsgUMSWZ+DT2VVnalRq8bTtDcLlYcrscdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXxgTdmV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729236370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya14nqQublJ+oBrxSqlMGSScCiwRD7+dwGBoRaBIXK0=;
	b=hXxgTdmVtS9XV3nnUvP0pnH5XNut3lZIY0jbRzjRItHDvzD0RIbJCSmAD18n7Qe4Apthz+
	qyjxrqQnocp3s4CzNpe0AWCkuT921b1MMbZv6C3AkC5M9tfi/dAZW+i919sK53+x7dU51k
	sFe3S9xO63IV4ZqAPgiYLBGSRlis/Lo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-Zxi-vOcQOjak96fErwzyzA-1; Fri, 18 Oct 2024 03:26:09 -0400
X-MC-Unique: Zxi-vOcQOjak96fErwzyzA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e4eb311c1so1814377b3a.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 00:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729236368; x=1729841168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ya14nqQublJ+oBrxSqlMGSScCiwRD7+dwGBoRaBIXK0=;
        b=J34FxW06OE2y8wZ3A6y7BmPC2dkNjWucwuV1HhxJ1YzQ3qIkACfM7zvD6Vub/eX6NA
         He3aBOMp9XxT14j3WU6jibyj2x+12dP/5jaQ0BinOTHihl85rZxqu1pN4lfq7dhR9yvp
         JJmtphPA8mgj61dyhEpSJUlScxQ0qxQSUP7EBJruvEs/1vYWDUX/pxwhRalJsp62Ksar
         D7ONvBxNwTJJFsRAig13LTMchtLMmPi6yFFq0StYItAO6ieB0UiWvvQcoZZlWC6M/PrL
         qXRvr6rfRPq9nplF38XGPN5zPH/SH74W6vor4t83pFZmDayl/MbjH2yrl76RsnkO5lBE
         88Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXomZxkOT6oUSMdKivVBpM48XbWK9of6ELaruUydQxtkNlHsiDUDWWwl/Kgz7+Y5wjgE28+0Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3qoZSEqUwBC2SOhf0Welfe3mQHwMzYbTm7OebWwZEXoUgmEs
	GGbeIoH/VqCA7SGCSLVlqRkVXG67Pt/76/OvtdOh7WlSR9n8ma2hp3v6rRzi9LhhX0Slnx5/WEj
	jl6Ui2OUXyImGAa8/xG+DHb6M2HFx6ZR5rijjPlKUZz01hzrya6FFP9dBlWRSxQY+a8x+aBcEhS
	aY1o6GOliByl/lgd/ljot4FcawewSg
X-Received: by 2002:a05:6a00:4b16:b0:71e:6fcb:7688 with SMTP id d2e1a72fcca58-71ea32fe8f6mr2016928b3a.25.1729236368114;
        Fri, 18 Oct 2024 00:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwmMXq/vV9LuZp+z8wMxxKvzZ6p0ZjeJAiYov4fqxFZUOP+iPB76T6Gz3r+SWg0xsZ7maJ06eN/9nDprbiLHE=
X-Received: by 2002:a05:6a00:4b16:b0:71e:6fcb:7688 with SMTP id
 d2e1a72fcca58-71ea32fe8f6mr2016908b3a.25.1729236367647; Fri, 18 Oct 2024
 00:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb09900a-8443-4260-9b66-5431a85ca102@gmail.com>
 <20241014054305-mutt-send-email-mst@kernel.org> <a71e0909-dc4c-43d7-88b2-8e92df89b386@gmail.com>
In-Reply-To: <a71e0909-dc4c-43d7-88b2-8e92df89b386@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 15:25:55 +0800
Message-ID: <CACGkMEs0huXk4KF894nFo2Vg1gRnasnm4Hnte6twmqq6hr0nxA@mail.gmail.com>
Subject: Re: virtio_net: support device stats
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:15=E2=80=AFPM Colin King (gmail)
<colin.i.king@gmail.com> wrote:
>
> On 14/10/2024 10:47, Michael S. Tsirkin wrote:
> > On Mon, Oct 14, 2024 at 10:39:26AM +0100, Colin King (gmail) wrote:
> >> Hi,
> >>
> >> Static analysis on Linux-next has detected a potential issue with the
> >> following commit:
> >>
> >> commit 941168f8b40e50518a3bc6ce770a7062a5d99230
> >> Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >> Date:   Fri Apr 26 11:39:24 2024 +0800
> >>
> >>      virtio_net: support device stats
> >>
> >>
> >> The issue is in function virtnet_stats_ctx_init, in drivers/net/virtio=
_net.c
> >> as follows:
> >>
> >>          if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
> >>                  queue_type =3D VIRTNET_Q_TYPE_CQ;
> >>
> >>                  ctx->bitmap[queue_type]   |=3D VIRTIO_NET_STATS_TYPE_=
CVQ;
> >>                  ctx->desc_num[queue_type] +=3D
> >> ARRAY_SIZE(virtnet_stats_cvq_desc);
> >>                  ctx->size[queue_type]     +=3D sizeof(struct
> >> virtio_net_stats_cvq);
> >>          }
> >>
> >>
> >> ctx->bitmap is declared as a u32 however it is being bit-wise or'd wit=
h
> >> VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:
> >>
> >> include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1UL=
L <<
> >> 32)
> >>
> >> ..and hence the bit-wise or operation won't set any bits in ctx->bitma=
p
> >> because 1ULL < 32 is too wide for a u32.
> >
> > Indeed. Xuan Zhuo how did you test this patch?
> >
> >> I suspect ctx->bitmap should be
> >> declared as u64.
> >>
> >> Colin
> >>
> >>
> >
> > In fact, it is read into a u64:
> >
> >         u64 offset, bitmap;
> > ....
> >          bitmap =3D ctx->bitmap[queue_type];
> >
> > we'll have to reorder fields to avoid wasting memory.
> > Like this I guess:
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Colin, can you confirm pls?
>
> Fix looks sane to be, with u64 bitmap[3] struct size field re-ordering
> does not seem to make any difference on x86-64 (64 bytes) and i586 (56
> bytes) when I compiled with gcc-12, gcc-14 and clang-20.
>
> I can't functionally test this though (not sure how).
>
> Reviewed-by: Colin Ian King <colin.king@gmail.com>

Maybe it's time to ask for a prototype for each virtio-net feature
before it can be merged into the spec.

Thanks


