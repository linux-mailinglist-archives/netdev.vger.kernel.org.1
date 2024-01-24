Return-Path: <netdev+bounces-65343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC783A1D2
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 07:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00244B26422
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 06:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B3E579;
	Wed, 24 Jan 2024 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fvpB4voo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E563AA
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076650; cv=none; b=FZgDroJDR7gc/1/x/em97Rpg9ZbbORKDGgFQd6nr24jIjH7Uk7gP9Zd9RG47CjRwyQel2wRM53UMkJcn/ZxT6hBVxcsuwU+4ok0By5H8+cNi2GpsGc74+SMVpmB9PkV/riqf9KShW7YiHphmdtlPi1ab8mtQjxp4Ivi4x6P4ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076650; c=relaxed/simple;
	bh=vajM2OVTOya+vobW9bkj1vHe99vPM7B2G5ZahYReiiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzBSqxzlIb4jNDJ9N2tjydtkb6lQ9T3+1RxW4GI6sdi88hK/4cYxdLRcHj7xpDgy/voNoqRDIu3Rl3iBaCDNzX3gjZwd5mrVKM3O/U/yWIKYU57TsnQUqOo0zNE38vRbYI9T9Kwce067fFVV5C1UrKgNxHA5o2LcNDL6tAmGkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=fvpB4voo; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc227feab99so4977522276.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 22:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706076645; x=1706681445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vajM2OVTOya+vobW9bkj1vHe99vPM7B2G5ZahYReiiU=;
        b=fvpB4voovaKQT1c1QSwcrgpSzG1/uZeBgU7EQXCLbhIVXugEfdarNbFvcHUEFAumbO
         fPpv8fvk2RrP1atY9k61zT5tISOgVqNnQlVKrGPISvNZy/y/7IB0uTg5qzurjlXGz7sE
         3qFKHocTwuxXACfOGix8G0y0TxKndpeuE0M3zdSFe76WOM3SuLC+HAZZTMGuDkwn9fT2
         IoZY0Kf0mefpdtRoTTk1piX/oAVFsHwk3uArm3xUj5ELN6q5OGe3tbG+UBMeLxr839J+
         vj9ysX2vex/fvmr+msNRhtVsCctySx7FqrFG52jVYBPWHznKmy4m6DDiD/TvjX/ZpSZ3
         zb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706076645; x=1706681445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vajM2OVTOya+vobW9bkj1vHe99vPM7B2G5ZahYReiiU=;
        b=Bh3KzdDsXVpo0RYZPQjz35WBqmIOZswAGJX9JDnpXZuW06oswBPKTXhqexMvU1gI9e
         dwRUw51Qh5Q+fCo+AfmLJnIWMFO5+2RsTgssfwlVteXfl32GGQW/cQMRDhQXIlzNCZMw
         I0ZI8nQZEJIL03eRP/nEP+M/jpijWAA41fYauXQegyp2+WAhjRg56/ABCEKOIZmgjDon
         meifBLqoU91eDTibXsg1XKcS2nAvevKYfd248PuXQYtnd2Vcs2i9NxZS2gHUyTWpHJjy
         9R4crvv20twf4Dmr597JBIBx/OUhCTH2ItQsA5TCav+c9qhN7ZQPBIePM24uOjz/QfBw
         9Hzw==
X-Gm-Message-State: AOJu0YyDeZeRXdjAkU0mXw8cXGH3OhBmsp3BNb9sIlmMFMgoyyYmtfM0
	wBUyH5evDoM/sS0TC+3FaZDwhtod4na6L/DfejWwElol8ObZkj43YjxUpeovt0km0Ye6MmCol2B
	ShcDo9rgxG7FxM+/LPaBbFdydcCzgHTqqaPeBiQ==
X-Google-Smtp-Source: AGHT+IEifamxfhVU3pyFzkjl1xeGIFOosedSeQUaLnWSRC6ia7G27iTM+8JLA2R1j86zPrb5lPPCT4QzYV4gWmeRaIk=
X-Received: by 2002:a25:df96:0:b0:dc3:6d8c:c1ed with SMTP id
 w144-20020a25df96000000b00dc36d8cc1edmr222955ybg.106.1706076645136; Tue, 23
 Jan 2024 22:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALNs47v8x8RsV=EOKQnsL3RFycbY9asrq9bBV5z-sLjYYy+AVw@mail.gmail.com>
 <CAM0EoM=1C2xWi1HHoD9ihHD_c6AfQLFKYt4_Y=rnu+YeGX7qMA@mail.gmail.com>
In-Reply-To: <CAM0EoM=1C2xWi1HHoD9ihHD_c6AfQLFKYt4_Y=rnu+YeGX7qMA@mail.gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 24 Jan 2024 00:10:34 -0600
Message-ID: <CALNs47sqEzW831Sjh7WzgaVrLQJmM9b0=8bhkWLrR3592GU4vg@mail.gmail.com>
Subject: Re: Suggestions for TC Rust Projects
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:23=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
> [...]
>
> I think a good starting point would be tc actions. You can write a
> simple hello world action.
> Actions will put to test your approach for implementing netlink and
> skbs which are widely used in the net stack for both control(by
> netlink) and the runtime datapath. If you can jump that hoop it will
> open a lot of doors for you into the network stack.
> Here's a simple action:
> https://elixir.bootlin.com/linux/v6.8-rc1/source/net/sched/act_simple.c
> Actually that one may be hiding a lot of abstractions - but if you
> look at it we can discuss what it is hiding.

That sounds great, getting an OOT equivalent should be a feasible
first step. I will pass the information along.

> Note: We have written user space netlink code using rust and it was
> fine but the kernel side is more complex.

Would that be the code at https://github.com/rust-netlink? Seems like
a good reference in any case.

Thanks for the information,
Trevor

> cheers,
> jamal
>
> > We are getting more contributors interested in doing Rust work that
> > are looking for projects, so just collecting some ideas we can point
> > them at.
> >
> > Thanks,
> > Trevor

