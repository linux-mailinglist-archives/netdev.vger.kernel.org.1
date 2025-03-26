Return-Path: <netdev+bounces-177864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72044A72522
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD3A165ADA
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5741424EF90;
	Wed, 26 Mar 2025 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/Xdtz18"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D9239FCE;
	Wed, 26 Mar 2025 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028728; cv=none; b=hXvKNpHD8Nf7SN2Iag1HXbjvLB7Lsb1m8RGzNWnfhod/uFbtoM6YhiB2cLiVyGePRQy31V9ncLqPB46H9di7i92gZqsyqjOqExdFVbNSYxnGtVz4dwYir6ExthbyoPaxh62/BL40Hd7TdeShWpwRpJBMur/1WPldThDQHZ0/Ays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028728; c=relaxed/simple;
	bh=H2y9HtTQmvQBzJD1T7U+UffAZs7WKkknHLjpbbnkIc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bV3sbfufw4qAhfIjIzaeysBrn/khA4iNFjmSFcQ7N6wQogxx2TNcPn7cE/dYxJL38qvL0fy9Xzuh98Zlfb3WcRcQpBewuyXlUGM+AMV5In1oMC4D6JfHlabyMI7mkTRlPNSE90tUh8Con5oMFzLuL3kdYeh4m45ry7WS7qIwuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/Xdtz18; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6fd80f30ba5so2669937b3.3;
        Wed, 26 Mar 2025 15:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743028726; x=1743633526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9D44QjpZljk+SGdrmPC7kTMGNHThYXdBfqrpwqLcab0=;
        b=H/Xdtz183chCbDsdJYtyhTyOK/n+BP7XpaKbS0B1iTMwtyuP0yLCtxNXpdzo6Z0xTZ
         a2a+5yqMmYFjRh8bMivO20fYtkTv1LrHf/76MwUyOdJkYa6t/6GJpZXJF8OSyIkeXE0I
         deYSuf6oOkh3ug7t/rLjRIVCEiQdhbFEbZwpFXFMEn6RCbxo4y08Z3zq51IU2ATEMl9w
         ImeXfvpdf2C3ESYKA8pHxzW9OvDDErh3YKeUy3TeUdtaDz/ZvTXszApe6QXyS2rpNIVY
         vnBYIQjy/Y3wsEqj181dTWPmlPmLtuvoWP1tHqGn/uCpM6yA453qc6MgHIfhm6uh7NYL
         /JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743028726; x=1743633526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D44QjpZljk+SGdrmPC7kTMGNHThYXdBfqrpwqLcab0=;
        b=ufuJ85zL5/i5477UcIwm3PwA/YwZxU6GDv+FEkheOSJitV6r4nP1Cc9wRCEEMBeMav
         MbBk5NHAMMi291EuFUqRtR/+g3awYZCUNLBKVm9vf7PjsyYrmWmhmeyzWjU26gzi9b7r
         TGmGPbTaGuK2BmheRQ18XY7XAOXq9etNAoBITnsJosk4YmtHwDbGT7wWSmqxfBTQ25VL
         c044JOlMcsUoTLDpsQR8x4L1k5yPeB50KKYxE5f1mzRFjOG0XMyEVrFR5xmEhSwkpQaY
         Ce5jYRQ7aM6PF4mSSwl0wmWcspaGNhGWneg00WLPZ/gTczvPkq3GLKe1i43Qe7rayT4E
         eBWg==
X-Forwarded-Encrypted: i=1; AJvYcCXQGPOq0o7tl97d9d26Z24Yw7RW5Cq0DIRSJ1ZyKII0TQl4NfvpybuVTplp8vf0UHwyBubmzvKd@vger.kernel.org, AJvYcCXorxFyHPx368IZ/FTINw72RxWIZF8ISZa4i/aU6Z1xsFvRPQR14LQJ0NtB3RQXNEmdpnsStvtc/qiSPmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHN0Gh5WQahNYKYkJZzJCWVPhGKbcobgdgZ2oB+6kB8gPpVl3Y
	HDhhAYOBmYKaGVRtjGfijdQXX9exum46oQIJVFXVOeKVR0icC3vyQZExPv8+
X-Gm-Gg: ASbGncsNKl3W8mR0LJ8+QoMd88HXYx7b2txEcl/MIp5PcA2MWCVxt5vTZlaRyVrKll0
	juc3jirKXn/QTmwvTWuPflcnyDcnh2tIs+maTeSlbQkri/b0UwW0NfCbQeb9jnYd7Y48DclKUDI
	CGgCngP3992rRr9k8lY9lR4H+1pIjA9evWuWWdLYg9QckNKiVuMK2RXPEhLFn0dRvQwNYc3Z9Wr
	ER6klADiaabMdbiMbnxVhsT9c/ezt08kZ8YpaKyB9SiYdJOVPwA0QvpQXWW28NwdpeqqyQvzHL7
	R8WAADcIkSPQvL/jmiyrc7S6rSrJGJ/o4o8KFsl3FE5JROJihB0bp1zXbQk5q+oQlRY=
X-Google-Smtp-Source: AGHT+IFdgdXC0PO8hx8zYU5TTKZvweZhG74lAB4hPV2nUNafFDcA0T0mgJgKTjPM7YGUdKXT3THvYA==
X-Received: by 2002:a05:690c:4b09:b0:6f9:544f:67dc with SMTP id 00721157ae682-70224f87e53mr19561247b3.1.1743028725541;
        Wed, 26 Mar 2025 15:38:45 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-702283ec2e1sm517867b3.125.2025.03.26.15.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 15:38:45 -0700 (PDT)
Message-ID: <85a52bd9-8107-4cb8-b967-2646d0e74ab4@gmail.com>
Date: Wed, 26 Mar 2025 18:38:44 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb
 flag
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-2-Joseph.Huang@garmin.com>
 <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/2025 4:19 AM, Nikolay Aleksandrov wrote:
>> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>>   	     pp = &p->next) {
>>   		if (p->key.port != port)
>>   			continue;
>> -		p->flags |= MDB_PG_FLAGS_OFFLOAD;
>> +
>> +		if (err)
>> +			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>> +		else
>> +			p->flags |= MDB_PG_FLAGS_OFFLOAD;
> 
> These two should be mutually exclusive, either it's offloaded or it failed an offload,
> shouldn't be possible to have both set. I'd recommend adding some helper that takes
> care of that.

It is true that these two are mutually exclusive, but strictly speaking 
there are four types of entries:

1. Entries which are not offload-able (i.e., the ports are not backed by 
switchdev)
2. Entries which are being offloaded, but results yet unknown
3. Entries which are successfully offloaded, and
4. Entries which failed to be offloaded

Even if we ignore the ones which are being offloaded (type 2 is 
transient), we still need two flags, otherwise we won't be able to tell 
type 1 from type 4 entries.

If we need two flags anyway, having separate flags for type 3 and type 4 
simplifies the logic.

Or did I misunderstood your comments?

Thanks,
Joseph

