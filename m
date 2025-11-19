Return-Path: <netdev+bounces-239883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C2C6D8AB
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A87F4F1215
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2E3090C6;
	Wed, 19 Nov 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TccGqokl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24732307AE0
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542293; cv=none; b=Nsph/kTCScYJWk4kM1IkUICwWgsEI8TVxTix8D19QjCUNGeiW244adj8HpIqyUYvUftXglA89G9h/vs8u7QLUnJWSoHo2P7Et2ISxNxm3RUsLrVb6ym9zsmc73sjUcQslJD75x6pNH5T4IXRo+gqcqPa+p5H3DS1LFz6fX1iMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542293; c=relaxed/simple;
	bh=ee7eIKYLxltvb9luhLPfWOa0bbdGd3NypbFBXy7NrLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sk38uUDaySLo5SqChyIb4coWp8r9qsURpgr2EHEpTV14dysLIxN7R6I7Mfd9JTPl44emPnRld2uaLscaUXypBa1/UiCGyWYauoOknw/LWqZHrc4H7QsCiRVQujBhdVcpGY5gNzFYWKvpiRtGNXaF6D1IrhwjhXKZDAytcPnZmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TccGqokl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee13dc0c52so29629621cf.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763542290; x=1764147090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PzdkOYousQrSY2rOnG5T82fyKw0YgPsDtubwnKB1Bc=;
        b=TccGqoklVTlmdWWsvUgK7A6YdymKUz2uVY5HJZbtUFQ+JSzE7TlE91757DSSwHcFx/
         abLGpnxDeRjkQVw+lZG6J+7RS8IoH0MGPjG9DUWFlL3QN6E+k0KcwqqnIIwDfnCtcMnT
         NVHsTO3aV0RyDnqMy5erjc0zuC3kRrlmSF60iJikaPHrvhK0R/lHQkd29Hd4xGYyq5Kw
         7SlAFFNXhdJPJ03+flkwNrXmypsYa3Jx2pLVvh3O3rRq+uidmxnfnE3778pPsuUv7arZ
         w1MEUc6JrS+1HCYEeK1yjsRUPjBcuvsVm5OFwJ+W+l0ppilpHwHfInPtLFJb39hwsuZt
         y6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542290; x=1764147090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9PzdkOYousQrSY2rOnG5T82fyKw0YgPsDtubwnKB1Bc=;
        b=SWan60CFaAx4ON3IJUz8RoUA9n45Kpbd3uThfn/fqYBd20HJrw/hpoQ51F2uUeVnMu
         PZi3JIcyLDzAMCUCrTAa8XUkN+CCZ50brHc1sSNmSpwxJoNg7rffYV0Fa1AEMYplmt7j
         3wFxuHVi3adin9h5P86bxR8JufMPC+tWEOPrs3HrIetENxxgYEe5LAcVEuKQrxdnocSG
         Gux0G/0QfcO3NwvQ6VfSLYOI9g1j8U1qMeJx4+53qcFQm7mIcpqaDOHt+lryDffBDuac
         WLvDr/0sNJeNVza31JzzSiOYWBJ6hBHlMfKubh97XweL0JEB3nnRhbKmAC9P7HFYIA2C
         pPBg==
X-Forwarded-Encrypted: i=1; AJvYcCUrQtUm3irGKRw7lC3xZbI5pia4dH3IF+qeeZgp9w7tX8mPXKbaCdLp88bKV5DXKwL5sstpv3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxC1zLU99VcbZoc5RN3tQoub8cOqOwv0ehT6R9Rmv/A6tDKd+
	rRf7mvyIVzOiAKgVAikaHoF4/RQcDR315a5aLiIw2IZbM3NJ1K78GsNa393tzE5JvUfLHxhHlvd
	h1bcP5owT7S/U14OGFRybWU6D0jrN0r/wyFnppbcf
X-Gm-Gg: ASbGncupkkXpD34S6evPWi5EG8ZhQm8JDJU2MyfhJ/iB03NeAe2fsM0DE/yq/xqiq5S
	ys1Cz4iQLHvdLoKWLsY5ieZEHxBj8tJZVaMC+qsueKhnz16DAWm2pWSkTPDy14xsA8ej9nwBTAJ
	/IO7Uz3DQqLlkDlH8sv23JAmKJqI+Fh1ClBBXBmdGYSBqiZq9b30pKgk8M8pewUPQDkzuKfb8/9
	HPUAahtIYogGRLuAvz/EVFKdTr/BY2Hwqwu4hcNL8QoO/VP6W4EtLsGccZGYUmLhEA8
X-Google-Smtp-Source: AGHT+IHqnaq1dnuT0/YFHHGEZtmwTLGpCIC27a5rS5AmgK2FX1w+IoEXNvJINEKEKYUZnzpuDOyxD7L3UrQ6druGve0=
X-Received: by 2002:ac8:5f93:0:b0:4ee:1b37:c9da with SMTP id
 d75a77b69052e-4ee1b37cc71mr119997681cf.17.1763542289535; Wed, 19 Nov 2025
 00:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117144309.114489-1-horatiu.vultur@microchip.com>
 <11ca041a-3f5b-4342-8d50-a5798827bfa7@lunn.ch> <20251119082646.y3afgrypbknp2t2g@DEN-DL-M31836.microchip.com>
In-Reply-To: <20251119082646.y3afgrypbknp2t2g@DEN-DL-M31836.microchip.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Nov 2025 00:51:18 -0800
X-Gm-Features: AWmQ_bk2GqEX4bm8Ggh-VH2AOGTcGYpyk3Q1NxUXfE0QpMeaNtJLm5SaeqgtGRE
Message-ID: <CANn89iKzVa+FNuWF7PZ-Cbq81Fj0pxeP74rD2gsjbg7NHEcOjA@mail.gmail.com>
Subject: Re: [PATCH net] net: lan966x: Fix the initialization of taprio
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 12:26=E2=80=AFAM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The 11/18/2025 20:20, Andrew Lunn wrote:
>
> Hi Andrew,
>
> >
> > On Mon, Nov 17, 2025 at 03:43:09PM +0100, Horatiu Vultur wrote:
> > > To initialize the taprio block in lan966x, it is required to configur=
e
> > > the register REVISIT_DLY. The purpose of this register is to set the
> > > delay before revisit the next gate and the value of this register dep=
ends
> > > on the system clock. The problem is that the we calculated wrong the =
value
> > > of the system clock period in picoseconds. The actual system clock is
> > > ~165.617754MHZ and this correspond to a period of 6038 pico seconds a=
nd
> > > not 15125 as currently set.
> >
> > Is the system clock available as a linux clock? Can you do a
> > clk_get_rate() on it?
>
> Unfortunetly, I can not do clk_get_rate because in the device tree for th=
e
> switch node I don't have any clocks property. And maybe that is the
> problem because I have the system clock (sys_clk) in the lan966x.dtsi
> file. But if I go this way then I need add a bigger changeset and add
> it to multiple kernel trees which complicate the things.
> So maybe I should not change this patch and then create another one
> targeting net-next where I can start using clk_get_rate()

Or define a clock rate

#define LAN9X66_CLOCK_RATE 165617754

then use

return PICO /  LAN9X66_CLOCK_RATE;

This would look less random....

