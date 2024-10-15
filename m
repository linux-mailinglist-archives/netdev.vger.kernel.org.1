Return-Path: <netdev+bounces-135452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9D299DF98
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2F8283C53
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F991AAE2C;
	Tue, 15 Oct 2024 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckw0BXoP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37A17334E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978440; cv=none; b=rQxsbk8MTRDwDws98EcZZwLiGEeK+xib5ITy5U3rJaxiACPONZqUn6GwhHHGG55L3VchihunCOkM69qTI9T0MQvZel21PlzBofq8PHjyJgoI5BF0bcsj6NbK5D6rUfPsN7Ys/dj+lBBr+LdjaYsN2g6C+VyUG7icBB/tUNQZIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978440; c=relaxed/simple;
	bh=+Ej1MNiBqld9sr/rde/khIhq0J381uRG4buKgfobWSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkF+CVRjm0wkJvLY1hxlyrdbH1Hyc1g/g4ymkEqqtP/9RViQDqwQceZuuRL3cl7zBKUAWsHMhZYSL1pcZFBfvDwdOn/xilBmRlaSFqo8pxa4NKk6XOHDsoVRS6I5PaRwfVsOTVviwEo5P6tcmLJQqG4mp2m/Cii/DOYq+baK0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckw0BXoP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a14cb0147so209216366b.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728978437; x=1729583237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGTAwWYylrgHxys3J7g7Oj8BY+b7ECipEcgHj47PxZg=;
        b=ckw0BXoPwqSakKCCbSFQMVYHsVK4NLgJf2u0hZZa7aJuFVbuoRfeJt/TZzfXySaaCq
         UP1Az4aNkicI8l6K0PNLLrJWJled027jM9HgMNagQOOqc+rIRy/xBNAcPQxoRmNzQc17
         RsljHRjEdoDpG9lZjS2o+bkS2n4QHZPC+Hg2xCO+DZ+ijBOiwkxbPBCBGn1OrspTHtuS
         j8C4tkxj3KH1kPG1l9PhkN904TgKPlvMfryPnBEDuZedL0ht6Ctg4QCciXs0Hk6BYME6
         q4VxqsLE1n+wMAo0X7XEsj7gG8eEG8tTV1EHii7MnQJYTDvquSJtAj6QZ2WyxqORuK5N
         BIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978437; x=1729583237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGTAwWYylrgHxys3J7g7Oj8BY+b7ECipEcgHj47PxZg=;
        b=gPBsWKd9sDmd7mKCkDC7GUmccxsF2iWeSD3Iu1CIIYau0HEpQ2ckxd6gvpZzP0eKPZ
         1Lyf5rpauXdq4XFeTkQKqxjWKF7rLDyeTlZNgPixp/6VDHda5LSL4e7wPoxRthkTGDaD
         zi5KK9Gp8UseEuYXGhOFNmGjqBkhTnT9tUxFvzXV4B1ujvGdsV9n8YV4s4tu5SHAa3hJ
         LhhXwxgMk2cqPUGC3c+6nuI6Rbo8Lzq5pWtkjCm1pQrUme4JVpwOAOhstsqv8NQ32nvX
         do4j6CLTf82UnRWssxZCaKGnH97THIO0zE98qN3wyDEWkaSUuYOxpuGT6vtOqqzEu0Uq
         Bzgg==
X-Forwarded-Encrypted: i=1; AJvYcCWYXP86WHNLLVMjtjpCHLjXEWujLsTzeUF3IAyMesMtNBWUNVpw/pMiH18bdbkg12+xTFziRZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1XJ8ZwY7yS8XkagKQ7L0wfcZ/7aIPMZ9g9zs7GCl7YaFxsMN
	ETkTqZJC4lPLE8vZD/1ozAhrpaJczgzO7thATZjagBqkCWeUuQ/GHF5gxm4qgSYb3cZRocX6VQL
	rRe98MgumGHFxOChuaxSrOkMrohLfD3NBlphd
X-Google-Smtp-Source: AGHT+IHOWVLnPX4C3QWmkZye9E646q8g8t2prDsYgVCykbq1ehRGzgpHCukbcmwC4labaeZy8W5xKeFOMAJpBJdxCWE=
X-Received: by 2002:a17:906:6a14:b0:a99:ed0c:1d6 with SMTP id
 a640c23a62f3a-a99ed0c0ac9mr795036266b.49.1728978436290; Tue, 15 Oct 2024
 00:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014144250.38802-1-wanghai38@huawei.com> <CAMuHMdVsagE1HMf5aLD_ZrubocY_DqX-UrTLxiFOMT+kwVhysg@mail.gmail.com>
In-Reply-To: <CAMuHMdVsagE1HMf5aLD_ZrubocY_DqX-UrTLxiFOMT+kwVhysg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 09:47:03 +0200
Message-ID: <CANn89i+Srr=M5+f0PbLs1OrWtOPNYULopNS+6-dy6EYNX8Ua0Q@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: rtsn: fix potential memory leak in rtsn_start_xmit()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wang Hai <wanghai38@huawei.com>, niklas.soderlund@ragnatech.se, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, 
	zhangxiaoxu5@huawei.com, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:58=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Wang,
>
> On Mon, Oct 14, 2024 at 4:43=E2=80=AFPM Wang Hai <wanghai38@huawei.com> w=
rote:
> > The rtsn_start_xmit() returns NETDEV_TX_OK without freeing skb
> > in case of skb->len being too long, add dev_kfree_skb_any() to fix it.
> >
> > Fixes: b0d3969d2b4d ("net: ethernet: rtsn: Add support for Renesas Ethe=
rnet-TSN")
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
>
> Thanks for your patch!
>
> > --- a/drivers/net/ethernet/renesas/rtsn.c
> > +++ b/drivers/net/ethernet/renesas/rtsn.c
> > @@ -1057,6 +1057,7 @@ static netdev_tx_t rtsn_start_xmit(struct sk_buff=
 *skb, struct net_device *ndev)
> >         if (skb->len >=3D TX_DS) {
> >                 priv->stats.tx_dropped++;
> >                 priv->stats.tx_errors++;
> > +               dev_kfree_skb_any(skb);
> >                 goto out;
> >         }
>
> Does the same apply to the skb_put_padto() failure path below?
>
> drivers/net/ethernet/renesas/rtsn.c-    if (skb_put_padto(skb, ETH_ZLEN))
> drivers/net/ethernet/renesas/rtsn.c-            goto out;

In case of error, skb_put_padto() frees the skb.

/**
 * skb_put_padto - increase size and pad an skbuff up to a minimal size
 * @skb: buffer to pad
 * @len: minimal length
 *
 * Pads up a buffer to ensure the trailing bytes exist and are
 * blanked. If the buffer already contains sufficient data it
 * is untouched. Otherwise it is extended. Returns zero on
 * success. The skb is freed on error.
 */
static inline int __must_check skb_put_padto(struct sk_buff *skb,
unsigned int len)
{
return __skb_put_padto(skb, len, true);
}

