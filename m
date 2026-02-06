Return-Path: <netdev+bounces-257515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNKhJIG+hWnEFwQAu9opvQ
	(envelope-from <netdev+bounces-257515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:12:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C8FC88E
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF10C300853F
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B854361667;
	Fri,  6 Feb 2026 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s1hZQdPC"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641534BA56
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372734; cv=none; b=pHnXuPa+fH5VxZrkKjULTq3bRZRdkmiwhL4iYWX/TJ/f9LBZZjpqMr6ZAn1AOOKSosxhWakDmLaLX0iYOnzyC/MQpd5YH7TetpxCWolU0447t9eMydDIa0aejvztHsunDXh4+Ktsa4+xqxdsjp7s/LRUIsMFczh4nTRUcO2LZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372734; c=relaxed/simple;
	bh=HvdRmzw1qTvrLbyWBS3sDsuy7TpzPvVFaI83A0h49+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFCIQ9y++Kgr3jV8u5Is4OqCgOMtOqRcs0SMXrLjCJ6StulIIsYRMYd8Sl/BoQFsaHpZpw9YIQ0iBYpYYWyFI35ZjiOxwK4v9fA/MsqMXU6t+jdaLmy7cm27Wz3QqbMP2j+r4h1HUZvtQMkyaskfDSPquXjcUl8VGNQfqA1Ovao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s1hZQdPC; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770372731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhaAgJyKGpAxu69onmTYpr1zMQl+4LY07Xc1GM3wQlQ=;
	b=s1hZQdPCFE8qhcU9pfJ34OOPrLOGMEaldYRioPOYeFAwkarsS9aJKjFZe1mnuBWM0/mgEF
	XMpM54KSCIaU4FlVnTqz3BzQBbPXVzzhVsYng3GqfFD+5XsqR/WpfOLetaMX15ajsu6wT+
	P0mlT45JQxV26mer0sXRaGq9c0djpU0=
Date: Fri, 6 Feb 2026 10:12:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <willemdebruijn.kernel.459b2672b1e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257515-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,linutronix.de,google.com,kernel.org,redhat.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D04C8FC88E
X-Rspamd-Action: no action

On 05.02.2026 21:41, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> On 05/02/2026 16:43, Sebastian Andrzej Siewior wrote:
>>> On 2026-02-05 16:27:03 [+0000], Vadim Fedorenko wrote:
>>>>> So the only thing that bothers me is the read_lock_bh() in
>>>>> skb_may_tx_timestamp() which deadlocks if the socket is write-locked on
>>>>> the same CPU.
>>>>
>>>> Alright. Now you make me think whether we should enforce OPT_TSONLY
>>>> option on socket which doesn't have CAP_NET_RAW? Then we can get rid of this
>>>> check, and in case sysctl was flipped off - drop TX timestamps as
>>>> it's done now?
>>>
>>> This would "fix" this problem for all users which do deliver the
>>> timestamp from their IRQ handler instead of napi. There are a few of
>>> those…
>>> This would be considered stable material, right? (despite the fact that
>>> we have it for quite some time and nobody complained so far).
>>
>> cc: Willem as he is the author of the check introduced back in 2015.
>>
>> But it's more like a question to maintainers whether it is acceptable
>> way of "fixing" drivers or it's no-go solution
> 
> Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.

Well, they are kinda broken already. Without OPT_TSONLY and CAP_NET_RAW all TX
timestamps are silently dropped. To receive these timestamps users have to get
CAP_NET_RAW permission, and it will work with the updated logic as well...

