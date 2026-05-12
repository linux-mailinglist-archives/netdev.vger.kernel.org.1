Return-Path: <netdev+bounces-287095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAO1GAQLA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:12:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F9851F1DA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D789430071CD
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A7343D66;
	Tue, 12 May 2026 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CVdKx6OE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CtJKnvtu"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A7349CD1;
	Tue, 12 May 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584183; cv=none; b=QjB4dVeuFbopNrZFgTGIfvOVTYQ7Km17UzMesVYYb33rTRl22KuyJw+XJ4XXdbG5xMsVgZpPMk19k5i8hGhBi5FC8G+2TfMNdSD9w1Xp0dY3UqvOm2Gv8U8nHRLg5pbPQ1EQuCkZUyWIBTlHeSGNgD7gd5K0siNYQohl+jfjw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584183; c=relaxed/simple;
	bh=H5Z9EQZQ2bDuVesIEqvRRn2unIwDk8pfBoJgs7vyKrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olHP13J8TM44XSIGutYRHN9nfqHQGyNffR0YZ4VmybE9ELeBLOVNLpsqlqhQMDwdr++PEh59Zb3JGV9VEPPyuR56w+B792BiugRaaR2TNq7mE0ZN70Ff6jwdDGbE08QomQLEtLRFWxtcEYMngc66M5/e7ZfEntR7rY3VzXTshpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CVdKx6OE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtJKnvtu; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 276317A00EB;
	Tue, 12 May 2026 07:09:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 12 May 2026 07:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778584178; x=
	1778670578; bh=ZjAPBkG3sfWpNIv+detbzhioPPQ2rmkdh6Hoytav/7U=; b=C
	VdKx6OE3BT4wby4U037bBHkfHJu64PNM1BShxw+HWGU6cKaOE0F6Tget2BmpH5T/
	mQOm9+1AE+AB3KOeHwJqLnbopPO51+KVZ4mnpy2uilaW73AY6GB45D90oNnxPXTb
	v0zfFjYDwsDas7a76VZO4meuILg3GkdLNznMYv+Yy2ac6ImCxPo8/K6jDaRLKvm3
	cbBE5TCt05Jyx/INtOw7FQBOsqml30SgPtRQp3N2EdEqGrGQzqSGH2sfSOekMRSi
	Xw8iQw4ySWxESmf4tB4lFyNBMMGZjVTuPJZpJKzc2tVUqKHypX0gfTonOkKR6QTD
	gaNKFk2kBPT0LvaT3KQvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778584178; x=1778670578; bh=ZjAPBkG3sfWpNIv+detbzhioPPQ2rmkdh6H
	oytav/7U=; b=CtJKnvtuHnRwV77ma/hGxey0qhGwQId0GGEE1SGaAT+sbCFPO6W
	R0Xo31j2+vS5XMElVlGpDHIC8Klc49ienftPtfepsUnffOvAkbRVQwWHM1u5ieR/
	Ct0LSF8Zw7maKoCN+pMgxYty9i8iJpwFw1kvYWiq15ufZHjMDbbrXVwJBsxC3CVr
	VUJvP2pnnmtqYnPI13O3KrP7DJSQ7JiQ4YVMlh8K53EejeTJWWXu1NLSqecS3Dsl
	GRAzDqwZWnG4G9VtakWtG06icTKf5W8YZCELPEP+mvwI/ERHRpy2Ux1t5TNUWP/f
	t0SkdgE78QvSq2Y5RYvQCetGy0jQAb3gAdA==
X-ME-Sender: <xms:cgoDapSHnHBTMftz7cGyJUyW2lDeYuy-sLZKq-c4tr1Xe5WuOJDELw>
    <xme:cgoDakXvkhuTP5i2kZcvJbY-sEOMJRF5KSDvF_5zN7ScgooP0DWyvtz56YrAdMBru
    9sDQ56Ml85Z9teykC_X1vwSbM7krDOlYzbbAgaBO4uuS05CPWadkw>
X-ME-Received: <xmr:cgoDauF0rnBM8gp-IdXlbRiScT4eixXFXouFwAK3njpJ9QhbMNA5T0k73IbWaIlYUcqP_T_uJeBACFBWccSld9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgv
    thguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cgoDane7tL-LdOcGVDUBdiqPCW6AEDmpHKYv8Rv_qY5APu3lsjQU_Q>
    <xmx:cgoDanrJrc3y4XS-qLbWWZ3vOvpkTEuRVF9p6phOOl06nlB2JCR7cQ>
    <xmx:cgoDaoDj5JAQFT9_MOs7N0U-9MeD9aNu5oPDT0QKm4MFWUvMFaVWSg>
    <xmx:cgoDagf_yYwEEQsWyrFRzdbfrMujGkddTzGuFaMEzMwPxy20tgv52g>
    <xmx:cgoDamllhoGDF8eqXfM3JiXpZCZXvou172fGPbL8pYNRena1JyR-nPJ4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 07:09:38 -0400 (EDT)
Date: Tue, 12 May 2026 13:09:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	john.fastabend@gmail.com, bpf@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, daniel@iogearbox.net,
	jonathan.lemon@gmail.com
Subject: Re: [PATCH net v2 2/4] net: tls: prevent chain-after-chain in plain
 text SG
Message-ID: <agMKcBrJYK5UIcsZ@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
 <20260511174920.433155-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511174920.433155-3-kuba@kernel.org>
X-Rspamd-Queue-Id: 77F9851F1DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287095-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,iogearbox.net];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Action: no action

2026-05-11, 10:49:18 -0700, Jakub Kicinski wrote:
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 2608b0c01849..3bfdaf5e64f5 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -789,21 +789,33 @@ static int tls_push_record(struct sock *sk, int flags,
>  	i = msg_pl->sg.end;
>  	sk_msg_iter_var_prev(i);
>  
> +	/* msg_pl->sg.data is a ring; data[MAX+1] is reserved for the wrap
> +	 * link (frags won't use it). 'i' is now the last filled entry:
> +	 *
> +	 *         i   end              start
> +	 *         v    v                 v            [ rsv ]
> +	 *  [ d ][ d ][   ][   ]...[   ][ d ][ d ][ d ][chain]
> +	 *    ^   END                                     v
> +	 *     `-----------------------------------------'
> +	 *
> +	 * Note that SGL does not allow chain-after-chain, so for TLS 1.3,
> +	 * we must make sure we don't create the wrap entry and then chain
> +	 * link to content_type immediately at index 0.
> +	 */

All this wrapping with extra "hidden" slots is so confusing...

> +	if (i < msg_pl->sg.start)
> +		sg_chain(msg_pl->sg.data, ARRAY_SIZE(msg_pl->sg.data),
> +			 msg_pl->sg.data);
> +
>  	rec->content_type = record_type;
>  	if (prot->version == TLS_1_3_VERSION) {
>  		/* Add content type to end of message.  No padding added */
>  		sg_set_buf(&rec->sg_content_type, &rec->content_type, 1);
>  		sg_mark_end(&rec->sg_content_type);
> -		sg_chain(msg_pl->sg.data, msg_pl->sg.end + 1,
> -			 &rec->sg_content_type);
> +		sg_chain(msg_pl->sg.data, i + 2, &rec->sg_content_type);

Probably a silly question: why do we need to chain the content type?
Could we just drop it directly into the right slot of msg_pl?

(I'm also a bit puzzled by the "last_filled + 2"/"end + 1", because
that would leave an empty slot between the last_filled slot and the
content_type? and maybe even overwrite the first actual message chunk
if we had filled the message?)

[all this could quite possibly be bogus, which I think isn't a good
sign for the maintainability of this code]

-- 
Sabrina

