Return-Path: <netdev+bounces-290921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCR3JSTLEGpAdwYAu9opvQ
	(envelope-from <netdev+bounces-290921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:31:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1889D5BA76C
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16277302811D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94E7388E57;
	Fri, 22 May 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvr2ojTI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D930EF90
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485064; cv=none; b=cbesFunpWhch9xscuZZqfs5GSh9+l5xTOVp4GOkZDm/hLEUWLtTVHORj/dixRIBetqgqqcH8hnyvDXHYHvrw1xeA73ORksAgOVi3lv3sfC6ESNhM+rw7ZX+q9FJUmG9ayAHOTfwJEP4+gCTbxXZpYU5TUiuJG/HMp51PI2fPBvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485064; c=relaxed/simple;
	bh=4X6wzxH9CRi7D5/xqnYw5mUklSE4bIzW4b0U7UOUrWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaWF5QO72FCD63RUY99fBb1LnascIHt2lA1P6F+tjEqjtIiFN/PCl/A0d/nL/tq/9iO3y9r3zdMT2abqe1kDC0OiD/B0o387zIc+f/01jJVMU/HBwsCwMVNEm7RBulqxA4dQvjPnHEXHjBF7LZOeO3GZvle/vhSXqdLeTKeTvCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvr2ojTI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso68045055e9.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779485062; x=1780089862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1dYQAJtuPMBNLTKwJZ/6YxJZAmjypXguzETEzIyllw=;
        b=Mvr2ojTIBVe2o3ED+VIKXcZQr0Oy2EYAJBgUjy5/t+zQWSGShwYEHO2jg8NGot9yPk
         tZ0rYKSA/kn9FdjqoDmMYPsPGZKGTMn6IvMWWhB8Lnchpwmgz8MrhG69zcbmpe4RCuBG
         71nq0YdRF8nZ68xT1H+s2DfhSEUIospWShlrl/FYDqHkRK4Q4MVRpsZBbyETvjef3VyS
         JvBkNgLxEiOnvBOZ3Ni7zszj6HtUcqTzYb7bBJlZAzyVZcacYBghvV2WLWjMgBoCtUr0
         IoCbR0hrWIsfHv7fpJ7GQ1f7wew6zRtdYyfysDZLjw0xb5fMzhaxJlAATcI5/AievCs5
         XuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485062; x=1780089862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1dYQAJtuPMBNLTKwJZ/6YxJZAmjypXguzETEzIyllw=;
        b=h14F93lq7AT/IDajTdsL1pq+x1F/OhcLXspAepxDKNtwvpYDRycijZd7A+llN75bN+
         XtWrXlCBauxQuGp4p794UCaCh2cmfBDO2c9Di4RZ+nCcVx9r5iq5D931eVFAFebD+tiW
         Bl8pdtX4uE+DuY7gs/E1ltv6yGuVIABJed6rxYyaPSkg8bLtQLBudRYavfXD3SBrtjQr
         Nh065sosFqWdS5aYF4jPxajyYxENQ/mgiWzcVBoA7q6UFK0MS3fOvflJeb0fq6H8jLqI
         o1+V4GXqmMontwZbC3KatpcuYZLrkpfkcuoKy8cCYS8g9omrY/xaUHXPCCSTegZzDkxn
         wAoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IilWxNJn3Et5hnZrv4yBXpHNY/mwyPJSDmLpSQe+X8vHOrXl/gJnHzlWPPPd9kYN2WfFzyPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGbaT7mGYABkB5gg6ZjEbjESDmrJC6mQmDeDBgOgYK1SjcN7N
	ajQaq7hBpCXip/3ZYx7x3IJWkTUnqp4PxR4wtHmLgmfOhO1V56DVRHlq
X-Gm-Gg: Acq92OFyt7+VimCL82IeYSfXnYmLWlKoLpGseHIA82aGsjjFsVn4vpwiD5MaXRZrvdf
	ZIUzjHcuRroeR0UOoiSgUfjb/RuInBYQAJ2fiqTu3ePKt8eUdoFNoSrhgze1/Vi862VoH71LN8U
	5XBc0mx45fqSRxkiuCuoC8pYXTaSNvd2YV2zQ1b+GwhYVqcwLvMEuGyW1KF6R5FidyJ+HGgNp48
	3peQq/NNtrorxZUwurZcbLuMEOgqH4JMMh64J4mJcm8KKSLEeX3qqqgn9NHDSlcyilQsrVtcNj3
	Wh7XH2+X4qx7L4NLbx3NOvdrSK4CKkMT/BqcG2YbD9QDwkZLfS7nashXCrmJ6/xKKFKP1TJiERI
	t7vVOI14kwgOThS0aUw5A4p3x7q7qVCvkV6hR891RTvszegVluWvdmqXxTgaZSE0kL6VThqoMsg
	QB+96hczUkr3Lb1ypBZywrzFU6lLe/o7uO9+VacrO7dWT+F6zYbqDhVT1DKPK36pDwkI5MC1f7Y
	I8lAyUyQqf+RUVW1Wp7pqMx4KmIKBSumPnM7NPOKFvWUc4=
X-Received: by 2002:a05:600c:6217:b0:490:44d0:11b6 with SMTP id 5b1f17b1804b1-49044d01257mr74805245e9.12.1779485061409;
        Fri, 22 May 2026 14:24:21 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f11f:2b01:59e8:aae0:c8be:3081? ([2001:9e8:f11f:2b01:59e8:aae0:c8be:3081])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6ccd211sm8562544f8f.10.2026.05.22.14.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 14:24:20 -0700 (PDT)
Message-ID: <afbd1b31-ef30-4e5e-97dd-54cceafdf2d3@gmail.com>
Date: Fri, 22 May 2026 23:24:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/2] net: sfp: extend SMBus support
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no, horms@kernel.org
References: <20260516135442.2234729-3-jelonek.jonas@gmail.com>
 <20260520234208.565366-1-kuba@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260520234208.565366-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org,mork.no,kernel.org];
	TAGGED_FROM(0.00)[bounces-290921-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1889D5BA76C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 21.05.26 01:42, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: sfp: extend SMBus support
>
> Extend SFP SMBus read/write helpers to use SMBus word access and I2C block
> access when advertised by the adapter, picking the largest supported transfer
> per chunk.
>
>> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
>> --- a/drivers/net/phy/sfp.c
>> +++ b/drivers/net/phy/sfp.c
>> @@ -756,50 +757,110 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>> [ ... ]
>> -static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
>> -			       void *buf, size_t len)
>> +static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>> +			  size_t len)
>>  {
>> -	union i2c_smbus_data smbus_data;
>> +	union i2c_smbus_data smbus_data = {0};
>>  	u8 bus_addr = a2 ? 0x51 : 0x50;
>> +	size_t this_len, transferred;
>> +	u32 functionality;
>>  	u8 *data = buf;
>>  	int ret;
>>  
>> -	while (len) {
>> -		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
>> -				     I2C_SMBUS_READ, dev_addr,
>> -				     I2C_SMBUS_BYTE_DATA, &smbus_data);
>> -		if (ret < 0)
>> -			return ret;
>> +	functionality = i2c_get_functionality(sfp->i2c);
>>  
>> -		*data = smbus_data.byte;
>> +	while (len) {
>> +		this_len = min(len, sfp->i2c_block_size);
>> +
> Does this introduce an -EINVAL regression for ethtool -m during the initial
> 300ms module insertion window?
>
> When an SFP module is inserted, sfp_check_state() sets the SFP_F_PRESENT
> flag and schedules sfp_sm_mod_probe() to run after a 300ms delay.
> Because sfp->i2c_block_size isn't initialized until sfp_sm_mod_probe()
> runs, it remains 0 during this window.
>
> If ethtool -m is run during this 300ms window, sfp_module_eeprom() proceeds
> because SFP_F_PRESENT is set. This means this_len will evaluate to 0.
> For adapters supporting I2C_FUNC_SMBUS_READ_I2C_BLOCK, the code attempts
> a 0-length I2C block read, which the I2C subsystem core explicitly rejects
> with -EINVAL.
>
> Prior to this patch, sfp_smbus_byte_read() bypassed the block size entirely
> and safely executed 1-byte transfers during the 300ms window.
>
> This also seems to expose a pre-existing deadlock in the pure I2C path.
> For pure I2C controllers, sfp_i2c_read() is used. If this_len evaluates
> to 0, i2c_transfer() is called with a 0-length read message. If the I2C
> adapter returns success, the loop variables remain unchanged, causing an
> infinite loop while holding rtnl_lock, which deadlocks the networking stack.
>
> Is there a way to prevent reads before sfp->i2c_block_size is properly
> initialized, or fall back to 1-byte reads when the block size is 0?

Valid finding. I would fix this by setting sfp->i2c_block_size in
sfp_i2c_configure to the known adapter maximum size at that point.
This way, it is filled non-zero and the issue cannot come up.

If there's another suggestion, please raise your hand.

>> +		if (functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
>> +			smbus_data.block[0] = this_len;
>> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
>> +					     I2C_SMBUS_READ, dev_addr,
>> +					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			memcpy(data, &smbus_data.block[1], this_len);
>> +			transferred = this_len;

Regards,
Jonas

