Return-Path: <netdev+bounces-234247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6136C1E1B6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EA5034D701
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF3253957;
	Thu, 30 Oct 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bovUsrHC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752C1F94A
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790594; cv=none; b=c9+GbOjS8+S3qQb3jvaHagDhr9A7HWENqVsx+5i8E7lFVc/aLpEMtJK+ZCQN0JQuRUlR+lwG0P9x2GG0PCXBLjEXVd9ht7cEaFKxL5foVS1X4yClpx17i4oeV/MSwdEjJN5KG31k0RTzKKsqsk12j2RrpdraCJuiOUZCtCIMR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790594; c=relaxed/simple;
	bh=B3CAAoANZ8AdYUQ/vBMppNZHRyDpgu6a7ycm90jmpdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5J3lV0aU5+BJQA6irkbolHcs1zkDqy0gAcFN5VMiQvzF6G3d7x8XQCiiudP5IOCxzmRInZATw+EYRuc5usFeAhcVeXsy2Jkli4cC2dCulQWeeHMe2TXEqvaj1O30urA0zImScaEL+9YtY5giL9LDDDyEqYcJVDVVU/77NJ+1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bovUsrHC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so714842a91.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761790592; x=1762395392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=skyS+Cuyodx+9RItDMBTIU91z9/i7AQUnbc/OyIR+As=;
        b=bovUsrHCfGt7YGFaza8N393yO9/cWakiXQ1Q9kZ5EEo45hMl9HTWy3XRcoPlMxfL/M
         k1xDxNJAC5fZbRBAqn5VHnYlmaywN3lFR2xjyPpLDFbJOUYp4ZbEYkpZOY0J+ABlOb4o
         3aaFAWJq4e++8ayUmIZKmss8QWTdjAS/1Izxag2BJQ9fe1EoD/YZ6BKpt3PFg9qIhC+/
         syMadwLvJvgba5qk2pS1usH4JpKq2MK954XP1aVdkbmTeTNF3JPkdlRnoxHmw1WAvsZs
         zRYoc1cAAAtq+arqFC/k7p0lfbaMSVZ6lnm18UVhJKgyRnm12jfVCPD51rp4YrIQOutf
         tfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761790592; x=1762395392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skyS+Cuyodx+9RItDMBTIU91z9/i7AQUnbc/OyIR+As=;
        b=Nz7H7INxZ9wV/gMMmKYgqp6A8QFk8F3TWMz5iK1WNzvl/s1aY82uVnKIQQq+U//Ei5
         JO9smamYuad6FEeKqUVBKgNPCFUu3i1+VhcgGp8BSSsGn3mmXr2RGnsiNZ0oXD0kccRt
         SbQuQTQqVuEkTBzykUFs7R4QA/iRv+l2jC+uWW+XhdI19pfyBmFjemWREwFxizOSPs9y
         HeI2zQ1YO1WDLKTh+LltwA27atkJN+zNjD69b6ODzNx2zDqdmpsMwJBbiriazkzbxqmY
         bM1vUyCtqb35h3dU+7gprKUTVwQIIRv9r9APXCd5e6CKwb2eCc/qFUpTBbkvdZDMArou
         7tGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR+pWc0YOgo5UBmZTm1uCagrw64+2y8ZUjJLXg4WE354xHfOcTFN0tipyVcUGHn+Da/mK+Ids=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvX1OoLVEDHzGESf6Yb1398Ai35BzTxLOo2XTrB0hry0hKDLgL
	41V0L9QuMRX1JerHnON/spT4QWl5I2cPAthNdZ98aPU6pJKl+5eRDeUS
X-Gm-Gg: ASbGncsPh2uwPPmF79H0sf8ZRMl09L6rjUx/n3DEIOU+z4CsaxqzO0TNaYFFALpSbdL
	N2NJGEt9F6nxjBvyx2nfzZizrgrkx3WJQCQm0uQsxSITERTUYApiejpUDcwCd8ypF/EHPDuLUQ2
	vT7kvpETC3B6ALyNmVH3YW8RyIuG2dwYcTu28Sd2e41ecrXBT5XcyuydZ6NFEgN/c13lh5lJN03
	mBKplFoRNHZGkki5IhwqskUFSkQ7b4qcqUG6/GPSZinors1MePkJZdrPR4/m+mc2V8LGq7D1j6q
	pPg8ytKeU0abREBmWj8fLz2/WWBwvLO9abIWX0qlKyroSPjHQPh/lCNjKCAo4oUT7DfAT0/GpaM
	HcZinI2uEw3eUMhjpmwfT4vKuS2S3PfftkMKvPgM4PmldTTK5/7cttTUrVMcRRcq3mSO6PhLob6
	Q=
X-Google-Smtp-Source: AGHT+IFhl6dhnMtg2Ql5+VRs8APrxjowbgOu4JakifHuDRZCkhJocdr+tQp+x3ll8cCXsnDbLGKBuw==
X-Received: by 2002:a17:90b:2d8c:b0:339:ec9c:b26d with SMTP id 98e67ed59e1d1-3403a25bb3emr6580820a91.8.1761790591601;
        Wed, 29 Oct 2025 19:16:31 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050ba1472sm580887a91.17.2025.10.29.19.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 19:16:31 -0700 (PDT)
Date: Thu, 30 Oct 2025 10:16:22 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 3/3] net: stmmac: dwmac-sophgo: Add phy interface
 filter
Message-ID: <kvkmvw2a7n3zils6rx3casv7slgzvli5cwlukmixly2loju2aw@vsuigze4wgwu>
References: <20251028003858.267040-1-inochiama@gmail.com>
 <20251028003858.267040-4-inochiama@gmail.com>
 <20251030004948-GYB1549833@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030004948-GYB1549833@gentoo.org>

On Thu, Oct 30, 2025 at 08:49:48AM +0800, Yixun Lan wrote:
> Hi Inochi,
> 
> On 08:38 Tue 28 Oct     , Inochi Amaoto wrote:
> > As the SG2042 has an internal rx delay, the delay should be removed
> > when initializing the mac, otherwise the phy will be misconfigurated.
> > 
> > Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Han Gao <rabenda.cn@gmail.com>
> > ---
> ...
> > +static struct sophgo_dwmac_data sg2042_dwmac_data = {
> > +	.has_internal_rx_delay = true,
> > +};
> > +
> you forget to address in this version? see
> https://lore.kernel.org/all/ljyivijlhvrendlslvpo4b7rycclt5pheipegx3fwz3fksn4cn@fgpzyhr2j4gi/
> 

Yeah, that's right, it seems like I have forgot too much things.....

Regards,
Inochi

