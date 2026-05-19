Return-Path: <netdev+bounces-289306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NvbFAcUDGoZVQUAu9opvQ
	(envelope-from <netdev+bounces-289306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:40:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD348579444
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F0330948BA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821423793BF;
	Tue, 19 May 2026 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QBDzXkkf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o4AxXcA6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QBDzXkkf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o4AxXcA6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282839EF35
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176084; cv=none; b=Va7mU+pQOG8Qwo+kfUPDC5U6DG49iNnb9wS42pcTjXAvFjf4GLeEyUqZSycFfiTct4XOdQFP+jb5vCD/j7/p4byps2EQKO20Kx90PTOlAYHxmdInZ/OHQE5zVvmF2QR+pF+Pd43bAvVmjX2WduOa1mCqOY1P9QoAJ+lSO0iJCnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176084; c=relaxed/simple;
	bh=/T/L34l0ybueJLJN5wUhediWSB/vVYizfN2TNN4ytJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIIqEN2fsXH7m/TqowfpBWpqLH6barFYxEiqlPXvj/MfpEFpuJVf00em6oYHxdxohARKRvJNVvrxEkQp5uDNgGoCmF5llE2q/T1YTu5wL3Cvl+ZVb7ljwPR2R/rWQh/iA7UZ2FMMsbXCNxoOXQoq+/NzAfiXVMWMv0fPWEZ7eEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QBDzXkkf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o4AxXcA6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QBDzXkkf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o4AxXcA6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8C035CAFC;
	Tue, 19 May 2026 07:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BajQC+5sYEP4FXnTqsvlmtfnE6e07wzfI4oyozjDq5Q=;
	b=QBDzXkkflDQ3fPEoqG74bx8JlDg3d/ooyJjIbA/hyw+13Z9TX/Iw7hReSlxFVIieeBcjfO
	jI1pZ5PqgyheXRXYW65Vwyvlku7j4ERmm1K1ykViGggAV1mL/8Z4FFhOvnaIMcRIdjUzTJ
	pqARPDLDMYYHu7kJofPSuPtQq48XUgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BajQC+5sYEP4FXnTqsvlmtfnE6e07wzfI4oyozjDq5Q=;
	b=o4AxXcA6pdV7qnI0Pp4guyU4qjVdsa8idy08+oRWy2tezgyYRSVvbiusFeaNkVz8xyA9qU
	S+173QmmY5huXsBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779176042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BajQC+5sYEP4FXnTqsvlmtfnE6e07wzfI4oyozjDq5Q=;
	b=QBDzXkkflDQ3fPEoqG74bx8JlDg3d/ooyJjIbA/hyw+13Z9TX/Iw7hReSlxFVIieeBcjfO
	jI1pZ5PqgyheXRXYW65Vwyvlku7j4ERmm1K1ykViGggAV1mL/8Z4FFhOvnaIMcRIdjUzTJ
	pqARPDLDMYYHu7kJofPSuPtQq48XUgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779176042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BajQC+5sYEP4FXnTqsvlmtfnE6e07wzfI4oyozjDq5Q=;
	b=o4AxXcA6pdV7qnI0Pp4guyU4qjVdsa8idy08+oRWy2tezgyYRSVvbiusFeaNkVz8xyA9qU
	S+173QmmY5huXsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83832593A8;
	Tue, 19 May 2026 07:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4cdGH2oSDGrmVQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 May 2026 07:34:02 +0000
Message-ID: <556f3d0c-8e69-49cc-84ce-3358eb3996b8@suse.de>
Date: Tue, 19 May 2026 09:33:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/7] net/handshake: Drain pending requests at net
 namespace exit
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
 <20260518-handshake-file-pin-v1-1-4bbcb7e62fda@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260518-handshake-file-pin-v1-1-4bbcb7e62fda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289306-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:mid,suse.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AD348579444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 20:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The arguments to list_splice_init() in handshake_net_exit() are
> reversed. The call moves the local empty "requests" list onto
> hn->hn_requests, leaving the local list empty, so the subsequent
> drain loop runs zero iterations. Pending handshake requests that
> had not yet been accepted are not torn down when the net namespace
> is destroyed; each one keeps a reference on a socket file and on
> the handshake_req allocation.
> 
> Pass the source and destination in the documented order
> (list_splice_init(list, head) moves list onto head) so the pending
> list is transferred to the local scratch list and drained through
> handshake_complete().
> 
> Fixing the splice direction exposes a list-corruption race. After
> the splice each req->hr_list still has non-empty link pointers,
> threading the stack-local scratch list rather than hn_requests.
> A concurrent handshake_req_cancel() -- for example, from sunrpc's
> TLS timeout on a kernel socket whose netns reference was not
> taken -- finds the request through the rhashtable, calls
> remove_pending(), and sees !list_empty(&req->hr_list).
> __remove_pending_locked() then list_del_init()s an entry off the
> scratch list while the drain iterates, corrupting it. The same
> call arriving after the drain loop has run list_del() on an
> entry hits LIST_POISON instead.
> 
> Have remove_pending() check HANDSHAKE_F_NET_DRAINING under
> hn_lock and report not-found when drain is in progress. The
> drain has already taken ownership; handshake_complete()'s
> existing test_and_set on HANDSHAKE_F_REQ_COMPLETED still
> arbitrates between drain and cancel for who calls the consumer's
> hp_done. Use list_del_init() rather than list_del() in the drain
> so req->hr_list does not carry LIST_POISON after drain releases
> the entry.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/handshake/netlink.c | 4 ++--
>   net/handshake/request.c | 3 ++-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

