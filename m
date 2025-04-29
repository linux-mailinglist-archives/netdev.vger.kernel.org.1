Return-Path: <netdev+bounces-186822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737BAAA1AE1
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E684A5040
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572024466C;
	Tue, 29 Apr 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="zawVJbcP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E424501E
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952275; cv=none; b=cx+G5lmK3Hn6twQizYLzg7Xk+tVqu68SITen5q9Hc9/P2qibo9DPAdcdzWisj3fRrAyn9Xixuod3oUlXUlc2xZDrxOR5md64HPs1H/FUOi/1mY6Gxm9xUkujl/FiwgOORV9SuiVOpt6XddTEc2/uk4VVa6ZwXC+IdWjarFB5VHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952275; c=relaxed/simple;
	bh=NQiU/MSBTj2FH0dX3dtrgsSVsxhxm4REYdXU7CZCTQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TqQJi6eMvf4Q+6rGm4bq2eFgASXop3MoZUs5YZAJEPLcLKMxb2KJAOLAJt60rfCAcEfsQSTB32aJuXwLl53P/JtwzEuVi1Bpa59WR6V1A47dXiHIaLcO9cXjGuRrq8owpl4cn/69xEis2bSl7h8eaNJGXmanSQbNQPIrWoyYmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=zawVJbcP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b350a22cso5623683b3a.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745952273; x=1746557073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UctpGRl40n/uJcjkIn8mfijxx7eJXL+V4bH0PauETlM=;
        b=zawVJbcPsmEteR2gXbNfGqOFbPXRPJIyFkluH4YPYhmqJ7JzDIUVdTaTtWjLrGG8kj
         StaPpkHZkKsNHM0TXb7xpWoYpY5WyU6imoy0/SLGSvgfk/fkOzNp99n6/u/564MSxZ7D
         IHvCinjOhbuYE82CWb7uI3H0O/IjLO2SQfZaLqM5J8bDn7Z8bcUtP/ZogjJraRPMmFCn
         jLofaF3tuxtaUGTq8/ryg9/nklb6Dyd6u6ijtjVLYJaHj1DQ3W4qfYA5GFY+JVB1WgnO
         h3MPCS1f+mUMJHoBG9XG8RHcRIsJadnq20tDKDyKWnA81PmrNsBiIrxuJ++cpkZ0Mk1/
         0+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745952273; x=1746557073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UctpGRl40n/uJcjkIn8mfijxx7eJXL+V4bH0PauETlM=;
        b=YkiW5fpMuEi45LYVB1qQexB93yLUQclPN+WF54X6MkKvUFseVbtInyj6qSHzXlOF4a
         2KaPMexPNhJ1fwz1ZnN/XCB6mjdj9oGBNMzs/5KjBvN3EzHBg4VoFlBVej1hTkCNTyJu
         U8RqA2ApO5rTlH54mCHaSkVbPbr3TpD3mIuyF5rL6S3VcPZuG3/4jxjfkwRD2zpzzovC
         7v4esclVq8wgP8qNmHsMlXdV0m8c7EjQl6emdmTvZ2pIZw5Zl4eeqv6pqZNt4UOQtH/X
         lGm6q55qxkWeEeP8wrIH8f1N+bqpDl2TRd87ZmDqB3j4GEz2xeRaQ+Ma/gl+eku3Lhn9
         3sDw==
X-Forwarded-Encrypted: i=1; AJvYcCVAyuzYPRkb8KgefadMe6nZc1/MAOCEfHejFbMn6feqATXKh5P1t6018VonhRRNyKXlryO9BFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkha2iyD894a/vuccAuUT3viy4eP3MBc+EGp28OEkYnPwf2jS
	ZE/lMAUiDJXu29hlxn2ds1VMmIiq0Xh4nxbXwZc7xZLfN9VdYKlcshY7RAWvmVQ=
X-Gm-Gg: ASbGncv1TvIuodFky5kkKUKJPPv+6AL4OoXEonH+HvQzfvd3IFsjt6hllLucY3fze8F
	0HIdBufR+OXzG2fBpytlS/wjlQTS7wod6osQR5d6obmkHlUqNC2DXLX2bkk+YtnTSovIK4J2GbM
	+gYUIZ9ZC8nZ639mY4YUqVFeL2HaTaxVETwonJtmFY3GxGoLG310Eq9vRaXzVhUyrAKDK623mU/
	RbtOhZA57lwFvIy5qn0QjxGsVpqLABOgnmF7e+b21tJQ4S8FUdrvvgvXPCv7g6T81w/ij+sZxUc
	M3zpFe1ODVfy1Z5NzZOoG+W5lBx1oa6vgg3RKR1iLMXAYLNoTP3ejVLpct/fr997Svg3jM88I7t
	CHw==
X-Google-Smtp-Source: AGHT+IGMPaUp3R2a470HUuK+0WqKF7uzlARt9LBaMGlmtJ9pDdQD0cA+ffSpd35GggDCBgkScdecdA==
X-Received: by 2002:a05:6a21:8dc9:b0:1f3:3ca3:8216 with SMTP id adf61e73a8af0-20a876479c7mr78825637.5.1745952273377;
        Tue, 29 Apr 2025 11:44:33 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:70:cef2:3f8c:63fe? ([2620:10d:c090:500::5:cb11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740398f9ee5sm2760b3a.3.2025.04.29.11.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 11:44:33 -0700 (PDT)
Message-ID: <4c0a86e7-fca0-4aec-bc56-6f6e407aaae5@davidwei.uk>
Date: Tue, 29 Apr 2025 11:44:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] bnxt_en: add debugfs file for restarting rx
 queues
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250429000627.1654039-1-dw@davidwei.uk>
 <aBDwL-XxG-Gvmk10@LQ3V64L9R2>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aBDwL-XxG-Gvmk10@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 08:28, Joe Damato wrote:
> On Mon, Apr 28, 2025 at 05:06:27PM -0700, David Wei wrote:
>> Add a debugfs file that resets an Rx queue using
>> netdev_rx_queue_restart(). Useful for testing and debugging.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>   .../net/ethernet/broadcom/bnxt/bnxt_debugfs.c | 45 +++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
>> index 127b7015f676..e62a3ff2ffdd 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_debugfs.c
> 
> [...]
> 
>> +	sscanf(buf, "%u", &ring_nr);
> 
> Does sscanf's return value need to be checked to ensure that a match
> occurred?
> 
>    ret = sscanf(...)
>    if (ret != 1)
>      return -EINVAL;
> 
> or something similar like that?

Yes, that's a good idea, didn't know sscanf() returned a value. I will
add it in v2.

