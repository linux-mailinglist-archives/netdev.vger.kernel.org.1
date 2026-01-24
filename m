Return-Path: <netdev+bounces-253025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJs3O5pZdGlM4wAAu9opvQ
	(envelope-from <netdev+bounces-253025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:33:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 598027C8DF
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5684C300CC2C
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 05:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38542233721;
	Sat, 24 Jan 2026 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Vhl9gpbC"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C493EBF21;
	Sat, 24 Jan 2026 05:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769232778; cv=none; b=hUVhwUR7AS7Hzn4qyylj65gODPkNLwICwqGq7ZUdPshT5DxuuVOTezSjSaWd8h0OLdQdKxk0g2FW+570org29WTpw1wjpmFmgBcBPRAjJehttvsmmYS8nr5jlHZdG8GMCGsm/nUJLJ1Y/WotsglO+2P8M5mNGlvPu4I6I/etmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769232778; c=relaxed/simple;
	bh=UCLgtgZ54n5NC1eGMdczx4XogBpfLFQ7S9rkRDHMlYI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tM2PM1wOdZ2Tn+FjRB9FGIDew4Cl/XoxuHScggX5jJe27KQw3leKvQGJXQdYvYLsqEsw6lSJkan0NkYToHhbPLrdvLcOA0QHM3/IOtLVrqlWGYMd9uuB9KNTd6ZdhyHrZVoecog0PfJ1oIwj6stHh8ozJKMUYpa8O/s83CnNcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Vhl9gpbC; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1769232766;
	bh=UCLgtgZ54n5NC1eGMdczx4XogBpfLFQ7S9rkRDHMlYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vhl9gpbC9sgtOr6CkkzlY4P4aIMHuYpU9yKfM1NHyKDqBI7jKYtNKeuiOR/Qd+mc4
	 DsxSqkt1Bfcqbi98HuhBccZU+XjWy03FADqTRJzbrwxXtRyDB/hXVCaKIEFmDHRjoA
	 tu+0vOfVG3AWTGhcnDoeyWU7W7+tHio0djAov+0L5qCopEV9LDQTjuw9X96KEBS7yU
	 hgfsdkIPTBYfynl6HSorot3hJI1kGprLYNn3NCgceZSTQ/Jna9kTO484pbF8VNMSSm
	 4eWpsm5rIcmvgQNqiBMe8artT6mgGIZWnrAvgFxcSAlxOlTtnPiKangP9ycfRQTTmf
	 iYYy/cXc167BQ==
Received: from [10.2.99.28] (115-64-72-106.static.tpgi.com.au [115.64.72.106])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D3F00789DC;
	Sat, 24 Jan 2026 13:32:44 +0800 (AWST)
Message-ID: <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/4] i2c: SMBus ARP support
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wolfram Sang
	 <wsa+renesas@sang-engineering.com>
Cc: Matt Johnston <matt@codeconstruct.com.au>, linux-i2c@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Jan 2026 16:32:42 +1100
In-Reply-To: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253025-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Queue-Id: 598027C8DF
X-Rspamd-Action: no action

Hi Heikki,

Thanks for submitting these. Supporting SMBus ARP for MCTP has been on
my wishlist for a while, so it's great to have a solid proposal here.

I'm curious about why you're proposing a kernel approach though; the
actual ARP protocol implementation would likely be implementable in
userspace. I think the only kernel facility we would need is a
notification facility for the possible presence of ARP-able devices (ie,
through a Notify ARP Master, or another mechanism described by 5.6.3.9).
I *think* we have existing interfaces for the rest of the ARP process.

It's entirely possible I've missed something there; perhaps it's neater
with the match tables and address allocation being all in-kernel. I'm
keen to hear a bit of the rationale for the in-kernel implementation
overall.

Cheers,


Jeremy

