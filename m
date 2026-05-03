Return-Path: <netdev+bounces-283662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK8/NDGj92nXjwIAu9opvQ
	(envelope-from <netdev+bounces-283662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:34:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 565134B7267
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E78E430068D4
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299F39D6CE;
	Sun,  3 May 2026 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/5g1tVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2C311968;
	Sun,  3 May 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836846; cv=none; b=SDTbncWLiSgUcmdqoM0FKUFmbU5kJRTV1d4vaqcl/QqEDoS/EnzkN0DfB6jReNGuYz0LWrOhPD3MoejmG0Fr49/hr7OjkgeLVzEWZYsLMselU5Z1Uun8vrkny1a6ITKwCVTlm6etyx+DAmtQsJ/Pl8s2zOcKk7cgULkFoZ7+ixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836846; c=relaxed/simple;
	bh=9JSKzgl+syuB5t6tQTY0ilz9DTHL1jdtvAEDtOWfJLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rs+K9VCUJL+2YL1TwcvctkL2z/4+gSZumOSOT9Rht9cN463tzU64WsHcDJQIQcAodQCgfW0TnE2EKuOxDO+5aXGm6q/Bx1mzKKzg9V0bK5Jhvh7sjvTiuhXJqcD2z8MysMqbzvjttr1dmbjT57NIO/dOZO5zNZrirbZNGjq3CAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/5g1tVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0036DC2BCB4;
	Sun,  3 May 2026 19:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777836846;
	bh=9JSKzgl+syuB5t6tQTY0ilz9DTHL1jdtvAEDtOWfJLs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y/5g1tVgwbcO8fY2GhZ91sRZ2uHJQ237n3Xm1oMlm5PKUwrfYhQlCTHAcKb6hTJwB
	 5dl7OvcAu3MMzsB0QzYaKCzaTGnxQyFt9iUJF0GHAaDwIxi17+zgWtWjpqP44ieG8v
	 IMd7vATKzQVhn59ZwsLMBcEOymU97ZYugz8nOeMmiMNLOqnGlOX4SdldR2hfezIO77
	 Ke3bWORZWKIBW1FALw8YklcuSO+Rqg8DBCWEIK0BpvObUG++M/Yezwv6DlOE7ywDda
	 41BULQ4UXfXNnCjr5Z9RXy03D6u208Dwbl7H/bijH74GO+bwJLR/xfcWSnZUcUlCxT
	 mZync/ogBquSw==
Message-ID: <2d2b5da3-3bfc-4882-8886-8f20b61254e3@kernel.org>
Date: Sun, 3 May 2026 21:34:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/5] TLS read_sock performance scalability
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
 <20260502180415.0b0bf12b@kernel.org>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20260502180415.0b0bf12b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 565134B7267
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/3/26 3:04 AM, Jakub Kicinski wrote:
> On Wed, 29 Apr 2026 17:48:07 -0400 Chuck Lever wrote:
>> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
>> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
>> this to Hannes, he reported a few performance scalability issues
>> with read_sock. 
> 
> Meaning, this series achieves.. what right now?
> I mean - the headline is "performance scalability" and there's no
> performance testing result in any of the messages :S
> Patch 5 for instance "seems logical" but how much difference does
> it make?

The cover Subject: line has not been changed so all the revisions of
this series can be located easily.

The cover letter makes it clear that the series is now only a clean-up
series. Since async_capable is set to false for TLSv1.3, there is no
performance benefit to these changes, so I don't intend to post a
motivation for it based on performance.


>> However, batch async decryption and its
>> submit/deliver scaffolding were dropped from this series because
>> async_capable is always false for TLS 1.3, the TLS version that
>> NFS and NVMe/TCP both require. Async crypto support for TLS 1.3
>> is a prerequisite for revisiting that work.
>>
>> This series is now only a set of clean-ups. Support for async
>> has been deferred until after TLS KeyUpdate has been merged.
> 
> What does "after TLS KeyUpdate has been merged" mean?
> KeyUpdate is supported.. You mean in NFS? Or in async?

We want to support TLS KeyUpdate in the in-kernel TLS consumers, which
include NFSD, the NFS client, the NVMe/TCP host, and the NVMe/TCP
target. There are two pre-requisites:

1. The in-kernel TLS consumers need to reliably and securely handle TLS
   Alerts. That is coming in the next series I plan to post.

2. The TLS handshake upcall needs to handle KeyUpdate operations. That
   is the series Alistair has been posting since forever, and is waiting
   on getting this series and support for TLS Alerts merged into the
   four in-kernel TLS consumers listed above.


> FTR async support is a major pain and we'd rather get rid of it
> (and switch away from cryto API) than extend it.

That would have been nice to know three months ago when I started work
on this series.

Is there nothing left to do here but drop this series? We'd really like
to get TLS KeyUpdate working for in-kernel TLS consumers, so anything
that can move this process forward is welcome.


-- 
Chuck Lever

