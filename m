Return-Path: <netdev+bounces-290924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK9+LHzMEGrydwYAu9opvQ
	(envelope-from <netdev+bounces-290924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:37:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 147995BA855
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88624300A60C
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674D386424;
	Fri, 22 May 2026 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTVc4vUd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F732F28E3
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485795; cv=none; b=eo8sbvKOcIXEOh9zBnpurHdfgCsbWmhq49883AaWaN6Y4GRUS2kdtw0NRVVaxw/JkFB0Y+YPGOm7LufTEXlWkT8hf6CzyIbDbI1A852EU3OCAKZK9lWVVFKbfK4W+6g1s1dPhMOkC9tB1dsLBa9RvlQnGpNXfNOIwFVVNQlwWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485795; c=relaxed/simple;
	bh=aIS7cZHGJDd3LFnie+bBtN7lwbtQRDS9zwaybw0o58g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2I031WrYEM+AgrPzKci9xYUp59mSQOE/fbGM4dwho/GJNLXp8mbt9HVF1ZyApmkK5JpT9zqRy58SBbk+OQkLkiWcS9uBWu+JoJo2OeLDgDTT+/fXnP6L6dAVpinRgys+scCyyiKDorwLna/Wfe/95kDgZsGMvlyVM5Mw1xD48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTVc4vUd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so18695455e9.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779485792; x=1780090592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfZtpNg/xxd2BsQF/1l2YYHH7lYt774iHWExpAvOxcg=;
        b=XTVc4vUde4GNLTUcS7qivqmTFnWu1GhQVOxSWAWTZb4siKJu89ICaOF0y2EgeXYRXa
         E7pBhuteMDU6cCsYlb7zsMCZBCBnEuoqjaAfHpDX1DZvPX6Oh0Lodj+TL56QKeR6X7Dn
         Frb0SJwjAYBnNexDdaMYtxdG6RarY7/78usteD6uNKONhj/h4b/dyGQaNuw9lp2JCI+O
         ZF7I6nqArM0ShJ4sS+VYofvfJKgtr3HXRJMJNNpFvd+i/1b9g/KbgFSg+i20lt8Sxh73
         guUndM0EQ36VDXZH6oAOcCDk9VOMAWgajYUHMKI8Id5eH1bXvLaV/6VHDiyjW4ognpvB
         6vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485792; x=1780090592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfZtpNg/xxd2BsQF/1l2YYHH7lYt774iHWExpAvOxcg=;
        b=aCvE/QX+fFGKD3wBJU5Dmxl0MkU3s8Yl0H148qHEju/5iPhpvOs41rLKv5ADOYrMyJ
         NrqmSltOQTd1a16cbME3YEHovgh7ct/6GgQK/9G9frD5PO0yEHuaJKuOTwyX193Wq2MS
         gbRAhd48JXgjCaZLRHbwqkzALXnFO43s9Ly32BmkIDsUBATsnWsL1hLy/pan004A3CXa
         zsNdS3WHPg1HvgvjM3Gs9uYwHAp5Vvd5dzRxXTMaUSXfqIHKywk1P+hH5x2yMTft1fjE
         f1aWKpmeEzTUChIQkqj5DVxLaGzJGgufeQrrBkR6oQdqwYrNf0kgnE8lB1MIX5ndI6WU
         WXSw==
X-Forwarded-Encrypted: i=1; AFNElJ8ljnLbNnPZlLNh0Lx5AjpI9+dIYW+5NYTDVmrUYX0452lK10wXTSKHSW42N3eL6pSh8kPsgYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xjMJ+7vvqLkVT0R1LqCLjghlE/l6B/8xaNNEGoSZMwX9vQ+8
	NWuzstvzD0IaRTMDiH7S3USpX6qGl+0IUwHtRbdWYlcHxGQNQjQiWKzP
X-Gm-Gg: Acq92OG090fgeFTmSWqXnWvCOqQVaDWZceRNHWRyWfBOL/w0QA7XMI5F4aj/fTIdnm/
	jRT8dd+txVPcWHzDa6iwCzemEzsYQgDVcpoEYCkC67Cc9uxdP6ylTfoowfNLIBvgGdnp9gLfogD
	t1QLQqTSHGpzZ5/xzntmc0MblaEViMjGAT1tCnttJ8WeIU/BDimkULEZNDds7xIDtv2ZSNJpWst
	BJjYG9zHMAi7NZNHvUZ7Ijj7ACZF2vu8bFPBiJNp81Xae0Za0xJXyyarh6/JPIXihrvv3JVppDD
	CL0pcunWd/XbH0ASSq3Eq193QKnVJncop5ULunnBlir6CPaKMiRQkI2vU7ktmJFRqn90c6bX9Ya
	whLsoCeu2mCxuNu05EoUuSW1UixbFo/Np3Gb8tfDsNyig8shYnZepaSX4vlxwRSkgXFS92CMRmj
	irfCQSoHNp6MlsaJJlJuo5QEd6KFVmS2l7CILd+g7mdOkeHPlVf0WA5U0vrfuGeJEVEmqLd3Cu0
	NiDrw01xLIw3zb2GbIAEbmlfg0PZ0z673pI1Kbw4NyNkzw=
X-Received: by 2002:a05:600c:a213:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-490424ada3bmr53332355e9.12.1779485792276;
        Fri, 22 May 2026 14:36:32 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f11f:2b01:59e8:aae0:c8be:3081? ([2001:9e8:f11f:2b01:59e8:aae0:c8be:3081])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527dbf3sm63950535e9.6.2026.05.22.14.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 14:36:31 -0700 (PDT)
Message-ID: <4a1b13f4-9c68-4f4c-a676-fd61e2aeeab0@gmail.com>
Date: Fri, 22 May 2026 23:36:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/2] net: sfp: apply I2C adapter quirks to
 limit block size
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no, horms@kernel.org
References: <20260516135442.2234729-2-jelonek.jonas@gmail.com>
 <20260520234204.565333-1-kuba@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260520234204.565333-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org,mork.no,kernel.org];
	TAGGED_FROM(0.00)[bounces-290924-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 147995BA855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 21.05.26 01:42, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: sfp: apply I2C adapter quirks to limit block size
>
> This patch modifies the SFP driver to respect I2C adapter quirks when
> configuring the I2C block size. It restricts the maximum block size
> based on the adapter's max_read_len and max_write_len fields.
>
>> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
>> index bd970f753beb6..e58e29a1e8d27 100644
>> --- a/drivers/net/phy/sfp.c
>> +++ b/drivers/net/phy/sfp.c
>> @@ -807,21 +807,29 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
>>  
>>  static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
>>  {
> [ ... ]
>
>>  	} else {
>>  		sfp->i2c = NULL;
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (i2c->quirks && i2c->quirks->max_read_len)
>> +		max_block_size = min(max_block_size, i2c->quirks->max_read_len);
>> +	if (i2c->quirks && i2c->quirks->max_write_len)
>> +		max_block_size = min(max_block_size, i2c->quirks->max_write_len);
> Does this limit the read block size incorrectly based on the write limit?
>
> The write portion of an I2C read transfer is always 1 byte for the EEPROM
> offset, regardless of the read block size.
>
> If an adapter has a max_write_len of 1, max_block_size will drop to 1.
> Since sfp_hwmon_probe() checks if sfp->i2c_max_block_size < 2 to ensure
> atomic 16-bit reads, does this inadvertently disable hardware monitoring for
> adapters that have a small write limit but sufficient read capabilities?
>
> Also, for actual write transfers, sfp_i2c_write() prepends a 1-byte register
> address to the payload. If max_block_size is set exactly to max_write_len,
> won't the resulting message length be 1 + max_write_len, which still exceeds
> the adapter's quirk limit?
>
> Additionally, looking at sfp_i2c_write(), it does not appear to loop or
> chunk the buffer using sfp->i2c_max_block_size. Does this mean the new
> limit will be ignored during writes, and the function will still attempt
> to transfer the entire buffer in a single operation?

Valid concern but it seems like this doesn't have a practical impact right
now. Having a closer look at in-tree drivers shows that

(a) i2c-tegra (read-cap: 4096 | write-cap: 4084)
(b) i2c-tegra194 (read-cap: no | write-cap: 65524)
(c) i2c-mlxbf (read-cap: 128 | write-cap: 127)
(d) i2c-qcom-cci (read-cap: 12 | write-cap: 10/11)

seem to have an asymmetry between read cap and write cap. However,
the actual limits for (1), (2) and (3) are far beyond the 16 bytes the SFP
driver uses. For (d) it is below but would trigger the hwmon disable.
Moreover, qcom-cci seems to be a driver running camera sensors,
nothing that will ever be used for SFP cages. Thus I would acknowledge
this but not add a fix for that.

On other opinions, please raise your hand. Then I might provide
another patch implementing per-direction caps, or any other
suggested solution.

>> +
>> +	sfp->i2c_max_block_size = max_block_size;
>>  	return 0;
>>  }

Regards,
Jonas

