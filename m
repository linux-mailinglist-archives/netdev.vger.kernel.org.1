Return-Path: <netdev+bounces-220127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65237B44875
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F46C5A5AD2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9B42BEFE1;
	Thu,  4 Sep 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi8rd0wV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5479E267733;
	Thu,  4 Sep 2025 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021280; cv=none; b=byFBvK6FfLrpFoPIAuwpUs1iWkALCCg2UUlQjAytCt96vTQhtHXgLa2DcrU23z6r/YXhuPNu8K5VXUPnzmoSulB+Ix/cy56fxp4P7X7ho287P8Ip220yHeSPdYoojKV4YZ5oh0kG9DAGHd8U23r9hh/7QivL07U+a0+Z3kZ5+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021280; c=relaxed/simple;
	bh=AcJVKOqTT/BgjT7rOyv5d5gV54Axr+D7z8q+qwG4J2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+2JsJl5WyZ2eIkEmydDcvU7LFy8yOJAmPtqoFqXvt7O+v4n4eGitGf/AkxH+2AF9z/6cIs6+bJpJFJOJZdwxwQ2cM3p9vs3u5dLY5oOVit0JNQ+7Bw+uzmYWJ9eNOJYF+1zkS3b484LgI0Mg6lRlutwzBArJW+wAoT3edWQvp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi8rd0wV; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e931c71a1baso2459246276.0;
        Thu, 04 Sep 2025 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757021278; x=1757626078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZAhyMgWHgli1L97SLzvlHNq5Gve0sxhiqrZgeSuDMg=;
        b=Pi8rd0wVaETczGeMbgqTLbO8VrWVH7DKZwURkXuQ9HOSlUjQ1ptr0xLCTvumToK6GS
         OWJFCHALcKJPqq3AieC3Wbr42gU/hyvfkK+GTRYxXfZtpZVA8yPftMM5mLsMtIKNt5jm
         e9oftZE5GU9Gv1kO2nHttURnJv0jxiN8KXsHPy5ZStfdiTlGyodwteBJmVugNTJMFl9q
         AFmCvAwpMFvBmZTzzrvZ+1pA09eJQ2YGSVKG7oKj+Y59NAJLzdXdUdnO9LlHYShFArgC
         s+7wj2jiI40XWflpqO18hf9AadKnNwGQzEz+PSGhQ/8RRb0UhL1NvLaR0TCfNjjKzHEn
         ygEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021278; x=1757626078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZAhyMgWHgli1L97SLzvlHNq5Gve0sxhiqrZgeSuDMg=;
        b=FfGd9mhIEtptQzlatZF0KNyP1w/tqmTQyDaRC98PADbo2nkIZo27k8BTpr4Nyzed9c
         oV5LmBVbCKeb0+nY86R4JzgrnXuLTcIKv/aXU2LZHX1XuLNwteZqbSLRDxlPcKJnJKj0
         R+uvtGBYjPj28CyEVpg2Vs5bdplMowOLOmDpWBRVy008mq9CdQ2OkhuofX5qfgDekNs7
         pTUWZQdLPY9epId8F0UaWNHDl1yQid1dg8+H06mgHOEe2DJUbXn0sy8aalDNdbqLPRbo
         GQA9myPNCnTzCG8UKpQOHpgFmK4dAQhq02LoWTodsf1049FtmyDAVXjs4PiVs0iIoLUj
         uO3A==
X-Forwarded-Encrypted: i=1; AJvYcCWtFC4kKXwFL3hs5MlL/wuXHLdIZzPryH9d/jDU1RCswfKV4XmhLGomE0q6we7AMryJrAH6WmrANwmk+b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwt+0kSHwBLE+uFvh20zmm0747jHf/KjcjFeKx33vzOYMye5l+
	dVSJR1VndxySdNIcWYimNz81jHgEqHGnNPkRsf4GGrZLoDomwf2pFxrkqaP3nkt1JH5gC891vkn
	V2h93/8gNIWwrFIVEeXq/ALL82meUHTg=
X-Gm-Gg: ASbGncs6C4Cp4O8UnqIj0R9XrqcCFSvr+7Yqmxd8kzvG10Zsbu7gtSxShqLKVEapkUj
	Ayk98cyc/zZt8wgGHbYERqMSyg6aWQu8LD998fYyb8JT2K0SeR094vqE7DChMvfpomX0PfhQ8V7
	QNk3Gw4zRxGWtF4gA3s4qFocGwNz/D1etA7b035Tyqid+XNHQZXqpDRw1ngFJIGiUJzEzfLXTGh
	kh9UKXfWb3EA2JKWbc2xZ01hNmIZPW8RrErp0vLw1lii0LaL5k3eIXguOBaAGT5XQ5YlhTcLZjC
	God/Qg==
X-Google-Smtp-Source: AGHT+IG5kicGLLVug/7HdBcLUIZ4WitDIRbTaowB+QZTucRNh6byweW0PquqDUq2n5YkoN9IARqxHd5isfF6SjopY+0=
X-Received: by 2002:a53:d005:0:b0:5f3:319c:ff0b with SMTP id
 956f58d0204a3-60177dd0c51mr3713950d50.29.1757021278115; Thu, 04 Sep 2025
 14:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904203834.3660-1-rosenp@gmail.com> <29a8a01e-48be-4057-a382-e75e68f00cf0@lunn.ch>
In-Reply-To: <29a8a01e-48be-4057-a382-e75e68f00cf0@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 4 Sep 2025 14:27:47 -0700
X-Gm-Features: Ac12FXzZnUsC-2oPVL9pdksAOyPLfZvJYfrHPQ2l7YInbj94bcJ0VzTGdGiWjPY
Message-ID: <CAKxU2N-3HvmYztoWs4ER7WhPhFHZt1PS9GN2RRGQP3b=KhNBXw@mail.gmail.com>
Subject: Re: [PATCH net] net: lan966x: enforce phy-mode presence
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER" <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:02=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Sep 04, 2025 at 01:38:34PM -0700, Rosen Penev wrote:
> > The documentation for lan966x states that phy-mode is a required
> > property but the code does not enforce this. Add an error check.
> >
> > Fixes: db8bcaad5393 ("net: lan966x: add the basic lan966x driver")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/dr=
ivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > index 7001584f1b7a..5d28710f4fd2 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > @@ -1199,6 +1199,9 @@ static int lan966x_probe(struct platform_device *=
pdev)
> >                       continue;
> >
> >               phy_mode =3D fwnode_get_phy_mode(portnp);
> > +             if (phy_mode)
> > +                     goto cleanup_ports;
>
> I think a dev_err_probe() would be good here to give a clue why the
> interfce failed to prove.
Probably. Although there are no other error messages in the surrounding cod=
e.
>
>
>     Andrew
>
> ---
> pw-bot: cr

