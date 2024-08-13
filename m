Return-Path: <netdev+bounces-117910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F694FC5E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 05:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099AB1F228E1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC141B970;
	Tue, 13 Aug 2024 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH0KMPrc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F718E29
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520642; cv=none; b=W5p/k5cRmz/feZbIA4+71SVvFAR/+PtkPKMWTFhQRJatlXHo+8J3MAo+QONQ2I+1DUVvV+qaW2gzOugGVqgtXApRebNO1RrRKIPKRRL/YWd/M3HhfNksQcIYT1jJhF4qHrzriApItrpLzy7+P6DM5akhrnB9r6dP6GwBnoIKQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520642; c=relaxed/simple;
	bh=Su7MAzd9Yy/Zx73BwnjeRJHKXm/Dqxa7oKm3l/+o2+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jarRxDKb0RKzvZQYftUfSHqnH0spn/zrYqiu5FvjNDqNvmIuCpGxXa4f4ma9NxlbyzNanEivRoEQSJhCph0+VxiadLoLWe28ZLD8gBu7yhyWm/LfBzL93n/TzDFWWP5+jFRUvhgWUuVlR8H2SJ1GhIDXg47aW873ZRoUAvAR4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WH0KMPrc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723520638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Su7MAzd9Yy/Zx73BwnjeRJHKXm/Dqxa7oKm3l/+o2+k=;
	b=WH0KMPrccpouVT5y8WXWF5uSGxPoS+Pm74sh4C8pTWd1mfkvErFD9zAGcW/5cp0riYQ3PC
	QdQ9t6xZz+kCxSTQq/A6BpI+maWGfc577BdEHatL7Le2fbcXPmNwRzuvbGjg+hNNQWvxVV
	1vk3WjkZxToaTrr0Wk1HeIRHzqdJDAU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-8mQhCvbZPnm9x8RI6-nSWw-1; Mon, 12 Aug 2024 23:43:56 -0400
X-MC-Unique: 8mQhCvbZPnm9x8RI6-nSWw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb5ab2f274so6267253a91.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 20:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723520635; x=1724125435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su7MAzd9Yy/Zx73BwnjeRJHKXm/Dqxa7oKm3l/+o2+k=;
        b=UHWxKBV0WlDapPvUgxpZtFcuQqNfkfFuCLHVKODVrlLd2uWXBGO6HXIlsgTeLO7e6q
         V6AG6u2eXD0ADVaEVOK2shY7j+HKdgtPFJDAlPwOLNXKrdRj5B9yn6nTQtP961suL7SI
         a5zkcEU9iwzsweqHRjOlbAMdl8W12VJ+U1QJ4gTdcT5WKiAqR0Igb5PomJOGz4vnjNDQ
         o1p8+XUZHkl1LVDg9AkMZ56LuUIGPmnqMIKbBhoaycdRM0L376ncmySvBbXaXCCZEDaj
         AcuJTx7Vca4oBgorqpjXegdjhVim4gDuyV5PPNAIPuV93LZkTu0WW7+19PGsgRZmkG5F
         hSPw==
X-Forwarded-Encrypted: i=1; AJvYcCXaelfIGBDCxs0zZGH86en452Lm1EkfCzZb04CgCqm2NHMAxavSPjALAiy/15cj1Ec6wDuLEc1HgSqTTWRxfl+tTbbjyiDG
X-Gm-Message-State: AOJu0Yw3Vni/HWW2I17nYZc+LpwjoOcsqtiGHtU2Ceb6IJSpzG03ec3k
	/0km//+CN+N0mYqA5cP/M6HVsxmHE/TAYvwcnxqm4MmCiO8MnZh69Je76KvkR6ia4vMOXCrLq4w
	DeL3pmEaRo8Kgqql69epy5LKrFYIl74uL4uMfAK+7oGOlQCcJQs/dmcGaYRIRMSjR4mki16xHGr
	i99tzswz5KZqp5TZpBEVmZvpy3gTJt
X-Received: by 2002:a17:90b:89:b0:2c9:9c25:7581 with SMTP id 98e67ed59e1d1-2d39250f3c4mr2566949a91.16.1723520635526;
        Mon, 12 Aug 2024 20:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6MA9BP6pmDHbnjy1bE7jxyzt0JSd6+Jor/U4mIPatBQ31eFjzMETJs1p+NZwb9A9w16BoIT6DhGKyBeNG3Y0=
X-Received: by 2002:a17:90b:89:b0:2c9:9c25:7581 with SMTP id
 98e67ed59e1d1-2d39250f3c4mr2566923a91.16.1723520634973; Mon, 12 Aug 2024
 20:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806022224.71779-1-jasowang@redhat.com> <20240807095118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240807095118-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Aug 2024 11:43:43 +0800
Message-ID: <CACGkMEvht5_yswTOGisfOhrjLTc4m4NEMA-=ws_wpmOiMjKoGw@mail.gmail.com>
Subject: Re: [PATCH net-next V6 0/4] virtio-net: synchronize op/admin state
To: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, edumazet@google.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	inux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Aug 06, 2024 at 10:22:20AM +0800, Jason Wang wrote:
> > Hi All:
> >
> > This series tries to synchronize the operstate with the admin state
> > which allows the lower virtio-net to propagate the link status to the
> > upper devices like macvlan.
> >
> > This is done by toggling carrier during ndo_open/stop while doing
> > other necessary serialization about the carrier settings during probe.
> >
> > While at it, also fix a race between probe and ndo_set_features as we
> > didn't initalize the guest offload setting under rtnl lock.
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Hello netdev maintainers.

Could we get this series merged?

Thanks


