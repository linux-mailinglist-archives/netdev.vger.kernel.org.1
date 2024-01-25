Return-Path: <netdev+bounces-65721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E383B71C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 03:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066141F2446E
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D846FC3;
	Thu, 25 Jan 2024 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="HQpAl0k/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0723117EF
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706149511; cv=none; b=YoLOTHnZidhrR8G4LZ3FpmfHcj6E5GRRnHdFMk2lIMsI797dPfRxvi/hlHfUvob7YyOCKgeEy6s6REgbvXY1QhS8Zbmlv1XO78m1XXemn9fX51emm0vFlbvuoYTsPNPkQ+HPQX0w89keriNYuV2GDVjlgoCF+9FAyu5hdns8uzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706149511; c=relaxed/simple;
	bh=JJbUmzIhV0n4876CP+VTF94ItzFlZJ0Fkiuh3ejgaJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSUlgdxTgSyZ6Tnxz4H2+xEHU7j44sclwpBrXkGYw1g98Qb38bCktcQIJwSIoaTfl6JhtDiMGnVAn6iThbGLZU7/xxRKy563HT6IvHdLxmpHhzFaNItFKon5iL0iG7R/V1v9C85VYDmlp6DpRxwcq+5OHz53S23sKy/gib9W9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=HQpAl0k/; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6000bbdbeceso37984997b3.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706149508; x=1706754308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJbUmzIhV0n4876CP+VTF94ItzFlZJ0Fkiuh3ejgaJ8=;
        b=HQpAl0k/RgHEypd0fyRKoSY0eUAhgnDpO9D1fnXJHTmbo+DORCS8625iHLtMnUlHyX
         jFBp4MSbcGRL39fQVhtRlZJ6e5MGmSOaWSp/WdQAS8LbGDPYH44eDa2qHDzj/Q/gfHNA
         REu/m3Lx4c/i7XRyframwSasUj7dMvORanr+yZNDiKjISSXQXJg9c7kfuxiHZEBlb3j8
         c53blF32hcSTMbDp4aG54ACcuYmRbRcqcXU4evKReQKZryU4moRs3C44HV+qAF6DhHjw
         zgcfroSI9Sk6oAsEE1S9A1MEsRkla8dLTWmM7mAFTfnSz9ybcXOv2EIszXPfDNn8lJnM
         DTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706149508; x=1706754308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJbUmzIhV0n4876CP+VTF94ItzFlZJ0Fkiuh3ejgaJ8=;
        b=Yb+7xeiS7WkvELdz/SFX9dcwbsnSGGtS8lV4rBsP6CkdtJ8Ud2xgN5V0nAPnOd4VHW
         BdNcZ9T3Hke5Fu7K/XEC2sqevm+3+avNQCMCFHT4By8/EDD4ERLPj9MPyxB/0vyvXgR9
         FXuIDougJZ4lqKrO1ftBlrztBiuO1tF/uVYElgFG4OgxndSpd7YTsBdDeO3Xj60UKeJG
         oKDX6CcMxd4rboZlD8uVPz9T6y3EZiOeA8+n7agSJ3iEf0qhrbFIoew5PvYFs5qckWKv
         snRzBUQzmK7ggFQnHmBv6Tfx3TsCCHRoKBYLJUB7IoPP+2B/WTODrWoqhS7aKB1ykPqY
         nXEA==
X-Gm-Message-State: AOJu0Yz4AI5Wyr5Y+sHRgu9EdlIvXyA6vejyd4Mj7P1pAO/WS8RqdbUB
	uVieKn+6npGdfpbnPZk+tvEVv0VFWaMT0u0e5c07ex4PpLPc+pX/NvrCyylEbZhfSBk25hCH3WG
	9fnDwZddfhlCUpyUAaJ/cwNFOO600n+4rlR4z+6feTQGLSuphJmQ=
X-Google-Smtp-Source: AGHT+IEpTW9mXstkrKdaaWRzPjfg3q6uN1sPwSuphnHD5Ars67PqX/fLBFVlV8a6a02SEUeeyoOBRJlAbT/jae7F7Y4=
X-Received: by 2002:a81:c90b:0:b0:5ed:d178:4d33 with SMTP id
 o11-20020a81c90b000000b005edd1784d33mr118864ywi.41.1706149507906; Wed, 24 Jan
 2024 18:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125014502.3527275-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240125014502.3527275-1-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 24 Jan 2024 21:24:56 -0500
Message-ID: <CALNs47sEu4-7vS5yP8Y1pfC0BDFAT=DvQ4Dza2KLuiccvohf6g@mail.gmail.com>
Subject: Re: [PATCH net-next] rust: phy: use `srctree`-relative links
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 8:47=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> The relative paths like the following are bothersome and don't work
> with `O=3D` builds:
>
> //! C headers: [`include/linux/phy.h`](../../../../../../../include/linux=
/phy.h).
>
> This updates such links by using the `srctree`-relative link feature
> introduced in 6.8-rc1 like:
>
> //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Link: https://lore.kernel.org/lkml/20231215235428.243211-1-ojeda@kernel.org=
/

Reviewed-by: Trevor Gross <tmgross@umich.edu>

