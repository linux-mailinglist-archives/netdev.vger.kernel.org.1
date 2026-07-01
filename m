Return-Path: <netdev+bounces-303623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4gLfLzYERWps5AoAu9opvQ
	(envelope-from <netdev+bounces-303623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:12:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607F6ED18B
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 14:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=AU4UdujO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303623-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303623-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE2A0301E960
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D27A480951;
	Wed,  1 Jul 2026 12:09:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2A3BC687
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:09:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907785; cv=none; b=my1QltcGnm+tpJ3AvDdg8Sb7U+0YdLh8O+iq3KM2hjZf5C54Sf8Qi8ggCW+cLVf9ycDFMZR+JCgI0wLEioH/SM/RqvRqtjspiOnE+mCrBeQDpWQ5RvHxkPyeFB5BO+YJd7bmm+IoYUs5/vhrWW/Pgc6stiv5B4w0vMwD1fmexKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907785; c=relaxed/simple;
	bh=0DVVK+sb/Pylm2Wu+pyR2Td8hSzX5xxVV7uA6nVLoRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nao8Dp/0H8BpE2OQmvcvPWVapyB5Ijagqe6eZ580qbxESdGeRCyHSKsIiXzz1MQo+tYiwpy1noAsbXe+9Rpd4CtWMX49Ht6NPZcoH0kx6y+a87ajvG6sBNdNVGzTj5GzzJi0FAhLgrwl3MBBCpi5ml5Cl7U63CajO0wuJdWSJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AU4UdujO; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b68b4643so3622055e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1782907782; x=1783512582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MMQApmtM0V7pMeP/5HTUxdvab8e0C2Em1BJkv7fkNdk=;
        b=AU4UdujOV9T3UHvagHxYOM79zkYmq9/urpupyUAw9QIYqzaZYK/RS/Ag5goopQ0aDP
         bIEsHNyMAgkCAIg6hHaNcTqr8bXBZLe5iYzTc7EeCYrxXKiGYJucl28M7ftuid+JZzsz
         Bv5paa47xPEc58XWzFK9BiROwIAYu1XuovI1Z4FSSv3dLjskQTctRjFbnj7ZF0+wxeHn
         eORVb4mffxNsO8UlYCpKnd1z3ESCTWHzqTZGtmGwfWgCLeNnZKkl4sYc8UDwV13FA02z
         Iyi99cGmupvyHwSBC2xznYeCt+CQYZefMy35vix+4zMAXJP9TksBYzVEvZZsBwbhfghe
         2Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907782; x=1783512582;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MMQApmtM0V7pMeP/5HTUxdvab8e0C2Em1BJkv7fkNdk=;
        b=reLwARKCr5mjfJJPlfwDW+My2pLUMGulHIfEQTlqJmt+pL8YDceMVMRuh0EZv93+e2
         VthD2hVNfIEqaXT/pIDVI5p2EF+VpPW279HDnYJk3fhWA8jauWbnTGCEPhaYADAnjsc8
         6nAeQ81ZVKPHXzYvUYlTu/HGv7L7fGO+gBmtyvSPwx2C1JfLuAWRiDeXoTcmE6njcdIt
         iz2KdrcaykrZhJaEyFXrrm57+GeXgjt2DHaiYaowTIXVR2Q7wVRjhEFrg7nk4EOfhyk/
         FleIYca6TwRqVKDNcMAQ4IQwCsvd0+h4t/tXvJPMSnEm4abk2u9VTIaUlAyioDo+x25T
         +Ayg==
X-Forwarded-Encrypted: i=1; AFNElJ/73rVCZBSQz07qCrwL7vEU/+gYXSjAnhKHpYAoeHdfmyCID9dUJoxOxcTeDHPI+wZGVgC7M98=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8jWvLsEgQdLkATJ8tBNvuSdNTfcSXhBxzoSt3n5aTpNTQot3
	OtblomTNi4fjObsnuvrOB9U7A7mwkccPXFzTnZHpw9DZCgkjU5JV0+0xovkJ4oGbaF0=
X-Gm-Gg: AfdE7cnSCYpDWOPjlg8YZBKEtyElgzA3KNQPbx8GH2oloCSZ1UxBDCXl9piKQecJV4Q
	U3Tjd+9qad9nWwwaVpzf5pMPg84EVyOaVkwWRbydHZrZszX+phwc3fv+FlgAgBSnWdp73p/myk0
	5+o12sj9zhVm/njaYIi3IuHos10sRXPx/Gpcc1ctmt6kC9Fwcx5TjfYoLtAFxmS1tiGtGxti8qw
	iu6KYTmHz0YbxDykv8RwYewqwF3dCOCay8XiFSNUBTsawPtTHgEPknLGeGHSIyGk7Drv/RiNXwG
	tJ38mjPhvIKFVfgfGf8x4nSfQ/5oI/Csu+Lseh+T+fpCHo0sdl9PMzTVDxW8EWnwua01IFkA2ww
	iKEsPzqNLbSQB00ca39Q8dbDUSqCJkyUMYfxWi0fWpoXMWP2UY9N8txJRxCzIgcU4F6aG7BuMGB
	oswnP5XifzonQe51U+cSTAOOxqM/qzLSVTPUG5VrkieLw=
X-Received: by 2002:a05:600c:34c8:b0:493:92c9:1e6d with SMTP id 5b1f17b1804b1-493c3cfb237mr4704485e9.33.1782907782244;
        Wed, 01 Jul 2026 05:09:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4bfdb4sm77827725e9.3.2026.07.01.05.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 05:09:41 -0700 (PDT)
Message-ID: <cbdc27c1-0fa9-4e4a-96ee-82309b58414c@blackwall.org>
Date: Wed, 1 Jul 2026 15:09:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] macvlan: annotate data-races around
 vlan->mode and vlan->flags
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260701082214.2974946-1-edumazet@google.com>
 <20260701082214.2974946-2-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260701082214.2974946-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303623-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1607F6ED18B

On 01/07/2026 11:22, Eric Dumazet wrote:
> Both fields can be changed in macvlan_changelink() while being read
> locklessly.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/macvlan.c | 38 +++++++++++++++++++++-----------------
>   1 file changed, 21 insertions(+), 17 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

