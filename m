Return-Path: <netdev+bounces-225808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB1B988EE
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3851119C5E3E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3566227D786;
	Wed, 24 Sep 2025 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCtAcpa1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3827B4FA
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699206; cv=none; b=Z0DgR5vQN/XtW6qH5RLR4YmYo0E4hZvSFBi9cbv1WjPhMZtZSVxOoiwI0ZwRnWKArFZccet/OU4/lZogqZJofuh6Xerg0qfQ8dY8aEYN0aDVtL7gMkLQq0952bbbWTJ7z4G46p9ES+ZOtZqzmP7DzTT9prnbdDaZmU1SlXhgHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699206; c=relaxed/simple;
	bh=b6wRV+hU0qQluBXkA/BkhIVUgI+95DTwLYGQyvNsXeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aA7+5CN04oxSIMQX+5TzTg4++Bdnf8OOdr10USEiW+/AHfPmdi2vyBtG23bHtfjeVcNRxMWcMUSP8Bri6RKCaKru1vC6HuXfRYHg353UyDfZNxKiQIg3NOHr234+rUX/LOKtRRgxm7091cB+6zHzMBI/m89Y1t5h6mkghuQkCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCtAcpa1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758699203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6wRV+hU0qQluBXkA/BkhIVUgI+95DTwLYGQyvNsXeM=;
	b=YCtAcpa1Inn/2Q/GHhuC5a7HhGVGN7S29gni/1Xu8GrgpCBYAXHUHwK7ImlAHVbDtCWxVT
	ADuwP9jlTAnXBf81nWROOJgmGg2rKUKBKgGoaes7ODfAM/rDvXE4Ln+z9rUu0Np+UFZzuG
	KmpPtk8LEIl1Mi2lLqtH9XyJ3ZJzucs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-YC9DflYENVKfv_HdyMyd-w-1; Wed, 24 Sep 2025 03:33:21 -0400
X-MC-Unique: YC9DflYENVKfv_HdyMyd-w-1
X-Mimecast-MFC-AGG-ID: YC9DflYENVKfv_HdyMyd-w_1758699200
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458345f5dso94728175ad.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699200; x=1759304000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6wRV+hU0qQluBXkA/BkhIVUgI+95DTwLYGQyvNsXeM=;
        b=qukyNvbhGiciRIrwmnbmdAE+sPQrGlaMAVAK2myXKnpsIcTk/KV6Iu8FXEtR9e+H6q
         xeCCk2egt1vkw4yJ7GdUFWR/T6wgXhvECV264WdBuvahuOrDUsE9XSQ0h6CCNBerp6yP
         TEyJkCwynqqXf1pxEfwue8BnaASVfPOvzFGIOOKkVoMoon4B6Ut9m8joL4Gfenf3g1bU
         knnJito7jgl03XZ5VboRVEoKBoL9LzIpRkdZOcouOGqbipYXF8jT+hVLtjDrccByDQTp
         JQmlZFs9w+JMQbgOWStqpxy0ITxUXPGTamH+CPbMEAX6FGfqqogLhZy/TS0/MvE41Hoi
         cRpA==
X-Forwarded-Encrypted: i=1; AJvYcCUvXRaoCcpR8EQxkB8B6hVcckqjhyLstKqBqK0AUv5T+PrsAYohW9wPp4o7hdB6uXTZ1iwkp6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIubN8QWt0h1C/zZyE2ngwomv116pUU1ZHGrRcShtkE/M45bx2
	FnewDikPBgYr+XHCT62h8SaKrgICBGpjE5/UTEEHQIzMht+a8SK/J2Z46Q3wY2yVV+ntBfCjmr0
	S7gdX12qNTG2ySMVDVuBUS7MGd913/3qXWBfP9/29ubh+DUST48X4f0fEG+1pdOT4acnAPEgmXV
	FwwH8378KAxqPbvffUvBbIVd05qgxmjAC+
X-Gm-Gg: ASbGncsOs1bHztmL4qPZkcP/a7r0UqKZkkMy2CUgx/LwuRT8gCL1gApH0vn/Nlvm8ag
	+h7ugRm/o9OMn33vd+iJWxcygbvwE8VQ+tng4XzI1tqGU4goLmy0DQc0w7Jmuam/FQSYUpAmbVC
	C2N8YQVNafVWiqHD1vOw==
X-Received: by 2002:a17:903:190:b0:265:a159:2bab with SMTP id d9443c01a7336-27cbaf0e24amr61534625ad.0.1758699200588;
        Wed, 24 Sep 2025 00:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+14SJa59MjbvP9DJUdCwTBFSU+ad1kkLu/Xoi0kve8FMkca56Fj+oIDkby//sq4cwlX8+6BEG+AYJCQZEwnA=
X-Received: by 2002:a17:903:190:b0:265:a159:2bab with SMTP id
 d9443c01a7336-27cbaf0e24amr61534425ad.0.1758699200205; Wed, 24 Sep 2025
 00:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de> <20250924031105-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250924031105-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 15:33:08 +0800
X-Gm-Features: AS18NWBSU_1fvQZUvaWmku_qO0_MGvBZjZq20karT9w3KYqASj9gmSz5-R3j6Bg
Message-ID: <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > SKBs whenever their internal ptr_ring buffer is full. Instead, with thi=
s
> > patch series, the associated netdev queue is stopped before this happen=
s.
> > This allows the connected qdisc to function correctly as reported by [1=
]
> > and improves application-layer performance, see our paper [2]. Meanwhil=
e
> > the theoretical performance differs only slightly:
>
>
> About this whole approach.
> What if userspace is not consuming packets?
> Won't the watchdog warnings appear?
> Is it safe to allow userspace to block a tx queue
> indefinitely?

I think it's safe as it's a userspace device, there's no way to
guarantee the userspace can process the packet in time (so no watchdog
for TUN).

Thanks

>
> --
> MST
>


