Return-Path: <netdev+bounces-260098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPKGITZ6nGlfIAQAu9opvQ
	(envelope-from <netdev+bounces-260098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:03:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2217948E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD30030354BE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517453090C1;
	Mon, 23 Feb 2026 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AOFkm0wS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ggPZbZK2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AOFkm0wS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ggPZbZK2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7F30AAB8
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862379; cv=none; b=H+YqEtMH6FbzflmM+55mm6naA9aRvA+3lK30BX+EpzyCGZ7Zpmq0b87Wnor2fnjNQ/uLXm95Z1F0PcXWbMpaxwxcQQyCoTtUBJGo1Y/9eLF4RxeHOD4BBbEyC2CZC2+skoACTBt1XoWv8wlYJq2DM9978AaV1SeBLWxTD7rig5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862379; c=relaxed/simple;
	bh=3DzJWG18UQD8BMkyzoVmPDuCb32UIi0DBzc1YMYn2/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPbX6jUKFkdaUIdGLC5I6reZXm93O69R9PWAqE6wSWHWSMNL3Q0H/bFHqGi0UFhwxaBwMDeIVmJqAVPRwNhDETyZjthXATESSEsuWoFY46HhwmvpfpDLC+sv1cHPuMXVoht8V+RFhgEo8G3u6ujpL5+Ri8FwIsFvy9r9t38EWgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AOFkm0wS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ggPZbZK2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AOFkm0wS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ggPZbZK2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45AFF5BE60;
	Mon, 23 Feb 2026 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771862376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfTADi7wOu0XPza4yRcEvmLbrPGNKl0T8wrL7OeuMro=;
	b=AOFkm0wSCOEnha8+QR/Vpfh0ZeEAXghtyysSx7F4sEE4AM7krYtxuMRLIgec6ZxA8vumCr
	fSi3LVe0G2d+kKoSEvHUZMgWCZUlT/JeW9JsVJ1dZzi90l4aIDtHPNcqmOuls528thWu/l
	nvz3pnScOiBlNBdhbe7xXaNwaGw/9yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771862376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfTADi7wOu0XPza4yRcEvmLbrPGNKl0T8wrL7OeuMro=;
	b=ggPZbZK27hqUwyWGKAxsJe93Jen5IKY+p4y1OfQ2nvzcBhAbCs/dZ7Syqo94aZdcZu3EN0
	KVsep1LivtLeswDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AOFkm0wS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ggPZbZK2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771862376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfTADi7wOu0XPza4yRcEvmLbrPGNKl0T8wrL7OeuMro=;
	b=AOFkm0wSCOEnha8+QR/Vpfh0ZeEAXghtyysSx7F4sEE4AM7krYtxuMRLIgec6ZxA8vumCr
	fSi3LVe0G2d+kKoSEvHUZMgWCZUlT/JeW9JsVJ1dZzi90l4aIDtHPNcqmOuls528thWu/l
	nvz3pnScOiBlNBdhbe7xXaNwaGw/9yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771862376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfTADi7wOu0XPza4yRcEvmLbrPGNKl0T8wrL7OeuMro=;
	b=ggPZbZK27hqUwyWGKAxsJe93Jen5IKY+p4y1OfQ2nvzcBhAbCs/dZ7Syqo94aZdcZu3EN0
	KVsep1LivtLeswDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C1C63EA68;
	Mon, 23 Feb 2026 15:59:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XF2zImd5nGlEVAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 23 Feb 2026 15:59:35 +0000
Message-ID: <7e8d2947-8e0a-4f56-8906-49a84cbe46a0@suse.de>
Date: Mon, 23 Feb 2026 16:59:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: move ip6_dst_hoplimit() to
 net/ipv6/ip6_output.c
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260223153342.892477-1-edumazet@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260223153342.892477-1-edumazet@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260098-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[suse.de:query timed out,vmlinux.new:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet.google.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: 68A2217948E
X-Rspamd-Action: no action

On 2/23/26 4:33 PM, Eric Dumazet wrote:
> Move ip6_dst_hoplimit() to net/ipv6/ip6_output.c so that compiler
> can (auto)inline it from ip6_xmit().
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/0 up/down: 47/0 (47)
> Function                                     old     new   delta
> ip6_xmit                                    1481    1528     +47
> Total: Before=25076476, After=25076523, chg +0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/ipv6/ip6_output.c  | 21 +++++++++++++++++++++
>   net/ipv6/output_core.c | 23 -----------------------
>   2 files changed, 21 insertions(+), 23 deletions(-)

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

