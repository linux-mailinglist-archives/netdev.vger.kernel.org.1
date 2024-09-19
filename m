Return-Path: <netdev+bounces-128943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6265B97C858
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C3D285E98
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88819A28B;
	Thu, 19 Sep 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="qL4W8wVd"
X-Original-To: netdev@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55469198E93;
	Thu, 19 Sep 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744390; cv=none; b=ae2Q4gx2y9W0XbOHPW9b2mtKBf37mu6yjS8f5eQZqkB/KnYnNgePWF8mQtSFJfMTa+5X+xG7upgYu6BhZmMYhkgXPY/nYzyb7WqsoEe3Ns9jRyQTWr+PgbZt/ZxYmhN9eGJo2MoGJ9exnt/kd8t83A1ZwDKxUrpqCG4e+JXxS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744390; c=relaxed/simple;
	bh=aVfxngTcxye6b+5+j6BICczsRALtI7DZyfHSw/35an8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkhrwC1qa9fkmej0l2LGA+kExwLKT29XuDbn3RYZ7lXDM00AR+OWxYxFttjaSwl2pN5JvlnyMkPCO3dHTtcKd7kb+1w0XBx7CF3C55HiAooxgTxlA2XkPaG4yFq+y6IVQFhnL7dPrLNuj1MgljG/xnRFE84JKDEsPnsVOJtZYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=qL4W8wVd; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1726744383; bh=aVfxngTcxye6b+5+j6BICczsRALtI7DZyfHSw/35an8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qL4W8wVdjifAeYUjrWMSyQzn6jQlXv2sU4UBlP2PG60gSetAUZkZsv37k1jOmBKSE
	 cMEWcQr+fxQMLuBtxekHX5/snwdlk1+o+6EMUcstxEE6p64gXAuUGL/cR+Rfbe0I1i
	 D1iXXj8ems839uqnRizHHbfZcnmBOH4yURWExjyU=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 19 Sep 2024 13:13:03 +0200 (CEST)
Message-ID: <7aa4c66e-d0dc-452f-aebd-eb02a1b15a44@avm.de>
Date: Thu, 19 Sep 2024 13:13:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next] net: bridge: drop packets with a local
 source
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
 <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240919085803.105430-1-tmartitz-oss@avm.de>
 <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
Content-Language: de-DE, en-US
From: Thomas Martitz <tmartitz-oss@avm.de>
In-Reply-To: <934bf1f6-3f1c-4de4-be91-ba1913d1cb0e@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1726744383-ABFFDE44-8C5A106E/0/0
X-purgate-type: clean
X-purgate-size: 2754
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

Am 19.09.24 um 12:33 schrieb Nikolay Aleksandrov:
> On 19/09/2024 11:58, Thomas Martitz wrote:
>> Currently, there is only a warning if a packet enters the bridge
>> that has the bridge's or one port's MAC address as source.
>>
>> Clearly this indicates a network loop (or even spoofing) so we
>> generally do not want to process the packet. Therefore, move the check
>> already done for 802.1x scenarios up and do it unconditionally.
>>
>> For example, a common scenario we see in the field:
>> In a accidental network loop scenario, if an IGMP join
>> loops back to us, it would cause mdb entries to stay indefinitely
>> even if there's no actual join from the outside. Therefore
>> this change can effectively prevent multicast storms, at least
>> for simple loops.
>>
>> Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
>> ---
>>   net/bridge/br_fdb.c   |  4 +---
>>   net/bridge/br_input.c | 17 ++++++++++-------
>>   2 files changed, 11 insertions(+), 10 deletions(-)
>>
> 
> Absolutely not, I'm sorry but we're not all going to take a performance hit
> of an additional lookup because you want to filter src address. You can 
> filter
> it in many ways that won't affect others and don't require kernel changes
> (ebpf, netfilter etc). To a lesser extent there is also the issue where 
> we might
> break some (admittedly weird) setup.
> 

Hello Nikolay,

thanks for taking a look at the patch. I expected concerns, therefore 
the RFC state.

So I understand that performance is your main concern. Some users might
be willing to pay for that cost, however, in exchange for increased
system robustness. May I suggest per-bridge or even per-port flags to
opt-in to this behavior? We'd set this from our userspace. This would
also address the concern to not break weird, existing setups.

This would be analogous to the check added for MAB in 2022
(commit a35ec8e38cdd "bridge: Add MAC Authentication Bypass (MAB) support").

While there are maybe other methods, only in the bridge code I may
access the resulting FDB to test for the BR_FDB_LOCAL flag. There's
typically not only a single MAC adress to check for, but such a local
FDB is maintained for the enslaved port's MACs as well. Replicating
the check outside of the bridge receive code would be orders more
complex. For example, you need to update the filter each time a port is
added or removed from the bridge.

Since a very similar check exists already using a per-port opt-in flag,
would a similar approach acceptable for you? If yes, I'd send a
follow-up shortly.

PS: I haven't spottet you, but in case you're at LPC in Vienna we can
chat in person about it, I'm here.

Best regards.


> Cheers,
>   Nik
> 


