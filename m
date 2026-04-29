Return-Path: <netdev+bounces-282313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJT9HsHJ8Wn+kQEAu9opvQ
	(envelope-from <netdev+bounces-282313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:05:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF19491820
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8ADC33013C46
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C33BADB5;
	Wed, 29 Apr 2026 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="hzR6/7nY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27153BD628
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453473; cv=none; b=HaqB6+eXBeyrFcHPFw/crfsu91M3Msq8GqyeX2/A1A8plw/m8aBJzazMKl7a7DaFJobL7BvIlPxuZK9aeX/RFiwzRpqdVOMYGSPYfucYQEpXhSXu6V2y+YqRUjeookY2OFLNRwt6GP7YaruaMV57nE6d9cwXLuVJ8UyxdLlt8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453473; c=relaxed/simple;
	bh=296joCAmysG1F9Bl6RzFDbrhRYQg7619F1iqk5vNTCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amCTg/cLMTTiL+ZVl8DPj9pYWicPhNqoq0kD4iaOBa7lQyoW0B2LrRM7wVv0BoGnoowdmd5srRf9vUG/hRgUPaQHCkVyKb1PdTcvspRBUqJsvrShrHGcZy/U6sREW0eGnCZqtjQ8xT3CHztFr4u35prSwN6074rqgsh7OeLQVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=hzR6/7nY; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c156c4a9efso17141137eec.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1777453471; x=1778058271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mH181RFMTZLLgWjxnA9SQ2slwkzkvSMv9aF6850KCZs=;
        b=hzR6/7nYlODHbvmyz0YBrgsm0d+qvo5bdcwx9+Own6gDrq6GR6UzMWP/nhth4pmex4
         mT1uhjdBwqHoTbvFAQ5hgDKqyWp69RL+ij+hRvK9Ivvho/zBbHNT+8BafBWa4jrwcACW
         k2FkGfp0C8Nk0UGDWji7dfa1ectqVwId0eR9dpK1vwSXPPaMcCHb5nZFMMoYyDbX5rE5
         bDhCni5l+yitWH9BLNvZQjTkHqp37yf0+tlFYOzJMzsbXQndewZSuXFDl7ANmxeh0z60
         8j3TDj+DqtGiFblpVRdoEWameFX/ivBUl5rEsk33laguNIu1HPf02mj6wHa6XRKIJcwd
         Z/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777453471; x=1778058271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH181RFMTZLLgWjxnA9SQ2slwkzkvSMv9aF6850KCZs=;
        b=QFmsPd63+NFLwiNpnCClAFV1gTc9BvqhTbu12I5pUfRhpKpbnTcUNrhvcJkwawK0fk
         9B/ObR858edrhMSvHKaOlWUN3bzB2Wmu7g+6njvRzrbBuW+IRVyk80UvAKsyj29ZJ3fC
         bnFW4GDmmpzmUOQ7h2UR95Ym5m0BxGaBZ9HInOVa6acCQfdM51EuldBgiNWmrXzUkHrb
         9p/1a6aEcS3cu9x5vIPvNp3DkiJLjuK2aUAiyasbZxrHOQ0dqGpOZDMTWWanSqCXyQ9Q
         jKEY892BxUoTKlsI4nQOL/82cR4fk4JoEdk+5KSTP090/SA9TWQ8itvPkhm+XjdahcHT
         XCRA==
X-Gm-Message-State: AOJu0Yy5r4b/cxw4ojlptN3HkX4jgQgd59wx7G7jHepuqr2EmYdYWWr1
	QkOILZvtAGgIZ5GCWROdCDlPhGnGgY4Rzm6aLu1xFY20CE2etgJ+Z7fjqlGOExcwjk0=
X-Gm-Gg: AeBDievlmFopm+GReZQbN8Z8+TDeYYL6iY13LRBT8x6k2HWrmXA5wCo9ODghNnNmqxd
	BpZ/P0VSqFQNtcuSlT03GyNonQ57OxKfJMgRTZ2T65xYVcTI/z8IBqYKKAH3s0IB2ijJilD4cyr
	fpggp7S8GSeuEV2dJzFAbGDlrdo6zuYHdMr+d4VPSVgjDomY2EBkk0WcNhjVwZ2l3RcW/WHNed5
	mbax2XCt444LvqVPdCd9YmaXICKyinR/oNpE4So4gxDz4/ZVss/9Gqd3EgRpHHocWv3SU9el1rg
	vBH/2uzLLQuqijm5bizoFU0tLYBuYahQpgWn0KMTto4ZKMsUEEoEaKHfKGbHcAHvwAz5wNsz2zx
	t5xteuNFWywhhwm5qGRAL0j9MS1z8gCwQBU0a0K26SzZkeMzHqwII3G+mcRf+lnhKvXlNnSlkSE
	Bkw1xcxduxSwxxpazt4mS3E5/51JvGLRm8czn96vjWNSmBy5gkhwx6zNuTCdntkA1ADqTHWrsaT
	YnzAlwCiIii+Kc=
X-Received: by 2002:a05:7301:7c0c:b0:2be:7885:31df with SMTP id 5a478bee46e88-2ed198bf62cmr1195730eec.17.1777453470531;
        Wed, 29 Apr 2026 02:04:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:5ae0:228c:e58:7bff:fe94:34ed? ([2600:1700:5ae0:228c:e58:7bff:fe94:34ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf8e77bsm1416333eec.11.2026.04.29.02.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:04:30 -0700 (PDT)
Message-ID: <0c396f24-366b-49ed-ae84-9f1982866a99@wkennington.com>
Date: Wed, 29 Apr 2026 02:04:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mctp i2c: check packet length before marking flow active
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wolfram Sang <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260423001517.79219-1-william@wkennington.com>
 <61bb1b3838609996600f46ccb2c4ff89d085ee6f.camel@codeconstruct.com.au>
 <c94fc7c9-279b-4b4b-92f3-7f1b88bc0c64@wkennington.com>
 <1651e98dcc86f38a0b39679b1a6f9ef604e0812a.camel@codeconstruct.com.au>
Content-Language: en-US
From: "William A. Kennington III" <william@wkennington.com>
In-Reply-To: <1651e98dcc86f38a0b39679b1a6f9ef604e0812a.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5AF19491820
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[wkennington-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wkennington-com.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wkennington.com];
	TAGGED_FROM(0.00)[bounces-282313-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[william@wkennington.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[]

On 4/23/26 21:16, Jeremy Kerr wrote:

> Hi William,
>
>>> Out of curiosity though, how did you hit the hdr_byte_count mismatch in
>>> the first place?
>> Our current theory is that we have known buggy firmware on our NVME MCTP
>> devices and we are seeing some kind of corruption on the bus that we are
>> going to fix in on the firmware side.
> OK, sounds good for the overall fix, but I don't think that would be
> causing the path that you're addressing here. The fix is definitely
> valid, but can't be hit through any RX data corruption (we're in the
> TX path).
Yeah I think you might be right, the hard part is reproducing this is so 
infrequent for us that it takes a long time to iterate on testing these 
changes.
>
> The header byte count is populated during header construction, so a
> mismatch here would indicate modification of the skb between that point
> at the actual xmit. Do you see the "Bad TX len" warning in these cases?

I double checked and so far I can’t find evidence of it. Probably we 
still want to keep this change, but it’s not the root of our problems.

>> We started also seeing kernel
>> crashes along with the bad firmware symptoms, walked through ~110 kdumps
>> and found i2c locks that were held by 2 owners (eeprom reading and the
>> MCTP TX queue).
> Just to clarify my understanding of the state: "being held by two
> owners" would indicate a violation of the lock itself. Or is it that
> there are two threads blocked waiting to acquire the mutex?
I think it’s actually this, 2 threads are waiting on acquiring the lock. 
There was a theory that it was a lock underflow that allowed 2 threads 
to acquire the lock that lead to this patch.
> For NVMe-MI, you're likely using manual tag allocation, where the tag
> allocation (and hence flow state) is entirely controlled by userspace.
> It may be that the NVMe protocol-level errors are causing that tags to
> be held for long durations, perhaps?

Yeah, this is very plausible given the device(s) stop responding 
correctly. I imagine we are getting stuck with manual allocations and 
not releasing locks. Can we reset the state machine back to NEW instead 
of holding the lock?

>
> Cheers,
>
>
> Jeremy

