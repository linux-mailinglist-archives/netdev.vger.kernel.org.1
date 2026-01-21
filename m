Return-Path: <netdev+bounces-252020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAuNEDYjcWl8eQAAu9opvQ
	(envelope-from <netdev+bounces-252020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:04:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AD65BC47
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE368849447
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88376357A43;
	Wed, 21 Jan 2026 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ueUyeBnK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uoI6yzBf"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080136C0CB;
	Wed, 21 Jan 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016226; cv=none; b=Xs2pJpsDDHWmX3ZuiMWxOMjbHjgesYCwukUOYVZ670DFHq+Td16F6mk4EO1NC8u56ME1kvL1UVlNBll9rLbdQVkd+ebqWZSDqoCfH+2cPkl4SxnCpDNf8KTbYhzL73AN1Gek2uM0UPGhfNotLC6aWmmr9bfPsINMh/O/9TXA1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016226; c=relaxed/simple;
	bh=DI63OJLiL9+FOfW93ih89bL5fyQaHnraiigjO/95iCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1tWftGtfY63HNZc/t89qZ63zdYNqnKqmvM7NjdfkJ3n5w0godxfFH9ZOd0o28tKfs3lJF0FqJvHqrGSVMBZZ+PIFYqNRuS2jNSLOsHGm6sH+zmzbsJg69GQjj83GO16xnU34XJ8eZUgL7cUbBJsDbhUXVN7Al6rMU8Vx30R61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ueUyeBnK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uoI6yzBf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 704CD1D00297;
	Wed, 21 Jan 2026 12:23:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Jan 2026 12:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769016223; x=
	1769102623; bh=hWIjHUQ/3+eV2KIHriZDhTusV5/FSAT4CPLcsSVcmf4=; b=u
	eUyeBnK0MCj83lyVejZFGMycRuqiYVSH4UZs/PsevyxmmFphWX2pxAUgx/IJkrPP
	J/ecSUCsgzKTO9JYF4kr4qn9rs67S3hfI6qW6JRREaOQ1jnlGe7GNGRdcOY/I00+
	MGG/Ml50zdZendNSLm8YGZTR2FEZc8bJMxnBRuenpam+hT5FkZZweW398tEUkLL7
	KWmR3ScACJsTm5zwTWDU9bAFr/d5Y4lT/kH11/Fy2XZOPO2AOH8jB9jk7bPQgrQ4
	YBNvZ8O6p+yvc8SHwvPgNsodjVsWGOan7/wo8trwWI6MsmcIRI4nAWP8fGJuYUWa
	AKyy7ytArkyPxthTRl3IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769016223; x=1769102623; bh=hWIjHUQ/3+eV2KIHriZDhTusV5/FSAT4CPL
	csSVcmf4=; b=uoI6yzBfxFBZEB9CRRVZvjiiBkTMdoyr73tb7uABP6D5UvJLOIc
	IsPSSjzuI0X3v7DtBope4m5HGlhq090BWG32nnSyq39J820YDYDAOqJ+ovapeigF
	Aqf6tQF9B0RHAt8Iz0xRbPqS6BrsjB+hSaLoxBK3tsXYyv03oxNoMwMRce2R7azx
	2glI3wl0fHUEJamijkZ82xZZRzF/TyEbVjQCmbRW+sHrIcAaaC4UQXiz8z8aW66a
	FHb429nlYM/QqdHGS77WVX18UH+xHsKw9CpQ2+I2I/3zfhhN06WmOzshxOiU8UaP
	TXx2cdEqgwaKBcZle7ZEZXVeb8oT2nhYEhQ==
X-ME-Sender: <xms:ngtxaaoTSvEw0LWMpvZMkyZKs4AuCvVu2T8i0ZzVzjuHY3Atk2iw5w>
    <xme:ngtxaTX0kvlghHk6ggEpaxfwgwJQzJfw92C6VFk1k_44jvaqUBV2Es5Qe7YI-_asa
    TLW7F1H__hZh1NxwTuUw6kN5c7M4EuHDYrvv4b_VBmjPWORDAGWMw>
X-ME-Received: <xmr:ngtxaV1LlW6eS7mMj6w-1WSVqJd7F9e8I0_MOYbqPoE4qsLsgSuBEapz5Fj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhmhigrnhhgfhhlsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurg
    hvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrrgiiohhr
    segslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepihguohhstghhsehnvhhiughirg
    drtghomh
X-ME-Proxy: <xmx:ngtxaU1AK_Q9oH_qSVWRwocOXIgBv7Wsf5wjpLoSisR75y4XFeTl7A>
    <xmx:ngtxaUmuyikstuAC5EXuJYZz4zhgA2dRQLGDB6X7-md4sEFI-4S6Fg>
    <xmx:ngtxaVNiSD_qW1LVw34-mcrWg91_zoLQ0b0d8ybLbQNxVaochkqQZA>
    <xmx:ngtxab4uYzTb55nkxQ7qgRIyN5cF3hY1Mwi8fOL8WOHAT_vEVlBK9g>
    <xmx:nwtxaapqgE7vvR36iTe8hG0fBvfSgYcq7e8bLESo36fs7Kzq5aeUhmBp>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 12:23:41 -0500 (EST)
Date: Wed, 21 Jan 2026 18:23:40 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next 1/4] u64_stats: Introduce u64_stats_copy()
Message-ID: <aXELnMSc4UU6DkbZ@krikkit>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
 <20260120092137.2161162-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120092137.2161162-2-mmyangfl@gmail.com>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252020-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E5AD65BC47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-01-20, 17:21:29 +0800, David Yang wrote:
> The following (anti-)pattern was observed in the code tree:
> 
>         do {
>                 start = u64_stats_fetch_begin(&pstats->syncp);
>                 memcpy(&temp, &pstats->stats, sizeof(temp));
>         } while (u64_stats_fetch_retry(&pstats->syncp, start));
> 
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing, especially for memcpy(), for which arches may
> provide their highly-optimized implements.
> 
> In theory the affected code should convert to u64_stats_t, or use
> READ_ONCE()/WRITE_ONCE() properly.
> 
> However since there are needs to copy chunks of statistics, instead of
> writing loops at random places, we provide a safe memcpy() variant for
> u64_stats.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  include/linux/u64_stats_sync.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
> index 457879938fc1..849ff6e159c6 100644
> --- a/include/linux/u64_stats_sync.h
> +++ b/include/linux/u64_stats_sync.h
> @@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
>  	return local64_read(&p->v);
>  }
>  
> +static inline void *u64_stats_copy(void *dst, const void *src, size_t len)
> +{
> +	BUILD_BUG_ON(len % sizeof(u64_stats_t));
> +	for (size_t i = 0; i < len / sizeof(u64_stats_t); i++)
> +		((u64 *)dst)[i] = local64_read(&((local64_t *)src)[i]);

Maybe u64_stats_read/u64_stats_t instead of local64_read/local64_t?

> +	return dst;
> +}

Since this new helper is always used within a
u64_stats_fetch_begin/u64_stats_fetch_retry loop, maybe it would be
nicer to push the retry loop into the helper as well?  Not a strong
opinion. It would be a bit "simpler" for the callers, but your current
proposal has the advantage of looking like memcpy(), and of also
looking (for the caller) like other retry loops fetching each counter
explicitly.

Either way, I think extending the "Usage" section of the big comment
at the top of the file with this new helper would be nice.

-- 
Sabrina

