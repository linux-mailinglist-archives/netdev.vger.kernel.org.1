Return-Path: <netdev+bounces-197255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E8AD7F64
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050391890BF7
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DED22770B;
	Fri, 13 Jun 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5Jp7sia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E6D3FE7
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773197; cv=none; b=ECse9P5S0gBbXJDP32t2rRl5K0gFpFzcC0kNeecWuHXBOCF1ou758ghYK6hJGesGanlAbCEdMEyz+SSi0n6FxlR9AYCzPSw/oBRorM7uhaURlSE9IupKRNDAyIZPFgM3Omn3jWEFOwRQrMYI2f8mSHUxdU82pTWgU9avuvmW5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773197; c=relaxed/simple;
	bh=ZLUVLq6ZMae4ILViuvnXnlaNGnyYVL5EvQU2zGv7KHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRP5sJ+XguH8ZfJXT+C8tDPi1/pN6wKriXcqFZ7UNNRRfz0bUTkHU2lIz7BHWo+rKn+XiJYNLwhkgwL6ShC940GOXGork3yZOORKbWczKwRLt0t3qinVd9YsWLjDvmE59MrkbVS8pNLfoGk5eTxo2qGWifp+YG9KmRQt63atia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J5Jp7sia; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55220699ba8so1708136e87.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 17:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749773193; x=1750377993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLUVLq6ZMae4ILViuvnXnlaNGnyYVL5EvQU2zGv7KHU=;
        b=J5Jp7sia5WTG2/LVu3RsY5FnuGoJDgKrN2rYWPZk4U6/BkobOxpCTEQwtL3Wfq2/ns
         AtQZJWtbDLpYxDyEhNErKQ3gwAS0Y2HlnkTjDft1FDZHwHSehX2vkRv+vecZxNVc44sg
         bMi8A3M7mpvKU+FC2upKtAyf4Qw+6Qxhdn2JTqFZl7WQiSI+BmwYPwDmW2w+Np8JUv86
         +4YiR4aGZqqA1qIFHZhQSRU4lxlRUAJQXRy5TrPerFJ4aFLegoFkYl8rZ1FuC7jRKfne
         EBayOBtymFCQlcJcBeFpKKkf1XkPIV8FQ4DUcQ65awBQ3tVD01T0fLlsnbpqqG4jWC5H
         Y43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749773193; x=1750377993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLUVLq6ZMae4ILViuvnXnlaNGnyYVL5EvQU2zGv7KHU=;
        b=YO14NNzMRj5/LEKuTfIAuOAl6idDZGYPBnODMN0CpU/JEVpJCWtt1rICWIfAQNJ5DT
         Aj4Lk27KXSDLIRoh0U2tehQ7sI3Ikxcc4SVU1lwNHEF3vBLKO+ujNYgjhMGxzbPZUV8O
         qHUdCR2v1n2aa8vKlxbBWT30bli9jy61ApGpJGfE5LigyTzJqMfIElxaT7E7dUDQhfUb
         qepcodQ59dHEl80iFhU7tCkwmtsmc27o57hlkuQykdc3EWpNA2LnQHhPId762E4QNyfB
         F80QMsYIwd4QrvbXobPhTAMKFufXiupOhar+eCvjhBUaXTW0msm7xL93uD54NsDg2xIM
         5r/w==
X-Forwarded-Encrypted: i=1; AJvYcCXGCDDAJXBn/TWM4hZOyaIa7RNuHp+yotE5+Y7SacTn/OfBweUBJOs1VlvtplGwWWnteIATDhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwsXhb5KqVgsvZhLs9ypkXC28ufb7wTO8fxJbus3AEkP7Ta3d4
	E4sK8zq/tj/5EH50V/kpBSMv4rO5wWPlxc38pxCNugyz0GAdjxZaRj5pm9PzZKCrTNKkBHx6kfo
	or3quX6IPX6P5EhJUOyAfgETf/DrjikfmKQqU+DA=
X-Gm-Gg: ASbGncu7N2ytY1l+v1ezzYvP6siwXHwp4234mezn0GBAtG9EPR8E0hnHGGcOzyHzxXU
	3LUwJ0dpTqIhPE4ooPWsPt0jFWfNYLrpuXI9Y2cxQf/TscktARGtBvv3qjDc2x0Fa0qDvHgw8wu
	5vef1YWFG+JYVK2F6WgoY4bhU3w8Vozaz5pnEfL15qNLLBMHnu9yVbvgf4K+/gxcdIhrRhB1S4
X-Google-Smtp-Source: AGHT+IHrEg+ybJdcpWZWIVUBLy8G0/MTjrY27t22H91RsC9IYefq0lqnA7Sz5zwnWvTkvn7s+HRj380Nj1zbba7qjA4=
X-Received: by 2002:a05:6512:3d8d:b0:553:28f1:66ec with SMTP id
 2adb3069b0e04-553af990214mr235784e87.31.1749773193289; Thu, 12 Jun 2025
 17:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083025.905800695@linutronix.de>
In-Reply-To: <20250519083025.905800695@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Jun 2025 17:06:21 -0700
X-Gm-Features: AX0GCFt5aLTih3d6dZUnHL1BbMpxOZ5rYd3fDRpWeoi6bk5px2yuSvTUdeBo7Uo
Message-ID: <CANDhNCqSbz39AN5Pp_1+YzW4jgO-089=L5WzgBrb077KTz4LYw@mail.gmail.com>
Subject: Re: [patch V2 05/26] time: Introduce auxiliary POSIX clocks
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> To support auxiliary timekeeping and the related user space interfaces,
> it's required to define a clock ID range for them.
>
> Reserve 8 auxiliary clock IDs after the regular timekeeping clock ID spac=
e.
>
> This is the maximum number of auxiliary clocks the kernel can support. Th=
e actual
> number of supported clocks depends obviously on the presence of related d=
evices
> and might be constraint by the available VDSO space.
>
> Add the corresponding timekeeper IDs as well.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

