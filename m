Return-Path: <netdev+bounces-191893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D0AABDC76
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05CF4C527F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C252475E3;
	Tue, 20 May 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFXz+6SA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196E24C060;
	Tue, 20 May 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750220; cv=none; b=d3VIrzC2WekLKfZhom+kisNfER829HGvtHvzLogblkEFFvJxuRIo/8LBkQra1qgpqvRiznLnw9N+sN0os5pJ90vTHxpScXXE7bVzxiBacX950IquV5AyOS+8S+VIWTthbjUrouF0S2h9WQ8Cl24xkBVQabNL1KPVfPMFot3Mn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750220; c=relaxed/simple;
	bh=bMmsrxEeVq0r7Qtu5nKyJAvcG6TULcyBlSKlhRfKfCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wz+pNO2o18AAY99pWxUmWy2R0N/QahmMCRPjpOL3nLkK/qrG9AdGKRFzyRdhuYqrNKbRgVjuooKSg3HPIv/c4jFCCch/e2VDFQurQOG0o6ciaeLAg9aUIZ1E2a9O4To5MRGxK9Ys3v5sS43uFIg65z5wuvhtlSP+3rqhNY5QSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFXz+6SA; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7d56716544so331350276.3;
        Tue, 20 May 2025 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747750216; x=1748355016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+Eo9ZxAXL6+ljXJitFZulGVk8fJXlmfVNiFnhGchF8=;
        b=TFXz+6SA6rlEenPQ/PRYsNJ23CjBOJAy5ns02OBA4HlqZ5DZzsbMbmgj5UzTMf8HF2
         3P6N6lcWILr2RldagbsCfKNv2wlBqKfu/KT/DBv4YBeuqy7nTGYpUdxSk40j4TPNRPw0
         HXepQA3ZCrAs2jc6BEkBY23K1RnhVb7TQhReHeuAbZfv5x4gJSHXxdDTtLJwDWxFQE+F
         otCewAnsFRq3/g8hJjNhANRVpC4Au+mNOFu5j9FiQGnnT1q2x8aTrRZbwJqa0ZL6rsXB
         GqJ1Pt/ClAFPrfBvSbUZCJbTT718xTpIvzi9x9tHLJk0TYNIZG+FhChU+VPqMbDk3CV3
         qBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750216; x=1748355016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+Eo9ZxAXL6+ljXJitFZulGVk8fJXlmfVNiFnhGchF8=;
        b=nCUqSKHj8oi2Gx10Gmi3GCILPfAh/lp5a4IdFwyRaMtFAxtHJ8SwrfE+aiQnX2+fAa
         vyHpyjodvLp7s8ym9hhfhxhKlK8D5ysKt5sjge+67pvfZx6Aho/v1mCzldfFGb1MdL9D
         ax708tb+JOviLPWh0ySzS3wCYnVyd/XPcUSVb0oARx1egtW18nMn8iA0ZE4SCLFj5Pm/
         z1inuq+6PuRd0aoNT//xGALG4mIFHvT/2flXD9KgrHh4WuxfXC/8NaeN4IFg0tzTfkcp
         oDvzQeaJWcFfSj9/uZvo0FAKX7fwg4vAFvJitOasLK0d28zjMJTYzEk6A282zNtszQlr
         /OUg==
X-Forwarded-Encrypted: i=1; AJvYcCWu//lGhDnhP6RBz2g+i7lTSCaF7IpfYPv/mPXCKRZA3ZlDyhxS6r9NFAAGk/wG6Rqw8ESR7hc+ysY85oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFUUlpoc0cYy7QKcElTWgESty9baQCF6B/rdaM2qhkntcy0Qo
	tweOiGHPg4IfpHBaraLc1rXmG4a8PYzfUMNYb0AJqKQtpio8QY6kjQlPVbOyTJW59vQ7pJeDu5U
	Z1/lpb8Du+VoGs+kK0QX839v8Go6rdkw=
X-Gm-Gg: ASbGnctK66v9ciD+ed4rzqk+QvrohjTAH/75sbbF72YrTEF7UMfo6tsbu5A7ht4xbIj
	EzXyq5Y7Q1E2PPEcsWfIcoRclDc4bSP5MVgBu4KzkmQ6kMVZQ72xTTgS0Qe+Qox5h2R4+CmcoYD
	WHQA5prkCQ11lNc2axs3rf7Wx5yDEZ9Q==
X-Google-Smtp-Source: AGHT+IH/d0wWM/ArdMMDQzKgUpLoG1e1XADDrY94vyj5OLW2yqBdqXYJLzIgwFjoc8FrINYPemo51m2yFiOuIeekchc=
X-Received: by 2002:a05:6902:1589:b0:e7a:b057:7e76 with SMTP id
 3f1490d57ef6-e7b6d447bc7mr21441922276.28.1747750215559; Tue, 20 May 2025
 07:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520124521.440639-1-stefano.radaelli21@gmail.com> <c8a05994-367f-42a4-8464-c0a0ea3bc748@lunn.ch>
In-Reply-To: <c8a05994-367f-42a4-8464-c0a0ea3bc748@lunn.ch>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Tue, 20 May 2025 16:09:59 +0200
X-Gm-Features: AX0GCFtOLXXdjG8G5aMCGKUGP-pNc18U-mKvaDxD8Mxn4l4qac3-bxeGBO3dprM
Message-ID: <CAK+owohzaLMB6Dxk1MSts8kZHy2bhmyJz18_jivjziRDzTG0RA@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net: phy: add driver for MaxLinear MxL86110 PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thank you very much for your time and patience
you dedicated to me in reviewing this patch.

I=E2=80=99ll include your Reviewed-by tag in the upcoming v5,
along with the minor fixes suggested by Mr. Alok Tiwari.

Best regards,

Stefano

Il giorno mar 20 mag 2025 alle ore 15:10 Andrew Lunn <andrew@lunn.ch>
ha scritto:
>
> On Tue, May 20, 2025 at 02:45:18PM +0200, stefano.radaelli21@gmail.com wr=
ote:
> > From: Stefano Radaelli <stefano.radaelli21@gmail.com>
> >
> > Add support for the MaxLinear MxL86110 Gigabit Ethernet PHY, a low-powe=
r,
> > cost-optimized transceiver supporting 10/100/1000 Mbps over twisted-pai=
r
> > copper, compliant with IEEE 802.3.
> >
> > The driver implements basic features such as:
> > - Device initialization
> > - RGMII interface timing configuration
> > - Wake-on-LAN support
> > - LED initialization and control via /sys/class/leds
> >
> > This driver has been tested on multiple Variscite boards, including:
> > - VAR-SOM-MX93 (i.MX93)
> > - VAR-SOM-MX8M-PLUS (i.MX8MP)
> >
> > Example boot log showing driver probe:
> > [    7.692101] imx-dwmac 428a0000.ethernet eth0:
> >         PHY [stmmac-0:00] driver [MXL86110 Gigabit Ethernet] (irq=3DPOL=
L)
> >
> > Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

