Return-Path: <netdev+bounces-224584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980EB8659A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D500456573D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14AC288C35;
	Thu, 18 Sep 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsTetEGM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D634BA25
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218571; cv=none; b=pBfueWWfCg+OTgH41nxpFdqWYwggPcHVpZS4GaL2klsvDNx4WkgdVfSXAcxh20EfmPBl3uKhkglSO2wtIusOLus5wGonWohuU+hr5rUenlgXQTZN95bkvwqIaoUwAKvZOStz6VAN8gvNYV5YwGRoO8FhDVgjMxaxplhGjwcgflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218571; c=relaxed/simple;
	bh=6QxVnUw4wzEueSJAKwxPM7TMxP0+k06YCDun+1cr6/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DASMTd7dbmMxrVrfFy7KxsCG+ft+WS+M6Wvg4LwDnPOjGQD5rQ/ggjGbb+mGKUcABMTfqRfLWrqXmDzy/RztHluwZhiTjgCha/nTHjlA62F3zoblI6BWjXoUPGUJXGjkARTGye1LNrNOtZQgKkmLvroUWxXpxorLzu3ELv7ic44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsTetEGM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b60144fc74so15943671cf.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758218569; x=1758823369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QxVnUw4wzEueSJAKwxPM7TMxP0+k06YCDun+1cr6/g=;
        b=tsTetEGMCe5W8D4hk/sVx3Ot9PWa7wgDIoQuCm8yr0O2UjPnBxc52XCOvax4i3tU3f
         bW/aKBLelLt481sczY6uZpm2KyYu2Qdlszf2JwqJY9zRUaT6sSMrhUjVFYcT35O7cXy5
         mdeli5YU15D/vve+HuK56/7OElMP/MTLA+3+zC112rggVWKU+qIqfiYTQ2zPTqL48hp1
         dg00kB0KsdV0XUszGz1Q/o5IN9zckG77Jtrro7ODlYqSrJf6I/YZOPqr7wjiSaOqTkqR
         EMsq9rRafddvoW9HI97BMDUWPil0fyBHMRPFfvIDx9SPgrFneUJyi2Z9o7wu8QYJr163
         y3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218569; x=1758823369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QxVnUw4wzEueSJAKwxPM7TMxP0+k06YCDun+1cr6/g=;
        b=uzumEPyhDy4nuwqCgm14GIR73Jkp4X9JiZCuM9BfzjLnT9Y1pNmBzkJSQG/+Gk5x0O
         nMtmqZ/Y6U2ZTU3RHElSJXiB7EeomEOOY21OkxthvW2AUORJCxkgGRTMxFjTacCJdwka
         Cjp0b9rayMaLENYHphD28t9yXOvWBU3QhjHLfBUvMYOZjCoSyidK7MQzz9hd37rC0UFl
         nEk+qEG/xT2HNQllRbbeBmM2TujvDEM1Zv7Ycr6/tmFoJm1++qacPjFCD4JNAktO0aak
         Io7iEoabNvC+PuhePEgnwN90vhsbWVSFAbdtgCzAfl8/Kq+KOjQZKR82v5cH5WAmSzTz
         q8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa7A4VUCb7quteO4UgPmwCmE6Gx1c8VlEwBQeruYHYGSuJffI8lerYs8bgTQTUVYJOlw+gRoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTf0txDesKW8fLt4WI90u8V2WdVi/hv9z3IIN/801jifgIPe6m
	JmKA75Ss0cMiAi0aJmgE3DY3Dty+EccpXhcwelqqangq57lj9GQoEqlpoKD4/cGnxkKMi/uhv2l
	wry9xgtpd4MDPSqmSvDFLqx/nW6n10X7TKwmcWGj/
X-Gm-Gg: ASbGncvytb9H2IEu6LvnSWBMHLinm8P1u7biXmfkVWHOorSX9cXCJ0LhkP0JIbdO5Gm
	DA6DV9b66Zzh4fQB7JFBZBME5VETROzr2xgT5Clwf97biicNXCuevpcwco35MZjZ2xZmSqW/ev+
	vLnXVRIP/A0jAKT+CPKsMSSVAyQV6UvRnHoGwyVgyRylRdzg/rJlpAwCLp1jOuvpxLMae+alN6m
	WLcGGmcHo0FHmG4JN8qRK6D+oljVfAs
X-Google-Smtp-Source: AGHT+IFS1dBplz8pVcb/mD/pF+XO0D6mfcu0KXBAm8HS0tv6eJvKqXpKx4eeVo9x6x9AYqjhXhvgi+R1r1NS9rdTa9Q=
X-Received: by 2002:ac8:5a10:0:b0:4b7:8028:ff1d with SMTP id
 d75a77b69052e-4c072d2e152mr2701381cf.74.1758218568442; Thu, 18 Sep 2025
 11:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132007.325299-1-edumazet@google.com> <CAJwJo6Z5+W2hDMOwPTnRWqLoGLqfwezZd_mOCmbMEnbvK-VBDg@mail.gmail.com>
In-Reply-To: <CAJwJo6Z5+W2hDMOwPTnRWqLoGLqfwezZd_mOCmbMEnbvK-VBDg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Sep 2025 11:02:37 -0700
X-Gm-Features: AS18NWCdacnt9l3q98jEJHNFfPbK4MwUg_OY1vnkkBQ55hGVaZi8fYlX5bTWMBs
Message-ID: <CANn89i+nAPNQ9pWjk6K7z+kH4dnP3YcmjvW_StT=0CdHoPR-+g@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: prefer sk_skb_reason_drop()
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Daniel Zahka <daniel.zahka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:56=E2=80=AFAM Dmitry Safonov <0x7f454c46@gmail.c=
om> wrote:
>
> On Thu, 18 Sept 2025 at 14:20, Eric Dumazet <edumazet@google.com> wrote:
> >
> > Replace two calls to kfree_skb_reason() with sk_skb_reason_drop().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Daniel Zahka <daniel.zahka@gmail.com>
> > Cc: Dmitry Safonov <0x7f454c46@gmail.com>
>
> LGTM, thanks!
>
> Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Side-note: I see that tcp_ao_transmit_skb() can currently fail only
> due to ENOMEM, IIRC I haven't found more specific reason at that time
> than just SKB_DROP_REASON_NOT_SPECIFIED, unsure if worth changing
> that.

We could then use SKB_DROP_REASON_NOMEM.

