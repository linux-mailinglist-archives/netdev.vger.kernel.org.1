Return-Path: <netdev+bounces-88557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21248A7AC0
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 04:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680E01F21F7D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 02:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3B063A9;
	Wed, 17 Apr 2024 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpSEX/mG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF041FA3
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713322443; cv=none; b=EFEAXDFku9n+CLyMbwSRnMqyrSO4a3lcEErT/4dVNTEuYLteX/qNhQ/brYzLWwfYD1zR0vOzyb7XZCG9MD160sN7yG+heMPxGvHquXBAUaPw4Xawbx28leaaBuxtoDXOsZPj02IsrYPxBC4iw5d1XkPJdd31RaAhnOdZAewLed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713322443; c=relaxed/simple;
	bh=avphAe2kkfvHzKls4jrz6Bq7fhTl4iSFQ0jw4sDwTvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/l+DRTgughQNoxZ/0NA5RaBGAsk0lYeTQbjG7H/RNerwJUul1nqVk2pP8IsXDF9CnGdyqL4tje8fWZZYavZPR1iSSTPkyxSifDCuQwwKt3Z7GGelwFTuxLm6T0uBbZu6xoYrMaBFVfUy66mqCAkGhVbxKQP9gun6+9/OFsiGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpSEX/mG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso647040066b.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713322440; x=1713927240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avphAe2kkfvHzKls4jrz6Bq7fhTl4iSFQ0jw4sDwTvU=;
        b=DpSEX/mGqhiA5qy3kh+/nariih7h/rt+S18N5qDnxywbUMRezA8xX3gDONjXI2/iw8
         sjSnePnRobxlU4P3gljDumt1EEgaGkjvfetL2iOsz3bBWpgI7SRxG0987PNuRnuRhgeC
         1MDSHKMHwCYKGiiNGqwJR4+OnPH0QkGgNqxsLCsrGDEe3wjM6NksQ0RFqMbOQup/OGmU
         erUhtSh26NJjEQRN4ZvGqBWnofl8xcT37f0lyQL7o15FwnNLuChWLh1Of3WwsMqBdSWp
         nifEcg04Vv92rmLuZJv1NkoL2lnno8Alm4P8phYzjorG/Tv9WYVWOAlGsKjO+lot1lKH
         eqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713322440; x=1713927240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avphAe2kkfvHzKls4jrz6Bq7fhTl4iSFQ0jw4sDwTvU=;
        b=CeQRtnHxmm0lNTrJY7GjK6aU2SzJDkZmOMhB3YFBbJWr7yAW4Z3JK2rFtuh7/uyEzN
         yo9i4J/BYjm9UK/6Az4n4WL3MlDgpkcQLQ4PUL/T/hB0scKI9wzJ+rigH39lfeiGyh+g
         4PCbgH+XMZ0XJrS7FRxsjRGsCtNN8lq5uqzdTyWxzjJZFUKSjHLD/xgp0bSkjgUanZGB
         t3qblo+LT8kfadAWrUdZFveYTnzW05EZxgiE8djtJltNHst4meN+WCac69Eu2gz5T5s5
         P/dHyC38gDEnIyPB/Colj7CX1JLbiqSiIMYO5KJqumn7fMGusepR4QV2Kvs0UtbCmPWW
         FZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU65zO4C8z31BAZspDsg+LxQvikfPveXul7bVL6dLpXi/oSzmioM3vYqQg5Bw2xInloT5lKbbnPYlnSKH8OOZjSJ22Gh9qQ
X-Gm-Message-State: AOJu0Yz2yGRquLHKSr1/esd7JNgbw9ZikcJGf0sBFANXunY2VF7ZZbok
	vs0KlooZx5n/MSk7n0xW+cquFN+II7GukECzgxRNnPZrs22ez5+loOCBzd0w+GeHNQldTw0I3nO
	EEc3pUa9L5BfN2hvcQlrVYUDuAPn7iTLY5ps=
X-Google-Smtp-Source: AGHT+IHgOytto0UtLgXXbpiyxS4wjrTtDFhU0uzHXJ/wB41RreYbGQMD0cKk3LQLqb2NzrmxF34RUmqjtedT1xaGbL4=
X-Received: by 2002:a17:907:7b9e:b0:a52:2ee4:def0 with SMTP id
 ne30-20020a1709077b9e00b00a522ee4def0mr13078612ejc.18.1713322439648; Tue, 16
 Apr 2024 19:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
 <20240416173836.307a3246@kernel.org> <1abdb66a-a080-424e-847d-1d2f5837bbc4@linux.alibaba.com>
 <20240416192952.1e740891@kernel.org>
In-Reply-To: <20240416192952.1e740891@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 10:53:22 +0800
Message-ID: <CAL+tcoDj11Y7o2f0Eh8-FMk0BxjtAwCupWaW7n7bOXTUVgAWSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Simon Horman <horms@kernel.org>, 
	Brett Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jakub,

On Wed, Apr 17, 2024 at 10:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 17 Apr 2024 10:22:52 +0800 Heng Qi wrote:
> > Have you encountered compilation problems in v8?
>
> Yes, please try building allmodconfig:
>
> make allmodconfig
> make ..
>
> there's many drivers using this API, you gotta build the full kernel..
>

About compiling the kernel, I would like to ask one question: what
parameters of 'make' do you recommend just like the netdev/build_32bit
[1] does?

If I run the normal 'make' command without parameters, there is no
warning even if the file is not compiled. If running with '-Oline -j
16 W=3D1 C=3D1', it will print lots of warnings which makes it very hard
to see the useful information related to the commits I just wrote.

I want to build and then print all the warnings which are only related
to my patches locally, but I cannot find a good way :(

[1]: https://netdev.bots.linux.dev/static/nipa/845020/13631720/build_32bit/=
stderr

Thanks,
Jason

