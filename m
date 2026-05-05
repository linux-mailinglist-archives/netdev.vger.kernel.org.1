Return-Path: <netdev+bounces-284287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIM9DD26+WmNBAMAu9opvQ
	(envelope-from <netdev+bounces-284287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:37:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2184C9E29
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 11:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD58B305EA20
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D30B3242A9;
	Tue,  5 May 2026 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzlZ+xBK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3474D40DFA7;
	Tue,  5 May 2026 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973693; cv=none; b=Cx21wpr1R3G9Y0zjss0D6Zrb60TNL2RnVGf2TvQjog8ILJyEftmm8jny7mMobzQErNpg65gFlvPFc/8M+RKHmZkZLJgPecakfD6b0ikSsqOLR6XQHrwdYsgNHP/xI+514mOytBSL5BaxzIO6wngWFMl2i5+038HkDRlZkHf7Ybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973693; c=relaxed/simple;
	bh=n/qxDvkG2vkc1gOFrFlJwX1Zjz72itXV5m0YGqL9gLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTjbO4q2VluULJxGoK+nnp7FyJV9PDG7WghPe30OSJKKkYN8jfsa+v4ZszuzPjt61+Sj3SQpxhP8aG/QWNsImeDf50WRb1eMtlM5+5MXwvlJedLXzUpjp46Am4nIISD81hlY9UWLNM0jIeueqMSvEdmZ1lcOP9SlR4izHkKAgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzlZ+xBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BD9C2BCB4;
	Tue,  5 May 2026 09:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777973693;
	bh=n/qxDvkG2vkc1gOFrFlJwX1Zjz72itXV5m0YGqL9gLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzlZ+xBKVsfK6+TmSv91sVWuiQN2p+bpjK9NjglCAbuEMjvFEBlYSF+f3EV8Ta3mm
	 7SzrhhBOBfHT7WQl0JIEquZ62cLOzQz+aSf6ScymudKlZoQzlPiNBO0+3INDDoDiBG
	 V+8Ha3PjDc0KPQ02c1fpuO7lxoD16jlgychTMm1Vsh8Hr+vuCO0BMOS5LBwRTfPc4x
	 2bAKEvM03QaKAeSmPfiNc4+g46jFsvINbLoNF7GkaXqfV22dNNEajPF7VeUj/BB8Ya
	 gNe4SHhyAgEsKm5oBO3sRpJiEZ5dXWZ3dJAe18k2ltkxtPvESliRjsNaV8w2+Qb90+
	 rRmQRFTBx52ow==
Date: Tue, 5 May 2026 10:34:44 +0100
From: Simon Horman <horms@kernel.org>
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Wen Gu <guwen@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Woodhouse <dwmw@amazon.com>,
	Yonatan Sarna <ysarna@amazon.com>,
	Zorik Machulsky <zorik@amazon.com>,
	Alexander Matushevsky <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, Matt Wilson <msw@amazon.com>,
	Anthony Liguori <aliguori@amazon.com>,
	Nafea Bshara <nafea@amazon.com>,
	Evgeny Schmeilin <evgenys@amazon.com>,
	Netanel Belgazal <netanel@amazon.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Benjamin Herrenschmidt <benh@amazon.com>,
	Noam Dagan <ndagan@amazon.com>, David Arinzon <darinzon@amazon.com>,
	Evgeny Ostrovsky <evostrov@amazon.com>,
	Ofir Tabachnik <ofirt@amazon.com>,
	Amit Bernstein <amitbern@amazon.com>,
	linux-kselftest@vger.kernel.org, shuah@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH v2 net-next 0/8] ptp: Add PHC timestamp quality attributes
Message-ID: <20260505093444.GQ15617@horms.kernel.org>
References: <20260430032507.11586-1-akiyano@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430032507.11586-1-akiyano@amazon.com>
X-Rspamd-Queue-Id: DA2184C9E29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,sashiko.dev:url]

On Thu, Apr 30, 2026 at 03:24:57AM +0000, Arthur Kiyanovski wrote:
> This series adds quality attributes to PTP Hardware Clock (PHC)
> timestamps, allowing userspace to obtain error bound, clock status,
> timescale, and raw counter values alongside timestamps in a single
> call.

Hi Arthur,

There is an extensive AI generated review of this patchset available
on sashiko.dev. I would appreciate it if you could look over that as
it does seem to me that many of the issues raised are relevant
to the progress of this patchset.

...

