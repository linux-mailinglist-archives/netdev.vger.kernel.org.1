Return-Path: <netdev+bounces-201734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CDDAEACF0
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 04:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DE51885F48
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C319D89B;
	Fri, 27 Jun 2025 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+OpDwJ8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C6199E9D
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992220; cv=none; b=LO9GX5+iaRS6pdf1QAfSr5S0rpoc5rrsZUvqK0VvyZFWGuF+WX3xIoVLi7Mbw2IsmRglHyidxr5zDi1RzXk5tkdoHX8LxFQShd0IHjwn09HWaemHYjtuZPfpYSnP96VwIiljGi5kTA+I7AHwUaul3WqM5qnSHY30jjt4/PHd+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992220; c=relaxed/simple;
	bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb5KJ13385pOLhG3NFv8Pdgy+TyEj5QlqbdppjEx4Xe1+2E4KnN6EIBmcFFSP2GswyUnp1vDUBq30kxHl4fujiUqPoizxZeh0/dv2inIS34aU8NoK3p1JXV9qrHiOH7B3tTOfEnYib22kTgeNGukWxRG9u7/p6IaS78/ZB1Znfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+OpDwJ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750992215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
	b=f+OpDwJ8InoOr8JvoeuHxbODQk0deDxL8X3f+/xEylGS2Lac9HO8f9BbGjU33L6z2e2caC
	xuJafinTLHXaeLRMu3UTElGML4az6V/ipbfDkmA7sd65FxjVMSKQp4jselapY2+2WG/YmX
	0Vp+fgbZ2FvOrpX9kuXYUrh5J1swJZ8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-jIwivknqN9uP20yD2JSr-A-1; Thu, 26 Jun 2025 22:43:33 -0400
X-MC-Unique: jIwivknqN9uP20yD2JSr-A-1
X-Mimecast-MFC-AGG-ID: jIwivknqN9uP20yD2JSr-A_1750992212
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31df10dfadso1027568a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 19:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750992212; x=1751597012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
        b=VlKGAwCy7n8/FBgcXR0yTsIEWxsyddp8mimAbb1IHWzHaWTEDWBuhW1CkNHf3dWxmp
         EBfCsdTF6cX9CtkVm7ElnpvMSmurykU9WREwjtcfaVele1Gx2yJPa7ppSLIi1A38GuLU
         q8oQfv+RfRyiWaIPS9Tl9C53Jc6VCd5d+PBoF5uXVhLQ6AKUX+gfmQpBbl3+rwE6FBfE
         mJF+GqO7DJxeTGCPBVaxomW2x2QdZhlURZEO/SF9LfLG0qaJxznqMM7QIDx1FbbqNwF1
         766U5DoPh8wfnarUKWSkAjmZVLkCxGaoyjfGbUV1UQVl8z+JjNzJAHUuE5lIZLyHMLwF
         ZFug==
X-Gm-Message-State: AOJu0YwBwECtdGnDwvnHf7K6s1bExyyE+dSZZV2QwtZR4cRcvKXvytPy
	LqOQeSAeQAh4qk3F/VwIACBda0E3H7sbOLW9APPXyS8TqDHrE7VhGSilALfidJBQrsivRjy4257
	FQXOdqpDFKlWDkl2xDvQzt/u8D98w0aDHPbtA2ulQoBJW28f5wBrjkPb/25mgg0LaZqgpUUI8E6
	bimdP+XOXN9a4WFh2+EdyWBhVz6WElgdo+
X-Gm-Gg: ASbGncs8ODCB1x+O+S8zcPOQ8LfXsBrl6XE1gHZRqddRLLTEx4bJ++HJgAuHZddjrRQ
	F8GC7l9Tw8k3RHXxsGL2wBTAiNwqVMmsWDuq8NshiK8ToZagvcSv/3eE3T2BLMH3nJ5JhYUlRSh
	me
X-Received: by 2002:a17:90a:d64b:b0:312:1dc9:9f67 with SMTP id 98e67ed59e1d1-318c9107a53mr2192663a91.2.1750992212424;
        Thu, 26 Jun 2025 19:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJM16rdnxRskTxwuXyeMZbSoBcs9q4++zM+ywcskISDMXjQ0J0UHxMNSH2KE2x3C2uBazsSFuOebCMbQTd6Tc=
X-Received: by 2002:a17:90a:d64b:b0:312:1dc9:9f67 with SMTP id
 98e67ed59e1d1-318c9107a53mr2192640a91.2.1750992212056; Thu, 26 Jun 2025
 19:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-4-minhquangbui99@gmail.com> <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
 <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
In-Reply-To: <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Jun 2025 10:43:20 +0800
X-Gm-Features: Ac12FXyeaiRss6v-acFo0ljDViofeaY9eNXnTbOP2WE1qi3Xv2JlKX1swLORs6U
Message-ID: <CACGkMEvf18Dmo5Wzdq-GnJf-jOrzKMQ7epZA+ssWPzXvCnCXvw@mail.gmail.com>
Subject: Re: [PATCH net 3/4] virtio-net: create a helper to check received
 mergeable buffer's length
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:38=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 6/26/25 09:38, Jason Wang wrote:
> > On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> Currently, we have repeated code to check the received mergeable buffe=
r's
> >> length with allocated size. This commit creates a helper to do that an=
d
> >> converts current code to use it.
> >>
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > I think it would be better to introduce this as patch 1, so a
> > mergeable XDP path can use that directly.
> >
> > This will have a smaller changeset.
>
> I'm just concerned that it might make backporting the fix harder because
> the fix depends on this refactor and this refactor touches some function
> that may create conflict.

We can make it a single patch that contains:

1) new helper
2) fixes

as long as the changeset meets the requirement of -stable.

Thanks

>
> Thanks,
> Quang Minh.
>


