Return-Path: <netdev+bounces-266727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPHGDkWmsWn4EAAAu9opvQ
	(envelope-from <netdev+bounces-266727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:28:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0933268070
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC6EE3047E7C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E1831E856;
	Wed, 11 Mar 2026 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HSNHngGz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4PRBapqr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YuPNQJ9D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oTDv9khp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18622E88BD
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249933; cv=none; b=m1FAY8ZK8zS8UI1rYIIFzVcspk7bD2QpArsM/WbzkXW50Jdtj2QG0WH9yxKgIGGYfm4Vdbe5XpBAteRb1bn1laVKuD2lI13kxQKITGr+/tozBz0Z2k+76ZEvuvqN+x4HTy6jUkrDm/Rt2L6zn/4AtiYwYyD6wKVYc8TcSYGh3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249933; c=relaxed/simple;
	bh=/5SN4aeNS+rks+IdrjcbweLHiVhWQ+XOAmGPVhG33fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slraTKdEH37kg7hWmAcahReKOYTOJT+ZwrNANHyLEuuxQrd0LzXYCpjTvEaEBHDxnxOE2hOwM0BCgWbfAMrf8W34CFJ//PmH+kO56dKjcyNKGP1ySKlzETIy+mGW8MwJJ2yNZ/rVi2EoGf69nS4H9vYsm3h0lAbWaIWDPiBk+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HSNHngGz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4PRBapqr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YuPNQJ9D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oTDv9khp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BC9D5BCC8;
	Wed, 11 Mar 2026 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773249930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzltAyfST7QBPvTcJm7vMYpyOBU+KMHi40X010wqG9E=;
	b=HSNHngGz3YbBEKhQvSVGD68EVIxTdo0Tm0SCHO9N+IMoikEWTtl+1fY9WKMGfDSt/52klo
	vI+nPllFouoVHiI+xnCY+8SRx3wz+UKidiB7+H0Vy29WajncLd9qP24m56mfj40L5WqaxU
	SlXZceP1z5uJ1OhxNOzMdTPDDR2TX7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773249930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzltAyfST7QBPvTcJm7vMYpyOBU+KMHi40X010wqG9E=;
	b=4PRBapqrsVPlb1MnHBNgqUYj6yf9PfQfhqwHxpwZuJ1C9Ug2VojHBWWrNadSNHxWR2u5JZ
	8UZDmJRpXVWTGrDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773249929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzltAyfST7QBPvTcJm7vMYpyOBU+KMHi40X010wqG9E=;
	b=YuPNQJ9Dmufo1rO6RCGHTGWCooZ4lA71Evz1kkra15GnxrARNLv2af63qdrguq9JJIhIWi
	UKVSGRUI4lZHGVcgZki4p+RXHP89TxM02c+UEzH8+MSU3xzDy8BwKgOFGEdFmhYpBm5J57
	Eso+b/UUIQS2kv5sxliOG1dt73RtE6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773249929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzltAyfST7QBPvTcJm7vMYpyOBU+KMHi40X010wqG9E=;
	b=oTDv9khpGj9F8fneQWgGDkQTo1piKGfSR8gZ8rtSV+nFCifNPJL//hhm5Iw9kCVrPASOh+
	9N9AQBmOfZ6r6tBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9216D3FB24;
	Wed, 11 Mar 2026 17:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IKrkIYilsWnyVAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 11 Mar 2026 17:25:28 +0000
Message-ID: <4b83a234-90d7-4602-abfa-8f302caf635b@suse.de>
Date: Wed, 11 Mar 2026 18:25:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] tls: Factor tls_rx_decrypt_record() helper
To: Chuck Lever <cel@kernel.org>, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260311001952.57059-1-cel@kernel.org>
 <20260311001952.57059-3-cel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260311001952.57059-3-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-266727-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: B0933268070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 01:19, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> recvmsg, read_sock, and splice_read each open-code the
> same sequence: zero-initialize the decrypt arguments, call
> tls_rx_one_record(), and abort the connection on failure.
> 
> Extract tls_rx_decrypt_record() so each receive path shares
> a single decrypt-and-abort primitive. Each call site still
> initializes darg.inargs separately, since recvmsg sets zc
> and async between the memset and the decrypt call.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/tls/tls_sw.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

