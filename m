Return-Path: <netdev+bounces-258358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oISDGy3xjGmSvgAAu9opvQ
	(envelope-from <netdev+bounces-258358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:14:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78AD127AA4
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC7331F52D0
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7B36657E;
	Wed, 11 Feb 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HA1FZI6F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qo6/lB3m"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676D364046;
	Wed, 11 Feb 2026 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844100; cv=none; b=T4yYFy0A3OONq0ozMCAg71LiTSF88p2jrPbiWuupaoGbvOTVFpG/kagwXxYUtKSoF07+WRPlxFGzpJ61L2S55NiQHR2aRAhb0yaXREIRXkHJ7gkt+AhribHqgEqik4ulmRBPQdZIuf6Qx4z1XF81iB+tkD+qDh43PaxTVKyS48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844100; c=relaxed/simple;
	bh=TpYIgXW8MshVnalAe6GJ/u5LHs48DVw+sDweUXwzjUA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SdfR8TjjjTNrDE9+evp6GEF3I67zgZXVg/ynE7Kc+qjfIdj/md4i4L/MevFy+l87iv4aPYjyVFuOXsn7PxXp05vCkGQ/IMtHv1wc5m83NFiZmUhPStGV36GoKpWI620xitPN+vyAodNMyX1dAWnVI7SaQljRcbpzLDEOW3Cws9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HA1FZI6F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qo6/lB3m; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 363901D00111;
	Wed, 11 Feb 2026 16:08:18 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 16:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770844097;
	 x=1770930497; bh=reFHnTktqBgYn8ETyGcPS3V50do8VnQ4m9FfKDKrS50=; b=
	HA1FZI6FlJch74Jh9LisB+EgdvbApjuyoB6U14otp4lmxI84pI3MVs+goYLSWCOP
	FG9hDQNne/PnaCixnX/w8dyzLCRoKfMOej5leU7AemZxjr0qMDpBbhXWgHsYHtDr
	btNB1/Frarg3xdiVqa5+O4SlZOkb0OgebwcBFgaVXUd4XC7ubLdeomZIBuCITwmP
	1vtfRjpFvpdMd0iSEAA+k1nEwXnguHirqNPaXkfj2zMUuRZROCtpNZ+TWBfETJ5E
	eezF9nYyEmNeF5oyi9Yod+wGvjAiaBh9tALIjdZY1vJvntHPU2lQnJgNHukvIT9M
	Iu45u7yOENJLYb0Nr4dD0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770844097; x=
	1770930497; bh=reFHnTktqBgYn8ETyGcPS3V50do8VnQ4m9FfKDKrS50=; b=q
	o6/lB3mga2LjItketCgtQvfePwVCv6+mxBNl8EYUyRMTvCge4i/RJ8SfI1b8f3M+
	NVh5c2qksAdQdZf1BN5KHm+fkUnwZsQixH3utyI5O4GzHqsmSMJQi5SbWqBLrM1m
	YAet0CJtQRwOumFuKlGRWeYBIGMLeAxhi98HFaZ11MbN5LSfNjf1rZDz1GOs2FPd
	kCvsf5mPWK0G5qXFguhNUhXjdwhyhNHjmTYAE2uCAIdoDSiDurAIzn71QlbcvHb6
	5OaR43mnsRjknein26R4USdUG2tRENZBEaP0QCwRQYM6zl5rtgLqYWy4F4+9/qEj
	2KVncmHwhsmaGAVTQZ28Q==
X-ME-Sender: <xms:wO-MadaXhjKXOS1xpTk_jXvd_rqRp6j8bkaLyDc7GQA9ErJTAQbRMQ>
    <xme:wO-MafO9j9hfPjBf1QVztAbKzkyVmjB4WnzuI0pdsoXpLWwsd_ayFPAOq80j-gWvY
    ThPwcoHaP8oCxDjuskb6Mj97YcrWXNe-Z43QCwxrXTILt7_fIsacx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvvgdrjhhi
    rghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehnihgthhgvnhesihhstggrshdrrg
    gtrdgtnhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhr
    tghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:wO-MaZVwJDNNjIMZtASXGU8nLJWOufHSMeHmEX7k2crO9DXIDQ5Zmg>
    <xmx:wO-Maf9LcNWuqb-T_lvdNTNAbMV4ZvKhjXiGEJ9yuP9khreRyvPy6Q>
    <xmx:wO-MaRqXG3MSK4LQvoGT2H3QNcE9u-vYpdun1NYO1durr6rVQxknng>
    <xmx:wO-MaaJR5gkmWLBX2nvzmzreTSTnKrb-t1MKOsR_oAXJfFTvFrI04A>
    <xmx:we-MaXn-3eQ1lhGonr7rx-owH4GvthUi9KLj5h6cludFqZoKonJ6sFCX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 74E5B700065; Wed, 11 Feb 2026 16:08:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AcGRDBlASdqB
Date: Wed, 11 Feb 2026 22:07:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jakub Kicinski" <kuba@kernel.org>, "Chen Ni" <nichen@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, "Lukas Wunner" <lukas@wunner.de>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <0244faa4-763c-4ccd-b98e-59a0ee6b346b@app.fastmail.com>
In-Reply-To: <20260211103308.4d6263bf@kernel.org>
References: <20260210013733.1901270-1-nichen@iscas.ac.cn>
 <20260211103308.4d6263bf@kernel.org>
Subject: Re: [PATCH net-next] myri10ge: Convert comma to semicolon
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258358-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email,arndb.de:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: C78AD127AA4
X-Rspamd-Action: no action

On Wed, Feb 11, 2026, at 19:33, Jakub Kicinski wrote:
> On Tue, 10 Feb 2026 09:37:33 +0800 Chen Ni wrote:
>> Replace comma between expressions with semicolons.
>> 
>> Using a ',' in place of a ';' can have unintended side effects.
>> Although that is not the case here, it is seems best to use ';'
>> unless ',' is intended.
>> 

Fixes: fd24173439c0 ("myri10ge: avoid uninitialized variable use")
Acked-by: Arnd Bergmann <arnd@arndb.de>

> ## Form letter - net-next-closed
>
> We have already submitted our pull request with net-next material for v7.0,
> and therefore net-next is closed for new drivers, features, code refactoring
> and optimizations. We are currently accepting bug fixes only.

This is a regression fix for a mistake I made in a patch you merged
for 7.0. This was not very clear since Chen forgot to add a 'Fixes'
tag and labeled it as [net-next] when it should (now) have been
[net].

     Arnd

