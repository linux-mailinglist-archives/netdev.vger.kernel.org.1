Return-Path: <netdev+bounces-186184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80878A9D652
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65423B7142
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99A296D04;
	Fri, 25 Apr 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="yQ82hEwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382D1F4E4F
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745624249; cv=none; b=Y7wdPmCE/hNvVq2KkytfIfbuHNp0S6lDn1X9bfm/swTybUaLT0knXHKLrXknKMAoSCiZKpDUmiftQ2ViV0Z45JNcPJA+LIL2xVRNjEezefibprM/j/hKLQ4daRtWPErErrEoVGeeZruvpyjePI94PhdMo7azf5rn06QfP9NZRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745624249; c=relaxed/simple;
	bh=PhEoIhJT5S4K1Cb4u5Z3mcJQhjTh0YNTtJOMZdpjKX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kf5jNDmxVMDf3iXC5CROm3Q3tuaWmj9CCJ05rznsDwzdDGZGHOLxG/ewdVbPQJ+qtvyeHtsnxnInYJJIPebTBCL5KWNlly3VcamT7jymvql53V8srqjGo/7y54SMNupyaAQDNPwivrU9RBAhawQ5b3nW2w1tU9gArIfZfISDdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=yQ82hEwx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227d6b530d8so32814055ad.3
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 16:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745624247; x=1746229047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPFOFIWGGWUoGgYBlEsPjtgwQ0Np9RQ+NgR7+W3sGv4=;
        b=yQ82hEwxflxO6yZhQcHLEsBCHpOSD3eePeVrOQvJvhcm/BD69SRGxZMiuidKCBnK/Y
         iTnUMDSpC3KbdPzgKSvTj8fRim8CwDeB2wolFdIglIMJTs/VjsydpU1PwMRlWAaIHnAs
         vSGcXhsopIZuqx2l2IRBGaG5X/S6q2HZKq+/xmossjn54uCoeIVGlSe2jcosj8f64TpE
         Z6PmG5EL29e2I2qP10cqHl5hvYSwDETqFGb53LzmwUH6Rlnp9BSUydp00cc1pm5iyJke
         NOb+hjkhSDU4DNwgLZm65Zy22mbrf51a7evPWHOSYBnY4N/Mwl0Me3WzWy58fbgUzbNs
         Bq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745624247; x=1746229047;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPFOFIWGGWUoGgYBlEsPjtgwQ0Np9RQ+NgR7+W3sGv4=;
        b=HhaW7ioGVNsGwBC9WmkSGM/t/tJ2ooCy4wf3pLnd701fiCV0ae8vytp2x//9VyfKHg
         qkkd+Yg60WllZS52rHnSjtpHam2AsiLtEii1cHeFqs6A78ultooNDwQs5koLzi3a4j/s
         MEPR+9K/wO3kEOCCFwsB7jeweD33yzbF/0mvOapBJO08umXUPe9PXOBtoyM/5FCeub2j
         Y9exJParnOaEhleu5VVBRQgJ2F/Di/yrbA7RFZM1nNEYTXucKUqE/upNYQmyZ03ikHUT
         b5MHe2pE7jWWEqZShhHwfGH5lWuaPLTpHb5VUNNcxTnF56YWc3jY1+XQH+ulAjZaVQSX
         ksmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNG6iRA7bEHDitSYNG+HyKytsY2DEW1xWUrV1EbDKCYfHCeoLSlbxMVh9dF/TapR6/xET3ehs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkRN4mhD05B8a2PWr3qPB6GraTvPM4px30zW8UQdDIGNUiHLg
	ajPjFwxv3v2IamBb2ckkdrAWpdG/PRt7IhOOrS6BQ8TDZSWHAZ9YPjI2D6WqONk=
X-Gm-Gg: ASbGnctHbVrxil1EH4a8ywB/40dfEBFcRjGVEc1uLi3jkggYbMUxBCjpLtOYhQgWOYA
	x3TVXv5Zk58vMsHEHhy7AM1+o84yli5AhxwjOolC1hOTDvCujX/+ytk42iygW0RDaySF51PqPZ6
	G9XuXi3pYyouRBHxVO0ZNZUMf5FOTEzpOaS117fStuGmIPwqnSKA7bzOibhq+NDCzyZdW2laTnR
	rAeKOUfa0qKLl/edNMAWi5I8rgXdUjcaoG/lEb/5/6kbzyl17R5tavCkCxpBiq4XfLHAAD6audQ
	1IkBhzZycfoIKWg5n/D9fN/zdbeixg3oT1CBCnx8lkfPYuo=
X-Google-Smtp-Source: AGHT+IHvD4Q4MbPHTV1JH82YwnrVleuHJ/CcRrKi853P7E85yFvtWNgzrwLY6YwW+FHeHIUNxB4kNw==
X-Received: by 2002:a17:903:3d08:b0:224:910:23f6 with SMTP id d9443c01a7336-22dbf743518mr65075535ad.45.1745624246990;
        Fri, 25 Apr 2025 16:37:26 -0700 (PDT)
Received: from [192.168.1.12] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22dc8463eebsm2779705ad.189.2025.04.25.16.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 16:37:26 -0700 (PDT)
Message-ID: <e668fa44-15be-4734-9b3f-a7b922c27c00@davidwei.uk>
Date: Fri, 25 Apr 2025 16:37:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/3] io_uring/zcrx: selftests: set hds_thresh
 to 0
Content-Language: en-GB
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250425022049.3474590-1-dw@davidwei.uk>
 <20250425022049.3474590-3-dw@davidwei.uk> <aAwRqSj8F--3Dg2O@LQ3V64L9R2>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aAwRqSj8F--3Dg2O@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-04-25 15:50, Joe Damato wrote:
> On Thu, Apr 24, 2025 at 07:20:48PM -0700, David Wei wrote:
>> Setting hds_thresh to 0 is required for queue reset.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  .../testing/selftests/drivers/net/hw/iou-zcrx.py | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>> index 698f29cfd7eb..0b0b6a261159 100755
>> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>> @@ -8,10 +8,11 @@ from lib.py import NetDrvEpEnv
>>  from lib.py import bkg, cmd, defer, ethtool, wait_port_listen
>>  
>>  
>> -def _get_rx_ring_entries(cfg):
>> +def _get_current_settings(cfg):
>>      output = ethtool(f"-g {cfg.ifname}", host=cfg.remote).stdout
>> -    values = re.findall(r'RX:\s+(\d+)', output)
>> -    return int(values[1])
>> +    rx_ring = re.findall(r'RX:\s+(\d+)', output)
>> +    hds_thresh = re.findall(r'HDS thresh:\s+(\d+)', output)
>> +    return (int(rx_ring[1]), int(hds_thresh[1]))
> 
> Makes me wonder if both of these values can be parsed from ethtool
> JSON output instead of regexing the "regular" output. No reason in
> particular; just vaguely feels like parsing JSON is safer somehow.

Yeah I agree. JSON output isn't available for these ethtool commands as
support for that is quite patchy. If/once there is JSON output I'd be up
for switching to that.

> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>

