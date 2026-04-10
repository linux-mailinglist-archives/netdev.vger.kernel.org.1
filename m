Return-Path: <netdev+bounces-277496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FpiJjQw2WkOnQgAu9opvQ
	(envelope-from <netdev+bounces-277496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:15:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E33DAF45
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 899063003712
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD633E123C;
	Fri, 10 Apr 2026 17:15:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trinity3.trinnet.net (trinity.trinnet.net [96.78.144.185])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EB93E0C57;
	Fri, 10 Apr 2026 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.78.144.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841324; cv=none; b=kWzntigof6bsMqsytGZM8WDY/vMUuu1JGQNOzz9y/FDsIdAemkoAX1csnf78emyQJe1Xg6z4MEJiwLVYYc0k4JFHq4Z51SLJHCNRA0/Y7Xno2UtxASKeAqQHFWVEk/WB2OschRs/T7FcIj3bHFODNa7KlTImyZJLvRQqF8/Jf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841324; c=relaxed/simple;
	bh=jCIgsDRilv7KIqAd1L2z7WRRBTaNL4Em2+kHrNaLTG0=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EyzxGgfC/fvKb4Hu+kd4G61nZttmGbSk+/yL82L5HR+3sXMyYt8eaOJ8p6via8Mh1abQ7OG5fbVGXyk+rRzkP1izc8NZhBByRZ4a3FDHViGbwN+gHV+6cHhy2r28Jm+ign8UDVBT9bvGPlAnVbdytjk4fhuGpTH9NVWJcmzFw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trinnet.net; spf=pass smtp.mailfrom=trinnet.net; arc=none smtp.client-ip=96.78.144.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trinnet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trinnet.net
Received: from trinity4.trinnet.net (trinity4.trinnet.net [192.168.0.11])
	by trinity3.trinnet.net (TrinityOS hardened/8.15.2) with ESMTP id 63AGcPw0019678;
	Fri, 10 Apr 2026 09:38:25 -0700
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming
 frames
To: jj <ve1jot@eastlink.ca>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2026040730-untagged-groin-bbb7@gregkh>
 <20260409190328.GS469338@kernel.org> <20260409203235.6b9329f0@kernel.org>
 <2026041026-excuse-slashing-c4ee@gregkh> <20260410102827.GT469338@kernel.org>
 <18e3df62-34f9-4de0-903b-19919d7ae2ca@eastlink.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>,
        stable <stable@kernel.org>, "Bernard, f6bvp" <f6bvp@free.fr>
From: David Ranch <linux-hams@trinnet.net>
Message-ID: <2e0f1dca-56dc-d6e6-f4d4-1de3160e0179@trinnet.net>
Date: Fri, 10 Apr 2026 09:38:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <18e3df62-34f9-4de0-903b-19919d7ae2ca@eastlink.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[trinnet.net : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,darknavy.com,free.fr];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277496-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-hams@trinnet.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trinnet.net:mid]
X-Rspamd-Queue-Id: 947E33DAF45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


I agree with John VE1JOT that amateur radio protocols such as AX25, 
NETROM, and ROSE are still very active in the Linux kernel.  This 
discussion makes me wonder how the Linux kernel community judges how 
"active" a given feature / driver / etc is being used in the real world 
before considering deprecation.  If there is an official mechanism to 
get metrics sent from users back to the kernel developer community, 
please let us know and we'll try to get you some one-off or periodic 
metrics.

--David
KI6ZHD
Avid AX.25 and NETROM packet radio on X86 and ARM-based Raspberry Pi
https://www.trinityos.com/HAM/index-ham.html


On 04/10/2026 08:12 AM, jj wrote:
> This is NOT an obsolete protocol..this is in use by amateur radio 
> operators world-wide...we use it for RF comms usually, because what 
> happens if the internet goes "down", we can still provide comms over 
> slower RF links....(plus it's a fun mode)please PLEASE do not 
> drop...and sorry for the noise...
>
> de John VE1JOT
>
> On 2026-04-10 07:28, Simon Horman wrote:
>> On Fri, Apr 10, 2026 at 07:24:36AM +0200, Greg Kroah-Hartman wrote:
>>> On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
>>>> On Thu, 9 Apr 2026 20:03:28 +0100 Simon Horman wrote:
>>>>> I expect that checking skb->len isn't sufficient here
>>>>> and pskb_may_pull needs to be used to ensure that
>>>>> the data is also available in the linear section of the skb.
>>>> Or for simplicity we could also be testing against skb_headlen()
>>>> since we don't expect any legit non-linear frames here? Dunno.
>> Sure, that's find by me if it leads to simpler code than
>> using pskb_may_pull(). Else I'd lean towards pskb_may_pull()
>> as it is a more general approach that feels worth proliferating.
>>
>>> I'll be glad to change this either way, your call.  Given that this is
>>> an obsolete protocol that seems to only be a target for drive-by 
>>> fuzzers
>>> to attack, whatever the simplest thing to do to quiet them up I'll be
>>> glad to implement.
>>>
>>> Or can we just delete this stuff entirely?  :)
>> Deleting sounds good to me.
>> But we likely need a deprecation process.
>> In which case fixing these bugs still makes sense for the short term.
>>


