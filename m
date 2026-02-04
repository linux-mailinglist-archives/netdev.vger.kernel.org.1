Return-Path: <netdev+bounces-256814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPgaC5upg2m6sQMAu9opvQ
	(envelope-from <netdev+bounces-256814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:18:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3C0EC659
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714E03016500
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 20:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3434A3DA;
	Wed,  4 Feb 2026 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J9a0Wb5S"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFC27456
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236310; cv=none; b=cAqhPietT4TVhjhD43k9njZqxjguDYWvcM73oAefemXi7Vnr4uQHfRYAoZwnRTOxm8kqM4zuF7xZWL1DlLEU5iktfFWDjd6dYkEaHjEsHlvd7gL4/j4OX9rxRB5GEvAOk1vSZl5kakj7qoTof60hAVLngClTV6POsZn5digxEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236310; c=relaxed/simple;
	bh=RodW8yBOZz6ysYNkDfsRd3/P3tfnOzkO8UycEqe9Pj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaEJBjLRu3QzTocSfmnpyRwa1INzpcf9vzIJhtVECbF6UpOdrYbKWOFEjxugB/hvP9tXt5PRDL1iWNXfy7QQLNmHSEGJiOAmF1a5dt+yqFNAweBB9Jx+6hJAp5xXIzPsuxjAjsEkQ/BC7uDcbEcorUMXlffvugAL1Pn2Zn26CUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J9a0Wb5S; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99bfc3be-0517-4e17-b7a5-e504b751d8bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770236297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gi9XIaCgaA1g0K/V/rmmDYgDSWtNyYGCbYjZKLA8l/A=;
	b=J9a0Wb5S2SXd5lZR8awLV2bTVZZ0LLvWJbp/NgnKQAMm5ZNARbR0CWGgMGpz2KqwutBeO0
	vGxEJjuUdu1RRZ6SjxwKYFJkQYNFsruhHAfpe74VMAoLVSlXggyMvGQJePbVEUrp0KMfHs
	6V8iCpMr7q57BMeOx8tcMF6AE22sA1U=
Date: Wed, 4 Feb 2026 12:18:12 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Kuniyuki Iwashima <kuniyu@google.com>, Michal Luczaj <mhal@rbox.co>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
 <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
 <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
 <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
 <CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpHBGqKcUT0iMA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUDrC1rO2diM3gVg5GV5CTVAUS2RbLP+SpHBGqKcUT0iMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256814-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,iogearbox.net,davemloft.net,google.com,kernel.org,cloudflare.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E3C0EC659
X-Rspamd-Action: no action

On 2/4/26 11:16 AM, Kuniyuki Iwashima wrote:
> For example, inet_sock(sk)->inet_opt could be freed by
> setsockopt(IP_OPTIONS) even after fentry prog verifies
> that it's not NULL.

This one should be fine because of rcu.

> 
> I'm not sure if bpf_core_cast() etc allows such access, but
> if it's allowed, I think there is no general solution.

bpf_core_cast (i.e. the "kfunc" bpf_rdonly_cast) does not use the 
pointer argument, so should be fine. Its return value is marked as 
PTR_UNTRUSTED. iirc, PTR_UNTRUSTED cannot be passed to helper, so 
bpf_core_cast should be fine overall.

> 
> Fortunately that's not null-deref nor oob-write, and it just reads
> stale info as Martin mentioned... so probably this is WAI for
> tracing prog ?

afaik, the tracing radius is large, so the prog cannot expect much 
guarantee.

Reading in the bpf prog is fine. The exception is handled.

The problem here is passing it to a helper (not kfunc) that depends on 
the arg being valid.


