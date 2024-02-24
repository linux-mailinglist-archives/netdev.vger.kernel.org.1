Return-Path: <netdev+bounces-74712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2BA86265D
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 18:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368CF1C20B03
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6019146544;
	Sat, 24 Feb 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="uSJ5ZFK2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031771EF1E
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708795985; cv=none; b=u8WhNCiQpwUNyY/t9KvyzlX2s+dnf0CAxIaJ+YQf48hXV83kRtm7eHOtgzHUEjg1Jgc4wna1ayviMEbpsSXcpTgNzPiGqETVm4JpQkQrLYpjJGIA6DEtjyAWcBLNGgLPFj+/CFuY0R0kAXLY52AGLrinCZHeZSzi6bwwKiqob+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708795985; c=relaxed/simple;
	bh=vfIQPbYeuoD6yyQgCZjp/iz+rtIu5/SLXQw9G6hsSGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcRInM0/1nuMSImYm/4IFsq4Xc9Y1BqU4uPHxflMSGaJjLC5RlT04mmuu4UbmwFyuz8pzUD/AC2HcorxdlqztsWGpiPdKOXDmscGN4hpADxwMJgGeaCKl0fX/NxXApLDYLNSoV39H6bi/zOIQpJaOYB7LvdIkAKbVZ6yWEb47/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=uSJ5ZFK2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7881b1843so14833785ad.3
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708795983; x=1709400783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQbcRqwCExGFnHTjnEPzslm+cF7EmshGQPBez0z65D0=;
        b=uSJ5ZFK2qQUGaIRiyvtdVT+38HnE1ufwhUuKDxqPLkbZkjcB/B+DUkNgPLjGVnxeXM
         1OkD9lhA70y6PQgotvdtNgMEb6SVJo9KlhlXL5qi59d/1ajlkIMzAuic8aqMqN5YEFyR
         n72m5wKXEVNbpIGys9ex2pWAlzM7mWzy+gk++4IqoxzjE6/2wKQWpRSbeTXKVsXPFI4G
         AicpFa59jqs/5mE+RHSrMHV5BtMCE2ECPqUR+gcca2r5tIFVwSJRhalpo3fbAJbih74D
         ZI6hzdGdR26cAwqqLyGdWINSp3IS5v7xY6UQ0vCVApvLf4S9cK6pfRPGZWP7VgS9qq43
         AACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708795983; x=1709400783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQbcRqwCExGFnHTjnEPzslm+cF7EmshGQPBez0z65D0=;
        b=KDNrDyeRZmOCUXlY0qH/yEUSncLor95huM2uFDRxYXxqrRp0nXjrsCTM+c/5K0D+V1
         DektzfXADY9nyJu3Ms2Jg/WtcReRDgbTOD9yjy+vIFgATTJcETpvla9udiuUB1i5gnMy
         BZ4/hSBFkWcFGWJshDbHrtJUPLfJzTQr75AQ+rdRpfbTvfasivof0NwrGFvkUG3+8iVY
         BwUerzaXYq/wM+qf3Cy+b4PlzsixsgVPEOD5htwnnNnZg7XuWIoQaxSGa0e36wnrVjFT
         Oyt3MBG+8TrLTohLYdufmKthzkw2WgAG4/3i3Rk3mSIp86VVJoWTcVrUDyogxD+j+7tL
         58jg==
X-Forwarded-Encrypted: i=1; AJvYcCX+u/WGhBdZnRWzFsquFdZVG2Hv54WkaNsuIaG3xbolHf4hE1WJsV9R36fxnUX+xMmZ5voQxT67BNOmhAbjREnnAxQkFJaA
X-Gm-Message-State: AOJu0YzNxZDxzC5Hbj5ZGu/r5piPLXkBw8yL/Nb/wNaD1gkt2Q+5GlHS
	v+MlxNXEz2osv3ufB8DJtDEFF/o9FB7cZbMXj7YfbHMW+k8GsraA26BNPTbiWjk=
X-Google-Smtp-Source: AGHT+IHwuKKOLMy5jtt4KplYTZWN2fhEXz9dn+cYU4iwxy9LzlkrsHaiVV3sGBGwt9P58JsPamRPQw==
X-Received: by 2002:a17:902:f682:b0:1dc:26a1:d1da with SMTP id l2-20020a170902f68200b001dc26a1d1damr4315957plg.13.1708795983349;
        Sat, 24 Feb 2024 09:33:03 -0800 (PST)
Received: from [192.168.1.24] (71-212-1-72.tukw.qwest.net. [71.212.1.72])
        by smtp.gmail.com with ESMTPSA id ja3-20020a170902efc300b001db47423bdfsm1251131plb.97.2024.02.24.09.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 09:33:03 -0800 (PST)
Message-ID: <c51765ec-b072-4c01-8dce-c2fa51f1941c@davidwei.uk>
Date: Sat, 24 Feb 2024 09:33:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 1/4] netdevsim: allow two netdevsim ports to
 be connected
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 maciek@machnikowski.net, horms@kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240222050840.362799-1-dw@davidwei.uk>
 <20240222050840.362799-2-dw@davidwei.uk> <20240223164423.6b77cf09@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240223164423.6b77cf09@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-23 16:44, Jakub Kicinski wrote:
> On Wed, 21 Feb 2024 21:08:37 -0800 David Wei wrote:
>> +	if (!netdev_is_nsim(dev_b)) {
>> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_b, netnsfd_b);
> 
> nit: the string format can overflow the 80 char limit, but if there 
> are arguments and they don't fit in the limit, please put them on 
> the next line.

Yep I'll fix that.

> 
>> +		goto out_err;
>> +	}
>> +
>> +	if (dev_a == dev_b) {
>> +		pr_err("Cannot link a netdevsim to itself\n");
>> +		goto out_err;
>> +	}
>> +
>> +	err = 0;
> 
> Why zero.. 

Sorry left over from a previous iteration.

> 
>> +	nsim_a = netdev_priv(dev_a);
>> +	peer = rtnl_dereference(nsim_a->peer);
>> +	if (peer) {
>> +		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_a, ifidx_a);
>> +		goto out_err;
> 
> I'd think if we hit this we should return -EBUSY?
> Unless peer == dev_b, but that may be splitting hair.

What would returning -EBUSY do?

> 
> You should also implement .ndo_get_iflink, so that ip link can display
> the peer information.

(Y)

