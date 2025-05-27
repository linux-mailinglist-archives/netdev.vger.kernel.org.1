Return-Path: <netdev+bounces-193741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DC4AC5A94
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3A7A37FD
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA252882BD;
	Tue, 27 May 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj9RlTSF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF2C27FD6F;
	Tue, 27 May 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373695; cv=none; b=BxCkk7dKPbYfZ7KN9amsVDMCFBWn4GsO9P+iKi9hSQgwfb4spmBJ7wJalul0xh2k8bPhz83vMmIQ6RF+SsoD6DoSJhVAVfaZd/5QjMjEY+jiA5aPZIlrXWrPYHF05WPR9HrGN2OWOEScjuom28CjWuje9lU7plZKMmAWXMlF/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373695; c=relaxed/simple;
	bh=ZOx7q4xf87k1jEIxa4jfUnotqYzGDRVn6aOkwlFU9qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7eWi6A4giUo0CVnRcavUwFLGyU7iBANUltdvWlVx+tRLcHJVjwcsaqf96pH1F4IiDnc280NYEFRMXDu/LVI5BB34gvZR3gb4H1awp9TSxBOHw8TksFW0OEDC31uuEXowLpg9NqAtoqRDMlqBmqMgyOMdwEpcrZNTYyLjqqad3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj9RlTSF; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52eea8111easo999012e0c.2;
        Tue, 27 May 2025 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748373693; x=1748978493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWXT/WupRqW0CupybvTkEKLCMDuWAmD/tW/zMc48HoA=;
        b=dj9RlTSFfkqtxFT4IfLLgg3yBZXDcxzLATwwDB0jthKsCCYOz9SXCpjc2w6kNV5LnK
         pwcQJDliDj3enWcoWQig9pwpucES4hHOSnclEp9/sfuna8mpo2GZEzJkWGa3tOPKSWPN
         UNKuowRlUqqYyFXEFFwvvvoxetf9KrK8xIE9ZUyjx6uFNkxdvUCzYYDgV2GPIKIfs/Vk
         aosHyyAF98QVU7fKchgwYZjRIYZm4G4R6RRFHN+Fwl44ZieW9d74Vibw3LoqmySAyW//
         cXPXj5I9TZHgcpOwY6+loerRue3nv6ugbZlaStS0gofY7vqpiwM0jTCe3YEYmrUYvY8C
         1GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748373693; x=1748978493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWXT/WupRqW0CupybvTkEKLCMDuWAmD/tW/zMc48HoA=;
        b=DmJeXw2r1tmgYxlgwwusUT1X2z+JwX2P+Z2qLEkjMNM5awY67VydasyHWVaC5tvZpP
         ggQuRHfIb1wBT6nckNv70Q+d6MoblxP/YPzTW/5tajJve8DzkzmkgH19nAoLP/b3bxPs
         Zb1P93ywchSaVn9jVulX8ZJPhVGsfb3yIkhDd0FUYI1EoA/sKcC389gabJkheO9a1NpU
         c/cntNj8oyaG3BfYVOLuIT39z7YI2SbTIcb4m1Ur5q1vierm7VgDiS8aBxC7EkzYDKge
         FEjCVxkwi39ZNIBSsnl5lpMXAW2vh1wdD8VfWznwBCAVSPxnkdM4dmhjD9th3k/o7jCa
         xykA==
X-Forwarded-Encrypted: i=1; AJvYcCVNdzgeH9E2CvxDceUzRs3sLckh7PEh9VAgM8uWRDd90rxab5x/74kH5ISG+6XH1rrOYP5bqwN/Br073us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/SK/Y2E8fXhmw0Pj4Z/+iROYOzUzQIhx3diiYmpfxr67NtF1
	k5BH0pPDvs8IEGT9nKFHZaEpoTVip2gV+iKJvz8jKz3jPGN7tIL1okLTIxc2O5pmjLv7fjoxflm
	H4/XRmG0/LCBvQzfnD4P1p8TrW1Lvz3I=
X-Gm-Gg: ASbGncvAVKJisZ2gEPw6ucQyvwZj0JHNsVJbTOD/5I9n9p8uoJH0Ej/OQhj12gPdp5X
	kWEVEoYaLxDwwS/Adkt9mw6cuzBpVusTer97W/D1GCU54bWfH/qtKOGl8LKXXEuXFovz2Z6vmKE
	fTXsi9vozCxsLUKHvw38VmsBqA9JDDDhIEgA==
X-Google-Smtp-Source: AGHT+IEChjVJAaQHlGSjHa9hTKxCJFyJzR7c9+aL/0QxNkhj4bg8SHCtIwSUXtZJZi5/vjBpZfQlumATcldCYDUWxqA=
X-Received: by 2002:a05:6102:290c:b0:4e5:9c06:39d6 with SMTP id
 ada2fe7eead31-4e59c063ae6mr471806137.2.1748373693026; Tue, 27 May 2025
 12:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527175558.2738342-1-james.hilliard1@gmail.com> <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch>
In-Reply-To: <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 May 2025 13:21:21 -0600
X-Gm-Features: AX0GCFvF6Ti9-VC-WdHc6MfKeYhf1F3qOQDDP4BI4jj848sa9rzAvWhhkHP0KPs
Message-ID: <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 1:14=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, May 27, 2025 at 11:55:54AM -0600, James Hilliard wrote:
> > Some devices like the Allwinner H616 need the ability to select a phy
> > in cases where multiple PHY's may be present in a device tree due to
> > needing the ability to support multiple SoC variants with runtime
> > PHY selection.
>
> I'm not convinced about this yet. As far as i see, it is different
> variants of the H616. They should have different compatibles, since
> they are not actually compatible, and you should have different DT
> descriptions. So you don't need runtime PHY selection.

Different compatibles for what specifically? I mean the PHY compatibles
are just the generic "ethernet-phy-ieee802.3-c22" compatibles.

>
>         Andrew

