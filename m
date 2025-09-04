Return-Path: <netdev+bounces-219770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086AB42EB0
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 03:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA57548312
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F94437A;
	Thu,  4 Sep 2025 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSbZPyZh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399586FC5
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947897; cv=none; b=iAbDk7VAv77DfwCbkENUpgMLzBA9XDQWBIgak7hn+6v7BCl/LNrsuPkH/ZD+Ild2aKYhXU+KYu0kbp8iuCKJ0zL6vnB/1b42E7CGJPiulolv96dgzFhVmHrAM7ojnLPywXNTrrRHe/w+xzB8Mkw08gPtZKoNb9eQpc+i5gl3zdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947897; c=relaxed/simple;
	bh=82y5kb4ye9MJv6nFHFCEvhWuw39kZAxYWqqNKJO97K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdI5y41zh4I6FGMJ3At/2K/DlqdnPTn4QqudUw/HE0F50MJzJTgXH80rvff/I9wwxoJHny86j/7SGklsk5vCxVww57CIx3hK7Mh+BYpuqm6N1JVdwINYVaBfv6hWyT1jfS0ogu9GpVSMDkEVZ1jSkHdzOJMMeSwVHSugPMRURuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSbZPyZh; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e96c48e7101so627484276.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756947894; x=1757552694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZtoOAcCbay+qQwYEvuE93/twRZ/IK5PgVEhK8+gTIU=;
        b=PSbZPyZhLGdchSufRsSsDfWsfiVC1yqE8aKmXQ3U/hwWE+ITc1zpdXtTyQAwK2WaU0
         MlAYr6pW/CIOKyX5XFlAk+K7bJpc/j6X1s47+jgAXpat9FHNAcUDuiTv1l3aH0u1QygK
         gWEsaRAkw67G11Ulvpuman3Kayna7OupDQSDk311xkVX7+TGXCWG2gGbrJuffrRfvnfD
         9Bg98gyQ185NWLHJxbZNvPznwtv9dqfQ+C+MS0OayrwhxmE6Diuc8Zr0tQyjZa5eWUMM
         /Kr48k9hNvQpPDrlDv4fRdTK+xc6yIxaPKj6PekrKYWjJ+OmwkLj/xHXYUkVFVua1/IM
         aUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756947894; x=1757552694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZtoOAcCbay+qQwYEvuE93/twRZ/IK5PgVEhK8+gTIU=;
        b=B4MTw9Y0Lipk9o2dW8ERRYNaG5YdMnFWfld9CNsXcliurihgpK56r9Gc2a09qEKrpo
         BRG5jFefWlYEI0f6H40p4s0ck0JAEgl/Hu5a9CNojSkIRqSSrXi0pdEdvEAvJgBn/N+U
         AlaN4QPqx8YDtQ8lfMqZ6wxzfoxNvE78X0lHt9ESNg6x5quH7iI1epycR4TEWTF3wyYf
         ZN+89FBqT5UxP3sst97/WMAwmskng1EGGWxtd83kMK4adCey5Y7SRJkgrnBH3uvjk3om
         sB61wxrb2AiWBhSy/1pPMlIrDC1ArM/iX0XJuzOjTJ9pm4I/Bd66oDBXFPGoC5XqkdeA
         /FIg==
X-Gm-Message-State: AOJu0Yy2jQlH3UPn7KjYcBUVe87pGxObzku5x2hleqZhjDQPyIKwlYx8
	twGoggnfCXJmFdzl4WYNoYSrwlIHVDyi3POb0cH1P+ngIfdt6ynkYl8CyRapMAlE+AfA1o0RVv2
	fRcTVwOAC/66A0elpZAM/pF8BeJSqoec=
X-Gm-Gg: ASbGnctQNq8EaiBLF1TLSrWY8v3OPT0LxvVu5/GY6xwhTZwB0VXfzRkrBuQiiyjYBWl
	HqMOS9pgK0WMLezKQWlhZ0dTSctyv18TqIjCQNVwz4NNv7OdGBKGTuFcp4HPVxhYO2X7EEizpip
	VicWPXb33QiDhoIQVERP8QQc0cUiNJ3JCoQYKFGJmkLZRoXyU4cXuIZMpRzJEJpqUZaLdDU85pV
	tDUrhi1Wx781Xu8aqBo16ug9NiFngLsejIU3twJm1w/Co6HsJ5sIXVIn0R5MMIa40oQtISNRGrD
	omGI/PrYQLLYWM0lu3CW/3HSck7bMn43y3rs
X-Google-Smtp-Source: AGHT+IFXodEmabmqdi+RQ0xNTrLJ3ovzLsBWkW096/kbkXAE5Wk8l87D9EpT/Pmxp2i03UVQ5kbynYW2qC88SRFjVtE=
X-Received: by 2002:a05:690c:688b:b0:724:a06b:cb2c with SMTP id
 00721157ae682-724a06bd595mr31300957b3.25.1756947894090; Wed, 03 Sep 2025
 18:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901202001.27024-1-rosenp@gmail.com> <20250901202001.27024-3-rosenp@gmail.com>
 <20250903165509.6617e812@kernel.org>
In-Reply-To: <20250903165509.6617e812@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 3 Sep 2025 18:04:42 -0700
X-Gm-Features: Ac12FXz8riJEWGhOyqGye8BQMSXHZ1ki0F4yjZMwAYweO9JVtT_NZJxFIpbNt88
Message-ID: <CAKxU2N_RaPLj07ZqxtefPUJCnRbThZjKhpqfpey9QB2g3kNfsw@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 2/2] net: lan966x: convert fwnode to of
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER" <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  1 Sep 2025 13:20:01 -0700 Rosen Penev wrote:
> > This is a purely OF driver. There's no need for fwnode to handle any of
> > this, with the exception being phylik_create. Use of_fwnode_handle for
> > that.
>
> Not sure this is worth cleaning up, but I'm not an OF API expert.
> It's pretty odd that you're sneaking in an extra error check in
> such a cleanup patch without even mentioning it.
git grep shows most drivers handling the error.

git grep of_get_phy_mode drivers/ | grep -v =3D | wc -l
7
git grep \ =3D\ of_get_phy_mode drivers/ | wc -l
48

I don't see why it should be different here.

Actually without handling the error, phy_mode gets used unassigned in
lan966x_probe_port

The fwnode API is different as it conflates int and phy_connection_t
as the same thing.
> --
> pw-bot: cr

