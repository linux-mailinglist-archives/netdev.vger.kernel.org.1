Return-Path: <netdev+bounces-287999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GpvLwHhBWpsdAIAu9opvQ
	(envelope-from <netdev+bounces-287999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:49:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4D543768
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54830304EF65
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38961407582;
	Thu, 14 May 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez8invaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5049407572
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769232; cv=none; b=gQz7fL0J0DOHbnbAXHfccpezdLiGpG+cwnXc5uXINXKdbrMzMGuXp1zFmqgRPyxKObVwuyifLF1Ama2J4jM9QM8GCWHAHgXnrQyoHh78OkUkiZOHzIIZfwwdxyRCs7xxTwnFuwOs5SN4OlCv38aH+5dt+hszQyX7pD4cDAIDIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769232; c=relaxed/simple;
	bh=86L4wx5USCbAX1+sjgrfkiU+rd2WBRiuNuMescmcXWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuMavMQN1WttG4W5Huoxv6mzR1oluuColPt+X6OcqFih40f/TNMNauQ85RimpURgAzRZl0glHDnRx032WeWOw+Zy9Sd6rWuMdS9Tqu0j2ghtF8o9GjKSu8J1omw+7sWluALeinjwBEb88FneekwiasvL/z3lXulUCHgoeL/V9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez8invaz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-444826c16ffso6750110f8f.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769229; x=1779374029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5Lv1hTQJ61kzxfQvLuMTMmEW9FXwpHbbciKhb4RyGI=;
        b=ez8invazwsGCMV6jTpONVqj60K1TXVTQ04yNGcmg8Zjh+5rQl/d549vPdYeVVhqJ6I
         OGkZr3zgU4m29ylD1qYCoFhut7PM3gEBu0KEhMMA7GCM2MbR/XjCy1WVPaxXzrbENpPS
         hZwjaYT7tgl2OQIPy5XK0e954bqiVSsnJ710G3cieSZ+dLuEDBNjFRwzuTdlS+X+R7ha
         uoF96KllBUnQXijg7aDkzHJsSbeHHNKnm4AhCXo0ZnrzkXhuZPNHsk9yyuVOL+au2kcP
         Z1YdT8QLLCbcRKwve54iPP91YZCquq+ALxoewsjVzhjO/KEPQHt3KSUk1axlgBDNJ8Tx
         IVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769229; x=1779374029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5Lv1hTQJ61kzxfQvLuMTMmEW9FXwpHbbciKhb4RyGI=;
        b=qbWJBHCBYqLBgMmoMYxfypflaeQqrRG6lMJE6EpxUOkzs9DKkLEMZSB6qDP52CTWQD
         X46tn/jW2K/qFoHDfVtsF+QFCwj9BX7HxdReVA9wozz+oUD3JmBT3iMIM7BHEpDzhRM/
         j84jwweQ8BSBtb+AFx0tZWOLKEWCE8MsAp73nAlfRU0jub5v1UkdV43IxhAX5jGCCgQy
         VONITHmv3Uu7wDfWepIhwtVG1UKBs90J6E5VJDzTyLm0Qdmi54RgaZw+UlAO60plToMn
         mikOtwDOJvs201DwAd4aRolHi4hvBffNpJKvQCwSkdQ7+aAgXaDn36MF1XAYmuNYP3L7
         dTag==
X-Forwarded-Encrypted: i=1; AFNElJ//W1fEspyBicdHfjP3kxMMt9yancdNVS4m4MZfUmGC7qUl/P8Ygt7cLo2GEtatuo3tOUtlDsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV54PKatUmRi/YXwAAlyaUZnCrTCYofLZXIvw8DzBc4CD5Nih4
	8PsJ4oefdDyV+RnUQ7UdcoehhsRGmOGr+4uHtBOAQaYq+srLYqUUd4Is
X-Gm-Gg: Acq92OF5tdniDqNjoGjae2VAVkPgYM2Ianab3FzJVlKgYuh+otJ/QACUiYgzcLLZm4v
	gzGPRSzEAUSDIHtFyfl3eRzY6eXsMmwhQvGVshJ5HMkRjqtUZoIrlkL5lHaItxoPY8DArqzPTCL
	g+OZSJhf6vYR1qGiI8UtQsop2iRXafMnC1CKIX7nE+xyoGQJcXpybVP8qan4BD8S8O4i2wIkIcS
	A3WbWY48nmZK0FrKfp7WpUVLhhqjSHw3I6YdQj3p9a98wFEFJAho8iDA13W1lVmbFHlC/E5JEn4
	dXxwfYH/3eJZChg2cml7ITpUVv5ELHX60Aqu31a51zHQGlEPqzhaQkFbO/28MYyqkIjdbT8BDdY
	e25Wb05imd+nzTofjV/ydm4jLYRPEeTSFL0nO1dfMH9aVTPQF+G6+S6CH5lX1Epc+9FixJURZDC
	w4Mr1SNKDpLRsG5PMrzjNti2u52p7NaivF5kb9SDUK8d6CwFz0SqYTgXJPvHdcYTrnWmFhUoH9C
	VaDMvUpwZG9Jq/NkivFDQ8=
X-Received: by 2002:a05:6000:268a:b0:43f:e934:50ac with SMTP id ffacd0b85a97d-45c5859efc6mr12993892f8f.7.1778769228897;
        Thu, 14 May 2026 07:33:48 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f129:8901:8931:b71:1255:626f? ([2001:9e8:f129:8901:8931:b71:1255:626f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2ffdfsm6594332f8f.15.2026.05.14.07.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 07:33:48 -0700 (PDT)
Message-ID: <5129a58d-8852-4395-85e1-8991934810b8@gmail.com>
Date: Thu, 14 May 2026 16:33:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/2] net: sfp: apply I2C adapter quirks to
 limit block size
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no
References: <20260507093301.1144740-2-jelonek.jonas@gmail.com>
 <20260510164726.1401317-1-horms@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260510164726.1401317-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8D4D543768
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org,mork.no];
	TAGGED_FROM(0.00)[bounces-287999-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

On 10.05.26 18:47, Simon Horman wrote:
> [ ... ]
>> +	if (i2c->quirks && i2c->quirks->max_read_len)
>> +		max_block_size = min(max_block_size, i2c->quirks->max_read_len);
>> +	if (i2c->quirks && i2c->quirks->max_write_len)
>> +		max_block_size = min(max_block_size, i2c->quirks->max_write_len);
> Does applying max_write_len to max_block_size inadvertently throttle reads
> and break hardware monitoring?
>
> The max_block_size dictates sfp->i2c_max_block_size, which subsequently sets
> sfp->i2c_block_size. This block size is exclusively used by sfp_i2c_read()
> to chunk read transfers. The write message in a chunked sfp_i2c_read()
> operation is always exactly 1 byte (the register address), irrespective of
> the read payload size. Restricting the read chunk size based on
> max_write_len appears to cause unintended side effects.
>
> If an adapter has a max_write_len of 1, the i2c_block_size becomes 1. This
> forces 1-byte read chunking and explicitly skips hwmon device registration
> since sfp_hwmon_probe() requires an i2c_block_size >= 2.
>
> Will this change actually protect writes against the max_write_len quirk?
>
> Looking at sfp_i2c_write(), it ignores sfp->i2c_block_size and does not
> implement chunking. It unconditionally allocates 1 + len bytes and submits
> a single i2c_msg. Any write where 1 + len > max_write_len will still be
> rejected by the I2C core.
>

The concern is structurally valid - the single i2c_block_size does
conflate the two direction caps, and on an adapter with
max_write_len < max_read_len the read path would be throttled while
sfp_i2c_write (which doesn't chunk) wouldn't actually be protected by
the write clamp.

However, a sweep of drivers/i2c/busses/ shows no in-tree adapter
currently sets max_write_len < max_read_len; the only asymmetric
quirks go the other way (read-only caps, or read ≤ write). In every
existing case min(max_read_len, max_write_len) collapses to the read
cap, so the clamp behaves identically to the situation without this
change.

Given that this only has theoretical implications and there won't be a
real-world impact right now, I'd keep this as-is. But if handling this
properly is desired, I can add another patch splitting the size caps
per direction and adding proper handling to sfp_i2c_write.

>> +
>> +	sfp->i2c_max_block_size = max_block_size;
>>  	return 0;
>>  }

Regards,
Jonas Jelonek

