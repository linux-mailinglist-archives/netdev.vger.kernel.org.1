Return-Path: <netdev+bounces-224972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F0B8C537
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 12:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC217ADDDE
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3532F5A23;
	Sat, 20 Sep 2025 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCUEp1vd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE56225A3E
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758362898; cv=none; b=i6Q+7YW9tUVDbIqjCL9BQgfBkxDC220BPcM7YIK8TUyH+691F9UXArBWMDZFD64xDyB09P6A/WYIoPP/CssvbfAh6Z85ze4b92PVXlcMEGRJjXZ33HQK4OSxyQ0v/a0Ok8kiSq2IQmrMS3qZQRHYM6NVRjLzc7ZUutdzLH8Kkb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758362898; c=relaxed/simple;
	bh=ObfgC1h52xwNdOobg2r5XPAg61UPKFKSYrDjYRIYwHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4lT+HjfFlw0H2ILRTp/t3QNkC4IlVwq35D4D+nVLQhgYzL9gAq5GTTFz1c0wfG/Q23RSEK0Vkd3Rzst0gGtx0kLeC8r9Pye0jFUChD0bO286+YFQNbTAGdpc+5Z6GInMpsRcyHeKLiwJ+2eMjsJF4n0xiQX3864pkaOX0LVpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCUEp1vd; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so414770466b.3
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 03:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758362894; x=1758967694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe0lcClCPEcf8hl+EDrEGGNTrCD25PEwuESOT223Ua8=;
        b=cCUEp1vdPsRtkJ9eCRmYoijTPBfORqZTwC2MNclBaJdtYOD2PfvUYwfp5sYJDK3mtc
         DlRspGc1FPMWlvPEOC3GhejtQPPM6bR85BU8x5xdmEmB7rL9dVNnYHSZ3pNvopRvsEQE
         L3L0JL1hnuUnSQM9XOJbLdmyFD0X/fNRr3iJIU6yQfn24bqN8RuUC0jEfCX+fVI+vv4V
         0cjDxZd1lfXtO4fbhKAKspJQHUOP/uun1OksP2izcW5HDJMj0nqBH3xzd1UwwOJ8soU2
         lb1Iy67CBeKMXPgS15ViIAlw+rjXDj+Jz8GNwaiwfHlxz2RhaipS6e3kqgbD4s+dnCxd
         LVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758362894; x=1758967694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe0lcClCPEcf8hl+EDrEGGNTrCD25PEwuESOT223Ua8=;
        b=ceNBoHvfXk3qIKyfdxTpqPa09dl3uBGk2d7zhyI1Rums5e1N8FFkaeGicONqB/tsTx
         GCZsT42X885KQfpFTgc98aNJhIfP7YDJ7wj6yKgfmY+KxSLUKoQJPqvoJ54V2PIPUEo+
         a0MWTm/YpQfufjOzQy9juirsLiuQgzNrj21AQlvxuK4kLWcqo0Bgb2xsyUxP3NTWQHvp
         qO9CtXKfRwlBrUZrm/WoqMobwurNJIvaSD82qw8wIKwbBdD+lyiwzN6YnKCbnvOjShvf
         SRfxtSiQUCJpJtf1jzBxVQYY/f6URagIzN8XLi3/CnqY892L5A1rnpd2s4hZrQp7GXsW
         jpPw==
X-Forwarded-Encrypted: i=1; AJvYcCXAZ/LMLlQYjaMKW7J+br1rso941Fh4H4VvhuZcT825HjdbWtjJACqCSksuzZLWrIKoA7pTISI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDtb/Lzcn3IpGq86kM2E34MmAj0My5u6THcVLlv8/ZtqkL4a0D
	HOz50BTCOQmrCfj3fH0cHN1dX4TRv2XyyLPCCEaHQ49UQaI07Nj4TgD0PgSfDai7FnAVO2j/h8X
	uqmnokL+JGTaIud91x2Y92cnLCzzIhGI=
X-Gm-Gg: ASbGncv0phVBEas9mQWN47BA2zKEzGz+whuFs/PxMINstRX+tMp+sbF+ACoaqGtOjv1
	rAj99a2OtuT/cp73cuVbDB67cJ6jFksLgSBWiK07zVBzOWlg1gtUOxcBC+xjlAeMSR0vg7+NjPJ
	/0Y6OLTKG8Mb9A3L5/fqH9+IijPtbrEOiSDitgel5kyb57HFRrHIou8OErMf5YI0R/cwkjk2yMl
	JDaetI=
X-Google-Smtp-Source: AGHT+IEWE29T6cV4r5UuETqqGeQnjCtI+yhJUtdEO1Ev8BuF7jZN0enwt/bBX1nmZpGKZUqSfijRG8c7SGSTF9FDuo8=
X-Received: by 2002:a17:907:972a:b0:b04:4046:db6b with SMTP id
 a640c23a62f3a-b24f567c816mr645963466b.45.1758362894355; Sat, 20 Sep 2025
 03:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
 <20250919-lurking-agama-of-genius-96b832-mkl@pengutronix.de>
In-Reply-To: <20250919-lurking-agama-of-genius-96b832-mkl@pengutronix.de>
From: Andrea Daoud <andreadaoud6@gmail.com>
Date: Sat, 20 Sep 2025 18:08:03 +0800
X-Gm-Features: AS18NWCh31p-viGL3PfP7OcvBtJwzsD-69eILq-7ZVP3bQSbKG7MfpPrWXV11mM
Message-ID: <CAOprWott046xznChj7JBNmVw3Z65uOC1_bqTbVB=LA+YBw7TTQ@mail.gmail.com>
Subject: Re: Possible race condition of the rockchip_canfd driver
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 3:04=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> Hello,

Thanks for your reply!

>
> On 18.09.2025 20:58:33, Andrea Daoud wrote:
> > I'm using the rockchip_canfd driver on an RK3568. When under high bus
> > load, I get
> > the following logs [1] in rkcanfd_tx_tail_is_eff, and the CAN bus is un=
able to
> > communicate properly under this condition. The exact cause is currently=
 not
> > entirely clear, and it's not reliably reproducible.
>
> Our customer is using a v3 silicon revision of the chip, which doesn't
> this workaround.

Could you please let me know how to check whether my RK3568 is v2 or v3?

>
> > In the logs we can spot some strange points:
> >
> > 1. Line 24, tx_head =3D=3D tx_tail. This should have been rejected by t=
he if
> > (!rkcanfd_get_tx_pending) clause.
> >
> > 2. Line 26, the last bit of priv->tx_tail (0x0185dbb3) is 1. This means=
 that the
> > tx_tail should be 1, because rkcanfd_get_tx_tail is essentially mod the
> > priv->tx_tail by two. But the printed tx_tail is 0.
> >
> > I believe these problems could mean that the code is suffering from som=
e race
> > condition. It seems that, in the whole IRQ processing chain of the driv=
er,
> > there's no lock protection. Maybe some IRQ happens within the execution=
 of
> > rkcanfd_tx_tail_is_eff, and touches the state of the tx_head and tx_tai=
l?
> >
> > Could you please have a look at the code, and check if some locking is =
needed?
>
> My time for community support is currently a bit limited. I think this
> has to wait a bit, apologies :/

No worries, I will debug myself, and hopefully send a PR if I found
something out.

>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

Regards,
Andrea

