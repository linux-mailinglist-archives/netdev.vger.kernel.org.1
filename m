Return-Path: <netdev+bounces-259143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gADaDjjSlGmfIAIAu9opvQ
	(envelope-from <netdev+bounces-259143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:40:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E291715009A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA2E83018BF2
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5016F36F431;
	Tue, 17 Feb 2026 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qddFoofY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3S2g/CSd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qddFoofY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3S2g/CSd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A53374178
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360804; cv=none; b=ItOJUXuxTeVov/6z+08mI0jKpwzVKFngCPrWHzGHeI8XAiOH395xkP/Iba3rFbDJDhkIvDsx3/UfDPZVY7JCjHXouIcdF1Tp2r+Ky9ycvlwsOb9uGBKS66q7PwuWFxlbgNAHvTuvH943nk6ap0/V9HCBaQ5rLA72Fhzl4v1rwxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360804; c=relaxed/simple;
	bh=L8Y+/soduBvvYE2WlvS3KBp0uuGuCnhVJ/41IrGyD3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzjVMTPcrvP/ilTQZRZtSkmm7brT7L9M9UoFLXsONuut1DwPahy3Pjxi0Yzuhjy3S9qvawmtxbrbRC5PwYIt5FjY6TqzqwNDtxi+gvDr1To/AilEGorVD4qBhLEwSfG+WiQPeqoHS76wfXiRFvCkZ2zuhLCQ4Yih19JNjx68L/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qddFoofY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3S2g/CSd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qddFoofY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3S2g/CSd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 227515BCCB;
	Tue, 17 Feb 2026 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771360801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYjH/+SOgtc4HRGiWKx69Qb64DZo8YcCzhekmoqYUbo=;
	b=qddFoofY7+gD2vl8tYV8SD0LjYz2VIVWwb8U5dKHD7EewnObHxVvgmgfkBqD5UEvMFa5Lr
	wYmQYj6WJzJ+Uv/92k2NtjZSFihT6aXJZZYo29kFlHQ60ppgGvignucyt601WOlDvfv5dV
	fEETVQJv1VfsetKGZ77/mgAdojKpqr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771360801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYjH/+SOgtc4HRGiWKx69Qb64DZo8YcCzhekmoqYUbo=;
	b=3S2g/CSdXoP4ZUlCaIBMR/LnFlMvWGs2On+pZis5fgFbwX3ylaQYRu0ahCtLaXi1C//lka
	ESgXe6m4SYXNNiAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qddFoofY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="3S2g/CSd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771360801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYjH/+SOgtc4HRGiWKx69Qb64DZo8YcCzhekmoqYUbo=;
	b=qddFoofY7+gD2vl8tYV8SD0LjYz2VIVWwb8U5dKHD7EewnObHxVvgmgfkBqD5UEvMFa5Lr
	wYmQYj6WJzJ+Uv/92k2NtjZSFihT6aXJZZYo29kFlHQ60ppgGvignucyt601WOlDvfv5dV
	fEETVQJv1VfsetKGZ77/mgAdojKpqr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771360801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYjH/+SOgtc4HRGiWKx69Qb64DZo8YcCzhekmoqYUbo=;
	b=3S2g/CSdXoP4ZUlCaIBMR/LnFlMvWGs2On+pZis5fgFbwX3ylaQYRu0ahCtLaXi1C//lka
	ESgXe6m4SYXNNiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 817F63EA65;
	Tue, 17 Feb 2026 20:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f/VfHCDSlGnAXgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 17 Feb 2026 20:40:00 +0000
Message-ID: <8ae8a497-370b-435b-a22b-3108e14f98a4@suse.de>
Date: Tue, 17 Feb 2026 21:39:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fix a race in ip6_sock_set_v6only()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260216102202.3343588-1-edumazet@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260216102202.3343588-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-259143-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E291715009A
X-Rspamd-Action: no action

On 2/16/26 11:22 AM, Eric Dumazet wrote:
> It is unlikely that this function will be ever called
> with isk->inet_num being not zero.
> 
> Perform the check on isk->inet_num inside the locked section
> for complete safety.
> 
> Fixes: 9b115749acb24 ("ipv6: add ip6_sock_set_v6only")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

