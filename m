Return-Path: <netdev+bounces-123494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818396514D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6DF6B24AC2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA94C18B46D;
	Thu, 29 Aug 2024 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hnes2F4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9318A922
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964856; cv=none; b=oDRh/gdhMwkub+24k/i5GcPoYuSvNCyqxYUqwuD5XfMMQw1pktAysnJPmNuEG5hHYxrTy9UfHae72+IYKd+VhMly3NC8AFBe3IaCRCIniqNiX9LQfvlGfmLcGLxfdHjJfUgYNNvcrCJzhOuqvGvHxh9S5IQMsRUJLz94n+o3Seo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964856; c=relaxed/simple;
	bh=W3QXNggGIlUka0CLektfw64CDNJtBPtY/C+13Acr7YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KWn7Nx1RMGFxsHtGQ5jPvkvX/l7Z052Or9dCzUef7OIW7rZqA7EiItVOKtO6uJocd2oBTlZhc3+LcqW8YjXR6wmHGMgGOxEi9yOs0jpSvrsFbuZQ8depb0LIOwa4YhZowQABE1UXNgVxnVAj3v+oFP5adbCdOpfujwYE4dfHp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hnes2F4w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20231aa8908so8751345ad.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724964854; x=1725569654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpAKIRUeMQ69akkagQpjTbK7bpiP+z/aYeOQSNNIjDU=;
        b=hnes2F4wx1FMWifJ7TWDt6fIELdXrrk8n0FP/Mz5N4rzjf3hEn29ilUndEQhbMqpcI
         i7B8LaavHKR7xZDAchiCUteDDZSBsqTm/vIfGyrOHRcvJMQLELa/gcTfsdtZ5YKoJbCZ
         5P0ilDBEkzYHOHJVQyixigj+7FmPUgPy58r9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724964854; x=1725569654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpAKIRUeMQ69akkagQpjTbK7bpiP+z/aYeOQSNNIjDU=;
        b=A/D6IERqbNEtRcBypM40v6gRLHfyjsnuCUoKscoykHnms9Z7OBzYQVO23EucSSDuWV
         nRgXNxM5qp959qYc0Xd6RUMOvBq9XkvdgYnHl63WfPLLPgr/41hnuQ6IyZCX7NYCxafW
         5ucrWtut/OBXEk3j/REijY8bVGQSk770I7eInmqVWqdHdyZ4pe9mJ8hqxIkzFGqUDx6Q
         miTLjMi95edb4EbN/yzF3JVlqysuVqU3MAXXWeFFMkZn33+BrqlnaD0/Wq3RkiKzBDiP
         r+5WYBvZGOwfPrOijxN9I6zBiTh3of8aFWYQv2xNwuEJdE+US9VcTv9sSQ5YQBAJRtAS
         tQqA==
X-Forwarded-Encrypted: i=1; AJvYcCW8UiN5P5ZamVpy8anspThYeUhvMVuwwdSqnBXJcZwVT7IQOp1t0Anqsip66ZbbnT+o7omksUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhOVXfb55av27zdcgzzbVxa4+jgQ3of1dXnpTQTTS6m2mcDi8S
	fYe983qaYlyecE476zUSdHzeE47oT8Em1OaRy5LEgf/uqgcfYFajBnj0TTzqTg==
X-Google-Smtp-Source: AGHT+IHWeXnhZnpNG3JqVZfHM2kILTImJt5gTQEIEKE4/lLhcadSeURX0TSadr8q6vHOf9OlWw3tSw==
X-Received: by 2002:a17:902:d505:b0:204:e310:8c7b with SMTP id d9443c01a7336-2050c3ef5dbmr41235765ad.34.1724964854292;
        Thu, 29 Aug 2024 13:54:14 -0700 (PDT)
Received: from [10.69.74.12] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051553720esm15596495ad.178.2024.08.29.13.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 13:54:13 -0700 (PDT)
Message-ID: <ef15f1a1-266c-4aba-a7ba-b7bf56fd20c7@broadcom.com>
Date: Thu, 29 Aug 2024 13:54:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/13] net: bcmasp: Simplify with scoped for
 each OF child loop
To: Jinjie Ruan <ruanjinjie@huawei.com>, woojung.huh@microchip.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 sebastian.hesselbarth@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, mcoquelin.stm32@gmail.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, ansuelsmth@gmail.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 krzk@kernel.org, jic23@kernel.org
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
 <20240829063118.67453-13-ruanjinjie@huawei.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20240829063118.67453-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/28/24 11:31 PM, 'Jinjie Ruan' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> Use scoped for_each_available_child_of_node_scoped() when
> iterating over device nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>

