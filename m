Return-Path: <netdev+bounces-288323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCRlHi8oB2ppsQIAu9opvQ
	(envelope-from <netdev+bounces-288323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:05:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5427550F98
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8716D303F076
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13147ECF3;
	Fri, 15 May 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRbW+Pwc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111E42EEBD
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853328; cv=none; b=r7pnOCJ9FBM1cDmu2GI9R5LfZ10truW4s2Z0jo46gjHHK+lAPwH/DO4t/6zbHLQ7epc95Mi/5jI7ELKHAw5GEKwvcXEUemmuRj9M1074LVRpjmHuMBMM+/xw64t7QQn3cypq3cKJ0JlMNlMluH1xYANwTKhIdyXaCI+oP1YuXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853328; c=relaxed/simple;
	bh=BdqdXw8XNNLQANNCqk2G2vcR3pDE3HW/ioVYpyZnd3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B628XYOJEI7fcd/5Gm4z8O8F3HycLfYruelm8em3CB8sF/lNQASDBXiHbbVRpq0M9gGEwsBZKPnzrnxLCslueNT258HXhi7d5A2OtK13gr5QzwNBHO6o5Zpbp8zxeXxOWPjekKFs54j4sk15vve0vytg0fh2REDhmyPyfoo7fwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRbW+Pwc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so50810715e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778853326; x=1779458126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hPqF1JaTYBBLTQ2TRNXm0UJi1hao1fcUpdO8Rg5YQRw=;
        b=eRbW+Pwchaf/gYIhRSqB8lqBxbZuAMW0DOdi1i9SmCRkScaIwhl53Ea3dvV4niom9S
         KqkQ1SZu4mZ0Sk4QPDZgRA4JgFioLmIpNVQQGNO/UxcN8nk6njHFtTBLq58omY1Y3s9M
         /H9YpXr2PjjFeSadlrDaZnL5vMKHf2eGJZPsgaBrQ90WNHtrJGHCwkSkbB1Yzq/x5XGo
         H0tiECbm+/CGXTPd0DWKtfHArmck2wsKY1jmaPyvTxJSw636esAnhu+WhHGvaKjWvmMU
         N1r2mPyZbwbVsQ+Cg7P35Yk3Zi1kVTWMEKNWNqr25fqWdslDcZF7C3VbYYDHrOya0goe
         HeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853326; x=1779458126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPqF1JaTYBBLTQ2TRNXm0UJi1hao1fcUpdO8Rg5YQRw=;
        b=HxwXWRfwI1jUouq499h7IUyQ3n4vuDegZpJYnsRm+PIav6v/8a9ojnCW7/TJtcgT4m
         EpMUr4mPxgkBBoQ7mg3WIZexR3oWqPvGwFK609V4ugLgSgzEAzJRrtx+bDFDfjU094SK
         UEC7dPTBt5XWYBSoSgWykddL/+zgWyUw45kCSXtr3JVs9mhje1VlJO/J3OGO1m+9ySrK
         eLqtfbwQVbF18w/+yDb1ZxuDOCYv/eL1EkX4a6k0EQSA+UATIcDcQG1/d0Q942rVVper
         ckKbUbP/sXGcdVPtUDpTv+vMoH4cVBbR2JUsaLJ7vnoHrwCkFia3BdPeiCAjO6FdpT9f
         u5GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8YFAiI1vg0NB194+99rxEynUd8AQJGgePzp9xRvILkueg5gEGl1xyotGUIkxkwlcTw4dqd16M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/G+9sSE26iyK0B4O9bDk+nQtTjRDFlygDpF/pfPLdgTYwhWR
	4VcrG33mXQfInZz7hyCdPeOiyCzSIkefEGAuwxaH8GL+DDmNz98poUdp
X-Gm-Gg: Acq92OH6e/AbUIu+8zE0ZkfMyrbPlfyA5S6vS7ZrkEcmqHPT913IAgj8AGnDnjk2pBm
	eKqL9hAHPIn2LPIQvGrwdlm/Jx1Ta5J6TLBQCMIBCz/AFIWtlbAKbYKt2tUAudmC/J/BXFO2wLg
	CGbqlzcS/fFdqLse/CF96zOOVF7wPHoL2leZr9ZyztupT/IYesmL27R4HHOrxqOh8PNgOYamN6q
	r0hxtkhJS7BvlwQPco4Oo36KRmd42wy8LgZnpo24g2q/Hm7MtzPIqwo40XAH6zh1VIF5YtPmyHF
	FUIjRPaa8FYD8V3Nuqfe3LibvkQq+ZWHPB9bkES51bojlZkX4MdMPXnWGaTmfupEVhLv56FbGjE
	m8wYrUpMUbCavrLrpm74k/AOdyealkkWkfZSNYOWX2Mah092drdHwWIYcp8fB8OPVSsmgFvUKfu
	jY9HwM9VLwGdk14CF6DvVwMG2epMXEg74BGCTeEuvxkJRpFHNuDyZSFkqn9+ZNIZ6eWvsDZ1hr/
	Q==
X-Received: by 2002:a05:600c:c494:b0:48e:706b:53e8 with SMTP id 5b1f17b1804b1-48fe60ecd88mr57313155e9.11.1778853325438;
        Fri, 15 May 2026 06:55:25 -0700 (PDT)
Received: from [192.168.255.3] (55-9-142-46.pool.kielnet.net. [46.142.9.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7e442sm13876065e9.33.2026.05.15.06.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 06:55:25 -0700 (PDT)
Message-ID: <d2a56757-8e57-4c06-91e0-dfd33855ad86@gmail.com>
Date: Fri, 15 May 2026 15:55:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: sfp: extend SMBus support
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no
References: <20260507093301.1144740-3-jelonek.jonas@gmail.com>
 <20260510164741.1401430-1-horms@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260510164741.1401430-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D5427550F98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org,mork.no];
	TAGGED_FROM(0.00)[bounces-288323-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

On 10.05.26 18:47, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
>
> [ ... ]
>> @@ -756,50 +757,110 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> [ ... ]
>> +static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>> +			  size_t len)
>> +{
>> +	union i2c_smbus_data smbus_data;
>> +	u8 bus_addr = a2 ? 0x51 : 0x50;
>> +	size_t this_len, transferred;
>> +	u32 functionality;
>> +	u8 *data = buf;
>> +	int ret;
>> +
>> +	functionality = i2c_get_functionality(sfp->i2c);
>> +
>> +	while (len) {
>> +		this_len = min(len, sfp->i2c_block_size);
>> +
>> +		if (functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
>> +			smbus_data.block[0] = this_len;
>> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
>> +					     I2C_SMBUS_READ, dev_addr,
>> +					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			memcpy(data, &smbus_data.block[1], this_len);
> Can this sequence leak uninitialized kernel stack memory to the output buffer?
>
> When performing an I2C_SMBUS_I2C_BLOCK_DATA transfer, i2c_smbus_xfer()
> updates smbus_data.block[0] with the actual number of bytes read from the
> bus upon success.
>
> If the adapter or device returns fewer bytes than requested (a short read),
> smbus_data.block[0] will be less than this_len. Because memcpy()
> unconditionally copies this_len bytes, it appears it would overrun the valid
> data and copy uninitialized memory from the smbus_data stack variable.
>
> Since the SFP EEPROM data is accessible to userspace via ethtool, could this
> expose uninitialized kernel stack memory to userspace?
>
> Should the code verify that smbus_data.block[0] == this_len, or use
> smbus_data.block[0] as the actual transferred length?

Valid point, indeed uninitialized memory might be leaked here. I wouldn't
use the proposed fix though. Maybe I missed it but It doesn't seem to be
the contract that I2C/SMBus drivers need to update that field after read.
So using that for a check seems wrong. As a fix I will just make sure no
uninitialized memory is leaked.

If there are other suggestions please raise your hand, otherwise I'll
sned the follow-up soon.

Regards,
Jonas Jelonek


