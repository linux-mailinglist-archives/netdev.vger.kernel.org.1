Return-Path: <netdev+bounces-297035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Hz9HFkDKGoE7QIAu9opvQ
	(envelope-from <netdev+bounces-297035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:13:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5F65FE4F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:13:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="l wj4AgJ";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=dxpvdnPI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297035-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297035-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18AC93001A57
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2140C5CA;
	Tue,  9 Jun 2026 12:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2E40C5C0
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 12:13:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007186; cv=none; b=ai52UvGDjOs4wYNZNOl3MbMjSEV9HJNwTKVSR97RtAMaM0NFR+yJBlkclscbpDROactnE6odlYYXLHslPAfUGMLxv9rUY1N7Ix0PxqmQTjAdWJ8Gu62bhCeRh3snAqeht/0Xjy4IhUeW1wG9uHqfepyOndqffrxPfnNgycuspPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007186; c=relaxed/simple;
	bh=G+vHkhOQyvX2lmekbnAv6Ywkb+ODNa78R7s251UQToU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq7YhSz3UjlZrb/zQZMFoQMsoi0S++t9w1+eU6ZQBqZX34V8VggXIcXlSi4Ywm3sho3LDstxUXkazVho/Zn86sTrUrlx2Sw3J+jH8HDs4gMEOY11wGppobiSTSM8TAUSCHtFsfPUDE3RCRtubi56D9Bg1zIxTGxeIT/QLs/Euqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lwj4AgJH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxpvdnPI; arc=none smtp.client-ip=202.12.124.151
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 83B401D00131;
	Tue,  9 Jun 2026 08:13:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 08:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781007182; x=
	1781093582; bh=4DKX5bDGTzVNeK9Ona+JNrqFwEcAU1ZbrrtAEpOhs6M=; b=l
	wj4AgJHVguL4xMYYDdth4JYognTCap74E5Fd3WjamFZJTd7uFy5GJXWoC9O+zMp7
	YWRQ9Hr2smEQ0p6aR8n16ZbeRVqLbE1BkXz3IeIZzLpYEviK4VFmrUozbkb00m27
	ekENwNi5pBKwyhGE/Xdt7kYiSEom4qejArx5Q3aOhoPfOiN6iL1xbV+Or/lZf3HE
	83kyhROaKVt5m7JsyPzuXXZE6eWFLsgecCXT7Str8s96E9GT4NHz1Sz7fhjBVdYv
	k9Yi6/QSkz8Md7lFq8SAApYsuhdkq2WlTD/rDW8YpiJ7Hu/bkvWNUYOqx78GOiPu
	+9J768WS5B2MbWbYfU22w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781007182; x=1781093582; bh=4DKX5bDGTzVNeK9Ona+JNrqFwEcAU1Zbrrt
	AEpOhs6M=; b=dxpvdnPIxvrkOm/Wx606TBlhjX67Ure4Jk90g/y3+A9A4w5JJeY
	HvmunRovsZbiX3wCcNYRIiuIx8VDICWSGCDdoTvc6XelfGiw0NRWktPN7uWw30ls
	dwjh7hLXct/iidkcl7ouO8qEwHqEIPrEfAOUQbeB7QoUdg+cI7hPydC+WTZ6zXFb
	k8Rb6gZx85rOyTaEKNakLkR9m3qsjzR/PBWVvrsclyUYtb3DF5MajQ/eyWkTDOeJ
	pHHCHPuMlqmJ5VFVdmyvWU6x9/ULp2Vn90grNG7dQ7LGp4jof1gjGfWoV76N5GOW
	XywRqePzBa9fYYnOvtDWrEonI/DbUtJ8aPA==
X-ME-Sender: <xms:TQMoaj9p7SFQDDue_M7hHRwTX22bZqGlv-Vo_HDqV3qdVmrzsKKEXA>
    <xme:TQMoahSnZpmIMMLaLPNdLcHg0AH9KHM82LrbhVSz5WvQex06_GCIk4adReFbmJAdz
    8xtKa1YhXO_5sNriu8wMi3awVHQ1N1EqdYOk6wYXVmmngdgKdjo4SCU>
X-ME-Received: <xmr:TQMoagSyyy---EULH95Lj7MoS8BL4_nQjThbS5DYZFwrL5xTGK4yBifiNzijolt9x06nnkVf_kTxhWTSxmne2nY>
X-ME-Proxy-Cause: dmFkZTFBYXm/+Yk5a+LVIvXPE+WgdUmcYXfyJ6+z1jaKtAJYdKcOrEJ3Im6UmG6F2r2k1l
    23aLRp0a5jfBLU7R4KD/n9voZXAIncB5XJMS82spkGQx9wLRUNgIIegmssaF14t+D+oWe6
    3XqVATEcZsmcEmDBtp57QzSDI+HJDxQPQe+/4UJVEdKKLq1b5QfZ4CSPGy1x7jcZcuMTqw
    qttXSwHFgaIwmHFFPVm8XpdEBbNl3rUp2nNdzyNsx7G5ZiHaXPDcTBIRZOMaVo1YiDF7gL
    7yCXiXUSd/j/u8nAkJVP2BfJpqwDu5oBHfi8EUL+5LV74btlJ/FtJzcb1dvu8PUG91kLhS
    8whIrBZwa4bpbkkPw2BcC4yyiNrPABxcn2VjvbjWlzA9Gc6ppVv27A0k/gn718l8JxS/NR
    pUL8Zw3M+eB+JlzRwY5IJPKmlvWe5rm1Fq6XBTmSX+8S2VsG+06YmXEg3cAbwoWyykatBb
    OCylq2JXrhPi46R/+FEAX4Hlr7u2m6SpO8tWSWMGh2hzurwu69xK5tRTzNM+vTigh+t1Ra
    12+i/pdwXZcuhvzYRH1at+l+YIdupz5nSDRGV0wr7csHRCFnOkFQur7s7/yWi++Ch9vLhT
    xDTjcZ2vSd/Vjmx9dnlb7/itWLIPSkayCuzx7VmSAY3iSFWZYk5c2BCcglMw
X-ME-Proxy: <xmx:TQMoal41WRr5yJk96trBcoAlZsjg-3_141-rr_urAoj99NV-7evH4A>
    <xmx:TQMoatU6L96XdICYTGV7ctran5szrVe1hxbLPT53C1E1nEDhPbSQlA>
    <xmx:TQMoaj_pvU24azqdJoiohgkcrVXFYURgeWo_brOBnN71F3eOv8mbig>
    <xmx:TQMoaloLb97sLiZ894qMGKshT1V62WFirC4usl2S-_OKz0xoTlFP4w>
    <xmx:TgMoaux5AacP8Ju3CM2T3Q5xE_ITGv3zUVXaty9c13R00KJno8qEI7BG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 08:13:00 -0400 (EDT)
Date: Tue, 9 Jun 2026 14:12:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Atul Gupta <atul.gupta@chelsio.com>,
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH net] tls: restore sk_prot before calling original
 destructor
Message-ID: <aigDShl67-mqMs2S@krikkit>
References: <158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>
 <aiZ9PZxNyp9jik2v@krikkit>
 <20260608200254.3be56aa7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608200254.3be56aa7@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297035-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:geliang@kernel.org,m:john.fastabend@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:atul.gupta@chelsio.com,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,chelsio.com,kylinos.cn,vger.kernel.org,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AD5F65FE4F

2026-06-08, 20:02:54 -0700, Jakub Kicinski wrote:
> On Mon, 8 Jun 2026 10:28:45 +0200 Sabrina Dubroca wrote:
> > 2026-06-05, 20:57:07 +0800, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > When a TLS socket is offloaded to a TOE device, tls_toe_bypass() replaces  
> > 
> > Or maybe it's time to simply drop tls_toe? There's only one driver
> > that uses it (chelsio/chtls), and it hasn't been touched by someone at
> > chelsio since 2021 (2355a6773a2c [1]). Since then, there have been a
> > few fixes by people who I doubt are actually using this (Eric, Dan
> > Carpenter), everything else is treewide/refactoring patches.
> 
> Yup, tls_toe is unsalvageable. Sabrina, could you float a net-next
> patch to nuke it?

Good, I'm on it. I'm also removing a bunch of EXPORT_SYMBOL* that are
no longer used (and should never have been used outside of net/ipv6,
but well).

-- 
Sabrina

