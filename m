Return-Path: <netdev+bounces-280769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIrfF7oi6mlTvAIAu9opvQ
	(envelope-from <netdev+bounces-280769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:46:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3104533B8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E817730067A1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4632D0C84;
	Thu, 23 Apr 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HYGGMkYd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A52C324D
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951817; cv=none; b=RX0hArE7O9wF86tY5smgSzXt0yal7jCEoHS1BBIfhZwhF5G8rEljvQanBpPJaW/BV1hodj68kATU/aZx/SVZz5SA/SBo/HthcHmsxTMUYWKgf0gux6X12t8boNh/AgQTksWRZrQacrMQ10hKW5Q+M9SFrYT3ujcXGz0UZx51c0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951817; c=relaxed/simple;
	bh=eWDpAyu63nSz7GLuWw26TV+zQjFIJXRwZEOAo4TYFb4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RFgRFiw+Dk+rH67Ev/ekE9a8nsdIJs6XTthHCbKhPUZ65MbsEQTyA/25PbHP6x4jaO1cjE8HNCpaGuD/MJ4BcqQabQMp08idSYw27Urw/JoGp8WMVf4aMrw3K5XL0GWz9HRWhkNw5Q6+bldFmSmd9K9Edl19ihpWLg7h2Ee0mj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HYGGMkYd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a283c44478so11323939e87.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776951814; x=1777556614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuGqJsZ71FtxmJ+fBHEHhg/A4hL9UX5bh22NH6WKqbo=;
        b=HYGGMkYd8Na72Fxb8v5ZgehYC1jmlrive4T4cgc3UxU5i0NYMHMNqCxJN0brgmVZV/
         EGm/avqsZkZwF9nG7SFdoKH9RVdhW8PhCThT7BxIVvGAdDeq2Cf4k7o7klxcOGv6gis5
         qvbhqoPM2Ii9aN3+AqV4n8DJ9mBSamRj0ZmKOxjPtjiq9GotWmpATI/L0P+Aip0U2jlW
         AVk1IER5XqxR6ExTaaTZF69a1EoX8lu3D+xaV+X8fSmLUIiGd7QX4YPIgw8RuPAuR79P
         Luq2OKiUNZetP5pJmychfDMBlI6XHK121xJwQYEM8liKwzEo0zUAWQZvf3ZGxI8XqqeH
         Wypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951814; x=1777556614;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuGqJsZ71FtxmJ+fBHEHhg/A4hL9UX5bh22NH6WKqbo=;
        b=TLzPBH4GnYOQCm4BLxPoldY+LRGgP+/i25zJJvnYQH2NxoIoSeGJXrvaLJ94yH8vjY
         tVtBY54hWVwrbNVR8km/xSSlmvTVwOc6eslB7H90DM6O3sSRBfCz9or/Gpve5ktmiSYU
         I3okh+tE4xrV+AGiOndtswfPOQGRtdRfvYYFzyTPbQFbHJZdvjMMP3QYr4rPQSwaYN+h
         G3GMRvO6Ygw+5CZZHGSghCWLUqin0RAWaYKoH0ErN56Ex7SWhXiyhETIHGJ3/lTzeBM/
         3kkB4P4W36AJh0ecT1ISNfSAFC6n8F0ZFDq5x23Q+6eZR3TgUORqTeFVZYsv/Pq6I4gx
         EFFA==
X-Gm-Message-State: AOJu0Yzwtp8VlkpHPLgCawEZRuyMUhhkhLEO39uuQAEjddcvw/0p8Egl
	ReL+yPu0FX0cuiRygqfbZ6LUYqCvIO0grAE0Pg/guss0Rg2BaeoBkf84aZ6G5E9UyhBmlgUmOfQ
	3Kl8kFNnB8VpZsrA0NKGmamsNARMwwcephfinIwBV2+/q7gIInFY=
X-Gm-Gg: AeBDievRXC1BEGqQBfDhY0cSZri5yoTZUGnSHU8I0kA3nYt94vogQCVkOm755AMmP17
	BHFUkH7fspz4/w84ZSUgix4f+rVvxpP1+dsOBjYw959DWlm4MZSyDlQNockCnhwWsjYB9WlC1ed
	g8Os0BfoMKdTW5f9lUsUnBLUPOcCljAwaatD2nb3smiyMySF3mjS8xqaY3VeUzh6Sju4tIX3725
	AcgrzHFUEXxq7C6o1BmyrMeTmI7BN+87h/lCAvcD1VNlAQd7zSmemoTGcmRpg1XJQna+5EeoX0a
	r2zRNPr2SKYEUGd7H+mjdDg23xsJcdQ20g2SaTyyijfnoCQLfjkt5m7ej6QYqAuqie7QMYXzzD9
	sfHZJOAlnmR5JNnwSMvWQg5kTIq8VPeQe6kjnAG7hu3sX3HQP0WeZBL8D1i1R6BYx1X5uJ+fF2f
	so8x+RKQPWsl4sn5QKBMRMsxLlVLH/b7KmkCeyuBaXqviQYWXI16ZuLdX3yz9PBAfk3jipk8p4E
	aJrN1lwg98=
X-Received: by 2002:a05:6512:ad1:b0:5a4:1133:c305 with SMTP id 2adb3069b0e04-5a4172daa96mr8401144e87.26.1776951813703;
        Thu, 23 Apr 2026 06:43:33 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8a7c:a6e2:5f00:730a? ([2001:67c:2fbc:1:8a7c:a6e2:5f00:730a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad0d0sm5203436e87.5.2026.04.23.06.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 06:43:33 -0700 (PDT)
Message-ID: <9221605c-ad31-44f9-b3b7-db2237f75eb7@openvpn.net>
Date: Thu, 23 Apr 2026 15:43:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
From: Antonio Quartulli <antonio@openvpn.net>
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Hyunwoo Kim <imv4bel@gmail.com>
References: <20260422123242.530882-1-antonio@openvpn.net>
 <20260422123242.530882-2-antonio@openvpn.net>
 <20260422192050.7c4ca760@kernel.org>
 <7481bc31-44f6-43ae-b3aa-07002644d9e6@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <7481bc31-44f6-43ae-b3aa-07002644d9e6@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mandelbit.com,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280769-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:server fail];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: AA3104533B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 23/04/2026 14:16, Antonio Quartulli wrote:
> On 23/04/2026 04:20, Jakub Kicinski wrote:
>> On Wed, 22 Apr 2026 14:32:42 +0200 Antonio Quartulli wrote:
>>> +    /* Prevent adding new peers while destroying the ovpn interface.
>>> +     * Failing to do so would end up holding the device reference
>>> +     * endlessly hostage of the new peer object with no chance of
>>> +     * release..
>>> +     */
>>> +    if (ovpn->dev->reg_state >= NETREG_UNREGISTERING)
>>> +        return -ENODEV;
>>
>> AI review suggests wrapping reg_state read in READ_ONCE(), I think
>> that's legit. Also nit: I think > or != REGISTERED would be more
>> idiomatic than comparing >= UNREGSITERING ?
> 
> Agreed on READ_ONCE. Will fix it.
> 
> As for your second point, I am fine with "!= REGISTERED" as that's the 
> only state we should be accepting new peers in any case.
> 
>>
>> If you agree make sure Sashiko doesn't complain about anything else
>> once it's public:
>> https://sashiko.dev/#/patchset/20260422123242.530882-2- 
>> antonio@openvpn.net
> 
> Is there any way to get earlier access to these reviews? (at least for 
> patches somehow related to me/ovpn)
> 

Dang! sashiko reminded me that I should swap cancel_delayed_work_sync 
with disable_delayed_work_sync. Will fix that.


As for the second remarks..It has convincing arguments, but I need some 
more time to think about it.

Sabrina, do you have an opinion?

Cheers,


> 
> Thanks!
> Regards,
> 

-- 
Antonio Quartulli
OpenVPN Inc.


