Return-Path: <netdev+bounces-129778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F6B986043
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7157288414
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCB719AD56;
	Wed, 25 Sep 2024 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbjpiMS6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E319F416
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268496; cv=none; b=Nk4LdOzK9unOgWcf1oDkmBkmm/A7fnuYVVPUh1Vv7svyBclRkEVKDMsb8KrKtNq0w7MYG75SKozs/YtSCJwnKSxiFyx2na7r1b8qQlSqVvTjoWlG1ZIJ2Rzt+sr/8Q9SbzDm8sO1tRLwgjpHfk/ePa7q7H0v/UQzDlVvJue6GOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268496; c=relaxed/simple;
	bh=T7srYZs9GfbTc+L0CLjpBUULlLTzdQhLR2XAomv+mc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIo2mm6L0+4tJO8P/HqvE1BQWvHwKcUDHAJecrDRJjZjn/y6kGoIF+GgIv8UN9G8K8kvlaxQzxYlBklmUGyCwDvBmHsKBkf9s9mtmdAEJNrb56xl8Ym+Xkx4CYIJ6rFkMjjvkl+itbGSzWoxzBUwKABWab5g70pGBL5xSgP37Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbjpiMS6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a7dddd2aaso76761966b.3
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727268493; x=1727873293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuXdQsw+RRom/AQjZTFSHz4b4b5PpEAcJKit79ndl6w=;
        b=lbjpiMS6WR+rSImoD76C+EoCiIAjzHoOSsW6YsGsJdipbKk1UR2+mfjvKBJODyCkAP
         m0DGvyGy1bcnbRBzIzWe9FYw4y26K8OpS76e3kHePe9PobaQyPq7vTy5UEgsBMxIqXrN
         S4xfc/jQBOCQKV7bq5LlambfwJFChQUjBBM+F9SyFNJgIhSKnih+Ob9g6eqcOFUM73t+
         SfDg98BVbjwZjUuETmLakKnVDtNt8zcO3oS7bq7ER6a/2BvQ7PnyKCGV11AgU7ESxReK
         bw5Nv9b85ZN9vcn+6Eu7m84SLL/k8j6uollXC2xGyWApbSKnxZgcMnx8T7l5r+P3O1/K
         usYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268493; x=1727873293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuXdQsw+RRom/AQjZTFSHz4b4b5PpEAcJKit79ndl6w=;
        b=cYXEJDhGXf7UyDk68rWeILrmGkTOyA0zsXka5xh94X3yomp9bXCGwegaCUSyzY5T3f
         ktHK7QLt8noeyobucfdU24w5YxE5dtE49wdXilAUZfxJqM+fJQjljdSqMGvH08rRmFnO
         H26qFR9BC1AItdXIvT3duCNwsf2nkxOVZDLqdh+4O8h02lmP+N7F1pNg/V0kb/dV7RIa
         /efW+57Nznwp514VcNEgsTJ0F88w0hCWURmcQmW0LqO854BakFG9jTAxmd9yKXgheG3J
         ArNofPCA9QZfpbqvSNz//XpwZaKb+hPOGcP4lQfJuoRSGC9I2qi3v1CoMDvithv55Gxm
         kt8A==
X-Forwarded-Encrypted: i=1; AJvYcCWIsUBNxaGP7JC4y+pVAaGzIPLV6sl1FbqVGK7h1/T5tf70m7ceXWi2eRZm/vcZGKK9w+A2074=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAYYCxOlW//eE1I8ZsvUBoJfjUTKVObII7vQrdBM8gLAqSsasn
	8LgYYgnQLFhiSeDQuWyqHc6pvLk+aVqx5q/oxNeWJxTgo8bY68QY
X-Google-Smtp-Source: AGHT+IEtS9Hfz450TsCH221Y56N8bpHwpAsKkJiKLbNa39+hGodyMA6e5M8gCGSjwSsuRdNKFiopvg==
X-Received: by 2002:a17:907:9485:b0:a8b:6ee7:ba1a with SMTP id a640c23a62f3a-a93a05d63e7mr129465866b.9.1727268492748;
        Wed, 25 Sep 2024 05:48:12 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393133c51sm204779566b.189.2024.09.25.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:48:12 -0700 (PDT)
Date: Wed, 25 Sep 2024 15:48:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 03/10] net: pcs: xpcs: get rid of
 xpcs_init_iface()
Message-ID: <20240925124809.rw7wsmcpmjn7sqxj@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjck-005Nrr-2B@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ssjck-005Nrr-2B@rmk-PC.armlinux.org.uk>

On Mon, Sep 23, 2024 at 03:01:10PM +0100, Russell King (Oracle) wrote:
> xpcs_init_iface() no longer does anything with the interface mode, and
> now merely does configuration related to the PMA ID. Move this back
> into xpcs_create() as it doesn't warrant being a separate function
> anymore.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

