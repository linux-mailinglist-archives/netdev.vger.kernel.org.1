Return-Path: <netdev+bounces-179278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B67A7BAD7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40071799FE
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83821A5BB7;
	Fri,  4 Apr 2025 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="W/TyADkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA633997
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762615; cv=none; b=tK2s6b/CMnm1jouEXz8kA86N2teXjtv7m14JUsEtNO99IW+lZijDNpE4UlAMnNw0SoEkcWWH9c7nA0bOEcujl7sfeRWfwAfKT8f1pm6XlpJvPhP/6eXkFk19hUMO897mFPL6mG+BzagzdtWxbfQYAMwjJFdXfQ2QuoNeWTP5iO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762615; c=relaxed/simple;
	bh=Jnm3SNeDPY10Q0mQMbLx+uVmDQAAO8BKaaZ3pKCNKOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMge0LwuOOCiSHdc9scZL6DdE2o4QoGQbP182e6mdh42JH8Z5O6uQVBDikJ53ikeD0EfBj2tNu/W/7uEWcW6Soga0+44AozHMb79/QDB/w0Cgg3m46Cr3hbKPQagEo7ac6HTd6z16Ygyq+Lsl/LdMtEuTpixuV9LamFhYIlWyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=W/TyADkh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so1864035e9.3
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743762612; x=1744367412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMK7AiVAmQ13rPWb5TPToJIdxeUpbsGyWlsCzKZ+U4M=;
        b=W/TyADkh1PKTEAZP/tORYyjZRsaLnf6RJMpnmlefDK7DxkFfHVOR9IwHCxtV4ZOIjO
         0e79qfkZIZxP5AaGu1+OFZIQbSFDNVtjpEE3WlnuMxZGn+rSlzDqxwSMhlXB3dIrL8M2
         D95uDpG4bZkCRDHcHnSLzYhsj1mRXZGMHvon9h6dpG3oAEll2iOvy5DjPdUvs2bfGjTP
         KSdlSXqT4T6Oe2eVM76hT4U/PjtNgti+1RuqRj+zpw8deGpIwOq0sgynS7bVoZqqlvTZ
         s4JoOS39nt+9PHFDMCHyVyNoD/OCD1zF5QqKG/Ff2izwdmqbi6VQDurlUMVim/TCH5y8
         DHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762612; x=1744367412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMK7AiVAmQ13rPWb5TPToJIdxeUpbsGyWlsCzKZ+U4M=;
        b=oS4HA5o51qDly8CluOHIJFkbDWf+EtqmxH1i5k6AttrNk6uRKE3S6sxICSSNPjtAEL
         7qJ9Ck7LVoMXEr3Z5LDhAoGz+UHADFjQKLWIjrS23Htt4EHuxcgBlBYjqocag8gmZX2X
         Z8082xc+s3ROiGC3Eq+5kHyhUo8uh2QSDbJ8rRrWdrQMJbc88+DFvQog4/4UTVSYClem
         FBZHNH2C9vwIaXm8R5Hh9ALKaDh4yE1zUnGtIotP+303A9Brzrzl3ttxyXJ7vTp8XqrC
         q921JAH8a5+TCXHKKVEgdvom9CD9O4zp1UhUyfgNXTjBv1T8da4lYKOMy0wPJME7IKMS
         U3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV4ZQEN8fe6kZdw+Oy/JabhMZ8crOrKOPfCISVzCGqbwbu53bi/zZO2Psm3ZCHa/YibRglhswU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERw20zaFjEEjyu1JVfwzJHakcDZYhadchaQxd+n8q6sYors03
	vmWFKuuDvA9yZPRsW43gQNbk2kOYtROXNBeo3i9jahTZWtWHczPftLjrYVHCHh0=
X-Gm-Gg: ASbGnctg67kwAMsN2ouAAY5S7biFJIqEmHYaRHv3mhJe4yuFrrNnIZ7NNTg7nuWLB4x
	bBT3AjAykBssGzVFFD+pEVC9/gZ///uOiaW6dr7e9k9Th6rE9E57TXBuV/t/wARYzAG6R6V+k/D
	B/4QyXNQ5Tuqie6YZleMlS+hS3aJ5loJ9Hx9h8AC2ij7M6447BJxVk6QzuaOyl1N/IeKJxlJIC4
	XgqYz2/Z1KTjxgnjPNZvUCn2KzHNcjT6+PxSpNypIIf1fIgRmAQIzTUN4TmrthhSr1PhUqqreXx
	i9kFD0pSA9yFfS87fB7bb1z/ChBjXSxzboBaecnl7HnHvzzinskPtdbbGiqS++d4KQsnKNrkoeo
	Y
X-Google-Smtp-Source: AGHT+IHDcuoBi0zXRLBGMhr23rvc5D92TbkiRjVw3vqzvuPIUT8bKi7xRmZ7MxsqaFITZlX/YgKMJA==
X-Received: by 2002:a05:600c:1384:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-43ecf85f526mr22847775e9.13.1743762612015;
        Fri, 04 Apr 2025 03:30:12 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a727bsm3984418f8f.27.2025.04.04.03.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:30:11 -0700 (PDT)
Message-ID: <d5d28034-66be-4ec5-8e79-a5b61bd24a6d@blackwall.org>
Date: Fri, 4 Apr 2025 13:30:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 1/3] net: bridge: mcast: Add offload failed
 mdb flag
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
 <20250403234412.1531714-2-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250403234412.1531714-2-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 02:44, Joseph Huang wrote:
> Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
> that an attempt to offload the MDB entry to switchdev has failed.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  net/bridge/br_mdb.c            |  2 ++
>  net/bridge/br_private.h        | 20 +++++++++++++++-----
>  net/bridge/br_switchdev.c      |  7 ++-----
>  4 files changed, 24 insertions(+), 14 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

