Return-Path: <netdev+bounces-98120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCAD8CF824
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 05:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB639281D0B
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 03:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F001BC132;
	Mon, 27 May 2024 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9LdJiQA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA40C121
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781348; cv=none; b=hqxfDwTVkREG/2Zr9JzT9+8eJkOCspWDPL7vw5tBJx+FMnYpKfrKsk9H1hCUnudOKb4+Ti+5yMMLwUIUjKK4RYA4Sh2tjkDcj94lavEEpDCylZ8Q/Ez+Cf9EhbnQWv+7qtVb/MiqtP6dOH9STWKz+XIAMuYLZrpqMGmN/YXleZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781348; c=relaxed/simple;
	bh=9JhHeiZ9fOYcxEd9/L7NL2iPzeWxkKhXRJPssf1Lhv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuosmTVEKM121lkWcCJf1/2y9/a+6MPQxEkYikwkIA6yx9xYKqB5HQ7O71ocVdXrelP8H9R2pU+cl/M+EXgb3FmCDjzd00IW3aPa2qiRqg8TxK2tfTzZerpmEIzfyeCJLvES9F6eXzuXRjfW853NcHby1w1UVfWOAVSQWBWzQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9LdJiQA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716781346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1G1TXr3mQFj361bybeNtAM3UF+HS5/GK6HdcRE4LH8=;
	b=K9LdJiQAPQG78OzxzzN55WrohFYCQxbOd03870gUwdj2U/NR+on5YPV7T5v51PG/d0QlCb
	nOoONoXdvTQCovHWFcCkAKPdMFynYxj5WrCqnVSe8sHSemN2HXfdKoL5XMxAxHDrf0Hc8n
	xsz/z8wBD+ErzrBJc7dmfMAl09W6w1U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-dbN7JARxO468Gl_JbP2Y5w-1; Sun, 26 May 2024 23:42:24 -0400
X-MC-Unique: dbN7JARxO468Gl_JbP2Y5w-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-68196e85d64so2483999a12.3
        for <netdev@vger.kernel.org>; Sun, 26 May 2024 20:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716781343; x=1717386143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1G1TXr3mQFj361bybeNtAM3UF+HS5/GK6HdcRE4LH8=;
        b=Z46NgQWglWurE7fXgKaZ1dcG92ggRLtfbcK/IcAoQYn+OHDXV+bgGhSXv+BclvwLVE
         SuXT/tYvte6hqha0uvgIODDd4I86QcmT2vjPNGYkPxaPKwJnYY5MWCmVAHoVWgYE7mlB
         Xn8k97m3I/ti9Eu4tNtG+lHkUKNMCVCOTYD2tnnr3J8K26m5pbppxQH0uDa12fxkqFIl
         xRmJy+szOFy8nYKoxtKVfjCesP3d6PsMX0WlUvdOpBas8R5c0v7cIKFa7bYxhef8GRCI
         WTBYaU9k8cGEgHx3fUqYtIaeXUqdP5Us0woIn9SpYc/FW/N3D24peAqemeVKJLz+p4oA
         TM5g==
X-Forwarded-Encrypted: i=1; AJvYcCVjnqGLR98ULzFYEXuyiRKAB+EBXgeBzBPj52xe5q1YohbLcL9/QZ1RntjxjJcHVPo9VBWl+wcQv8SCTQF7VWL32cf5Iakh
X-Gm-Message-State: AOJu0YzV4bQnSrUcOGFe43YQsX6apInrJSD3iqtoYm/MYUgNmzaIb5AB
	6UXv/XDqbFztzN0ejPYrQvNf5bJrlx7vTA/PhuUKjEaXquJDHLOm3rtFJNzSJklbbPAUJDniyHt
	BCpJUUWhIz5ptZZVoOWm1f8EYf8M/D1zu5fiR3x7M9fLFMiohOyWKs/NbO2CD5JnSOBJ61EoqET
	fLt+AcQzS69e4X2fBuDXNZRgnY42iW
X-Received: by 2002:a05:6a20:100f:b0:1af:adbf:2a16 with SMTP id adf61e73a8af0-1b212f3490emr7508511637.43.1716781343577;
        Sun, 26 May 2024 20:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFybCZv23Y7GXVDMeC7chDqiMFhio61O2YMrgc104tFi3NC+o27SBwMZyMBIWybqNYXnz1HGzreZpP/TYbQTko=
X-Received: by 2002:a05:6a20:100f:b0:1af:adbf:2a16 with SMTP id
 adf61e73a8af0-1b212f3490emr7508493637.43.1716781343116; Sun, 26 May 2024
 20:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520010302.68611-1-jasowang@redhat.com> <8ff81e78d13975c852800dbae2aca7342e8b6fea.camel@redhat.com>
In-Reply-To: <8ff81e78d13975c852800dbae2aca7342e8b6fea.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 May 2024 11:42:12 +0800
Message-ID: <CACGkMEtqRqj9hNki3TaCqAwUC9yY-kUYxmTKoM2b62D44PeDMA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: synchronize operstate with admin
 state on up/down
To: Paolo Abeni <pabeni@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>, 
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:14=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-05-20 at 09:03 +0800, Jason Wang wrote:
> > This patch synchronize operstate with admin state per RFC2863.
> >
> > This is done by trying to toggle the carrier upon open/close and
> > synchronize with the config change work. This allows propagate status
> > correctly to stacked devices like:
> >
> > ip link add link enp0s3 macvlan0 type macvlan
> > ip link set link enp0s3 down
> > ip link show
> >
> > Before this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ......
> > 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 q=
disc noqueue state UP mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > After this patch:
> >
> > 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN m=
ode DEFAULT group default qlen 1000
> >     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> > ...
> > 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500=
 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> >     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> >
> > Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> > Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> ## Form letter - net-next-closed
>
> The merge window for v6.10 has begun and we have already posted our
> pull
> request. Therefore net-next is closed for new drivers, features, code
> refactoring and optimizations. We are currently accepting bug fixes
> only.
>
> Please repost when net-next reopens after May 26th.

Will repost thanks.

>
> RFC patches sent for review only are obviously welcome at any time.
>
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#devel=
opment-cycle

Thanks for the pointer, I've done a short path by just looking at if
there's a patch with net-next posted in netdev :(

> --
> pw-bot: defer
>
>


