Return-Path: <netdev+bounces-163877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38D3A2BEC5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E156C3A23B3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CD81D5CFF;
	Fri,  7 Feb 2025 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="aIJou5B4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C241D5AAE
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919294; cv=none; b=imIF2bYsH2y3OwkuAacEALB47bW4tTE2NGuz6qpjwa8dxF7ZNlcGzp8YeKu65SIkaoTmO0dQ8lwYuPJaF/AuZkOP/mTyKtRb/CkirNVwPNlsp6+eE5YaOspgV2uHah2MX+V5oASbFSen+a8Nbd2ADr9SnK6iT4GOs99dpetfmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919294; c=relaxed/simple;
	bh=1R6HcGvORAHV7tq/cAUFDOqo8gqx3kfEsHkVWHMzkJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qd996sk/JT6EA9bS/dDxhzPQuIBQlS9X52NhoLLOgBZsxvqNyh1KkT/hSNJosZc/0ZSCPdickr2AZsQ3HrZPAUO7jv5hDRMsuuRXxA9fJHDbj+ipSWMNlX9+/+n4Qcr0mo//IemG1GueAO3Ll8AgaD6xj0NaFNgDpMdtzKMUKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=aIJou5B4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38c62ef85daso252679f8f.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 01:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1738919291; x=1739524091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=56V5bOg0EtfD8kZQ9arz5/00DzPXuSL6JOaG8De13wc=;
        b=aIJou5B4lMRSCOhjgE52Adt0PEqvUW+ukXL+V5j2O56GcfsWnhsopIkOoQekGDUApY
         aqgnWALgwHkHXsv49TKvdXl7dvjT5LIWjxJN9QRTzHomPInPCZQ0kg0exybu+Q7e51Nu
         omSWm9JZ3R/VNoqaT8agrDJQ2wn+YQSbHjQzwm60tEVwd0IK5vwBwpqOin+m9Ky44FWQ
         neBe4tIBUGlp8waEAEIkPJ18LJl4h/n02n+zglRQxk/PAFxahpkslBJade9kN3/2Spi5
         sxehhU377CLskgd+VJ3ckolKdqEsmtX6BI5c3VpRGc2eJhVZ+nX8fhkUOLbZN3crUpnf
         rfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738919291; x=1739524091;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56V5bOg0EtfD8kZQ9arz5/00DzPXuSL6JOaG8De13wc=;
        b=r+UrUIm9YH/HgGxHY6IiSRmLnOyVAtc9mFzR6FaAhxKbNkqkWNp7Qvai3c7XmoPptj
         t0e9AIwvrm11Kg2cQI8V+MktaQy5u5jo08WPwaHRRrCTegJ1U/Jf2kMOWJGU4s3p5lGX
         W9Eq/X4wfrU4DHw/iYiI3RvEsEzsuTpzl88TK2/zBB0mgDuhgzM9Ki6ahjbX1OphmAAp
         khZ77pKtwWFYRXJMIYFHcXCwFBleRwcVuIrrWD3hoQ+12l1v8h+TNENcQEoA3aUVqX3e
         i2e6EFwJFgOjO3P7QpuLQHzycOSCeyr1VFALJqtpfRvVR3DSYeXn+ZKD5Oe21SqsTLVn
         yjfw==
X-Forwarded-Encrypted: i=1; AJvYcCVURonWvLnxZao3aPrX2noqCynm/o2oXL1kaqibzT+3MEcIQtQO94u+yeMBYpfseVxLh663yiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WEvPqvCoGpLKQ1cq/782qX+hsKLpQj3QVldWDjoBInXQrzvd
	Lt0/LY7is3v14tB8YQSBffPUzueI97DQo9fOY+wyEwLNNyOBzMoua2RxS2VDeWw=
X-Gm-Gg: ASbGncs9qy+TF3JbqCeLikuQuEj9dPTVwAVR/c6mHHklqmzxn4NOXS0Ut3PHXyG9Oce
	JTH3Hfjq5s7dYm+/hjEiB+VsDm3HEP8AfRJ9IGlIin7nxz6LYNsFFZH9vYpnyG0uOkPcKPOHqKx
	Zx/bDiSs88W7PLMwpem7REJRLr7Twbgg4rQT8ljCxraV9LAL0sdyRQEksyuyxRlmHhlAPC7ImvZ
	bP7eKm+z4h2Q8jP3FSAziAGGm3e91Ilj3Vov/6tQKKjXfVizJc6vZJXCR/pit2s6aRTY+q5RQEC
	ZHvHke9QbIWzeAWj0fK0LA2mBdvyUtv1X2pSCh1TxhOMF5Bli3wNVCPw5O2hGuuticfa
X-Google-Smtp-Source: AGHT+IEvWivmCvymYd98u9PIIq/4TYBzyy3lKQSdhuoLPj4g5uhiN8C/MxTA8xmu7AmngbSrWF0bOg==
X-Received: by 2002:a5d:64e7:0:b0:38d:af8d:87e8 with SMTP id ffacd0b85a97d-38dc8dc37e2mr531550f8f.4.1738919291160;
        Fri, 07 Feb 2025 01:08:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:b6fc:4d17:365c:3cad? ([2a01:e0a:b41:c160:b6fc:4d17:365c:3cad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc672b55bsm2135829f8f.79.2025.02.07.01.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 01:08:10 -0800 (PST)
Message-ID: <0c1499c1-565c-4b11-98e7-6b12c1e04081@6wind.com>
Date: Fri, 7 Feb 2025 10:08:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 2/2] net: enhance error message for 'netns local'
 iface
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
 <20250206165132.2898347-3-nicolas.dichtel@6wind.com>
 <e439e851-435d-430d-b7fb-7666ea496954@lunn.ch>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <e439e851-435d-430d-b7fb-7666ea496954@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 07/02/2025 à 00:02, Andrew Lunn a écrit :
> On Thu, Feb 06, 2025 at 05:50:27PM +0100, Nicolas Dichtel wrote:
>> The current message is "Invalid argument". Let's help the user by
>> explaining the error.
>>
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>> ---
>>  net/core/rtnetlink.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>> index 5032e65b8faa..91b358bdfe5c 100644
>> --- a/net/core/rtnetlink.c
>> +++ b/net/core/rtnetlink.c
>> @@ -3024,8 +3024,12 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>>  		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
>>  
>>  		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex);
>> -		if (err)
>> +		if (err) {
>> +			if (dev->netns_local)
>> +				NL_SET_ERR_MSG(extack,
>> +					       "The interface has the 'netns local' property");
> 
> This seems to have the wrong order. Why even try calling
> __dev_change_net_namespace() if you know it is going to fail?
> 
> Maybe this NL_SET_ERR_MSG() should be pushed into
> __dev_change_net_namespace()? You could then return useful messages if
> the altnames conflict, the ifindex is already in use, etc.
Users of dev_change_net_namespace() are not netlink users, so I kept the same
API. I will plumb the extack into __dev_change_net_namespace().


Thanks,
Nicolas

