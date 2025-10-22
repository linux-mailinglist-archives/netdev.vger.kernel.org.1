Return-Path: <netdev+bounces-231814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5200BFDCA3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D52784E7A90
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CA2E9ED1;
	Wed, 22 Oct 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJTmVLWh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87223313E
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156834; cv=none; b=OaqbXtTZAoJy6unM7XJwq9H1KXI0/msx1vPayIOWQStBbqm24P8eFafXK0yF1LEZmvUDlj6dDjUjtpbZLrlGTbskD/9N13gFlLBF8qtaQcdLzG4Gc4QOTdSmMObTWnH4LFpLH0vPwHCqI3ocCrUyEAi4NqXQin+ER4vn7an0/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156834; c=relaxed/simple;
	bh=akQcrtSvdGBJ2NLvzjLasBtPJVzXK/5I2L4U8Q3+cx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqHjNfRKTfCLfVobKYGSD/zB6xruRStCt0yw2F3d6TZXL3GgtI+vgjVofpVn8pNw9HliS9lz19AovO4OkCG38AgksqDALa1++i+ZAYlTYsDv7UbnKEB/gc+nwBsO30Hf1pqtgPnf+brRz0Tcff7fjD5djfYa5fC/PqqOFR+EJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJTmVLWh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so6780132a91.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761156832; x=1761761632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLJgKW63U3laQ8TNHosGYPDklPCsb+gg1+m7SNDlD30=;
        b=aJTmVLWhsrocumtEMVBTdTfaYYYXzzHykyA0n9TppyEDxxfEglIlKtGUCuq6614OIe
         ceUVvFES7gJsZBu7war/g5KmLKqD0ZJu+EQG/pMEjvoBMnlFfFhOqtDLHt7wzRXY9/mW
         gNkjnsMTyDZjCEa+aEMfwMbbv2Y6Wuj6Gc/pFg/Q2b4TkuY2Pr/LJW7TEyfgL4SF0MVL
         7TcH4HV3yxZcyn6YNb6tyBzEJQdBUvyay7LfLyGNRstvht4nNLrtGpjfPnW9D1ehWUMd
         NPUUpBPtCjvqMJgaZ7xPglY+hDnUT3puRmI46KodcFP/UE/GlQ1R8u28DYcgyqUc/VIS
         NbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761156832; x=1761761632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLJgKW63U3laQ8TNHosGYPDklPCsb+gg1+m7SNDlD30=;
        b=LQiRV9l2SRf/cznVCZ7YwFBY4LA1CJ/JmR6wJ7K6254KtdSIo70bICn9v0Ow5ScDEM
         0tjDsv2UkFUJ8v25PIxqz1zes8O2RfLAEZUm2P7+dEvLnXzHW+4JfS1UjnNKcy+ZKhFH
         yKtW79h8UumYYy1CMkyy56UQXyr1XC0YelaO64kq+IRRV/BJqMhq3856bFLRL4HJtdXg
         6TOH+N0VHum5gxR655+dFgx3hqwoCJR9grVYqoI5WH/hzvC3Ua2dr5voB9HateC7fDMN
         eVZetYPlmrHOC7N80qcuO0DEEQM2v0dGXMAPZWdV+dUQezsPoKcd4Io4ec2V41r5Xc0W
         9u9A==
X-Forwarded-Encrypted: i=1; AJvYcCWq+IfmwiyRQw0xcGURBnxMZ7mmVR0K5CXgU9hcS4JFtG7CHyuOsh5vXpPloLKAVZ1Myhw4NY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD5OSRZ++GYZ6IiDMuEjj9g4Ssh2RHL9lIytcH7o6b2NsJyt/l
	t9a9ZjX44ApKd5JmWzMFlvxwomhf87QBqPk8rrV/whvYHY5NwJLzHS+9
X-Gm-Gg: ASbGncsVPWLc8I8/ju58K0i2NDVELaClSNmPsXeYEwFyxK+ilr2abejNlH+thllS0jP
	sFOz8wDGDrSY3Yx1ughGmbYMZAyXdZcfHM/2AcSHjAk9N/csmuAEEPlX0GisrXmhONh/1nEdOic
	NKxCAH+xTfdKwFe9HTd3ajB/MM2HtS1worl2wV2v+dhDvpyAcgkVPUMSz9ljSjZTGb/QNb44l9p
	LdcgsG4jGva2Jk8bkq1xASozld9X/KeoXh/EhfXJen5w9sNg63chGdJGP2sRQz2nQjQbta7Spcp
	JZbyY0OARCuRN5AdaAQk4WVY4FplzCQ+1Jqqs///IvGNOls8NJx4/AtdkeQx1vTvQc8fSU+xKfJ
	adc86xQbTQxYq5Wwz2b8DLPIG46QaIWHNdjoiPcsTDYwTZKhm0KZyi5w0luQAPMHjFu0f1y1sSV
	BYOYjEPPWghRCu80/gXraCUPhG25Pc9+xF1ojkzw==
X-Google-Smtp-Source: AGHT+IEKSvBBS8awXEhQRZuuE4/RFkGN+a9c8XIx/ZTqTS76us8OMEo2zvvCAOTGGDCXlFKP7uLGXg==
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-290c9c8968cmr299698995ad.7.1761156832260;
        Wed, 22 Oct 2025 11:13:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e22428b1esm3212795a91.22.2025.10.22.11.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:13:51 -0700 (PDT)
Message-ID: <82e4adab-73b0-4ac7-8c29-718b12a73468@gmail.com>
Date: Wed, 22 Oct 2025 11:13:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net: phy: add phy_can_wakeup()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCJ-0000000B2NQ-0mhG@rmk-PC.armlinux.org.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1v9jCJ-0000000B2NQ-0mhG@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 05:04, Russell King (Oracle) wrote:
> Add phy_can_wakeup() to report whether the PHY driver has marked the
> PHY device as being wake-up capable as far as the driver model is
> concerned.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

