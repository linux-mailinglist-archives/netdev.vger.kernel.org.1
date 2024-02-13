Return-Path: <netdev+bounces-71566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9667853FB1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 00:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A291F25009
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352262A12;
	Tue, 13 Feb 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYFvfwwv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919164F
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865697; cv=none; b=igWXiStQeyIY8yWav7bBFXEB7+MjnvclVQUG3Y+0odRMVneiYLqiwsi5ZrvN4wIJr8TZ0L/HepboL7qbPtPhvUKxveeHB8Hl6cDtt0P3xQMlhFU5F2XiyaXDnPv/ulj47IpXVCHrX/oreFqWpvtAJjhqBYOsqduxSQ5ULJDS6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865697; c=relaxed/simple;
	bh=UPKxpUZmpewL2oiDjDYBorf4uyD8cQRyNRxn1Fc4a+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaydtBOSmI7Vr+X5qIGUxLwtx7kfjEu3/BQkBcZZ8ovIX0BVXV3HYSLWR0r7CUPlT19l4c/TZYWj8QlTly3X5472nsVenzVgEOOCEoK/0sCZojlOGPMNoAdthCp1liUZF8xla+FJZ+m9S7hbfa89DrnzFzmteH5/LDYu/LStJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYFvfwwv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso1243842276.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707865695; x=1708470495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPKxpUZmpewL2oiDjDYBorf4uyD8cQRyNRxn1Fc4a+8=;
        b=pYFvfwwvTNfuiAFviMHRdrQIH42+S6oSdoE+uEH8ZET+sRVwrnJBbmOfPTXWW86DiT
         vLBi2x6E6gy5kM8J/1RelO4lKJRXibwxOFuTaQqdQsp7vl1pz89aJgcGzzg5c5BasHlT
         LdyaR1s0Ujjfr3s8UpOZAgIwiRObuumNzVUxNZvCfw3TS712oBxNIYApbW1YTB2bSEf3
         gX2YwVaiipfjmtzUfWNE5CwOp0L0GuOue2uViw8Z0P5ll9mK9o8CUngWk4uEGt6IA3RW
         Q1LU9jaktXOLAftO+M+B4LhQfWUCImlP/qOrROKoP8wEUQZRg+/idWt2YnoEOog50cxh
         PysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865695; x=1708470495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPKxpUZmpewL2oiDjDYBorf4uyD8cQRyNRxn1Fc4a+8=;
        b=U65CTigJa6MSnEeUjzguGftowXjB+oE4XfiP/3QgOe1KFJJ1qtBdM/jqREnTyeyifY
         rhgj58toZzZ8TUgij1apZVyGVenwC5RMzhBHgmRlJ5wv2Gudplso2plihc3wQH9MKI8f
         b4h6kdGFyd/5+THM9DfMtU8ivtB5BoRFncVoSH6ksl4HNlR8BXg72wuvvtCI8S1wIqfh
         8wd9Bz+WgHBeoW/WsmWPFzJobid65o1FbwJB/qazt8Upt0SC35BIXFGD4oBMZ2rgLQsc
         HUzVBQH6AIhnBe9SwGTF4f9nWkUocOkhqwemkv/HsURDw+23YKWJIdC5Bnadt53fJlCO
         ArcA==
X-Gm-Message-State: AOJu0YyaHpRgNyXPEixA7c48wIHdmrrSgRFOwekVNh/Ivj5zPl/IZS3/
	rzPudyKM2ZCLG+JvX3qrEhukfGavqieXfMnGxdiR47ZZUi9go79QZ9LfwfachrMN5buhC6SWr6S
	aD35nSFWLvVz/tHIPVQ5cgAV0jOLYjMerv+LxdA==
X-Google-Smtp-Source: AGHT+IF+elx+hBn7SrCXxhMrRvIzsV8yx9LlnGhlnBcMFGcNffUiWOWuLtYWOP2QLloedfePv65ibJK4V2I/D2Ty+lQ=
X-Received: by 2002:a25:8c86:0:b0:dcc:140a:a71f with SMTP id
 m6-20020a258c86000000b00dcc140aa71fmr626531ybl.60.1707865694274; Tue, 13 Feb
 2024 15:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com> <20240213220331.239031-5-paweldembicki@gmail.com>
In-Reply-To: <20240213220331.239031-5-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 00:08:03 +0100
Message-ID: <CACRpkdZCbnDQ+JYaSyv2OKYC4zCb0iboAN1ma6DMuxyioVBvYg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 04/15] net: dsa: vsc73xx: Add define for max
 num of ports
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:05=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
> used in the future instead of a hardcoded value.
>
> Currently, the only hardcoded value is vsc->ds->num_ports. It is being
> replaced with the new define.
>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

