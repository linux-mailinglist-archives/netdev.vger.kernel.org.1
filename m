Return-Path: <netdev+bounces-209695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF3B10687
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261F51CE6751
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956D2D77E6;
	Thu, 24 Jul 2025 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XR9ODHUM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD3A2D641A
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349392; cv=none; b=aAHr4upmuhatODmpgWuOX1sNuv3swho3CxnYmvUqz8mFSxZ2P5Z6zm12qsMnIP0dJXbSKlJiW+qzCb/9vpxSFS0gJwTHyqU+q7uoDo5aiteG1DUxpNOahy2sfb+GrC0v4X5NkIZAF6QAYmJbeQhdoznjOU5CY0w6HFWh4wINWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349392; c=relaxed/simple;
	bh=COy83tWwM4souj8Dt40LunOOP/o/rdXvf4yrQ2AELEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6AQzhCL+yu0/8yfx0EH3T+RBPYVDCA0MsGYzdHeKnbW2H5nNtW4JK768tlKGB2HQWRvGxQQisYrPjZZ7L3W95Mbd+LIo2AsYHJB5nkfhwxvchpomsOkBlxdD5KvzS56fiZrm2AwHAfOmZXFpB2m3eS1MuTQZWc2tCiz5JTM0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XR9ODHUM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753349389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COy83tWwM4souj8Dt40LunOOP/o/rdXvf4yrQ2AELEA=;
	b=XR9ODHUMjvoISaFSyCsTQgwh9shaAsV/ueLIz6QbIZ4XEaqddl+GZqAfG0+OImDAwrB0Nh
	9/m5vz/Yvm83wLgdUGNM7G4jN+enyCiAQj4a105erysNwSk0oQLthIC9/6j7bXHqtWymYD
	LDmoaYas23QZSEoSXx/HlXu0tlxB+Tw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-7t5Ze9AhM5yFCQex4sIp7w-1; Thu, 24 Jul 2025 05:29:46 -0400
X-MC-Unique: 7t5Ze9AhM5yFCQex4sIp7w-1
X-Mimecast-MFC-AGG-ID: 7t5Ze9AhM5yFCQex4sIp7w_1753349385
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so4673705e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 02:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349385; x=1753954185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COy83tWwM4souj8Dt40LunOOP/o/rdXvf4yrQ2AELEA=;
        b=I+MyvAf0/rFe8Si4+OekqGpvVOQQyHERLeNYDuLtkmBHAAvtNewE7h78HtfRu7okgF
         AA7nVmB+H5MetScMc8izm+bNWhC2/L/Iy1k3yXuuywTQq52vrKHlHkx82KeEOG0hPo7S
         0rSLwsOVqsBpAH1jdwPjXXkUUy7wR4b/j/jFBlSf7RW6p1nVavFTRbXdJ/mgkeE7iurx
         XmDxaCzooO4kCEmG8s5ekSFI2HMNxENpBuPBYzSfBHM381c1YbGIQuT4Kwh0k9wRaFca
         oA+WLZE9PClz2B4DKPmtRz8HD7Nek4UIhrFlk+3eIcjcXrDoFbP9GYRZskBgDKXf7b22
         bZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCX9xJsXNmlWJ7e8Dkp/s7e0LTFeoKhxIxxN2SGgqqZmTaCptaFG9XsB9BrbyI2/yoTZ18px6ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyveykWBm3T7XjPOx0qu2X0CqzNkbAt8714kh2DoQh8+wU46oUW
	5MGik+XqwuruT75HcDwJjkeJp7Ig0WGVKuGV6pg8vZtXTFLvo9pe1CQzgOBI10pzYH7o7f2VFQ7
	7+dN37/z/vIO7Ylc7lObUeIW3fyGKTVIYFKzDPjKmCx/AA3tJZIwrYyUT17wTdikeyA==
X-Gm-Gg: ASbGncsTSc5JSwCH/REkSdmz0ihI+xp5Dx6pI4dOyab30v6+cEK33gmHR8BmcX5unZ4
	et2DsKJiY2vA8Y2EvWSnoYD4ra+CfRkuNAHx+E+11Ahmnf8pLz0LVVS64BbBVKy8vkm6Il5Lt93
	Hw7o0aidxeUlgweSKpkBUQIAYNDy2GyVNTwYVG2EiP6QBMIZZqRNR9IE78UhNWpj+8lgdD8mtMR
	XBvAyBKfixXf96HbnilIASiurPSVXT1SSV5PHAer8BDZ+jEpYLUz9J+PyrxTMjCZkv7zFvJGOAu
	NHTk0W+z0JH1cM/WCAYOVpVbfOZPrQULLvpU906JMQWiWvnJ+NcitMbZXm106Z7Wx/ebWj/VzO3
	JOCDzwSkRCe4=
X-Received: by 2002:a05:600c:6085:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-45868c9151dmr56874935e9.2.1753349385153;
        Thu, 24 Jul 2025 02:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBDCtOdNtOOjUer8U/bVwafMO6zqzIY2wA51iUL1BDNrL8+9tX2KQFb/3D9W5WVuxG+nKEQg==
X-Received: by 2002:a05:600c:6085:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-45868c9151dmr56874635e9.2.1753349384672;
        Thu, 24 Jul 2025 02:29:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586f88ce71sm12109225e9.0.2025.07.24.02.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:29:44 -0700 (PDT)
Message-ID: <08f2d147-5a49-43f0-b698-6ededd7c93ba@redhat.com>
Date: Thu, 24 Jul 2025 11:29:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 0/4] There are some bugfix for the HNS3 ethernet
 driver
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org
Cc: shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722125423.1270673-1-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250722125423.1270673-1-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 2:54 PM, Jijie Shao wrote:
> There are some bugfix for the HNS3 ethernet driver

Note for future memory: I would appreciate a slightly more descriptive
cover letter, i.e. very briefly describing the fixes included, and/or
outlining the most relevant ones.

Thanks,

Paolo


