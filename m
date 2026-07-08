Return-Path: <netdev+bounces-305968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NyQXKVyfTmqtQwIAu9opvQ
	(envelope-from <netdev+bounces-305968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:05:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D504D729C5A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:04:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y9lREdGE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305968-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305968-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86ABF302FA96
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87770370AD0;
	Wed,  8 Jul 2026 19:04:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107043933E;
	Wed,  8 Jul 2026 19:04:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537497; cv=none; b=lRE4oWbUHSj4W9J7lk1mBCIPYxyt1EK4zV5TfhIXeP/xAFxjGvO/t50h2CcwEJ7Ge0Q5xoDfrUOotbUOirSxG2TyAcmVdlYZ2PdR6+ZAHjwcbvwxaeaCSz3Uuk2V6AyxavL0zusg+dgAINpGb5mbEItElmG+XKDybx73pPAqDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537497; c=relaxed/simple;
	bh=tPH9DICekdlZbynKMclkIKeubaFZz/dgqiOwKq97EIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujDvVKAQPFToNHlz8NF/WddiDCKoFWaGiLZnm0nTpA82+ZEDUe7cWFVNWy3IFZ+g92qETsud5AAOPXuThI4tdxCorAdGMKvjQwomQ9ZznbPI4yJ/NaxFkMhWpTl40fm+U6nFRBrP3Jpx3li4jwPrm8w8SBA6DkQNFDHf/Rr7oQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9lREdGE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2491F000E9;
	Wed,  8 Jul 2026 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537496;
	bh=P77UWkg5VroY5vpeRPWTAH/eSCjDlL6nr9xgv0/Fd6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y9lREdGE2X8+jzoVKSg32WHZlgvfm9WUnyhAs7lCBVlPjSEGUlqc/9BP+Khb87TWw
	 PcMlY0SMlJfW7z5yAXD6XGxU1f6aI/OMTQSmS7d13+3zao6azE0jjjNtfxNi+lnlOM
	 sWWXqZjKVt65mmWHcRaexgAleBoEjR2/r6chFprmV0rV5/Fc8hfKGMVt8YRmhWiZjF
	 Shr/s9UsWMHEg5uMVvvZOfDGhEU7pSazhugTTPIYeBAbr99/0zSWXWRo1OqeDTT1l2
	 pNgcyFJl4jk3K9Fegi7OPac0d4gLGiWjIsAk8J9vfckBKJ/e3+3j4Ziuu0ScLX865Z
	 /hEAc3FieTDEA==
Date: Wed, 8 Jul 2026 20:04:51 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>, laforge@gnumonks.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next] gtp: annotate PDP lookups under RTNL
Message-ID: <20260708190451.GM1364329@horms.kernel.org>
References: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
 <20260707142820.GG1364329@horms.kernel.org>
 <ak0SYEOvw6K_8C_w@chamomile>
 <20260708103525.GJ1364329@horms.kernel.org>
 <8d5fe948-6979-46be-866a-69a98ee391d8@redhat.com>
 <20260708183252.GL1364329@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708183252.GL1364329@horms.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305968-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:pablo@netfilter.org,m:runyu.xiao@seu.edu.cn,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D504D729C5A

On Wed, Jul 08, 2026 at 07:32:52PM +0100, Simon Horman wrote:
> On Wed, Jul 08, 2026 at 01:10:58PM +0200, Paolo Abeni wrote:
> > On 7/8/26 12:35 PM, Simon Horman wrote:
> > > On Tue, Jul 07, 2026 at 04:51:12PM +0200, Pablo Neira Ayuso wrote:

...

> > >> I think this patch is not correct.
> > > 
> > > Hi Pablo,
> > > 
> > > Of course you are correct.
> > > Sorry for not realising this earlier.
> > 
> > Human slop here made me wrongly apply this patch. Could either of you
> > please share a formal revert?
> 
> Sure, will do.

- [PATCH net-next] Revert "gtp: annotate PDP lookups under RTNL"
  https://lore.kernel.org/netdev/20260708-gtp-rtnl-v1-1-218091f171bc@kernel.org/T/

