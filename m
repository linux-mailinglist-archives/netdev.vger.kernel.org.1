Return-Path: <netdev+bounces-243201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE0C9B68C
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 13:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD93E3A27CA
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747F1C84D0;
	Tue,  2 Dec 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WB8BEZoo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4SyM+d7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E291373
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676894; cv=none; b=KPNF2rZVFgVRMSDsX70LGOUZmGJxv/OlnYhZt/x8rmo0TOx0IX3aoAe/r2/9jx26WRILUadgzUnZemGFPR6XgVyi0iP07vQVxZ1XaiOG5N8aiXnl0YvpF3g0m+k7NATDKO69k0KpfkqD7+NmkFQRHAoWs/+tL1H+8O96tnaXM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676894; c=relaxed/simple;
	bh=RqJ//CWvi0CXQU2s7uvLpFvS5h/u27nmChPXA5DxgsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qz0RVWai9VKG9rZQh/5b6l12738qz6H4tIP7s7QinT9MvUSCSVVE7DSEvG2uaUHBlIThuu8krc+0adkjjPVkcSoKjuq9frki8l53WuSP7zJYSXpkELLGH18a1O3ct+WkCPRQ8oZoXaEQQkys+F6mW4tK1cGzzletuy/n1Kgm6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WB8BEZoo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4SyM+d7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764676891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbnvjWtO9qk90ULnVMI5PCokfD84zE6L8J9jrLFhb5o=;
	b=WB8BEZood5VYGeuY6TWLUXAX3f76pRsqz6GBCnsg8W5d3KEfmNlLUA8F+070ASb939cXUw
	qpYtnAX9NuTFRHTWsrOfYMJCp5A8VsKJz9a1W8SxyN9pyd3005DJV6RL+mX3hGcBjuBNfT
	yptb7rWSI/k+C0vZcxWqNwS91hW2jeU=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-RAt-IQvHMYipR9iCaPiSIg-1; Tue, 02 Dec 2025 07:01:30 -0500
X-MC-Unique: RAt-IQvHMYipR9iCaPiSIg-1
X-Mimecast-MFC-AGG-ID: RAt-IQvHMYipR9iCaPiSIg_1764676889
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-640b8f1f66cso6732456d50.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 04:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764676889; x=1765281689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbnvjWtO9qk90ULnVMI5PCokfD84zE6L8J9jrLFhb5o=;
        b=H4SyM+d7UqmKkaOrCb03gr3chDagQ+p3ZT1vmlV/JGhN4Psdw0/v4kgRi8f7Z3Qo5g
         d7ZQRc7/UrK2RWRrHfNuURnQLeF0de2cVTpGAhmK+4ppztXofMEA3glLaHDfCJnLEbpc
         wddWlTgTcL2/uhD1AZ5gK4gPi7kyVvc2YO4D+MTZWrvmwQVdgMEIRX/mjpyfjB2XJ8Je
         3dPP0yWuWtjnZ5BYRTFPD8zYh57ksNYhU/WjvH+5hMDhX00POVSifFM2ljogcQihPeb8
         86NMv/R5rLB9GhlUVoxv98pLkSF0Y4WEwHR9oV4J9SHDo099JbLMd+8PJFx7iAwR4/Rv
         C8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676889; x=1765281689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbnvjWtO9qk90ULnVMI5PCokfD84zE6L8J9jrLFhb5o=;
        b=onGMZ6yaFXQF6kfvDm3i7VMfluzfFJ3eqwTPwsRsFe0PJLBJPTiSwwdx1saECpUadL
         m5Q3ltJuyaA7Aa9skuo7h2lc6nsrI/hCotz2AKx+8LgOoNtd4n4ND96OhPZOVkgXbFt/
         0K96310BNOomYXdipPlnHumNqt4sAGsnNwo78GcTbIfw4ra8uN96jXBepAHzvDLwGXsE
         M9AZ+imLoO5lu7UzpI/Z+jy+PyZRw1Iv2ADEjtvUROvPTwAFxH4dHzLHbOwBJh0iZ4Jn
         VqU6pmVLnUoiEIeVQSY4elZGXSrI9Sr46TG2z1Qi0/tQYPajBsuEr9B0ZPfWe6e5NZaG
         JpOw==
X-Forwarded-Encrypted: i=1; AJvYcCXYh5J4vXUBlpVvq9AhXHUC8dSpoq+dCrTpM8aHxYajsJK3P57mE7KeUNOX6/WJqMRbAZ4E5eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7NdpEuHEKpo79ONe7g/9r5ktAFGOyiyvd+l6jlqGhDGhk222
	tx9G7fXPuRNAsheWosunspGA1CjlPaKYG0pZHUeWnVyV9fkFfaHrqkJ26qNGF0Sxf+ERdQUXfPA
	Vf/ehzn8C4y5LwGk94v3oNX1kDCULEkBQLzlVsT6AtoaPv3QNMYdm28SyZB9hI4ttcA==
X-Gm-Gg: ASbGncsZcgQZ8J7MgVPhjBEQMmvnhZaWV7Gk28QsdvHuODxCcUrMOHx9dPkcPmwSipb
	strbVXHt3fqAlqqLeufLXWoeaLVuVoW39hmi37QaY5vnod6tQbgDNwAr33Iqotn+2WqyZ4sVj2b
	P5+pFoiUhZqdto5jtUNV2N9aFfKMl5CVYOK140zgKYjO1/h4lQtVr8GGCxW1PCfzQ6+9y5HTcGQ
	4yoSRN5k6qTpWMp8UvErvJHFT+dm6uOrWC7fEtDAcQ4eyc1KYT6Nhnkdxu8/gfGoYmZu4L1jQrE
	xzkXGNJhvYh5fqdOvh27EywLrW494mZP4bKbM/y44FIm96+L4Bpq/IHoCZnCrqFan3x5U24Z2DM
	G6UmO8Mwj/E7zYw==
X-Received: by 2002:a05:690e:1688:b0:63f:b634:5b3c with SMTP id 956f58d0204a3-6430296c57bmr32364674d50.0.1764676889191;
        Tue, 02 Dec 2025 04:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0niqrwvSFWdVWcCNBWDR+rNeIIFXCq8mz25S9gzNKYKdM5V8Z6Q3lyCGxg/no1sMqYMkLAQ==
X-Received: by 2002:a05:690e:1688:b0:63f:b634:5b3c with SMTP id 956f58d0204a3-6430296c57bmr32364640d50.0.1764676888476;
        Tue, 02 Dec 2025 04:01:28 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c443d2dsm6157511d50.16.2025.12.02.04.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 04:01:28 -0800 (PST)
Message-ID: <8fd45611-1551-4858-89b5-a3b26505bb00@redhat.com>
Date: Tue, 2 Dec 2025 13:01:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] selftests/net: remove unnecessary MTU config
 in big_tcp.sh
To: Mariusz Klimek <maklimek97@gmail.com>, netdev@vger.kernel.org
References: <20251127091325.7248-1-maklimek97@gmail.com>
 <20251127091325.7248-4-maklimek97@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251127091325.7248-4-maklimek97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 10:13 AM, Mariusz Klimek wrote:
> This patch removes the manual lowering of the client MTU in big_tcp.sh. The
> MTU lowering was previously required as a work-around due to a bug in the
> MTU validation of BIG TCP jumbograms. The MTU was lowered to 1442, but note
> that 1492 (1500 - 8) would of worked just as well. Now that the bug has
> been fixed, the manual client MTU modification can be removed entirely.
> 
> Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>

While touching this self-tests, I think it would be nice to additionally
add the 'negative' case, i.e. egress mtu lower than ingress and bit tcp
segmentation taking place.

/P


