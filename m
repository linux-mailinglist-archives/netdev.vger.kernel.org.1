Return-Path: <netdev+bounces-234362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59B0C1FCA9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEB8189AB68
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBD2343D69;
	Thu, 30 Oct 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb3kSYB+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307022E5429
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823086; cv=none; b=SIgXIUf7EwgPQv/suoSDw+kFpqHV2nh6DeqcCb8Py+64ModXFcp8l+Z3hiRak140VRg8yaS46S7rFuh/yuiBUGbLPP6xdvTQTKljddJxbjHvqTW6/aYlHhQB0L+MrSI89MFlN2kcb6VI4WeE3oBbw2CywuJOEHw6rFm/IPVb7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823086; c=relaxed/simple;
	bh=zDrcC5GJxSK7Ji8wHBSk5s/mSLGf7VLCyLmVbQ62M6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTa1GYDbVm6BsS/UQr+Lujat3iI/174VhZ6VpLWRHw2ml88mWexT3jAPqShZzC5a2eEU7cHOsAaildE0JFkbxwMRc/DuzpF3F32VIAdJbxBjE6e1rmfSzyk1T8SBzmHboHZj3dLj5i94v+5kP25+rbOBLu144GCqwlprV+ty0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb3kSYB+; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-940dbb1e343so84475339f.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761823084; x=1762427884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnjkRvMkBIKfE5g1/0FeD48NJujoOxw0nQk05fABqm8=;
        b=Kb3kSYB+ldi+GbhDJUDhRYgsGgiDr9uf4s+cYNVfog4hG4P7s+Wp3WKRg7NQcHsvMQ
         sbmAnYA6Vlx82/GlGFjczzh1XqElrp4Xs/4IsfWpFRwVf9C4kUex9pmJwzc/JM9Djdc6
         wGQw1FjUesJKLVVX6rZhl9DaF7OiTjcqVBMmFTyKHyrI+j36aKkYu0QNYCcsrdep6w6W
         X0kxKrNoJSmQiw1YCcTL0GelFlo3bhNneku4sPC/DWMYdTCevvsxC1pDmS9TpcBbMGsR
         JbEGHR/it6YSp/XmA+FetRxIZVYvYudKrCGVHAy4B1dsfCjU7qkk3U238DO+HMplAHvw
         yAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823084; x=1762427884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnjkRvMkBIKfE5g1/0FeD48NJujoOxw0nQk05fABqm8=;
        b=b8E10pbo1I7I7mkP4EjJdq/1MMb5jwB3Y1X6bmbGp41qZZyH8G16bhnHVtdwPuQtQZ
         rfTc8iX8w/T2DximfPsv2L4HiJ4/5QGUf5BsCDjhc5o/dFHqm76ta/ydc62bGgEz3g2x
         GXwKWetSj8YHa9ZBTK8DrlEnXJ3p2JzK1l/nbdn6P7aRQKDx3Cje6uNr/YCacWCMPEC8
         wi5r8WgjVB3vxllXG/aCezGycOxN4EN5181Cb4nDlGdDK0WNLWBQ8kDRIETnhOTCFRm9
         tH3k0saKx0FE2fshMw5aHfpB0KE9/t9XsLQeW02bANuYu5JP3ZjTIgGuosbEKVF4CRwW
         Jlww==
X-Forwarded-Encrypted: i=1; AJvYcCV/jB2ejgpLygyc3aTBaQET/ImjcbWopVU3ZcBuul3wyQfu0FjvszGPaXeBwgOQSa3rAzfYZVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDC0YIUJ+9OvSQmDq3KT5Qum/E5qU87ZWQqxcZ4N/IqnCTMGJH
	WsCgRTcHWETqP8L1Htd7An9j2M4s5eG4f6ppSMyEZqsPhLbiIUj+GDOhai65TD9SUZchFn4kOIE
	AdPOdU1GFGFM856ZtAFxmAuyImQXvGWo=
X-Gm-Gg: ASbGncshr6jbafeBdShFskBVxTyZNq5aNPjYmpCjRxTQb3634wuXmGCFiEiCOkRgrOW
	b8toME8aoDVy+tJPcm3yBje0hBmACmhmyKhKHkWwUKGKPiflFG8Px/n5ywUwNcdlu3DTN1r768o
	OcjOX76ady+gl0CqTbKn4jLhdd1nUd7Kbvev+vuGK17T4Evu5QPo36C+ocPGDEW3GSQgpkG9egE
	8sv7lYe9KzPDnPuo+5vEfup9zRsrdvqqfu9PK34CoKbywwYrfoJTuRoMtLK4WKKWA1TH/g=
X-Google-Smtp-Source: AGHT+IFjYZSNf5b3bFjLFO/ww09HkUIGFNXY28HL+DLlplYADC6BMo7pzFokHHmEQe3ahOaOb/z+WYSc4dOL8YKuAlY=
X-Received: by 2002:a05:6e02:228a:b0:431:d685:a32a with SMTP id
 e9e14a558f8ab-433011f4f3cmr39332745ab.6.1761823084219; Thu, 30 Oct 2025
 04:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026145824.81675-1-kerneljasonxing@gmail.com>
 <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com> <e290a675-fc1e-4edf-833c-aa82af073d30@intel.com>
In-Reply-To: <e290a675-fc1e-4edf-833c-aa82af073d30@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 30 Oct 2025 19:17:27 +0800
X-Gm-Features: AWmQ_bmnROwfpAdiuZGw8HjV-5Z0NcRHwx0YijpygGa_flsHGmonev7UefW_R34
Message-ID: <CAL+tcoCu=7MFm9kioQnQmAQYkqbC_PNr-j3UyVEqyxhe7T2Fig@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:00=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Thu, 30 Oct 2025 11:15:18 +0100
>
> > On 10/26/25 3:58 PM, Jason Xing wrote:
> >> From: Jason Xing <kernelxing@tencent.com>
> >>
> >> Since Eric proposed an idea about adding indirect call for UDP and
> >
> > Minor nit:                          ^^^^^^
> >
> > either 'remove an indirect call' or 'adding indirect call wrappers'
> >
> >> managed to see a huge improvement[1], the same situation can also be
> >> applied in xsk scenario.
> >>
> >> This patch adds an indirect call for xsk and helps current copy mode
> >> improve the performance by around 1% stably which was observed with
> >> IXGBE at 10Gb/sec loaded.
> >
> > If I follow the conversation correctly, Jakub's concern is mostly about
> > this change affecting only the copy mode.
> >
> > Out of sheer ignorance on my side is not clear how frequent that
> > scenario is. AFAICS, applications could always do zero-copy with proper
> > setup, am I correct?!?
>
> It is correct only when the target driver implements zero-copy
> driver-side XSk. While it's true for modern Ethernet drivers for real
> NICs, "virtual" drivers like virtio-net, veth etc. usually don't have it.
> It's not as common usecase as using XSk on real NICs, but still valid
> and widely used.
> For example, virtio-net has a shortcut where it can send XSk skbs
> without copying everything from the userspace (the no-linear-head mode),
> so there generic XSk mode is way faster there than usually.
>
> Also worth noting that there were attempts to introduce driver-side XSk
> zerocopy for virtio-net (and probably veth, I don't remember) on LKML,
> but haven't been upstreamed yet.

Thanks for the added context. One minor thing I need to say is that
virtio_net has zc mode but it requires the host to support a series of
features which means at a hyperscaler it's really hard to ask hosts to
upgrade their kernels and on the contrary it's effortless to upgrade
VMs. Indeed, veth doesn't have zc mode.

Thanks,
Jason

