Return-Path: <netdev+bounces-270576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLrgGG1awWnbSQQAu9opvQ
	(envelope-from <netdev+bounces-270576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:21:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA252F62E4
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A36E33A2C30
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8923B38BC;
	Mon, 23 Mar 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PbwFVq1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KpERMpnD"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06773B2FE9;
	Mon, 23 Mar 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278186; cv=none; b=F72CnjNMDnwnsCoBSguf1HrSh3JqonbbLv5A1W2BC02G1QwDG7xLLrrk8ifIiiKK6kPk2P+6JNMlXBWUEd6wFkFLNerFe2xwIzkK2bgDT5fKSZdi/nBq9AIry75416GChPkbr70ZA8nfN8NG4xc4dWuUOzPj8wGLonGNS+yjATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278186; c=relaxed/simple;
	bh=SNxjJzUyfHQgpxL3kdLhE0O7BoNK4M784+ioh0vuBqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiv7qiaSIE37XTluJkcIGeYC+0w1QMRhvdHp7Vav2+RjecN60bwalJNofUQ9z68TfI3mzttseBGP0gGhqLD4AKXX/AvVl1QRJrlgF1GywnzzDMxrSlxTTTON0EpuwCuBUkO3R00oSIX7JUrIG4JPyWZWai3yFO07G9DWyrygLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PbwFVq1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KpERMpnD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CD657A0155;
	Mon, 23 Mar 2026 11:03:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 11:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774278182; x=
	1774364582; bh=vESA2oSpUNFHbIqfotmrsVSC4q455gUCfyI47AdUjAw=; b=P
	bwFVq1Hy66fqP9vyav2dVyMIImak0u42gPNggfnQU+0uLchLHxaWXjSKId0gXfvd
	uQpUGgoUxOx8zaN6epkLj+oldp2DmyMzikB1j7nVOyeY1SXLvt1tlS1ty+B06gRj
	4sRDKWrzvLvAac3JpfuBZesWcdbufQcFKggcVFcBXm/F126oeEaZaJzjVSElyACH
	ZQxhgw2e1SdYBpFsRWysFjkITlHxJci11Zsju+6qV6sFvUvzansSUZGXHmixnOAH
	1PiKdFORujbBi/Da0C80oEz2KTt61BSZKmy3L/tc1grylA7D1HZ9kLj1wA7ddATN
	YALrjgLQh3j0JoF12DVNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774278182; x=1774364582; bh=vESA2oSpUNFHbIqfotmrsVSC4q455gUCfyI
	47AdUjAw=; b=KpERMpnD/knU/22KWQIaWUNj3r5esijnuBgvk/i9A9IEowcTb0s
	TdFXZDThSa+blMO2X4oMpwToFfqbaGCMoBkxKxsF5ZSPDkozjmqouBy8o37FGhjP
	NhRtqM4B3TXvKZ3E3oXPVIEeBr3vQI9k7ktgZEVkKfVph8QUQ4gnEeRT5k5S2VGd
	STR+eolTrAFdO6OSaK8INJA7zXNmvpMzz0WjHiVT2cEroB/sm8fAAasf/Rf3D6pe
	/KrxUloZU3k/cRRGAEE/9Okyv4e9BYNRlKCS/CB/RDx6BbUiiETzai5Xu60Qa3lY
	Jm09dceue03WAxbTnwnPtlcwaMdk0IGhTrw==
X-ME-Sender: <xms:JVbBaSEwV2onQoJAXAeEm9jq9k_HKuLNMRr4whiijx_vX5Y9OgtU8Q>
    <xme:JVbBaWYlPsklN8_394Et3zC8eGczJJlX8Vi-89ZCHZTgrw0pr-gZt66gXEZxYLOt3
    vS1pPzElHkZ4KJQfyyixIROF11BZZIwthXL9AFdbWfONmpcZtO5t-0>
X-ME-Received: <xmr:JVbBaWxoNc8ekzkz1R82WUacnb4WRZDw91lmWRHBm-pYYBB326NBu1WWDEeW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomh
    dprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigqd
    hkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepught
    rghtuhhlvggrsehnvhhiughirgdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvth
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:JVbBaYT1IPrTziuQSRKTiz8Be2TfNtkLA51R4p0SIj_IGbmp9iMaSA>
    <xmx:JVbBaTKKDX5BiVKmKBP95erYBQCKJlE7ztutit9Ezbav9kIb_6xm6g>
    <xmx:JVbBafXTdlqvh4z94Pi9mCUlsrnJtTzIVpYtYegJJkCXG2JMri8CWQ>
    <xmx:JVbBaXQfXazEXX4POSOjcgoYUmLs6oaGmYjFVB1G18Di_YVCBzEqqw>
    <xmx:JlbBaau1MN9q0L70DrX7xOgb_oEwuvopuvUsv9QuDNB_eUFBhFIdkkck>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:01 -0400 (EDT)
Date: Mon, 23 Mar 2026 16:02:59 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net v5 0/3] macsec: Add support for VLAN filtering in
 offload mode
Message-ID: <acFWIxzM-GxpAhjH@krikkit>
References: <20260323123633.756163-1-cratiu@nvidia.com>
 <acFODtfaa8LCKX4r@krikkit>
 <5ae5d08d578fce1a01a548fad8552a14df8c5679.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ae5d08d578fce1a01a548fad8552a14df8c5679.camel@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 0CA252F62E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-23, 14:42:00 +0000, Cosmin Ratiu wrote:
> On Mon, 2026-03-23 at 15:28 +0100, Sabrina Dubroca wrote:
> > 2026-03-23, 14:36:30 +0200, Cosmin Ratiu wrote:
> > > V4:
> > > - Migrated nsim-only macsec tests to Python, usable against real
> > > hw.
> > > - Ran these tests against both nsim and mlx5.
> > > - Gave up on nsim patches since the tests no longer use them.
> > 
> > Why not? Being able to test without accessing real HW is still
> > useful.
> > 
> The tests now send macsec traffic over VLANs and nsim, it's just that
> nsim doesn't deal with VLAN filters at all and there are no stubbed
> vlan filters in debugfs, since real hw doesn't have that interface.

Since netdevsim doesn't deal with VLAN filters at all, the "tests
should be written so that they can run both against ``netdevsim`` and
a real device" bit of the docs doesn't fully apply here?

Anyway, I think the original tests had value, even if they're more
limited in some ways than traffic tests. HW/driver behavior could be
hiding problems in the stack with VLAN propagation, those simpler
tests don't have that risk.

-- 
Sabrina

