Return-Path: <netdev+bounces-159662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF9A164A5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 01:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEBD164365
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 00:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71C7483;
	Mon, 20 Jan 2025 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESiPOpUY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778D2114
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737333410; cv=none; b=bZDitxnt3o++RHsGk8hNw6aR15ape4Jp1jg1eIA4a+t4aTofRumc0ApeoTYyOM44bmMw2CXGmo1F3dURpJQEFTdJsvEr+dDyEMK7ROXiQbqf7ee59XFPI3kQNNBeVgWWk6QXD09jXlp9Jw44U3+GerH0huU2CiRB9Cx4YD/7Wjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737333410; c=relaxed/simple;
	bh=sBrzjN252amelDCl8v0nqe8T7UjrAIPyRfaO63v6GNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvujqfu35k+CR16w2SNUHP0ZHfr5yKRyuFFPaM7midphdzBB346KhbmnKH3U+o2TxMsc2K82xJMn2EEHL8VockVPOZyWN6yUL0nZtPfiWEtooakcs1isfmUWQhh4tXdeuz/5gW7MLiKarDcE2CWtYtihCDoCIPMYEy1lCTRFeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESiPOpUY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737333407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H0nYB61+8LVuoJq+zs1egrUFpcaWndWQWohYstwrpY=;
	b=ESiPOpUYEu+ALPvnGqREfqAI9fNlFWb0MCxgYAL5z/OAkxVQ90e5y0bNpeGPZg2mXy/Ey+
	DzUrjUNcI51RoK84vI2gH3NoPET2FgpKQzLMhhlcOpckpa2wyhPkBTvAdf1HxyZoQkyHfH
	OsWIHWJsd+DsXJvvJ9pQbZZ9HPpmOfs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-mnxuSiIVNEuSasEVA29osw-1; Sun, 19 Jan 2025 19:36:45 -0500
X-MC-Unique: mnxuSiIVNEuSasEVA29osw-1
X-Mimecast-MFC-AGG-ID: mnxuSiIVNEuSasEVA29osw
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so11116673a91.2
        for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 16:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737333404; x=1737938204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3H0nYB61+8LVuoJq+zs1egrUFpcaWndWQWohYstwrpY=;
        b=fZZrJgvuh4BaY56AvK2akBe/uF/aMIOjEEhk6zQRYbppUS9PJi79WztCJVInwJHOp5
         nBElJWicO/D3Ulx0FmS5zO0+/NoBMlKUB3sdFNDWOVJMraX7YaJ88ss9tcYS/uSaXmiH
         EjdE/++1wkMysA3pAz+7tRIZZZMColb5OYq9CEUz6d75TRQpPzblHEYx6RWKh3t9hWf6
         5Dgg4vD0C7P4DADx1e32xJaEqyLittPopJ3VFBkCBik7iO9bxcSfBqbmmviLFZsrvS7n
         oV/6jWVsrLY5p4z4RNnHVHbqj9TI9J37wgHiXajU7dSxv+vxvw+9OmujgDr4VSCLc6hX
         N22Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoze9sIAfzpFRInZPELRfYi5koGeELsVg1FN7vgHQE0+XNmPtx5pKaJRe+zfVxaPEHYaBO6NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4yOqA8viLfu3s8N5HjgT2fo9E9QQvq5Wu1+MOZ0EvvtbKEly
	IuVgeSck5MBF1EF90PXZ228tsC5JfJ5pNXxqalnFFMHjloT2vy8DhLjgfIZ+m1CaMlNufL0O4u1
	qprRWuRvh6vgyup9O8PmhiTfrq/8qCBeTZZIGz2RzSU2xEF/IG5BfzBSk3xhIHM56963b74ST8z
	V55SHuAGesVUlcwfO4Mdub+gqajhkvGG6kyemPG/M=
X-Gm-Gg: ASbGnctihtvj8jNNjYktkqjzjmyxI93JhiZS+L5Td43MJCcxRFHXnF/64naE82wljjQ
	V3SN46w0SHbbKhF5z9hK4hNKxXGR5FRzYIkbK5D9LeWqBFQTIlPgu
X-Received: by 2002:a17:90b:2b83:b0:2ee:fa3f:4740 with SMTP id 98e67ed59e1d1-2f782d86690mr16043475a91.35.1737333404217;
        Sun, 19 Jan 2025 16:36:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp1Ois/gQ7usRrA6ey98y4JMzYea7jlE0C3PdWtBxN0mj155LyybzQ3UYqgF2HjpbQV22UEWHRbWe4ES5xwPY=
X-Received: by 2002:a17:90b:2b83:b0:2ee:fa3f:4740 with SMTP id
 98e67ed59e1d1-2f782d86690mr16043449a91.35.1737333403779; Sun, 19 Jan 2025
 16:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com> <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch> <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
In-Reply-To: <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jan 2025 08:36:32 +0800
X-Gm-Features: AbW1kvaoh25v05-5WCQ_wsN2rqQ8xuqgKjHNGkTQtJgSpKoEbixeVohO4Epfz8s
Message-ID: <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 6:35=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/01/17 18:23, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> tun and tap implements the same vnet-related features so reuse the cod=
e.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   drivers/net/Kconfig    |   1 +
> >>   drivers/net/Makefile   |   6 +-
> >>   drivers/net/tap.c      | 152 +++++----------------------------------=
----------
> >>   drivers/net/tun_vnet.c |   5 ++
> >>   4 files changed, 24 insertions(+), 140 deletions(-)
> >>
> >> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> >> index 1fd5acdc73c6..c420418473fc 100644
> >> --- a/drivers/net/Kconfig
> >> +++ b/drivers/net/Kconfig
> >> @@ -395,6 +395,7 @@ config TUN
> >>      tristate "Universal TUN/TAP device driver support"
> >>      depends on INET
> >>      select CRC32
> >> +    select TAP
> >>      help
> >>        TUN/TAP provides packet reception and transmission for user spa=
ce
> >>        programs.  It can be viewed as a simple Point-to-Point or Ether=
net
> >> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> >> index bb8eb3053772..2275309a97ee 100644
> >> --- a/drivers/net/Makefile
> >> +++ b/drivers/net/Makefile
> >> @@ -29,9 +29,9 @@ obj-y +=3D mdio/
> >>   obj-y +=3D pcs/
> >>   obj-$(CONFIG_RIONET) +=3D rionet.o
> >>   obj-$(CONFIG_NET_TEAM) +=3D team/
> >> -obj-$(CONFIG_TUN) +=3D tun-drv.o
> >> -tun-drv-y :=3D tun.o tun_vnet.o
> >> -obj-$(CONFIG_TAP) +=3D tap.o
> >> +obj-$(CONFIG_TUN) +=3D tun.o
> >
> > Is reversing the previous changes to tun.ko intentional?
> >
> > Perhaps the previous approach with a new CONFIG_TUN_VNET is preferable
> > over this. In particular over making TUN select TAP, a new dependency.
>
> Jason, you also commented about CONFIG_TUN_VNET for the previous
> version. Do you prefer the old approach, or the new one? (Or if you have
> another idea, please tell me.)

Ideally, if we can make TUN select TAP that would be better. But there
are some subtle differences in the multi queue implementation. We will
end up with some useless code for TUN unless we can unify the multi
queue logic. It might not be worth it to change the TUN's multi queue
logic so having a new file seems to be better.

Thanks


>
> >
> >> +obj-$(CONFIG_TAP) +=3D tap-drv.o
> >> +tap-drv-y :=3D tap.o tun_vnet.o
> >>   obj-$(CONFIG_VETH) +=3D veth.o
> >>   obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
> >>   obj-$(CONFIG_VXLAN) +=3D vxlan/
>


