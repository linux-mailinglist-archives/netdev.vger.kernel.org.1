Return-Path: <netdev+bounces-169290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C7A4337B
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08F2174B60
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB424A04B;
	Tue, 25 Feb 2025 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MppD3nCy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C324418E
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453458; cv=none; b=A9GJR4C6wxIughEXD8z4xJ+E1EaSmELEWwSFqgZ1R6dyP9GnlOy8Tb7Rye+lH3si5AVEgW93WHBjEiVA0EV8WNO1FNqztDihAsSs/Pm8Eps3/qVfiwMbGLuqYhGhoU95oAJeQIbax3zVox8D0+Q/ZGMqpq4liOhPG4bRwAYhV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453458; c=relaxed/simple;
	bh=P4xMosJeZHRsgLEK+WpB7Nt+0vpaNhYzi/3+8wiBTko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0irmF24f2VB5LUztp/Ubuh0zINIZmoFXJvsjLqLOJgn4MQQLsAd5zg5caPOPr9ogJ3YqNQKX08K4TMKb+yhK2YBn0uZOTfk9bUZFur2ZYz4IsyrzVaC9NufpDTdTy9v/J5/DO89VK1gyxSavNDAUS2dpQR6cB/YsmvL/R+2e7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MppD3nCy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471fe5e0a80so43721051cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740453456; x=1741058256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eb3P4NZJu02aAKSAk2NE05Ofs+1SxirmBohjwHsIlTk=;
        b=MppD3nCy9SJdRRNi0eGFYDFC/nPzOYbMt8+/t2UpBUAdmkk4/ZjFka4kTK24z8tmVS
         p/cf0nVJYxB9RM1+NdsiArDP6ekyUy91+zaJw+I0JQ5rYehuapPmXgpiqqnlXF5RudPA
         GtZJFU23k/XzL8CQVStBz/aD9y+gLIY9+tLdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453456; x=1741058256;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb3P4NZJu02aAKSAk2NE05Ofs+1SxirmBohjwHsIlTk=;
        b=oK0N/HWxz4x5BZ1DlnBixA3Lcl97JtjJ9kcp/Uk6exXiX/uwVxaLUm5X0d+bFHYhk+
         e137AZz1uSqmEjnEqwLC0/MWugVWJX+4a9uTTXanIQsD2G8Ztu1lPwqnXXPvmDF5qVEY
         Bu1VCXnykom9rkk51Tpi9KReFTP1QkU2jFahG1d1QumEfe+nzhHp7ORqeoZFSvHVXLaY
         dcNua0Y65Kei8zRzPb347xIY7NLMB2b483taqKlOzWQjrlfYbX8N6gJduUL38PLozCU0
         pzFGmjVDrZsbHOEDC2GTCiEEJEP3tR3hlCMCd2FQyisMW5YYZ6zfKgPTvv2GnZyA8krI
         ObEA==
X-Forwarded-Encrypted: i=1; AJvYcCXRwT8xzRozYZ+sZk2L1jUN0/Lype898NH4xOY6ytEjMxKeTqAg2QZfhXG0dfFhRg+wk6YCltY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSm5drRiHW+HuvuWnWh/4k4inEB5bV4Zh2SU2Mj0RZb/24U8UZ
	x1A0U1MZbWHKQqRV9k50oKu9IsJgMwlGJ0BKmCwbfxGzjXKBVRh+MQS1uolpNdc6SN5J5laN0r/
	O
X-Gm-Gg: ASbGncsrAA+SkDes0lVFtCjM74Ktx5MA+9VKCbvOtL8YTwi96VViVMXkhmoIRcNZQC0
	zS0g2rPvB3JAyyvgQX/K1o3yaF+PWUP/gzjea1bPqXDxIfofGq+DaBn4S2AO8azQCj+1NBZPEvK
	eJJFJXQlK1pmC47LyLJ+F+J07nvw6W+hpb/sx5/yaUSUBqFJb4D+m0qj9f/Yrd48kx2Vf08p3hk
	lxYinzHfoRM9OJL1VBxy9QC/1Vrs6krLo81oLQDAtdPw4OYnVGVzMwYxUgHeeeefTm5sdnt5C5F
	kWMizRADyMfSS4/bP27n+/N5jDs3j/T2qfRxZU/rgB+DfVTPegU7bg1MYGOZBX4/
X-Google-Smtp-Source: AGHT+IGF/zmWkZGN4tGUWHZ0IVvEWSUR3xbsxzWrLlmfPxO8NikBjLRvWJ/b5+ih3jHT1nFbIx/HVw==
X-Received: by 2002:ac8:7d45:0:b0:472:1225:bd99 with SMTP id d75a77b69052e-47224716778mr203069491cf.2.1740453455852;
        Mon, 24 Feb 2025 19:17:35 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4737806a530sm4747131cf.59.2025.02.24.19.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:17:34 -0800 (PST)
Date: Mon, 24 Feb 2025 22:17:32 -0500
From: Joe Damato <jdamato@fastly.com>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next 1/1] enic: add dependency on Page Pool
Message-ID: <Z702TLsTKDIvTQN_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	John Daley <johndale@cisco.com>, benve@cisco.com,
	satishkh@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Nelson Escobar <neescoba@cisco.com>
References: <20250224234350.23157-1-johndale@cisco.com>
 <20250224234350.23157-2-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224234350.23157-2-johndale@cisco.com>

On Mon, Feb 24, 2025 at 03:43:50PM -0800, John Daley wrote:
> Driver was not configured to select page_pool, causing a compile error
> if page pool module was not already selected.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502211253.3XRosM9I-lkp@intel.com/
> Fixes: d24cb52b2d8a ("enic: Use the Page Pool API for RX")
> Reviewed-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Hrm. This is a fixes, so normally the subject line should probably
be "PATCH net" instead of "PATCH net-next" and stable would be CC'd
- however - it looks like the commit it fixes is only in net-next.

So, CC-ing stable is probably unnecessary ?

At any rate, I'd probably skip the cover letter for a simple patch
like this in the future.

Reviewed-by: Joe Damato <jdamato@fastly.com>

