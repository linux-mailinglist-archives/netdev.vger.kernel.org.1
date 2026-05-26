Return-Path: <netdev+bounces-291561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNh7Ed5GFWqLUAcAu9opvQ
	(envelope-from <netdev+bounces-291561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:08:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40AB5D17F2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C178A30421D2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00303A8759;
	Tue, 26 May 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HbEFYb+B"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A3380FFA;
	Tue, 26 May 2026 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779127; cv=none; b=rRjed+KHczlPE4VK0R60ioCS+OWW3yc7Y4qOoPkjebZ6FtQWqYBX1gBXY5DXtOOzEj8YL23Fz61SmUHXJWpHtyNi4nDV3wQjRifNywYeHrc8DgcjwDB8imoKzbTxmXT1vuskCQZwdBQcb/ZzgEYwyIOg/avKgXktpnX+w3mnlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779127; c=relaxed/simple;
	bh=f8DAXXyWti0by9Cv8DO/3OvZeHRksUoTa8mEZPQtEtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2UF2YruV6wMoNCUwH5lTcJLBGLOO94PPHkww7UtQpWwDReLUklKhkfB5hreTYaEmyzIEAUzOnzew02UyIytEuYRhnVdywfvkig8mrdHLjAiUgZHwbol26U2+LQKTnDB06BxS8fYrrRgziu0zmcCvvffpJzizLWzkL7HNue/+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HbEFYb+B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3h4K0TLKBXuTZOqjfG5ALM/iez32lKAxf/EnmrS4GuQ=; b=HbEFYb+BQED2m5cwh4Qfezy2uu
	RHdVurecujysFtkOIUjSWShhrA6u+r2GnXZRN8HkJvdFRP0la/7ylZY3CZPWxR1wxxV2BCDSYozE+
	gegJgRFBhaaMyQZAMF7Wa31Xs7DuK1TQE7G4GOraq5XXQi+H9sUleRgAo6J94vchPIdNiP4TVp6vR
	BVlKGM1Cv+i2wIxNkpPXYoqjgmEcPrxEltsKPrnvRtaJcV8ncDQQmhmYpPNmzjqNLoK6Fb6uqzw/D
	zs99xAqjmkwAEOVj0OMVJF6+I5QRrq1pe45/9tMaVYDTFMf2edMfG36JjLQEsGuT3EQviKZWlDHCB
	GzC7LYmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRlqv-00000001ECT-0Lij;
	Tue, 26 May 2026 07:05:25 +0000
Date: Tue, 26 May 2026 00:05:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Yeonju Bae <iwasbaeyz@gmail.com>, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, security@kernel.org,
	john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH net] tls: avoid zc receive for file-backed pages
Message-ID: <ahVGNWX0j5D-ZEbc@infradead.org>
References: <2026052150-stylus-germicide-780e@gregkh>
 <20260521165328.16112-1-iwasbaeyz@gmail.com>
 <20260525105459.5ae73c2b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525105459.5ae73c2b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291561-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,gmail.com,vger.kernel.org,linuxfoundation.org,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: A40AB5D17F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:54:59AM -0700, Jakub Kicinski wrote:
> > kTLS RX zc decrypt writes unauthenticated AEAD output directly into
> > pages pinned from the recvmsg iterator via tls_setup_from_iter().
> > For MAP_SHARED, PROT_WRITE file-backed destinations, those pages are
> > live page-cache pages rather than anonymous copies: MAP_SHARED does not
> > trigger copy-on-write, so FOLL_WRITE returns the actual page-cache page.

As does MAP_SHARED for any other mapping.

> > via COW; PROT_READ-only destinations fail at iov_iter_get_pages2()
> > before any decryption occurs.

Btw, this really needs to stop using iov_iter_get_pages2 and switch to
iov_iter_extract_pages / iov_iter_extract_bvecs.  This does not fix
your probleb, but other potentially exploitable races.

iov_iter_get_pages2 and friends must never be used for writing,
and preferably should go away entirely.

> > Avoid zc receive for file-backed destination pages.  In
> > tls_setup_from_iter(), after iov_iter_get_pages2() pins pages, check
> > each page with folio_mapping(page_folio(page)).  If any pinned page is
> > file-backed (mapping != NULL), release the pinned pages and return
> > -EOPNOTSUPP.  Handle -EOPNOTSUPP in tls_decrypt_sw() by clearing
> > darg->zc and retrying, which causes tls_decrypt_sg() to allocate a
> > kernel bounce buffer instead.  Decryption output never reaches the
> > file-backed page; on tag failure the bounce buffer is discarded.

I can't see how this is not a problem for non-file backed shared
mappings.


