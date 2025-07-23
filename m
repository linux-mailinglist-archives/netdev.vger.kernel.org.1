Return-Path: <netdev+bounces-209294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A902B0EF2F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4496C0C04
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176BD28B7EE;
	Wed, 23 Jul 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EktbJzhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3377272802
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264992; cv=none; b=OlkKU6mwbX1/MsmV7dtq/UoX98N9nLBgPMP15E5TThjwibI0+6YuBNL/byz757wxx3RJwup+pnFFroeCZUJMlybi+wH5iGX/kHUML0uFQTclQyXQgJslRDGmiS+YHzItieBNBL+nBX60FQJIHEefYtDCdT+vzzO5bqUsMNogwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264992; c=relaxed/simple;
	bh=FRb1qiH3o0lBrK696PgM2GZRUTuGEcb/TysNiZWRTjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhX+phE+Q1BGtVQh7en6T2iptULaI7Ndo1UI5HEUbK+M1H4q0Xc8zQcgQwvVajVs/yttxVCOxWWCUoxjthb/6gHOISIqLlJAPRvdEfpav4n+wdbBjXg2IEIk/S68hivBpc9Bnmy/mYowrYOISqoXpsUhW8sSO38trzPv+fK6+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EktbJzhf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3b336e936so1218801966b.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753264988; x=1753869788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nM1jVIuamez5M+6HVwApfA2A4Uhe2e5VzTRsWi7W/gQ=;
        b=EktbJzhfucvM0krtabXvgfc80xq9eDf8l/eN3xz/1Nzh0+5Zm+mU+B+oJrqnGPk8b2
         tum54brUGd+VXs0PnXDQGNrw3mfZNWWmvWCCzSCHN0XJ4dRhy+D3roWwJUoKsuLdassn
         hfzCtsYyngpOFOZf/6U7Nx0EBWcBBE/SiDX7RwRFzXgMB5RUVy7VZDpJlQTEGL7A2T6j
         w1rzDYpR0IF9QqzUDkQB891E1giKEfPpw2gQJBCpTON5H5ZBTfW754ExipJo2gPX95Ys
         T2O79TOC0/Pbci80qb+owp2EWPDj518BDWlndT8p3I0/1fISg7nxu+qRnKVl4CUybM0S
         WUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264988; x=1753869788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nM1jVIuamez5M+6HVwApfA2A4Uhe2e5VzTRsWi7W/gQ=;
        b=Z8TbGOz5moxW89WYI6TnmdJtmafPSdwuTcYa744aV/ZPsg3XEU/pulkdjO0e/p6bil
         vOB4TTBfBKlkrd+kFbH6Mycy8HFe05fGwzPzS2Yk0cI3MbCAkLUwuq5r6XuGYtQAwC7P
         N1u0KiXU9XyYkrvfgZ8BQrJ0EIT4SMjx1RxOL8St7I7Bf38MZeuq+4/KgD4PicI3s4Z/
         nsg7QUVBcWGKmHSFXfNLd6GC3n8Ym5RX3xlGw2d99d6iMb2uMd7iGyos7z7iBzEP2DE0
         IJUPd5JL8foLAobXe9X5nJy6tOi7Q9Rx9zkfdXxhyV2IAKfInvTVlhgUdj0QLpACmoKb
         74gw==
X-Forwarded-Encrypted: i=1; AJvYcCUPNCTNa2AHCcdDAFULohg+xlr5g5B2LjPrzjBcoqp68XTN92et1oVFUpQh3z6HfyOLrurxI8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvuM5HQ55ORYsK6amJzhAwIAQScr9A0+oh4tlghKaTJC91TgP
	j2CHz2YwvWFDc3xBmbD+pRnIFTSOru3yQC5H13wD6Tb3Vg9azASzqR/8zF9Yg1vbxPw=
X-Gm-Gg: ASbGnctJgE+p+Ojh2baEpKtXQvE1dm2cTPiwmZRzi3lP3OeFM3BGYoa2OBMI6F5DBVK
	Fodg0wh8IFfhxlWq2669/ezjA1AQlt7R+OQB5f7fTNVnh782530Bta8vFkolH2Q420rUghtMDf7
	gn2VZ1qwoS03V61vZWFEU2SDN61rrZhS1nFaCVrXcnjW0cNKW4NZl4r9DE2/J9RhMJjcmp4q5Sz
	2WWMfVDXdXGmf6Nz/m9DE6cT65M2L6LDzFNAoNWphgi9Sj4ys/EV1yxx7hTVJgv7Y63uiv161HK
	c8gK+UqMyI3OTk5P20PsZnFJrOhk6Jcbqcuj6ei6ufJGSTu2RXMEqlpCigOTlWfAMO8z9Q8mvLG
	b+WKV8r41zWAOKD436b310YeLXJxKCQ3Zw9wemDJtBvWsOnDxG9Is/6DDtETWhAfa
X-Google-Smtp-Source: AGHT+IHfkzSwbGur1NwDeKeURLOKGW+DVfaaRz59/h5ZYqfN8olyIRuFnqm0vC4m7ZjmRZpOt3tqYA==
X-Received: by 2002:a17:907:2da8:b0:ae9:b800:2283 with SMTP id a640c23a62f3a-af2f6c0a946mr224628566b.15.1753264988234;
        Wed, 23 Jul 2025 03:03:08 -0700 (PDT)
Received: from ?IPV6:2001:a61:1375:cb01:9949:2e73:6e1:36f7? ([2001:a61:1375:cb01:9949:2e73:6e1:36f7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c9071069sm8158777a12.50.2025.07.23.03.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:03:07 -0700 (PDT)
Message-ID: <77738f53-591f-4cfa-b65b-9789911ca4b3@suse.com>
Date: Wed, 23 Jul 2025 12:03:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of
 MII
To: yicongsrfy@163.com, oneukum@suse.com
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, yicong@kylinos.cn
References: <6373678e-d827-4cf7-a98f-e66bda238315@suse.com>
 <20250723084456.1507563-1-yicongsrfy@163.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250723084456.1507563-1-yicongsrfy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.07.25 10:44, yicongsrfy@163.com wrote:
> On Wed, 23 Jul 2025 09:17:02 +0200 Oliver <oneukum@suse.com> wrote:
>>
>> On 23.07.25 03:29, yicongsrfy@163.com wrote:
>>
>>>   From these two tests, we can conclude that both full-duplex
>>> and half-duplex modes are supported — the problem is simply
>>> that the duplex status cannot be retrieved in the absence of
>>> MII support.
>>
>> Sort of. You are asking a generic driver to apply a concept
>> from ethernet. It cannot. Ethernet even if it is half-duplex
>> is very much symmetrical in speed. Cable modems do not, just
>> to give an example.
>>
>> I think we need to centralize the reaction to stuff that is not ethernet.
> 
> Thanks!
> 
> I think I understand what you mean now.
> You're suggesting to create a unified interface or
> framework to retrieve the duplex status of all CDC
> protocol-supported devices?

Well no. We have to understand that the difference in duplex
status apply only to a subset of devices. In a way the network
layer is deficient in only having an unknown status rather than
an unknown and an inapplicable status.

If we are to retain a single status for simplicity, then
I'd say that the default being half duplex rather than
unknown is wrong.

> This seems like a rather big undertaking, and one of the key
> reasons is that the CDC protocol itself does not define anything
> related to duplex status — unlike the 802.3 standard, which
> clearly defines how to obtain this information via MDIO.

CDC is not a network protocol. CDC is a protocol for talking
to network devices. CDC can define a way to transmit duplex
information. If the protocol under CDC does not have the notion,
this will be of no use.

> Coming back to the issue described in this patch,
> usbnet_get_link_ksettings_internal is currently only used in
> cdc_ether.c and cdc_ncm.c as a callback for ethtool.
> Can we assume that this part only concerns Ethernet devices
> (and that, at least for now, none of the existing devices can
> retrieve the duplex status through this interface)?

Yes. It is not really that important. But strictly speaking the
network layer is using the wrong default.

	Regards
		Oliver


