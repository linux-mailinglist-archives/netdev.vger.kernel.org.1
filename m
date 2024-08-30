Return-Path: <netdev+bounces-123534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 493BB96542A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E891F259BD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E981D12EC;
	Fri, 30 Aug 2024 00:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf27jwiA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E74503C
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978487; cv=none; b=EUGtkckSVNIKHc4vLR6LDHJ7zi17z4BZjizuPtJkUs1d3Fz6bi7h1jsZpdtHSZAjsyvZABs+0WTdGynCgqeqAd5YlGtdiHiEd3k6Abz7SxFbVGDqmQvmAYU9C/lSg98t8YaUYQnEOuvw6f6H/x6+i++XocFb2H9jn6d3cHWsIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978487; c=relaxed/simple;
	bh=JF4x9ewCohlgD09KI/KsiuL5egJjiB2+YaNG+oMDIs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0NVvba7DWM3kYMtqF2h8EjIlVUR3d3vzJcAebTTZXw9tPoct6Go4+ufecZ9qgqq7VBBoiPtwaDoxU936RGv2fhG0sTDpYSdqUMBV3h4GxTHZwNWOKphVg/aJ71aKf61JtCUpw19Y7R0cypV5/+cL0azaggZ+uEozDrIv/8yVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf27jwiA; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39d29ba04f2so5255255ab.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724978483; x=1725583283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF4x9ewCohlgD09KI/KsiuL5egJjiB2+YaNG+oMDIs4=;
        b=Zf27jwiA6xnNPLqF6Oo4jfrvoRdPIlIpBRapg4zBw8vRc1zzkychWphm3Ahhwo3g6F
         XGcYb+WefLXvFaLfcJ7oeUSEjCe8k/LQ3H24aS6L7hKGvrMDgJezYFR+N5QrFqq5K02E
         ctUcITrrBpYbTXlA7hlgvf//7qbp1kyRK6EsITg21KQQQEXrcjnrNhBYzQA2cWfYT/n1
         ZpLKsEnF1leG130LsEd3pEaQla0ScgIeZUBvfQIR9J5IUMtm1GA1CuKQc9xRIkbvl2Yj
         kKTW1N/WFJ1Aj+rl1asc27eDD2rPlTIpugdg7FI2erLjO5/ksYBV9OmKOE+VJiycAFaX
         1huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724978483; x=1725583283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF4x9ewCohlgD09KI/KsiuL5egJjiB2+YaNG+oMDIs4=;
        b=qP0Hb7tWQbIgSeo5D7wI+tj5e+C8i7Bxfo9YjhPd2+Lnm2eKuvpLHD1OFV1+MGWPyj
         fg73LthmHLxG6jLfE+i6EP5cIxBRRSpAYKSzCAsInEojHr8tT8khJYrBEXiUbNuJsFtQ
         nEoDRvHYfPr2nIbtTt6LL5p9UiCKVuu89Xz0pHREaX6InHtiqeui+FAPV/ksgQeEviW1
         N8anPyUGA+soYRwRhiqQ6v9xQI2itXu0qtexbuee0FQSmGk2aXI39qj/3Av8IyX9eBIa
         GTsaLmMxcXH9fj+NMUkvVGvbKU3VdX3iC2esnpCA7NfNBMW38zxMTFEsarbYDUPhI6/3
         ja0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWt5lbdYjIO2SqueREqialv/TTRWiVKv7Vb9+isySPIqOz1298lVxhbhdZxHZSSIp+/6gp1r3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxaIGghWpykDNItiHX0nEIJc2rjI2H3BiYlqY4XpxN3BqywXME
	tHdbfDQOauUgKhh+44blZQdYBm7LK7Phh+HOLrcM08RI0BVXg+mAfpP6te5x/DN47ZMvLIZ+0mt
	TULN9PkzZUNj0rAZaiZckmP1W7Zo=
X-Google-Smtp-Source: AGHT+IExcaGKossZrdSsIpFsVTky9+VbMAqgHdnJ5bBhgZDNIxvCY6NDZwFtaHiFWgjrY3GtLXTLBY3uCAYQfsPVTWo=
X-Received: by 2002:a92:c56f:0:b0:39b:34dd:43d1 with SMTP id
 e9e14a558f8ab-39f3786b5f8mr50739095ab.22.1724978483418; Thu, 29 Aug 2024
 17:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
 <20240828160145.68805-3-kerneljasonxing@gmail.com> <20240829122923.33b93bad@kernel.org>
In-Reply-To: <20240829122923.33b93bad@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Aug 2024 08:40:47 +0800
Message-ID: <CAL+tcoCXTwarrWpaZ8adVz9cV0FsROTBRHJS5v3YOtE0jJD+ZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jakub,

On Fri, Aug 30, 2024 at 3:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 29 Aug 2024 00:01:45 +0800 Jason Xing wrote:
> > One more important and special thing is that we should take care of
> > errqueue recv path because we rely on errqueue to get our timestamps
> > for sendmsg(). Or else, If the user wants to read when setting
> > SOF_TIMESTAMPING_TX_ACK, something like this, we cannot get timestamps,
> > for example, in TCP case. So we should consider those
> > SOF_TIMESTAMPING_TX_* flags.
>
> I read this 3 times, I don't know what you're trying to say.

Sorry about that. It looks like I really need more time to improve my
written English...

I was trying to say:
In this case, we expect to control whether we can report the rx
timestamp in this function. But we also need to handle the egress
path, or else reporting the tx timestamp will fail. Egress path and
ingress path will finally call sock_recv_timestamp(). We have to
distinguish them. Errqueue is a good indicator to reflect the flow
direction.

Never mind. I'm going to replace the series with a safer alternative
solution, which was suggested by Willem a few hours ago.

Thanks,
Jason

