Return-Path: <netdev+bounces-292416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ4CK7AqF2oJ7wcAu9opvQ
	(envelope-from <netdev+bounces-292416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:32:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE095E8562
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21BC4301947C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5439B49F;
	Wed, 27 May 2026 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1SBAOK7k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DifxZ3a4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fy/zUNdl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mH3+nsXe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10A30AD15
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903150; cv=none; b=YuzmYOnr+AObjYPI5pTBl3qqo6ECo4ZZsKVe2twL8vYLV812Si5C+Ujq4Alq13VzPivzkyclbs3b1iN0QfxqeV7bFs74M4I9XEk/Pai2uerADluNJQqb1eGipYiwaP+i1dL61PwQrJSXrlSv4rFg+gInLfVPydUemhzUOXC5X0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903150; c=relaxed/simple;
	bh=YNq7TjsCf8d/xyo0IQdfUzw6QQqc1A25a5WrXR2mqqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hb+Dia58m5TjTUltWVkNR1GcvqEEZjivjpg1TpZ37EWfR/GD/y1eUpOE/knvqxdWFJk1Li4k9bfh91v/bi/pzah34deKRsne2bINz691B4HsTotC917WGLYFRXbslKWJ0nGjLE/Zc4ch597NVjBwkdiOy5Bpj8Jep4sLjLzdpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1SBAOK7k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DifxZ3a4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fy/zUNdl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mH3+nsXe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66A9C6ACD9;
	Wed, 27 May 2026 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779903147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FquF5TRsyuRxxCso6UuAHSdVWzsEcorBxS2pYHqNBzA=;
	b=1SBAOK7k5G/dKvMqwMLmxLKAN/4AWLOiB6wweE3uAcRfWu2uKENHcxCe0iXRL49BJHCtiD
	BSVNTrFz7YOId1tk7EvgeQDXMUBkXjAIKitc7y0YR8KRR4TyybgqFisLDIIjDnfBOfVIpL
	jslwhoHKxQTxy9Vzga15PaD/D+iFhT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779903147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FquF5TRsyuRxxCso6UuAHSdVWzsEcorBxS2pYHqNBzA=;
	b=DifxZ3a4nR4PBQaDIXAqU6wi7vYcyddkNIINHRynyUrZuzn+kO3a4MWhp+oD3Mn1q5o9/L
	RNCc+jRHCi1JPuBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779903143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FquF5TRsyuRxxCso6UuAHSdVWzsEcorBxS2pYHqNBzA=;
	b=Fy/zUNdlkkLzrNMMmVc3XfQSB3CCQx9IhquQGrV31Rxcx/7iquK083SmGmfSStzfgv4EeC
	FFKjCWz+/Z0XKuyWIq+J2qHLxaLHuTz1pdtrfDmQ910uUNjrMYcMZV/F/L2jHwh+2loCih
	/wYrVWyFp+FyZQ/ghutFcIWAx+/eqr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779903143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FquF5TRsyuRxxCso6UuAHSdVWzsEcorBxS2pYHqNBzA=;
	b=mH3+nsXeApTs4ZhlMqioy+cZG8MxuKR6XOrNQGZzfGW5kHhjD86crchHop6wpPISKSit97
	eSI2smTh+TWnz3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDD665A93A;
	Wed, 27 May 2026 17:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1omLKYqF2rhHgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 17:32:22 +0000
Message-ID: <d733383f-534a-4e1a-9f46-8e2b1d07fb41@suse.de>
Date: Wed, 27 May 2026 19:32:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/8] net/handshake: Use spin_lock_bh for hn_lock
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
 <20260525-handshake-file-pin-v3-1-66c616906ead@oracle.com>
 <41835be9-ef00-42c7-a5d3-258f092b59eb@suse.de>
 <eb4de53b-f96c-4905-b67a-90790d5e4007@app.fastmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <eb4de53b-f96c-4905-b67a-90790d5e4007@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-292416-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 1EE095E8562
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 16:24, Chuck Lever wrote:
> 
> 
> On Wed, May 27, 2026, at 4:59 AM, Hannes Reinecke wrote:
>> On 5/25/26 18:51, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> nvmet_tcp_state_change(), a socket callback that runs in BH context,
>>> can reach handshake_req_cancel() via nvmet_tcp_schedule_release_queue()
>>> and tls_handshake_cancel().  handshake_req_cancel() acquires
>>> hn->hn_lock with plain spin_lock().  If a process-context thread on
>>> the same CPU holds hn->hn_lock when a softirq invokes the cancel path,
>>> the lock attempt deadlocks.  This is the only caller that invokes
>>> tls_handshake_cancel() from BH context; every other consumer calls it
>>> from process context.
>>>
>>> Deferring the cancel to process context in the NVMe target is not
>>> straightforward: nvmet_tcp_schedule_release_queue() must call
>>> tls_handshake_cancel() atomically with its state transition to
>>> DISCONNECTING.  If the cancel were deferred, the handshake completion
>>> callback could fire in the window before the cancel runs, observe the
>>> unexpected state, and return without dropping its kref on the queue.
>>> Reworking that interlock is considerably more invasive than hardening
>>> the handshake lock.  Convert all hn->hn_lock acquisitions from
>>> spin_lock/spin_unlock to spin_lock_bh/spin_unlock_bh so the lock is
>>> never taken with softirqs enabled.
>>>
>>> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>    net/handshake/netlink.c |  4 ++--
>>>    net/handshake/request.c | 14 +++++++-------
>>>    net/handshake/tlshd.c   |  2 ++
>>>    3 files changed, 11 insertions(+), 9 deletions(-)
>>>
>> ... and there is always the question whather we should be calling
>> tls_handshake_cancel() in the first place.
>> We already call 'tls_handshake_cancel()' from the handshake timeout
>> handler, and this instance of 'tls_handshake_cancel()' is called
>> from a socket callback (ie when the soecket is closed or something).
>> I would have expected that the handshake code cleans up outstanding
>> requests on socket close already; if so, we can delete the cancel
>> here.
> 
> The handshake layer doesn't auto-cancel on socket close.
> 
> handshake_sk_destruct() fires when the sock refcount reaches
> zero, but it only frees the handshake_req and removes it from
> the hash table. It does not set HANDSHAKE_F_REQ_COMPLETED or
> invoke the consumer's done callback. It assumes the request
> was already completed or canceled before the socket reached
> final destruction.
> 
> The timeout handler and the state-change path cover different
> failure modes. The timeout fires when tlshd is slow or absent.
> The state-change callback fires when the remote peer resets or
> closes the connection while the handshake is still in
> progress -- that can happen well before the timeout expires.
> 
> Without the cancel in nvmet_tcp_schedule_release_queue(), the
> race plays out as follows: the state-change callback
> transitions the queue to DISCONNECTING and drops its kref.
> Then tlshd finishes and the handshake layer calls
> nvmet_tcp_tls_handshake_done(). That callback sees the queue
> is not in TLS_HANDSHAKE state, hits the WARN_ON, and returns
> without dropping its own kref -- leaking the queue.
> 
> The cancel makes the teardown race-free: either cancel wins
> and the completion callback never fires, or completion already
> won and cancel returns false. Either way, exactly one side
> drops the kref.
> 
> The SunRPC consumers (client and server) avoid this problem by
> blocking a thread on wait_for_completion() during the
> handshake. A socket state change wakes the waiter indirectly
> through the completion callback, and the waiter handles
> cleanup. nvme-tcp's handshake is fully asynchronous -- there
> is no blocked thread to wake, so the state-change callback is
> the only context that can cancel the handshake before queue
> teardown begins.
> 

Thanks for the clarification. That's what I had (implicitely)
assumed, so the tls_handshake_cancel() needs to stay.

So you can add my:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

