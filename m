Return-Path: <netdev+bounces-50670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A497F69A7
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2CB1C208CD
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157A419C;
	Fri, 24 Nov 2023 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8xc749n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD3AD6F;
	Thu, 23 Nov 2023 16:05:59 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b837d974ecso804233b6e.2;
        Thu, 23 Nov 2023 16:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700784358; x=1701389158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGodACVCE2G5lTrEpFSbibZCGBS3bo1pjwu8ZCWoqM4=;
        b=d8xc749ngLfdI15Fq31Ar/QgiExWslcpR8+ugeLDZN/ALvmMVpYU50QMghCbxl+VFZ
         9sFoD6M2KA6Ufk+6MPdzRVTe9j2J2XwWgy9+5nM9K6UVDfUE/eDznM+fjH9e7b8VUSL2
         4ioh8j325mOVt7umMUh2KcdeSHWDGxWpEFzxgF1IRN9oewpEIg5zDSrucb3m4B/rjLEk
         dOzlRteabbie6d75dSV4TfyCx0IgZmadYM9/mWuO7bUzM1hF+fp2VHX1+Emwi8dZdM25
         arZwH9NzNsN9TNbKAnz9RHcWwOVSGgcRrmhCJ8Xf6EjAZDnQxsPxYqQfo5xlgeBJmYZD
         fWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700784358; x=1701389158;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hGodACVCE2G5lTrEpFSbibZCGBS3bo1pjwu8ZCWoqM4=;
        b=i6iYeBFH9AVjYgNjVHQ2dURZhQp9lmX8CuUYY3lsuX29vKExNnOIheleHokdqUIBx4
         wE9ahla+mMatd+xcxzSvRhBAkN80TXxQyRKP0XZkSWqfAMad/4FdB0Zh7OS/p6BGoNzq
         T0FclPVWz4ChEEukFx4xbznbIspubDph9bH2EvpHNDU1ZYTQHi6laR7+A2updSn3EbAG
         qi9SH/HyF/AOXNg0JLgunZnRvy3Vmudn4wpkpsL1IR0Zy1dQkewjOgV/GERveg8Sf9wy
         CNn7JhgnwsR8n8mgEmuo3XLCpKezRHEmdrJM1QTihikNjdAzoVqkDBxh10ZB5xBJIgPv
         NgJw==
X-Gm-Message-State: AOJu0YzgnVnjRO0uPT+nOjrF0XgdQmx44so6eggxlfN0tVn29m0F7Exv
	tR7gslTznFjQ1BRJ2ZL5cyaBAZNB9SY=
X-Google-Smtp-Source: AGHT+IH8+NS/LOoB1M3xhQTRqg0Ld+/nkQh6YRodumRrSFqQt/3G4Ohf0zfvHr30gDPQ9ny2KxEJpA==
X-Received: by 2002:a05:6808:2026:b0:3b2:f275:18a8 with SMTP id q38-20020a056808202600b003b2f27518a8mr1361814oiw.22.1700784358263;
        Thu, 23 Nov 2023 16:05:58 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id cp8-20020ad44ae8000000b0067a0c767c26sm652868qvb.37.2023.11.23.16.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:05:57 -0800 (PST)
Date: Thu, 23 Nov 2023 19:05:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mike Pattrick <mkp@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org
Message-ID: <655fe8e5b5cf5_d9fc5294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAHcdBH7h-sq=Gzkan1du3uxx44WibK0yzdnUcZCuw-mp=9OxOg@mail.gmail.com>
References: <20231123183835.635210-1-mkp@redhat.com>
 <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
 <CAHcdBH7h-sq=Gzkan1du3uxx44WibK0yzdnUcZCuw-mp=9OxOg@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when
 virtio_net_hdr is enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mike Pattrick wrote:
> On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Mike Pattrick wrote:
> > > Af_packet provides checksum offload offsets to usermode application=
s
> > > through struct virtio_net_hdr when PACKET_VNET_HDR is enabled on th=
e
> > > socket. For skbuffs with a vlan being sent to a SOCK_RAW socket,
> > > af_packet will include the link level header and so csum_start need=
s
> > > to be adjusted accordingly.
> >
> > Is this patch based on observing an incorrect offset in a workload,
> > or on code inspection?
> =

> Based on an incorrect offset in a workload. The setup involved sending
> vxlan traffic though a veth interface configured with a vlan. The
> vnet_hdr's csum_start value was off by 4, and this problem went away
> when the vlan was removed.
> =

> I'll take another look at this patch.

This is a vlan device on top of a veth device? On which device and at
which point (ingress or egress) are you receiving the packet over the
packet socket?

From a quick glance, in all cases that I see the VLAN tag is kept in
skb->vlan_tci, so is never part of the packet payload.

But checksum offload with VXLAN can be non-trivial on its own. If
type & SKB_GSO_UDP_TUNNEL_CSUM | SKB_GSO_TUNNEL_REMCSUM, say. Then
csum_start will point to the checksum in vxlanhdr.=

