Return-Path: <netdev+bounces-191936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C6DABE005
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B191B6526A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD6E269CFA;
	Tue, 20 May 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwcFIuz+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEB2741B2
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757271; cv=none; b=MymEyfnAzVax54HAQu73sodWd9NrDc2St+Y+Ab5p1I3Uk8pVbMpJpS0FUw85WgFGVtzKiG6aLixdE99GOHtyFa1ZDAbGgflJWSe4ASAGP8Fpt5lQ4TiAeN703ilugj3AfgoTYaHgbkOmn9Mm4ecfZYSKUNuene0lqSLbwGsxTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757271; c=relaxed/simple;
	bh=KEmywsEn9OPiTNAgnQZWHfqSO542tzK1uRyVMFzMmXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqIhm1SgDbJVHV1WglljfL7Uc5PS/2LlTIT8mW4MI/KIjMe2F6opbdFNdIM0DZ0qgHZxny6ScVQXLhuYXfxNsGlUCGX77+lQkB0sAj2ES826gRoZ+2TC4dYSq46uBxHFMOd3+H4VPSWlqYvKcdT6YMrllBoV1iScJ159oADteNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwcFIuz+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30e542e4187so4265722a91.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747757269; x=1748362069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgKSlcIHaP2JfMPMGmeAiqHpEUAyT6DPYqTVU+V99g4=;
        b=KwcFIuz+3QWUNVvBjThDrnXJjjzKMfgIuKtxgRQQDxMsK+38FlxACYtGVdqaMorwxZ
         y/ePGxg6YD1RxKCBV9oK2ub15ZG7OJu59uSC6E9IgVLYfPlNWBXbQg33iWDGroUOFhXz
         LsM637reRSnOqAnI3J3q8n3Uibyru84iHwvR7/rAwtpO10k52tloxa7Y5hpfB7CHzCvl
         ky14JuTnewtlqPbQmKsPn8Q8C15fIYpvs7VxScsfEP26nCKKJXCtIQOKF0vF323qDAK0
         eNFxTuxHwTiKvXuaLXhiKMcNKu9ZseBnnatMDQIgsivXiaoLb0GKH1LpSrYoQm1zJCAq
         iR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757269; x=1748362069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgKSlcIHaP2JfMPMGmeAiqHpEUAyT6DPYqTVU+V99g4=;
        b=V9XLAusRjRRKicZiM+doVPeZ00s/nCvw1zg/GH2nzKFJ/F+DDEujiUZNYeak3l+8cw
         zXagc4gzwpcbk6dMoQlMyFI6NZcLYZ2yulX06i0WBckz0WGuzXh0oiSUj02QFuDgmdZn
         miTwJ+qUgTnBMsc0GTHcO8mRBeoZIaZF0fDtn04NaDoqHC24OJDcFfglF2qs1kZFcp2r
         ZrEx85pghHSCuMghCzjyYqRTE3oXUWaPqxPwLq4T2INsQxg15khBxJYNbaWivq1sRGq8
         gmbU2k/t+N3UoDc46uguhFhs3z9qgREZtCBqP0+e05n9gu7KN6EbUybp6lhPsR5DpD8i
         g3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXZqyeirKWSSILW4QqA+DA4Xrrj0dF6VXVWHZGpU/wf8iyKB3zIw1PpBcjEnHSxIfz5MhfgbCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9O81d9rvrOKJn2kI3ucBSJ30X5LLQmU5TlCfvHx1Ns8yjLEXN
	DonvTL3Ora70POwP6qQ8rVs+zAD9e7lcykbsBZWGg+Km0vZkebHvn8e+NBkIKN6SpeNQoFdmbb2
	KWqFxufeWB0lQNm3QvQsWz34CxBu6siM=
X-Gm-Gg: ASbGncvFS3abct8+kmvc6WxG1u1QxdljsfzM0Z5cFmNhO7gQHfvrUDRMTzv+M3KMD/6
	sutp2pwoCkbz4BcfLCunP6kMz9ihnT33CFc7Ox+IWgC1wXeJ/7LifNzRnzLIfZ9NDP2suMNsgWO
	tD44zwWlVVg47sh2Q4+cOFLXlIh5F3Qqk=
X-Google-Smtp-Source: AGHT+IEkFr67ARw6CK7+QYwd2pKUJ/v3hF77cMEtCG/fswuNpdpX+3fdUCXDCmNyuZq7z9CwNXcUMIOV3U5m6mJrESM=
X-Received: by 2002:a17:90b:1805:b0:2f9:bcd8:da33 with SMTP id
 98e67ed59e1d1-30e7d57f355mr24237733a91.21.1747757269300; Tue, 20 May 2025
 09:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <de5f64cb-1d9f-414e-b506-c924dd9f951d@gmail.com> <914ef57a-7c22-448c-b9a3-0580e5311102@redhat.com>
In-Reply-To: <914ef57a-7c22-448c-b9a3-0580e5311102@redhat.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 20 May 2025 18:07:43 +0200
X-Gm-Features: AX0GCFuVXTibbJuV2iprMPB1xbK0WCM0HHgvH_dPsh_-_1Gti41dFNH4QqFMdTY
Message-ID: <CAFSsGVvLr9KLFBjgs25RedKKJsHYeSw1xWLQnNddMYxUjrzLhg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: move mdiobus_setup_mdiodev_from_board_info
 to mdio_bus_provider.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Russell King - ARM Linux <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:45=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 5/15/25 10:11 PM, Heiner Kallweit wrote:
> > Move mdiobus_setup_mdiodev_from_board_info() to mdio_bus_provider.c.
> > Benefits are:
> > - The function doesn't have to be exported any longer and can be made
> >   static.
> > - We can call mdiobus_create_device() directly instead of passing it
> >   as a callback.
> >
> > Only drawback is that now list and mutex have to be exported.
>
> ... so the total exports count actually increases, and I personally
> think that exporting a function is preferable to exporting a variable.
>
Current call chain is:

__mdio_bus_register()    // in mdio_bus_provider.c (module or built-in)
  mdiobus_setup_mdiodev_from_board_info()   // in mdio-boardinfo.c (built-i=
n)
    mdiobus_create_device()    // in mdio_bus_provider.c, currently
passed to mdiobus_setup_mdiodev_from_board_info as function pointer

Having this call chain in one source file and not having to pass
mdiobus_create_device
as a function pointer outweighs the drawback of having to export list/mutex=
 IMO.
But as always YMMV

> @Andrew, Russell: WDYT?
>
+1

> Thanks,
>
> Paolo
>
Thanks, Heiner

