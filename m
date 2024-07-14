Return-Path: <netdev+bounces-111339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFBC9309F8
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 14:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C26281A0E
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5247347A;
	Sun, 14 Jul 2024 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3AREP2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0321DF58;
	Sun, 14 Jul 2024 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720961253; cv=none; b=OlMlmYjeh4tYrXNkbVEzbfBU/2DIAlIP+3FAtaW2IKYqnN2fQQlN1JPmSDpd7JQKe81CZslAKRsdSRGEwCc0VkPiEkUrf0wS7nPAdEYB8wE61lDzux/fg7vq/+hlz8A1rSCHpqPMn9XH7rraguRH59sHoMyaWBzjpccRgW2oDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720961253; c=relaxed/simple;
	bh=hZ7lWekYicc/GQPSBXsMSuOVB+DQDtPdnORXDQb9EL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvoSnIUdZtogy5VhLJ5tsYmcsWJu5og1HjrZstGr2KrnTtGxb6+9xGjSbj43i+tESCP70q0A+IH5Z083M1McQr0ny6kgxB55lAL6Y2BOz34vhNAdSqvZEidj1v8sIQpBjiw+DD+e5GncAah9n9EFiMm/QZBfRAJnWOxBMkfzwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3AREP2A; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea79e6979so3853729e87.2;
        Sun, 14 Jul 2024 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720961250; x=1721566050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYeW1aUqkkqQu0pvxg2P+XASuy3RpuxEzFGY7FDRapU=;
        b=W3AREP2AoLkWnxLFTt5y2uH6zoJ4A7gxESvMZ4Vjg3XFohwwn3pGVPRVwJc26Ovpru
         WoBVOE2MOa2xYfFtfU4fPN5nhgUSOEFlUUN8GyUGi3xK5hrh1/IoVuHdm6eYoipG9srN
         0Nofne0KkybdZ4Q1BCy7Hwxw55cR2QqMmkAND+2TDcTPqc5kSnDQyQq/kjk/sh/TGrlv
         IDkeppcxn0pW3HDkNukj94kLox+tSz2VPDBLlsNg9ZCgyJlwba+MCVm2YjTFaG1lGo7i
         5B4EdgY0lxtTEXA0nfD/vbcfTz6AV0QyrtzRPbPoP/1inbgLKHWGkmgROlGTkxoE3fEY
         gO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720961250; x=1721566050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYeW1aUqkkqQu0pvxg2P+XASuy3RpuxEzFGY7FDRapU=;
        b=r4cyouDZpCmMzfM8wKw5WRTEWcLxXhZuvlo2Ep0pG3Y1epsSbb3vD1EIjEAQTGnHym
         yIKL/fqrBQn1Jz1JzkKHj2gN2xJkLzB+Yfke7leXShcu878aiOU+/9QW2VuDWuxkQeBm
         qCXf2UO2i6bAxkvcGxZVRHUE9Hryozpx5f3G/tnoa+cjYnCri1YwRMKGoR1WiuEI0Gin
         iD1w7tpdao72gVxZ17N+3c3fGnx4c6/AxAaY8G37OotwHPG89eT3l/lSjdsCsmAINFyg
         hncxUxSq2xRyVcfq0SFacjllHe6Ku97lc1bNqvAxWoC3AKlPcwGSUXC16hpnjYHk2JU5
         CTqw==
X-Forwarded-Encrypted: i=1; AJvYcCWD4CWzbdgxRcWjHuB/DyvBmdd60MNcIGgogJIArzRmnFvAdqE23exrk0VrnU+E+xWhgKVUrFGAlKrrODO6cS1+kN8PaM4GK1vuUxE95XBuXLXwZ0MRM041Kxf+73wawVxnrcZqy7UApgRaSwV+IA7xA4w5MN4QeBJjIcKqg0rBmA==
X-Gm-Message-State: AOJu0YyvYPoZXbyy1GtY71t+wJFIP1bhJwB2svbrg2NsL1fqDBrVhJLN
	roXej97lgKMHTF4yuXlEWwxvqVQVNt0A7OQOyt1vL6ejiz+XFhbi
X-Google-Smtp-Source: AGHT+IExx4Gr8Umbg0gbYQ03/bv/pYqJqX/EK/+AOIRZKuLKmJm7iyM5zUZI7yWzpxPPD+pjOE17rw==
X-Received: by 2002:a05:6512:3b82:b0:52c:e084:bb1e with SMTP id 2adb3069b0e04-52eb999126bmr11827758e87.13.1720961248544;
        Sun, 14 Jul 2024 05:47:28 -0700 (PDT)
Received: from mobilestation (pppoe77-82-205-78.kamchatka.ru. [77.82.205.78])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24f3b90sm451958e87.113.2024.07.14.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:47:28 -0700 (PDT)
Date: Sun, 14 Jul 2024 15:46:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Drew Fustini <drew@pdp7.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC net-next 1/4] dt-bindings: net: snps,dwmac: allow
 dwmac-3.70a to set pbl properties
Message-ID: <ywwl3eaamj3d7dhwkhcoglxwxqmpwd5dewkq6ldmrfqdfgnlu3@rawh4yhkuh6h>
References: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
 <20240713-thead-dwmac-v1-1-81f04480cd31@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713-thead-dwmac-v1-1-81f04480cd31@tenstorrent.com>

On Sat, Jul 13, 2024 at 03:35:10PM -0700, Drew Fustini wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> snps dwmac 3.70a also supports setting pbl related properties, such as
> "snps,pbl", "snps,txpbl", "snps,rxpbl" and "snps,no-pbl-x8".

No longer needed due to the recent commit:
https://git.kernel.org/netdev/net-next/c/d01e0e98de31

-Serge(y)

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Link: https://lore.kernel.org/r/20230827091710.1483-2-jszhang@kernel.org
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Drew Fustini <drew@pdp7.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 21cc27e75f50..0ad3bf5dafa7 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -584,6 +584,7 @@ allOf:
>                - qcom,sa8775p-ethqos
>                - qcom,sc8280xp-ethqos
>                - snps,dwmac-3.50a
> +              - snps,dwmac-3.70a
>                - snps,dwmac-4.10a
>                - snps,dwmac-4.20a
>                - snps,dwmac-5.20
> 
> -- 
> 2.34.1
> 
> 

