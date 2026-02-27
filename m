Return-Path: <netdev+bounces-261637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL84Kt3goGk4nwQAu9opvQ
	(envelope-from <netdev+bounces-261637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:10:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 225431B1258
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE0C63031F3F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632E81DE2C9;
	Fri, 27 Feb 2026 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WuIToFdm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wYtwcRoc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WuIToFdm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wYtwcRoc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B831D5151
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772150999; cv=none; b=bsE7cK4y0io4wH+/tpm7xcTUm5qj6mkZuWpl5IyjOgmR4/J/Mv34nReQVzN8XduqSsidl4oG+y9fDlNzaq7wGJEMSM5CFRiZc1M+6EWFpxD1SCwMz3FvCIesg6HZkHMrCwscv2157/Ot8a5ORVrrGu8k/5hKBBm2kB0V5RabsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772150999; c=relaxed/simple;
	bh=hEOXuMW87dKrLHm4dXQ7+Hg9Rtsk7SP7D6NUHuyYu8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enuI0IFvNk9JezAY2ZnZe7Uha7ZpXHAoDM/2+eR1GiapyXYFdVBSOjHvwB+aC/A7H9oql1JaVgAJdViJk7AeBkIsireuVKGNry2MeZ5oLjrxT981Z4Bfud63YbiZUlRHRoa3Knyn2ORfi0re/2yX0E5BtxgzIx7RHMpmLF4PszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WuIToFdm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wYtwcRoc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WuIToFdm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wYtwcRoc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CBFF1FAB3;
	Fri, 27 Feb 2026 00:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772150996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IsClWDiArYepAhcPmc4a36QofNhKDIYpMDz4DWH4zQ=;
	b=WuIToFdmbRgMSjuEWTq+QeOBCApraU5G+itJpHP3xFsljGDkWABswfX88S1fqIW7gaVivN
	i1epu0L2bD5W7MR+tZT43J2pW/dsFIuIWPhrGpXT2hOFj9VOauEyvZUkeKo3dRvjGoUHIB
	jl4S/IVO9BBm8i9ShUEHqWR9l9z7qUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772150996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IsClWDiArYepAhcPmc4a36QofNhKDIYpMDz4DWH4zQ=;
	b=wYtwcRocEJGZ725UKjYTbeM/xkA1zOPTJ75FFcqB8HX3Rl+G19V6FfmW7jyHF7q06V2OZX
	ML8Q/TluI7DwzrBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772150996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IsClWDiArYepAhcPmc4a36QofNhKDIYpMDz4DWH4zQ=;
	b=WuIToFdmbRgMSjuEWTq+QeOBCApraU5G+itJpHP3xFsljGDkWABswfX88S1fqIW7gaVivN
	i1epu0L2bD5W7MR+tZT43J2pW/dsFIuIWPhrGpXT2hOFj9VOauEyvZUkeKo3dRvjGoUHIB
	jl4S/IVO9BBm8i9ShUEHqWR9l9z7qUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772150996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IsClWDiArYepAhcPmc4a36QofNhKDIYpMDz4DWH4zQ=;
	b=wYtwcRocEJGZ725UKjYTbeM/xkA1zOPTJ75FFcqB8HX3Rl+G19V6FfmW7jyHF7q06V2OZX
	ML8Q/TluI7DwzrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C76D53EA69;
	Fri, 27 Feb 2026 00:09:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GXS8LdPgoGk/awAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 27 Feb 2026 00:09:55 +0000
Message-ID: <7e5f3579-be4d-4220-b00c-8e2c9c999fa0@suse.de>
Date: Fri, 27 Feb 2026 01:09:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fix nd_tbl NULL dereference when IPv6 is
 disabled
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, roopa@cumulusnetworks.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, razor@blackwall.org
References: <20260226234059.19402-1-fmancera@suse.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260226234059.19402-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-261637-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 225431B1258
X-Rspamd-Action: no action

On 2/27/26 12:40 AM, Fernando Fernandez Mancera wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called
> which initializes it. Then, if neigh_suppress is enabled and an ICMPv6
> Neighbor Discovery packet reaches the bridge, br_do_suppress_nd() will
> dereference ipv6_stub->nd_tbl which is NULL, passing it to
> neigh_lookup(). This causes a kernel NULL pointer dereference.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000268
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   [...]
>   RIP: 0010:neigh_lookup+0x16/0xe0
>   [...]
>   Call Trace:
>    <IRQ>
>    ? neigh_lookup+0x16/0xe0
>    br_do_suppress_nd+0x160/0x290 [bridge]
>    br_handle_frame_finish+0x500/0x620 [bridge]
>    br_handle_frame+0x353/0x440 [bridge]
>    __netif_receive_skb_core.constprop.0+0x298/0x1110
>    __netif_receive_skb_one_core+0x3d/0xa0
>    process_backlog+0xa0/0x140
>    __napi_poll+0x2c/0x170
>    net_rx_action+0x2c4/0x3a0
>    handle_softirqs+0xd0/0x270
>    do_softirq+0x3f/0x60
> 
> Fix this by adding a check before br_is_local_ip6() or neigh_lookup()
> call. If ipv6_stub->nd_tbl is NULL, return immediately.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> Note: I am investigating more places where this might be happening too.
> ---

I can confirm that there is at least one more instance of this problem. 
Although it is not on bridge driver. I will send a patch ASAP.

Thanks,
Fernando.

