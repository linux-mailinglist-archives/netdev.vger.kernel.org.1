Return-Path: <netdev+bounces-158367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C135DA117DE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CEF3A5A5A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7A7155303;
	Wed, 15 Jan 2025 03:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m//Mt4yr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B661DA21;
	Wed, 15 Jan 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736912236; cv=none; b=qicDF9DPkywRMSJzkza71NtFzVppuCQ84uWEBDk+jc0vQCey2cXJ5k8Zw0Z65Vk7PujgRhk2Z80cyjHr3LzFZodQz36PdsZ7xu+7WNcO9Kam8XfOFJjAb8On65s1geznq+pJbSjO+td0oKX/6B2RHA+2g7F++BazSxMiER6luX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736912236; c=relaxed/simple;
	bh=xzr9RUzFlvWRbS8Wq6izwlxsEIs9xY0NMTymgpHkanA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lirftgauQfT29mXqFgLDQmgawefv0/Vbk7v4QB4gMKu1aDnONQaInUbLA+PZPb4XhnpWVUiZhPUVV03cMZl7WdtKURK59YQszZcOaiSd5B4AwhvJS1ES15xIJ7ASNusfu8JISElBIj8G1sBhF8Nj3+LirabKVz8EoOhaF38QnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m//Mt4yr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216281bc30fso132709585ad.0;
        Tue, 14 Jan 2025 19:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736912234; x=1737517034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj0+YrUHmRLNjBOy9TBhk4AoGWmWhd9y5NPFHsoWxMk=;
        b=m//Mt4yrHqF034Fpuekup7l/zXZNysh79qVHsedoqsj6QznaXVzmegbJZJURF5p1XY
         ZEp6pdzPMi6dttSvQEwZSQbFAeR0Lf9FXLlbxkyZVtUs7XPKxl5Sgtxyd0ujYR3deNMB
         q7wYYmDFb2r7xRGcD4uk42a3qCleyhEv8aGf6EDXR1PNqXHoVIAJONh3Ib1uT6+KIdrv
         lpOyI1E4L0J/Xr+Dm2iXy+cSD4y4UHZQYNIqxuHk1WMvZNeCD+/3F+jnUjO7P1OYhGa7
         HShC0v103r2306AOOTD7KcqoDgjtcKcy1P13xGwEsx8ZeyI9ZHfor2sp8wcWV3inWUgg
         Wbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736912234; x=1737517034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj0+YrUHmRLNjBOy9TBhk4AoGWmWhd9y5NPFHsoWxMk=;
        b=llgaihkcbo2/RMtcqNd/Q6WhfnF92y4zcf4eKn8O2ajEsFJX6/vRrBXCczwpkZAGMX
         dXPlTopQb1SWzzwiDrMnxfHQ+MdkblFoQh5jaZOhWbwFxGzjK0A+yyfYqibi/krQhg/j
         aE7fnBA8viuCs6HHmnrDm3oz4q1JO9yPBsPHz/BP63YUc7hvBroeoztGdDO2QTqki3Jh
         HYIXRJh3hKFGJk/3Wdr87y1db+N75d8jcDuuxRQ5RzU4wrm0Cf9m2mCNaABX15oH0l85
         Y5+z+dglA56enlMsymZbI1hSiAYRpB+LZGdT4O6+Q2xeV2XBXu0RDRedXbP7TYLIMnPW
         nLlw==
X-Forwarded-Encrypted: i=1; AJvYcCWx0jfpNPP9saOM08PoreSSnlDmy8Z2h3GWqFPCY8s9C1SlCSUu1UxAXlnWuTT1OCT7dBTcRs73rb6FNh0=@vger.kernel.org, AJvYcCXyFobSz0Ggw3WdhfgQgpWzLEGsUc3YWZE03kGnouZsozD7VqLbe+rYBRZ3/cjgY4hmu7Wq3972@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDrgKSVOeVNn4mi4sk0tUBHcgjZbpmxh9znuQ9Trq2kvAmFFP
	KaFjsfddpzRLkVpDHb8q1s0I7u5Xcs+HUx6XVN9MhFge8eLu5Cdl
X-Gm-Gg: ASbGnct97TnIVsQAWp5Sh3AdfaPhXnE9SsG4CtYZ2DjT4m6PHy92B51B0mCXcYmFmCO
	dUGy9E1pBm/3sqLyED8h3XJBrovjpizNJ1wphBEFlGWyGNCrV1b6ovWN2PT3/8kpZt6zUlPj6Wq
	IlRE8UWl9Xzuc09bK4Xiz6tnIimMTiS94od/rsu+zKlgw1iRmDCEsDP/Z6MuITu98B2HbVJVhcK
	J0uWse9AAuo4b8Ohjr+Xtsv2KPX4l+I440GGBWOFbp0JdrwnPHXwVxTNoZG
X-Google-Smtp-Source: AGHT+IGHddRWK3bBj5Tq057kXLlHvQKCRF6boTTCM6xgilj6ZFOKnzvSus/wGg7dZ7MfUl9ZQt0kEg==
X-Received: by 2002:a05:6a21:398:b0:1e1:ae83:ad04 with SMTP id adf61e73a8af0-1e88d134c3emr44081686637.27.1736912233690;
        Tue, 14 Jan 2025 19:37:13 -0800 (PST)
Received: from HOME-PC ([223.185.133.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a319772a5a8sm8912127a12.44.2025.01.14.19.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:37:13 -0800 (PST)
Date: Wed, 15 Jan 2025 09:07:10 +0530
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
Message-ID: <Z4ctZoisJNJVv3/o@HOME-PC>
References: <DM6PR11MB4610108A2FA01B48969501D8F31F2@DM6PR11MB4610.namprd11.prod.outlook.com>
 <Z4WuXmWcOwlNAZUt@HOME-PC>
 <DM6PR11MB46100E03855B13F00F9B6E64F3182@DM6PR11MB4610.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46100E03855B13F00F9B6E64F3182@DM6PR11MB4610.namprd11.prod.outlook.com>

On Tue, Jan 14, 2025 at 12:32:47PM +0000, Kwapulinski, Piotr wrote:
> >-----Original Message-----
> >From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com> 
> >Sent: Tuesday, January 14, 2025 1:23 AM
> >To: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> >Cc: andrew+netdev@lunn.ch; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net; edumazet@google.com; intel-wired-lan@lists.osuosl.org; kuba@kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org; pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Swiatkowski, Michal <michal.swiatkowski@intel.com>
> >Subject: Re: [Intel-wired-lan] [PATCH net-next] ixgbe: Remove redundant self-assignments in ACI command execution
> >
> >On Mon, Jan 13, 2025 at 03:23:31PM +0000, Kwapulinski, Piotr wrote:
> >> >[Intel-wired-lan] [PATCH net-next] ixgbe: Remove redundant 
> >> >self-assignments in ACI command execution @ 2025-01-08  5:36 Dheeraj 
> >> >Reddy Jonnalagadda
> >> >  2025-01-08  6:29 ` Michal Swiatkowski
> >> >  0 siblings, 1 reply; 2+ messages in thread
> >> >From: Dheeraj Reddy Jonnalagadda @ 2025-01-08  5:36 UTC (permalink / 
> >> >raw)
> >> >  To: anthony.l.nguyen, przemyslaw.kitszel
> >> >  Cc: andrew+netdev, davem, edumazet, kuba, pabeni, intel-wired-lan,
> >> >             netdev, linux-kernel, Dheeraj Reddy Jonnalagadda
> >> >
> >> >Remove redundant statements in ixgbe_aci_send_cmd_execute() where 
> >> >raw_desc[i] is assigned to itself. These self-assignments have no 
> >> >effect and can be safely removed.
> >> >
> >> >Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command 
> >> >Interface")
> >> >Closes: 
> >> >https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIs
> >> >sue=1602757
> >> >Signed-off-by: Dheeraj Reddy Jonnalagadda 
> >> >dheeraj.linuxdev@gmail.com<mailto:dheeraj.linuxdev@gmail.com>
> >> >---
> >> > drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 --
> >> > 1 file changed, 2 deletions(-)
> >> >
> >> >diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c 
> >> >b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >> >index 683c668672d6..408c0874cdc2 100644
> >> >--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >> >+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >> >@@ -145,7 +145,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
> >> >             if ((hicr & IXGBE_PF_HICR_SV)) {
> >> >                            for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> >> >                                           raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> >> >-                                         raw_desc[i] = raw_desc[i];
> >> >                            }
> >> >             }
> >> >
> >> >@@ -153,7 +152,6 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
> >> >             if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
> >> >                            for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> >> >                                           raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> >> >-                                         raw_desc[i] = raw_desc[i];
> >> >                            }
> >> >             }
> >> >
> >> 
> >> Hello,
> >> Possible solution may be as follows. I may also prepare the fix myself. Please let me know.
> >> Thanks,
> >> Piotr
> >> 
> >> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c 
> >> b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >> index e0f773c..af51e5a 100644
> >> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> >> @@ -113,7 +113,8 @@ static int ixgbe_aci_send_cmd_execute(struct 
> >> ixgbe_hw *hw,
> >> 
> >>         /* Descriptor is written to specific registers */
> >>         for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
> >> -               IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
> >> +               IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i),
> >> +                               le32_to_cpu(raw_desc[i]));
> >> 
> >>         /* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
> >>          * PF_HICR_EV
> >> @@ -145,7 +146,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
> >>         if ((hicr & IXGBE_PF_HICR_SV)) {
> >>                 for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> >>                         raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> >> -                       raw_desc[i] = raw_desc[i];
> >> +                       raw_desc[i] = cpu_to_le32(raw_desc[i]);
> >>                 }
> >>         }
> >> 
> >> @@ -153,7 +154,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
> >>         if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
> >>                 for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> >>                         raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> >> -                       raw_desc[i] = raw_desc[i];
> >> +                       raw_desc[i] = cpu_to_le32(raw_desc[i]);
> >>                 }
> >>         }
> >>
> >
> >Hello Piotr,
> >
> >Thank you for suggesting the fix. I will prepare the new patch and send it over.
> >
> >-Dheeraj
> 
> Hello,
> As a result of internal review from Przemek, it may be improved as follows:
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index e0f773c..0ec944c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -113,7 +113,8 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
> 
>         /* Descriptor is written to specific registers */
>         for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
> -               IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
> +               IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i),
> +                               cpu_to_le32(raw_desc[i]));
> 
>         /* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
>          * PF_HICR_EV
> @@ -145,7 +146,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>         if ((hicr & IXGBE_PF_HICR_SV)) {
>                 for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>                         raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -                       raw_desc[i] = raw_desc[i];
> +                       raw_desc[i] = le32_to_cpu(raw_desc[i]);
>                 }
>         }
> 
> @@ -153,7 +154,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>         if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
>                 for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
>                         raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -                       raw_desc[i] = raw_desc[i];
> +                       raw_desc[i] = le32_to_cpu(raw_desc[i]);
>                 }
>         }
> 
> Thank you,
> Piotr

Hello Piotr,

Thank you. I will update the patch accordingly and send it over.

-Dheeraj

