Return-Path: <netdev+bounces-115415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7B9464C1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA261C21586
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BFB54660;
	Fri,  2 Aug 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmsCX7Dy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE504D8D1
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632575; cv=none; b=UnHHVjcJRucpUbSNpVX0gm+j0/0gHYcghpVtR9Z3kJqa1ikxO6N9VMt49l/CDdOuFKfVmf3MB10bAx0rFPWSt6hNBy3pzlFKwqqa/Tb5HdR5cpcEt3y2mTkpev5cQa+BuJZT31J6tjwt2Tv2BTigZNQmZmy1ToT6sRZLVF32GCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632575; c=relaxed/simple;
	bh=M8kFf0Jt6NA4sNyW9x1qC7SEh3iENhRBOScZoNi/YpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9SmUCURiMgRbzGNKolpbYY0dx8K2tIbB6WcHz2yQYIJzJTnUy/sBoAveHBI6iB1YIqMOd+y7ctVRIF5ZV5eC49yQcNTsqFMt7542olyv1ebgJy5Nj41YdjIKUKHo7MUFfquAGsAgzQwNx10eJFxArTdweeHPEb6DB7xZMVzvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZmsCX7Dy; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so18686160e87.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632571; x=1723237371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8kFf0Jt6NA4sNyW9x1qC7SEh3iENhRBOScZoNi/YpE=;
        b=ZmsCX7DytYOl0XnCZ8xlxEB6phSoYafcwUYJFFkfDSQkxMEKYiH7Oszm6B7KbjP+dH
         s3eF1svtBRtNRikTLcdxQVGX+i9x//JJPT7Fg7QOF7fFPhqSY+U3AovZjf9VtBOcSIkd
         QqgOxkDlRHV1AvWAJmbkWo381/J4n4fenqQNn+M6+FiF37UG/XBDkHc51wztyzZIhyEt
         qa8qfd3Kc5baKNrm3eLoZOZGX9LyNhx4/xFLfFZHov6MBWQ8uA3jlM038Kx6WmsZ4QKx
         W2cl62CRYYaey9qQZK/tRtHYKSMAX5dB3rDWcMYIcD6dUobXuCadElkJ3BEEwNqK4WZX
         6BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632571; x=1723237371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8kFf0Jt6NA4sNyW9x1qC7SEh3iENhRBOScZoNi/YpE=;
        b=uGdKt6NXZsXEE5/uww9HS4JmdMHwIkvHCemtxc2NI4KFIaHdEuOPSln60HRX41+PMd
         QDQUfH3m8NG7p4tRAHjNghDCfVOFdoQdDperRW8uKDMPv7JizReur1VGthDcc7MbfAYV
         lYez0mHiRNzW//SAa7gWim4YZ3osdSnin+2egvRvn2nuyezGH3OO2kEpBTcIqGyXMnO1
         GTE671ax7htX7GWox3eR781Z+E6zSR7UENovaw1BvJvWL3YWzcwQel9gyJR0IioxWI0Q
         /gK8pBRWos0GCZfLSv0Hiiuu9jd6HZFX7TI/f6Sp6cWZs4gCn17IHoBmLzViKODukk8P
         fs7w==
X-Gm-Message-State: AOJu0YxC2PiST8oge2irwaVD0UdQvQ0k7yYRQMjR3uC2Voq7eI6PO2lb
	sozZKty4+5sSloBI49tIojqSdWfgzn46VgABTK1wk01KtFrQfepB+X6A5wFRmMnNGK7vm36gHoK
	uUMvqLZL2SF1hAx0WsM0VjDx9ItyNdhVHhKB1AA==
X-Google-Smtp-Source: AGHT+IG9iocRNKrKKnUuVyBrBnCQiAmae7NKntQVMqeZsr5uEwqat79wo6dWkIPEOd5pUjoq+VHGi6dJhy+T9uAyKOY=
X-Received: by 2002:a05:6512:b07:b0:529:b718:8d00 with SMTP id
 2adb3069b0e04-530bb3734f5mr3615718e87.8.1722632571416; Fri, 02 Aug 2024
 14:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-3-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-3-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:02:40 +0200
Message-ID: <CACRpkdYrmQ3HUSyY0BGq90ZigwuorOGZWehxpxw9M_K-n9-SDQ@mail.gmail.com>
Subject: Re: [PATCH net 2/6] net: dsa: vsc73xx: pass value in phy_write operation
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> In the 'vsc73xx_phy_write' function, the register value is missing,
> and the phy write operation always sends zeros.
>
> This commit passes the value variable into the proper register.
>
> Fixes: 975ae7c69d51 ("net: phy: vitesse: Add support for VSC73xx")

Actually that should be:
Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")

Yours,
Linus Walleij

