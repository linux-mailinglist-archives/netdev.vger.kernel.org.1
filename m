Return-Path: <netdev+bounces-62268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D258265EB
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 21:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524341C20AA4
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BED111AA;
	Sun,  7 Jan 2024 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0kpItg7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AAE11702
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e734251f48so8395887b3.1
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 12:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704658625; x=1705263425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sq3pULoSBqZLAyzcWKl6Jmc/aIKzDYzrOj+eK1mC/9I=;
        b=G0kpItg7xsaAnnn1kJMh/cp5IbVvqw3TwzUZLKWJDCLyYMmYtr3BMGGgLp3MABPzmC
         N3JqhpbY2SOrK7Ph4rSEl3DYYHtm2DgCsCwQ3tF2vTXqPewyVJR5CTm+o9e7QBJU8myv
         JSneqav9Gd514CwO1k9yswv2sFSJw5ggS02UpKs7OhlyT0jOowPICAkLsxZiQiU0++8u
         hAZq/NgO1W94/mDZ4xZgBtGqNZckX2BXGxPGuyHzRhuV6YkFuwRLHK1moZlFQ1FRyTQr
         j1Zr6gUFx09o3V6cuCscIHq6546Rx+iNcbJ11TsVv6wt6EIlGD7RlxNYDnHhNKUR5EWA
         +L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704658625; x=1705263425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sq3pULoSBqZLAyzcWKl6Jmc/aIKzDYzrOj+eK1mC/9I=;
        b=Txu/kisjmHYvTyUN1SbvBZYWhDeUeNGr22AcyOwrlhTj3YBrbgJBS3nBvZWnlfw3Bw
         e2ubALT8ohAaSdWEydJ1R/vaXl3Qt6zzh4Lk4uAxTB35+Sp7iRQ9HfKst4LKIIupt/Ih
         7u2iFwWc1LEaZT97LHXdqVqsQQa3qx1z35ulnbc4dvV5rayihY95XZrJcc7vF4/Ywk3M
         fK2S47KjG5jo4r1JfkJZ2OL59m0KaV7qdAH0nL70X4jCc/TS3+lRLxkzZsg83bEgo3IO
         fVNBuh8XvFXKJl4xh+Z+ilYLS5f6FGVh+iNu1fAVkG6pR+OgyR+00XIyjhl267X/ErVX
         I4Iw==
X-Gm-Message-State: AOJu0YyXf9EPYx7Pol373BpIRDHf+19YdvNNCWMFLfP/3cjy5W7JrKzO
	FDWUW6vgJZY2vq2YcqEjMfeNIkhe/mZKnkJv18Jz/puuztESIA==
X-Google-Smtp-Source: AGHT+IG+3i3iD3j5k4Z6JxM2v3DvpI00+CKoZfm+IpLv0MaZxA/L6m1Yyn8HTvRi3HPQtYGsMLFguGy/LMTz5MctG1A=
X-Received: by 2002:a81:7345:0:b0:5ed:f41:d660 with SMTP id
 o66-20020a817345000000b005ed0f41d660mr3609241ywc.41.1704658625402; Sun, 07
 Jan 2024 12:17:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106184651.3665-1-luizluca@gmail.com>
In-Reply-To: <20240106184651.3665-1-luizluca@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 7 Jan 2024 21:16:54 +0100
Message-ID: <CACRpkda8tQ2u4+jCrpOQXbBd84oW98vmiDgU+GgdYCHuZfn49A@mail.gmail.com>
Subject: Re: [RFC net-next 0/2] net: dsa: realtek: fix LED support for rtl8366rb
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Sat, Jan 6, 2024 at 7:47=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The rtl8366rb switch family has 4 LED groups, with one LED from each
> group for each of its 6 ports. LEDs in this family can be controlled
> manually using a bitmap or triggered by hardware. It's important to note
> that hardware triggers are configured at the LED group level, meaning
> all LEDs in the same group share the same hardware triggers settings.
>
> The first part of this series involves dropping most of the existing
> code, as, except for disabling the LEDs, it was not working as expected.
> If not disabled, the LEDs will retain their default settings after a
> switch reset, which may be sufficient for many devices.
>
> The second part introduces the LED driver to control the switch LEDs
> from sysfs or device-tree. This driver still allows the LEDs to retain
> their default settings, but it will shift to the software-based OS LED
> triggers if any configuration is changed. Subsequently, the LEDs will
> operate as normal LEDs until the switch undergoes another reset.
>
> Netdev LED trigger supports offloading to hardware triggers.
> Unfortunately, this isn't possible with the current LED API for this
> switch family. When the hardware trigger is enabled, it applies to all
> LEDs in the LED group while the LED API decides to offload based on only
> the state of a single LED. To avoid inconsistency between LEDs,
> offloading would need to check if all LEDs in the group share the same
> compatible settings and atomically enable offload for all LEDs.

I think these patches look great, and the driver certainly look better
after these changes than before them so if you resend without
RFC, please feel free to add my:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

HW triggers may be hard to implement but plain software control
is not bad either so this is already way better than what we had
before.

HW control can always be discussed and added later.

Yours,
Linus Walleij

