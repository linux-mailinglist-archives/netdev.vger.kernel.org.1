Return-Path: <netdev+bounces-141729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8B9BC1F1
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AF41C215CB
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD9AF9DF;
	Tue,  5 Nov 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErrRJR1k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051A2AE99;
	Tue,  5 Nov 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766103; cv=none; b=bl/eYBHIHR4O/RbpH96x8HheGT7e12/Pfut9pgdtCzcsTVVdxvBXG9odtXMnT5s16MZXnJdPjq7f9saJQRnG6no4FKtVtVnP0xCF8cwl7dPSZD1XFTxQ6Ti0fdPbn0pKOZ78W9R5+u/Z0zEDQAPkP4aBUJN9t8ivOmP6f4/E7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766103; c=relaxed/simple;
	bh=OVd5a06EGZiG7o6pHHfnuZvQApvq91xiIr5lMA05WwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mycuj907lxaErcYpX3zjlO82hk3PClQfiUYPW9T1M9jsNkg7AB0EF1Ia1wY3GS+jq/7H7dXnY+KnoP0StHbZ9JTqmySIveY4kLfkB6Icd6ZnHFO4xsajf+tTeHRsxgg6TGR4oCvNOYoHNTqbcBf1twvBoDTLb15WQMvkvbS9Hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErrRJR1k; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84fb86af725so1465712241.0;
        Mon, 04 Nov 2024 16:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730766101; x=1731370901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIvv/7/0QkDr9+Lvtf+98/wsCpQczZvz/7XwQcz2uMA=;
        b=ErrRJR1kxKrlSEqt5C6CPi0oCOMjUgbZPpc7Xl5WEWLW1R06ecijAXJHylEIV9lXS1
         okL6+E2ztIhX+66KohYbIm+fp+innDL55eEP/2bQV0ZPnghtwYL8+zVP/0uheKYC8pFZ
         hVa4T7Z7XkFaznQ861VNHBRBpQMr8SF1vsgoojJOUqrxCZcgiYCN6fILrAMLi9cinEbM
         MHVXOtfjyUx1TeQ3OhKDrG31xW/AWh2BB789qxjJBuGmE+mnfCQkXw98q14CtiW41o0a
         u/RNMBmjW3wHZOlmhEQoFBGuvjjqL3E1T4O+/xunT8H0l8YiCVGgnVqNcXnrV7zyIHsP
         fUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730766101; x=1731370901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIvv/7/0QkDr9+Lvtf+98/wsCpQczZvz/7XwQcz2uMA=;
        b=Iy7+y3r0msSP6vtQA79/+EvuNfdovTvJa1ZiJCUs8cA1GKCsGb0dc+gIVJ6JRSMkxx
         VkH8SC42d+Yrqe/189iuB8E6ik+iekBmq2kVrUVvU2IfENubzBVI9KXv6n2ha8b7xlPV
         yrzZbTMoTZi+YcJtWFdUvafdzlFiHeU1IGeyMiMUvXR9ZyejBvB5B7vv75t0a4dJT+fT
         SIdVjA+1daMH82rteEHJHGNW5GPjenx9kXera3UJdL9f0Wck+3GUp+iflCdWU61d5FxY
         M41SR5Gt+NHDuvwXVeiDZHj9z+13XN8y0OI70puB51eQkFJZNthQp+CY5XEjzN9r1FXY
         zBjg==
X-Forwarded-Encrypted: i=1; AJvYcCWk7sV8tRgnd8RPADXIRnlyqDAvEpBCQ3QumNkDgHr9rFqn+i7rUj4Ildik/nZXYlg9mNbTiCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX89+0/8eDgqiJZdIwbvPdpaBKQiSS19ZJJpTHqWZuk1soB1Dr
	oNBJhEs5K0RfR+9hHfNT3Hzy+ekYaKq3ejR0ZdPQb/QinISHegDx83vQe66BrSycDlR/GLIpkcG
	ZSWhavJ6gTzVc46Y9eCnc5ld88KQ=
X-Google-Smtp-Source: AGHT+IE0kTYb0sj7pw21XZ3m2RUlLD0HX0IXzkLml5071iEe/AiO67lEdTv4icKYB5Ov7WJrBHEcIQVkQ2sEovV1yEY=
X-Received: by 2002:a05:6102:3706:b0:4a3:d9da:16d6 with SMTP id
 ada2fe7eead31-4a962d737cfmr12464247137.3.1730766101115; Mon, 04 Nov 2024
 16:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104070950.502719-1-alistair.francis@wdc.com> <9ae6af15-790a-4d34-901d-55fca0be9fd2@lunn.ch>
In-Reply-To: <9ae6af15-790a-4d34-901d-55fca0be9fd2@lunn.ch>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 10:21:15 +1000
Message-ID: <CAKmqyKOX8gcRT2dSOvJY2o4bpoF+VuPmhaygJj7pTb1KesrFOQ@mail.gmail.com>
Subject: Re: [PATCH] include: mdio: Guard inline function with CONFIG_MDIO
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux@armlinux.org.uk, hkallweit1@gmail.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:49=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Nov 04, 2024 at 05:09:50PM +1000, Alistair Francis wrote:
> > The static inline functions mdio45_ethtool_gset() and
> > mdio45_ethtool_ksettings_get() call mdio45_ethtool_gset_npage() and
> > mdio45_ethtool_ksettings_get_npage() which are both guarded by
> > CONFIG_MDIO. So let's only expose mdio45_ethtool_gset() and
> > mdio45_ethtool_ksettings_get() if CONFIG_MDIO is defined.
>
> Why? Are you fixing a linker error? A compiler error?

I'm investigating generating Rust bindings for static inline functions
(like mdio45_ethtool_gset() for example). But it fails to build when
there are functions defined in header files that call C functions that
aren't built due to Kconfig options.

This is one of those cases where mdio45_ethtool_gset() is always
included, but mdio45_ethtool_gset_npage() is conditionally built.

Alistair

>
> In general, we don't want #ifdef if they are not necessary, because
> they reduce the effectiveness of build testing.
>
>         Andrew

