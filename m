Return-Path: <netdev+bounces-115434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A819465F8
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19281C21035
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60A65E20;
	Fri,  2 Aug 2024 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7MjmMOO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DE1ABEB6
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722638830; cv=none; b=rEsNVDxmtv1KRj+nGDR1gyWF8TXMnq1PRbBQu96YDx83bSpXVbi1AyrK3K/vbGlPZNVlXQB8mFk7rAIUpNsJQ+zRCDRIXMEgmUG3V9bO8nn/BhtKAfEAt/I/NN1pxSKsKPZsZIYsJHNa3igTnCmLQjuBVOEMGa4eXNYJjfcwdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722638830; c=relaxed/simple;
	bh=THbTUedfPNKqjs96TIhUgzsZRFAOtZ7uuHKn4O5aN+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gibwyonYn9sk5CLyIsZZvivHUZB9AykbmtliirA2Lxj3ukrFW03h/QELLX6z3UY9IJPxD/D9bfQM/bZhfyMUp7KMpJDIbyg75HgEwflNtBOFsS98YTdoXVSsQdJYabi6QicB8SKIZvxFFEQyrnRE7YPWvkr9qqGati31MDfqV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R7MjmMOO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so12476339e87.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722638827; x=1723243627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THbTUedfPNKqjs96TIhUgzsZRFAOtZ7uuHKn4O5aN+w=;
        b=R7MjmMOOKwoGcyWXPdAKmjHimBgssKNjw9vulms0y4bUDk887y2Dyb3sQSOuwk8n+4
         nkRd0SSX+k9hauZhvhv1Mu4ObP3m1+X4RZwAhg2fw2DUkztNmV8zdxC3/RzTPae9ZNwf
         enPSuIApxI0Mjdj41YsVXVvIrAuOMnOIhuXrruG1fg60AC4/S8IbK4ZYjs+5dUDlGqSw
         54Ae0Dj8dOowo5KFG0HSoCxb5mVpKyDdXSxWj0d8H8Em/Ydc4tnQ0xR5GlkLBpIrZxXB
         SKX7i7bgd/MqeNhde8RRxpW7zASaN+hZpJe+jTmaIlQ4Cxh/3GEhnVf5ZLgqxrrVozmX
         7Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722638827; x=1723243627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THbTUedfPNKqjs96TIhUgzsZRFAOtZ7uuHKn4O5aN+w=;
        b=uojpWwPEOM/xGOQkT5aNmF/bq21kAE6Em9rDvn7F/NOXFz0IaQc5LQkFzm0dKlWxlI
         qpnvD2tP4rryWp81CwLyuk/kq7D4JfnomBWfMWip912QzVc3xvd5B1msPUOqWNAdqYCe
         vgJQOkpWEjK2XwQKFoc5rPbtYAIUyzsrfDOkSOH27+WsMH+Q9odJEz6yqKvDcxczKpbx
         GwO1dhyefgxgTQODgHrsCCBP+5ych1HdlMpRX3iLvtgwQfpViqPvrNsKkzDjk1bml+2v
         /GTa0pnw1ig1fpn6ImRTkaHyi8+rGsAhh1lr+YVHr3j81sWilYK1JGiOJMSR74OG95qE
         bs4Q==
X-Gm-Message-State: AOJu0YzFNl89rY5XRcTHP+8VXhJHSR2+xcYElb4t8+WU+kdhMA9yhJks
	k1fQCKCnRNI7XE3g0/0X1UmM3++xrvP3/knlhWkOAqQccVIqv1DeVJfxSG/jwXZJ/M2MsdPTPju
	nc3DWa8IJirB3mY64TKvHel9Vz4nDogLRK6QMhg==
X-Google-Smtp-Source: AGHT+IHaxphvvVOqZtyqFT8jtOs3FeykDhzmXg4r2inKAxkSbJwEECQUJ7Z9cz9h3d+4wk/yzyUeMpDU1gIrN18B/T4=
X-Received: by 2002:a05:6512:128f:b0:52f:c24b:175f with SMTP id
 2adb3069b0e04-530bb374350mr2990086e87.20.1722638826801; Fri, 02 Aug 2024
 15:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729210200.279798-1-paweldembicki@gmail.com> <20240729210200.279798-2-paweldembicki@gmail.com>
In-Reply-To: <20240729210200.279798-2-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 3 Aug 2024 00:46:55 +0200
Message-ID: <CACRpkdb_7R=B6Ud_PdbrPA4JQViMBLeyAqSbga7-Ljkq0T3M8A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] dt-bindings: net: dsa: vsc73xx: add {rx,tx}-internal-delay-ps
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:02=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> Add a schema validator to vitesse,vsc73xx.yaml for MAC-level RGMII delays
> in the CPU port. Additionally, valid values for VSC73XX were defined,
> and a common definition for the RX and TX valid range was created.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Elegant!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

