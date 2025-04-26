Return-Path: <netdev+bounces-186271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ED6A9DCB3
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4FB466FAD
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689F25C708;
	Sat, 26 Apr 2025 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="AuHfQemZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31B1A8F94
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745690442; cv=none; b=TQ2g9OVLKGvFzlKoCxaSA9CnNhKRo2+p/4aK+5hHGq9wnC67u0qE69+eihPbcNQTfUY/kTxnchBeMEoTi1rT3F8LOtMejmgPQdOTrJ/UfknmiNOJJ7IdbzE5p4g7gCoPW32UujKRQvovgPx96eDYdanlxj770uLBf1MAdXPJ6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745690442; c=relaxed/simple;
	bh=u3YbSbQr1t68qdkG1ZlwY9MIykzunl7dGObamj58Nns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxTtcRoqKp+UWgG6ilFihFDJrhptI96CrhnWVsKjwjpISCOrtqLecv6ruWPlv3Uk0AzWijgh5BlTxhSODH7t/782MFFyeOWoOqNPzS83rM7l79URkR2e8LmwhhaRro7e4wF8f8WARLeUnIzDWfrmOV34qe3gDfCJDM74TTregAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=AuHfQemZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-aee773df955so3807517a12.1
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745690439; x=1746295239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8nMLKC9EuzoG0KxJa3sqARqrZncC0cz9XbevEN1ukQ=;
        b=AuHfQemZSp4gafO9DGHjvOhsPJQpKwVBFvOUDh/4Dr0zo4+eBjHYOjjVqmPKNRN433
         ZIaPXqmGvniXkfjUAqFCIkSSGDsDtbQ5C+9TEAeWjwlFH/gPczKjCtZX9pGRHFPjh00v
         STXF5EIQlsEV7L4NWSt7t2nUGHeDlkBWM/NHGx0i9gYXnJNHoDTaG1DH7mx8tum4s9Dc
         ayeQFv5eJXFbuyx8yh73Xg4u8WWysqbrmJ7DsWH6ZaxAG2DWgsfeEb/4Kuu6hZrbC7rJ
         qBUytE9bI7jNiSm3UCVGVuCfkpSCtQKyljdN2kFRJAMFxH3oEJOY/cK6CsZkkDL6IW58
         cjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745690439; x=1746295239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8nMLKC9EuzoG0KxJa3sqARqrZncC0cz9XbevEN1ukQ=;
        b=ad7e7yiFTj61gv9PiLaWJMpzSFxXrLmcfpVB3sh4YHz6MvmJP9l+wFEwM6x5AVOX3H
         LzAZhAqLM6iu279RBV3iiaUIjp5Hjdmg8od8l/jXdnBXH27IkhfPm3DlBRHbqvM0R72h
         ujuANU1BKrw23h7ygKCRn+J9HdSUfakMJLHjXx95xUk7DYPCcFioQrjmnst3EMYaYKhe
         2z4rx1WctfexAnFbsAcoMK5ffmWuae+iLr/FnzRdVgd8vD0IeyTeIXa3rGlguCJqd9jQ
         ANw1OUHNuLWS4muuLxUwVPbBv4tk3J2dd4NI4y49nV6iRdRxWO9bZAAgwsGmW8DNBaUN
         JpRw==
X-Forwarded-Encrypted: i=1; AJvYcCXd7etTPHEJWnPh15ucddErhFSyfd4UTdcLrVaO+3gXCT8QrL3gZbwe4olpw9ywdDfNKWRxWAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUJisT977l9y1WOVwaqXxXdnocTnasifg7V8UV/9rp4RftYW7
	nvUkni5hBoroho++WQ27S2LqqAjG7erEba6vSIMUycqf4y2ePWEj0aJagyEiCPk=
X-Gm-Gg: ASbGnctbrWNdOaC7Jz7FSuikb9q1Zs2h6vBwQjSBXEHH52PFrCA+8An0Fy7htpxhZAn
	cJzcWSoenADJHNPQAj1SjCzTe0NkYgjnAePgZrXwE7XzW1/kgnZjynFVywCP4qsaxtSKTvRUBCp
	Ra0LVDFB09bPHKWp4xESuOlKbaZM3WxPJN6YMVAxwGf9BxfIXJXVs2+FAILFs0Av1Si5RpcYxGy
	OC94S9phZzT24QbpItOnjU5aKYS8gOYiogNb95uSS/x0yuXhfkZSJmbYWBnwpew30sFFktRVfuG
	gtSm+CgUe7BsSUQvqIwCRvYJjxorjInqVDEUoPm3/VCJjwo=
X-Google-Smtp-Source: AGHT+IEv/+wzK9kr1p4FdksSjM5bKf5KICKd/rSzYUNuKn7pdrQssIDAJUaKie6z0p8pczyXqD79bg==
X-Received: by 2002:a17:902:e851:b0:21a:7e04:7021 with SMTP id d9443c01a7336-22dbf987e51mr84798935ad.24.1745690439423;
        Sat, 26 Apr 2025 11:00:39 -0700 (PDT)
Received: from [192.168.1.21] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216c02sm52534495ad.211.2025.04.26.11.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 11:00:39 -0700 (PDT)
Message-ID: <c8389982-026a-451f-82c3-0503ecd2f7e4@davidwei.uk>
Date: Sat, 26 Apr 2025 11:00:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/3] io_uring/zcrx: selftests: set hds_thresh
 to 0
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20250425022049.3474590-1-dw@davidwei.uk>
 <20250425022049.3474590-3-dw@davidwei.uk> <aAwRqSj8F--3Dg2O@LQ3V64L9R2>
 <e668fa44-15be-4734-9b3f-a7b922c27c00@davidwei.uk>
 <20250425184248.226460d3@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250425184248.226460d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/25 18:42, Jakub Kicinski wrote:
> On Fri, 25 Apr 2025 16:37:26 -0700 David Wei wrote:
>>>> -def _get_rx_ring_entries(cfg):
>>>> +def _get_current_settings(cfg):
>>>>       output = ethtool(f"-g {cfg.ifname}", host=cfg.remote).stdout
>>>> -    values = re.findall(r'RX:\s+(\d+)', output)
>>>> -    return int(values[1])
>>>> +    rx_ring = re.findall(r'RX:\s+(\d+)', output)
>>>> +    hds_thresh = re.findall(r'HDS thresh:\s+(\d+)', output)
>>>> +    return (int(rx_ring[1]), int(hds_thresh[1]))
>>>
>>> Makes me wonder if both of these values can be parsed from ethtool
>>> JSON output instead of regexing the "regular" output. No reason in
>>> particular; just vaguely feels like parsing JSON is safer somehow.
>>
>> Yeah I agree. JSON output isn't available for these ethtool commands as
>> support for that is quite patchy. If/once there is JSON output I'd be up
>> for switching to that.
> 
> Joe is right, gor -g JSON is there, IIRC the only one we use often that
> doesn't have JSON is -l. You could also switch to YNL directly, fewer
> dependencies. But probably not a blocker for this series.
> 

Oh, sorry. I'll change to parsing --json output too.

