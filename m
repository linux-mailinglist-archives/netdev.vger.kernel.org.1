Return-Path: <netdev+bounces-179279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67847A7BADE
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E8B3B7E68
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95821B4254;
	Fri,  4 Apr 2025 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ESGUk8Qv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0EE1A314A
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762633; cv=none; b=ArVipcmog9jUuOQX+ZCQEs1exWI8RkTGC707seqPDLObYfrgnf3gchEqL1YqWBrc33kv1WPf4nr7l3Wyz/ZnjckrwvvadDoWU4KdXqAP834myB+xZxKy4IGuMnUovc10RGhxRkpuIB1CZnPIVRv30Wg723ddS3keQ7sfpuakWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762633; c=relaxed/simple;
	bh=tuR8ogLN+102A8mr0se4sJNMwYt11xopo3TwsfwUfn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/zmkeN1uU/2YBSgpLncz1nLwNy1R3bl24OE1hShfjMLCXQW0PnoC15m16B7iDcBzQWVpwMdLL897hqYK4bKGZfhHgjhfws6xj+Hr/Qeqsswtb8tzGcGm9vS86yqZ5BfiBht7N23JqYDKwh9FloFaUf0iyazr+BrRMWoAjTJZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ESGUk8Qv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so18268715e9.2
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743762630; x=1744367430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCa0h1WYmNfXaxL3CdCkJZxEN7JBqurAiMu0YdgPsPE=;
        b=ESGUk8QvIMctsPN8EqZtBUXj07M1RaQDyuFedSPB3jtBSMz6CzyQgnUT3ZSNXj6mav
         OYQZPaxjaGgYV93bw1Rhe9Tuj7venj3uHQo6fX/SD2Z0Q9p4JBm8iLGeJJRecC6UM1DN
         UXc1VLnLkM8670N8+dscrLazVAq4Cz/eyIeHr9XucScvtpMECt8St2yQbT4Qu/Y1VKxu
         Nw96WfhIMFF+OdZICvSeIeZgqK1IveZnhF4PKMt80u2lVIBG84ul6NU7Pi9NPunywKzz
         JGstyGCsj/gEHgsU/PTaCP2/RqlTVUW//49gu+L0WzAaI92N+vHAP1B3PmP/YOfRMJJf
         3KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762630; x=1744367430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCa0h1WYmNfXaxL3CdCkJZxEN7JBqurAiMu0YdgPsPE=;
        b=r0V0/DmOGWGXTWvguTnhCn80s3sT6McrtfrchzG9H/+MNGU9MUtEcIYWjuzf6yk8sC
         /0uklG/yEdyBZzWj8avK9XEhERfKtw21zcqxlUi6GbPPK+onbM8A4JpUqP6GWOdjJByv
         it5g47TTw6XPxBceRjGsv9p+O+vfJyaA4sT9/VlZJ2y+auPPCGiRWrwLvM4g6kYCGXdT
         DTxxgGnaygUH1mzF4NRbJA3206prfL8AdaxB/sggHINio3b8jiwRtww/Qjumf4+Xry3S
         rhnwH09V8ReVEZV+AUNuxox8tkGW1uui2e4EjZhShw3QpKWxsCjYUVKbOvSYn1wHpxTZ
         0m3g==
X-Forwarded-Encrypted: i=1; AJvYcCXIrXNRd7FExrpZn69n6/Z9sSkOJkvYpnJFZh6ugXu6wPjuHIOHexuuFpeewnIfc3+lerHPOKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+HnF2ZoUzu+AEjT+P151QKIrDcG/aKz7mG82C9B7Cx6zmmH8
	OlXUFZ/ZEIQ6Tv7H9fh4RU2621ox1lsMODGZcLdiuyFbIbwxRUKU6p/BaUXRFc8=
X-Gm-Gg: ASbGncsivjcsbJxxWgV3Wri8+Yd497u8dWjN1iTH+U7xrCxQcngIv8+KFUBytw6ZM9T
	P0xs9ENbj5ZxqK0LgCzRUfi76d+p9Bi/tUWLwQpBp27mDLU4jdE86H8t3YpB5pBOAuH44VYrSXI
	EgjqIZQw1r6JsvcwWPfV4+3ftEIwLl8jSzH25Jbr06wF/4DNoCUxS4j5DPhKY4t8taeNzrdLkd0
	G0NZkVJP/caKDeimls1/53doTtRiQ1E7TEcFNIbMreq13OwkOWM/2w5zy3jBHvNmivFJ0HtclDu
	w9QUQeUZWHP8lrqY8JI0LDtrMlsysThDIdMP05ctdZdXaIt4ohwJhBMmeH44b328vsRf1B3x21X
	o
X-Google-Smtp-Source: AGHT+IEj/9kwyzS+lDrHuF1aDtd7ZnFRYoi1f0ub48TiwcmQog45MqDKf6yHGPbubxz8L3SJeZRakw==
X-Received: by 2002:a05:600c:198d:b0:43c:fe15:41c9 with SMTP id 5b1f17b1804b1-43ed0bf6378mr20646095e9.9.1743762630130;
        Fri, 04 Apr 2025 03:30:30 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1663046sm46400095e9.13.2025.04.04.03.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:30:29 -0700 (PDT)
Message-ID: <804b495b-eb2a-46a6-a42f-bee87fd45abe@blackwall.org>
Date: Fri, 4 Apr 2025 13:30:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 2/3] net: bridge: Add
 offload_fail_notification bopt
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
 <20250403234412.1531714-3-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250403234412.1531714-3-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 02:44, Joseph Huang wrote:
> Add BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION bool option.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h | 1 +
>  net/bridge/br.c                | 5 +++++
>  net/bridge/br_private.h        | 1 +
>  3 files changed, 7 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


