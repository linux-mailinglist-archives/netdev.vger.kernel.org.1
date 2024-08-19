Return-Path: <netdev+bounces-119717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF67956B2C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D7DBB22406
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B50316A95B;
	Mon, 19 Aug 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yS2ZEHHC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="etB7Yaja";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yS2ZEHHC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="etB7Yaja"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5501D696
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071801; cv=none; b=A2S6l8HAxQDgoaLgcUbRaKRpHRvzxenr7c/1Kki37eK7Uz5FaX50NzJir2KisVeV466TdG6EUz5QKB56yIyaf/3MkVSMdIEuXkQxnfpm4rmaXWZnbNvLkkH49WN+DUBOyY8nnGafarCQi5bd7q+IBwG6XPBp4N6S8Vi8Qmtj33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071801; c=relaxed/simple;
	bh=KPkSbNrrXQwqvsYCvoPtXVbJb+ZlkqN9wFhBIr1k2h4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BWXwbq5qdXISnaw40g+amXL1Sk9g6vmavyJiXVqNwrZHJfZWnW5m/kN9ushkXSTbHiAvUan7c6ILbOsV2Gwk+Qo6K7SG2XVSgqrMv0qs0mVvaTdL4hmGpsQYkAjLnH7/e7owet7R3oBRNltN+D7ERmae+XDiq+G8ApSsDLBJe30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yS2ZEHHC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=etB7Yaja; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yS2ZEHHC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=etB7Yaja; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 325AD1F7E7;
	Mon, 19 Aug 2024 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724071796;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yzoWeW8HTqGHd9LcS95jS31gRoSDtiAwN6yflQeG8eg=;
	b=yS2ZEHHCfH20nmmGaKZUHAz9Ne5lhSx7DJ6FWTSqoL9cqf8CHfAlQBqVh/IZfP2/HeWPfy
	3oHfbxtTlgyGK/fW0eUJlPb095MiNYxX8T55Fg537UGJ1P83T2REkMRMaR6zmXBQD3PfYG
	WMea9Dln70o16jBgiXoDJIm4zvRIQSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724071796;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yzoWeW8HTqGHd9LcS95jS31gRoSDtiAwN6yflQeG8eg=;
	b=etB7Yaja9xEaVXFtzhO2fiu9YE1HqNjPNk5dgafjPGDjxh6xWXNzZMrhVjPpiFo+YE1+HP
	zuV3obT2WgUrJFBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724071796;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yzoWeW8HTqGHd9LcS95jS31gRoSDtiAwN6yflQeG8eg=;
	b=yS2ZEHHCfH20nmmGaKZUHAz9Ne5lhSx7DJ6FWTSqoL9cqf8CHfAlQBqVh/IZfP2/HeWPfy
	3oHfbxtTlgyGK/fW0eUJlPb095MiNYxX8T55Fg537UGJ1P83T2REkMRMaR6zmXBQD3PfYG
	WMea9Dln70o16jBgiXoDJIm4zvRIQSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724071796;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yzoWeW8HTqGHd9LcS95jS31gRoSDtiAwN6yflQeG8eg=;
	b=etB7Yaja9xEaVXFtzhO2fiu9YE1HqNjPNk5dgafjPGDjxh6xWXNzZMrhVjPpiFo+YE1+HP
	zuV3obT2WgUrJFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E34761397F;
	Mon, 19 Aug 2024 12:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wF84NnM/w2alZwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 19 Aug 2024 12:49:55 +0000
Date: Mon, 19 Aug 2024 14:49:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Eric Dumazet <edumazet@google.com>, Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [RFC] Big TCP and ping support vs. max ICMP{,v6} packet size
Message-ID: <20240819124954.GA885813@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

Hi Eric, Xin,

I see you both worked on Big TCP support for IPv4/IPv6. I wonder if anybody was
thinking about add Big TCP to raw socket or ICMP datagram socket. I'm not sure
what would be a real use case (due MTU limitation is Big TCP mostly used on
local networks anyway).

I'm asking because I'm just about to limit -s value for ping in iputils (this
influences size of payload of ICMP{,v6} being send) to 65507 (IPv4) or 65527 (IPv6):

65507 = 65535 (IPv4 packet size) - 20 (min IPv4 header size) - 8 (ICMP header size)
65527 = 65535 (IPv6 packet size) - 8 (ICMPv6 header size)

which would then block using Big TCP.

The reasons are:
1) The implementation was wrong [1] (signed integer overflow when using
INT_MAX).

2) Kernel limits it exactly to these values:

* ICMP datagram socket net/ipv4/ping.c in ping_common_sendmsg() [2] (used in
both ping_v4_sendmsg() and ping_v6_sendmsg()):

	if (len > 0xFFFF)
		return -EMSGSIZE;

* raw socket IPv4 in raw_sendmsg() [3]:

	err = -EMSGSIZE;
	if (len > 0xFFFF)
		goto out;

* Raw socket IPv6 I suppose either in rawv6_send_hdrinc() [4] (I suppose when
IP_HDRINCL set when userspace passes also IP header) or in ip6_append_data() [5]
otherwise.

3) Other ping implementations also limit it [6] (I suppose due 2)).

Kind regards,
Petr

[1] https://github.com/iputils/iputils/issues/542
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv4/ping.c?h=v6.11-rc4#n655
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv4/raw.c?h=v6.11-rc4#n498
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv6/raw.c?h=v6.11-rc4#n605
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ipv6/ip6_output.c?h=v6.11-rc4#n1453
[6] https://github.com/pevik/iputils/wiki/Maximum-value-for-%E2%80%90s-(size)

