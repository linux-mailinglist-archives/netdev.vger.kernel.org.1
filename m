Return-Path: <netdev+bounces-165267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8BBA31579
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C256B7A1411
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9976926E624;
	Tue, 11 Feb 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="afRLOIXH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211526E626
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302443; cv=none; b=G1wjHBwwQ6iIIGR1Heg3zojfMTaFdJlcxfqCI7jgEj4RZ/sOIL+LM06+I5dfOg6Jq4mamVJhfgWK00qKG0KSjzdpkLKvsQGbNDjE5yjrXjnwMRGJcQeMjSVuSnkACYaqkMZWX/WBt+z12ZlbPSmlzmQcWhBSkwIjp4L/i4gdTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302443; c=relaxed/simple;
	bh=uoyqtNIM04n5gAatkZzlTXTmmLUlbkrkXia+O0lRb0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0FUF3tS5nJ5kEDUqFRI+IwfdhscBKR5TmMYPXSVkxa5FhVVo1n0NArx/Cnic5+lwYFp8k8kwrIsHs0pGwWgxxOUoUOORJzG+PmYEnn31x5UhEp2+lNsZhCGpXxXoW33EFWK3ei6WO+wTQ3LddPej1GtC844puaGfMCc6zTZ8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=afRLOIXH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f4500a5c3so119526275ad.3
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739302441; x=1739907241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Msv1WId3SM86J5ukNlvxPp1WZW6DD4cvAARwpXj2Qqo=;
        b=afRLOIXH9jny9X4zrBVMu/YCw0/TN0uDJnENv7hw17KwqmkiNcpkYW3suvfUqsrsmp
         VFiYVYD1lTXL+yVhx/+pAsDdRbX3T/kz2+e60lBRpDr8XcWIrsDjt2GopwQyn1bWm2KV
         ZJu1FBuIiWQhGXcjDoV1BqrfBTavAPOzd0peA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302441; x=1739907241;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Msv1WId3SM86J5ukNlvxPp1WZW6DD4cvAARwpXj2Qqo=;
        b=krDABoJTSySyVZQ8ey0zXySBjKayUSiY6L5D6dk/bHoUwY0+nuEgK9cOKOvfHUz5R7
         5ssczAa85FgxBmgw9rgoYQlBtCjCY9yTqnrfKFwVIH6Qz4xE0r/v9UM3SyYfZ/GIUpaZ
         0oLevV+Hv5A6M0X7WFlVBhKv5vBYDoAz/zTk6olr7SbVUj4yKIHYvQ6UOu23mINC6kEN
         YBnG3ote7oW2cTma9y+51Lrxu3ger7lnAnuiNM3+GFJr/btb/59jdgN74OlzoZ4IqzUm
         5qrsOZJRX7qWotZjQDuEs6nyAT3Cakh275m27Wqwl1Ck545bCe6eEcTHwYVKNmd9ok/Q
         AD4w==
X-Forwarded-Encrypted: i=1; AJvYcCW1lZu2Xlh5lB5/gpAvraJGbUjnJcyQDPzMrL57jDkoFK2EjM2F/hsbMPSlhrvLEIllTEjo4KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzua+KnxZKqJJ36emDN/4m0WOwPLrX9uynovHAEgMKLU16+s4Y/
	aBapOvKNEsfuIEeMN0NU5taxRbda9SCuTz5ikp5/q9aOstfMGGyljVbNc13Crxw=
X-Gm-Gg: ASbGncvBC0dMyQZKezRCCDZ8dZyGEh1s1wtiNZwwJvD/sceCwZjsYKpLxB9TDRO8zjj
	Om1+C4YmVlM0PK7DeD0TJAtpH7lcZlNi9NcG6JlQVIQ2UprCzSGl7FY6m5LCV0WVsu2d+3qDwLr
	at4zOZeLKQEnwt6N/4NKGUZjfCRY5fnTgVbYn5cNA4BUcZDobvG3FudJYffbz/oGwTUVE43NOk6
	PoZjr72KqsSpruivWDHnHyYh3Bn50lEXXtWtu0v/3Ha9ZEW7GB+ej262H6mkOU7omAiXXOflq5j
	uhZsG+44qohT3st9updeskp5powu8F7iB1SfGKs348wQKnWYxXGUFlpdJg==
X-Google-Smtp-Source: AGHT+IHK86v88nkiZFwWngSMVd5xUipJOnRzU/xcKu0bUXQMArrlf1yOCcyYQKPXqF+sA+tGrlOPkQ==
X-Received: by 2002:a05:6a21:3992:b0:1e1:bdae:e054 with SMTP id adf61e73a8af0-1ee5c7909f8mr929676637.25.1739302441071;
        Tue, 11 Feb 2025 11:34:01 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732194ee701sm1884223b3a.25.2025.02.11.11.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:34:00 -0800 (PST)
Date: Tue, 11 Feb 2025 11:33:58 -0800
From: Joe Damato <jdamato@fastly.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3: Check return value of tg3_nvram_lock before
 resetting lock
Message-ID: <Z6umJrdf0IsgAUWi@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Wentao Liang <vulab@iscas.ac.cn>, pavan.chebbi@broadcom.com,
	mchan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250211152658.1094-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211152658.1094-1-vulab@iscas.ac.cn>

On Tue, Feb 11, 2025 at 11:26:58PM +0800, Wentao Liang wrote:
> The current code does not check the return value of tg3_nvram_lock before
> resetting the lock count (tp->nvram_lock_cnt = 0). This is dangerous
> because if tg3_nvram_lock fails, the lock state may be inconsistent,
> leading to potential race conditions or undefined behavior.
> 
> This patch adds a check for the return value of tg3_nvram_lock. If the
> function fails, the error is propagated to the caller, ensuring that
> the lock state remains consistent.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 9cc8db10a8d6..851d19b3f43c 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -9160,7 +9160,9 @@ static int tg3_chip_reset(struct tg3 *tp)
>  	if (!pci_device_is_present(tp->pdev))
>  		return -ENODEV;
>  
> -	tg3_nvram_lock(tp);
> +	err = tg3_nvram_lock(tp);
> +	if (err)
> +		return err;
>  
>  	tg3_ape_lock(tp, TG3_APE_LOCK_GRC);

A couple notes from me:

  1. Subject should say "PATCH net-next"
  2. Use --base=auto to generate a base-commit.
  3. code looks fine to me, tg3_nvram_lock is checked in all other
     invocations.
  4. that said, seems like tg3_ape_lock could have also gotten a
     check added at the same time?

I can see the argument that tg3_ape_lock cleanup should come
separately, since there are a few unchecked invocations of it other
than the one right next to the one you changed.

So, if you resend with 1 & 2 fixed, feel free to add:

Reviewed-by: Joe Damato <jdamato@fastly.com>

