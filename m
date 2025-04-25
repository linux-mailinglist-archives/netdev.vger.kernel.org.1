Return-Path: <netdev+bounces-186185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17822A9D654
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0D4C6AC7
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5740296D2A;
	Fri, 25 Apr 2025 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="WHBn2PA9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89A13B7A3
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745624299; cv=none; b=ddyjmsEbkq4J8H2d5o+5+BoyvMizxy1aa/WLof8KUcDYFywXsAH8ZD+9g2bijkt6D/4hqV4muGLS3MUwFLFAbut9mQVqJiIvUp6MaqLqjNjkaOz1tYzcolXZpGJx1+u2JQnBUoacKs0XgxShxKZWOzQKJlxp8wfQ53KST6HtCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745624299; c=relaxed/simple;
	bh=esw7ySmCSdGEWfUQPx9Ck0zUZyxBWD4CkYFJVY9ak/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QvyooJq2Gktr/pOj1mFBoG4ZsbbE9uXmcnXwbdDexkxezufNOoelOOZwu5/H/Jr+t5UXcYZ0QTzr75eYYqhxZ7bXulDv6vW2vhALUE8nCpx9Q4IrhsXP2Syplza69/Evg2c/QIgbIpMkih72ywWoRuXnXD6E85PodD0iykHyqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=WHBn2PA9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so2768044a91.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745624297; x=1746229097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTZSgj/iv6cXycp3OfvH2ywXhKynVfo3VtFJdq/nyac=;
        b=WHBn2PA9R6aW1oLXd7fBagV6i7yqg63rr+S4z6YflbsEhyIkhdEJOMg229c22Tccb3
         ppQXl53CiTZZIUw2VqJV2bqKOCxqHGlBkYbA3FY8UH1Sh9gbdchtQvjC/GtMKeY9hf5l
         38hnskGnlTQ/zeMKvftlnVSWfW1+v0Dcfu3reTgcLO3Qs7wjNmycRawD0dMllh6RrQQA
         b4Owh91Wz6zmWNY+8x+AMYw2b69oxyUe/PdgEWdgvCXaNoSRsTfiuBJ3CK4by0riQf5k
         cUYWMoRYbngSGn8wMwicFkVTIPj1n05AlPUAqAAXMXSyknPhr3q0C+4KnoNoUbOcNpP2
         IQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745624297; x=1746229097;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTZSgj/iv6cXycp3OfvH2ywXhKynVfo3VtFJdq/nyac=;
        b=I+F0353RMSl70JPzZhMO7LUvmVU/SvhfRL9cZ7+z2S7qFVdDkTGgF81h0CKqK5Let4
         HAsPe4mjRPhFY1nRavfmjA+H9tM2kDJtajAX+/Q+REn8ztLlnmi1kkJQLs5vej07Azya
         I9kYo4BmnfKZg3OVnuc/LW0DH7hP6RAEy6IzusAT+SnZ+89Z0anSy4c9XUQF4RppBfuE
         JTrw5o+9quQykzdCNRJuZnZ3i8TW4FmpbLIkIkFU5oktosGOb0xJcxhIk940XJvZQDOW
         N8AhyL/wcJVCPfwhEdM/E4Onpdz92pc3lpvbRR3I+j/SXC6HGWHz8SDun/COalqQTR1b
         ya9w==
X-Forwarded-Encrypted: i=1; AJvYcCUiGbhPSXiZxR5Mx6/9T9ucaUIfiQxZNtv83Ic09+aIy6bwkebvoow0ey5tZRWKZLIHGys+/8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vx6oGG8ZGocxELoRvrGXexWtL8XqwM6H8Fi52n0twjjBS319
	BcgVE1B1zNf+uccvzdYLAG+QkMx40shJVBwj11S0Vj2aScogJU0jvjaIrGu4OX4=
X-Gm-Gg: ASbGncvLyPikB7QUE48h/l0NutjCjljImUeWUfXFdXhnYULMxoDg8nbXJtIohur0SE+
	xWKUgCrUxAW40WXROvCPuZEein0znvgyMmrAhnBiY2axsvvFFkcU0q7dj436lfZfs2BTpsFH3yl
	Ksjxz2T76mhYBBzuG0gRgLOz5fj4twb4XmsG1tZC7mKxBq/UyEb3oDkLgoyZBz4RxmQW8OPsRLL
	gS6Yyf7HF8IsK3k1AMkmupDdUNoerhCnZLy7QSXRiv93omtwIh7viF6P8HSwst9eC/er1afRogW
	gQARrG2S+CxEbvcFLEDj9/O92IAXyoq5tuSTGdYBB7flgV0=
X-Google-Smtp-Source: AGHT+IHOUdxGqSJTH9MBTyl0OMsSYuShq32vq1zxiuMA+tIKWGblXjsf7i7DDL8rSCUxGDK74C0yNA==
X-Received: by 2002:a17:90b:3ccf:b0:303:75a7:26a4 with SMTP id 98e67ed59e1d1-309f7da1e3emr7078556a91.7.1745624297426;
        Fri, 25 Apr 2025 16:38:17 -0700 (PDT)
Received: from [192.168.1.12] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc2119sm38525845ad.91.2025.04.25.16.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 16:38:17 -0700 (PDT)
Message-ID: <fe560d8d-a331-48ab-a450-5a43bf76be67@davidwei.uk>
Date: Fri, 25 Apr 2025 16:38:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/3] io_uring/zcrx: selftests: add test case
 for rss ctx
Content-Language: en-GB
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250425022049.3474590-1-dw@davidwei.uk>
 <20250425022049.3474590-4-dw@davidwei.uk> <aAwSyL-N9g5p1z9o@LQ3V64L9R2>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aAwSyL-N9g5p1z9o@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-04-25 15:55, Joe Damato wrote:
> On Thu, Apr 24, 2025 at 07:20:49PM -0700, David Wei wrote:
>> RSS contexts are used to shard work across multiple queues for an
>> application using io_uring zero copy receive. Add a test case checking
>> that steering flows into an RSS context works.
>>
>> Until I add multi-thread support to the selftest binary, this test case
>> only has 1 queue in the RSS context.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  .../selftests/drivers/net/hw/iou-zcrx.py      | 41 +++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>> index 0b0b6a261159..48b3d27cf472 100755
>> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>> @@ -21,12 +21,25 @@ def _get_combined_channels(cfg):
>>      return int(values[1])
>>  
>>  
>> +    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port 9999 action {chan}", host=cfg.remote).stdout
>> +    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
>> +    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"
> 
> I wonder if perhaps future cleanup work might use rand_port from
> lib.py instead of hardcoding 9999 ?

SG, I'll tackle this as a follow up.

> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>

