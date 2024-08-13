Return-Path: <netdev+bounces-117924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7E94FDE1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 08:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0268EB212CB
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58573218B;
	Tue, 13 Aug 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY1VIgIB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EFFA38;
	Tue, 13 Aug 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530741; cv=none; b=pWGfap1xR426x8lwQZjDfJtfv70AYL+5kPvsxYqJ/XvTeCneL110LMGtH8IdtIYrRgY6IjVoi768uZQE45WJ2n3/u3alk3fytp6G+uWZwwS1ywL8RuxEtKPwUNYc7JbmjKEAELpv0K7MsdLuUYWBEYvyAsMTJdRZXFr5XjGETVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530741; c=relaxed/simple;
	bh=Scht2teRvd9wrXAQi4J4232Xwe3lKglEDbeja/d0A6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz9/pEQH8jSfDsu0etfJxXIn7dDul883Txm0ixVpVB1aScPUaU8tpQdqjvfYMylWZttYwKaGRmaDxQzVXpevyvDcnxB47fILg4mVxr9Z83GH1XS0c4K7+NnryKeO8859LA8zvdo6PjUxwoKwbAPbNPPBKiqtPPcpqsz1XcG9/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY1VIgIB; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-664b4589b1aso47562267b3.1;
        Mon, 12 Aug 2024 23:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723530739; x=1724135539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+lp+6ga0pU9laZ07nXGFAMwhQ6m6VJIn8wZydb8H98=;
        b=VY1VIgIBTjTKCB+WTJ9plUxc7HqgykQVm8mWOoZk5mrckPLBuTGDF/l5xZf3ExEScR
         KSP6VDYkNybGyo25o0B8+DnJFzZ7WmNDJWmSEJ6GxjVXv6AMTC1AgWgz/JjbPz+H/4lv
         QD+c1P5B1KlLHFiCq2i+VwSzN2jOKVfTPbeJrbhBGUDuQm8iPUXHPsYND7IZQlXAX9ed
         QbFAZWtdGv55U89dk1Rew34KhMvM7PQZUL9FrgfrkD05vRdjqT9QRNHgvPteo03t2h42
         D4RAewclVnv+2gKFYrdkC0cyxVZuDCAV+nobQSi//n0wX8EEYE1moKJxMvOhm6iMfUsx
         XQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723530739; x=1724135539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+lp+6ga0pU9laZ07nXGFAMwhQ6m6VJIn8wZydb8H98=;
        b=EgDr4iRSuXj+rR/4ehZmO/VjQNtMcTmz6mVF0o2zBLn4jHttwRRDLnplpipNbxhPum
         sxZuWFOofrFQ003XdrkzbkEp3fVzuxuiLSZq71wt5mgP18APQkzcKXymkiO7k16ydEi/
         ihuChZRDrfl9c6eT2mR6Eo8cUH5dmcbwVF7c1HXBeMEbU4XSXBC5ui8jY3ScaoNvqtn1
         oxJZ/CH7s7No8XBLkp1Pk6idzzkxRhiQOqr8pLJtNeaCnHT4S50kYJ/N4Z0+GXSNKF36
         y+aPc3HiEV3JGCoAXuAY14q7yPI+VmLakJkTa31CaBU/eVL51vvqB38Y8C6+TM6aK/sw
         adqg==
X-Forwarded-Encrypted: i=1; AJvYcCU3NCIa9xADuIBMdqhgAZF4P70w1HjmmS6ZuDqWgDR7pPS97Mw162CEHR/9VPdGLJDCeEG/Z8jo7RqgQUKkslQTXFB/dSpzNS/ToQSo
X-Gm-Message-State: AOJu0YxvuW1ZuZhz7P1Fx6BTF8amBNho2XKVE0zVHEHFY4tiUG/EVgdp
	RtQALCrTlSuxPkVG1MlDrN8KXVQkLVvSorj3HSRGg+XsZLiKq1gj5oqjCKbQfR06kc8PYEffY0v
	1MCcwi/dMlS223IdAl4oCNRgngU+LUdg9
X-Google-Smtp-Source: AGHT+IFsV/KI6dci/F7G0iXCwf2EV9DUTE3HBVc+eezsckmOzEWDNwXUcaxaN3BKNBZAXWq4dPqE4JGAQjwrv2MBLQI=
X-Received: by 2002:a05:690c:4501:b0:65f:96e9:42f4 with SMTP id
 00721157ae682-6a9e7656cccmr17096487b3.15.1723530739210; Mon, 12 Aug 2024
 23:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813061728.GB3072284@maili.marvell.com>
In-Reply-To: <20240813061728.GB3072284@maili.marvell.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 12 Aug 2024 23:32:08 -0700
Message-ID: <CAKxU2N-hBo84N4uR9-Vk2wx3FRk_j644_tnKbMRsj7BCX6hC1A@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: ag71xx: use devm for register_netdev
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:17=E2=80=AFPM Ratheesh Kannoth <rkannoth@marvell=
.com> wrote:
>
> On 2024-08-13 at 00:36:53, Rosen Penev (rosenp@gmail.com) wrote:
> >
> > -     err =3D register_netdev(ndev);
> > +     err =3D devm_register_netdev(ndev);
> devm_register_netdev() needs two arguments.
Rebasing error. Will be fixed in v2.
>
> >

