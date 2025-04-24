Return-Path: <netdev+bounces-185675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F083CA9B4E0
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFA61BA6DE6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E328A3F9;
	Thu, 24 Apr 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DM8GmkWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CE28BAB0
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514009; cv=none; b=V7p3PH85MkLQwSzZdlmlSPUWCtyQ0dtZmxbVAadTNNJmw5MqxmRWP6rtE+7AqmgA01zvKUxVMExm8WyMOSPGtuJ+YSAidPE43ZKVKrdF8NLDAC4qFLFVK9VsyCBdqf/QZ1XhfWlWQoAPKet0/bZSNptGvgahMQk/dz3GE2E8CkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514009; c=relaxed/simple;
	bh=Re2dLQxUt4a1JE5RnNgPNCuWjCcZgs95HiMEjBL7vA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCRx9oIq8TUetL/NYdiCSMcst2kcg7a9ETpn9LAG/KMHGGkZQacgJl1+oozQmO8nscGlZ4x5xBUSgEEuOItlKQaN/5pjFn/2HmWtRkVY4VynmHmrkRiDU4D26YVkS4OGjLi224QHYdh2XkupNYFd9NtFbvMvmgA+LlWn4Kii7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DM8GmkWm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22409077c06so20507895ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745514007; x=1746118807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ctx76qQS095rezkew6EL81niHz5SA/vv4yeyN5Ui+J4=;
        b=DM8GmkWmxHQNa8aKg3yGQB/fc+vWJV9LL3UCEV6fY9mVYoqihPmaqsaAXXi3KvJNPT
         82oCOHI4KPD0ktuataihMFX82kh5dCqVWhnDzh3lJrayvfecWmKkSvNRMjo5uSK/a27z
         uipuK+e+aHHvKeskn3AJaUztlKe6mynaT9yGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514007; x=1746118807;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ctx76qQS095rezkew6EL81niHz5SA/vv4yeyN5Ui+J4=;
        b=STVt7Pxpf+GFxz/QjP+XpFMhzkGv9kJbRr9enRfc8Y7e9/XWt/F8bPK1OTqykE+mp7
         ZX4ZHzYoCzaZku9jSukJqlJGTds3bE2alp7N2naOOQzNPDSVI2cueTH/o/NeIYnY0ZDw
         /0V11hcf9Q1A41T3381c7bYY/FK9yr+xUnCNaAEIGGYgjKgFR6QMaSMoxsnMVsXXPgTp
         LHehOH3nrtoGwYEmrEIOl3jGFFjLzxDA5LD+lGCrZV43UCli9+DYnQT2bX9tDLFD3YVO
         1jgKDTSrX25G4hvHkjK8/13N0xzzjmi6uoNXe2T7kvAiAq/fLCDFggRIuFR5lSOrmsEs
         +sog==
X-Forwarded-Encrypted: i=1; AJvYcCV2YiwZeALxsRxCXm160G7TCG3dncGtOeUg53cHGpxOSEiWAtguKGj8RQZs+9XeYSUg5Oc5aHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmuKeh4DEAFxcswaJlQZTPg4mTDSVifw9aLxLWccfyCcY0/PXn
	ecDBtzhpOFJ9/nEf8rcYt8uVXQBKXvMBKwFTCPdickxuV0zQtZO+a/LqG2S20qM=
X-Gm-Gg: ASbGncugEQgc9IgSlpUNXPqXJrM0d9HFVR9o/HfQePShzqtUH9Afb22Dct84lNuk86J
	g5rikzgWnTVL0ROa3e5qIuUMtsF1tTCSo5nbKV4ILExsFnURctct6oKV5Sau7JmuIQlkJPo6VXv
	dBuaPXj2Dg8avMT9C2o4tzVBQPhK9KKWWzWUEXxsEM4KQsS4l9RbF1l7tG4fvIrTRb7O8X/shPX
	PPQjt+gg1dgQpoV/SSQW44sp9Szc1jeCCyQXcMzVIEJ2YIIrxlJ17D95Uqoh9itmpaq6VCT4Gyl
	DILe4hFoNk6YpLqt9L/UYQYIzvRX8uMuSKY7u7qj82u3Hx9wR6n4yjlDgnVlb26jHinD5ue2EUi
	Yp13FFE1tTcnR
X-Google-Smtp-Source: AGHT+IH0aoqvG/SgAriNMgVXTaXkiSNjDTr7/adoRh1UdV50gvlVaim43ev4uIVJyg31dGRDqG+cbA==
X-Received: by 2002:a17:903:244c:b0:224:2717:7993 with SMTP id d9443c01a7336-22dbd471651mr2754775ad.45.1745514007176;
        Thu, 24 Apr 2025 10:00:07 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f83ad368sm1469288a12.33.2025.04.24.10.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:00:06 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:00:03 -0700
From: Joe Damato <jdamato@fastly.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next] rtase: Modify the format specifier in snprintf
 to %u.
Message-ID: <aApuE3xTASb0vm9H@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, horms@kernel.org, pkshih@realtek.com,
	larry.chiu@realtek.com
References: <20250424062746.9693-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424062746.9693-1-justinlai0215@realtek.com>

On Thu, Apr 24, 2025 at 02:27:46PM +0800, Justin Lai wrote:
> Modify the format specifier in snprintf to %u.
> 
> Fixes: ea244d7d8dce ("rtase: Implement the .ndo_open function")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 8c902eaeb5ec..5996b13572c9 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1114,7 +1114,7 @@ static int rtase_open(struct net_device *dev)
>  		/* request other interrupts to handle multiqueue */
>  		for (i = 1; i < tp->int_nums; i++) {
>  			ivec = &tp->int_vector[i];
> -			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> +			snprintf(ivec->name, sizeof(ivec->name), "%s_int%u",
>  				 tp->dev->name, i);
>  			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
>  					  ivec->name, ivec);

Same comment as the other patch: not sure if there is a bug out in
the wild for this (seems unlikely since i is u16), so I think this
is cleanup for net-next despite having a Fixes.

Reviewed-by: Joe Damato <jdamato@fastly.com>

