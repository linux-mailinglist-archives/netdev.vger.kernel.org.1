Return-Path: <netdev+bounces-185687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA1CA9B5FD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302514C10B4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2A128F503;
	Thu, 24 Apr 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bKZu2i/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD728E60C
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518206; cv=none; b=gk2N31BWPrk22CcSJWMzjZNZTpIKRXybFp/Hou5/X5iCl7CBJ4zuH3h50klD+SyUQHX/aEkKADi5ZNHMULp1ZbBXX3B/Z8PRmmI3Xi9nbWBYfi7u+UyjNVgHcBYCUN+OURU6lZE3mvfNMDHezu3pXy8uKhuLMQpJRJvV4iS3ucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518206; c=relaxed/simple;
	bh=Wr8Howp6YUBHFQ5IXcbrHAh69nUeNbi1WwiX/cJv9UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOT/0APN3FLUpc2IuILiOIWxXKZqb+ONCCmQjhk/MIUyvxSiO1Py+g9OstWEDpgDaJgp1qY/E7R6mRj7lUPL3lYdbsxQcyB6kW4AlOUs3w5vgddm2m9MrV5AIS0oubjxaFiQ+pf3g6mbyaYQwcUjZ5PZ/lw5grRAoiQ/pUy/XtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bKZu2i/+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2241053582dso21074425ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745518203; x=1746123003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UKNt0lCLDr2VLT9kOvLTb2AuOQOpzIZeg4tCrvuwj0=;
        b=bKZu2i/+MrIu2KWaD9cKAvnwOtvxeCXthuKHF+RSMnLrA28adNRkceF7FVKDQdVdOb
         Nvq6c/Jj8r4Z19qC5Pwd3i793T8SUDrsgwkz5e/def9SNCHPVg8SYZ/nlELW5/MxEspu
         3fkd6+cWdFheKMYW0CgmG5pGFUhTOq8OacB+G/Fubs4yQGoQoLNEiYqTUzGTeokFEQd5
         o/G3Qe0xBpy2OFfQtwTjMjZfVpJgERu7ftw5jiMl+1hFlOiK+BFkFdUYxKr+kHfXTMN9
         aP9osERILIZ6wsDW+OtIUr30RDevAJkzjjvHS0+p9M9XRYNWLF4ncQkUdhN2Pc/3Bius
         9adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745518203; x=1746123003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UKNt0lCLDr2VLT9kOvLTb2AuOQOpzIZeg4tCrvuwj0=;
        b=oSJa9lFKtFL+b8x2ow4IVx/k6eLBIbcMGfqcbOHRJ4XT3v8ESGokYBka4hrFqiD9OO
         xw9MZn46QiY1xV0fhN1uCGeF6HsC5p+ktON/0ffi1QK5FQpEm7mtB0RYPrFJeNlMXDMD
         uSKCzz79xdHryh/nY4oezvDrm7+D62w/g3ZAMCeDh9auNA1xM6PKXxu6LBwi/FxDyO67
         HJBhnmMvhnOPnaEm1AdIXnfzCbs+u3/oxZes9YlOIe9Sv5cs0i780c5sW9z9xy3JN0zx
         OQI3s+zY2WtTkOxPUIjTSonaPX+kXQ+XbNLPxVdZzlScueLgZY0Wu3MzhBuSe2ZXVTQu
         CB0A==
X-Forwarded-Encrypted: i=1; AJvYcCXxo1nrE5QqE0p8FSVGlgrrlhKy6ttSZvUBGnwQnzGqb722Ei54VH/rpvM+tw6QDE+w5FPZK80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzHvsPyT3MhL6HrsvrnZBGlGQsE7EqHEXhUmyrI7+VaO9Lis4
	Z4wqWVVR+dKL4R1Zau9AgJsbk2uWYLCtszIh8QQYOvCmgSjrREKOKMttOlD6Zh0=
X-Gm-Gg: ASbGncvJ89upnPB/ns0QARTW9jL0pdPomoo6qLOAWKAkQLndi2S45Cmqtx93m7LekD3
	l/q3r7oBMnIyzyym/yhkk1GZmwTkVNnkuHNEBUTdXZlBcgLmXcYUzNcqA6wGf0Uloyzgi4857YN
	LOTuax/u82oG2U61ucArv7UcnSByagKaByKEGNdwZ/XGtFNAmNH19TtS2lE7R8kfalhzFo7zll9
	hp1rFlKjelsjPfQyYzhlItG84mEj07s9V9axOS01+PAa5GFWH6gc6sWYpreG0993DaHKi5QErnV
	A6Y1oqhxDwsoJkd4X8RJT7Gk7fFF9LjMtlu1b7EsHDMAMEgchZsJdVUcoe3MtLxiDn9uSpwoh98
	OzfvZMM7xII+YzqqKXnQ=
X-Google-Smtp-Source: AGHT+IHnCaTt/PjXgficrL39pGhcE2L6yyJvkQieKK32vsywiH1L2LBk23RuW6NeWGc4L/G8Ur3ipA==
X-Received: by 2002:a17:902:d50e:b0:22c:33b2:e420 with SMTP id d9443c01a7336-22dbd401ed7mr5490555ad.7.1745518202886;
        Thu, 24 Apr 2025 11:10:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cf1:8569:9916:d71f? ([2620:10d:c090:500::6:c802])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e751dsm16782485ad.142.2025.04.24.11.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 11:10:02 -0700 (PDT)
Message-ID: <6d9d6ad1-71cc-47f2-b7a8-d61f5ecdfa55@davidwei.uk>
Date: Thu, 24 Apr 2025 11:09:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: iou-zcrx: Get the page size at runtime
To: Simon Horman <horms@kernel.org>, Haiyue Wang <haiyuewa@163.com>
Cc: io-uring@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250419141044.10304-1-haiyuewa@163.com>
 <20250424135559.GG3042781@horms.kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250424135559.GG3042781@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-04-24 06:55, Simon Horman wrote:
> On Sat, Apr 19, 2025 at 10:10:15PM +0800, Haiyue Wang wrote:
>> Use the API `sysconf()` to query page size at runtime, instead of using
>> hard code number 4096.
>>
>> And use `posix_memalign` to allocate the page size aligned momory.
>>
>> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

Thanks Simon. I'll apply the patch and run the selftest to make sure it
still works.

