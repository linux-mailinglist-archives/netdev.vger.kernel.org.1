Return-Path: <netdev+bounces-92130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123328B587D
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0811F23E42
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27D3F9C2;
	Mon, 29 Apr 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJLIXPpr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756501B94D
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393624; cv=none; b=ViSDTJcF9nhiD+N/k4MDfuVtzYL5f2jCeGB3x8Joc6Jzd64BggNF/0FpRjMiMxPfq29LuewnXfKjLW5WiAFKBbEzRUMTx6fF48O4c5LeYYeREZHnEqrYqcAcgsV9cj+L3fpN3Yw3vQqK+kGJ/ZBFJxekFTvuXmQk4tXq8f94jXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393624; c=relaxed/simple;
	bh=tuSTpIVn0SW01pSetjW8tMVtLjmm5VhmOL04c8cHDCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFXvC2r7CUd8v14rK/lrBHQy3fpOuog7+aMS1Q/T2bp/WWnFqPX53mjVNNkJBt6YZQ9COB1PczPkCSNMW0GxSV3fyxFOhyx1wthnp2l782YVgGyo2O1hDSBhqkLxjX3JzfcMNixL5LSt3QZ2k9cfF3qG328MbuCXixww+/ubkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJLIXPpr; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de5e74939fdso773588276.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714393622; x=1714998422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuSTpIVn0SW01pSetjW8tMVtLjmm5VhmOL04c8cHDCQ=;
        b=VJLIXPpr8UdGBj1Gmhc96X9sp4ugSZjmWMvES3wD9OrxEpCutO6TL4K+LyVgs+Wx0C
         JQk1lc2zb23Ba2lezrIEuZcOuS0/2+76fPjEnIL2qwJiGa7sY15dNsSXtRCluDuZ9uXb
         6Fg+oI8pyYz5ze06uZNLeAUqHJeixh/sIfin1OY9e4lIpxSR1ULGlu4ByYhETPdhsRd8
         G7f3qcnmHdpcm0gO/ZKxQhSfA1aMm+7cJa3LndpJskns7vZSl+X1nDP9EL2tGbmA6fxd
         VfIiqdTHS38u73zP3o3nQ70UZrdhjN9oYDWTAZcG6AAVYaxrN8XPtV0u37wHmOI6Uxqj
         ZyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714393622; x=1714998422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuSTpIVn0SW01pSetjW8tMVtLjmm5VhmOL04c8cHDCQ=;
        b=nZfHXBeq37/fDUYUpY5bPThpouvNEQvphbzjy69DmF2z3R8wCRZDUb8JljAxJOuHTm
         +haAVJmhJvYSQEBoS6w1MN+net8y/9Hrmt7SKkpSC3S1JaE8WCi1Ur8cX4K6ijR28gxF
         y5BYJrkRWkA75kNQoSgqONDkG8RFhfHjKbVjNLjzglN+YOoCQPMOddG93euZnuXXF5LG
         KdIUIzAVyFqODqyX2oAUGF2dDlDTc4tmKNe1sWth3bZxajbA/qNc6/J96egO3DJaZIQt
         5g6bHOrkAplvu0xRwGxUqVDDN+gdSf+frpiofsBR3fdw+0sEr3dCVC9CzVPSp1Q9zU2u
         CXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ANDEr6+HCdYDcAj+oV7LAN6ow7/YmxumvvmqMBwo3AeFEtDgsDJr/0f7BrhBdmkPRWcd+B/MsEO9BCHj70Ysw987th/G
X-Gm-Message-State: AOJu0YxprMHVpMUmXmigUksg2DypJ3DDR0BPvcr1i+Qbt02jzTxBBmJQ
	Ve18B6aS3CvgDiAxUEontDVqj+o9lAhkuBK49UbfUzoi5jNn/KGqOzUGkGlniQZYIujho8x5jBK
	flJSc5QQfCeZDDMbSFPHkzuc+WvRwvpApp9KbBvE9ptkz2xjO
X-Google-Smtp-Source: AGHT+IFtKvHq4pOnPt4rIKsXtd9zM5FkEROME21Y+SD6+vds/LzBJ1ndg26Hh25Abbz9C/YUM2Xia9UkxmWN68qSwNI=
X-Received: by 2002:a25:d509:0:b0:de5:9e29:b5bd with SMTP id
 r9-20020a25d509000000b00de59e29b5bdmr9417884ybe.64.1714393622160; Mon, 29 Apr
 2024 05:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1s11qJ-00AHi0-Kk@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s11qJ-00AHi0-Kk@rmk-PC.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Apr 2024 14:26:50 +0200
Message-ID: <CACRpkdZ46ji6Sc==S3dwjWLbehwjadmDm_QrnCmJsuY=GXVUtg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: provide own phylink MAC operations
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 12:33=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> Convert realtek to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c. We need to provide a stub for
> the mandatory mac_config() method for rtl8366rb.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

