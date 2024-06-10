Return-Path: <netdev+bounces-102227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A0C90201F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA1CB2342D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7D78C7B;
	Mon, 10 Jun 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzzznmvk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64016FC01
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017671; cv=none; b=XxGewIhE+rx7Mhg0LjWC40xAt/hZdPl78E2Gs/DdTa33QP287FUn7qbu/ks3c9EyCu0CoHY1is1cbqTEMQYRNAMKRtjCUGQ/cC9CwOn+iJXLTp0OMU+3XdDNof3LmNjfHpRNIVQlq4EzC8e6LHapJOwPAvV1PMH8p1gopNr+q4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017671; c=relaxed/simple;
	bh=VeL1eAGkwPTSuPFp49S/x/nSdR/3Q56yuwmHdmeuYR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doM6CqtJmsJV5x3K8d8IPkO1/e7E7ITc9CJO/C/o54Yg7GBDkmgpwtrRIi5uyOVBQQPT1C27YYCd0OI3Am231V2KXHGv91ZyBdJ9miOUi82jZ0+6DowxrEoF94ZAJOHu/48o+hYoe5z8gqO746d6R2/MNTJbhBesQyMIHvgXcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzzznmvk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f253a06caso55187566b.1
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718017668; x=1718622468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeL1eAGkwPTSuPFp49S/x/nSdR/3Q56yuwmHdmeuYR4=;
        b=TzzznmvkUHJG7AZgjkVNuied7hLhbZ/272WRhk3zGEPuZZeP51n3mlj9+kwH/Kzj2J
         H/Ou/YJ9JJVl6evTybM35grGWqNmUzSfDPRLdVcRoVLaREJUM4lmcbcLymoGuQ7dIc81
         XsHjXZ9nzqS0ulasIar/IHbBBGYUzc63Ec3MpgM6BzgWpSlDsklg4WsZngbi1BGf/UBX
         WVcmFwicRAFv4W9NAHXYO7j3yjqZ0nNm9cEeP+0iS3kGTNo4QIAkA0rFnAD0I7T/2g7V
         li2FuiV8vo+6sKeDFVl7c/Pq36Yfy8MjIKu+c9PX5BPhYLcPWCNojaT18w8CBi+buDs3
         ui4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718017668; x=1718622468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeL1eAGkwPTSuPFp49S/x/nSdR/3Q56yuwmHdmeuYR4=;
        b=t/N7GfLttQq56q2hL90CNN/3PiXD4IgR5ICXCa904c7/WebSbrab8qx8tVoz7sBJFk
         gaFnkYsenzHlFQRlhsXhLbL/d/RFfHDciTX32RC9qkgkIZuzlMnYNbnJ2ywSjRzf5/aM
         N6xwN6cAjMbYQWyCcCaRXLw/THdZkRxxxqOyS9LEM5dClUK5JrKP+PhQAAtGFF5mluKy
         Q+TYkfhPRfDb2L8MW7d5lZwCJnXGZIfw0ssop7qnXlTujpsSzzwlyrUgca2cXfRMQt5b
         T8rNwEmEZZxA+zaC9D4zRmFgT2WmcyeGYJt8Ui6G2q7wwSDJWbQWDA4FRDq0l0OZf/p7
         /50w==
X-Forwarded-Encrypted: i=1; AJvYcCV/i+Dgt2bBR4s4ERGf05kGgffxiByrLzctEvdh7QvLiTPFcpxQEmL4aTpASSQZ1zvuQjh+9qlXlg1/lyk8q60OTKCXufAn
X-Gm-Message-State: AOJu0YxmkBJ/1Z4C+vSsonL9sXSYJBV9tv8+bKGP0Y9ow5Zl/4IWTfxi
	w1n7TaEZb3C7cDKGKisf0jEu0hNMAbx/PZzhJvqJTqpPFkv8w20tp1QXhG34FSsP0XYOJmpb2+1
	HEgHSPmiNmnI/DoWWHbr2PZ/W3Aw=
X-Google-Smtp-Source: AGHT+IEGmHRVjTV2SWd1PxnIUP3bTlQVheGFp5FcHD1mbIzOSVjNCmHYZhuM2yPsyPCoOJYI9rlBxlHa8tulDKtIRkE=
X-Received: by 2002:a17:906:2e98:b0:a6f:2de0:54d with SMTP id
 a640c23a62f3a-a6f2de00b91mr58373466b.76.1718017667543; Mon, 10 Jun 2024
 04:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609131732.73156-1-kerneljasonxing@gmail.com> <ZmaeNfHr-D5jTsq9@nanopsycho.orion>
In-Reply-To: <ZmaeNfHr-D5jTsq9@nanopsycho.orion>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 10 Jun 2024 19:07:09 +0800
Message-ID: <CAL+tcoB1B2_4K2_VGeTG5oOa0Hjds1OJeCPusKzNzjhzF==_dw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dqs: introduce NETIF_F_NO_BQL device feature
To: Jiri Pirko <jiri@resnulli.us>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 2:33=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Sun, Jun 09, 2024 at 03:17:32PM CEST, kerneljasonxing@gmail.com wrote:
> >From: Jason Xing <kernelxing@tencent.com>
> >
> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
> >BQL device") limits the non-BQL driver not creating byte_queue_limits
> >directory, I found there is one exception, namely, virtio-net driver,
> >which should also be limited in netdev_uses_bql().
> >
> >I decided to introduce a NO_BQL bit in device feature because
> >1) it can help us limit virtio-net driver for now.
> >2) if we found another non-BQL driver, we can take it into account.
> >3) we can replace all the driver meeting those two statements in
> >netdev_uses_bql() in future.
> >
> >For now, I would like to make the first step to use this new bit for dqs
> >use instead of replacing/applying all the non-BQL drivers.
> >
> >After this patch, 1) there is no byte_queue_limits directory in virtio-n=
et
> >driver. 2) running ethtool -k eth1 shows "no-bql: on [fixed]".
>
> Wait, you introduce this flag only for the sake of virtio_net driver,
> don't you. Since there is currently an attempt to implement bql in
> virtio_net, wouldn't it make this flag obsolete? Can't you wait?

I admit the way of introducing a new flag is not a good way to go, but
I cannot figure out a better way. I'm still thinking. Virtio_net
driver, I think, is not the only non-BQL we miss in dqs.

You can keep trying sending BQL patches for the virtio_net driver but
they don't conflict with the current patch. Can you guarantee you can
smoothly introduce BQL for virtio_net in a few days? I have no
confidence in your recent action about blindly deleting old features
and introducing a new one without considering the real world, I mean,
the world outside of the community. They are thousands and hundreds of
servers running outside. You have to prove deleting an old one doesn't
harm the users instead of asking users to prove the old feature is
useful. It's very weird. The key reason is about whether it breaks
userspace compatibility and how you handle the compatibility. For
example, I don't think kernel developers can delete some old proc
files even though they are buggy/inaccurate. I'm just saying what I'm
worried about. Let the maintainers decide finally.
+ Jason Wang, + Michael S. Tsirkin

Let's get back to this patch, I think actually it is a bug we need to
fix since netdev_uses_bql() decided to limit non-BQL drivers. I'm
still thinking, as I said...

