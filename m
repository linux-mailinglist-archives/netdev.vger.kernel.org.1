Return-Path: <netdev+bounces-259810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLUALDYKmWn1PAMAu9opvQ
	(envelope-from <netdev+bounces-259810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:28:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0F16BC0C
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1CCD3076716
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AEC31A068;
	Sat, 21 Feb 2026 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu5Ay1s7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E80256D
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771637111; cv=none; b=bm59QOT4y24EcQh0bGwg+Ak962yniQxzozbCENShKlV/UbBR4QiABlvqyCmSytW/aTfIDXwZW0n2ZyFrymewLzEbRB+QiYTUkqAfJmYZYVX4LYtnmCuqi7DiZYxAoTWvH/VSS83sgZK05MXA+74OgTS6S8glZpV7pE0zG75/9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771637111; c=relaxed/simple;
	bh=8AfdFFGJRQq9lQ6HAg0Gt3kisLntoSpQWQBKXocNQCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVubaqGs7O3XoLsReb/HeAozzF3MCyd+IORpXxoGlXLWL9D74V5DqX3Q9c4is7s4YKrmQDCjJVBYefJw8wptO7ZwBvM/Ns9NUYIg+faEpjG7oXJvRGayP4oU5c8LdekfLqs8juzwaPW5rYQCrsKgJmastdlNiGz8300SoecJoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu5Ay1s7; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3452459eec.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 17:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771637109; x=1772241909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uUPr8PJo5TNKKtjOrhpKB8nOTPqFyfkRZt7mLsh19Go=;
        b=Iu5Ay1s7ugQqiqXJRZkHyb1eUx4CrW9DV3Rg/5Yp2OMVpG/N+Xo/BUM0v8WvkY42d5
         81hi4dDGe9sFBdYIlsgetfVgb6dSgsPcew/tt9wEoAwzT0Tm2LngQB+l/kN9nT2PQXtp
         Xa5zNEc/8sluEM1es2MK4U0FRLORYubu3skZdq9upoRPuBOeJ4wsUYvqj3eQbV5Lx3Ex
         3lME9cQnj0B+QptXF+fG0H7fvxyJOR4g+8eBVSGI6OMJal8gXqOUVpDhJ0anHKXrFVkv
         M/UZKwLqzByiIWjSTFQdBGgwO8ZitNDuXl2C6bHoE9ly5bBVL1Zi5WB8cEnaWbEqZsoV
         EFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771637109; x=1772241909;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUPr8PJo5TNKKtjOrhpKB8nOTPqFyfkRZt7mLsh19Go=;
        b=EwzP8Wfa7YwwjTQbvldLkI2KwMtXWcC+eqGvbxbR1wN+ngfVV05GUfx7Fg4a098A85
         r2I3H4ng98DRXEQeCdL4F7rfkiHpngDyeqv8btiGWom7wh6YBTX4Lv+E9sdtGazx2OHy
         RQNnlgxEucGsSCVyIVtIQBTA/GDLoiW6C/Z/QV0gu+z3lEvVyr6C8Ab5MuUhXKKDU/Ip
         L1vY10iCWiMZvBDHkd1AP/s9I1tPENTBEktSLzYuYzk4ogczWInbvOS+yfsueJEIR+FR
         oprlIuSoxrJF21pNkHCx/vaosbRljQ3PtT6cD2OT22OH5Fu+sLpygWQQAB6CFtOA4elL
         beZg==
X-Forwarded-Encrypted: i=1; AJvYcCUBClbpX6oE6BO/Z6hS2psdd+/srOTSr40p/NTP3bsz8h8szxR0Ss7FB1qxOv3+CTiStcnng9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM3AL1toZYiDQxoDy4eiYC2SXatj3yRVlk1yRJhh9PHXObCGK4
	6OvIWl5A4PS6T6lPjk3OnPn6rKxXRr03DL8Uu8Uo2k8cW0Ostj1pxUeW
X-Gm-Gg: AZuq6aJeQMwlXxrgQoR+MuVcEBV2BPsPjgCCgBnLqulbO0fASDiASUUzLeM4EaLr+US
	Ywttmc5T+fprwsg7/t4WcM4BCZLTBoVEA6JtvfX75yEH8oATZkpwZQXX7+PNkwd/UXwLpG3j1Jm
	cKEu7PFeV4l7AQD3UiWa7xtnWq0nr1/N+JKYHQ/2/LWna5juXaJvrxw28uHC5pBqW0cxmJ8SH+8
	KBb7o2SPkKi20/bKpgDhFnP+AVybwePu7iV/g2er+KZUaRhy6ssChJcZCXUk2J1xMlgidlm+FcW
	h60f4r0yai7zml/JDHKfGuvLaxWBX/Ki7vAAQuxt8BInbtbXBAYUI5F/djJYV28/jblk83vAgPx
	U6+3HWD0ZpNwGczB0LxOOEDPUf8kpaYw7sG2lERGg7SZRjoBIYb3Vx8rlnVWoZVKiOvZg6/ESUJ
	mDl1Q/gnZP9nw54n4SNSx+4UpK+/KxhiOX5h5zr0A6YT2oZKq2aF3GdbXHmjW1mh0YPwdcU6ud
X-Received: by 2002:a05:7301:6706:b0:2ba:9f79:8189 with SMTP id 5a478bee46e88-2bd7baea79dmr785306eec.13.1771637108906;
        Fri, 20 Feb 2026 17:25:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8c936sm1142061c88.14.2026.02.20.17.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 17:25:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9d7aee5a-ac46-47d9-ac26-0f3a63b6a8ab@roeck-us.net>
Date: Fri, 20 Feb 2026 17:25:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY
To: Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20260216105522.2382373-1-arnd@kernel.org>
 <aZMKXavVQPelSXcG@makrotopia.org>
 <306e79fb-f3ee-434e-a90e-547e97d2a5aa@roeck-us.net>
 <c881a13a-0687-4e4d-b70b-900f91acd212@app.fastmail.com>
 <70a195ab-3b61-47fb-a361-17b53cf7bdda@roeck-us.net>
 <aZNEKS-fefEgqhTs@makrotopia.org>
 <316a6ee6-9e5e-4518-8dc4-2f39805934a9@app.fastmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <316a6ee6-9e5e-4518-8dc4-2f39805934a9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259810-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: 36A0F16BC0C
X-Rspamd-Action: no action

On 2/16/26 08:27, Arnd Bergmann wrote:
> On Mon, Feb 16, 2026, at 17:22, Daniel Golle wrote:
>> On Mon, Feb 16, 2026 at 08:20:41AM -0800, Guenter Roeck wrote:
>>> On 2/16/26 07:34, Arnd Bergmann wrote:
>>>> On Mon, Feb 16, 2026, at 16:17, Guenter Roeck wrote:
>>>>> On 2/16/26 04:15, Daniel Golle wrote:
>>>>>
>>>>> Technically, with "select MAXLINEAR_GPHY", NET_DSA_MXL862 should depend
>>>>> on "depends on HWMON || HWMON=n". That would prevent NET_DSA_MXL862=y
>>>>> and with it MAXLINEAR_GPHY=y.
>>>>>
>>>>> Maybe it is time to implement dummy functions for hwmon API calls
>>>>> to avoid all this.
> 
> I think I misread this bit earlier, sorry
> 
>>>> I had considered this when I found the build failure, but
>>>> I think removing the 'select' here is much better: this
>>>> simplifies the dependencies, and allows a valid configuration
>>>> with hwmon and gphy support in a loadable module that would
>>>> otherwise be impossible.
>>>>
>>>
>>> Makes sense. I think I'll move forward with the dummy functions anyway
>>> because with that the #ifdefs in drivers are no longer necessary
>>> and the "depends on HWMON || HWMON=n" becomes optional.
>>
>> Yes, that would be great and eliminate that whole class of obstacles
>> with some inline no-op stubs in the header.
> 
> What I meant above is that I had considered and rejected the extra
> dependencies in the ethernet driver. I don't think there is a good
> way to add inline helpers. Technically, one could use IS_REACHABLE()
> here, to stub out the functions when the caller is built-in, but
> I find that even worse because it replaces a trivial build-time
> failure with very subtle runtime bug.
> 

Lots of kernel APIs have dummy implementations. hwmon isn't really that
different to those. Also, arguably, that would not be a subtle runtime
bug but a feature.

In this context:

If NET_DSA_MXL862 is enabled but MAXLINEAR_GPHY isn't, does the system
still work ?

Guenter


