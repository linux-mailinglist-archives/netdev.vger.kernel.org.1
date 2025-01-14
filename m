Return-Path: <netdev+bounces-157930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9791A0FD56
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B3B1888B63
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34C84A3E;
	Tue, 14 Jan 2025 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUOxkzJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB4EC5;
	Tue, 14 Jan 2025 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736814180; cv=none; b=f23iRk3478x2n03OWsAzjUBLnYUF48KNWSrWuDi86hEV4//qxQZ21KfrFkdNyApDrA+2CX2oIw+yxaSr++UKCTn9dtEyI3ZW9dhR2HTeSo98CEM/yxxddrKg40qBATkQ3iorMPhXkvVHX2lS18WCy/Ee5js6qC5sm7sQh/Qq0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736814180; c=relaxed/simple;
	bh=4Mdgo5HAHEnkKUSS9HMfqB/lmKPdV/Lc/405dapH6ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhWbgcyeiQo+Ops8Yg25jywVmQ6VV/8I7vKvhC3bmxcEx/C16n+qj1DtRmeyc6TaM5Y1/QSsM1CIRLMi9dsGT0qo5A6uRgjjPGEfHqZDgg2VKs6+hq4vk58XWee9tIl6ZOl/6T9Rhxdy2kPDb9wN9LdYkIPUc1Po5X2aWsm5KCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUOxkzJg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21636268e43so114133125ad.2;
        Mon, 13 Jan 2025 16:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736814178; x=1737418978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/UiYLFlLwTk2sQjZg8A3ILqtZiVXnyupyxwDjYITKXo=;
        b=RUOxkzJg2U0iM19CfjhuAUIIkMCw3HvUvcFHaIT8gqqS+HVilLxddr0Nq8wY46KiN+
         30pjIdYhF+jm0EzIwszkTIB/BjubvQJ/wSuRodFb7H7RYhIFYNhfyikGqAknFxYeHTeU
         RGy1mqnlfllZpWPUY1tUVyqXnvdBuiTNoVzWKymnliyCnkFIi6uTXdptAJXQX6YmmbvM
         PZjTipoDHzxsdfmXZVGgSNcwt4OtfRhy4upfNZjobVkf6tWeY7WxR+tKkM0HgCnNo8S5
         LdHPhVZIeleUBvXtuikywUnbGWWj8h03EqXfLHS8+WY09V/jVJdF3yiQ4esP65yxZht7
         G7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736814178; x=1737418978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UiYLFlLwTk2sQjZg8A3ILqtZiVXnyupyxwDjYITKXo=;
        b=MJj/4wcOnfr+hla8ro7IFRBG0URCcS/pWo6IZ5wQSKPOA4T58Kvywro1qNIuTCEJJS
         AtiCnrWieZcRyR+jn7APIDjrAx7aFahxPhDulZKup6iJAMFyMAjMAh5kzx8ubX2TXCRT
         OzQBy0bplpn9hFbyCKD2OAI/bc3ZVoQpNTV3nGRwo1oPPArMmSsdVXXvhWr0mV0/vgwq
         oLTIgqIkGyB3JbI3CbTH/LQUGt8a7ADHg4iWE7h3alMI9QAi4MoXmRPYO670BA2N9UzJ
         x6eqj4Rsw0xQ1usT7s11FuB3KJOYFxj063L4nAihiRgbeFUiqh8aexrQPjoFttJZavDB
         XeBg==
X-Forwarded-Encrypted: i=1; AJvYcCX7+tw2rNbtIUtGU6qR3UHjJ1/pck0xWszhA0zD0AY/dtxWMalefXpEhumrswfOlRlg/9U09GFbGV6msYE=@vger.kernel.org, AJvYcCXU9VbDf4w2CU//4jC35PPF/eg+8FRfXW77NC1TRAiVkOf44fMe+fjvABfGLdtmNA+rNW3YFrg8@vger.kernel.org
X-Gm-Message-State: AOJu0YzVY5mtUoBbz40KbZRgM0Dn97yGbsRvRLhOcyUjkeVuO6TEUGOp
	xgL6XKD00kiKTWk3TbAOxqASgyaIMWwO5SdziRu7BWE5atsoeEyvclb7Mkt3
X-Gm-Gg: ASbGncv4sSBXI0ZXibireUA2kgq6mhJviAgspldsz+b/KBIKA4fRxDnR+OEFr+o0M3n
	T7QY8kY3Uj3cZqo6Fp0s57FLLQ2cfdkWX+P40ltzGpca4/g+Nh6d9X/ohE5irtSimp1Wnu6rtgl
	rFTx/C1O4iK7ZvKIDR4yiaIWcM5S8csZDoX3Tiiof/1ShksWhsfIFIR/JdcHw1dXUidolFlFn52
	5dKmXQHp/KGn2YpiPwPwODXV/+Iiyzf+3IgWfGnkhu6NdBf8k/fBQ4A/6uS
X-Google-Smtp-Source: AGHT+IE7mGmM4vmR+GJnT0a75lDlxZQQHp4cimm6gmSSjGqwJ+CfPeXRXhxxFjJBkLKQuY8yyE12KQ==
X-Received: by 2002:a17:902:ecc5:b0:215:bf1b:a894 with SMTP id d9443c01a7336-21a83f76704mr351058565ad.24.1736814178141;
        Mon, 13 Jan 2025 16:22:58 -0800 (PST)
Received: from HOME-PC ([223.185.133.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10dddfsm59304825ad.23.2025.01.13.16.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:22:57 -0800 (PST)
Date: Tue, 14 Jan 2025 05:52:54 +0530
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Swiatkowski, Michal" <michal.swiatkowski@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next] ixgbe: Remove redundant
 self-assignments in ACI command execution
Message-ID: <Z4WuXmWcOwlNAZUt@HOME-PC>
References: <DM6PR11MB4610108A2FA01B48969501D8F31F2@DM6PR11MB4610.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4610108A2FA01B48969501D8F31F2@DM6PR11MB4610.namprd11.prod.outlook.com>

On Mon, Jan 13, 2025 at 03:23:31PM +0000, Kwapulinski, Piotr wrote:
> >[Intel-wired-lan] [PATCH net-next] ixgbe: Remove redundant self-assignments in ACI command execution
> >@ 2025-01-08  5:36 Dheeraj Reddy Jonnalagadda
> >  2025-01-08  6:29 ` Michal Swiatkowski
> >  0 siblings, 1 reply; 2+ messages in thread
> >From: Dheeraj Reddy Jonnalagadda @ 2025-01-08  5:36 UTC (permalink / raw)
> >  To: anthony.l.nguyen, przemyslaw.kitszel
> >  Cc: andrew+netdev, davem, edumazet, kuba, pabeni, intel-wired-lan,
> >             netdev, linux-kernel, Dheeraj Reddy Jonnalagadda
> >
> >Remove redundant statements in ixgbe_aci_send_cmd_execute() where
> >raw_desc[i] is assigned to itself. These self-assignments have no
> >effect and can be safely removed.
> >
> >Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> >Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602757
> >Signed-off-by: Dheeraj Reddy Jonnalagadda dheeraj.linuxdev@gmail.com<mailto:dheeraj.linuxdev@gmail.com>
> >---
> > drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 --
> > 1 file changed, 2 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >index 683c668672d6..408c0874cdc2 100644
> >--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >@@ -145,7 +145,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
> >             if ((hicr & IXGBE_PF_HICR_SV)) {
> >                            for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> >                                           raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> >-                                         raw_desc[i] = raw_desc[i];
> >                            }
> >             }
> >
> >@@ -153,7 +152,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
> >             if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
> >                            for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> >                                           raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> >-                                         raw_desc[i] = raw_desc[i];
> >                            }
> >             }
> >
> 
> Hello,
> Possible solution may be as follows. I may also prepare the fix myself. Please let me know.
> Thanks,
> Piotr
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index e0f773c..af51e5a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -113,7 +113,8 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
> 
>         /* Descriptor is written to specific registers */
>         for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
> -               IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
> +               IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i),
> +                               le32_to_cpu(raw_desc[i]));
> 
>         /* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
>          * PF_HICR_EV
> @@ -145,7 +146,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>         if ((hicr & IXGBE_PF_HICR_SV)) {
>                 for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>                         raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -                       raw_desc[i] = raw_desc[i];
> +                       raw_desc[i] = cpu_to_le32(raw_desc[i]);
>                 }
>         }
> 
> @@ -153,7 +154,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>         if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
>                 for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>                         raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -                       raw_desc[i] = raw_desc[i];
> +                       raw_desc[i] = cpu_to_le32(raw_desc[i]);
>                 }
>         }
>

Hello Piotr,

Thank you for suggesting the fix. I will prepare the new patch and send
it over.

-Dheeraj

