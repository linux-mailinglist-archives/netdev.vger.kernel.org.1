Return-Path: <netdev+bounces-228422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D31BCA44C
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21BBC4EB68E
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7E23496F;
	Thu,  9 Oct 2025 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7c8o42W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963811C695
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029059; cv=none; b=aRyEziG7Hazy2pCegDnFS/p8k77qJXX1fVgOH/JNB4Q8qxqeYmLZfT4+ZF5p4RIoY0pQ9Iq0lwBJPxJu85iLfd59nbP0aw1G53ozhuKe12HM5gwSX6kpK/YUt8z1xgfYBc8yspHiJSoXqL62VKzIzwWNkl+qq+c1Naj0Umhojzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029059; c=relaxed/simple;
	bh=RF9ZSJQioRunccbOJ8PBKnVv5gI2HqZYf6M8L8RhwBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEuV/XWhEm6qzDhI+OOpJM1betocRTTZqCAgEsY6fKk/QDV3TkPnSYMMUKcfbj/kGBfISqTBD8AIK5C9gZuSmRNB2OvlpeKhIGnGBiK2GVLn+l3L0fmigt+ytdcoI0sRcIep3Oh46uxXlL61RjbzLCr4QLQf2neRK4mvl2Cp3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7c8o42W; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so2270923a12.2
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760029056; x=1760633856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RF9ZSJQioRunccbOJ8PBKnVv5gI2HqZYf6M8L8RhwBc=;
        b=A7c8o42WIGU3OTQiIFlRbbz08yrpvjZUsLCUbGIvzT1sELosdWPF5Q1vKl9XqSFsD2
         rbAe3BHgfqamjmo98bOTJ0H6jIrz1m3slOoIEZQzoBsqjptIsqBh8eENTgPyxZYlUzW2
         zmQTk0+ygC6lyXe8G0g59NRXz+0wdCeemkZt+Ul9WTZRpy05R1D3iGo/dysZUnU3nF4U
         L5EBYrsPDEvtp+BQoWAJGoBGg+CUzjzjWJtFxcz1icMsT2Ch9d0LbWAcZknKyXUv7ntH
         Ie3VZ2vcp5IKRmEwQ2GjX2b3LboYhQl2PR7I0oH1uEH9+KgUCtg4RNvBn9xO0bKqzbXk
         321g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029056; x=1760633856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RF9ZSJQioRunccbOJ8PBKnVv5gI2HqZYf6M8L8RhwBc=;
        b=Zc5+E/C9//zyIx3qBau1FffFiHJWkUq/sek5lmbZlIkTBcAvKTyXw7QkoP88VSw+94
         619CxDS4lQQZyjC2MI1JugwrRlNCs65czb/zXG/Ftn2rebkSzrAw6xfF2ATgkM7oNr8q
         am48rUoOzGgzwIF5GJd6DpVfjwx6R83QJvMToOl7YSZM24FG11Guyedya6xlnHd7+E1z
         zqYvGil6eYK2PSkmT+H0AnjBNDxn5wjPVCyrv8D1LVZ/kPMGjb1Z2dAXgA3FocrURhLc
         GoWOBz/PXnwGHGlxEruLuWWWfDQCmSmjY3GeR+6Q36+qovx8SOvIFGS64b+j9FoTSJHh
         oIwg==
X-Forwarded-Encrypted: i=1; AJvYcCWD+8F5GPxmYpCVZ1kQpkzBV1s9ZXcG+rzpPqMa/NCu7qcJglfxb85RfNRac1s35FFnfBxzU1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0rqq5JNaza7Epjxg9Fm+unK+v371SCEBN8NkdQgXxs/oiVd5
	6REnrysYjhVm6U7Cj1/m7lncr31wXjb53+Nd+ZgKG9PuEUu8tNb2UcfkqxEiDu7GuFz+mebaMrr
	gWPxfoyeSkijU5ilNoUhRijnQFVKgKcU=
X-Gm-Gg: ASbGnctiDmHtlUipAdodn2Gj9ENfNFFQIjSX6fCGCwlrXXiDa94cgneZnBvqyIw/Saj
	eYgwkVJG33qClfrKMjF72nR0W17ALb6A3LqlOpK6j4+UhmQzRjRCoukCac9pL5du1Tsx4Mi44/K
	z1/r9u7tfgpkwgSZ5QCwy9KBJ4CCXBoSEZ0RUOjOGBq0vrmNar+WVtuwe4KFs2XAq64eRLQKV0A
	5G08WUNBCgykxWG1/Ph530QPT4UHDa8UfcPsddVMrDlLa8XV2fitMuFV4cyDgX3Ec8cuBOsFsz4
	WfPM
X-Google-Smtp-Source: AGHT+IHgAXC/qDv6DJSl3IbBYDZyNsei3ooyIM9aY+vI8wPwiiUSx8OQ+G2ng29IMa/tU47rvIJShBZrKGpVq0btB9o=
X-Received: by 2002:a05:6402:42c2:b0:615:6a10:f048 with SMTP id
 4fb4d7f45d1cf-639d5c6f3admr7423302a12.33.1760029055749; Thu, 09 Oct 2025
 09:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001131409.155650-1-viswanathiyyappan@gmail.com> <20251006111211.28f018bc@kernel.org>
In-Reply-To: <20251006111211.28f018bc@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Thu, 9 Oct 2025 22:27:23 +0530
X-Gm-Features: AS18NWCKulaivvxFZjI1XomTCbqny61jfhLMROFJeOwz26mAdFKX8RsAFt2auhg
Message-ID: <CAPrAcgMW=BLZkxhLq0ubRVvHQ7pNKGCCuGLSyoK_xh7XUUXv+Q@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: lan78xx: fix use of improperly initialized
 dev->chipid in lan78xx_reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 23:42, Jakub Kicinski <kuba@kernel.org> wrote:

> We need a Fixes tag

a0db7d10b76e ("lan78xx: Add to handle mux control per chip id") seems
to be most suitable commit: It added dev->devid comparisons to
lan78xx_read_raw_eeprom but did not move the dev->devid read before
the call (devid is the precursor to chipid and chiprev)

I feel like the patch title sounds a bit awkward so should I change it to

"Initialize dev->chipid before use in lan78xx_read_raw_eeprom"

since that sounds more standard

in v2

Thanks
I Viswanath

