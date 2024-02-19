Return-Path: <netdev+bounces-72820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F8F859B87
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 06:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497961C20A6D
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 05:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA98B1CD1F;
	Mon, 19 Feb 2024 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGmPZXIF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227A28F7
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319316; cv=none; b=WYtyKSmYjb9GvhP9GgdEU6XjJP+/w01c7QSuRDqedjDV9W0aM5i2tohzvTSjnM4uuOTRkDiGS1PVkL/hZEck28aCl/Bq612OSe8Tsd+mgO835LnHfxgnvQsJKrSqY/gpBrx9ntHZeDB5oESJZ+fN8L0VS9LjAeFCAmDbdU8gmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319316; c=relaxed/simple;
	bh=6ZkJ2wZmonf08x7C4OWJKATJq8sZbtjaO2dLFVFALVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ni3atjQky3H5qloqEdKcndnrnpfFl/caZvFL1aW+eMInxqvhQRLlkfGME3wk0ArCTugGX/htUh9Colzj9pQLnQjxp42dYJST0CI/k9iP4g5gcpeEDwtHJZcCJ9ajIWax7pC818imiEGJ4t5TOi8Xs8FtkF3Tc4UaafI+kRsKp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGmPZXIF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso583846a12.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 21:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708319313; x=1708924113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZkJ2wZmonf08x7C4OWJKATJq8sZbtjaO2dLFVFALVs=;
        b=dGmPZXIF4T0NeLLpK3ixGpPNGt0UyZkTeQ/ZIkH8FrjSGgBVuGCtCSZbT0wJaVGNi0
         MiaLb8u33wJdCDW5W4NrwP+Ek3bbI7yyyIXehrGVACD1ZgnuJNup3fzE+xSjogHeeqhd
         L2wBDjLF151BPuaWQfjcxm/Noz8DPlA15n8aI2Li4SXlY7jXxevRkLeUusujF5p4yc+g
         srH8oZLuKeXRAQ024UI0kCGXXeakJmI3hFT6YdJEC9tGqiyPk7rChCn5rzfyyrlzJEaR
         zFNbzcvUQWrDnfiT3Qia/FEuB219oIWckVDrS9h4GNviQTuxwF2PEK4Z4r8HIu9wPzhW
         iIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708319313; x=1708924113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZkJ2wZmonf08x7C4OWJKATJq8sZbtjaO2dLFVFALVs=;
        b=O3JA6XcmtnZsrhB92vVhVNfgTeSETNf5Qe6pDvNhIKqVFXzWyex5JfjZD2ZYwh+5C6
         a7xHu9ncilzg8sg32OZJJOC55oaGv69U41aIsMCMj0UjG3XWJAiHbIJwWObDVgsDuVbx
         fDdoDjgB0/oiISnV3AVC++SBtD1iJVbmDrvT/kS0jqWfkzNF1ZoWl6MBIfcbQpwyg31h
         8I2N8NTtI8OhehqUXJTRd3k3OnAa8SFSvRUzdwzPS23MK64UQ0KVXtLSjk7IuZ7XiC1J
         /Z0H/w8EzuA6h7JZGS2vkm6VoWs3guEfZ22Hd1Za4J+L+zIYgXNracIhE28n+ZdoZfJL
         rnpg==
X-Forwarded-Encrypted: i=1; AJvYcCUAt3IJVUAd8cjQTRsnlVevWg/KIaG6EwhpSak1FDLompjnKVnuFCR2Ztka3BdywuCoZAc2FRzeA3FKoMGrVZom5cc7BEpl
X-Gm-Message-State: AOJu0Yy1rveujOqHgAZPagJ/RYa3nIzE67K4qTme54fzpT3lJ7tui4aM
	/VWynFonBYS7RndOr50TPv4LRzEUTxe63s7Vtcyob3IxaC9iAny3+T96kMlRBbUxyK756Ae3jEX
	s6N92ic+tsXq8TMhmHbahkNnPvAk=
X-Google-Smtp-Source: AGHT+IHtl6tuLYoSraSQZ3ok35NWMGdINB+nMo01+oZf40aUSoC2ZXJdZiBhpsoZ2AYsLGG18cRxWiVd7+TnolDSEls=
X-Received: by 2002:a05:6402:2cb:b0:564:7074:7431 with SMTP id
 b11-20020a05640202cb00b0056470747431mr1138400edx.14.1708319313443; Sun, 18
 Feb 2024 21:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219032838.91723-8-kerneljasonxing@gmail.com> <20240219045447.99923-1-kuniyu@amazon.com>
In-Reply-To: <20240219045447.99923-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Feb 2024 13:07:56 +0800
Message-ID: <CAL+tcoCr7Q4TUwmXPj2NZVBK=q1xVkpuH0a6ERmxZHQP8k2vxg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/11] tcp: add more specific possible drop
 reasons in tcp_rcv_synsent_state_process()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:55=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Mon, 19 Feb 2024 11:28:34 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch does two things:
> > 1) add two more new reasons
>
> description was not updated since this patch was split.

I checked that since v3 patchset the current patch has not changed.
The description from my perspective is right because it truly adds two
reasons in tcp_rcv_synsent_state_process().

The first series in v4:
For "patch v4 [1/5]" - "patch v4 [5/5]", they correspond to "patch v6
[1/11]" - "patch v6 [5/11]".

The other series in v4:
For "patch v4 [1/6]" - "patch v4 [6/6]", they correspond to "patch v6
[6/11]" - "patch v6 [11/11]".

>
>
> > 2) only change the return value(1) to various drop reason values
> > for the future use
> >
> > For now, we still cannot trace those two reasons. We'll implement the f=
ull
> > function in the subsequent patch in this serie.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>

