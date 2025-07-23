Return-Path: <netdev+bounces-209183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D0EB0E8B6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170703A543B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676F1C2334;
	Wed, 23 Jul 2025 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2sQ0t69t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A719C54E
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753238206; cv=none; b=Conp4s9M1A9tm5RR1K/beU3kl1feO1NhL+eMMCbRy/T8ubVgeQQn4uaCSoznXUwipoW4WIWL3amT/GeNZCWMi49+m+Gp0woBtkXA/GoNp0R/b7ssFvWEt/d1/KkJc98sOMeJqj+WN8jVoQj3xxhX1BznZOipbKNHti6IJhMWY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753238206; c=relaxed/simple;
	bh=9F/qrer0YHOOzf34SvLjL1tmn8PFnQdDB52YTfxHz6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAQ7zQC5wRxXMsseDR0TBCEqzuPp6+KPfWHmEFZfdTRCRdQPZ1OBAY1ADMpDTsUQkyJwKydZaHAh76qo/tR9dCRybwNaLEfF6Syy7axEcG0jR5DGMav0bNpZFICn8YPxLdhslLpIk4PcBtBgyeYsJ8qL/glN1rFroQVkq6rQrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2sQ0t69t; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e389599fso121975ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753238204; x=1753843004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkcawzErsKetlruUZ8nxtm75KFIUDxv5f5CiaoAi4JI=;
        b=2sQ0t69ts2q7iiJh5ymCTGITFQCmM1Gk3L9Y2gwRR9ARX+J7MYMG4efmivGX1xeWak
         SVDNwtGrViSg/Aa4DDPEsgsEaM+M6Xkv0BrZYkp1TL2wRRYmixk93OP3+DIjb9/K812U
         S/zs5BFwmdjUFq4ok28ZKaP7Twcjhx5THeaZ++yUXisSfpY1p1NH2KPL5Uv7WMgKpJkk
         vsiSfXw3UkXm6d3PPxEBNhQricO2dmozNIzWtVsMzmGPnA+gmn+fFgsiApWXpp+pfBQF
         HZbDFDRNnhfAmkRsFM22c17KbyBB7JsUZ5UKUH2j3w8g4QsjP/7tHUrkcalbJlPaYPCv
         XDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753238204; x=1753843004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkcawzErsKetlruUZ8nxtm75KFIUDxv5f5CiaoAi4JI=;
        b=vGi0RaUe1Ia5wL7ZW/pWMUlKnVjxxib+Cimx/V3eBgG0Gdk1OASh/7rL8e1IDaNiGo
         f1a1vhXEB24rdtIyOQuYsXbGB2UbqW+J5NhnI/cIrue04QeqfV5jgmRwCXa/2bDaPRfc
         tonLs4566fyT2g3z+Ki4WDvz7GorS6X2ubvamTq8pQHFxAF2htWuTLtoi1/ouhXw31CC
         PBslkC/Gk7XKB6PkV63ClzodaX9EiCQ7xg8j6J5vjySf2rd03JVl8WIG4GzMjgd2sZ7B
         qV6494laQ4qsndW7MH+N7z4qNdOgbl1AktxIuZSMJ3aN8vhg9R0YfaRNV4FGsiHISlHX
         poMw==
X-Forwarded-Encrypted: i=1; AJvYcCUm3qri3cQxxu4GHIap4DTTjgx2qzKOYhfJMykC06mT/ajs09rxEa+r9rWV9cQdnNj46BC7fvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfCbFBOFs303ra23OVBp486JJxvBmIM1Zf5HOvfRJDzA+FEQFL
	m1F/3YXUSYAPQO6gCWo2fmf+100YfeLHDWMjOKHdP/ABMdoxW+7byXw9W1yz5nZWbi34PLoDnYN
	0zqaTQUm6UoePGSYUrZZ2JCHd1bRwbBJxsxjE4Rnr
X-Gm-Gg: ASbGncuTcyoLFEF2DBVTm8CVj+NH+R9cp14t9gF29v1hCQzxJxEYTshA3nwlXkPfz5O
	d/t4nvx0McJCfbwqnEnQKHd0t2/PSagixLC7hKAVYy8mTOe6NXBHdyKrO8M5EBIp+tBDP7OgYOO
	qclTkFq+498ab3ufojiNpUWoxvj4OM6h20zfeIiWrGGdm9KXwxYnjJ456J6UZJhO1wO/NEiEssw
	v5z+7UWrc9D1CFNGTy6HuXmS7EXmNcjGfUg9Q==
X-Google-Smtp-Source: AGHT+IE/f5gMKJQecCvU4mwpZfVLxyBC1LLMi24CZwRjawgIkPvTTYzKJPAAZ/WiT4xQybYn47Hhesu7cmfqaRxP9oQ=
X-Received: by 2002:a17:903:e8b:b0:234:b2bf:e67e with SMTP id
 d9443c01a7336-23f98dc9378mr689295ad.13.1753238203211; Tue, 22 Jul 2025
 19:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721233608.111860-1-skhawaja@google.com> <20250722183647.1fd15767@kernel.org>
In-Reply-To: <20250722183647.1fd15767@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 22 Jul 2025 19:36:31 -0700
X-Gm-Features: Ac12FXxFUdV4X9GigSCMTo9FSOpAt5CY4_7t0vjHnnZXCDiEjiwsp_8EEjx-bBA
Message-ID: <CAAywjhQN4Re3+64=qiukq1Q2wtLBj2pesaDSsvojK4tDAGHegw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Restore napi threaded state only when it is enabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 6:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 21 Jul 2025 23:36:08 +0000 Samiullah Khawaja wrote:
> > Commit 2677010e7793 ("Add support to set NAPI threaded for individual
> > NAPI") added support to enable/disable threaded napi using netlink. Thi=
s
> > also extended the napi config save/restore functionality to set the nap=
i
> > threaded state. This breaks the netdev reset when threaded napi is
>
> "This breaks the netdev reset" is very vague.
Basically on netdev reset inside napi_enable when it calls
napi_restore_config it tries to stop the NAPI kthread. Since during
napi_enable, the NAPI has STATE_SCHED set on it, the stop_kthread gets
stuck waiting for the STATE_SCHED to be unset. It should not be
destroying the kthread since threaded is enabled at device level. But
I think your point below is valid, we should probably set
napi->config->threaded in netif_set_threaded.

I should add this to the commit message.
>
> > enabled at device level as the napi_restore_config tries to stop the
> > kthreads as napi->config->thread is false when threaded is enabled at
> > device level.
>
> My reading of the commit message is that the WARN triggers, but
> looking at the code I think you mean that we fail to update the
> config when we set at the device level?
>
> > The napi_restore_config should only restore the napi threaded state whe=
n
> > threaded is enabled at NAPI level.
> >
> > The issue can be reproduced on virtio-net device using qemu. To
> > reproduce the issue run following,
> >
> >   echo 1 > /sys/class/net/threaded
> >   ethtool -L eth0 combined 1
>
> Maybe we should add that as a test under tools/testing/drivers/net -
> it will run against netdevsim but also all drivers we test which
> currently means virtio and fbnic, but hopefully soon more. Up to you.
+1

I do want to add a test for it. I was thinking of extending
nl_netdev.py but that doesn't seem suitable as it only looks at the
state. I will look at the driver directory. Should I send a test with
this fix or should I send that later after the next reopen?
>
> I'm not sure I agree with the semantics, tho. IIUC you're basically
> making the code prefer threaded option. If user enables threading
> for the device, then disables it for a NAPI - reconfiguration will
> lose the fact that specific NAPI instance was supposed to have threading
> disabled. Why not update napi->config in netif_set_threaded() instead?
I think this discrepancy is orthogonal to the stopping of threads in
restore. This is because the napi_enable is calling restore_config and
then setting the STATE_THREADED bit on napis based on dev->threaded.
Even if restore unsets the THREADED bit (which would have already been
unset during napi_disable), it will be set again based on
dev->threaded.

I think napi_restore_config should be called after setting up STATE bits?
> --
> pw-bot: cr

