Return-Path: <netdev+bounces-285967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EsdHOVG/mlFogAAu9opvQ
	(envelope-from <netdev+bounces-285967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:26:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C944FB7BA
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC7C30115BF
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849E437C0F5;
	Fri,  8 May 2026 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpL3G3KY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6122F284662
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271934; cv=none; b=l+B67PPXKDcGEcuHnsOMFeOzf9cpUsv/Mw/O6ACg+1Lz0bv+woa5CJVE5ZJj4MyacgQfy5k9WEoAB3d/0xZUo7Qdhc6evqRjCEmHiV3C3hoq3eQ1kxNwVAVFhNm7o1rmPYUrVZbSNT1ebH+0KcSM2xXGHtLkWvGtLDkSijZnOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271934; c=relaxed/simple;
	bh=K0V4rsSg3ck28HBMMEO+ld3HMWVJ+vBsRlwyAok0kGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWxJw1ZTSjlWQQJyj9ikjI0yXifsWO28XOCwWvvkk1c+Q1xip5uNGlY9laEgNpaeZYccu1Bn+4zdJ8FuIukHKvHBa55RO47SmpeLz8j1FBBUdY3mL2NiYtJDQKZhMF9QLRsrNabsTDHS4EjDYGyx+kxluNPMQZyqWvW+o+l1xDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpL3G3KY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83863C2BCB0;
	Fri,  8 May 2026 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778271934;
	bh=K0V4rsSg3ck28HBMMEO+ld3HMWVJ+vBsRlwyAok0kGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HpL3G3KYsrbhNN2VS2A73NmJb0rRs96adEAOMPrc5cNnd3Jn3fUpPLHgV8nnixbr1
	 bk4PiXZ+gahL5ACx4EE/lljbTh9EM6n37UmdbfZ6iH7JL0obeqsgjCKZKJUFLHnYq1
	 XFXF1W9KxL8jJrrrUjt7F3C1kgg1qmYgz6MGPTKrD9DNRPaFfCRsGWZPjycFyuvuh2
	 PmXWwVxWyFpFDg5awImtZcptCf5ikYHgfxPXMhrlEHjBrxn4i3FbMuNAMeKoYynEbL
	 VWi6upE/qFrEZXVKO8zWkhIP4DffvghoKDr0n/BS+V56toAJVgU53J7/yirmtgkk1f
	 mLQ6tkDKLwf9w==
Date: Fri, 8 May 2026 13:25:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Qingfang Deng <qingfang.deng@linux.dev>, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-afs@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <20260508132532.2008a68f@kernel.org>
In-Reply-To: <af19tf9gX3sxIrWr@v4bel>
References: <afKV2zGR6rrelPC7@v4bel>
	<20260508055716.89380-1-qingfang.deng@linux.dev>
	<af19tf9gX3sxIrWr@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F0C944FB7BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285967-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 8 May 2026 15:07:49 +0900 Hyunwoo Kim wrote:
> > > -	if (skb_cloned(skb)) {
> > > +	if (skb_cloned(skb) || skb->data_len) {  
> > 
> > Ditto.  
> 
> Thank you for the review.

Maybe skb_ensure_writable() ?

