Return-Path: <netdev+bounces-129101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE84F97D79B
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 17:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62442867CA
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9417BEC8;
	Fri, 20 Sep 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="iYS2Xm/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03017D355
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846945; cv=none; b=cCPxS6flSciAm82KOkLZ5dKcYy9QdHF75pXgijtcumm3e5AAOV9Q4RGwVmNXLB7L0hD3TPL+ixAzPe7VcAcTGLr1bz/0pwxSlPaDVptcAQQ+8MQZCFWJz6BJ3JSCIKMYD/ANf4qMkyUWnoMsVO9S3djsPOdGF2ROQFUE4zY/A0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846945; c=relaxed/simple;
	bh=BrUo1hGDmT+C2vYyXamkgyXJdqsOC9wxPtpo35WpM5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOPkJ5YvOTKOJZXl7MI0k5pPzopKYPXAHjAXky/zxZY1g5NfZIurDG9PzZYdXsbcr+JJSyFWwU97E3/8+pAbiPTlZ3qBifn++ViICsp2zcHQnF43ujzB6L3lv9tUJf3Fthn53kdN7mMTZ5NxaTvXQQIqZ4x68HHmWUsPV0WTXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=iYS2Xm/c; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso2180650276.3
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1726846941; x=1727451741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBms5AmCW+8qvkUXiLJP3/Ll31btWSgF/+xX88EatPY=;
        b=iYS2Xm/cSwnpG97rgHEhzdH/TSBHB3egT8gIf9JoeJsxapw8dgtu9U5hyj6Gv6MC1D
         lb8qAFkg4rzHt3xVK/5EUHzNi4pxZTCXFZ8h98+KHS+vdbUDqVzTDL/NeT0gIdXNj7Vt
         4P8Vtr/45Qo8pCIxUNUpTBBZ9I0D7g9R+7LY1Dt8nOzYQ9oXODJmxksOYPkhwzYW1NaW
         VHz+6IvP6e58X7o/jd0Zv5rGdAECvDp3OHOzsrLNDpEwBRWBte9L2QxszTm7GnMtpSl5
         7ZKuibH1XKpl11EFp05wqeE8/hJgz2Qhu1rN25b9Ycf6t3mB8yOYn5lAGmmGj/x4Wf04
         xrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846941; x=1727451741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBms5AmCW+8qvkUXiLJP3/Ll31btWSgF/+xX88EatPY=;
        b=MXmLyI3KVwmkZnqqdq5bx3xmELSnAqVdy+AhO1wJ6eXxUrPZxQ+EoTQdWC3RWp3lrR
         TnXoOs5zRR/ypSRhL4NfH0wsfuBTNkBM2YUK/48cZdQYTmlKb5B5O5Ceerq578np1mmo
         q7zqmEoZVHxAPwt+6ba4O7QL1PWqWgHyD6oI4B86ggxR3V4CFLjXFBwgDZzxyxYBaqIH
         2CUWqtlqdAH70xyS26az9W5/vCKHAtQMPHwrdoJkVwvTJeVPO3jL5dCQL9Mgjzh8GG2K
         7Yiynwwc+KgNu/K00Nk0aItysBFXqi3Zh20vrTEI+5aGdt0Aovx3LfN+J4ylwZ76rZYq
         kJaA==
X-Gm-Message-State: AOJu0YznWqac/PmaajS9JP5btZs5p7rFT6AOMLG4SZsj9rkTQ8jSW20O
	7D4k1j1R+1PJFCZjL3wIKo1ilfv0X+bw6Cy7aYTrc6I80gq6MYYJtqTawU313wlZQprxWTJYeFg
	msQfwv/2ujP5nK4DiH6VEzlEc+xMN7SUP9E4PWQ==
X-Google-Smtp-Source: AGHT+IHjpN1OzhYyrYcjXoFBaTIHRbGE/VC20HB74/35tSY15/jE8Kh9NHydI0O+wbbYlPssxU2bQEq7gS+S11oLPdE=
X-Received: by 2002:a05:690c:6f8e:b0:6db:de99:28ae with SMTP id
 00721157ae682-6dfeed31fcfmr37362647b3.17.1726846941569; Fri, 20 Sep 2024
 08:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919043707.206400-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240919043707.206400-1-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Fri, 20 Sep 2024 17:42:10 +0200
Message-ID: <CALNs47sKXVrMdC-vraJG3gt-b6yDWvFTOvfrL6+G=j6-1Y-BYQ@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: qt2025: Fix warning: unused import DeviceId
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 6:39=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Fix the following warning when the driver is compiled as built-in:
>
> >> warning: unused import: `DeviceId`
>    --> drivers/net/phy/qt2025.rs:18:5
>    |
>    18 |     DeviceId, Driver,
>    |     ^^^^^^^^
>    |
>    =3D note: `#[warn(unused_imports)]` on by default

The >> shows up as a quote on lore. Should this entire block be indented?

> device_table in module_phy_driver macro is defined only when the
> driver is built as module. Use an absolute module path in the macro

nit: "as module" -> "as a module"

> instead of importing `DeviceId`.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409190717.i135rfVo-lkp@i=
ntel.com/
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---

Easy enough fix, thanks for being on top of it.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

