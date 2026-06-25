Return-Path: <netdev+bounces-302016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g1WUDYpPPWpp1AgAu9opvQ
	(envelope-from <netdev+bounces-302016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:55:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A03806C7347
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:55:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RZ1GBGiR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302016-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302016-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9780B30B8C9F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4D931AAA3;
	Thu, 25 Jun 2026 15:54:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6E26E173
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:54:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402875; cv=none; b=Y/sh1I7TNWwKkVnTGkmOIPm1BcVX9h+YT5OYrNgjzgfV+g+J4DMSeiehhDAJ5oNKbOGFjLJWva0o40c+3/5rlQpgkvuJv+GwXD6KWmTeWPd1hGAOJb5/oZAiU1uBJoMhlI7RRJdMrGAmSU+714AMZXPo30dv8r4XgK2e/PmS/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402875; c=relaxed/simple;
	bh=GjibqhTRoSMwtT2rQf8/YwUCCraZ5cjmIu/wmd8c/uY=;
	h=Message-ID:Date:MIME-Version:Subject:From:Cc:References:
	 In-Reply-To:Content-Type; b=AgqqWs6QDlEnC+le9mo6j7uWk3tEhwBTxNz/RxuW60nkZW5RMW6vNyev5qXHSwmN8C6J5zojatLJvatxKZl56KtbnEFgOrVgi2X0gJbg/xLqcwx3qHQVYx3j4y5WK2yD4ahENR27s5ZdeZ8JC5qqrLGfYwoYZjVDHAsdmrwgn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ1GBGiR; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4627adcf4d6so1888309f8f.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782402872; x=1783007672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r11YPBeFUMC/ykhviZOTZPIZ364dxZdsWoCdVPJYmuw=;
        b=RZ1GBGiRE/nozlrNcIh9AsgEV1qo/O/2GviCrTxteM39GPuzlxEUboYaqzdx7E0wMB
         IzMNQp4JYCjVHiel972AT4vemkz7bZ0Q21ARzxxx8IfwZnfrwej5v09pmf3wzPWxE2lM
         ldr8Xb/qWYqCpS71Z4NyTx5MKdT4ugPQvME3gUfBWQPv9VaovOU9nB8pygTzLCsepI7Y
         Cr8bSaULQSk9ljrH+54+FO0kldl6Ub9/ARocLAz8gVOCHeW3wCdfk3jW1Rv1O9aZsMer
         YsptXDikunyAESsRSnn5rGJJMm7eCRzJ4Caj9k6v1gDVoIMHqPmlO5SZ6s3pwq3in/fv
         /vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782402872; x=1783007672;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r11YPBeFUMC/ykhviZOTZPIZ364dxZdsWoCdVPJYmuw=;
        b=SFHxSe6KDH0+B5avy7+GKqzHTmC1XYCseoN6Mujy3YGUkURGcPAQfaUMdkKQAVyrru
         ndgmN9GR/gmID7JWujDK7dVyXyMNlpkzoVa5YqEHb7vWTHvY0el6VOJPn2txHg2/Lzkg
         b2NcN4FS1eE/ynRP0v9ATTpPDMJKks0mdpJoL4QeWZtdj1/mIkjAfLvnOU9vRyX/rPwr
         EiVqyRGloMMJfQLMjpfTQUkSTlx1EJWfnIDhmjPGyJFIxcox/uPrV46pvvOHpEB57ca5
         bIMHkxzISL2WmEZUcYHSqwDdaih1BqmOBBcnmurUQVQjIt066d3Mnb6nBg+QhhxZ0D1+
         xFTg==
X-Gm-Message-State: AOJu0YxPGpDpS7F5fEMwzKAdZL8gnsRGotddFPG5lJpbV5MtL3XCmhg8
	y7Xdiu0zi5iC0mEQ1Fxi8e95SHscAfON+9mCTSJbC2YSZ4iLdqQCUcVwSB7YsoW6
X-Gm-Gg: AfdE7cm6exuVpRfFhNDExzyVbZGbRbsE2luhOLhZsFpDaytapWXE5XY3bL1iNkNMRm0
	bTk1cVLxiZf9RUGTPVqTj4tmPtAI1u0P39zS/FjekthyuNsYVsIM+Jo49bnkrj3aO2es/bJ8Me3
	5zeKcwWM2Hsz1g2W26RN00BEFkUakZTR633KL8rFseafFAJNKTc/kKk8FPm4kWhbn6ApJkNK0uO
	JV93vOWwgrJ4eS+aarFBh43PDNwZ4V3xI8OYxa4QY9HqBMKd0/AKpDyn+b1A9ugrQpVgVmP00GP
	NOaOaABfmrBF9Ote4AfsgfRzde+M6tJnocRRRKYf+tBF66rkLKzFRYIFOFT/wt2GuFipswNOytU
	XYsu48Pw0Zt5tW/gnPuUvSYin7g813/MOjeKi+nOO3vHvbzwLsgTup61n7y17euPho+LuRkgxsb
	xqUI13jkriEERF4QHMfpOaKauJHOX8JWneK996eX6xJmw/I40DLvfx4MU=
X-Received: by 2002:a05:6000:220e:b0:46e:878c:9194 with SMTP id ffacd0b85a97d-46e879bd418mr960662f8f.32.1782402872265;
        Thu, 25 Jun 2026 08:54:32 -0700 (PDT)
Received: from ?IPV6:2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4? ([2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9405sm18758152f8f.22.2026.06.25.08.54.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 08:54:31 -0700 (PDT)
Message-ID: <65f53987-c992-41b9-9603-9e9a448e469d@gmail.com>
Date: Thu, 25 Jun 2026 16:54:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] "ip help" wrong output, exit code.
From: Dmitri Seletski <drjoms@gmail.com>
Cc: netdev@vger.kernel.org
References: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
 <20260621082105.1196ef72@phoenix.local>
 <069b13e1-f689-410b-bd40-b5e5831b67e7@gmail.com>
 <20260622075700.27806286@phoenix.local> <20260622174454.576b3580@pumpkin>
 <3d6f256c-3bd0-441a-bece-8692985c5ddc@gmail.com>
Content-Language: en-US
In-Reply-To: <3d6f256c-3bd0-441a-bece-8692985c5ddc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[drjoms@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-302016-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[drjoms@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A03806C7347

I am confused.

Whats the next step here?

Regards

Dmitri

On 6/22/26 18:47, Dmitri Seletski wrote:
> Hello David,
>
>
> Based on change introduced:
>
> Two samples of "ip help" with demonstration of exit code and standard 
> output are below.
>
> This is in line with what expect.
>
>
> dimkosPC~/compiled/iproute2-next #if ./ip/ip help a >>/dev/null  ; 
> then echo help triggered  ; else echo error code triggered  ;fi  #this 
> redirects standard output  to /dev/null, so text missing is not error,
> but standard text
> help triggered
>
> dimkosPC~/compiled/iproute2-next #if ./ip/ip help   ; then echo help 
> triggered  ; else echo error code triggered  ;fi
> Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
>       ip [ -force ] -batch filename
> where  OBJECT := { address | addrlabel | fou | help | ila | ioam | 
> l2tp | link |
>                   macsec | maddress | monitor | mptcp | mroute | mrule |
>                   neighbor | neighbour | netconf | netns | nexthop | 
> ntable |
>                   ntbl | route | rule | sr | stats | tap | tcpmetrics |
>                   token | tunnel | tuntap | vrf | xfrm }
>       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |
>                    -h[uman-readable] | -iec | -j[son] | -p[retty] |
>                    -f[amily] { inet | inet6 | mpls | bridge | link } |
>                    -4 | -6 | -M | -B | -0 |
>                    -l[oops] { maximum-addr-flush-attempts } | -echo | 
> -br[ief] |
>                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] 
> [filename] |
>                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] | 
> -a[ll] |
>                    -c[olor]}
> help triggered
>
> Two samples of command that is broken on purpose.
>
> dimkosPC~/compiled/iproute2-next #if ./ip/ip idontexist   ; then echo 
> help triggered  ; else echo error code triggered  ;fi
> Object "idontexist" is unknown, try "ip help".
> error code triggered
>
> dimkosPC~/compiled/iproute2-next #if ./ip/ip idontexist  >>/dev/null 
>  ; then echo help triggered  ; else echo error code triggered  ;fi 
>  #this redirects standard output  to /dev/null, so text missing is not 
> error, but standard text
> Object "idontexist" is unknown, try "ip help".
> error code triggered
>
> This works as expected as per my understanding.
>
>
> Not everything is fixed, but chunk of things fixed is better than non 
> of it.
>
> for example:
>
> if ip  add help    ; then echo help triggered  ; else echo error code 
> triggered  ;fi  #this redirects standard output  to /dev/null, so text 
> missing is not error, but standard text
> Usage: ip address {add|change|replace} IFADDR dev IFNAME [ LIFETIME ]
>                                                      [ CONFFLAG-LIST ]
>       ip address del IFADDR dev IFNAME [mngtmpaddr]
>       ip address {save|flush} [ dev IFNAME ] [ scope SCOPE-ID ] [ to 
> PREFIX ]
>                            [ FLAG-LIST ] [ label LABEL ] [ { up | down 
> } ]
>       ip address [ show [ dev IFNAME ] [ scope SCOPE-ID ] [ master 
> DEVICE ]
>                         [ nomaster ]
>                         [ type TYPE ] [ to PREFIX ] [ FLAG-LIST ]
>                         [ label LABEL ] [ { up | down } ] [ vrf NAME ]
>                         [ proto ADDRPROTO ] ]
>       ip address {showdump|restore}
> IFADDR := PREFIX | ADDR peer PREFIX
>          [ broadcast ADDR ] [ anycast ADDR ]
>          [ label IFNAME ] [ scope SCOPE-ID ] [ metric METRIC ]
>          [ proto ADDRPROTO ]
> SCOPE-ID := [ host | link | global | NUMBER ]
> FLAG-LIST := [ FLAG-LIST ] FLAG
> FLAG  := [ permanent | dynamic | secondary | primary |
>           [-]tentative | [-]deprecated | [-]dadfailed | temporary |
>           CONFFLAG-LIST ]
> CONFFLAG-LIST := [ CONFFLAG-LIST ] CONFFLAG
> CONFFLAG  := [ home | nodad | mngtmpaddr | noprefixroute | autojoin ]
> LIFETIME := [ valid_lft LFT ] [ preferred_lft LFT ]
> LFT := forever | SECONDS
> ADDRPROTO := [ NAME | NUMBER ]
> TYPE := { amt | bareudp | bond | bond_slave | bridge | bridge_slave |
>          dsa | dummy | erspan | geneve | gre | gretap | gtp | hsr |
>          ifb | ip6erspan | ip6gre | ip6gretap | ip6tnl |
>          ipip | ipoib | ipvlan | ipvtap |
>          macsec | macvlan | macvtap | netdevsim |
>          netkit | nlmon | pfcp | rmnet | sit | team | team_slave |
>          vcan | veth | vlan | vrf | vti | vxcan | vxlan | wwan |
>          xfrm | virt_wifi }
> error code triggered
>
> This is still problematic.
>
>
> But so far code leaves "ip help" command/argument in better shape than 
> it found it in.
>
>
> I may try improve things more, but lets submit what we already have 
> "better", please.
>
> Kind Regards
>
> Dmitri Seletski
>
>
> On 6/22/26 17:44, David Laight wrote:
>> On Mon, 22 Jun 2026 07:57:00 -0700
>> Stephen Hemminger <stephen@networkplumber.org> wrote:
>>
>>> On Sun, 21 Jun 2026 22:48:59 +0100
>>> Dmitri Seletski <drjoms@gmail.com> wrote:
>>>
>>>>  From 0805e07105cd15c5b94271a4706e50e3c65dbde5 Mon Sep 17 00:00:00 
>>>> 2001
>>>> From: Dmitri Seletski <drjoms@gmail.com>
>>>> Date: Sun, 21 Jun 2026 22:12:43 +0100
>>>> Subject: [PATCH iproute2-next]  "ip help" wrong output, exit code.
>>>>
>>>> Changed output of "ip help" from standard error to standard output. 
>>>> And
>>>> Exit is now 0 instead of -1. "ip help|grep bridge" - now gives bridge
>>>> syntax instead of flooding user with everything from "ip help".
>>>> ---
>>>> ip/ip.c | 4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/ip/ip.c b/ip/ip.c
>>>> index e4b71bde..4627b61c 100644
>>>> --- a/ip/ip.c
>>>> +++ b/ip/ip.c
>>>> @@ -56,7 +56,7 @@ static void usage(void) __attribute__((noreturn));
>>>>
>>>> static void usage(void)
>>>> {
>>>> -fprintf(stderr,
>>>> +fprintf(stdout,
>>>> "Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }\n"
>>>> "       ip [ -force ] -batch filename\n"
>>>> "where  OBJECT := { address | addrlabel | fou | help | ila | ioam | 
>>>> l2tp
>>>> | link |\n"
>>>> @@ -72,7 +72,7 @@ static void usage(void)
>>>> "                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch]
>>>> [filename] |\n"
>>>> "                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] |
>>>> -a[ll] |\n"
>>>> "                    -c[olor]}\n");
>>>> -exit(-1);
>>>> +exit(0);
>>>> }
>>> Your mailer damages white space.
>>>
>> The output also needs to depend on whether these is a 'usage' error or
>> if 'help' is requested.
>> Code code is correct for the former - except it should do exit(1).
>>
>>     David
>>
>>

