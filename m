Return-Path: <netdev+bounces-70523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D896C84F5C2
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B71DB20C7A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA17F381AB;
	Fri,  9 Feb 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyYNF0PC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B91374F6
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485058; cv=none; b=qeSXYKj7kf8s92w61qsz056+pfV6CR/Y5bI50DXHSLpIGMHpqdp00fSuwsrD62N3NlwyyCTUFgrNnilhAJfb5jxrW6mN2htAZ/HpcIaJ9JB81ovkPAY9ppeGxG+g0DycsbwF1Xf6aUuVAh9UPVk0mJJ3j/nrgc3I1J6EOLFcKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485058; c=relaxed/simple;
	bh=O0Z/dpFBHnf2aGHeu+zM2P9An2C3mvbpnSWoRPcjfd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG7+yYuNS0fWI3oCg6eW2Z5YBtlmMVngpiZSNh14UANheE/D+kWrKYNO0IjpXsqNITfSkU+S/F6HCrLMamgsuyrLq8MdlEVVrlAsiNyaW7u/4Lenb7q6lPm5+x89LhBGkaynpB4snYTu4zSya3mD4D+DNtVyjTlkbwduCcV7vGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KyYNF0PC; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-604a3d33c4dso10394797b3.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707485056; x=1708089856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0Z/dpFBHnf2aGHeu+zM2P9An2C3mvbpnSWoRPcjfd0=;
        b=KyYNF0PCBjuFsCKJKi37Y5DPCtM4CYREZ+teXA3IDsryEzkins5vmZHK6Ajoq2Ffh4
         JKuxD3Umv2o/Y7MlJX71W7RgQNUenPETBu2SF/hfNTt90zBGiZilSW6QCINDWaeY3jMG
         Nhf/Sfqg4jwaCRe+Yonlo7EGei4dOzbpNr3JUOzhCquygacZngEISO8cuzjRTtISO4be
         CWq01Bud6m2aiat9dPJmZTWKfduH/RQbLP2V5wFOTmAQhn4sgICui4EUOYFSqNhflDKG
         Kf1aDCNuWjA5IWov2zt4+G6ICJEooyq+cYuz1kd13WTN4zJ6yxLN6SpKeEFoabCLU5sN
         s5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485056; x=1708089856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Z/dpFBHnf2aGHeu+zM2P9An2C3mvbpnSWoRPcjfd0=;
        b=YQ/ZHrnW5Rjksm+413N1ayDXPjIoOlJbZXa0Puddoqo6GOUHExUYSHGOSC4GHJWtwN
         UWnrl6cM3gHUfFP0UrG/SEFy46HK0hdweZDrBK+1mhVwWz+E9+SlhScK3VNL35WfuaG7
         uOj7ST1s/+ZsjK8Mlug0BcduKdSF1mL3DyRfu/b0dgvqazjtIUXjvXBqeaXZVq4UzuIW
         j7q6H7I+eLRAn9uqHSi7fWfB5JVeISTbON1sR2SF+HqnnBBSITthGwEKuk18nt+rKR6w
         Gp3veM/Zon1Qs1bDAltrI4Pl6+uR+5bYHHRTCSktwE7j//4juLJOo483QfgDe/N4GDC2
         aXnw==
X-Forwarded-Encrypted: i=1; AJvYcCWIWNwMNhvYBKt71oG6UHXx2Wim4gnno40+PrFnCH5F7nSRtc5LH57ENXDhETmym/SN8jBVLHUKojHkfrnf6Byj0XNSh7WH
X-Gm-Message-State: AOJu0Yy+04NmHD1AWe8WyzvtWbhUqbhnxDUQ7GAsn5Z6BcccQp5+/IVP
	4W7MadbWBuA7yCTYaL5HCUEgJdduwVt6+D+7bZ/EFwMzKn5qMqOJmW33vhgBZa19AEZg9p0QV8R
	5O1Q0sy4EDoat+KbIoUrJWcOp5G9deGPaoKvndQ==
X-Google-Smtp-Source: AGHT+IEE6opJCMSFPZxtYJ9lhFWs16+8O0MbjYP18a9YLE2vj3AHs+OBbahALeN3Jp5iQV6eaX/MkCWq2fEOffZqRs4=
X-Received: by 2002:a0d:eb8f:0:b0:603:c982:2877 with SMTP id
 u137-20020a0deb8f000000b00603c9822877mr1584995ywe.19.1707485056513; Fri, 09
 Feb 2024 05:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-11-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-11-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:24:05 +0100
Message-ID: <CACRpkda8GLnzUHjD8nwcQYzX0xaQVsFHpPJjMkp9R6WvyFSZSw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 11/11] net: dsa: realtek: embed dsa_switch
 into realtek_priv
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:05=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Embed dsa_switch within realtek_priv to eliminate the need for a second
> memory allocation.
>
> Suggested-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

