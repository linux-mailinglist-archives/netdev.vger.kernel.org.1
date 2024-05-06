Return-Path: <netdev+bounces-93712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA788BCE44
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91D51F216DF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFA3335B5;
	Mon,  6 May 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zQYtVdkN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2661C695
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999386; cv=none; b=iIws3W9/IYfcEOSvsHcaELnNX46xSfqQxq0isVlKKh2/slg2DJfVlSkeGHRzE/EU98w+6Gw5CLetEwAkNE53CDXQxHmpVVAkfVhcwTQfYxHoiCe0MG5JVrArSle2IkDmWFhfLeOUSPFz1tce4Oli5iHYeh7R3ME0lLTzrZo1/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999386; c=relaxed/simple;
	bh=cfs2ycVTEkuQ3cfqr5nM6QWK12nCn6P1/OxUfMj1naY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmRxx4ttFxHuShuOqLe8LSORilQgeJLNiz5dNndzS7UneIqs5ACEqsrfV+7uWn/xsiFGiRBUPmaRjJYBRgeFhLByz57uMEHEioXYCAhXP+IRYQ+QjFPC7Jc/SEHxcrshwcF3XkvuVpZT7exV619aMDbHZQO+86Wy4yE1x7S9IoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zQYtVdkN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso12077a12.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714999383; x=1715604183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anw714zKyXDK460Ivdwt+n1g4c7F+zM3eSbBt2Nf1dc=;
        b=zQYtVdkNN/svr3RnSO3xhBgUkkc/Fywb6Daf7Efb0r+JWfIRzGi/DDs4PWq6GO5exj
         wxEI8qVva3WZ1ZztB6MQgufHiru2fCpkbYO+hQSZXQJtcKNvbxoX1hsGyqTvnY04YJmq
         8dMOcJf1ttNIGbWxrHtxbAIi8IFCVdrCmMbplbwWMbTiXomw6dxiH1ZTQnL84SasN+02
         iHehrxU9LY/P9azdjr6gu2oALreGE3YaHV1C5YytC137bXhUrXF5ZqHPnl0Rj37XLl/e
         cPWxUMfXSeHhImTc5a2gMETZ9uEbXhgVjqHHX8XjQlfZ0wZwS0lzJikNLDno5IQ6Fy4a
         91Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714999383; x=1715604183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anw714zKyXDK460Ivdwt+n1g4c7F+zM3eSbBt2Nf1dc=;
        b=pqAsGlStwdPtr87hVSyDm1mIaUQ3PHAmYge228wnH2/UcAxOenHm7Db1ADfbmWSPEr
         YObff7XOSs2YYS/wyEXs4jLw2Uxt1j7aKXUCd0cSZvH/Gu0yVxOKNFWum8ZtMdq+eLcm
         5Zo6SLERwEGyOPyFjAPKs/1K80xa2J+bch1+DICf4MymCWGcGWW8B90Vmgc9loMGCoOR
         I34MvQcftGrCGA3lndFVvYeCYV3fvfGyf9qblnhfNTEjLlpi+9z2eYwuWqLV+8ngTmyn
         kbWy8GP90JzLEuoBN1OWYufqO38NvfLD7xwCCChS4YvBsiDzu3s6U0BTLPnyktSGo3IK
         CUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtvSE1CgBZ0C2Y2xSaNY3gLzPZltWcbPDkpCAZMOEOoIQ2A8NCGM5ABLO22UqoL+ZJyDYp4os/lr0jjcD8Nhaoeu7rjDaZ
X-Gm-Message-State: AOJu0YwL4LZ4ix2TSnwzGlbxSiO12REDnIvp4Spz4NOt3Eq8YYXm18Y9
	K3zJQ9DnHdkjjozje5m/uenoSJbwdMFVplN+EsFkuvwDUO0ZZkmg/fiYZGHT4XocrX1GqDGAV70
	oM132F8ZnG4lAFTgW5SevUlkheM/eTN1UFJuS
X-Google-Smtp-Source: AGHT+IGtSrv2pvTwoBF5UdNJr7FvxT453Udnb24JDuKg9lObH1vQzj7IDUm+HAcq7p4gGsERfgIVrHi4ogILPAkeVjw=
X-Received: by 2002:a05:6402:1bcc:b0:572:a1b1:1f97 with SMTP id
 4fb4d7f45d1cf-572e26945c5mr234715a12.1.1714999382503; Mon, 06 May 2024
 05:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506120400.712629-1-horatiu.vultur@microchip.com> <CANn89i+SJiOLLy8azt8NqckUkTLqTS3Wu=16vfTrqCFYLKxTPw@mail.gmail.com>
In-Reply-To: <CANn89i+SJiOLLy8azt8NqckUkTLqTS3Wu=16vfTrqCFYLKxTPw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 May 2024 14:42:51 +0200
Message-ID: <CANn89i+QiQEX3DymsVaRMv-DRmcdwtPZ2U_O2VDxShJ0fKqXkA@mail.gmail.com>
Subject: Re: [PATCH net] net: tcp: Update the type of scaling_ratio
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, soheil@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:35=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, May 6, 2024 at 2:04=E2=80=AFPM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> >
> > It was noticed the following issue that sometimes the scaling_ratio was
> > getting a value of 0, meaning that window space was having a value of 0=
,
> > so then the tcp connection was stopping.
> > The reason why the scaling_ratio was getting a value of 0 is because
> > when it was calculated, it was truncated from a u64 to a u8. So for
> > example if it scaling_ratio was supposed to be 256 it was getting a
> > value of 0.
> > The fix consists in chaning the type of scaling_ratio from u8 to u16.
> >
> > Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
>
> This is a wrong patch. We need to fix the root cause instead.
>
> By definition, skb->len / skb->truesize must be < 1
>
> If not, a driver is lying to us and this is quite bad.
>
> Please take a look at the following patch for a real fix.
>
> 4ce62d5b2f7aecd4900e7d6115588ad7f9acccca net: usb: ax88179_178a: stop
> lying about skb->truesize

Remaining buggy drivers would be these USB drivers:

drivers/net/usb/aqc111.c:1154:          new_skb->truesize =3D
SKB_TRUESIZE(new_skb->len);
drivers/net/usb/smsc75xx.c:2237:
skb->truesize =3D size + sizeof(struct sk_buff);
drivers/net/usb/smsc75xx.c:2256:
ax_skb->truesize =3D size + sizeof(struct sk_buff);
drivers/net/usb/smsc95xx.c:1873:
skb->truesize =3D size + sizeof(struct sk_buff);
drivers/net/usb/smsc95xx.c:1891:
ax_skb->truesize =3D size + sizeof(struct sk_buff);
drivers/net/usb/sr9700.c:424:                   skb->truesize =3D len +
sizeof(struct sk_buff);
drivers/net/usb/sr9700.c:436:           sr_skb->truesize =3D len +
sizeof(struct sk_buff);

