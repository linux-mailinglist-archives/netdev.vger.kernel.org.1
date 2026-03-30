Return-Path: <netdev+bounces-273276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CdxJsquymnU/AUAu9opvQ
	(envelope-from <netdev+bounces-273276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:11:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1483E35F348
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1F81300E3EF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE7F377EDC;
	Mon, 30 Mar 2026 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MkF5N0P6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S9MjmWwL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MkF5N0P6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S9MjmWwL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA7175A8C
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890695; cv=none; b=OfayHpVf97jlQj963BGSHNn4Wej3UEKCmRVLwweUsTgECX78HT824DJqPAn1YJUrKY0W+jgyPweznYWBvI+yPjoRPssF8zL5LMttBqlOy7tGox+RWIhuBH7PO3bNZkS0fjft8xGCAZI7FKpmFTksAF8bUZeCmNMwTrAGd6g5d0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890695; c=relaxed/simple;
	bh=GGxGYrOfa6EJqnhyb2hATgtHu2bZd4TPhZm0gsY8GIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkuqqKc5p9Q5g3bCcNN7gGIZZGe38urc3Pd4pz8Qpq+dMl6Wl3Ta2v8j35tt98v89U81Blx6CK8XuzJf9JnyBfLJ28WfG5dJKc/CdGdak77PxM9DKK1KBnzvyDKBp1SNW8MziQdV/wEcJL5SCY2MRuv+/jwC3QBAh6Xb+QCM7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MkF5N0P6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S9MjmWwL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MkF5N0P6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S9MjmWwL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E5FE4D522;
	Mon, 30 Mar 2026 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774890692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLYqAKK4ZpwzlNcFVjzW3F6YvxZHNSzAako3v+Emn78=;
	b=MkF5N0P6HPGeOpBOgGd+GwxtIqr5r9lzyxZMzGSH5vX9fplCQX9bEusQP7yxDvsyF08o3S
	AOWUfSxo85o8w8bm2ax2bREoijqsCvoRrU9p0btcWjHTLVB45G8GaV1uQfB1GmrtOTpBBc
	vKCS9qsrF4sWNVaIWNpRYC0jbtbCf5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774890692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLYqAKK4ZpwzlNcFVjzW3F6YvxZHNSzAako3v+Emn78=;
	b=S9MjmWwLBm3R4AM3WVh9J4obzU5LkQ9sLF+pNZ52+SC/XNjlPH5uatcm8h9dZQxnhau+gY
	SIeOynBSLGxpJxDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MkF5N0P6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S9MjmWwL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774890692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLYqAKK4ZpwzlNcFVjzW3F6YvxZHNSzAako3v+Emn78=;
	b=MkF5N0P6HPGeOpBOgGd+GwxtIqr5r9lzyxZMzGSH5vX9fplCQX9bEusQP7yxDvsyF08o3S
	AOWUfSxo85o8w8bm2ax2bREoijqsCvoRrU9p0btcWjHTLVB45G8GaV1uQfB1GmrtOTpBBc
	vKCS9qsrF4sWNVaIWNpRYC0jbtbCf5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774890692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLYqAKK4ZpwzlNcFVjzW3F6YvxZHNSzAako3v+Emn78=;
	b=S9MjmWwLBm3R4AM3WVh9J4obzU5LkQ9sLF+pNZ52+SC/XNjlPH5uatcm8h9dZQxnhau+gY
	SIeOynBSLGxpJxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 122414A0A2;
	Mon, 30 Mar 2026 17:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Se2tAMSuymlBBAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 30 Mar 2026 17:11:32 +0000
Message-ID: <2da5ea9d-b612-4b0a-8c2a-20aa9aa2e797@suse.de>
Date: Mon, 30 Mar 2026 19:11:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] ipv4: nexthop: reachable WARN in rtm_get_nexthop() via
 oversized group dump
To: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>, security@kernel.org
Cc: netdev@vger.kernel.org
References: <CAL_bE8Li2h4KO+AQFXW4S6Yb_u5X4oSKnkywW+LPFjuErhqELA@mail.gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <CAL_bE8Li2h4KO+AQFXW4S6Yb_u5X4oSKnkywW+LPFjuErhqELA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 1483E35F348
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 2:14 PM, 钱一铭 wrote:
> Hello,
> 
> I found a reachable warning in `rtm_get_nexthop()` in upstream commit
> `a989fde763f4` (`7.0.0-rc4-00029-ga989fde763f4` in my test build).
> By creating a sufficiently large IPv4 nexthop group and then issuing
> `RTM_GETNEXTHOP` for that ID, a local user can trigger
> `WARN_ON(err == -EMSGSIZE)` in `net/ipv4/nexthop.c:3393`.
> 
> With `panic_on_warn=1`, this becomes a deterministic local kernel DoS.
> Without `panic_on_warn=1`, the issue is still reachable as a user-triggerable
> kernel warning.
> 
> Source analysis
> 
> At the tested commit, `rtm_get_nexthop()` allocates a fixed-size reply skb:
> 
> - `alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL)` at `net/ipv4/nexthop.c:3381`
> 
> It then serializes the selected nexthop object into that skb:
> 
> - `nh_fill_node(...)` at `net/ipv4/nexthop.c:3390`
> 
> For group nexthops, `nh_fill_node()` emits `NHA_GROUP` and related metadata.
> If the skb is too small, the serialization helpers return `-EMSGSIZE`, and
> `nh_fill_node()` propagates that error.
> 
> The problem is that group creation-time validation does not bound the group
> size against the future `RTM_GETNEXTHOP` response size. In particular,
> `nh_check_attr_group()` validates layout, duplicate IDs, reserved fields, and
> weights, but it does not reject a group that is valid to create and later too
> large to dump back through the fixed-size `RTM_GETNEXTHOP` reply path.
> 
> The same file already has exact size estimation for nexthop dumps:
> 
> - `nh_nlmsg_size()` computes the size needed for a given nexthop object
> - `nexthop_notify()` uses `nlmsg_new(nh_nlmsg_size(nh), ...)`
> 
> So the reachable warning appears to come from a mismatch between:
> 
> 1. object creation, which accepts very large groups, and
> 2. object query through `rtm_get_nexthop()`, which still uses a fixed
>     `NLMSG_GOODSIZE` buffer.
> 
> Why 512 members are enough
> 
> `struct nexthop_grp` is 8 bytes. A 512-member group therefore needs a
> 4096-byte `NHA_GROUP` payload alone, before netlink attribute headers,
> alignment, `NHA_ID`, `NHA_GROUP_TYPE`, `NHA_OP_FLAGS`, and the `nhmsg`
> header are added. In practice, 256-member and 384-member groups were dumped
> successfully in my setup, while the first 512-member query reproducibly hit
> the warning.
> 

Hi, thanks for the report. This issue is legit, I reproduced it locally 
too. IMO, that warning and also the ones at nexthop_notify() and 
rtm_get_nexthop_bucket() should be converted to the DEBUG_NET_ variant.

Using nh_nlmsg_size() seems like the right fix but the allocation of skb 
would need to wait until nh fetched. I also wonder if we should use 
nlmsg_new() directly. Would look deeper into it.

In addition I am writing a selftest patch for this.

Thanks,
Fernando.

