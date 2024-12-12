Return-Path: <netdev+bounces-151265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943449EDCEE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 02:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBCE282E22
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 01:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF7517C68;
	Thu, 12 Dec 2024 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvhNcRpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186631E53A
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733965737; cv=none; b=WW1ToGu5Q7xAsJzvG9sY6rkb28YUBEnwcNfN9PG40I+ycAgh21V6U2OoJf+Xt1RuKTerAGH2HH00zDYj0JEhO2E/E/mmzNXitcyq0ANnD7zkS6rJ8zAOqaL5QzCBBFvUVIdwpGPXLj71Cz5xUj93YnKsDjNYMJ6znVm2Babl69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733965737; c=relaxed/simple;
	bh=EoyweFmVj+YjPrtVOIm7w87frPQQrBdb2qTM1lLqKjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6T3VJiCNxXHCdbqC2Bp1x1wU59IsPVIQVQrjGf0wUaKt1YYT5l6czVfddk+xMhw99ZEvibJ7H997KM7/97oS1kGOvQ7/vWH5hcRBbuz6K2uSAntPUTL+ObR+eq2VAcFN9C9fTg+gY8tfZmnuvJ0mkQVHyEIkJ8FPLevK+zIZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvhNcRpL; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a9caa3726fso270885ab.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733965735; x=1734570535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoyweFmVj+YjPrtVOIm7w87frPQQrBdb2qTM1lLqKjA=;
        b=AvhNcRpLuDSR1W0IPBcUaantK+P8nYAxlh4SmLYEZtyuje2fagRfJ00r8n7wlr+zEF
         xifXNjMeGK3hWDg4U2XNX5YJUT63EPUFTxwo5VobEcj2sHItHUKuSwqblOG+J8mBuKvm
         dWHmAkToeLNMYWeKOfB66B/jIRC7MMn8qdalqOI62it6u5DPU04adYZT1g9zPrSNEA15
         QKdwFWQ4N4vUP1PzKkp47A3e3K5nXidCrE6EDwV0Qsgb8DVmB8vo/M/vQwbczgEwN9FE
         eayV+eMt0LLeicQA+XDCX3CejNZGtWxyhm3qpY+M3J8bW2jO3318tIVDsWy3xNIj9FZv
         FZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733965735; x=1734570535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoyweFmVj+YjPrtVOIm7w87frPQQrBdb2qTM1lLqKjA=;
        b=u0RKe23RG57ORa/roIfr5NzTLSFxjDtSkH2ys9r7g/w+Y2dUsTn9LUnYuBQu0/pbRQ
         /j6PPYPaWUYCHLFHNSaENkazterUNNEEzZYNesPSNUoUreoT+7oXNlIEJ+xTQljeAkb5
         sbK/RjG/EXj/ZpVi4PMNC+SD+5zRSCItDb2KsvhtO1O419qoteecggxhS3TQ0yhKlsDC
         zCl1SwwoIlk7XZIM0UEb+/BWNyGiVihtghukfD7kkMx4e5Vpt4QSdFOZuUlDnhSmt5s7
         XPRFIDWQHugBbc+mzKuhI0ZTCGXCR4nxn+fNg/qdoIAulaFla35WDa99BrNWt3Jo5iKn
         zzkA==
X-Gm-Message-State: AOJu0YxTjjnS7zCttzrylwjeURQD6WDUoTk4S4G43muQEvm0vxaDjpca
	Byf1dhammVX1vVattWy+0K0Xo898U9dnEY3lIAsYFzG1ItlN6veJKiIShul3josJXavLJhwdLW2
	GbRMj5jrHgGROz74VnggS0x9PqgQZnZJ93S4=
X-Gm-Gg: ASbGncvA4ShCj+mzW4dIhqhOpbPZcjfaM5aN/iYZ1i72OKKZVpYW2i+f8Up6F1fVbbH
	CTtB2oJDVixB9AWaXzTothEvZFCSZ74UhpDB/
X-Google-Smtp-Source: AGHT+IHI2/dVrgOJHj9ymgA+6BKxRHJGFHi2veXDYIZcERHkMy84hN7uCFisty6rsEHmgtH6IpOuADO/Xwt3nZN/tYA=
X-Received: by 2002:a92:d409:0:b0:3a8:16c2:3772 with SMTP id
 e9e14a558f8ab-3ac5e6390b8mr13873325ab.0.1733965735158; Wed, 11 Dec 2024
 17:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
 <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-2-66aca0eed03e@cloudflare.com>
In-Reply-To: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-2-66aca0eed03e@cloudflare.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 12 Dec 2024 09:08:19 +0800
Message-ID: <CAL+tcoAX2zMStiEkOkvJDr-PLCM3fC8JwHZyxnOToQCPfMq43w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] tcp: Add sysctl to configure TIME-WAIT
 reuse delay
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Adrien Vasseur <avasseur@cloudflare.com>, Lee Valentine <lvalentine@cloudflare.com>, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:38=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Today we have a hardcoded delay of 1 sec before a TIME-WAIT socket can be
> reused by reopening a connection. This is a safe choice based on an
> assumption that the other TCP timestamp clock frequency, which is unknown
> to us, may be as low as 1 Hz (RFC 7323, section 5.4).
>
> However, this means that in the presence of short lived connections with =
an
> RTT of couple of milliseconds, the time during which a 4-tuple is blocked
> from reuse can be orders of magnitude longer that the connection lifetime=
.
> Combined with a reduced pool of ephemeral ports, when using
> IP_LOCAL_PORT_RANGE to share an egress IP address between hosts [1], the
> long TIME-WAIT reuse delay can lead to port exhaustion, where all availab=
le
> 4-tuples are tied up in TIME-WAIT state.
>
> Turn the reuse delay into a per-netns setting so that sysadmins can make
> more aggressive assumptions about remote TCP timestamp clock frequency an=
d
> shorten the delay in order to allow connections to reincarnate faster.
>
> Note that applications can completely bypass the TIME-WAIT delay protecti=
on
> already today by locking the local port with bind() before connecting. Su=
ch
> immediate connection reuse may result in PAWS failing to detect old
> duplicate segments, leaving us with just the sequence number check as a
> safety net.
>
> This new configurable offers a trade off where the sysadmin can balance
> between the risk of PAWS detection failing to act versus exhausting ports
> by having sockets tied up in TIME-WAIT state for too long.
>
> [1] https://lpc.events/event/16/contributions/1349/
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks. I feel this will benefit a certain group of people soon :)

