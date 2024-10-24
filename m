Return-Path: <netdev+bounces-138501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33C9ADF12
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB71B2251E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A41ADFE6;
	Thu, 24 Oct 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJbhz3tv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AEB757FC
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758370; cv=none; b=FhAX82ib6pTvvHdCliGOlR3SO/W14On3bDyClxNRtm9Aj/2T4iH6/vp8KkNJZH3huY82Rhtkfar35ibLujDKFWQ8RBXBX9MmRmwqkJE6bu9G9Im0n4jHyfEDwSeJlyAGo8HhpiGpcwmAIPqeAfkmHcdLwu4D7ujvuiSexpXnEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758370; c=relaxed/simple;
	bh=91V0h/7zDnGI9sCOjMHFf6NA0Jnh9LCDW0ToMZO1JSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImzqoJuLSmFcF1CNXdMULZpiq+Q0S7WjLcaMoX4hVRF6Ckh9AC3u1UfYTNJTJwx09EbMvjROx/5pZZNBfnXCwnJTSwQNHM+fpzzA3CVV0nIP8qrYDr+U7TvprQ0C2o+h/zMwh/vLoMWLNxSpP3M347OY7ddfIqURXr45SjvwHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJbhz3tv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729758366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwIK22jJTXiNl/4qz1QFJTbAu0ESQS65/f/CMFNbJQE=;
	b=XJbhz3tvd+c7YtoL9qvpBkJsrEs7IjIemQII/fAwUJFQcNG6DqjD69Z8iiSNO2Jzz3AyI+
	EH1XHIMMrbJVv1L/8yTLJP1x950Uwdg9F2hjn7K2AKtBn70fQJFoLHM0gpcmpNA1uyAtvB
	vDe61TZ+A5NnGvrv8iIfbQZiTH2dpQw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-DrVP7ZAWPEm7amMDNDlMHg-1; Thu, 24 Oct 2024 04:26:05 -0400
X-MC-Unique: DrVP7ZAWPEm7amMDNDlMHg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d603515cfso338631f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 01:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758364; x=1730363164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwIK22jJTXiNl/4qz1QFJTbAu0ESQS65/f/CMFNbJQE=;
        b=QpGfgTVLjT4jHWxW4k76J0mT5A5LqqXsLe2nmRlzo3r5VnRIXINS4jBhWUbR42e9Wg
         xWsNcyEyChJahloxUK7v7W1zFHBJdQo47YBjwKAvL4keJqXRmbJvVT/OPuD2dg5akWFQ
         cESEnC3Nu9EnsTuOx/f1tkLsFl6JT0l+nwygbRaKi1unz1pAsNZxFT2NIQw8E7JAc5u9
         torGGsJgayI6R5ubjkcK7wR9rhDnLJkXG7lX5LCuVbEQNOfGQ/kfvThYZxP0cZPjtAOu
         AsidFgkZC/dUOyAYidSXuwK6Q/OZJgMIAoPRhvZZO/uaVdHWwBnWmw7ugFNluWyTt0Y0
         XtrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwN+R65M1DWPEqPlWKWFu0b7tV9Jlzxl12Zol7Y/BkEsGEetnbtkz8+Su1hU18FJRe3y2ZlPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ICLGDPjQQeqCfMiGgrtnKIuDLu9h+K8AO6GuiJCkeoDimO3k
	oNTCc7CLpLiX73LTn+FAQGwzZ7VyZF8WvAEra2dHRkq4HAHcgMWsgSo4K4vWxeHa3vbEqrETCpA
	D5u1lKyDZtL7NJ7TN8SsLGWBhAcTdJK3nxHNg7BZm8tyPVPAzHDJMfIWlUnpETZCm
X-Received: by 2002:adf:f0cb:0:b0:37d:46fa:d1d3 with SMTP id ffacd0b85a97d-37efcf33bb0mr3582922f8f.34.1729758364347;
        Thu, 24 Oct 2024 01:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUHc3F4aF9Xtr+r5ckouML3Lz2RpgiwwzhufdwsDQDe1WdqdqUHPm6HAtVWSTtcDcEHoiDqQ==
X-Received: by 2002:adf:f0cb:0:b0:37d:46fa:d1d3 with SMTP id ffacd0b85a97d-37efcf33bb0mr3582905f8f.34.1729758363954;
        Thu, 24 Oct 2024 01:26:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10764981f8f.89.2024.10.24.01.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 01:26:03 -0700 (PDT)
Message-ID: <50874428-b4ef-4e65-b60b-1bd917f1933c@redhat.com>
Date: Thu, 24 Oct 2024 10:26:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 1/9] net: hns3: default enable tx bounce buffer
 when smmu enabled
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shenjian15@huawei.com,
 salil.mehta@huawei.com
Cc: liuyonglong@huawei.com, wangpeiyang1@huawei.com, lanhao@huawei.com,
 chenhao418@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-2-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241018101059.1718375-2-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 12:10, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> The SMMU engine on HIP09 chip has a hardware issue.
> SMMU pagetable prefetch features may prefetch and use a invalid PTE
> even the PTE is valid at that time. This will cause the device trigger
> fake pagefaults. The solution is to avoid prefetching by adding a
> SYNC command when smmu mapping a iova. But the performance of nic has a
> sharp drop. Then we do this workaround, always enable tx bounce buffer,
> avoid mapping/unmapping on TX path.
> 
> This issue only affects HNS3, so we always enable
> tx bounce buffer when smmu enabled to improve performance.
> 
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

I'm sorry to nick pick on somewhat small details, but we really need a
fixes tag here to make 110% clear is a bugfix. I guess it could be the
commit introducing the support for the buggy H/W.

Thanks,

Paolo


