Return-Path: <netdev+bounces-281198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TuSLDb+d7mk2wAAAu9opvQ
	(envelope-from <netdev+bounces-281198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 01:20:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF946B74F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 01:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F686300130E
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 23:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23926A08A;
	Sun, 26 Apr 2026 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JsBu6ySt"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA30138490
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777245626; cv=none; b=Bl9enM3sEsAsWJTA5BrgEUl2VXqGJnR4yBBF5UJpv50AjwKnn7yPnLcbqWTkIfncySBs2e9BfG852J9bO7c5PBeECVqMOc4yypux8yYH1+7WDZQjFA83+WaamNkElWeM5CIauI7mVw0OBZWI+QAIDFYNJWSdoXO4ZTBmoIbmhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777245626; c=relaxed/simple;
	bh=Pz0wRMeuU5MHSiNmGPdDSD6/RntfkTLDDlks2S2u7+w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=KlHfW5g5wFvd0Ol+yJqlpY/jnKcrDrH4qm8noR5mcaY2JMrQPdpRVWxw1fSwldOb8zkK+9ESwGXCw3iPB/8hhEEKG72Q+JimrmiwmyDh5xK2ZOgykomrB9+roEST6IgCFo5lIP6GF3geA8xtDefdcUpCkJC1Gg92uCx7BcRQiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JsBu6ySt; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777245622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pz0wRMeuU5MHSiNmGPdDSD6/RntfkTLDDlks2S2u7+w=;
	b=JsBu6yStYEos3W0X3N1ZwgG7KOZUlm+LBmzB54mON9+idiyW16zs4RD76uF0z2HQ4perUt
	B5LiEeeDKCGAuzvoRrE67vSzVvkIZquKefBkvVgif0YjJkaBXTcBf5Ob6a4MxJESv9twOQ
	hsNid0nDDHYep6WvpJ2EBq5LLN2lFTM=
Date: Sun, 26 Apr 2026 16:20:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [REGRESSION] aquantia: Sunshine/Moonlight UDP video streaming broken
 since 5b4015ad833c ("net: aquantia: Remove redundant UDP length adjustment
 with GSO_PARTIAL")
To: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B9EF946B74F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281198-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.schwartz@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello,

When using a previously working setup of remote streaming from my workstation to another device via Sunshine (the host server) and Moonlight (the client app) on my home network, I no longer receive any video output on the client app after upgrading my host workstation to kernel 7.0. Reverting back to kernel 6.19 on the host restored my setup to a working state.

After bisecting, I landed on 5b4015ad833c ("net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL") as the first bad commit. I confirmed this by moving the cable to my second on-board NIC (Intel) on the same workstation, which restored video output without any other kernel changes. My affected on-board NIC is Aquantia AQC113 [1d6a:04c0] (rev 03), atlantic driver, firmware 1.3.34, MTU 1500.

Looking into it a bit further, ethtool -K enp97s0 tx-udp-segmentation off also serves as a workaround on my Aquantia port without changing to my other ethernet port. The working Intel NIC reports tx-udp-segmentation as "off [fixed]", so traffic falls back to software UDP segmentation on there.

Please let me know if there's any additional info I can provide.

Thanks,
Matt

#regzbot introduced: 5b4015ad833c

