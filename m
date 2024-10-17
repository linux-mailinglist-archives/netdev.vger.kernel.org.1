Return-Path: <netdev+bounces-136454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAF9A1C8E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92ABAB2734F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802F71D3194;
	Thu, 17 Oct 2024 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzV7CLmf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25B1D2F62
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152262; cv=none; b=kW2ynEFuuv7qZNXS4NqZrViwg36dzozcgw8BeNlHy6+hTqqR4oirikP4GMh7jOzNRzFny3SstS4wnr3fhhMOTEFtmBI3RVEkQxl18NIzEntihGwfjaZSLtyZbDTBOtMbHHPD5ok73gW4QyItFo/0zuuRXdWEzZtb8DhvQe5RDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152262; c=relaxed/simple;
	bh=gtaBUmgxl2HdEconv9lj1dXNVhYyJlwHFuoeJGtu7m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eufk0aNG7Z9jMAF/i6yaf6THc0aiDX/38HJcsbFkePTk174koOlLWXs65WSeaqWGCm3quYgngfRRxi5AlbIBfb3canzdBDfG1CnxTFg4QxnwXBr8Isu0LxGhJ/V7inmnJZDWrSzw7FwZUWq4tbxnLHR7FTSm/ZMBNj6nd8Uo1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzV7CLmf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729152259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO8UCuKbSZt+/BzvbR8aK7OxMm4lkhtuT9Fr8MXR7Uk=;
	b=DzV7CLmfm6VmFqJssE4euGq2IDtta+nC30NBPj6xBRc04PqdjOoOlUBEq3TqcGm0mKAK2a
	EwwOm/m1nGpjZKU7D7dPPSJ2+VEKBUbNuwu07IBjnuqHiLfMi7u8jKLzKfYWxMqRnletsb
	+X5MbGeN5QsdjPz4qM+g64TD85kvB2s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-cVjK1GSpNRGwZE6t8sksYw-1; Thu, 17 Oct 2024 04:04:17 -0400
X-MC-Unique: cVjK1GSpNRGwZE6t8sksYw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539ea0fcd4bso467919e87.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 01:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152256; x=1729757056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO8UCuKbSZt+/BzvbR8aK7OxMm4lkhtuT9Fr8MXR7Uk=;
        b=U5xvQgiER74dhgrsMOQh18O4FzPFT+ijzBqD4CNbC9LAClMvZxtwfodAP6nOxg75GD
         HxNdC/ptSmh7hSRuOJCGKpWtSkROpLXBDKiceSGAp61Pzq4mkUNxJGngcIq+OXDVAPis
         Uh90uV78Ciu6WvHkZgbIHsKdg3z2bppzLwdhII+grw644V18J4CO6bCyPB14022uz8ZV
         g5P4n4lFH5JiU5zIpAyfhylw16Zc6psJVsaZ1FeZJ6epoSARKKueVhWiMvTs+lCONPv1
         sDU5KNWOC6AQDva0Y8xBp0kAGmrqnzGrr8KwcZyqbRKEYLOzKdAVOkQ4CEUT0PHLqOk7
         pXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8DRxGOklfJAagg80h7lt1r+/5D9cp2NZIj6e9gw2wY/ZoAGKVGlWlNJRwubGMg7JqMGs74Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2ByAcD5LrKq1LQoI1jcyVBIJc9uOeM+hvv+5zhwv9f+61+9p
	OS3ENMf2GDRdwRXq5DqGpdxiZ3JyfveOv9k5f/GoiErTG3ayS1VmjoYUW8tP4gR3Tw38nYzgEKc
	26VWukhnrWc6zQ4NUz+4gef20IaZ4TSskgKGrAk0TZ3vbRRY/nxmCzg==
X-Received: by 2002:a05:6512:33c8:b0:53a:bb7:ed77 with SMTP id 2adb3069b0e04-53a0bb7ee58mr1677323e87.14.1729152255772;
        Thu, 17 Oct 2024 01:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBPfQRYMHFp3GTkkzKGNINwnC6QE2O6rfOaHgOQa9hVwPABw61gd5NSheFE2souMGZG1P13w==
X-Received: by 2002:a05:6512:33c8:b0:53a:bb7:ed77 with SMTP id 2adb3069b0e04-53a0bb7ee58mr1677302e87.14.1729152255318;
        Thu, 17 Oct 2024 01:04:15 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c4dc29sm17967385e9.36.2024.10.17.01.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:04:14 -0700 (PDT)
Message-ID: <53cd75e3-79c3-42ed-9fb5-4d7258d9bffb@redhat.com>
Date: Thu, 17 Oct 2024 10:04:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 RESEND] net: sfp: change quirks for Alcatel Lucent
 G-010S-P
To: Shengyu Qu <wiagn233@outlook.com>, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 19:39, Shengyu Qu wrote:
> Seems Alcatel Lucent G-010S-P also have the same problem that it uses
> TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
It would be great if a 3rd party could actually test this.

Leaving the patch pending a little more for such goal.

Thanks,

Paolo


