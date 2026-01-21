Return-Path: <netdev+bounces-252019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGZIK7MmcWmqewAAu9opvQ
	(envelope-from <netdev+bounces-252019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:19:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE15BFE8
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C572F8486F0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFCA4A5AED;
	Wed, 21 Jan 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="EA221Aak";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/6xA37V"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8549690A;
	Wed, 21 Jan 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016074; cv=none; b=V5OAITt0LPaNp+gpVlM5THJ/YLRba5WlEsxAzChV15tdhylu6zVhiKAsPuWOXuqPn4f5aZ/ayXDomQoMdB0VHH2NqphHqPkSI5usDoAW/cQd0LNkx0Gr3XmI0a9ExL/AZbcAc2E7TRXtqCaFvpIb1yttiye0pU1/KyMPlrGGnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016074; c=relaxed/simple;
	bh=hVozr/UAze3F0ZukkBIDoKX7V9cDW4MB3uwxpn0t5cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyXQkFSokLgCc6j4dF4Zry9ooLxVQ6BlNAjnAWoPYTQ6qsJR/oxJ1gPD8xnoR+7wVgQ9KhamyQYbBeJOjIsdUYW6QdL9PJ1EdhrH+RA3K51xdgSjsgqms/kvQ9+s3/BQLMzIfxWDsrN3h+da3mkaKiac70w9JS78KeuMubVVVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=EA221Aak; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/6xA37V; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D7B41D003A3;
	Wed, 21 Jan 2026 12:21:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 21 Jan 2026 12:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769016069; x=
	1769102469; bh=9T5Cog/dLzaoPDeo3aK2X6a5C6BvZXYMr7KZk1YmWjk=; b=E
	A221AakZhh8hkGn3DxeDhJHm3K5KtJ5mhTx940AdHbFc81KZON2mUhPtUsMphPWj
	pRpg3MLk09i7T01wwmqVKtwgUCPpXX5Ud7SJvplaPnQEauvoJmS/Me/c7x7ZdfyA
	dVYlOSpjuWErVysjBSPN5lj9YuWx/9pTDxU+8km8ZQSFyiHIZE/lMp+qEvHzO6sh
	F1iZWiJWfHAiq7apzV27R1IaFEt8k0FE1Jt6qkM2HGiz9lN03EFfXuB2TWff63AL
	PUeiSaAVhnRlGHz0Q/eTPZNPQVjYRpaFuHvAQVGFZY6fjYsbdY7tErHWM5cwuL2c
	ZBiTxt9wp0zVQoqGJMc7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769016069; x=1769102469; bh=9T5Cog/dLzaoPDeo3aK2X6a5C6BvZXYMr7K
	Zk1YmWjk=; b=g/6xA37V8999oqJwIZaSxJQs0TqMR1sXFe7N0ba/mBVFHngJ1mV
	IAyx0WOR1hsRAKTaXFXMCMsgC9H46tYAEWUFh/UmmA9AY6vTN/IIx4Kf4JY3Bw6q
	EbmaPdKwhMequs4UxmV98gqZys/UlmNeBmTRX7l53eAnTcTBDhmeR7krHo+XG1yF
	f0EBaaRRYw3H6AU9CryaSmRsiBzSMTLCQDOxpxMQBlQaNHNx81mTXccT+MQzs/bx
	EJYOMeyW9n0Zcli/Lhq2LTc+Yl586eYmSLMuu3NwctQNhX6k9eWCoDTkzfeNUI5u
	uTy7fnkva44IaTI01jZvuMaPXGsnC00GVng==
X-ME-Sender: <xms:BAtxaSSKchQxO5lcRmk5vFOM5cosymiqQV1672daPqJWQRr0KTyLgg>
    <xme:BAtxaScCt1B2cXVeQ-bLubRKlVMISGeR1LgSw85YlFHw4Bq2SzhkzHZZeMwtURhKB
    jvz5FHIHNAZT0AL-jk1sB_ez4WNUdYdWpI-Mq0sdSJbGRP4B-53snoo>
X-ME-Received: <xmr:BAtxaWenjqTibrpHBWbTMaE9pZrXPIj0pjcqC6lvUD6ehi24MUoyPqySC4Jp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepihguohhstghhsehnvhhiughirgdrtghomh
    dprhgtphhtthhopehmmhihrghnghhflhesghhmrghilhdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfi
    donhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllh
    drohhrgh
X-ME-Proxy: <xmx:BAtxaY9sQH0auz3CYOgcnXubjtxhaaA_4W1Ve7leOIr3aTeiEo5cMA>
    <xmx:BAtxaWPSaZbvxd9azNi5f8SOyVWJ2Lfoby9SVEu8NwE9mTjeXxSEAA>
    <xmx:BAtxaWUdck1Uqr_ZWBtNpPhZo3xm01BMoMUSE0kk-AO7HytKXAYg1Q>
    <xmx:BAtxaWgB0so-k0p_LjrX4jS3rTFNfv4yOICIZGlHLwqHjoxAwOJf1g>
    <xmx:BQtxaasD_IhRgwcxmbMQYxDD7YYFGQKZ1cWpIB3WBxYhZjtx56-EawUw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 12:21:07 -0500 (EST)
Date: Wed, 21 Jan 2026 18:21:05 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next 0/4] u64_stats: Introduce u64_stats_copy()
Message-ID: <aXELAazPe7G5M6am@krikkit>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
 <20260121111635.GA447040@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121111635.GA447040@shredder>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,nvidia.com,fomichev.me,debian.org,lists.linux.dev];
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
X-Rspamd-Queue-Id: 57CE15BFE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-01-21, 13:16:35 +0200, Ido Schimmel wrote:
> On Tue, Jan 20, 2026 at 05:21:28PM +0800, David Yang wrote:
> > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > against load/store tearing. memcpy() should not be considered atomic
> > against u64 values. Use u64_stats_copy() instead.
> 
> The existing memcpy() does seem problematic (even if in practice it's
> not) and the proposed solution in patch #1 seems OK to me given that all
> the callers only pass structures containing 64 bit counters. Couldn't
> find any more instances of this pattern.

No direct instances using memcpy, but do we need to also full structs
copied within a u64_stats_fetch_begin/u64_stats_fetch_retry loop?


// net/mpls/af_mpls.c
static void mpls_get_stats(struct mpls_dev *mdev,
			   struct mpls_link_stats *stats)
{
[...]
	for_each_possible_cpu(i) {
		struct mpls_link_stats local;
		unsigned int start;

		p = per_cpu_ptr(mdev->stats, i);
		do {
			start = u64_stats_fetch_begin(&p->syncp);
			local = p->stats;
		} while (u64_stats_fetch_retry(&p->syncp, start));
[...]

// net/openvswitch/datapath.c
static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
			 struct ovs_dp_megaflow_stats *mega_stats)
{
[...]
	for_each_possible_cpu(i) {
		const struct dp_stats_percpu *percpu_stats;
		struct dp_stats_percpu local_stats;
		unsigned int start;

		percpu_stats = per_cpu_ptr(dp->stats_percpu, i);

		do {
			start = u64_stats_fetch_begin(&percpu_stats->syncp);
			local_stats = *percpu_stats;
		} while (u64_stats_fetch_retry(&percpu_stats->syncp, start));
[...]


And if not: can't we just use the same pattern for those other cases
that this series is touching?

-- 
Sabrina

