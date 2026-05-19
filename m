Return-Path: <netdev+bounces-289468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLlEL8JpDGo8hQUAu9opvQ
	(envelope-from <netdev+bounces-289468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:46:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBC557FF2B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4822A3010260
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A26B348C4E;
	Tue, 19 May 2026 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Y2xE8nSc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD223403F5
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198334; cv=none; b=Un1pCRUwHWlhi88meZixAy1aSN2xX+8uL+MbpKNyNIgZaPBVfeQLyrf/+jDdoFpRTHlYFW2zu+0+f8Np/HWucuLI27xazCQCEg5xdMRzacTR0mrTa51uSYHMMYD6XrnfHrURrwSubZ1b5keUn09FRcmIUcHGtSJPVRQUAx1Q73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198334; c=relaxed/simple;
	bh=a6qFLyjgLGGhbiixDkKGZIW83Jdh1bNdjuoKqPmHSJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnM2/fjm8UuBdPX7MGcIZwjnwFCPVdpeC7BFvtLuEK98Uo8N31nvJ5dIMF62gNP4iIOMfqQPabegTtqXHZVifv1bS59oQv9aex1278ORYLXXl6opyctOQJlRpmf/uRaTmVkytz7h9kbnPprRKSAKz8973fd7jlzF0f5BYvoUMOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Y2xE8nSc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso6496325e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779198331; x=1779803131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=htvneac4XiJE8jRymOw7+602x21csPB4eaUkO/mk3sA=;
        b=Y2xE8nScV7lfMXxqPzWmD3Jiqz0vfCCEaNT/4r8N0ZZ1NYDR6fqBhniHJkyxvoaLiZ
         UXtM4XbTruR+KQceWShBIkhKyTbO+bgmjZTMllr4DqXMVJQ59TxYEnFjsex6Ekfh1Zxk
         P72A3cNrx2Iz2cO5lo6Su5Df2vQrb3/eFTB7wjCFawhBovHQ55S92fXt2Mh9J0KcIJgf
         IwiDJYYfMNv5kfPNVWsXlbIEE2GC5tafzqXN83cJc1WjV9yRlf1AWxc8UT0feMme7n3x
         60gl0tJpXKMnf9Gz0zaluG/tMYwdzEIlQa3cHm1orBdFLaUmzv1YcqhySBh7xEyavolK
         +4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198331; x=1779803131;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htvneac4XiJE8jRymOw7+602x21csPB4eaUkO/mk3sA=;
        b=Cw3CO9QyUk9qbyxg+xXEXKplkHrwqSHtuMGuUwZW+S+jD1dARJEtLRf12GYh5IGBxp
         dQOMd68zhTMHrqhL/TGDGWNfG9XB4XmmLgpVj0GRZmtHi7kVyC/dm2CnKmsdWJbamzAB
         dPJJxVVU0NX1ttuXDxSyR4PIDFV3CXUhqA878QBOXAVW9CozoWnzYQExGGM8y0JNAWKc
         /Uek6TcSdTnJKCvNTC3R3w6uHkH33I+8ORHrRDPgYM1Ed0TGNPQlSAx3e8GStWudfuJn
         AfWNly6AcBF3XhGuEb/WYa7rDeawCZlCwE1z2kJ1Yzh9gIY8S/H1Rcra5PZ4mxK2J9a6
         mjUA==
X-Gm-Message-State: AOJu0Yys7KRWRiDhSxuZ9uASDBXsCGFG+HSQWS04+4H1YVhy2J2l0Wmh
	gf1kyDaXW5oaW5WFN0+f/3ObamavPH8ENwU4fzKwkpQxGESKuwebYbiqvuGXZNhg8/M=
X-Gm-Gg: Acq92OGWybNlEU0f4NFe9ydM8VgmTbeIa2qc2RiRgT9z61ISn5we6xPMDuuz38uaPJi
	CiCvHeY9UdYDjkOQj+HkDto/3+m8eq++zqLF6jDobkvU6p2026O1XjAMgW55na47aCuG+i7wmow
	7wxDIRPYamXcq2U7AuZu6T6wqgRi12D1FdqyjLzWJXU/Jg+YUjj+1E1VTh3RsrxzvpkTEytgZ6C
	6Cifpbec5J0iJGtnOKOoUg6the/JksdKYbANu2MMi+1YEFe6RGbK+l6FH+atKg/44ZrUZYUV9pG
	hP5w8gsl2V3HdPvkUufYUPuN3etZSEAhXcXqoU2yyKEApzNW57UBBVVVjs5Uw0KA5AVLqJNwRWR
	hVFouPIoKnQekZ7I1UHoDUaou85VHrgQScOGtnVLJTh+WEywPK2Fyv3N6QUSnxLm/E0xHeMKTbq
	5cid9P9rRn3EhST6DbSjP8TBUPo0uj5NWgTZjL7nHyAA==
X-Received: by 2002:a05:600c:1f8c:b0:488:abe9:86 with SMTP id 5b1f17b1804b1-48fe631817cmr145344455e9.7.1779198330594;
        Tue, 19 May 2026 06:45:30 -0700 (PDT)
Received: from [172.31.99.185] ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb00e5easm107621965e9.13.2026.05.19.06.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:45:30 -0700 (PDT)
Message-ID: <b8b89071-6f17-4f6a-8a06-101056f780fd@6wind.com>
Date: Tue, 19 May 2026 15:45:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4 devconf
 netlink notifications
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
References: <20260510081528.5257-1-fmancera@suse.de>
 <20260510081528.5257-3-fmancera@suse.de> <20260513193544.47970cb8@kernel.org>
 <bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
 <20260514162429.366b94c9@kernel.org>
 <f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
 <20260515181623.5a44140e@kernel.org>
 <f5cae72f-93c7-41d7-b7db-2b60281afb72@suse.de>
 <20260518142346.4c0903de@kernel.org>
 <54f7f213-9783-42c0-8ae8-51a6b65b7b5d@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <54f7f213-9783-42c0-8ae8-51a6b65b7b5d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-289468-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7FBC557FF2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 19/05/2026 à 09:17, Paolo Abeni a écrit :
> On 5/18/26 11:23 PM, Jakub Kicinski wrote:
>> On Sat, 16 May 2026 09:02:27 +0200 Fernando Fernandez Mancera wrote:
>>>>> Oh sorry, I should have clarified it. ip netconf only shows/query them
>>>>> but it cannot set them AFAICS.
>>>>>
>>>>> Usage: ip netconf show [ dev STRING ]  
>>>>
>>>> Oh, fun. anyway, you gotta find a better way. Or just give up on the
>>>> selftest, the YNL hack is too ugly to live
>>>>   
>>>
>>> Fair, let me see what I can do. Otherwise, Paolo as you requested the 
>>> selftest, would it be acceptable for you to drop it given the situation? 
>>> I looking for alternatives anyway :-)
>>
>> Maybe extend iproute2 ?
> 
> Ideally I think extending iproute2 would be the better solution.
> @Fernando: perhaps you could update the self-test accordingly, adding an
> explicit check for the iproute subcommand. If `ip netconf set` is not
> available skip the test, so that iproute2 patches could land later.
> 
> Does the above look feasible?
FWIW, netconf != devconf.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/ip.h#n156
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/netconf.h

The devconf API exposes all sysctl of an interface via RTM_NEWLINK /
IFLA_AF_SPEC / IFLA_INET_CONF. There is no event when a sysctl changes.
These sysctl can be set via RTM_SETLINK.

The netconf API (RTM_NEWNETCONF) is a notification mechanism used to notify
users when a sysctl changes. It handles sysctl from interfaces but also from the
'all' and the 'default' entries. RTM_GETNETCONF is also supported, but not
RTM_SETNETCONF.

'ip netconf' uses the netconf API.

Regards,
Nicolas

