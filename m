Return-Path: <netdev+bounces-174579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425DFA5F617
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C393BA19F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68872267731;
	Thu, 13 Mar 2025 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7bEIH2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212B2673A4;
	Thu, 13 Mar 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873122; cv=none; b=R92+D/BgGYI/BqgH10hojdQE6KLRiM/dkZZiOnxMFtqIuB34H7UK5bijaefOjzmiUnBQ/yw93LpZCW4R2EJpMzD1C8opoiGd6qNEufnOntE14xjjzTEuOY+tP/FIviecwXHGa0bc5ZsOM0muUiZ4UsAn0RnKB2WOVIbeA71Ih8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873122; c=relaxed/simple;
	bh=bHpxg3FxsEpGxOxCi9WYoHqnBy4pwRNyqrvZtjCjr5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOE24TL6egAJsBKTawtSmLMzZXLqL7fZ0w0ZSAcn8uFdIZdtqFFK4um1vuc8qotWUM4IBvAcnFyGEoCf2TPLle31iK73x3ZxdZOxZOGbrXKciDF9/EW0JOUNhN6wLEn/jtAeS5qmg6+8jDE+AWv1vzJ0PfMELRhEcY5T6yMFnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7bEIH2F; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso433708e0c.1;
        Thu, 13 Mar 2025 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741873119; x=1742477919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIpqoek4eGSOylKbMTSFOVbyM/qGLYGplSwODZFoBwg=;
        b=U7bEIH2FKTRC+qkDQFz4AFaQI1VUij66rlLJ8rO1nwLNC7YETKEF1jhVHCshqP5LAf
         2uoIxI7muC8zSu+ti/wMYNhs/txi8JCo4WkN97KLbGmVAD9O3Zrlu8OUlHb/SXrfYYex
         jN/ZyHoZgvIqtZfUhWOm/A9NeBUhYE+LoAtblRK+adZ3fXwt6kv3BIirXsC2Oh7Aogqh
         DK1rsVDcmyQbdRqW97Oy1vog9RzWRe/4XoRuqRgrrWTBygGr5s9i2KGPEPrHKqsuqSC1
         lmWOCij69s6JI0q1ZMW0LhwkpvLGczMZdypsvZRHtIhBeIV9hgCMWw4NXXenYK5pReOD
         qAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741873119; x=1742477919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIpqoek4eGSOylKbMTSFOVbyM/qGLYGplSwODZFoBwg=;
        b=OMOUbJZLwEvVqk5v+a/xYthRDC1dXZU+NJNHA8DXw8sqIiAUJvWcB1nMyf6P4fFxts
         jTerFTUjtSrRfT19x4dc1jNIjy5G4dWCPC3DM1bzgonr7UXns8S9iwIqK+F0cpmNvkQh
         Sh5jdC8E5Y6eToLt17Xl+pQQNbWxDHujzlbrffStTJfU0eC0xawWbOCNiHTNcv6P6/Yh
         +YfW83WVLh8TQIJvWLOJY9nPsBfoaziehoCXCGfLpBY//wOHfon+t9H6Qo6uPF+jVKv+
         gc6txbrVIsY2z1nq0/Cirr3qwcaebt+JZbjBSOfOM1W051rnMxCVVoQNijUBh0dALEWc
         Pzfg==
X-Forwarded-Encrypted: i=1; AJvYcCUP72ZFxv1QooPXcanj7INHJ8duMnT1nvfy5sSGDDiYfyOlyxeXEuGAOSwQAwZjioheTGNY9yLF@vger.kernel.org, AJvYcCXJsOQzbDQ3e5YYGMHXGRwk1kz30cSjyoSTK0UovejYf+njm6ddqg7znFwyOjwv4DPoq1nauex2/ymn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jyfRTJkfys1OCwvgZsWHyCvl7Zn4ZcYIj+q5y1sS2R8mjW1c
	sSdTB3GL7ONQ4UgJTGbZHucn3ximD9pd02XwQ9zqfW52YZQ3dRh3C/cFMDGfH1izYywImf4Qwe+
	0Wt76JB0cLZ3BxCTUyXK6q1RUlp4=
X-Gm-Gg: ASbGncvhcBaeI1U2FQojKaUhBn+sj8kG7Kmcrvy1sVfZxikP0si9ZCj+N8BUirNrNcK
	TzIWUsj2/JHjRbfcJWXrw2ZWtYJq5AZhVkxcc+TYp/vpgZOQJ8HleSJ8vHau76qswRlM8cKaFC3
	U0oaGBI1Px1K1Q+YbuAgYwyxvGrESluezjPMrX2nyfJsiHLHXR7kG5Bz4xi5M=
X-Google-Smtp-Source: AGHT+IEcryLwmYP3TdsvEC/+UeCHlR3N+sWjCLCU1sbSkHGz1fjASLBhtHx+j6tuN07I1St0YxBKUyaqA22JoKt2WYU=
X-Received: by 2002:a05:6122:1d9f:b0:516:230b:eec with SMTP id
 71dfb90a1353d-523e4076cf3mr19762024e0c.5.1741873119552; Thu, 13 Mar 2025
 06:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z9FVHEf3uUqtKzyt@shell.armlinux.org.uk> <E1tsIUK-005vGk-H7@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tsIUK-005vGk-H7@rmk-PC.armlinux.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 13 Mar 2025 13:38:12 +0000
X-Gm-Features: AQ5f1JqlA8hzG437O530Oq2Xdo4TAVMjVgaona5iqv0GCiHktSEod7myZxpXhN4
Message-ID: <CA+V-a8sasAGkwCWGnbBEjeMRVM79xVVzTq15uJQ_7Q+YwB1QpA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/7] net: stmmac: deprecate
 "snps,en-tx-lpi-clockgating" property
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Eric Dumazet <edumazet@google.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jose Abreu <joabreu@synopsys.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, 
	netdev@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Abeni <pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:58=E2=80=AFAM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Whether the MII transmit clock can be stopped is primarily a property
> of the PHY (there is a capability bit that should be checked first.)
> Whether the MAC is capable of stopping the transmit clock is a separate
> issue, but this is already handled by the core DesignWare MAC code.
>
> Therefore, snps,en-tx-lpi-clockgating is technically incorrect, and
> this commit adds a warning should a DT be encountered with the property
> present.
>
> However, we keep backwards compatibility.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

