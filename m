Return-Path: <netdev+bounces-293790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ex1MRGWHWrOcQkAu9opvQ
	(envelope-from <netdev+bounces-293790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:24:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA72620D01
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A90E30059B1
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22437F8C0;
	Mon,  1 Jun 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="KpXL73iS"
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333683009E2
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323854; cv=none; b=VDLnrK/Q4g/pSK92XHTAD9BSiv8gR6whqsBdpTbc6xMGp85R7B4ypp/gM+uAOD2aWm/GuuzUL2fnCiBAcL34Uj4zHaid1N7K/jAfBg3gZbA/ShXpGmrptEcsQlu3NdYHkEAgBG6IpxywkVAHOiiqkqXSXt1uXmCu0C0dpGXTETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323854; c=relaxed/simple;
	bh=OrjU6LLwIFPHt3GQu5Xk6yxt96sc0YSmI0QjzUlovME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StiT0m6mfQecNYV8H3yNtYTMxS3q2Tx2Y8OeV3DjjdEeQjeVisQuVM8zPtMmOFvrtnaUZSm0CrHcbhMb1LplPWIs/v7YOFk01U9pxZKL8fLCXCZ8Std2j7tEMN8XtQLPD5sW8asw3rmO3jf60HGUWtgLEyF0m5JgwabgvbT5E0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=KpXL73iS; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gTbmz70bXz84T4;
	Mon,  1 Jun 2026 16:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1780323844;
	bh=OrjU6LLwIFPHt3GQu5Xk6yxt96sc0YSmI0QjzUlovME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KpXL73iSAQFBvrvDHoYt5vtfeivdTNe6GtNm9QuYwr5IpYu8PGHsZzm19KPTQiJi4
	 GdRxW3aWGPK/YdDDC8WqhTIiirKTmfN90DVTLI5vUaGEGKlG9zA6wZUP7ZQ2UQpDzp
	 8bvc7OJ47rJ/uJej1Cokj8Xv9vHqUk+ZDwQG3nWABpSXNJ69FQftRhfygyb9kbQyuE
	 ZFki2uga2ynPvXAA1dtHgXrZ10awWH41ro6As5OmOs4YCZZazQdt49OqcTylEYs+5n
	 /IGqGPug40ZgQTEJt4X7oJIBqcCAf5wKdSTzH73YHJsWoIkTDdSnccUIUmGY6nlf/t
	 6w6qdjsx+LYLg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gTblF1H4zz8Cqc;
	Mon,  1 Jun 2026 16:22:33 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gTbl8747Sz8scM;
	Mon,  1 Jun 2026 16:22:28 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 7BE3B6031E;
	Mon,  1 Jun 2026 16:22:27 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <87940248-df61-40b3-ac5d-4d8d668e0d7e@leemhuis.info>
Date: Mon, 1 Jun 2026 16:22:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
To: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>,
 Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, idosch@nvidia.com, dsahern@kernel.org,
 Chris Adams <linux@cmadams.net>, David Gibson <david@gibson.dropbear.id.au>,
 Beniamino Galvani <bgalvani@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org>
 <20260601153525.546746a8@elisabeth>
 <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178032374806.2081081.14097493368263592946@mxe9fb.netcup.net>
X-NC-CID: I9zoyUOnNugzmgEy4BN9SqxGMfgcIucYi0qor0Ek7/UQb6rIITY=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,leemhuis.info:mid,leemhuis.info:dkim];
	TAGGED_FROM(0.00)[bounces-293790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,vger.kernel.org,redhat.com,gmail.com,google.com,davemloft.net,nvidia.com,cmadams.net,gibson.dropbear.id.au,lunn.ch,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6CA72620D01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/26 16:01, Íñigo Huguet wrote:
> As I said, this solution would break a few programs like
> NetworkManager

FWIW, that is not allowed in the Linux kernel; see

https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-situations-where-updating-something-in-userspace-can-resolve-regressions

and other sections on that page.

As mentioned earlier, there are nevertheless solutions for this kind of
problems, but they are all somewhat ugly -- like some bit in /proc/ a
fixed NetworkManager could flip at boot time, as then everything will
continue to work for those that update the kernel without updating
NetworkManager.

Ciao, Thorsten


