Return-Path: <netdev+bounces-170904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2541EA4A7B2
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 02:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306CC175359
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 01:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE9154BE0;
	Sat,  1 Mar 2025 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12JGXXTz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9014A629
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 01:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794019; cv=none; b=Q3j/4i7nhDmUR1LFmrTQ5Q94IuroyPbszeTyKF8QjMd/twiXA94dpfzdmPw33exixW6JBtxZKxJWQi5yO/Sn2vr835AJHUPFzSUfofPmlQsM0izFmlY0sVmjWwb5Kv0sHruNVAmYExeFSYsgZtitC8kQ9WFjCIRug0BVzAley3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794019; c=relaxed/simple;
	bh=EKuULC55HQ3nbCCUfqRw7VZYjnjWI4RwxZ9r8CX/fpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXz3Ajy2KSsonw/pnBPgBBEBcGwNaYw2Lb3T4nFmQ3+DC19gTzzsRujaR+/hLl5D3p8d+2Bffym1hKzOAQA3MTDV6Yq+8XUStnZerMGMroTvjzlFzrw+RWAFjO38dsBaoI0BEdPD5KwJYJEEqa8HVXKSQTF4FCBZjVa1/a4zWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12JGXXTz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22342c56242so73205ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740794017; x=1741398817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLgNKvgK3MF8wXxYtxDEojHg1VBQZqgwWDhEQT1JUUI=;
        b=12JGXXTzsoc1iWgXyyRLnXMhsEoyiBf7P4LYJpBLEopDJB65evcVNnxu4b/FentsI7
         dEifDNpjnqiviO4Z39pUdSLcRf1n652uhmWi2UNYIlbakFEG+sXGFhuagq/IeprMIK2N
         NTmIE7F6hCTn82toJrPrXXSvn34Ln12A6rkla+rBL4ZK5by+lyArMDy9P6rO/1Ogi4YC
         UF4dgBogJYgcBy45T4v0A70WpJKCV+CNftJuwvHAfix0pMe3S+xz7ANAwmzmvq3iA0tD
         FxoLcGgHuyHUjMYuYm0yHABNzUMlHIiS1aEJqQQTr1hAKwrtcd4YM0CQgmFXgayZ4ekc
         mzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740794017; x=1741398817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLgNKvgK3MF8wXxYtxDEojHg1VBQZqgwWDhEQT1JUUI=;
        b=ISvotUeT0PJarzHTeQw6Yn6SdmVgatBu2qRQViCkfzCWjxaXBDpuIH0jDgQ/TyBq8/
         td0DST2WgWMocH13SyCNmTYN5E6/XeZIOuBsipA2VN13n5XT+vV69YoJH0zfVqeHrrLn
         Sw/5rYTDH97JlLL+TRRTfvC2KoYBHB09WtX7uPV0aCJo9aqnyxOcmal5vTW/tR6a4l5K
         9nUfLxoU8+2/yVAJnMirjxMv6VAGx8DEqAhn90uojqiLG4jzci7q92yiJbQR9Wxuv/6L
         ad4zhwUYhKJwj0NT1bN1jurhiYv/XWa7yTC3PtWh8frpDRFpST+zqyYApTfQevsx/9Lx
         L4sA==
X-Gm-Message-State: AOJu0YwG7Fb88ecfKIU2PhamtWxcS2qzppJtPHN26RTTSlRbPfiHjq14
	cJLZDmfLQtGTWcrSRVasSgjv5rpylP/RjMQvCudsI68yaN1SbOQdT5xJWjk0XuPZkta0YGkLVj1
	251bsYA7+66nKSyWx4yNKM6ClamsQuPe4unax
X-Gm-Gg: ASbGncvcqu90bWTTt24A0xcyVoq6H2qXs6v5cNGawprbgZrMV3vsLsakc+1a67HyChI
	9u4ASdgNS7aJHxDvhCVveXabIDT/03WMog8mi2U/wt0+6GpntYll84m31ipYU/aDaoNkFyxC6vc
	xqJKlUGEcllVyXWdPuL4+aFRHyLA==
X-Google-Smtp-Source: AGHT+IHKl2PLDaPwJZ72jov+1EwCLnYkzTru1UwRQte3i8ZHKbDpflK/NcgLRYMjS26dyimEoNSydoGDDo9IEsABteE=
X-Received: by 2002:a17:902:d4c5:b0:215:9327:5aed with SMTP id
 d9443c01a7336-22383684e49mr1174475ad.20.1740794016936; Fri, 28 Feb 2025
 17:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-8-almasrymina@google.com> <20250228164301.07af6753@kernel.org>
In-Reply-To: <20250228164301.07af6753@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 17:53:24 -0800
X-Gm-Features: AQ5f1JqJZCsnxITjcDH7bL98xxwfM9Akmi35L149mBq-r5HqPUJRq4YCYmUnRBY
Message-ID: <CAHS8izO-N4maVtjhgH7CFv5D-QEtjQaYKSrHUrth=aJje4NZgg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 7/8] net: check for driver support in netmem TX
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 27 Feb 2025 04:12:08 +0000 Mina Almasry wrote:
> > +     if (!skb_frags_readable(skb) && !dev->netmem_tx)
>
> How do you know it's for _this_ device tho?

Maybe a noob question, but how do we end up here with an skb that is
not targeted for the 'dev' device? We are checking in
tcp_sendmsg_locked that we're targeting the appropriate device before
creating the skb. Is this about a packet arriving on a dmabuf bound to
a device and then being forwarded through another device that doesn't
own the mapping, bypassing the check?

> The driver doesn't seem to check the DMA mapping belongs to it either.
>
> Remind me, how do we prevent the unreadable skbs from getting into the
> Tx path today?

I'm not sure if this is about forwarding, or if there is some other
way for unreadable skbs to end up in the XT path that you have in
mind. At some point in this thread[1] we had talked about preventing
MP bound devices from being lower devices at all to side step this
entirely but you mentioned that may not be enough, and we ended up
sidestepping only XDP entirely.

[1] https://lore.kernel.org/bpf/20240821153049.7dc983db@kernel.org/


--
Thanks,
Mina

