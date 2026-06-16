Return-Path: <netdev+bounces-299694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id epJnE4umMGqmVwUAu9opvQ
	(envelope-from <netdev+bounces-299694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:27:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FAE68B402
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:27:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VkcH0y3L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299694-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299694-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C18C430053AF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DD63793BD;
	Tue, 16 Jun 2026 01:27:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320E2C2374
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:27:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573255; cv=none; b=DmPsej3FMBJe0P54CFO11/o9AS9nUQq16x/SU2vntRN22YWz+KSkuFGhPPaFPsBxwao4Km++bepBqIJqs5uO1Tnkkkz5fyHhN2RLWPm1oJJ70mGYW/EQYdnTmy7kDs/niEPImRnEf7AD/akyA4QqIyGyvRWgqKYooxPj48HoZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573255; c=relaxed/simple;
	bh=eyMPuATrFS2OTqsiADcq/gyLKUwursPohM/0jluuQfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfXshBJFhAaC+TJHKHSXbiIe4HkepmdkhueXsEJRHnlNVuP55/wZMEUJiiSuysXKPYxdtymf1n2XP/ckvonEfSrZT6BZCOKExEXkqBZ4d6Ti+InkZNtJIDh0WNMTj0qBTe4Y4h8OFSjRPTz8lo+ku1qq/BX9LjKtWAlbcVrPjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkcH0y3L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592AB1F000E9;
	Tue, 16 Jun 2026 01:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573253;
	bh=6hTMkCg4OsqsqIHaeluLsOS0eLuyg7/K2ebDVUYGbUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VkcH0y3L0+pN/yaPFlCtqoll7KUV3i/IanrTelTO/o5FZQ7PoiQ+4HySjMk1ogtRV
	 P98t1p8hRyie57syi4R/pLQwqbiXy6WCH3hbN/WNzIrhDw7f5vZDVPJ/zfTEx+RZYH
	 YDo4BKQnz4GPcZgPeW1hTnIdxQ3gQTrLnSi0Nf9g3JtC/M0Ya92BT9JW2gP7aiv41S
	 Fc8APAVcuC0de0y401hJsAtrpw+zT/aQKmV13mlfFxgqyBcAYbswqf6ad05Dix6EM4
	 io8TKFCXnBuH/rzxwiIaBIO04rMMmShVu1fDKLzab48C4WqnbKt6+1/bbhF0rvSvUq
	 DLPOCJY9onXXg==
Date: Mon, 15 Jun 2026 18:27:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Nikhil P . Rao" <nikhil.rao@amd.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 5/5] ionic: Add .get_fec_stats ethtool
 handler
Message-ID: <20260615182732.7d28e31a@kernel.org>
In-Reply-To: <20260614205303.48088-6-eric.joyner@amd.com>
References: <20260614205303.48088-1-eric.joyner@amd.com>
	<20260614205303.48088-6-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299694-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eric.joyner@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.rao@amd.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4FAE68B402

On Sun, 14 Jun 2026 13:53:03 -0700 Eric Joyner wrote:
> +		if (fec_cw_err_bin != IONIC_STAT_INVALID)
> +			hist->values[i].sum = le64_to_cpu(fec_cw_err_bin);
> +		else
> +			hist->values[i].sum = 0;

Setting the sum to zero is very much against the API contract with
ethtool, no? Since we are just digging ourselves out of a whole with
the link down events maybe let's be more strict going forward. :S

I think mlx5 had a similar problem of not knowing bucket count.
You can put the bucket table in some driver struct and populate it 
at runtime.

Looking at this scheme, tho, I think the ethtool core is buggy for
mlx5 :/ We should make a copy of the hist table, because we write 
the Netlink attrs after releasing the locks. Another call may start
already and make the driver write its table in parallel.

Please send a fix for that if you can, or LMK if not, I'll chase
one of the people involved in adding the fec stats.

I'll apply the first 4 patches here in the meantime.

