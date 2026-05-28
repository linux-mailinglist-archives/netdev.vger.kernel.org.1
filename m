Return-Path: <netdev+bounces-292702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDUfLYhNGGomiwgAu9opvQ
	(envelope-from <netdev+bounces-292702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:13:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513E5F37BF
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E11730804F1
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8215285C91;
	Thu, 28 May 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="h4K1jIWk"
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A7282F09
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976986; cv=none; b=mxmzjGb5bYRZEczZgIey97Fhwqr4ejGgq/V4UQi6YSZ9SCzz4C73OlbWEwMKkD3xgYF03WEmuJDWvHAEmpHGyq8vRicXF9O4A5daU4V8dse0P5stF8dQT06jiEhbSGQ4SGKxhrKn7n+ADVT8OT8q1hfNqYetlelogf20JBkdbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976986; c=relaxed/simple;
	bh=kZ3olwqP0S+mcZKNEUbMnN/vuJVOB9UNWHQ+IN5erh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJwDjAtRyzm+UhVtxUttfzLW6KXa4bjEtJ64InJSHRRsCfpCYaJyCJe+r8NFukzVM+Z/ZAE7QEXQz6aIqzm3BbMjsFWm0espNa17uLTzheNZuevqAiRsUUSIneQQUrN89JOI8b1o35eB9igjvIXXqoYJ1H4bsplh/DG8oiIneYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=h4K1jIWk; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gR7VS71cGz8fTj;
	Thu, 28 May 2026 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779976977;
	bh=kZ3olwqP0S+mcZKNEUbMnN/vuJVOB9UNWHQ+IN5erh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h4K1jIWkV8ffq7pP/BxsjkBzjvLqG/YIpsLPBuVrAU/0Fpkk0RZ0j4npKO520Wylq
	 xRghI1P96Zhmr7InLyqYZvmmsdTzu3EAZU/oCZNFJT4JWHmTKEi9NX29j3LS4MidPp
	 ovw/gGSoeEQ28BdqKQi/SITXEQbfvFX2s/qFu0g7ixus/HTzjtDf17eDs2w7w7j8tf
	 N57DngVIQsVkdDBBZe5xo/atNh8e4MHAnW4OovabKHWs7SWa3gDPlXW12NBWb6YVQ/
	 seUOFXULpdh5KRjDn89iHT3BCjhsg2CVVtIo7YLQVmPUa9MHvUMzIkazT2cH21uJ49
	 qciAkDDnK1QVw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gR7VS6H2tz8fSf;
	Thu, 28 May 2026 14:02:56 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gR7VS0JRVz8sZd;
	Thu, 28 May 2026 16:02:54 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 838C260345;
	Thu, 28 May 2026 16:02:47 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <80f517c8-8daa-4126-b9b9-f23eba8cfbdc@leemhuis.info>
Date: Thu, 28 May 2026 16:02:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with IPv6 privacy addresses in 7.0
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Justin Iurman <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>,
 David Gibson <david@gibson.dropbear.id.au>, ihuguet@redhat.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260521135310.GC977@cmadams.net>
 <20260526175743.1f2c3761@kernel.org> <20260527010641.GA21073@cmadams.net>
 <20260526183122.348e44e7@kernel.org> <20260527215135.GB16443@cmadams.net>
 <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth>
 <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
 <20260528131250.1352ab48@elisabeth>
 <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
 <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
 <20260528153202.14900687@elisabeth>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260528153202.14900687@elisabeth>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177997696797.895729.11924838714779855892@mxe9fb.netcup.net>
X-NC-CID: tmXDwoIlLybsVv9Ko5WTER0ZpYVgqykSePmxZbMe8/YpuYIhHig=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292702-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,leemhuis.info:email,leemhuis.info:mid,leemhuis.info:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1513E5F37BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 15:32, Stefano Brivio wrote:
> On Thu, 28 May 2026 14:29:50 +0200
> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
>> On 5/28/26 13:29, Fernando Fernandez Mancera wrote:
>>> On 5/28/26 1:12 PM, Stefano Brivio wrote:  
>>>> On Thu, 28 May 2026 12:46:05 +0200
>>>> Fernando Fernandez Mancera <fmancera@suse.de> wrote:  
>>>>> On 5/28/26 7:38 AM, Stefano Brivio wrote:  

>> But there are ways to fix even this, it's just that most of them are
>> ugly. Like adding some bit somewhere to /proc/ or so that a fixed
>> NetworkManager (if it's the only affected app) could flip by default to
>> change the things from the old behavior to the new one; and one pasta
>> could check that bit and warn. Config options are also an option, but
>> that's even uglier.
> 
> Actually, an eventually fixed version of NetworkManager doesn't need to
> know the behaviour of the kernel: it can just order addresses by
> timestamps instead, as Fernando mentioned.

Sure, but the trick I tried to describe is: NetworkManager knows it can
handle the new way of things (and thus avoid the regression the reporter
described at the start of the thread) and thus could at boot time tell
the kernel that by changing some bit in /proc/ -- and make it switch
from the old to the new order, so that pasta will then do the right
thing, too.

But as I said: ugly, even if that uglyness can be removed after a few years.

> Are you suggesting that we
> should anyway try to minimise the temporal impact of this with a revert?

I'd like to leave judgement here to the network maintainers, they are
better equipped to make judgment calls like this.

Ciao, Thorsten

