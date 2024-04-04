Return-Path: <netdev+bounces-84965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E82898D06
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C848B1F22C32
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9F12BF06;
	Thu,  4 Apr 2024 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QThm8eB2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3712BEBC
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250576; cv=none; b=DtnDa9MWVh5TFXp0EHUReuVh/DmEIXxJahVT8wRwfDiFVYCkF6Uk0ydGLGRc/06l059CW3AEACkAi2T6mYo50+i42xwJ2I/GmgEJRm/eChTBTHYXYyjF4o3UkXUzd9qdSsM1n452JOgwBIk+4WmfOwR2vxYMFqzekSrNrLmyno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250576; c=relaxed/simple;
	bh=75veXdvHVGBGKdsT/X9RInAKKKDeeyDLnHogazNvqHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9zr+K2QdbztiSQiGa1KMOyt9tTw3RyLcmzeNPEqqLxwatPHt+uE/IQdwhnDFwb/Z7AQmLh9fsf2sq0yi45kGISXljCBDsaIi8L05BZqeH0jWC0zDWqpwWaHLoAHc9Agc5fA4POpMZkzYSNP0mLvQfeskSi4dlz7xixC6Zanws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QThm8eB2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso343a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712250573; x=1712855373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd/KUutY8k98OH4WU4pXgX2oA0me8NydQT/NVKkKzK4=;
        b=QThm8eB2GkIYFIQZdCGqbHmGOJKti29fms8vpvUh3EgP4zVwzq0Oos2C+gZQJeCEW1
         j/9YxeFIylb2cpnUTJ6Hb3CWN3fx7ul/ajlRk9fJlWg6swWbQ2JVzkcxljCJx9dwSF0W
         Yc5TIvApxFMj9b8vUxrqaEESgXNs/1qc7JmSjK6uX4zgdKnK21CThjEAN2QsMBYuA1RD
         346d9RfQiBrsJ4Ua9gQMiEQQ5McXLhhTcpZErZRA7W+16IP7akgfFSsdW+nZ4c0uaVMc
         S1M0vu9WFJOF5iw+ToHaZvVBt4g+10O3L3fwUHK+h9BmlfWLTMOIcs01L8xXROaiTriJ
         bmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712250573; x=1712855373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd/KUutY8k98OH4WU4pXgX2oA0me8NydQT/NVKkKzK4=;
        b=YI94XWr2Ynfc6JBqI4AnG0hQ3cLbPH5Uc54Ut9E4zfAvLJ5RiUaom3754IN7aQ2b1d
         6u4vlNxmOH8zwIZ8+VWP0ONasv1IojFQOJUzQZyptZhaoG4bVQxOGjc5irN9E6stJQW+
         oLds9v0ud/PlosO2/yYTXMnrgXlSxEcWqe8XNsQoXf+RqDHdR7NakPqqOfjVHVO3xpbp
         Z8uuTy6snT3Iniawt0SXW2aaaZLaPQFIaNm67WNRZtPYehdP+A7mch/Rr4l3Gd9GngZl
         rBmXBuftzqXe5Q8XF7mVLb0cVKGU0RjGWIoKDAC74wusQKWI3uYfsd60bP6MvCw76Ssy
         8Zug==
X-Forwarded-Encrypted: i=1; AJvYcCU5ieL+GxDotqtowiVyvFLLXqi7sf17Nu+ehvn3XS0ykpBDCH7w1QDbbvnSj5i0sk3rN4eUZk4EeE0hOcaOd5NOXv4EUDTD
X-Gm-Message-State: AOJu0YzlDPsGaANaYa5X2J0AVZAvawuLzzl9WIhngBAc2cZVtmg+/gJk
	PCmrSrxr3tog5ZQrb3a/Z8BQXue5lKk3Kp9u+bdI0DFTDTZd3MMru535DjfPEBnpHd+3ZN5phi3
	3LY+L+Ii8uYeUV/uHtVrtxJqUB80RLZsUiDSP
X-Google-Smtp-Source: AGHT+IFs5FJlTAX7nsxWbYHR9ouajL9lmeqa7W4zxKxY/vQBRgiYYzHoA+deevjGKTY1BU89KBnI2KUBZFtexJKnLxM=
X-Received: by 2002:aa7:cd05:0:b0:56e:2239:bcbe with SMTP id
 b5-20020aa7cd05000000b0056e2239bcbemr129710edw.2.1712250573448; Thu, 04 Apr
 2024 10:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404131126.2534400-1-edumazet@google.com> <20240404100035.3270a7d5@kernel.org>
In-Reply-To: <20240404100035.3270a7d5@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Apr 2024 19:09:22 +0200
Message-ID: <CANn89iJxsJBj6tG7BQ2rDibcXnb-PSHREY_zKSAFcNXQacQO3A@mail.gmail.com>
Subject: Re: [PATCH net] geneve: fix header validation in geneve[6]_xmit_skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com, 
	Phillip Potter <phil@philpotter.co.uk>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  4 Apr 2024 13:11:26 +0000 Eric Dumazet wrote:
> > syzbot is able to trigger an uninit-value in geneve_xmit() [1]
> >
> > Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield())
> > uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> > skb->protocol.
> >
> > If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->protocol,
> > pskb_inet_may_pull() does nothing at all.
> >
> > If a vlan tag was provided by the caller (af_packet in the syzbot case)=
,
> > the network header might not point to the correct location, and skb
> > linear part could be smaller than expected.
> >
> > Add skb_vlan_inet_prepare() to perform a complete mac validation.
> >
> > Use this in geneve for the moment, I suspect we need to adopt this
> > more broadly.
>
> Something is cause the ttl test do break:
>
> # =E2=94=82 geneve =E2=94=82     4 =E2=94=82     4 =E2=94=82 inherit 0x3c=
 =E2=94=82    inherit 8 =E2=94=82 false =E2=94=82./l2_tos_ttl_inherit.sh: l=
ine 350: printf: 0xeaECT0: invalid hex number
> ok 1 selftests: net: l2_tos_ttl_inherit.sh # SKIP
>
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/537382/6-l2-tos-tt=
l-inherit-sh/stdout
>
> Is is possibly this change?

Let me check this, thanks !

