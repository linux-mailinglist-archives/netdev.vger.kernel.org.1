Return-Path: <netdev+bounces-158033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FB8A1025B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4A97A1E45
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C1284A5D;
	Tue, 14 Jan 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaqgT+oY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35422500BD
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736844602; cv=none; b=VnTD/aRBUQY7lFXLioeuQ/kJhjp4skKIC0+vjQSOY8FT7Vb80YwgL52jApI1/u+CC0GuCcEDvCl2h/Rll0iLzvyFIpqjcuUSKiwq1E/wwDFleJ8IF/8NJzBS1JGIQwSXn2aDkgYFdJtAuqY+UnT51uIBSHCkTSYFuL9mRDGzri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736844602; c=relaxed/simple;
	bh=yjI73KXE1o0v24JdQTFtJedB3AghlGDfi+/rsDjpB3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGaTO3v139Ry8yfjoHiO0yGMZHNzK7jlEvNoTzsCsgl+/PKZAwaMwRH2z8si526DZhh04aZUyc5eM4cCgESkCIFbr0t83I/RRu8Qo2OZYlhAxRpoCMM3qTZY1tKP2J34qJUQYJ/if9tI5fs8g4PsHlnVFlF+EfbJqcRSHYBaR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaqgT+oY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736844600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPh+lL8fM1azGe99o+jyyb0ZHEVF7xd0MdY/zPEIluA=;
	b=LaqgT+oYd+QgksEA0MozlPU+Z+s4Q5jFCQOYk4PvSV3GQm6aDOcKBqJID+NkWul/D55LY8
	Dck1yZHUYNpx/SCl8g+Km+UsO/9+KLwtmcSmztcLKLmWXPmuUFpRtPOcDRO76pHEZ18cFB
	hRAo+Yz3UOmFrtobkSDi+Dp6DJJkFOA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-eyWZKGWAOCKvXkSITnzl7g-1; Tue, 14 Jan 2025 03:49:58 -0500
X-MC-Unique: eyWZKGWAOCKvXkSITnzl7g-1
X-Mimecast-MFC-AGG-ID: eyWZKGWAOCKvXkSITnzl7g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso41722785e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 00:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736844597; x=1737449397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPh+lL8fM1azGe99o+jyyb0ZHEVF7xd0MdY/zPEIluA=;
        b=W8EM65EQCa0LU1ehAL6qerZCIcB5gLPnV1z6hKQNhHB4FivZoDo+k9m+HTkgV2ijro
         JwGH8EKWJdBElvamUT1WnPQqJdfJnf9RI7wxhtfXDqj5I04TLNd5deYZzrpa69fzr7t/
         0/QwMa1sZcaTnzWtSZnxoNH9rbFPtNkH+aKauccznR6KXpA0Ac8rVvBN+nyuQ3VgRCiB
         h5c+VbYIUN/ZWV28KvgJLFH8W4qIeCf1AsMwXSjP+gT6K9xW3gk6sxXql+aVN8eBlshU
         UNvDMovB0AJ6/ey2KycA8VR3Hb+X/Pl+dy06E+aqCFXEPgmUOmaxkXau24MA1rcAwzJm
         WoFw==
X-Forwarded-Encrypted: i=1; AJvYcCUZQ8ZtKsX70Kfk12O5jJohSylEiLcbf/wr9OIRM5FKF11rb4iEJbMLuACknXSITH8subTwU8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8r9NUn7kZ+EExu81VZvpFRQSeL0+KreDO7Jv3NZpYhP4XptM
	B9BVlE35pxq/TX7YQM05qkkOux7rnGHnXJ9WA4wC4t/7Xiawc6tFIdh5qD93+qhm672lIbk41pA
	luoXUweKjrqFXRoIRCT2YhnDs9duDm9q/Ic0zdt+i/83dhz6AY9XJZQ==
X-Gm-Gg: ASbGncspuYXhcrkTvWr0dGnV2X+9WLc/7dfZN3RRqKM/v490ZJkGWH7lbZ6b1lQGxkQ
	yjQgC9x2aYojwfimvN0Ojf6eq0yP8MGsD6a3ZvgKGjm7KK9+oWQSFEaBtuAHaT6Gz1Ee8lkWoYv
	6d9M92JgTjPMKQE5wbggg9gPcSkwzidc0Mm1KhhfxGFJy3UfQlSplaIUXQJ+fJ4E1EsEdsfM3vW
	FV3rUkTUX7S3Aiv00jDyfn14l+jk8vMlr0fYMpOqxnEYGnq8EzkovAzxTWW21kfrQzKEo8VW3Lp
	rRpVnCZdR20=
X-Received: by 2002:a05:600c:3149:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-436e267fbe1mr223306435e9.7.1736844597262;
        Tue, 14 Jan 2025 00:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOIBNjAnXgPwJtVjORPvgQ1GVBYC46pvFjgixl6aysLuqBaKkmhOPJs5mJt9C7n+7EkBny7A==
X-Received: by 2002:a05:600c:3149:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-436e267fbe1mr223306125e9.7.1736844596920;
        Tue, 14 Jan 2025 00:49:56 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62116sm166347825e9.35.2025.01.14.00.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 00:49:56 -0800 (PST)
Message-ID: <44a21765-1283-4e79-b24a-fb672399250d@redhat.com>
Date: Tue, 14 Jan 2025 09:49:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 M Chetan Kumar <m.chetan.kumar@intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e60287ebdb0ab54c4075071b72568a40a75d0205.1736372610.git.mail@maciej.szmigiero.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e60287ebdb0ab54c4075071b72568a40a75d0205.1736372610.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 12:33 AM, Maciej S. Szmigiero wrote:
 @@ -530,3 +531,56 @@ void ipc_pcie_kfree_skb(struct iosm_pcie
*ipc_pcie, struct sk_buff *skb)
>  	IPC_CB(skb)->mapping = 0;
>  	dev_kfree_skb(skb);
>  }
> +
> +static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
> +{
> +	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
> +		if (pci_registered) {

Out of sheer ignorance on my side, why 'mode == PM_RESTORE_PREPARE' is
required above? Isn't the driver already unregistered by the previous
PM_HIBERNATION_PREPARE call?

Thanks,

Paolo


