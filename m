Return-Path: <netdev+bounces-173898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A3AA5C2B6
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAAA1894DB2
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA4C1BEF77;
	Tue, 11 Mar 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zjy+XG8H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601833E1;
	Tue, 11 Mar 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699842; cv=none; b=NS6XLoD0qXWfXBHjDtMMMBbGpNB7IiNMo8g4akDOpOHX7yrPJzAhjj7SVNbyglKxSwKfZ3XRQgmtH4vjhFKcJ0tS/Nr2R6QwrCKVCUdjyGcIriWyF+ceek+oYLnu1zjGwf/GIe1KqMbjR4Fpao/uDr9p/wWu0/4YpVSZgouRIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699842; c=relaxed/simple;
	bh=DSIaqEYMgkyYCBJZ5KNBTAo4Vk3cJBXJ88bu6yBkm2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKkuQEAVjQ7rLccbGOLATsvL26ioj6FvRmuY2KsRKrlChChq6H0sTlzTJVlD7/iXJKU6sEyyRnsdSIsCpPilJnEeSbqpC6VLEpDe9mMhJU+Gi0CwimkNNW3Q2glNs4GHQm39iGBsrmsiyZ2+S+W9xhwjfSGvtOO8+bvFatRkW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zjy+XG8H; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso2243373e0c.1;
        Tue, 11 Mar 2025 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741699839; x=1742304639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS+kx1EYJx8zGVZAVZxDQft66T1VTJ/fMWqkBxUi750=;
        b=Zjy+XG8HgQmUhiQ3CY7P/s/MGHR3AYob+n5mWBjJ2iMkuzRGfZ2Q9tif7UE6rI4B9K
         vt8lX7xTGKgk8x3v5Dzj38PyWtgPR73s0IX2o4w7QUP+4zzl+AFgzogP+A7NJDaJCrzl
         X9LqaZhAsMyH4ITpGAObm281k9pzT7cBrQrlB1efblOUh8wCxr6wrebzo9cJsc6DvVy+
         kW2heRsa4xJ7DMc56RVD0DQbM9ENN07EXxLfHzQi6l3qBKZ41BG8hl4E+lKhMb5I3DFO
         BYwGtekbe8A7VQDii7G+6jd9+YV0btZeMVwyG14lFnGrgbY904mNdSM+zVc2L/jHKi56
         KurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699839; x=1742304639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS+kx1EYJx8zGVZAVZxDQft66T1VTJ/fMWqkBxUi750=;
        b=s58Tpkf3H6NOVkE2iHLqzWSzkFEjxDGGl5vVHhv73/V7FhO8LJYwL1p+drYAOYudKb
         QrAFQAc7Ytrd37qhKY8qJZF6eT8cfEz0P8baaE+beZX+j3pq/VhpWVMRO0mY75CjND26
         YaesTkMaXNiWhLca1gAfm5bB6s9hf/JcRjRhmH6Ykr2gfOhkHaggdovk24Kl0TMGi93N
         8d3GkquwbjlOSxg5bTBEOMrHwyuL6qxVciQAnTHrmiieE/CwHUvhb3NbCh7W/fcY6XqI
         TqMloUOuRL0Zeeue+8MXFzewqc2U9zjtvdkhTxdIN2WLU6pg3p6pSyLbo/DayGlGoAAv
         7icA==
X-Forwarded-Encrypted: i=1; AJvYcCV+eKHxgCz/mXnoj2LoJ8NiVRMyztnxgqnogvST9Q6SSj8Jwr7uKQ+j7LEGKi8bZKgcwnTpR7u3@vger.kernel.org, AJvYcCWefNikSYHS467zrzzUM+Qxmy/+9nGuHYabRRv5H7j0GoQpSNEggfUSNISWJvVZxzotmKop7ifNeB8T@vger.kernel.org
X-Gm-Message-State: AOJu0YxN4rHQDG7L/b7IAPgoaTDMWKgOzRKRbRebuJE68QLV6V7mpR1w
	LcLBvpYlEHoOWo4Glck5ueUFamjrRW0F4yZNbuIpAhM0u1NxVmwGPLzRqWN0m171mWHPNg7bRWr
	AfHalfkxdBMs/kFxVkVqvH30YeZc=
X-Gm-Gg: ASbGnctbZynmjyR+CVJTnD/Yhkw91xl6N7UViCnkKanjfR0rZe/BMT3MVx6FcNk2hws
	3zy8NiIDUDaj0kYzKFi/lR4cMaBSLQRF2/a2QdC7HMnZOzTI7SDK7sDqQWE58LGLUeFdVRgYqKM
	22ZpNEaUAJcntJVlCbJR4bxHyRyg==
X-Google-Smtp-Source: AGHT+IFy2Sl8rkBIl4+/ZfojG+Lp511BkNoNkiebfxbXz25a/xXmKtCtJuK/D9U65TOMGgOaav+c8ESCttCkqV6X1J8=
X-Received: by 2002:a05:6122:2011:b0:520:42d3:91aa with SMTP id
 71dfb90a1353d-523e3ff118fmr11782712e0c.2.1741699839299; Tue, 11 Mar 2025
 06:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z82tWYZulV12Pjir@shell.armlinux.org.uk> <E1trIAQ-005nto-3w@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1trIAQ-005nto-3w@rmk-PC.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Mar 2025 13:30:13 +0000
X-Gm-Features: AQ5f1Jp3UtuRRhR-96fKi5aM9eNN6ctPoGEYrjWhhbpHpPNGlFs33K9fIDMWwbw
Message-ID: <CA+V-a8u34cKgccW=qEw=FC34HH+Q6pVmRqeMq7Q_btxqkqNtnQ@mail.gmail.com>
Subject: Re: [PATCH net-next 6/7] dt-bindings: deprecate "snps,en-tx-lpi-clockgating"
 property
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Eric Dumazet <edumazet@google.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jose Abreu <joabreu@synopsys.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, 
	netdev@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Abeni <pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 3:13=E2=80=AFPM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Whether the MII transmit clock can be stopped is primarily a property
> of the PHY (there is a capability bit that should be checked first.)
> Whether the MAC is capable of stopping the transmit clock is a separate
> issue, but this is already handled by the core DesignWare MAC code.
>
> Therefore, snps,en-tx-lpi-clockgating is technically incorrect, so this
> commit deprecates the property in the binding.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 3f0aa46d798e..78b3030dc56d 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -494,6 +494,7 @@ title: Synopsys DesignWare MAC
>
>    snps,en-tx-lpi-clockgating:
>      $ref: /schemas/types.yaml#/definitions/flag
> +    deprecated: true
>      description:
>        Enable gating of the MAC TX clock during TX low-power mode
>
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

