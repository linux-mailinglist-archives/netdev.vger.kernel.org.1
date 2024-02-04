Return-Path: <netdev+bounces-68904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BCB848CB1
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD391C215E3
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5C1B267;
	Sun,  4 Feb 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHqOYzyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C111B7E2
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707041760; cv=none; b=j+GRYQ8agrOq707ToIjw1DpUKjWBvT/wXrCjVft2TvlGaB4WmsWLr+raFskWaAkNIYwNJJeuN38ACvj8bYqXd22KXSXxhD6UqDY275TR+vsQv/OGoeCy/82fPxxkHHZK/gitAmoGQPHac8xvvR2U8yLeSMsvDqj8AVO4MsH8iUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707041760; c=relaxed/simple;
	bh=OhvM86Xze9+DvXK0VXIxTpTE3A9qY11nGhgU75YR3D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgpXUtJkehYZxuT2/IAO0Tfd5y8SlZWfkQ0SphpT/r+f5xo0Gqgj8yWr3uZgFEVlqibfmjYxcJ/cTAoxBsK+z92NSDAysCxamx7HzGuuPb3RR3atTVLYVDcnMrWhMuDfg8ZeOjbzskvhb+4EkESRvc0WhcX4JJrz/hdQSECjOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHqOYzyi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so526a12.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 02:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707041755; x=1707646555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54CUyr9gJ+SIulmzjunyJm9JrHt4hcyAOlHqsaAkRos=;
        b=zHqOYzyiVUIJajZ/bv1IIYZFskHtxszOclebbQHWS53hs+Dr+l5AzcsVD4VZDZxudI
         U8zIXjxI2AMLKSsdpX5dwccpp7OuotE5v/mE4BDx9CAK/9QC4/LIKAzcvrQ77jNsv0gD
         PPmF2d0cjvJ9Knuw93nCrCNlQvtgb4Pj+0QQGrHaPC6LOKWChtrAbYtAvgT0kRrCNVLB
         Ik1tZZGZPeBf3jwopxw9BAh2l96OO8c1fnMnbwwQQqUW7Ov8YRxzvbhzEEhYzxh5Cktw
         InMe3dJC21IiknxcAza5ReWQT+k561Jw4dInSdMMSZcynCWloCbORmkfpT9rt1cN2Zvy
         05zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707041755; x=1707646555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54CUyr9gJ+SIulmzjunyJm9JrHt4hcyAOlHqsaAkRos=;
        b=C/rrn5G9y9gvC2JMUszAIEJreGholwyxYHN/C4jV6XIBHsTuNwPbtf9m+fOD0fm67h
         ABVdp1ilo+pBjraH4vzFtboUpqZ4Yj96SEPrdwb9ZX00XYJGGF4I6LVKSzMSruV1ECXd
         LhGBaKfXp6Gf+OLC7a9ds8lhQufTNKR9QI7LAu7baLKYV0ipIhz5XqigPXvvW3Cupt14
         ly059tbCY5lwRZ8g5Fk7tr8562n7fsbjd2I0j2B7+TIA/riR/FSvWKpSIq55jCN3juFY
         TkVyaCXIdkkVFV/LBC5umpdeXuNWwZ1SP7abLOb1dyTejibxJw40/wu0XV19qFlaKIor
         7dWQ==
X-Gm-Message-State: AOJu0Yzp8Q5qAkVCONHkdC+DQQotKQM+Hju9Qu18k/F8DgQCExDLmn0H
	PGKxwGNIxOeDKC2gptFVnzbAn67qr5Z4S/52ViGTPPFbS9fO3oFS1TwT7jHnhHo6IqV9uyNUPnH
	+AbOoC3R7eZO3oRkH/8LBiTpGjOSULIPR48ybH9zJtgv4CiaQZqhR
X-Google-Smtp-Source: AGHT+IEjmm0CzqUN1BpNBPa8suAQMr3jHX9Qg+ycA22umoOdADkK2bTJOfNRAOVCj6hrnzq2UX+Nspyc/b3bbUvwZ0Y=
X-Received: by 2002:a50:d517:0:b0:55f:98d7:877c with SMTP id
 u23-20020a50d517000000b0055f98d7877cmr135200edi.5.1707041754830; Sun, 04 Feb
 2024 02:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com> <20240202174001.3328528-16-edumazet@google.com>
 <20240203211052.30905ae4@kernel.org>
In-Reply-To: <20240203211052.30905ae4@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 4 Feb 2024 11:15:43 +0100
Message-ID: <CANn89iL6CoVLdd9qVkcJ50pSU1dS7Fn4naKGcK2K6ci9Xp_cYg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 15/16] bridge: use exit_batch_rtnl() method
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 6:10=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  2 Feb 2024 17:40:00 +0000 Eric Dumazet wrote:
> > exit_batch_rtnl() is called while RTNL is held,
> > and devices to be unregistered can be queued in the dev_kill_list.
> >
> > This saves one rtnl_lock()/rtnl_unlock() pair per netns
> > and one unregister_netdevice_many() call.
>
> This one appears to cause a lot of crashes in the selftests:
>
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2024-02-03--=
21-00&pw-n=3D0&pass=3D0
>
> Example crash:
>
> https://netdev-2.bots.linux.dev/vmksft-bonding/results/449900/vm-crash-th=
r0-2
> --
> pw-bot: cr

Hi Jakub, thanks for letting me know.

It seems default_device_exit_batch_rtnl() is called before
br_net_exit_batch_rtnl().

We call the br_dev_delete() function twice.
unregister_netdevice_queue() is called twice.

So the real issue is with patch "net: convert
default_device_exit_batch() to exit_batch_rtnl method".
We depended on the fact that the rtnl_lock()/rtnl_unlock() pairs were
committing small batches
of device removals.

I will rework this patch and move it to the last patch in the series.

(use list_empty(&dev->unreg_list) to detect a device is already queued
for removal)

