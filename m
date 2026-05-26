Return-Path: <netdev+bounces-291673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHm1CVeJFWqGWQcAu9opvQ
	(envelope-from <netdev+bounces-291673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:51:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E07805D52A4
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FE1130008B9
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7707D3F5BEE;
	Tue, 26 May 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oCmtTKVj"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E23F075A
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796285; cv=none; b=sp1UjMmfcYEVLBhi/nvKX7Lnxdm6trdSAglQ8SruDvE9dHVu8Xt5iFQg1gkGqyIHiichHk37upmtXwcn9vRALB0ea1zxi9EE5zSdQck1RGmSWCRywxnYUEXrIQt3Gyyt1ElWsO5NnNnqzZXkYzA2k365KHk2UronGTT4ufxVbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796285; c=relaxed/simple;
	bh=KeGWwolcFFEH6R7fa5T0IRDv6gq2FEjg9XB7oEUZrJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEGDpfqNEDXbGefvzPEVG6UmgRg3VoqUTqUSEvhpwJLjnkNLH+jnPJFt0ZxhJ2PMRbtL5LkleC0YuuLJH2AwTC1hVxTer+F6u74c3tU+DvDoZ6r+eWqf7iU2Zmz7AgAWpdj1vHmKcCY68VyNo3fFLZBumI0lVBLg63MnP8SGipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oCmtTKVj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c51fabe-5524-4857-8f23-b351f5e63e10@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779796276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=seoM7xwshPL+GdQa7xndfUCJxVw7uD12en9S/jPI/GI=;
	b=oCmtTKVjd5G6szWT7UR5qToOxE5sP4P2xAdpHNVURpzolULiQ1BxKuqrQC90ioLiGxDx0A
	weJ37QJhm3sjpt+XcY3weljsY+xetVNb0F+NvqeIv5hsDlUB4MfYpResfcaWxkgaAhGnTF
	ZIOFvr+mOdRP2hXt6JYQ4C/7+LOVl/A=
Date: Tue, 26 May 2026 12:51:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] xfrm: move policy_bydst RCU sync from per-netns .exit to
 .pre_exit
To: Steffen Klassert <steffen.klassert@secunet.com>, stable@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com,
 Herbert Xu <herbert@gondor.apana.org.au>, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 alexanderduyck@fb.com, enewton@meta.com, vlad.wing@gmail.com
References: <20260521102926.2613544-1-usama.arif@linux.dev>
 <ahV1BxasOuDHX7Zy@secunet.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <ahV1BxasOuDHX7Zy@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,gondor.apana.org.au,kernel.org,vger.kernel.org,redhat.com,fb.com,meta.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-291673-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E07805D52A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/05/2026 11:25, Steffen Klassert wrote:
> On Thu, May 21, 2026 at 03:29:26AM -0700, Usama Arif wrote:
>> The struct pernet_operations docstring in include/net/net_namespace.h
>> explicitly warns against blocking RCU primitives in .exit handlers:
>>
>>     Exit methods using blocking RCU primitives, such as
>>     synchronize_rcu(), should be implemented via exit_batch.
>>     [...]
>>     Please, avoid synchronize_rcu() at all, where it's possible.
>>
>>     Note that a combination of pre_exit() and exit() can
>>     be used, since a synchronize_rcu() is guaranteed between
>>     the calls.
>>
>> xfrm_policy_fini() violates this: it calls synchronize_rcu() before
>> freeing the policy_bydst hash tables (so no RCU reader is mid-
>> traversal at free time), but runs from xfrm_net_ops.exit -- once per
>> namespace -- so a cleanup_net() of N namespaces pays N full RCU
>> grace periods serially.
>>
>> Use the documented pre_exit/exit split. Move the policy flush (and
>> the workqueue drains it depends on) into a new .pre_exit handler;
>> xfrm_policy_fini() then runs in .exit and frees the hash tables
>> after the synchronize_rcu_expedited() that cleanup_net() guarantees
>> between the two phases. Providing O(1) RCU grace periods per batch
>> instead of O(N).
>>
>> Observed on Linux 6.18 with a workload doing unshare(CLONE_NEWNET)
>> at ~13/sec sustained: cleanup_net() and the netns_wq rescuer kthread
>> both stuck in xfrm_policy_fini()'s synchronize_rcu(), >300k struct
>> net accumulated in the cleanup queue, Percpu in /proc/meminfo climbed
>> to 130+ GB on 256-CPU hosts, and memcg OOMs followed. setup_net and
>> __put_net counts were balanced, ruling out a refcount leak.
>>
>> Fixes: 069daad4f2ae ("xfrm: Wait for RCU readers during policy netns exit")
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> 
> Applied, thanks Usama!


Thanks! Forgot to cc stable@vger.kernel.org

Adding it here 

