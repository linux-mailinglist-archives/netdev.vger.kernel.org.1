Return-Path: <netdev+bounces-262550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEdeFKVFpWkg7AUAu9opvQ
	(envelope-from <netdev+bounces-262550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:09:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D61D46E2
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61EBF300EA9A
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C2A31D367;
	Mon,  2 Mar 2026 08:09:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F01F2B88;
	Mon,  2 Mar 2026 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438946; cv=none; b=jjg/koZ+EIY6FhcxHZ6GEos6u1hSBGwaqFJEgjryP8J6ytjsWllrUMzdazcqxnjVCwrFYoggpD2rSslrVw+RaJ8RvbFtjmHdAYSN9HjeEP9wdDN0yA+bcvFJPTuRETBgxPwm6juWuUE9E7uqskir+PKk91C8Qmm7YhBIUCQngc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438946; c=relaxed/simple;
	bh=D3RZLvV0PsxmO/YS0/AtGcTqc0z3e2/zT9l56j2AvQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ3rwOQOjJkXl8KQsTrprfSgpANURgXTWdET4GoVTo0oyLcLPSs98UYhEfLp7mMk9SXQeTtIWAhAso91em4wErzvae4Apr1xzZkdrDIR4SO3btid0sROzkYi9p25zhhmcb7LStEjMD5xkjHdHLhmQZG7fmJ6t5ApvgDWgtU2f6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3F1154C45D;
	Mon,  2 Mar 2026 09:08:59 +0100 (CET)
Date: Mon, 2 Mar 2026 09:08:58 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org
Subject: Re: [PATCH net-next v3 02/14] net: bridge: mcast: track active
 state, adding tests
Message-ID: <aaVFmtS1hdYSYRZR@sellars>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
 <20260302054008.21638-3-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302054008.21638-3-linus.luessing@c0d3.blue>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	TAGGED_FROM(0.00)[bounces-262550-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.871];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: AA5D61D46E2
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:39:56AM +0100, Linus Lüssing wrote:
> Before making any significant changes to the internals of the Linux
> bridge add some tests regarding the multicast activity. This is
> also to verify that we have the semantics of the new
> *_MCAST_ACTIVE_{V4,V6} netlink attributes as expected.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---

Sorry, I might need some guidance on what the checks patchwork
lists want from me here.

I'm running the tests with the following command without any
issues:

PATH="/mnt/net/iproute2/ip/:/mnt/net/iproute2/bridge/:$PATH" make -C tools/testing/selftests TARGETS="net/forwarding" TEST_GEN_PROGS="" TEST_PROGS="bridge_mdb_active.sh" run_tests

But why does shellcheck list so many errors with
"This function is never invoked." Even though they are invoked
with my above command?


I also don't get what netdev/check_selftest wants from me. I only
see "FAILED" here? https://netdev-ctrl.bots.linux.dev/logs/build/1059784/14444497/check_selftest/summary


Regards, Linus

