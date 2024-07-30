Return-Path: <netdev+bounces-113978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411F894079F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 07:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005682842BC
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 05:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9457F166312;
	Tue, 30 Jul 2024 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imnt4uUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C7D161320;
	Tue, 30 Jul 2024 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722317411; cv=none; b=M1sXM+C5V/5sdZ6B6LFd7zOxo1uW4112L2nr7jcYavj1y1zjSSlH8IGLDY3qCSMARP9hQCKn6rG2FF7bED6E3+oVJFtoaxCnur05RiLNZJt60NEt+ZSwShOHUIb9EonIWC5dDXVTJ3pKWtlamfHak3H4HAtFstUV3i02YS1XQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722317411; c=relaxed/simple;
	bh=t/7aU9sDpYwQXeoJM1CArP5cEatPpjsDcOLesviOAhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YF2m3aEI4kX0s34PTP+47vRPzGkG7yrFTrnDqjYf0xI/OeLLKyzw6KLeCN3NcTi9n1+QYa0FAR2Y1gJ/FXUuYhcwsFHwYPiTZ7J8zX5mPYJAo1iUo4X/EldQBcHemUo6dNGVeI29LO9FHaynfYp9lzKPFNUDMdxUIqolRw7vy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imnt4uUU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42812945633so23585325e9.0;
        Mon, 29 Jul 2024 22:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722317408; x=1722922208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/7aU9sDpYwQXeoJM1CArP5cEatPpjsDcOLesviOAhg=;
        b=Imnt4uUUGMqkhwTXlQ+3oGaURaUAreu2VdHmu7zOpevAZIkaLfOIJ3sqzoGw7iXwgL
         ot51ixll0SrTQB71K+zwEyDrHt4+Ps53CwGJzCXlpixzu3y2gHRtRzaFKIHPv9bVj5Kp
         a3wOI8BOIuNQ3ynaSLZbTC3JNj2zpHMMCmLoEWbDj9/kDBd/8dELyb82AzXN1UPOVLpA
         i4yr9nPKd91yeZka8VIbRLoo27pxsmOrgV70tG/K5fwDswLeAYUXHkWiGJ884syaT5Ia
         GbZPGQ6Kv9JvmPRFgYq8aEMy3Gvktv+G1cMSKnO+ppBytBH1EXjz7tZFu+19AwUetrB2
         OSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722317408; x=1722922208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/7aU9sDpYwQXeoJM1CArP5cEatPpjsDcOLesviOAhg=;
        b=nXMXvsqMc7/a5jDsg8HMJZLL0RzRq5VUWWcpQx3FwgnXi1ps5s7jH2MY+RgNjWn99z
         gsFFbGLyH2lBBV8kU5Fq4MdWLaJxTQqr7n7sYlCvSUV3dkEoOnJP2vIjlgbRD5MlmnnM
         dfH711Z8VkTRSf7Oc7XL5MgCBqYpV2YspXTtOsukwYLCHQxjXSJjYzaW+b1655PSyJ09
         Ft2UKCfmBSTxLznKkClp7xzoPSHJ0drlk6LgdEWPOZ72c6FLJgL/z2eSjjIscUG7rgP1
         H+Lz1TYZVGJ313JcpSo/UKleg2q26r5KtaD1PYbq0J7tVmuRk+b9jB6TweTG/i1k0T7F
         FjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkAgB+dL2oWSL8QyCVJ8rRl8H68IpXWBq4oEA9gKa6D0hv/0pg+GsnEii9gUTLHdHwIj+GQfDws97NWSOCuz/ktnRTXpbfRLH/o/g3nKYgLlPlrrInE7o5ENYUzNOjYaEeMMsh
X-Gm-Message-State: AOJu0YywMIlA7/ZccHgn6OYpibl0kTL7qFoZSjMiwgq5WbdGIURCa2xH
	gCzz23h4mb9qgi/8egYJ1odN/Ldpq1BPWWjXEh2M/pqpKH9sJ5kknTQT0ZwktfCz/CHg3hJcCgP
	5G9zRfkpBKVvlUVEkq0JmoVTemKw=
X-Google-Smtp-Source: AGHT+IHFHRVcyzkdry4aJQCeC/O2MYafFRyK4dAEMqxvOWlqfqEifF0pIrhi4TgeD3Hldw/g6fzElAg6Io6qXofmcmY=
X-Received: by 2002:adf:e585:0:b0:368:3f6a:1de8 with SMTP id
 ffacd0b85a97d-36b5cee4ce8mr6504099f8f.11.1722317408110; Mon, 29 Jul 2024
 22:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729183038.1959-1-eladwf@gmail.com> <ZqfpGVhBe3zt0x-K@lore-desk>
In-Reply-To: <ZqfpGVhBe3zt0x-K@lore-desk>
From: Elad Yifee <eladwf@gmail.com>
Date: Tue, 30 Jul 2024 08:29:58 +0300
Message-ID: <CA+SN3soFwyPs2YhvY+x33B6WsHHahu6hbKM-0TpdkquJwzD7Gw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net: ethernet: mtk_eth_soc: improve RX performance
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>, 
	Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:10=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:
>
> > This small series includes two short and simple patches to improve RX p=
erformance
> > on this driver.
>
> Hi Elad,
>
> What is the chip revision you are running?
> If you are using a device that does not support HW-LRO (e.g. MT7986 or
> MT7988), I guess we can try to use page_pool_dev_alloc_frag() APIs and
> request a 2048B buffer. Doing so, we can use use a single page for two
> rx buffers improving recycling with page_pool. What do you think?
>
> Regards,
> Lorenzo
>
Hey Lorenzo,
It's Rev0. why, do you have any info on the revisions?
Since it's probably the reason for the performance hit,
allocating full pages every time, I think your suggestion would improve the
performance and probably match it with the napi_alloc_frag path.
I'll give it a try when I have time.
You also mentioned HW-LRO, which makes me think we also need the second pat=
ch
if we want to allow HW-LRO to co-exists with XDP on NETSYS2/3 devices.

