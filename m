Return-Path: <netdev+bounces-276678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /xV2MWOe1mkLGwgAu9opvQ
	(envelope-from <netdev+bounces-276678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:28:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEC53C0CCF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88E9D3034EDD
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D734A3D4129;
	Wed,  8 Apr 2026 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RTR4RrhY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFiGebzk"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949882494F0;
	Wed,  8 Apr 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672769; cv=none; b=DlscdJvDUH6oyfU4pu9gJVqh4teHjIaaJK+wxiEJ+tSt/Xa/GYP+yxhKw+18t/j1908MDZQKibYbjRlkizmL04UAKSrtec6P1rIVxvqhlqfg4bI5VeElqVEzfr+xBDZLv6DEX/rtEhunEPHoxK88XFZqYpUiBc0cLNta9osGODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672769; c=relaxed/simple;
	bh=VJ83GD3SdOYdbO+KeShA6+18yEYBseFpAwF6rIZ/HoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTjk+QyDLYYbmWncBkHyjpPvsD4MvnFahXXgR0Vs+6uoglWOPymH1LdaRGFx84B0xGL7UzPzWzV1JCp+QdHsVdYdlJmExSbilhsIoXsDvDjRAZ5Q3bTEMKFmfhJC8/pKlvgwnnTy2uuwz04KkmmcqkK1YBFqr+ofbEIh/8X5IpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RTR4RrhY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFiGebzk; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C9307A01F7;
	Wed,  8 Apr 2026 14:26:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 08 Apr 2026 14:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775672766; x=
	1775759166; bh=3g1b2rdgcqZMi/s3RtSe/udpnK07L+SNtGZz3w2Agrg=; b=R
	TR4RrhYUMPNUB+X+ZF2xh8ySvZ2+P/4j74sBgGr4YgJAt9t/2HE/yUzh7bTvmn2L
	X3nt8Im0PTio5YAaL6QSKqqTeMWhftToJxVcl3SHTb0HBpb/UU9Dh8tHBbDSFeQB
	JcKx9GhLyJ9gHq7+ji8pAnjYroFMUlqnAazNJWmNepHsMk1OJutc3YB0jpDoeyBi
	P6PqoNAxp/8v890v5f4n6eDwkQyvyY6ZDQJrehCJ+Vri+3UuLb3nIKDHJ4P/CEE2
	pENI6iBEGv3vteVlYCa8Jdm2z/YalDYirDBf5s2IrZg9HxPc6ekhYT6gfc7FATNH
	4//+0tELQ9btVnu7VAx6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775672766; x=1775759166; bh=3g1b2rdgcqZMi/s3RtSe/udpnK07L+SNtGZ
	z3w2Agrg=; b=IFiGebzkhJLUG61ukeyqDlboYOxrcrHzwId0ulWox2+1407iaBH
	Gi3uFGH2iVqYcbs5jGAume/54JNSRhjd4Qy862zWReM75ZGA7JUyI5n2Rn0b5g4F
	XWcdwxlfzPbkejL7y+hmlFPrY+G8k/UTDI/K19jT1SS+Iik9DVPzrUrMp2vQksTK
	qFcxCIy9lm5ThHMH0dKwyA99sCqkLgwCG0pErSwHSD01hGkxlwaYwpGQH/brtocv
	uNRsPehFkNPdPn7rXzulQ2WtqpNyO95dbF6V+mBu186slwkm80QxbeHD1h3BoWUp
	0s3PnY76PIc+7Qz4dzQ1Gw4a9qchOZs9LRA==
X-ME-Sender: <xms:vZ3WaeAN5NpFJg-0lWShMfLno9IMrLWEjg_spr0vzcwz9v2fFM7twg>
    <xme:vZ3WafDHfoc-1sGEWfSIqY7cQ3uOqKdVuBIwZ961JZsHra0GbDVLcAk9qs-mh3ZQT
    IDD5R4W22oRTIb5OQHciJQ6haL4NRxKNjXBjcqtZPFkgAqamSpVJ3E>
X-ME-Received: <xmr:vZ3WafnLxqLmoC5CJTBenz9MCii-r8bal79cfyasEvyH2TwXAy7Tcnp4Cuzi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgv
X-ME-Proxy: <xmx:vZ3WafjaHO8hjVxa3XDd0UZbNQct3An6nUK_lREHRs2HY8QU2lo4iw>
    <xmx:vZ3WaZjukSJ7-ZXJZMfN5s5BlOm0mUJv5mj1AlxKET9AsFZD0AY8WA>
    <xmx:vZ3WaRsaZTYkZq7eljLCYX-3MUi310WTQrLkhTudNTG5bflsqx_B-Q>
    <xmx:vZ3WaRut20DOlFmOAQskSAE0jtcjCb1LIqD4zsLJEUHKyxOhGvQAyw>
    <xmx:vp3WaXRIUcJFvn4EUo8-AbWUtxcAQW-t89JapUXQ1n8QfNRLfsYH8V3k>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 14:26:04 -0400 (EDT)
Date: Wed, 8 Apr 2026 20:26:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, David Wei <dw@davidwei.uk>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v8 3/4] selftests: Add MACsec VLAN propagation
 traffic test
Message-ID: <adadu3_TfrFtrJ87@krikkit>
References: <20260408115240.1636047-1-cratiu@nvidia.com>
 <20260408115240.1636047-4-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408115240.1636047-4-cratiu@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276678-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,queasysnail.net:dkim,queasysnail.net:email]
X-Rspamd-Queue-Id: 7EEC53C0CCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-08, 14:52:39 +0300, Cosmin Ratiu wrote:
> Add VLAN filter propagation tests through offloaded MACsec devices via
> actual traffic.
> 
> The tests create MACsec tunnels with matching SAs on both endpoints,
> stack VLANs on top, and verify connectivity with ping. Covered:
> - Offloaded MACsec with VLAN (filters propagate to HW)
> - Software MACsec with VLAN (no HW filter propagation)
> - Offload on/off toggle and verifying traffic still works
> 
> On netdevsim this makes use of the VLAN filter debugfs file to actually
> validate that filters are applied/removed correctly.
> On real hardware the traffic should validate actual VLAN filter
> propagation.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  tools/testing/selftests/drivers/net/config    |   1 +
>  .../selftests/drivers/net/lib/py/env.py       |   9 ++
>  tools/testing/selftests/drivers/net/macsec.py | 141 ++++++++++++++++++
>  3 files changed, 151 insertions(+)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

