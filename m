Return-Path: <netdev+bounces-226896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2822BA5FFF
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 15:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7BA1B2398A
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB72E0B79;
	Sat, 27 Sep 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl8taeLZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BC1DF73C
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981373; cv=none; b=lcYWbRSfJn8su+NCH4bjO9sVeGAf+WFFh7mZMvrMnmRFYDXKFF/Hvc2lL5bjhbVpH4l4rJ5Z0JCRssDXk2PpAeM9U83qIJHVlhjnIjqQlXmE/Z52c6cqymklCJ4pGYKRlW00IjnDwSH1REMvBwW5TbeyZtzTvRN9c0qaEGICJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981373; c=relaxed/simple;
	bh=ureChU45nREqUmvZTTVk+SwNTIJzvHOY5zs5cEzl+t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6rrMsSKzRe+aW7hsm1gsiDCZmaj+rslcgMpXUIzU5WhWkrHXfUvnTr5IUxdvRvm2bWQq4zi+SiRge1/Mf/O57XYuoxunrRC/cOM3fbPF/W7tRjkttO6I7bqspNPox80WPmw9oZzjXkbeZ112gtoBNNOIh2LX0OAK0/H5nMfw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl8taeLZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso20621485e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758981370; x=1759586170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ureChU45nREqUmvZTTVk+SwNTIJzvHOY5zs5cEzl+t0=;
        b=Wl8taeLZnSuAkaYOcGiWwHKKI0GkeDjdflDaWh6frmYQL0Z+k0Xx3jt3oZUPBO2PqF
         98avA75obFkBGIjilt9vyuxg1DdCi5eiI0RN29bC1O3+2BOewamOw/Ff1Y8evzLlX5Ln
         eOI6Axl76EKmWtoitIKbIDFVB70ixzJ4AJrqQNLXYjq9degIA7/ybCmsXwt1qb6QS8tZ
         kcsqJBgXoL5Nph4MZ7ld9jxvW/lmD2u6bOU6wOGhdctGysb1alze/Ijnxyr/jcD0Phjs
         mvdJG0EDXfS9RaQYlmg7AvXfTSQFB5lDfQjcn8weyOwqNvjftEPUMqvxbcYg3uB5k4vc
         fU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758981370; x=1759586170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ureChU45nREqUmvZTTVk+SwNTIJzvHOY5zs5cEzl+t0=;
        b=qY05zL03ztsJsohfna/bm2YIt90UxhcRNNvpO97obbjyfgetsA8kWPJJqF5lLEIb7f
         27luuU58N2tw/KRS7OAFTghOpqyaKd286sYPUik72txhOVh0ESgyRILqyGZADkETW6Jm
         yosT0XkLrR5ujr6c+Htz+SbYy2/+6H5KgV/if9qU8LJpaSYjiXjcQQekOMJG8MOj4H0e
         l0p2SdqxDi4WFWapw0ZaIPOS+aE4KQqnb0zpwL4AtuDJndL34znvtN1flNr7tfSZfO6C
         pBW7nErd5NDAsFSCFVxhrKYptBdMO5EXwxfxCQ/M/5/Tx1Nk2Hf3qC/FZaBByDQK+Btj
         NLIQ==
X-Forwarded-Encrypted: i=1; AJvYcCURnVo+X0rOMpjZHJFeGpuicjUI6Ji0YLh+btdDEwU4pZtVmkNKNvqLgm+Pb+sfWnf0MLiEPzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cizuc8dAsvanJy8sinsnm2zz4e7XINmW6KWqDqrkVzEn7LKn
	YcIQCb5+NRJ2Dy1TWVfP0Dm3uRJ5rKroPX6CHC8V0pKQMUMOfu0fuSQUziX35MQC0EMGxjfRv6y
	DnonFiMFRkWxw5c9I1PZnQt7wCBd0an4=
X-Gm-Gg: ASbGncsQpHX5i8jSnrCSuK0pjCtu2D43GWL9/T7+E02CMK6Yd4lzoFBMHYDZZWE9rjm
	Ro130U89O2IjI8dvW4pl1gEE23J3A5fNcATy5Vw19yFaIBp+y8hVMCUqKgBDN5xRv8E3jJUYmII
	bmx7A75lSLytYg2A69VxPTFMSQFR1g5m/uF25S+C7QQCKrIECfz/Nwf/OKsBRWJQNLtLuMrAaw6
	RFzuJiMtDsp9NOEHUT0fsr2Gwq16+bX9Jv9gS4z5UOa6UGwWyqeJfapTywQKhHL91vB6337Q0OW
	J7q2IJBj
X-Google-Smtp-Source: AGHT+IGr8zOK+RC+hHIYloBf/M6OFm9CLonT2X9KL0+nRhOcgIc58bzH/HUeqmIKXIC0EyAYm8IIg0+2JgEjPzNIGIA=
X-Received: by 2002:a05:600c:3594:b0:46d:7fa2:757c with SMTP id
 5b1f17b1804b1-46e329eb02fmr105794995e9.19.1758981370031; Sat, 27 Sep 2025
 06:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912163043.329233-1-eladwf@gmail.com> <CA+SN3sp6ZidPXhZnP0E4KQyt95pp_-M9h2MMwLozObp9JH-8LQ@mail.gmail.com>
 <aMnnKsqCGw5JFVrD@calendula> <CA+SN3srpbVBK10-PtOcikSphYDRf1WwWjS0d+R76-qCouAV2rQ@mail.gmail.com>
 <aMpuwRiqBtG7ps30@calendula> <CA+SN3spZ7Q4zqpgiDbdE5T7pb8PWceUf5bGH+oHLEz6XhT9H+g@mail.gmail.com>
 <aNR12z5OQzsC0yKl@calendula>
In-Reply-To: <aNR12z5OQzsC0yKl@calendula>
From: Elad Yifee <eladwf@gmail.com>
Date: Sat, 27 Sep 2025 16:55:59 +0300
X-Gm-Features: AS18NWBlYzv4rg7URg9J1v208P3mV2tQeMkzKbuflldE-TNBrvutb99r7dTcmXk
Message-ID: <CA+SN3squaSg08e=GKLZeStS3bSaKQZz_n0SWOB=Cv8cuLhO1Vw@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action
 for nft flowtables
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:51=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
> You have to show me there is no mismatch.
>
> This is exposing the current ct mark/label to your hardware, the
> flowtable infrastructure (the software representation) makes no use of
> this information from the flowtable datapath, can you explain how you
> plan to use this?
>
> Thanks.

Thanks for getting back to this.

My goal is per-flow HW QoS on offloaded connections. Once a flow is
promoted to the nft flowtable fast path, nft rules that set packet
marks are bypassed, so a driver no longer has a stable tag to map to
HW queues. The conntrack mark/labels are flow-scoped and persist
across offload, which is why I=E2=80=99d like to expose them to the driver =
as
metadata at the hardware offload boundary.

To address your =E2=80=9Cno mismatch=E2=80=9D concern: this wouldn=E2=80=99=
t change the
software datapath at all, it would only surface existing CT state to
hardware. Could you advise on the best way to proceed here? Would an
offload-only exposure (drivers may use it or ignore it) be acceptable,
or would you prefer a specific software-side representation before we
add the hardware export?

