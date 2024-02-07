Return-Path: <netdev+bounces-69829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56B84CC1E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A90B265E9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC277644;
	Wed,  7 Feb 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhLERExa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E37A713
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314127; cv=none; b=NwDI6Pjx4RPCpwlDpTQxElXXlfyElLI4/hyjBJIZRoU5bFUDeM68yluCE2mfDdionw4XyMF68hN0Devx8UT7U6bZO6L6+Fw34QVpHtzxOR4uVCpV60/G3lBDX8LBOHqY4sV5NfivdTi5bknQepvmgcEzz5PSGsgg+6k9n7V2fz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314127; c=relaxed/simple;
	bh=Z7rQC1fkFIqC/tJTWNXMD0dUUmRdRuNQULPDoiyeO1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx4xjEjkkqVD5NasmEK+09xnreKxMM5sVuQuqTXrYweJmlx0FyRKSc0t3X5UG/rvl+eWwIotBzSWodqpok+I4ind7J2gTkRU+R0gYPAcdXoY+/fXFlUBm0czKwpXNXtqljRGynfKJ164HRLihcha1XiYEhXIuHvRLS2QYePR+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhLERExa; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5116588189aso1119143e87.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 05:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707314124; x=1707918924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=by92DEK9XSM7323pyJ6TZwfJcKH/EW0cCEEjPXbhw7o=;
        b=nhLERExaIVsbgfny0PkbHtN2xsMixr55aJ0l8ofyoK/VlX8NHBmSy5SQwdINITrUIZ
         vXiF1gHKAb8HTw7btqH1VsW/Eq+RBPmtGKI/S+FVjpGpKG3awYExggjtI+SVEXC6dUG5
         tXaDAUYnuu/kNxy/C9ycIC0dycN+jAw9Zn9LfhXwSJwDSKGQA+Plg6RVfNAJMuwbatVt
         JUY9ZNqH1d5Ap1CAbGoS8hcOMxl4KP5PMBPwFziqy7e5BItouZeaLQ5ruto0wL4sqaD3
         Zgev96yX7mNnLDfMqRuarc8zuoD6wj65eyBcZ8npswyy3TKNH0We+qoHSopzXcDTuQ0Q
         P3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707314124; x=1707918924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by92DEK9XSM7323pyJ6TZwfJcKH/EW0cCEEjPXbhw7o=;
        b=aLPsW44qN61O+D/MeLbVSHJRVKuA8L/7iCCpumOmyHOD9C8M+Xalvc807Lg5PBpucE
         1zZ1+g+Db+83Aj8SmOTs+qPBzch+Z7XW51iVIC8WBwNmuG6S8jOVo5rAU9PFN+CbMFnk
         AWuufWkmA0nnlGln4lT4lh5NDg2fFPuN6WbsntGGH0/SJX+2ZVYFpdfjOaS/JEvGsw7m
         gMGYXccG3WLHrFxRTNe7Wibkze26p5hMWdu8H5lxRIRS7jFC/dFv8ICcKr4UtqTnpvba
         W13xTYvcb4817NErJ6a8H6DA0vNY0W/ta88p/AACK7TpoEHicm7SnGieQxOcG+utBCai
         SCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtdJfouZ+9FJMuslNL2cBk/gYfdT5w1bNj46wOhjFBNhUma3yj79y6FUFwY5VXKcT8cNa/BNk1WJMKyogdVJmzAyn8tgXi
X-Gm-Message-State: AOJu0Ywy0Cx9KAzuRfFiLV3iKfdqL6AhqW0sjjGW7Hl+B4h++DLsJqDC
	ADRG6f0fqZu0H+N8V6KkyorPfnOS4pBvPf8xKTclaPQr6gfTic8e
X-Google-Smtp-Source: AGHT+IEOk2AGdPkr7JjjRj6vF2sVns8SA640c0gyoR1lwxnBMBbazqa3bKt4C73kzX1xoHZE68EIJQ==
X-Received: by 2002:ac2:5617:0:b0:511:519f:ce76 with SMTP id v23-20020ac25617000000b00511519fce76mr3986759lfd.57.1707314123579;
        Wed, 07 Feb 2024 05:55:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjIt/4gQu1zQesvxRtHLJAF5eS33qGSRoCJO2FtTNPXb1q75lKmjmmgZwe1g+ew0Mphc9I1vYxMMYOLQXkwgdeDq+eHtiMexn/lqKbb0sy9NKkFE/6c5/DL6oNQF+5dy82P79bLa7JDxwu3auc6KaU8xyuInyU5cY0ipGHYsIPOOyGbuJEvaUD5Wa2XtrR2e+9b1f4COALVpyqLPx8CXB7FnpkSorKs7rBrCcZb7jkPzmw++DxjFkXndUd6IheVyeQnOxIuv++wAPTOAyWWv+MhmaeEhqjPbplqioiVcNtJRv3doP0tlmqxml4u+nCPAsDS/ZVc2P9QOWfIF8zEgKckADaRZ+UBdGPoJDk759wqyxLH+8rVtj3ZQJpnKinysqyt9TbFtK4Dd1warPD+Qe6ErZyoaXPbF5BJP91mL66WEhEv2QxrEbIbzZ3IRvUFKasGsj7zt1+Mnc6fkhxjT+/wfi4Fk0ZnjwOOL93IqfUbLGz4b/yBgVUq4INNgji4r68Sm6TiDWpqFLwJ78cMFJay43NGPNUVhuX/LsCS8l35Bsx0/RRC9DVzT462gkTtSFMJpfNaNOh1P8ZVHewQrOda1lGKyeQa1UgIqN3kLsyIncLHQT3rqYkyKzTkP1shgKcXqxyoO2hhZFGIdnAJTi/5zaznFZdpIZzlJ0coO/dvSQCePXO6ZRLE0CLKnOgB+cMy9DVoscSHJ5KvBt8NP61luZA
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id gr8-20020a170906e2c800b00a3840fbeef9sm779222ejb.70.2024.02.07.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:55:23 -0800 (PST)
Date: Wed, 7 Feb 2024 15:55:20 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next v2 6/6] net: dsa: b53: remove
 eee_enabled/eee_active in b53_get_mac_eee()
Message-ID: <20240207135520.2zvinnv5w3v7kruk@skbuf>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
 <E1rWbNI-002cCz-4x@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rWbNI-002cCz-4x@rmk-PC.armlinux.org.uk>

On Sun, Feb 04, 2024 at 12:13:28PM +0000, Russell King (Oracle) wrote:
> b53_get_mac_eee() sets both eee_enabled and eee_active, and then
> returns zero.
> 
> dsa_slave_get_eee(), which calls this function, will then continue to
> call phylink_ethtool_get_eee(), which will return -EOPNOTSUPP if there
> is no PHY present, otherwise calling phy_ethtool_get_eee() which in
> turn will call genphy_c45_ethtool_get_eee().
> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Thus, when there is no PHY, dsa_slave_get_eee() will fail with
> -EOPNOTSUPP, meaning eee_enabled and eee_active will not be returned to
> userspace. When there is a PHY, eee_enabled and eee_active will be
> overwritten by phylib, making the setting of these members in
> b53_get_mac_eee() entirely unnecessary.
> 
> Remove this code, thus simplifying b53_get_mac_eee().
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I see the series was put in "Changes Requested", possibly due to my
clarification question. Let's see if I can change that.

---
pw-bot: under-review

