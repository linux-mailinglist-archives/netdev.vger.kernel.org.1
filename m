Return-Path: <netdev+bounces-194661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3719ACBC11
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23873A4764
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F324E223DFC;
	Mon,  2 Jun 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMi50EeR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5872F801;
	Mon,  2 Jun 2025 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894385; cv=none; b=TegxIGwpmZukbE7eHx8XqIM6zLomENJe9MArRjxUAMa9RSUCnJjtBLg9KmXN9hbhb6wPkp72dB5/yl4pRcfyHl6iHZ18W2NruvxPcCf2ncmqazlLsBCcJxCWq3i9VdqoUASkFQ3x7cVCaephvFGUVP/2BKZEAMRBVmdbKSDnoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894385; c=relaxed/simple;
	bh=RHvDS4cAJl+92SKascd6+GCLIsOdByGvIOkroYDtzFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvtN/a6IJVUXF7U/n3tXAvm5jilzn3scKkXoKN6X8OeuYRF26EJMg6A0SEKalfYJMV27V7keVuXb6tHR23VT4J3wvF/hLWciRgqyyLsUpH+3gUdVbskj6rev6QAMJ9aM4r7jb6VHj1Mx0VbPszbNwmWf00RIsYE1ojVjiIc1frc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMi50EeR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e102eada9so43443007b3.2;
        Mon, 02 Jun 2025 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748894383; x=1749499183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIhra9oieA5lipSepna6Y8iP2PylydCCjXn7hB/eBYU=;
        b=YMi50EeRCPKXMllyPCADbX6O/wvnf81CWTeugrJenQUlOGFpbe3zJDnh/W1RMWOVVv
         fpjAwTHab2cBie98+H4N26ho7tXoQH50z1D67tpjw3v7pDqn+0Uof9g0YewRqKRi9hNF
         syjiUQKBikTwULBbsODF66e0xPZujLLtaQgstfIsnvkCDnIQL+c0jMY4z+Ks/VubTJ1u
         GgYHkF1+oYf3+EPNjoNHBcx56nrtr/ch+7zI7iyfVX5zxwK7RO/+/8jsHPBSgu5bAeI8
         bR3J7UbAwkuupmLELXUjq53nqZJgA//rTHt+JSijfA9somDh/Y/ZuywH3BEdRloXpe/v
         fPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748894383; x=1749499183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIhra9oieA5lipSepna6Y8iP2PylydCCjXn7hB/eBYU=;
        b=eyeqeEYSgXgRPBtkVPyGORgE8ZB9on/SYG6DlnOLGa3TY012Uy6UyC1kNNRPNe3MRu
         XcIAQURz5t1SUB0yTTNW3mz+0s25dYDo1C8uiLn+kuKMkIgQXW4eYsAzxTyWJo9n4TI6
         V38xhZogbOPWAuUeGhBsi39TM3oaB2LzGb/CGLqBPzmwI0J2tvWmpzqPAWUmNX15QVX7
         wDxWV8NnD3C6E7BLNw13KlgOp7vXUjpp5SCfize8minaTGXndLjai+HJmRwQWHWTyV7+
         wsyzT2Tto3bp3s6bp38hDGV3A2yVcNBfY5yfAVEAvnnIZNUSFZ6jTAN37kCPxBxweH6d
         VJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU59BOTXZAVY9DQFWdgdq4f+1j4ZvH0wsYMxuDLt0PuwaZZQ31yHREEoPrSVyIG0z+5Z2/DZD1Akt748gQ=@vger.kernel.org, AJvYcCUZAA3aQsyT2PYF6k28fZasOhKUm5+TZ0R+sTn1pnICOtZKI2QC9L4wJfAbR+PmgBUTxV7P2yf3@vger.kernel.org
X-Gm-Message-State: AOJu0YyPW5PolQOYoFM4r0yQ42NMfLH/zX6IMPxCK7YkIfsXLxgaj2Im
	97xdC1v+ePAMA+yNLCCDjny52yQC3fhvKVPcRWcESLLfvZLmiQtPWtMt6e8xABAdvc4SNcSLz2W
	14jzHtlAcOWbeN9rAwE7NePYuymXFi8k=
X-Gm-Gg: ASbGncvb/AsDZPRR47ppsHVwg+JBAgt/cB4MhOFJMYYdi1O1d2ZV+XmO50M86qieczU
	iHY7HydG4zNKZxS5s5FW/cFIcFMGNXsrAA9UyFva7E1jJ6J8h4CfDrUnN3+D2gNDb917aCNhYYI
	1zkGA0ONhQ28A8CPnUOQAnMY89Zxcgiuk=
X-Google-Smtp-Source: AGHT+IFaWA9t31/piCYFAJk6alZKu/kEChLNmdDEWgF6KlX3U4CkL8UaHAE4YZ2ByETQvmO7lewDlSOwJp08MPrWqqE=
X-Received: by 2002:a05:690c:4485:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-70f97ff9266mr222966767b3.32.1748894382835; Mon, 02 Jun 2025
 12:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250531101308.155757-1-noltari@gmail.com> <20250531101308.155757-5-noltari@gmail.com>
 <5d3d04c0-d9e4-4f80-8ab3-7bedb81505b3@broadcom.com>
In-Reply-To: <5d3d04c0-d9e4-4f80-8ab3-7bedb81505b3@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 2 Jun 2025 21:59:31 +0200
X-Gm-Features: AX0GCFtdY2lyYs2N50Q99tWdxoPNyeqsskkVl8zfCyMTRNSNLhGpNsTfeSkElC0
Message-ID: <CAOiHx=nQiYs43oHXJpOhUn1dJ-tzD-TPdB22zcHFxjUBKXeVng@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vivien.didelot@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 8:06=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 5/31/25 03:13, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > BCM5325 doesn't implement B53_UC_FWD_EN, B53_MC_FWD_EN or B53_IPMC_FWD_=
EN.
> >
> > Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floods=
 callback")
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > ---
> >   drivers/net/dsa/b53/b53_common.c | 13 +++++++++----
> >   drivers/net/dsa/b53/b53_regs.h   |  1 +
> >   2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53=
_common.c
> > index f314aeb81643..6b2ad82aa95f 100644
> > --- a/drivers/net/dsa/b53/b53_common.c
> > +++ b/drivers/net/dsa/b53/b53_common.c
> > @@ -367,11 +367,16 @@ static void b53_set_forwarding(struct b53_device =
*dev, int enable)
> >               b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
> >       }
> >
> > -     /* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
> > -      * frames should be flooded or not.
> > -      */
> >       b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
> > -     mgmt |=3D B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
> > +     if (is5325(dev)) {
> > +             /* Enable IP multicast address scheme. */
> > +             mgmt |=3D B53_IP_MCAST_25;
> > +     } else {
> > +             /* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whet=
her
> > +              * frames should be flooded or not.
> > +              */
> > +             mgmt |=3D B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN=
;
> > +     }
> >       b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);

Since the only common thing is the register name, maybe it would make
more sense to have the flow here

if (is5325) {
    enable IP_MULTICAST
}  else {
    enable DUMB_FWD_EN
    enable {UC,MC,IPMC}_FWD_EN
}

>
> I don't think B53_IPM_MULTICAST_CTRL is a valid register offset within
> B53_CTRL_PAGE, or elsewhere for that matter, do you have a datasheet
> that says this exists?

5325E-DS14-R, page 83 (or 105 in pdf paging) on the top.

Regards,
Jonas

