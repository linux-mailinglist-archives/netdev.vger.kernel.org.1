Return-Path: <netdev+bounces-120923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0740A95B368
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B611F23DE0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47022148841;
	Thu, 22 Aug 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdOWYiGi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B118C31
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324558; cv=none; b=Aq7pZtngcjwkUAuREVzdGzjEbZgWg5kYXbSpJTNt5E5L/wpwRwtnr5l2JGsd9GX/aJ76DdOuKCRUpUzKgqbg9b9vHeiWJ2ZkiuAGpfhQLzkJLkZpqWCDI1KEX5aYodzdqB3lqdmzlxe4T6n880NnJbw10fopi2P1UQ48VOFXOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324558; c=relaxed/simple;
	bh=2nODh978mMzK3j0GjNsmpF8YNFjkBxrPTFe2CgovZbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXAFkh44mOrZHnb09IC8DIvKy0N0OVFXDCrXBrbj/+1R5LMcjdNcY/VzCagJgf6ZeIJ14WtIoFys1tX9boW4vABpvF19IQ6cGTAlSNDitwaWblCSXiM3vppRxR9fLcoQ3f3cts+nWxpJnsKt8mB6/WS/ne96U2t4bgB4wxGZj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdOWYiGi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724324555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkldUBIK7FYjS/3cQzFqhh6w3aGsW6ya31tCj3iSXs8=;
	b=GdOWYiGiXbCMuLR+ZXh7eocOJl9k2m9somZLhBQ/EK6+XUyuv/br1kYBHo0ho1tOYRHOpF
	VpwoMa8qJWrd5Vmg6DLmrK8I1daQDPfqdllVuQV+L8+tQrDcoqzrhuvkSr+9qIWLnadCTt
	zcdSQTZX77BJrWuJexiSWgEjYlYnCTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-NEFpVhScNeyVDmTkZRWTyw-1; Thu, 22 Aug 2024 07:02:34 -0400
X-MC-Unique: NEFpVhScNeyVDmTkZRWTyw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280291f739so5471205e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724324553; x=1724929353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkldUBIK7FYjS/3cQzFqhh6w3aGsW6ya31tCj3iSXs8=;
        b=RE0Y5QayNZzUF8nTom5MEaZ6gMl2r1Xx/bag159xTnwz/q0SELzOKEK+O1WJyWDZbA
         O7M7nPCFiGhLnLHcyQp1vGLfnsiizwR+hDDCEssNTjGPSJA4VCv0ov4Ii0cB3XrkWAR1
         9cCLA9+wXVOs0YPXepb104jaoUAAkZiVbpzIDkss4vW3xn5ax2jrEyLlMt1kFQC3SzZD
         /Bx/I74yMOceOtqafkBZtWB4FI1u1LztJfwSDsuqWGA3K3IQEps7VhWOlifSCg34O6E6
         XOMtHy9gWes2vYANIV8JFH/22SbovZE/14IE7Al40nT2Y6uTJBmsmctbXg/MrYZ7vJUy
         AKGw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZRNVL4KlI3bCADG62071Lr8DkUROK7Aw94L6fnLb9Gq1p1B4E+N3jFw9Z4E1B3CfVwLoSO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtR/jGklzBRqzdtR9I42h5wYUuvyDqCu8hrUw16Sas45Q7G2xX
	wwnFpOxPwTk/wSnm12zRVAEBddGgtTxF1rxpgHE5TfluRuIhfK90aISAfGQYZWQGg89+ZUm5eCP
	t4249FeQBTydfrVUAC/25YV/BZNQiORTDKHKRTXd+KiaYy9D3No+WDA==
X-Received: by 2002:a05:600c:524e:b0:427:9dad:e6ac with SMTP id 5b1f17b1804b1-42abf0a9948mr35751425e9.34.1724324552985;
        Thu, 22 Aug 2024 04:02:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBnjCtefwrwoXOwIfy4zozQekcOrOC3c7UFCnsmdTFsHXi5VMk8GxYOLmUniZcLdcFxziotQ==
X-Received: by 2002:a05:600c:524e:b0:427:9dad:e6ac with SMTP id 5b1f17b1804b1-42abf0a9948mr35751095e9.34.1724324552430;
        Thu, 22 Aug 2024 04:02:32 -0700 (PDT)
Received: from [192.168.1.25] ([145.224.103.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac624bb23sm15992425e9.32.2024.08.22.04.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 04:02:32 -0700 (PDT)
Message-ID: <313e8573-6c84-473a-90ee-ef98b553dd3d@redhat.com>
Date: Thu, 22 Aug 2024 13:02:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: realtek: Fix setting of PHY LEDs Mode B bit on
 RTL8211F
To: Sava Jakovljev <sjakovljev@outlook.com>
Cc: savaj@meyersound.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Marek Vasut <marex@denx.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <PAWP192MB21287372F30C4E55B6DF6158C38E2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAWP192MB21287372F30C4E55B6DF6158C38E2@PAWP192MB2128.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/24 04:16, Sava Jakovljev wrote:
> From: Sava Jakovljev <savaj@meyersound.com>
> 
> The current implementation incorrectly sets the mode bit of the PHY chip.
> Bit 15 (RTL8211F_LEDCR_MODE) should not be shifted together with the
> configuration nibble of a LED- it should be set independently of the
> index of the LED being configured.
> As a consequence, the RTL8211F LED control is actually operating in Mode A.
> Fix the error by or-ing final register value to write with a const-value of
> RTL8211F_LEDCR_MODE, thus setting Mode bit explicitly.
> 
> Fixes: 17784801d888 ("net: phy: realtek: Add support for PHY LEDs on RTL8211F")

Please, do not insert blank lines in the tag area i.e. between the fixes 
and sob tags.

I'll one-off fix this while applying the patch,

No need to resent

Cheers,

Paolo


