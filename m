Return-Path: <netdev+bounces-200155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4035CAE3714
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD68E1719A5
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023161EFF9B;
	Mon, 23 Jun 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VgwVTpFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05B1F4C90
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664176; cv=none; b=nN2P+Y/PpuQEqMkhTkV6tKrbR36EnfPJ7ctw+rslNoAGwoJII+u05GDn/rdI66XKaIlU+cSvyHf1NgP0POZxIGlkoYguSEVsj6o3WP361bgM3j8+seMu6dadn3h7wA4lRe1VBTfXZaFH6+l/komYybKFx3zlKluK/+VV8/T17Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664176; c=relaxed/simple;
	bh=w+3qbmZ+/Fzih2MTelSdaDcNnHFx2K5wHnL/eTsCyys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgGS2oz1tq3GGQVaMOR+h6jSkFoQYpmRp0PVJSHyQTCSkZxfE+EI1C4uSv+1dl1P5czKEchDCC0OmcqgYn0tgP85Dstuhb5+RLWr1c1Js/qpp7KZHwWrZKiWcEGfrpvKHQUNn3GCPAcGgm/64mwsVioEFRE2/d/LfeBuBh/bs6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VgwVTpFX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a5828d26e4so609288f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750664173; x=1751268973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+3qbmZ+/Fzih2MTelSdaDcNnHFx2K5wHnL/eTsCyys=;
        b=VgwVTpFXYnXMmKkwwR1C+MvWG4pgWpxpA+TvvHS+kNX467zWiGKrYvfK+uPzPML6iq
         s8GaaSXCVWL5lh9F9ZrBW1iT9mjBH3SI6G1rwJ6So1ynwM6fplh6qrsdXr0xHSLWOVXt
         3Y3ah9TzdxsO9VaMexNtfS+/sKG4sCiCBUNyNIt84GHbs16zsbWAjPBvVPqOYeSuE+RU
         oZNH3KtuaYIodq8727OV3SuvfenfUCaOfU13/UAO2OKoUK/ffnxHIAFvnI7JMQZb2OmK
         obtnvtKu1THrGhrByu8iMgkkSR+RG3qi92D34exCFbQNICm92gC4mgpF6csVKx6M7VGo
         gWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750664173; x=1751268973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+3qbmZ+/Fzih2MTelSdaDcNnHFx2K5wHnL/eTsCyys=;
        b=bGtVMPfJkgfmaqUCH5XaF15EiC58vrw0jP/F47tV43G28zw9c88Mtf5gmLJdXiEwwV
         Ml6V4Cpm00fRBFx348spgNP0oWaKwjUnfGbmCZYust6/JKG2koJaGXVGdFJD/XzmdWf9
         c6vPMT6i1/u8tysjEGGCVizsElyWO7amUuOgx02zOshgoJy+Hl28p0SMe1mzmnYxIT0S
         f8sQMFsxTjhwXvGQfzFy7LAqIZ6eRUhrN3bRlUTyaLdIpy1QA8Lx+sTfRvDLQnEwimLl
         bFkMelLdCUxQ8HwmkTyIExxxTqO6XdgulVNJw33EMrh4maDYCCX6QJNCFN2uBODz8isP
         JjRA==
X-Forwarded-Encrypted: i=1; AJvYcCXSRXX+dN/A06bQbqisfHXrye14rvwa0Zp2YR8Tzu/ISiCoIbY6xNkXtdTRjd2O9h7npOyUNGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtuCeNQ3uYfJjuj/SSNWXU8LRs9+uRqoh4wHo2WDnIqUGbElb
	SOseozLqbnvqXIGsjjdGFbwpEd3nyf6Hw15+FnRdROgk7XwPhcM3VDx5g4Uqpgqkaeo=
X-Gm-Gg: ASbGncuoQYwJi0PCTW3VJDMWHNxTqoLETB4WOgnobxDmkyB/jpkiBBXxubCaWHwPEMF
	clExsz0O6N5a+t54yS9YMagfLIR7ioJxXqYSTRARztQhaE6qQqxsgoedOgBOeuAYXf+046eXot1
	NVYOKI52zEe1c4v3BNCNd7RmrIh/g1WNDHKRJfLu8yJb1ZtbxUtBMk1dOxKgSOsFgZSnC4cGgmA
	iz4L5VFiEJBo0iETEi9CtVW2GrE9UzpJkcVjU00HVcZAUAWQHLSMDs6w3hCwqcn5TzQS3No+C93
	JkzNPboMI2Tt4QPgj7kWnlFMLA8BpfyfKm4y++elFVb0apZAvLzGtqwp8J7AOnqkeSXVkRvBuIZ
	EGN19nlNHg+KnjGe5yuZV4bx9QDOLz3nG3V1X/sAylpaI4cuquNTchmrDOE/UIR4JqmY=
X-Google-Smtp-Source: AGHT+IF8cAJKU0uDUbsIxPPaSCr7igCmeTXnBbWub3AL1j9L+jNBLIxdzW27wopPloNnbvH5RjVzEw==
X-Received: by 2002:a05:600c:4747:b0:441:b397:e324 with SMTP id 5b1f17b1804b1-453659ca904mr40838535e9.9.1750664172885;
        Mon, 23 Jun 2025 00:36:12 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8e19sm134858005e9.21.2025.06.23.00.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 00:36:12 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:36:04 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "open list:NETWORKING [TCP]"
 <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 0/2] tcp_metrics: fix hanlding of route options
Message-ID: <20250623093604.01b74726@mordecai.tesarici.cz>
In-Reply-To: <CANn89iLrJiqu1SdjKfkOPcSktvmAUWR2rJWkiPdvzQn+MMAOPg@mail.gmail.com>
References: <20250620125644.1045603-1-ptesarik@suse.com>
	<CANn89iLrJiqu1SdjKfkOPcSktvmAUWR2rJWkiPdvzQn+MMAOPg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jun 2025 06:24:23 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Fri, Jun 20, 2025 at 5:57=E2=80=AFAM Petr Tesarik <ptesarik@suse.com> =
wrote:
> >
> > I ran into a couple of issues while trying to tweak TCP congestion
> > avoidance to analyze a potential performance regression. It turns out
> > that overriding the parameters with ip-route(8) does not work as
> > expected and appears to be buggy. =20
>=20
> Hi Petr
>=20
> Could you add packetdrill tests as well ?

Glad to do that. But it will be my first time. ;-) Is there a tutorial?
I looked under Documentation/ and didn't see anything.

> Given this could accidentally break user setups, maybe net-next would be =
safer.

Yeah, you're right. Technically, it is a bugfix, but if it's been
broken for more than a decade without anyone complaining, it can't be
super-urgent.

> Some of us disable tcp_metrics, because metrics used one minute (or
> few seconds) in the past are not very helpful, and source of
> confusion.
>=20
> (/proc/sys/net/ipv4/tcp_no_metrics_save set to 1)

Yes, I know about that one. FWIW it didn't help at all in my case,
because then the value from the routing table was ALWAYS ignored...

Petr T

