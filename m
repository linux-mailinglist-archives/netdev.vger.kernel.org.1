Return-Path: <netdev+bounces-191665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E35ABCA50
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD9C3B3F8A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB1223313;
	Mon, 19 May 2025 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsmHtKsz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810622126A;
	Mon, 19 May 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691018; cv=none; b=Bg4ruNRdkOFA/NvYeQfTENoczJIiROM8aDcP2KbVjp7dE+w2FPVeVip2CA0TUI72S+XMUJOc6j1/EYMHcBtaLw3iQHlC9ex4LmZR7arO6gC/3mbU98C4VxkFfi5NM4lcNZHMezawrMjNZyRB469Jr9IQkLkCqVnReeWFaEYXpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691018; c=relaxed/simple;
	bh=eoKyZZeh4dCJi1ifrO/HYH0EZs1icYueUurBrUQhaeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ov5os74jB7S/V07Zk5AzngxIP7GoV3FgFtq3Em/zv0fdKw4Y7+8L0IylI7m16f6ZNLIbobrKVDJV3f9JfwbjD50nxLmbblwGyVOexvg8wYVeNF+kcd+/JzhyFHsP2aV36sYSRFBF3zJQc/VgCVNPIn2yotxEPD3nhy+q+5cU1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsmHtKsz; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-703cd93820fso44541027b3.2;
        Mon, 19 May 2025 14:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747691015; x=1748295815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoKyZZeh4dCJi1ifrO/HYH0EZs1icYueUurBrUQhaeQ=;
        b=gsmHtKszgz6TJfDMsA/E/PLiNnMw0TSc1qklHbowRZVSLX4p7NUjTkKiWTfq6lKAqk
         ewSHn33OCum5XU2xAFtKYBucDvJg6uUKxZV3DJiOubn5PfgPSwOAhPfUQdQSrYz0H2HY
         zig3ufO0D5kq5qBudc+NoLXmzfV+H0W7Mx6XF4y4RDXq3O1SIS9lQj2Tlf4i93Y6WFd6
         hzHZ3c8BV3UW9hQIxNRnIlDtKaYVeMSmKw6d0cnz+88Q3lZNfpxBoTYqayJ9SLGdNFjD
         V1wMsJdF9iRMZPqEG3GM0hLe3lRFbKEHbsXTpJdExv5J/fl4o6tfCG9K9CuXm1TuKnXQ
         yLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747691015; x=1748295815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoKyZZeh4dCJi1ifrO/HYH0EZs1icYueUurBrUQhaeQ=;
        b=r0dscLAlIjSgX/swd3GV/Ois7YHgA+IASguGj0nzwuB7s7y2uG40do6QtW//SvzqJI
         H5K7nnnY9TVafZ/qlbVTu7LCHEkW0QOTw/4XDXIcmvjsYOq7BaMZejqPLFr2iTHexxO4
         9ztIwdazlx+p9oErHyhPywrOQLZt+xcKP+ckhK3KonuBi8yCkKZHSnx25Lr38jacjiXV
         j8KvQ0Kdiw62p8QShY/62JrDTPHXEPwQGwdWupxU1B2C0YgKUGro+k8o9tts8i19Iq1J
         h/l3BGY51y7FByWbPYkuKKSLeW2w3kSZSo1Lwkax34ptfqbhaOHPRFvXFBT0fA7itftk
         dH6g==
X-Forwarded-Encrypted: i=1; AJvYcCWNU+zNnOJWLTJrhvewyVE0/8viNQ2gasH5+DJMao5fv+lqeuAjVf+l1vk+mU1+tVkXfK9fA8l4@vger.kernel.org, AJvYcCX1xn6RNqeneWaRRevoWo+GTDXm+bT3JG91zs5SXkaygpFh1dp3cXSZYRaRQQdXnvjM6PMgs6pfdior8OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE9uGpXZZbGRQ/xjeAL0O6bZ2OjQhyB+v8lybRvHdDwQYQMBwW
	XCqOsZm5YPYa1BfAIIPZv4X2eOsNdVfBRFnRWBjN7jkqqeloB0eqLuYwLMprfpkRcXtrEVddVUR
	3vN7BjkIUXifVH9yzJVQclr3Dv8WQHIw=
X-Gm-Gg: ASbGncvV1zqw9px9xgkFexjbcl19PQvFIQDT73Dq2hR+IRsezdnjwpxTi+axKzBSIh2
	p5jP9jz2xNWlltVP8JXcXWt48MxP+Ov8UIyupaL1th2vSW8vgR8O3wGfIX/Dq1M6ROOJct9ZcRb
	Cxy7j/nv4x8HRQ8QvWMdZ3DpoeEwYfi7k=
X-Google-Smtp-Source: AGHT+IEVUXmqrqf2co1CDu/Xmw3prCw0ZQz+oMhqZMl6b1KMNFNeeeKC4jcgxBIUdxXH/dECMmbWYTHGehpcjK3jYz8=
X-Received: by 2002:a05:690c:951b:b0:708:35b1:d55b with SMTP id
 00721157ae682-70caaf38bc4mr144684617b3.8.1747691015300; Mon, 19 May 2025
 14:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
 <20250519174550.1486064-3-jonas.gorski@gmail.com> <ed75677c-c3fb-41d1-a2cd-dd84d224ffe3@lunn.ch>
 <CAOiHx=nwbs7030GKZHLc6Pc6LA6Hqq0NYfNSt=3zOgnj5zpAYQ@mail.gmail.com> <2e5e16a1-e59e-470d-a1d9-618a1b9efdd4@lunn.ch>
In-Reply-To: <2e5e16a1-e59e-470d-a1d9-618a1b9efdd4@lunn.ch>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 19 May 2025 23:43:24 +0200
X-Gm-Features: AX0GCFs0Cd-tkQBXp_ukkEPbXXlQllmjZxbVCmyPTiMZwzFkGeq5Bg99ndcdFpg
Message-ID: <CAOiHx=mQ8z1CO1V-8b=7pjK-Hm9_4-tcvucKXpM1i+eOOB4axg@mail.gmail.com>
Subject: Re: [PATCH net 2/3] net: dsa: b53: fix configuring RGMII delay on bcm63xx
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vivien Didelot <vivien.didelot@gmail.com>, =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 10:34=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > > These changes look wrong. There is more background here:
> > >
> > > https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/devic=
etree/bindings/net/ethernet-controller.yaml#L287
> >
> > This is what makes it work for me (I tested all four modes, rgmii,
> > rgmii-id, rgmii-txid and rgmii-rxid).
>
> So you have rgmii-id which works, and the rest are broken?

I have four rgmii ports with PHYs, I configured each one to a
different mode (rgmii, rgmii-txid, rgmii-rxid, rgmii-id).

Without this change no mode/port works, since there is always either a
0 ns delay or a 4 ns delay in the rx/tx paths (I assume, I have no
equipment to measure).

With this change all modes/ports work. With "rgmii-id" the mac doesn't
configure any delays (and the phy does instead), with "rgmii" it's
vice versa, so there is always the expected 2 ns delay. Same for rxid
and txid.

Though on testing again RGMII_CTRL_TIMING_SEL doesn't seem to be needed.

> > E.g. with a phy-mode of "rgmii-id", both b53 and the PHY driver would
> > enable rx and tx delays, causing the delays to be 4 ns instead of 2
> > ns. So I don't see how this could have ever worked.
>
> In this situation, the switch port is playing the role of MAC. Hence i
> would stick to what is suggested in ethernet-controller.yaml. The MAC
> does not add any delays, and leaves it to the PHY.
> phylink_fwnode_phy_connect() gets the phy-mode from the DT blob, and
> passes it to phylib when it calls phy_attach_direct().
>
> There is a second use case for DSA, when the port is connected to the
> host, i.e. the port is a CPU port. In that setup, the port is playing
> the PHY side of the RGMII connection, with the host conduit interface
> being the MAC. In that setup, the above recommendations is that the
> conduit interface does not add delays, with the expectation the 'PHY'
> adds the delays. Then the DSA port does need to add delays. So you
> might want to use dsa_is_cpu_port() to decide if to add delays or not.

The Switch is always integrated into the host SoC, so there is no
(r)gmii cpu port to configure. There's basically directly attached DMA
to/from the buffers of the cpu port. Not sure if there are even
buffers, or if it is a direct to DMA delivery.

Best Regards,
Jonas

