Return-Path: <netdev+bounces-269295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GApDLPB3u2lvkgIAu9opvQ
	(envelope-from <netdev+bounces-269295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:13:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5152C5D5B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48EE63018AF7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018492882C5;
	Thu, 19 Mar 2026 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eBD2Na3y"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E052D060D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893597; cv=none; b=k556NOQ3BeVRdPo74VwRx4xObfZlnOoNlSf9tTqgcE/jGQ2F/lmRIqlbNfilLG2/bKSyQMzdCLPI/tEpjm+1l9kHCp7qiAA5OewFgoerEhwjBq+peze6uaIXDGqkGgxwmldLlqlv27FL99ndvubcQDEtX3vuhxkN+1zvLl2gxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893597; c=relaxed/simple;
	bh=ChUgWajoz59HV8j691dH8bdso6d00BwoboF6iy4g0OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbwseCxoooCn3rCb/qAPqqPc3Pd/9qrVv9AhEoTtUng3codewcKY++pGyX7Nka+Qeyupmgss/yZY4tcIJeRyEcDHE2PghScTe9GFX8uNHaTukc71r+bVq2ip7XrXrnr66S80ZJzdQt/h2mFuH+JXXw19TYeGxOPZru9cL7jr+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eBD2Na3y; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed6f017d-4c5a-4fe3-aa3d-c8ed24f1e74e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773893593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ChUgWajoz59HV8j691dH8bdso6d00BwoboF6iy4g0OM=;
	b=eBD2Na3ysuTCkriXf3Fyihw3UK3XaQrUcC/wvOt3pclDZr2Am2ScBg4gHSvmjQIK4JVXQD
	8UV64NAXzAc2b2EXXtI23BJVDzW2qyiIHJIBCiwR/Zr6Besuvpj0x1n3GBo+3iEonGaLzL
	+EXh5LcvsO3WNJUCwxn/HqaWFREKTXU=
Date: Thu, 19 Mar 2026 12:12:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net/ipv6: mcast: fix circular locking dependency
 in __ipv6_dev_mc_inc()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260317111208.62667-1-jiayuan.chen@linux.dev>
 <20260318181536.47ed9fd1@kernel.org>
 <f877e139-2da9-49d9-93bf-9b4155d687a7@linux.dev>
 <20260318202649.004d33fd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260318202649.004d33fd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-269295-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,afbcf622635e98bf40d2];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: BF5152C5D5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/19/26 11:26 AM, Jakub Kicinski wrote:
>> Yeah, using memalloc_noio helpers is simpler. I checked and there
>> are about 18 places taking mc_lock, so having a common mc_lock()/mc_unlock()
>> wrapper that does the noio save/restore covers them all (if necessary).
>>
>> The only thing that feels a bit odd is using memalloc_noio in the networking
>> subsystem. It makes sense in block/fs to protect itself from recursion.
> Totally agree that it feels a bit odd that we have to worry about IO,
> but unless we can figure out a way to prevent nbd sockets from getting
> here all our solutions are dealing with noio in networking code 🙁
> IMHO it's better to acknowledge this with the explicit memalloc_noio
> so future developers don't break things again with a mis-placed
> allocation.


Makes sense. I checked and there are about 18 mc_lock sites, and more
than 10 of them have GFP_KERNEL allocations under the lock. If we want
to fix the mc_lock + GFP_KERNEL combination properly, it makes sense to
convert all of them to noio helpers.

But if that feels like too much for this fix, I can just focus on the one
reported by syzbot.


