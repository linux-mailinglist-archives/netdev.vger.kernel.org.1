Return-Path: <netdev+bounces-107200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC79E91A4A6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5930281DFC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE52146D7D;
	Thu, 27 Jun 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3UiQX+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD21459EB;
	Thu, 27 Jun 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486642; cv=none; b=SNYEpC7w6RJhRt3CRokD+nRkxQdq2KCDMAvy8L3wLMpuBNO6IyatETi4DWjOr3QJ1AdpFIsUbfis+U8rqIhOVHCw3OE67mEo6U3HY4yPLbZclqlCS5pNm+yba5Yq0dzbEQKlY3THh6X8WoPGklr0uU2HZlQCHEo8taM+D6Tcv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486642; c=relaxed/simple;
	bh=EQ9a4SVPlVS31eDUYhL49b4QXgWqMZA9TEv9GI5s6bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASzgBLmVUNCduzktXmrSc4lSzPWd03MQMZbupeVS5g3mxbGLuBIlxHTypInrj7MHyRzA/Co9DS9MFl0peZF6cs7d8qKA783CDhglP/1Q6AKEqgwZhlbvNfDPCVjU6Q2XyTL/p9o5CBZrVTBDXq4EYIqUHNkKpjPdLwu9JGu6/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3UiQX+h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-424ad991cbbso15561655e9.0;
        Thu, 27 Jun 2024 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719486639; x=1720091439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ41cKVFUDoayT4CnMdbSFrorOT6+T+2QyObCadagbA=;
        b=h3UiQX+hqKv76QAKwONp8AhKnC4NRRy9c6h8VbYm76uPYZVAFhITFS7ZHB8xtOKUcU
         muHbCzHTQ8gylJcLTb/7TLqYAawkZavvZodz398fF5Gj8vyE/QQ9Hcz4aALHMaz+xU8e
         002dmaUbgmV/N2zkNqSvXiuTblFMGLcQhES+sPNnDHWsoSVsRD7cNgQxVyXICfp6ZFhe
         20AG7/1Xj2gKqzjoFj7fNs4mX1NS2TEIIIpRehgtB+hR/rt73VFkDBO9kn8KrPFh7/5D
         uBxfmZkynPvO8ehfoXAobO4dStfPlCxNFZHcKMz/ZsZxJYl6GTJiTYPGEWLjtARJQWmS
         y1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719486639; x=1720091439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ41cKVFUDoayT4CnMdbSFrorOT6+T+2QyObCadagbA=;
        b=kwotSi8RLnqtzDF8CAmEUOrAX9KenULW9smIfy1jdHv4Cl6876B2RGIUVVMitKxbai
         g8LWcI1gcHgGIJOJfULYNHKB2plM7IRqGbBtnmQoTTrFycJPZzpP0kiXISoOgRytlD3F
         x7NrlutYWFfajPcFzWrGfKGWmtCAXQ7g2DjHRwd3tpGvptl1XpUSrvTChnxOapBqtYAh
         mo93Swpjb4T85rqdney5ApGvz0Bi23EKJk/5fHjWmhFBG8Ng/eCpUPqc5+6RHvFROgZd
         oWtr9W7OhmbNsl6lHmbYGENA7t7y9QvRyEvBV9lfx51klRxFJ5IIU8Py2uT9nwjvxBoh
         lEHg==
X-Forwarded-Encrypted: i=1; AJvYcCVsjgghNbVsAURJqx8Pyx9mzRIpEVwrOHmlF+TVYbBJqDT0eCZ48XlLkMXn+D5INWIJY/p/HB7CP2wTVgPq/WtameSC1/hgzy4DisKtys0XReYHJoXIG94hSuoRkqfZgSjd9lzvtfQFvlBI0YTGU1CUao1NfLdobJ19zBA1AY1niw==
X-Gm-Message-State: AOJu0YwSMPFiZhByISP/iQpP9CNBMjv5aRmJdgC3oT9n1Mrr622lcR9g
	dGQGrqOtpyHghXxjeG6uf6XFoheLwaJDdnLafPVHArqd2Nx3nTmw
X-Google-Smtp-Source: AGHT+IGjITfTRof17ZOH07aYl96wyP8RcQUw3qHVP4Fjlv+Ra5754pHItvboK3VjmikCndiKEWX44g==
X-Received: by 2002:a05:600c:3399:b0:424:a5e3:8022 with SMTP id 5b1f17b1804b1-424a5e38107mr42905705e9.34.1719486638478;
        Thu, 27 Jun 2024 04:10:38 -0700 (PDT)
Received: from skbuf ([79.115.210.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674369982bsm1484333f8f.74.2024.06.27.04.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:10:37 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:10:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 00/10] net: pcs: xpcs: Add memory-mapped
 device support
Message-ID: <20240627111034.nusgjux3lzf5s3bk@skbuf>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627004142.8106-1-fancer.lancer@gmail.com>

Hi Sergey,

This does not apply to net-next.

Applying: net: pcs: xpcs: Move native device ID macro to linux/pcs/pcs-xpcs.h
Applying: net: pcs: xpcs: Split up xpcs_create() body to sub-functions
Applying: net: pcs: xpcs: Convert xpcs_id to dw_xpcs_desc
Applying: net: pcs: xpcs: Convert xpcs_compat to dw_xpcs_compat
Applying: net: pcs: xpcs: Introduce DW XPCS info structure
Applying: dt-bindings: net: Add Synopsys DW xPCS bindings
Applying: net: pcs: xpcs: Add Synopsys DW xPCS platform device driver
Applying: net: pcs: xpcs: Add fwnode-based descriptor creation method
Applying: net: stmmac: Create DW XPCS device with particular address
Using index info to reconstruct a base tree...
M       drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
M       include/linux/stmmac.h
Checking patch drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c...
Checking patch drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c...
Checking patch include/linux/stmmac.h...
Applied patch drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c cleanly.
Applied patch drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c cleanly.
Applied patch include/linux/stmmac.h cleanly.
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by merge:
        drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
        drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
        include/linux/stmmac.h
Please commit your changes or stash them before you merge.
Aborting
error: Failed to merge in the changes.
Patch failed at 0009 net: stmmac: Create DW XPCS device with particular address
hint: Use 'git am --show-current-patch=diff' to see the failed patch

Thanks,
Vladimir

