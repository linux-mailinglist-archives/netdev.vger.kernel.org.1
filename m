Return-Path: <netdev+bounces-257248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA5BJ+3EhGk45QMAu9opvQ
	(envelope-from <netdev+bounces-257248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:27:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BB4F5361
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3748D301A515
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D6A426D05;
	Thu,  5 Feb 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BeTe8UR1"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31957426D0B
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308840; cv=none; b=RzwFKO4/zr1OdZjpS/TfHJgYHT0gNS+scOQ9weGVf/LKa2zNxssQzhFfYWORCoj7iw8rRP7TQa1bCBrsIFfo3kGyBPDdRhd/lHhI++42g6aOXMfJTs/EFNUh/TVjPTf1sEKKNU8HktQ9hVSmxQYM6d1eg3sYA1MZz5KB1lrFDds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308840; c=relaxed/simple;
	bh=e3Mh4cqPyjgeMUHDkKjgumrwqhe3d4J1EQPV/2Qpmlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVbd4s938cmiYJKTIE4/YbL9MNkCbDUIpcs5T5IgBwgtnYpHMVIZWlQVTZUQU4qaIKaoVMReXdsjQiQ8Onk1zPy+/WQy36hpRKYREPtyXmp6hgtCq0qJ1WCuFs9nYuAXtfV/7CdhypsvUdEG7dwDbBsq0Ea7q5ZKJZHx6TU0Xmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BeTe8UR1; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770308828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ET/qeIEpwmI/Es2elWLSYLqXMVH7pqog+cxAo+h7unM=;
	b=BeTe8UR1CL3v7CzRECCoz4879yHxH8spUWym3MIX+VYLz/P/y3rXxHSDBxMVnCyGqA+Ix8
	g9Fh+B4lgqMmtuIOQiSsruwLH48OsRuEUzzrnRm8D03KbfoO3qlP+2z6RjOIWZ5o4LZ08r
	q5ewL6Vp32VAGbWCY7l5UM3+34J9F/w=
Date: Thu, 5 Feb 2026 16:27:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260205145104.iWinkXHv@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,google.com,lists.osuosl.org,kernel.org,redhat.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27BB4F5361
X-Rspamd-Action: no action

On 05/02/2026 14:51, Sebastian Andrzej Siewior wrote:
> On 2026-02-05 11:56:44 [+0000], Vadim Fedorenko wrote:
>> On 05/02/2026 10:37, Loktionov, Aleksandr wrote:
>>> spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep
>>
>> Hmm... that actually means we have some drivers broken for RT kernels if
>> they are processing TX timestamps within a single irq vector:
>> - hisilicon/hns3
>> - intel/i40e (and ice probably)
>> - marvell/mvpp2
>>
>> For igb/igc/i40e it's still OK to process TX timestamps directly in
>> MSI-X configuration, as ring processing has separate vector, right?
> 
> The statement made above is not accurate. Each and every driver does
> request_irq() and here on PREEMPT_RT you can freely acquire spinlock_t.
> 
> But !RT looks problematic…
> 
> __skb_tstamp_tx() invokes skb_may_tx_timestamp() which should exit early
> most of the time due to the passed bool (which is true) or
> sysctl_tstamp_allow_data which is true. However, should both be false
> then it tries to
> 	read_lock_bh(&sk->sk_callback_lock);
> 
> where lockdep will complain because this lock is now acquired with
> disabled interrupts.
> 
> The function will attempt do free the fresh/ cloned skb in error case
> via kfree_skb(). Since it is fresh skb, sk_buff::destructor is NULL and
> the warning in skb_release_head_state() won't trigger.
> 
> So the only thing that bothers me is the read_lock_bh() in
> skb_may_tx_timestamp() which deadlocks if the socket is write-locked on
> the same CPU.

Alright. Now you make me think whether we should enforce OPT_TSONLY
option on socket which doesn't have CAP_NET_RAW? Then we can get rid of 
this check, and in case sysctl was flipped off - drop TX timestamps as
it's done now?


