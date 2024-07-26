Return-Path: <netdev+bounces-113150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E993CE60
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 09:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B061C20BC6
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 07:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3073F9D5;
	Fri, 26 Jul 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TMGeYcqR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92152848C
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977248; cv=none; b=b7fL0gZeuxM2JMV9Q2EVFs5svoDur5Kpkf0MGFDOK5d8M+azJnzt/ci3nByWhxLl6PbZ8k0w0wg/Q7EV45QDtE4EoJJX+P9MVd5v1IPuGjYQmvVaadVgrOnfN17Zh/VlgiE06izLc/Oa6MuX/66eourHtucDFKN+rAYczs5Iov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977248; c=relaxed/simple;
	bh=cXuBQx8G6HRYGa0zLfyDdgR2a85QCTfKAqQ15Xuh0GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5XLQ/klBhOYz9lbJdtjBwm7AAkGhHNklJw/2xNh0DY83hcFT03ecn+bqAHM6UZqQazzhgsGJ/M3z7vM/cdlbKlSGx8l2eRe0RMsx3AAQtrfBdG1HgQvGoYspWCpMxhG/tWf9ovLKr06sL/IdmSE37y4D2r/DBKyJmZFqhXX8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TMGeYcqR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso10971a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721977245; x=1722582045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y53RKvzqwB6Dazh5v3d7KIAfo6n5xzd1ZjyTale8iyE=;
        b=TMGeYcqRdXm4l60kUGYknKAvHdGAEVRv5NQN65i4FG/TCHJ3TXJZep6siLFU/chlxF
         PzAEVEAImwK1JpCsIO4CF9m0rrYu8Mdk6UsNAWBvioAi5XcaZAdFZRVTNM2iuDjhDMZn
         q+W4iS4AEF98LLa5cE6mlVA0I5oLnb58E4o2eUNCYDHx+PkqinShyUtC68SiHF8ORErM
         qBC67XgX3LBiLJqLvk6E8F9KEk1Mg/DnzXezgRD+lk2HaUPVDRo+K/W8/HAvgeq+HgAa
         Qh0/dX/Z0bbzLu06GvBLms6sFqIjBdpLDUBXteERU0yEromWgIZczbcNX/jpuVj2H5ZK
         U4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721977245; x=1722582045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y53RKvzqwB6Dazh5v3d7KIAfo6n5xzd1ZjyTale8iyE=;
        b=uzfmiQbh86TchTwGnXPwn84hgcsl3ANsegDfQxeAUNKxjbymGD3zgKXLOXjw2HDPjC
         HqqeUIdYCl/rcl23lKUUH2Gaqqo3rN7FQb+6+YC15JE745y5vAq2af3BW3/byl0nAYOU
         IbURWQ0/16K7TEnGtc/yJVemjX8qfpaHFvWE9JyiIIGLZLu9YLg1YMkoHZJ2FjlzcSPy
         FK/f5k+z7EY+HlkEUPM/wcid2K2p/6QJ78xvOQk3EWPZXt+JV1Cf789FY0mIEUwQY4/a
         3dYpcaUtuM2nJmhXkuU+NL924trug7N0UC9kPsE7b7b10Lm0GxCib4CFKedQ4QqU/JVN
         tx7w==
X-Gm-Message-State: AOJu0YyCSeqQ/TcjIl/OHgPPFIk5pdoHKLHXp3lmY4VMuRnXA7x2ySSA
	/VuKh6iBDAe4ww9LP1M1WDD+AwnJ6G6UAgKlDr/a7lDHLuwMbeFGt685/1ars80o62tUl7bCtGH
	ePsawMvhJNJ1/g9wRWehSXQVoKlAVj2oi/IYK
X-Google-Smtp-Source: AGHT+IFR4x8V4lq/D59qYaxfXZmUN89/wq11yTIMlDMOCvYHoW19s4vACmySyegOBrCOQvySYTHsqn+gvzSYKwXSm90=
X-Received: by 2002:a05:6402:35c3:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5aed72f8708mr118245a12.2.1721977244667; Fri, 26 Jul 2024
 00:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Jul 2024 09:00:30 +0200
Message-ID: <CANn89i+gMUzYfX2UTzCZx_S=96UHEf9_KzkG-cCq9aQkUiX3Bg@mail.gmail.com>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in virtio_net_hdr
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com, arefev@swemel.ru, 
	alexander.duyck@gmail.com, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:34=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>

...

>                 /* Kernel has a special handling for GSO_BY_FRAGS. */
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 4b791e74529e1..9e49ffcc77071 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -140,6 +140,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
>         if (thlen < sizeof(*th))
>                 goto out;
>
> +       if (unlikely(skb->csum_start !=3D skb->transport_header))
> +               goto out;
> +

Using skb_transport_header() will make sure DEBUG_NET_WARN_ON_ONCE()
will fire for debug kernels,
with no additional costs for non debug kernels (compiler will generate
not use skb->head at all)

if (unlikely(skb->csum_start !=3D skb_transport_header(skb) - skb->head))
                  goto out;

(This will match the corresponding initialization in __tcp_v4_send_check())

