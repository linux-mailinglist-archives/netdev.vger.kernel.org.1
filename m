Return-Path: <netdev+bounces-285665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK00CE1+/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:10:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660A4F2432
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 073B5304CA45
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D773C376BD9;
	Fri,  8 May 2026 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YxqGG18w"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E97343216
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219859; cv=none; b=ShEv5ZJ5b0rhaTPTK+YWxqkY2Cb7MqNabl91RnOHYZ4QVxP5IVwTQ4IMDkLfKp1YWHJuOLOBMIMh0taecIjlZWY53jI520fGv6omtz2PNNH8KbBqEqm3EsTFGDkcvNiwYKLRiH3knTJCxzcbsiggSxswHOkf4naCjbH/ObRtX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219859; c=relaxed/simple;
	bh=Q8iQ5oKYpNWlooeXbi/5OQ4Oh8nrDr0N3nkHem0tgo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO7lhHS1MpO7CfBnrmVbt2NOtiyBUjR8Asl4ETEPloKRvt/MwINpsFlzvO34cqJE6INWTOxvyK+5exsHTDVdmqn9PeKaK6yVy38+cZySc3KX+J7KlT5DdPT3yNaEeZNFCJT2CduU7i4aOELaZP8MbF7/PBrriyGMGVss8gbkJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YxqGG18w; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778219843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ct2pIyRxDBx3gdYX08AC7c84QzUSggtk08N5J4OSxrk=;
	b=YxqGG18wjkfF/AwKXpU1WOIL4dNkfs3hh1218lMQD5a0BT0vSVI09luslPQTOWesDT3Jzt
	O2FcaMOKNScvCFgombZao1Gchz+ournPNCZmqwy5PL8lUbnINxZ4JS+6Pm2fKTosp++aOJ
	YK83CGlW4iMxjUyOu5b+28HrgnKmRWA=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
Date: Fri,  8 May 2026 13:57:15 +0800
Message-ID: <20260508055716.89380-1-qingfang.deng@linux.dev>
In-Reply-To: <afKV2zGR6rrelPC7@v4bel>
References: <afKV2zGR6rrelPC7@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 4660A4F2432
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285665-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On Thu, 30 Apr 2026 08:35:55 +0900, Hyunwoo Kim wrote:
> 
> The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
> handler in rxrpc_verify_response() copy the skb to a linear one before
> calling into the security ops only when skb_cloned() is true.  An skb
> that is not cloned but still carries paged fragments (skb->data_len != 0)
> falls through to the in-place decryption path, which binds the frag
> pages directly into the AEAD/skcipher SGL via skb_to_sgvec().
> 
> Extend the gate so that any skb with non-linear data is also copied,
> ensuring the security handler always operates on a fully linear skb.
> The OOM/trace handling already in place is reused.
> 
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/rxrpc/call_event.c | 2 +-
>  net/rxrpc/conn_event.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index fdd683261226..6c924ef55208 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -334,7 +334,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
>  
>  			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
>  			    sp->hdr.securityIndex != 0 &&
> -			    skb_cloned(skb)) {
> +			    (skb_cloned(skb) || skb->data_len)) {

It's recommended to use skb_is_nonlinear() instead of open-coding
skb->data_len.

>  				/* Unshare the packet so that it can be
>  				 * modified by in-place decryption.
>  				 */
> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index a2130d25aaa9..eab7c5f2517a 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -245,7 +245,7 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
>  {
>  	int ret;
>  
> -	if (skb_cloned(skb)) {
> +	if (skb_cloned(skb) || skb->data_len) {

Ditto.

>  		/* Copy the packet if shared so that we can do in-place
>  		 * decryption.
>  		 */

Regards,
Qingfang

