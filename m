Return-Path: <netdev+bounces-292219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEvwCqq/FmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:55:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7265E23AD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 997E33096EDE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097D3EDAC9;
	Wed, 27 May 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v/fREzOd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kbfVHoq2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v/fREzOd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kbfVHoq2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C43B3C06
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875189; cv=none; b=UYUSL+0ELxnfsFlnO/DdEbHSzVzGQ1qOUQezj4MAyxgUZ3lf6k3LSjQ7+Yy0jA3cwrpheiXQr+h2WoXInA+Q1m6/L6oPIPstYxAsf2+qkEfBAhiPK2EM+Jr5VVaoTeiYJgMAYJgfohvOaTy6fN8gRxXOx5VFTbaNJJNDnFZPFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875189; c=relaxed/simple;
	bh=P0gbLrjpLk3LPdZL5HvrZ56iDHMpCmHGsz0XDv1QZQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3w7KYbmwxqeeDkrMFZJEpEXhZIAd/tr7INU5OUdhe82lytjEn9PWL+Q/FGfPucydUBObsabJbGVb+7p+fNZKjdm3W2VLFWO+ozirGCp0AuToh+MRyOvWXCcpR9L/aarlFa+PN06BBcvzo6nIRJ2o32HjVHMNZNQrsLb7Qnq/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v/fREzOd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kbfVHoq2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v/fREzOd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kbfVHoq2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FF986B058;
	Wed, 27 May 2026 09:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779875182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNq+E6iNRAn6IT78E+OBYybuayEnbVbjrSvewBRbWOE=;
	b=v/fREzOdcR1yyao9Kuc0L7z+XA1f9exREfLMXzegvULYZHVJVpPOY2U/OrejXD6OqniekA
	VcLqElRjOX/A0rXi/l8OH/P+Im+mjXwjJz53nNrvh4Ze2hpl8UHObF1NA+c8JtNJFU85uU
	LW3fMkUEyRCUfnjGDxvE3zne3UuEbvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779875182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNq+E6iNRAn6IT78E+OBYybuayEnbVbjrSvewBRbWOE=;
	b=kbfVHoq2wRZPP+KKxUDsrmeO/xq4V5ziM4p4h8F45Dk39UpZ56uRD9wlOYLgAfou+APWaT
	/NcZj1p3DQlNV2AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="v/fREzOd";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kbfVHoq2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779875182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNq+E6iNRAn6IT78E+OBYybuayEnbVbjrSvewBRbWOE=;
	b=v/fREzOdcR1yyao9Kuc0L7z+XA1f9exREfLMXzegvULYZHVJVpPOY2U/OrejXD6OqniekA
	VcLqElRjOX/A0rXi/l8OH/P+Im+mjXwjJz53nNrvh4Ze2hpl8UHObF1NA+c8JtNJFU85uU
	LW3fMkUEyRCUfnjGDxvE3zne3UuEbvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779875182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNq+E6iNRAn6IT78E+OBYybuayEnbVbjrSvewBRbWOE=;
	b=kbfVHoq2wRZPP+KKxUDsrmeO/xq4V5ziM4p4h8F45Dk39UpZ56uRD9wlOYLgAfou+APWaT
	/NcZj1p3DQlNV2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 528AC5A77D;
	Wed, 27 May 2026 09:46:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZFZAE269FmrRQQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 09:46:22 +0000
Message-ID: <9db08da7-316a-4914-b70d-383933f248c0@suse.de>
Date: Wed, 27 May 2026 11:46:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/6] tls: Avoid evaluating freed skb in
 tls_sw_read_sock() loop
To: Chuck Lever <cel@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
 <20260526-tls-read-sock-v11-1-244fe1dc4abd@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260526-tls-read-sock-v11-1-244fe1dc4abd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-292219-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim,grimberg.me:email]
X-Rspamd-Queue-Id: 8F7265E23AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 16:21, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> tls_sw_read_sock() ends its receive loop with while (skb), but
> the else branch in the body calls consume_skb(skb) before the
> predicate is re-evaluated. A pointer becomes indeterminate when
> the object it points to reaches end-of-lifetime (C2011 6.2.4p2),
> and using an indeterminate value is undefined behavior (Annex
> J.2). The pointer is not dereferenced today -- the predicate
> either exits the loop or skb is overwritten at the top of the
> next iteration -- but any future change that adds a dereference
> between consume_skb() and the predicate would silently introduce
> a use-after-free.
> 
> Replace the do/while form with an explicit for(;;) loop so
> termination happens through a break statement rather than
> predicate evaluation of a freed pointer.
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/tls/tls_sw.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

