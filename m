Return-Path: <netdev+bounces-297548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ljLQIbcnKWqhRgMAu9opvQ
	(envelope-from <netdev+bounces-297548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:00:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E656678B6
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:00:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=WXrzODMQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297548-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297548-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 650F03031306
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F5B3A9631;
	Wed, 10 Jun 2026 08:50:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51435213E9C
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:50:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081454; cv=none; b=sv9E7lL2UKrONDTqupYw28Lpd2v2aobNFluMfBrgZSswhKaEi+SMQBED/hlXC2CU1Fzf3cIkDvnjGxsh5b05JMUzxeduowJ9MelJkaHFzD8lr2g8drOx5JbZP1Gb35Nk6QyQLiuV3dA1yQm+uDbV2C+3b7dVfKtKsKXPsEia7+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081454; c=relaxed/simple;
	bh=Lta5JCWqxpn0mjgK7mIYEOUu+E970PhLTCsgq0Rz6EY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=i/cZNnUXbLECHcs4SuIBWdkxgDhRn1MxqGMui64//Od3DiZUEpO2mb0VzkB/EFrWLOtVidy0m7ROd09oeCDTN+EbXGfChKaW7iEx6/U4brua+p0C9g0b7wOxMxBtSYfjqQj4U/WVq6QKjSZNydc1r7er1W/4Nap1LTh+74GpfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=WXrzODMQ; arc=none smtp.client-ip=195.10.208.51
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4gZzpp0SZlz9yNG;
	Wed, 10 Jun 2026 10:44:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1781081058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHeDnN5f03xSlAb5Dz1tT3TpMTPDrXOhiXurXUd3EPA=;
	b=WXrzODMQuSADhN0RUN2+TjMRwpDgmV1CTM6v3q8ugPaRc3fCRxZ+IuitjmXUDpKdV9hIy6
	ewF78bE5ia6asj6WLXVRbI8nsCM5jqfKOYmgKTV37dYXcMWcXP9gbXaSk6DQpcEM4w9yoD
	eEhBzALcdVOLqxLHd/aGjuYrgKWS8b55QZLieJ4w/Sq2FOewcO7IiPw2lRTZUMM+WXwUdo
	kGDm1Qd2hXwKRtPZuQiIvhwuoWqqZmscYA9EgsTXJ9m2QnCt21GaMOLKeAOnkmW8hjvJWV
	GtZ8vBND0Rh9UubD9PV2c5UZb27hjJXN2Lb1TVcOLJ1ZXfUoWC8qImyc9pf+Eg==
Date: Wed, 10 Jun 2026 10:44:15 +0200 (CEST)
From: Marco Baffo <marco@mandelbit.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Message-ID: <1290464191.15539.1781081055969@app.mailbox.org>
In-Reply-To: <20260609194246.23c66818@kernel.org>
References: <20260608150741.3320919-1-antonio@openvpn.net>
 <20260608150741.3320919-7-antonio@openvpn.net>
 <20260609194246.23c66818@kernel.org>
Subject: Re: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive
 timeouts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:antonio@openvpn.net,m:netdev@vger.kernel.org,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[mandelbit.com];
	FORGED_SENDER(0.00)[marco@mandelbit.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.mailbox.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1E656678B6


> On 06/10/2026 4:42 AM CEST Jakub Kicinski <kuba@kernel.org> wrote:
> 
>  
> On Mon,  8 Jun 2026 17:07:37 +0200 Antonio Quartulli wrote:
> > Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
> > to ensure the keepalive mechanism is robust against system clock modifications.
> 
> Why boottime? Unless there's a reason shouldn't we be using
> plain ktime_get_seconds() which is CLOCK_MONOTONIC?
> 
> (if you decide to respin could you also drop the selftest change
> from this PR and move it to net-next? memory leaks in selftests
> are not important)

Hi Jakub!
ktime_get_boottime() is like ktime_get() but it does not stop when suspended.
From Documentation/core-api/timekeeping.rst :
>ktime_t ktime_get(void)
>CLOCK_MONOTONIC
>Useful for reliable timestamps and measuring short time intervals >accurately. Starts at system boot time but stops during suspend.
>
>ktime_t ktime_get_boottime(void)
>CLOCK_BOOTTIME
>Like ktime_get(), but does not stop when suspended. This can be used >e.g. for key expiration times that need to be synchronized with other >machines across a suspend operation.

