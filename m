Return-Path: <netdev+bounces-225380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E18B9333E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 22:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3FC165A3F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AEC2EF662;
	Mon, 22 Sep 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvoabrkE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A892E5B11
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572356; cv=none; b=SKvQqmRQlxoXjI1VXkcP53iPQrqkb2U4Umv8ZDk5AgOhjdfSE/gLhRiO1hKILU8YGRQ0FJu90eQ4Fph/ZQqQF33yZ9zCPyWjI8RHxZezGdRcuCdyG5TXvu/AEBFalT9wuLR2sB4F6Sp/AOwUxaBCWCVTKZN25AAfnAmNERKoJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572356; c=relaxed/simple;
	bh=QttDP1ln342QjfppuDfqfyIT8hMIJ+qw+viHsD5KAjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbZum5UnJj5MLGNELW03FBttzJwFlWrAOJFhMMSMhZUWc8d6a4LukYSdxfqra+5bg3B8eq5L56tRopPSXCUwtJ2fmYWbJpIg2SML6Q7l7CKFSXCEFdRfG4cYzQMTRS1UbF0p7Zqv9fzdmcsu+wAaE6aorVTngWowUFqz3I/fYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvoabrkE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee12807d97so4139560f8f.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758572353; x=1759177153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QttDP1ln342QjfppuDfqfyIT8hMIJ+qw+viHsD5KAjA=;
        b=CvoabrkEm1yOP8RwIKkFSRMhK2mCqs8t5L2dtVAITLf1anYUCmn5hvzJ0tNyEhNENA
         qNjq0plWrIUZZLra8IUL6Qs5LunpIhnE1WoUa3u7RjKC0pSd82f6u/IAH6YnkJhhF0Zp
         yQUfI6x2KbkUl6d9EPt7CXkPkL+o9lBUam5BiXS5yabvoSb9vRltu/WyuT/tGOOvciXU
         cS8Hqo1ooG6Et3UqMh5qs+v26e0jzQvE9aaUukTpBM6ZTq09D/1uPtorQQJAmCPcvQZj
         TyYkacxkhhcEvfJhRfxBzAc29jAZ4/r4KTKrmsW1SJ70+IgBM3u5Ukhl29gAK9aKSc7c
         iLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758572353; x=1759177153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QttDP1ln342QjfppuDfqfyIT8hMIJ+qw+viHsD5KAjA=;
        b=KkCdU6NoitU5VrQFLrJUpcrNPBt8FkAWJYoqjDcRT7rQZeksq2qRqdSbY76rIsxeti
         lZ2riG5UBS0SUc1VPNTQ6yhC8QYLtcM+mv2mb7JvE9bGHp/ITfAFwL4uLLj5qzhaGFyk
         ZvrDNYmY1n+JO2dUWjriP6a0A6dIp9uhxwa+NsGnL01OI/qtU10mrB5SRRL1UeuAa48P
         D1Ixl7YoabkNXV6dHfv6MHCNkdVDqYJ1DxpShYOIxl7TgYlEKXNJJTSKTIyUGoOrukgM
         2ddXrc0U7ywxfc1FebxRMjeiesYYmdzE8tnj+FGL4a2GUzZAumMctwERssrxyQfc75ux
         vn/A==
X-Forwarded-Encrypted: i=1; AJvYcCX+XUG3d+IDD/oy4QTMl+JzJDKNnv0cM3MPmI02k3TCfgLTseiyVSxvWO44JnbxUEAgULRZCDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpeL4Q4xL6ulYu0pPAfMNvoMcEYJOMO7ImxYZxNEwO+f5Q31SR
	fYlNEOXQB4VhtUaTR6qTycO486FpNRE3XdvlwRD/HSytjFikgjIhNtC4MAPRQfm1TBlEiYNgWb/
	WVDTI7F1+UF3kyOMGOm6ypfr/ljuiA5E=
X-Gm-Gg: ASbGnctEvVGXoaL7ZlGbVDAZt9Ph97qkn5gsjusKD5WgWS4qPzduJPFP3VQ7odiRsNU
	4BS5/Yav1Qf5ADSz6ZWGsVqFMPQayOhgfbm2EtKhxDuFt1n8rb0+KcJsG16gVwDBN2ZXKGWZtQa
	/iuN3iDIUxzlZKQY8V5Q0LTB2QlwXfbyMWFXms4Tbh8Qw03wTr5LnOVintWoLAhEerNnoFelRDT
	O+j
X-Google-Smtp-Source: AGHT+IFLIDbz4ZX9ktavmNMKXxYAgQWeKfTSZyw+CX4xnsbuFFlXMHCLmpfONorit8BlcwmGyhQn2z8UMrpU5t/N8+A=
X-Received: by 2002:a05:6000:2008:b0:3e7:5f26:f1d3 with SMTP id
 ffacd0b85a97d-405c5bd82e0mr16877f8f.17.1758572352590; Mon, 22 Sep 2025
 13:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com> <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
 <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com> <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
 <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com> <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
In-Reply-To: <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Mon, 22 Sep 2025 22:19:01 +0200
X-Gm-Features: AS18NWBmQb01FOmDkWddXCnLyIUSas0wzq_nBPDNh66pB9e1ZHt2XswuZbgX6fw
Message-ID: <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com>
Subject: Re: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Slark Xiao <slark_xiao@163.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Muhammad Nuzaihan <zaihan@unrealasia.net>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Loic,

Il giorno lun 22 set 2025 alle ore 10:03 Loic Poulain
<loic.poulain@oss.qualcomm.com> ha scritto:
>
> Adding Daniele,
>
> On Tue, Sep 16, 2025 at 9:23=E2=80=AFAM Slark Xiao <slark_xiao@163.com> w=
rote:
> >
> >
> > At 2025-09-15 00:43:05, "Sergey Ryazanov" <ryazanov.s.a@gmail.com> wrot=
e:
> > >Hi Slark,
> > >
> > >On 9/11/25 05:42, Slark Xiao wrote:
> > >> At 2025-06-30 15:30:14, "Loic Poulain" <loic.poulain@oss.qualcomm.co=
m> wrote:
> > >>> On Sun, Jun 29, 2025 at 12:07=E2=80=AFPM Sergey Ryazanov <ryazanov.=
s.a@gmail.com> wrote:
> > >>>> On 6/29/25 05:50, Loic Poulain wrote:
> > >>>>> On Tue, Jun 24, 2025 at 11:39=E2=80=AFPM Sergey Ryazanov <ryazano=
v.s.a@gmail.com> wrote:
> > >>>>>> The series introduces a long discussed NMEA port type support fo=
r the
> > >>>>>> WWAN subsystem. There are two goals. From the WWAN driver perspe=
ctive,
> > >>>>>> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.).=
 From
> > >>>>>> user space software perspective, the exported chardev belongs to=
 the
> > >>>>>> GNSS class what makes it easy to distinguish desired port and th=
e WWAN
> > >>>>>> device common to both NMEA and control (AT, MBIM, etc.) ports ma=
kes it
> > >>>>>> easy to locate a control port for the GNSS receiver activation.
> > >>>>>>
> > >>>>>> Done by exporting the NMEA port via the GNSS subsystem with the =
WWAN
> > >>>>>> core acting as proxy between the WWAN modem driver and the GNSS
> > >>>>>> subsystem.
> > >>>>>>
> > >>>>>> The series starts from a cleanup patch. Then two patches prepare=
s the
> > >>>>>> WWAN core for the proxy style operation. Followed by a patch int=
roding a
> > >>>>>> new WWNA port type, integration with the GNSS subsystem and demu=
x. The
> > >>>>>> series ends with a couple of patches that introduce emulated EME=
A port
> > >>>>>> to the WWAN HW simulator.
> > >>>>>>
> > >>>>>> The series is the product of the discussion with Loic about the =
pros and
> > >>>>>> cons of possible models and implementation. Also Muhammad and Sl=
ark did
> > >>>>>> a great job defining the problem, sharing the code and pushing m=
e to
> > >>>>>> finish the implementation. Many thanks.
> > >>>>>>
> > >>>>>> Comments are welcomed.
>
> Daniele, do you think this feature could be relevant for Telit
> modules, assuming any of them expose an NMEA channel?
> Is that something you could test?
>

yeah, I think this is something I can test, not completely sure about when.

But I'll try to have a look at this at worst in the next week.

Regards,
Daniele

> Regards,
> Loic

