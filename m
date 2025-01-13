Return-Path: <netdev+bounces-157591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F0A0AF14
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A47165496
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580AB231A33;
	Mon, 13 Jan 2025 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNzx/m9d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953C1B87E9
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748231; cv=none; b=gq4lcRVYA/QL+NkIpPKKSvcbqMmPdkDAcfYMjPBJe53N7m3YqfXTqpsT4lRBTwL4azJVwJ1nmgOP3R3XwDooPuiEhT9WiCpngCB0B/lwqZK+tjaJltMaRU5ke0CLFTeFWgw19KN9/8fFnGXuOHo6ylPOIxdnzW+TWCCOR8WLdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748231; c=relaxed/simple;
	bh=Jx8UqfzIjWLE/l5vEYoWQiykUMtbF2Xs+fqRm8C2jnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elBcfweb+HRhnyvfS7yC/QUnW05/Q/j74wXub3rMvREtOKlW7mzAqMnYQtRfJx9zv8Xxn/VY9lhjSLN5JJ4doyfvNtWOXYEtwhY4dLyZ71mYNub51cnRj2FbhBBX4ns5ajne43BeNe+H0Asi72ehkruqWv6z5Iwn52jW887YFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNzx/m9d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736748228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRfvoZSq59xDgIbjE3MXjh3C8swGNv8nTHTENTK3KGs=;
	b=aNzx/m9dc4wE07N5ecDpAphuIzTXPJVUnKXDLXBa/xhdikbLnSQE2FtBH999IwEGRjfmuh
	1xAo/THiiVmgn0Uw6MxMY4yaTPLq10ekkGJPiCeN0u1dSqXaHYValhf/8DOEbJttiZojcR
	HaIHchZyEdXRInaE/q2eu537WapQBI0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-I4YHLK_APEO9y_GVR-X9Jg-1; Mon, 13 Jan 2025 01:03:46 -0500
X-MC-Unique: I4YHLK_APEO9y_GVR-X9Jg-1
X-Mimecast-MFC-AGG-ID: I4YHLK_APEO9y_GVR-X9Jg
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3eae7a9b8so3680647a12.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736748226; x=1737353026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRfvoZSq59xDgIbjE3MXjh3C8swGNv8nTHTENTK3KGs=;
        b=A4Gvm35gT34+Z8JccGLORUVu3DJq1Da0TtVlem9v0H7IiYCv2fzG4ASOyYgu529Pr/
         7PlhmFE79RZhWgmsY93lQ07Q7DT5vMvENyZCjI2bBKEpUsxG5piivMr6abQEz5WOoQW0
         b+vopy3VcoWan1FUxQiHXEkumHNpapcDtQZfFtS7AQiGx/VDHi3dlTLoTP2fI1JID1JK
         YkwYPCblG2RGBqejjzBH4SmEYgsEfOEBWLySlcWiZwtXb0pnNHO/gykmkVG891P8geVA
         /byBroxhhGiuFqzod8k04pqNe59FUxSC2GKDkQxu7Rnu11Zu+U4+12PVrAY0f/yoPBTx
         XPXQ==
X-Gm-Message-State: AOJu0Yx//gtWqgEar0KUupQbg+GqQpk7nWebBkMNNgZaziKBrazZgZsb
	XIngfKTc08Kez7vqPbmEv1qBPRurhqgsOZjI5LelaE7yuFkDf1uMojUEk3FBUA8En1rQnH7PByB
	q7Qm6VHfkW4v1AEUWvyBWa5BTLLsmsURwDrz6Gx4hp4D96AH2xYickf3gctQ3McCg3UxRqgGWVA
	UUtFXlSRhfC26qQIvuGhYtxHjkV79E
X-Gm-Gg: ASbGncuA7ES0r/dR2ZKLFHNF1l//kdWX8NssEpb54gBxZRa/FzAhm2jxtFujAO/p318
	is6tNWRAmZKlhxkiloKXbwUbigm/TRZCtI5E6Jc8=
X-Received: by 2002:a05:6402:274d:b0:5d0:e50b:899e with SMTP id 4fb4d7f45d1cf-5d972dfb400mr17355044a12.4.1736748225647;
        Sun, 12 Jan 2025 22:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpXP2UdK5u/lOnf8j8kk81BB8Xh2L/TCeQINOuQMpxzWoGcGTx1RD12iNsQmVoUUuFtpxXcO58VNsKCybQiKQ=
X-Received: by 2002:a05:6402:274d:b0:5d0:e50b:899e with SMTP id
 4fb4d7f45d1cf-5d972dfb400mr17355011a12.4.1736748225218; Sun, 12 Jan 2025
 22:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110202605.429475-1-jdamato@fastly.com>
In-Reply-To: <20250110202605.429475-1-jdamato@fastly.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 13 Jan 2025 14:03:08 +0800
X-Gm-Features: AbW1kvba2fNdUGVp7gFxi1Bq2_NuWMOr_1YCCnaur_kbyMnys2wQSdgaX54y0uM
Message-ID: <CAPpAL=zaZ+7judG424sEmndE2UxEFA0ZdcEB7tB1A3PcGw5n9A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] virtio_net: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Sat, Jan 11, 2025 at 4:26=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Greetings:
>
> Recently [1], Jakub mentioned that there were a few drivers that are not
> yet mapping queues to NAPIs.
>
> While I don't have any of the other hardware mentioned, I do happen to
> have a virtio_net laying around ;)
>
> I've attempted to link queues to NAPIs, taking care to hold RTNL when it
> seemed that the path was not already holding it.
>
> Note: It seems virtio_net uses TX-only NAPIs which do not have NAPI IDs.
> As such, I've left the TX NAPIs unset (as opposed to setting them to 0).
>
> See the commit message of patch 3 for example out to see what I mean.
>
> Thanks,
> Joe
>
> [1]: https://lore.kernel.org/netdev/20250109084301.2445a3e3@kernel.org/
>
> Joe Damato (3):
>   virtio_net: Prepare for NAPI to queue mapping
>   virtio_net: Hold RTNL for NAPI to queue mapping
>   virtio_net: Map NAPIs to queues
>
>  drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>
>
> base-commit: 7b24f164cf005b9649138ef6de94aaac49c9f3d1
> --
> 2.25.1
>
>


