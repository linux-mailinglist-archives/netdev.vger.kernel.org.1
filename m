Return-Path: <netdev+bounces-143710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ECC9C3C32
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D3281190
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095E17B51A;
	Mon, 11 Nov 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYjpMyx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB215B971
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321601; cv=none; b=bmoIPteuMavrYhLwLZdSL7GKifIgjGMfoi/Mre9mVoz9DE8MaMXPSXBYpnOfMWCTH41hl/jyjC9/7rgLbSEgKm6LW6OV4Ah+dodbBigd7UaSjqLUL01KACIUNhsOfjED+fkFio12S7xQzh9+vsE3sutq9l6hneK6ymosc92Q5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321601; c=relaxed/simple;
	bh=ZooVzeKA11bNCV2rZauHGdxFYbOKwoDzCawkcPIjnkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXvcyNLqDUKAPfS6JFe2LfEi6u+J7ugeavdrcLlQQ8P1hyv2KrOin1IAFoHxyrUb5vsCLII2fuP9Sv/cOHv8B25J3toyF1JoPHupN0XOw8LdIs0yVAzPFUtpqJ8uUqTLO5oj/Ayk+FcGn0PfMeh0cineoIQlRG98ci8FjRopn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jYjpMyx+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c94a7239cfso3388317a12.3
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 02:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731321598; x=1731926398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83Ex4i0amGXOVK4wdTZcphg7YQMJCRSlYiBwa9dai4Q=;
        b=jYjpMyx+byufTqv0+Xi2r4R2xovD3vTz2uGDnJdp+JeD0g0UMzyGDVVRvE4W7mtVC4
         yC2HKP9kYcmReJblx+MfxOcP7Gcqqrzh9y1ZAfqf7U9iZFU9rYOb0w73GtLxZzPb1hbU
         +GGSszBONe3Tim0lO2QQzPtCK5CNrVNOCOWyS+MeNsY09eAqXXvNWOHJC4iabkoRy6lI
         Pg8rFuqSYbFdxWMEQztC3nB9LOHvTh/gcVisptu/hGqTKgVe3T6h+CvLEmt9afL5TMbj
         QjBGYvR5yCfRcz40g7DBWFhgqgSH6D3r98Hy34cnOiLan01VES94sMoX26VAZWFyPrcc
         dAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321598; x=1731926398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83Ex4i0amGXOVK4wdTZcphg7YQMJCRSlYiBwa9dai4Q=;
        b=WTlha0sjy6lLMa2eYlCKYnWfAhgjZyJPsqO4ZD59Epl4w5sH+apAQpQaSO5Ede2g7m
         iTThl7IxKDIfoTDC8Ce8K1KbCdLI0fiRv+ke4lGvawqoJuCc17MJo3HycPWk/CXQQFCm
         75DRRZVx0/GGBlYFVsEu+Lx6qzmKU330SoZ42aIGIx6iVc/zrkO6JwU6cSPxJRwZWIS6
         cjigSEjv66Kkg0dbhBpbbvC+hMznpgycclqKvnPwg1t5ppTmHyidOCYFrpSJJ9J3PNtv
         IMP/Ty0zVC1A8TBJhQE71qmoH26oWtJgjBo5aE+ceHMph2A5RW4gC3rHPnka3KxObwHo
         CNww==
X-Forwarded-Encrypted: i=1; AJvYcCV14IAfKerJNji6uUxf2FTaye464221FfUT9AWPshVu4w5TdBRD5y1+6J1R9xq2LlPQrp/BsIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8kiRGHG91RlLuHAvZcBSkWLuI9Zx16nndr6Ci4F/+RnBK1Iz
	MTLVbSrws8EgUYjtUR0wWttzpr4KV7Lb7+u6THoa3DMPCvmYDbE+jRr8wXQviGM=
X-Google-Smtp-Source: AGHT+IG3n2/H+iwpqZ5QO1ewQ3Ger1ZK+UE8iF8Hgk62H7RKzgwtzGUzRUPggQWQjwX8bVTQ7/DvaQ==
X-Received: by 2002:a05:6402:51cc:b0:5ca:efe:10de with SMTP id 4fb4d7f45d1cf-5cf0a4467eemr14296940a12.30.1731321597634;
        Mon, 11 Nov 2024 02:39:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ed9fsm4794848a12.62.2024.11.11.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:39:57 -0800 (PST)
Date: Mon, 11 Nov 2024 13:39:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: oe-kbuild@lists.linux.dev, Vitalii Mordan <mordan@ispras.ru>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: Re: [PATCH net v2]: stmmac: dwmac-intel-plat: fix call balance of
 tx_clk handling routines
Message-ID: <9e7d4adf-f147-43a8-a654-8c2ee722121e@stanley.mountain>
References: <20241108173334.2973603-1-mordan@ispras.ru>
 <e1b263d8-adc0-455b-adf1-9247fae1b320@stanley.mountain>
 <20241111-def1390bf54ce26f76be250c-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-def1390bf54ce26f76be250c-pchelkin@ispras.ru>

On Mon, Nov 11, 2024 at 01:25:42PM +0300, Fedor Pchelkin wrote:
> Hi,
> 
> On Mon, 11. Nov 12:39, Dan Carpenter wrote:
> > smatch warnings:
> > drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c:163 intel_eth_plat_probe() error: we previously assumed 'dwmac->data' could be null (see line 101)
> 
> There is a patch [1] targeted at net-next tree which removes the check. I
> think there should be v2 posted soon.
> 
> As it's not the first time Smatch is pointing at this issue [2], is there
> something to improve? I mean, posting the patches in form of a series or
> explaining in commit message that the check is redundant and is a subject
> for removal? Adding new redundant checks for the fix-patch would not be
> good..
> 
> What would be the most appropriate way?
> 
> [1]: https://lore.kernel.org/netdev/20240930183926.2112546-1-mordan@ispras.ru/
> [2]: https://lore.kernel.org/netdev/20241003111811.GJ1310185@kernel.org/
> 

Once we remove the NULL check then the warning will go away.

I don't look at it like a big deal that both Simon and kbuild-bot reported the
same issue.  Especially since he reported it against an earlier version of this
patch.

regards,
dan carpenter

