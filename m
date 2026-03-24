Return-Path: <netdev+bounces-270966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHSaIwRiwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:05:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD2A3062E0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 111F730379C2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D9F3DDDC1;
	Tue, 24 Mar 2026 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxwmUWHi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="syeEvkFr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxwmUWHi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="syeEvkFr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958363DCD88
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346134; cv=none; b=TU+Ky3NAyQWSBtGATxZozN3wW5LygAOI59p2TAgv/jhi8gwuoB3grEBeq9ANq7IZMmWTNllPJ0OMaYCljDb6z/2T6dNfFFfeJ1nkqEi33MgCEJZTfZdlC3xSYhm2aBv3Gbli4V6pouV5DVIRi3loCgjzK2t7MYN/0KteJolPaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346134; c=relaxed/simple;
	bh=kQXSrqH+bBHyZU8Ikga3QmufCvLi6niQGDxpCGfL+3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJpDGJtvo8ol9Quoz0rJujLahJ40JhlwNZ7GSJLhQbMNdL2/KY5XPWKFJd/Xo5dwJtuOS+JgICqK/Fu9LHe3oQOMMzxtf8fpVBpzejQ+vkZFOAeoitpzh9jfosxpjQsEsV/PaxskEOxIjk8IwYz9QetfCSjOe/tmMzV8IlymoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxwmUWHi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=syeEvkFr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxwmUWHi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=syeEvkFr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B965D5BCC1;
	Tue, 24 Mar 2026 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774346130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3RmIUNecDumCgUvYIUS8Oe2HB5G8HAfqwqqKdnkiQ=;
	b=SxwmUWHiFIemAPlF+oRiBFnJe+AXQp9/6icj/bRaV4SLehFhB2ipHkQBmiC/zTVJZjOjU0
	EDntxw0h0Von9GJAbfM8YUEvzclQta9Id02u7E6yldgubXN73dQrDdJOJEq1a+kWEot9wy
	2ZJIpyp0O3LgN9ZtsSRfKmQA/ZlxyCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774346130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3RmIUNecDumCgUvYIUS8Oe2HB5G8HAfqwqqKdnkiQ=;
	b=syeEvkFr6rwPEOFGGZd35V/arJSKlQGdF/T+VsIw0c42v1hD1v235e2ZVyg0IN98DgdIYO
	ckH0nAgRfpL20ZBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SxwmUWHi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=syeEvkFr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774346130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3RmIUNecDumCgUvYIUS8Oe2HB5G8HAfqwqqKdnkiQ=;
	b=SxwmUWHiFIemAPlF+oRiBFnJe+AXQp9/6icj/bRaV4SLehFhB2ipHkQBmiC/zTVJZjOjU0
	EDntxw0h0Von9GJAbfM8YUEvzclQta9Id02u7E6yldgubXN73dQrDdJOJEq1a+kWEot9wy
	2ZJIpyp0O3LgN9ZtsSRfKmQA/ZlxyCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774346130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3RmIUNecDumCgUvYIUS8Oe2HB5G8HAfqwqqKdnkiQ=;
	b=syeEvkFr6rwPEOFGGZd35V/arJSKlQGdF/T+VsIw0c42v1hD1v235e2ZVyg0IN98DgdIYO
	ckH0nAgRfpL20ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5516443D95;
	Tue, 24 Mar 2026 09:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hNXhEZJfwmm3QQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 24 Mar 2026 09:55:30 +0000
Message-ID: <08247bfa-b67b-4c66-aa09-71ebdbca0df0@suse.de>
Date: Tue, 24 Mar 2026 10:55:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>,
 'Daniel Borkmann ' <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <20260323225250.1623542-1-martin.lau@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260323225250.1623542-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270966-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FD2A3062E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 11:52 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> bpf_prog_test_run_skb() uses net->ipv6.ip6_null_entry for
> BPF_PROG_TYPE_LWT_XMIT test runs.
> 
> It currently checks ipv6_bpf_stub before using ip6_null_entry.
> ipv6_bpf_stub will be removed by the CONFIG_IPV6=m support removal
> series posted at [1], so switch this check to ipv6_mod_enabled()
> instead.
> 
> This change depends on that series [1]. Without it, CONFIG_IPV6=m is
> still possible, and net->ipv6.ip6_null_entry remains NULL until
> the IPv6 module is loaded.
> 
> [1] https://lore.kernel.org/netdev/20260320185649.5411-1-fmancera@suse.de/
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

LGTM!

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

