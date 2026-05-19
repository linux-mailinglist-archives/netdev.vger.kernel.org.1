Return-Path: <netdev+bounces-289314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE5wMnUZDGrrVwUAu9opvQ
	(envelope-from <netdev+bounces-289314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:04:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4D85799DC
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35151300BC9E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F253DDDD0;
	Tue, 19 May 2026 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K1um8r1v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GzWtOa6D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K1um8r1v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GzWtOa6D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F516A395
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177590; cv=none; b=NKDNLwXEnJ6irJcEdCFXgqT8v23Oj7iNGkrkk/+M7TEI9HcJGg5gckPeBpiXqraCIV5kKF4kOcziFAd9XoPCFezA6ydHhzivH4d9KUCqY0cGWjiPXYCxMZP8Z19ZaJthWx03KdXcY4QDTh41IiWVF0hnCZa08siJlamRJJH+OW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177590; c=relaxed/simple;
	bh=T7+jilZHGvY4EQupEtQ6+7XjvCfq/CXs996JRBCu0wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7USak0fEsW7v4ZyxZaudsDYuFPkQB+Yb/sEfQd0zMXlpnZVMQaBMqkhxxQTyxIapJ3l5+EU9oMfyYbsSWIZE6wNnmrvQUCBlK+2gUU2vbwk/Ur5fLR4QaL6RkwUhC/Ww8rPzm0v8Q2v4/ezxhGq2SIW7YL3ekYPRLhtfz3Ntrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K1um8r1v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GzWtOa6D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K1um8r1v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GzWtOa6D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BDCB66DC9;
	Tue, 19 May 2026 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI4aPSozWh78t1SQ/0I7HGIjm0423IGba5gD7goL/dc=;
	b=K1um8r1v8Yx0gZO6qc3IhyB7LMDT3BIhS0XxPSq6rvSulTwua5OkUN73zskCz69t4Zpfil
	AtT+xr57Kz4RFafFokLbRxKqf4fTD5XDXnUM2uIjsch5Jw/CSc4l+xoVHdivmhLKNktGHz
	83F51CfI0E6wurIbJjMe8d1m2t1tQgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI4aPSozWh78t1SQ/0I7HGIjm0423IGba5gD7goL/dc=;
	b=GzWtOa6DuBGtjzOM1Npd67vt4GewXzZn03+/PNF21r8NMJ8pEB9SpAvAAXFvIFzIcfEJhU
	yrO5rx/mbba+tTDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779177587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI4aPSozWh78t1SQ/0I7HGIjm0423IGba5gD7goL/dc=;
	b=K1um8r1v8Yx0gZO6qc3IhyB7LMDT3BIhS0XxPSq6rvSulTwua5OkUN73zskCz69t4Zpfil
	AtT+xr57Kz4RFafFokLbRxKqf4fTD5XDXnUM2uIjsch5Jw/CSc4l+xoVHdivmhLKNktGHz
	83F51CfI0E6wurIbJjMe8d1m2t1tQgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779177587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI4aPSozWh78t1SQ/0I7HGIjm0423IGba5gD7goL/dc=;
	b=GzWtOa6DuBGtjzOM1Npd67vt4GewXzZn03+/PNF21r8NMJ8pEB9SpAvAAXFvIFzIcfEJhU
	yrO5rx/mbba+tTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D45C8593A8;
	Tue, 19 May 2026 07:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mDNTM3IYDGp4bwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 07:59:46 +0000
Message-ID: <20c1c773-ea29-4c1a-b960-eb12afd2995a@suse.de>
Date: Tue, 19 May 2026 09:59:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/7] net/handshake: hand off the pinned file reference
 to accept_doit
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-5-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-5-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289314-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,meta.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: ED4D85799DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> handshake_req_next() removes the request from the per-net
> pending list and drops hn_lock before handshake_nl_accept_doit()
> reads req->hr_sk->sk_socket and dereferences sock->file (once in
> FD_PREPARE() and again in get_file()).  In that window a
> consumer running tls_handshake_cancel() followed by sockfd_put()
> (svc_sock_free) or __fput_sync() (xs_reset_transport) releases
> sock->file.  sock_release() then runs sock_orphan(), zeroing
> sk_socket, and frees the struct socket.  The accept-side code
> either reads NULL through sk_socket or chases freed memory.
> 
> The submit-side sock_hold() does not prevent this.  sk_refcnt
> protects struct sock, but struct socket and sock->file are
> independently refcounted via the file descriptor the consumer
> owns.  Pinning sk leaves sock and sock->file unprotected.
> 
> Retarget the accept-side dereferences at req->hr_file, which was
> pinned at submit time, instead of req->hr_sk->sk_socket->file.
> Pinning on its own is not sufficient: a consumer that cancels
> between handshake_req_next() returning and accept_doit reaching
> FD_PREPARE() takes the !remove_pending() branch in
> handshake_req_cancel() and drops hr_file before the accept side
> takes its own reference.  Hand off an additional file reference
> inside handshake_req_next(), under hn_lock, so the accept side
> operates on a reference that no concurrent handshake_req_cancel()
> can revoke.  FD_PREPARE() consumes that handed-off reference,
> either by transferring it to the new fd in fd_publish() or by
> dropping it in the cleanup destructor on error; the explicit
> get_file() that previously balanced FD_PREPARE() is therefore
> redundant and goes away.
> 
> Update handshake_req_cancel_test2 and _test3 to simulate the
> FD_PREPARE() consumption with an fput() so the kunit file-count
> assertions stay balanced.
> 
> Reported-by: Chris Mason <clm@meta.com>
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/handshake-test.c |  8 ++++++++
>   net/handshake/netlink.c        |  7 ++-----
>   net/handshake/request.c        | 18 ++++++++++++++++++
>   3 files changed, 28 insertions(+), 5 deletions(-)
> 
I _think_ this should fix the issue I had reported about a kernel oops 
in __sys_recvfrom() in tlshd.
Which has all the symptoms described here.
So glad that it's been addressed.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

