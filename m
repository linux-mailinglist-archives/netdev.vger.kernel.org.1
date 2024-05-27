Return-Path: <netdev+bounces-98177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8F58CFED9
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 13:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFDD1C217A7
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012013DBB6;
	Mon, 27 May 2024 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mb7+gCFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1F13DB90
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808891; cv=none; b=PqGeXn186KZuBFUttTCTNIrfK3qVPWewYcGTOxUhgwbuV9Rqn+/KwGse8OoNUdbReqdEzEHOaAMIsP3TkOsbDXKrGI+wEymi8ypy25/A9AdBVv2sGzg1J4AnJ+gCLkM88xXlUXUvj3nO9gh2Ph03+PN2wbCt6n/GVBiguhT72h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808891; c=relaxed/simple;
	bh=je9mqqmdaY/JxmbvitIGUVjDXcfhLkM5qW9qsLL8Ttc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hscsB+si0+rDd/lMZqrYJtXq4lQYcIoBOffu3kgboaTnOoR1U+YrGT0vrNq+jbSXhZHnpyy51zeWh1QEaMDJcqgO7PnHbEQehs+1WUBRTxy4NaKzWdupqEFkk8kF559xBc91cc8HlP4xrxae9SnOJOrflJF4GcLA1GqCfbree5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mb7+gCFA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57863da0ac8so12067a12.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716808887; x=1717413687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UbhHOt+pOcq9D676QmKA4dAkwNsDHqmpZkbHg+/poM=;
        b=Mb7+gCFAQQYuCSRoYWSYKbCexmO1NveO+hHGvgjSspqJ6cpm3f7D42LhWd9lNXeXWL
         XZS5RoEXbQoWHiHruay9nqTWIGF687tHBKNMLEFjyYorX4uI5K9kaWcsIGxaJ4ApyGEh
         +DuayktikLvmJt7rmWLXYru2fDazJUgasK8HPDL04KXQnyAbZqV/GxI0eu2xLtFK/pws
         qmS+zdxTaboRmQoswPTOmtoKxJLHTgQSc9CGRJnIEkFDI98FoVL5uJfVOqxlXAmSR/CB
         51Fo9KV8CBIH6R0AVbhIelG1N2/kquwBMX1Bx3o+AgeRG8F6mSPpGs7OOB6nnLC1mkmX
         dPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808887; x=1717413687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UbhHOt+pOcq9D676QmKA4dAkwNsDHqmpZkbHg+/poM=;
        b=KsbDy3pGlR0aQiE6n6Wukm32tjo+DkRfS6ZDRNkp7GOxhUaDv8xZpE4Qo3/LVbTszm
         6GvN0sSFUpruNYOMHIxqcSHHAj0Ah1DITVOkikesKdpUsF81ePrnIoYuPT/n/18S3Qat
         3ISdCkf4DHMYbo+VZVtB7lS9PR2jUFEuuzGDXuawPK+ta8fupzpICaULrPiYLslI1Zz4
         qop9Rfi6b3fHrjQj30DZMGW6XkOw3nr6rZuZlEC5jXCFzn51AKi7K+y23LHiJtKPE/JH
         /0+piT+Cghc0MIBNAiDv7/mQzrHP+Ai4pclAkZ+MWh//wZZWuemizD/gMBl8T/m8SRbo
         uv1Q==
X-Gm-Message-State: AOJu0YyNf9Ho6j2oMNNdPHR9fXuO9Yt/v8d+AJ543R3vwqRI4cj4vh3n
	A66Jgqo5d2tdx3XSYmpjbwpNs2bf7W21OnIJl6M9JTU3LF/D8/JM+0F60JBdMpjcj38sZoVEmtS
	IjdB6D/DACQpJwsDb73JeXRsFBHBr6NAJI/DH
X-Google-Smtp-Source: AGHT+IH1g58wjLeSh7ZISKL47v3jKQJpRPrJ7/Q3DjleTWwfHGxq2+s0blglQox94q2zv53Obl5uOSZbqJDBbBYo0B0=
X-Received: by 2002:aa7:cd02:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-578679155ebmr241317a12.6.1716808887363; Mon, 27 May 2024
 04:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523141434.1752483-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240523141434.1752483-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 May 2024 13:21:13 +0200
Message-ID: <CANn89i+wkjYSFuq7x3ZcL4L42BsMMTVdyGcXJ47runBHKD_iHw@mail.gmail.com>
Subject: Re: [PATCH net] net: gro: initialize network_offset in network layer
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, richardbgobert@gmail.com, 
	Willem de Bruijn <willemb@google.com>, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 4:14=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Syzkaller was able to trigger
>
>     kernel BUG at net/core/gro.c:424 !
>     RIP: 0010:gro_pull_from_frag0 net/core/gro.c:424 [inline]
>     RIP: 0010:gro_try_pull_from_frag0 net/core/gro.c:446 [inline]
>     RIP: 0010:dev_gro_receive+0x242f/0x24b0 net/core/gro.c:571
>
> Due to using an incorrect NAPI_GRO_CB(skb)->network_offset.
>
> The referenced commit sets this offset to 0 in skb_gro_reset_offset.
> That matches the expected case in dev_gro_receive:
>
>         pp =3D INDIRECT_CALL_INET(ptype->callbacks.gro_receive,
>                                 ipv6_gro_receive, inet_gro_receive,
>                                 &gro_list->list, skb);
>
> But syzkaller injected an skb with protocol ETH_P_TEB into an ip6gre
> device (by writing the IP6GRE encapsulated version to a TAP device).
> The result was a first call to eth_gro_receive, and thus an extra
> ETH_HLEN in network_offset that should not be there. First issue hit
> is when computing offset from network header in ipv6_gro_pull_exthdrs.
>
> Initialize both offsets in the network layer gro_receive.
>
> This pairs with all reads in gro_receive, which use
> skb_gro_receive_network_offset().
>
> Fixes: 186b1ea73ad8 ("net: gro: use cb instead of skb->network_header")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> CC: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

