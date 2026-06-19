Return-Path: <netdev+bounces-300729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +jlyF8toNWpLvgYAu9opvQ
	(envelope-from <netdev+bounces-300729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 18:05:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BB6A6EDB
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 18:05:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=toke.dk (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300729-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300729-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 631FA30B498A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB903BE659;
	Fri, 19 Jun 2026 15:56:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798033BD643
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 15:56:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884605; cv=none; b=Kd8TLgSiLNofKTu/w7FHoThKeIiRbMagfEL+K8DRx/uq3l43IydAcGY4nKOhHi827XkMi/oG9GorH28lZ6TXfzZLtLFOO35LnrS/bW78OkNLV0aDExGaxyZRf+wuJqpxA0EUxY5bttYo04uFgwpPZIzVPySWPCb0WRHGbd/IyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884605; c=relaxed/simple;
	bh=pzzKtfaG7YGyh18+LJQ6NfX5mv4Fg7jnzEpEYIGQXYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bkva2oD7UdCSkS4qOmKNfyjSCP3V9i4E0wat8FveXEdtkhxG3SV8SRrBOPvx9Znnrn7vCVMydVcn2QtTUAh5Hhjs6njPTHXGW3kgc5IDluIQBduI65XoM8YHIt7NPqGY7mPPELAZS5EABS3cb520+BPJpQPqZZbkZfBfwHBoJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: wireguard@lists.zx2c4.com
Cc: netdev@vger.kernel.org
Subject: Wireguard head of line blocking when CPUs saturate
Date: Fri, 19 Jun 2026 17:56:34 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <874iiyfrrh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.03 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.83)[subject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[toke.dk : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300729-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wireguard@lists.zx2c4.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,toke.dk:mid,toke.dk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB0BB6A6EDB

Hey everyone

I'm running Wireguard on my main gateway, which is a not-super-high
powered ARM box with eight cores (based on the NXP LS1088A SoC). The box
does, however, also have eight hardware queues for its networking, which
means regular network traffic can be spread nicely across the cores.

However, the per-core performance is limited, making it pretty trivial
to saturate a single core by just running a fat TCP flow through it. And
when this happens, Wireguard traffic just... stalls. I.e., no traffic
gets through the Wireguard interface until the (unrelated) flow
saturating one of the cores subsides.

I suspect what happens is that Wireguard spreads out traffic to all
cores for encryption, but has to wait for the respective CPUs to finish
encrypting the packets in order before they can actually be transmitted.
And because one CPU is now suddenly saturated in softirq context, the
Wireguard work queue never gets a chance to run on that CPU, stalling TX
progress for the Wireguard device entirely.

I'm sending this message to (a) see if anyone else is seeing the same
kind of stalling, and (b) to get input on whether the explanation
outlined above seems plausible. And, in the case of affirmative answers
to both (a) and (b), to hopefully start a discussion on what to do about
this :)

-Toke

