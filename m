Return-Path: <netdev+bounces-302289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7cW7DtsiP2rOPAkAu9opvQ
	(envelope-from <netdev+bounces-302289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:09:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6286D0AE7
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:09:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hY5nuNwZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302289-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302289-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96CFA3025175
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 01:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A722D785;
	Sat, 27 Jun 2026 01:09:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B72F84F;
	Sat, 27 Jun 2026 01:09:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782522584; cv=none; b=qQF+k5pqfe9xM76R0rGuCohuZUTJq70cveRHwq9p9e7q4t82P3kfKN0snLyxmpUgOLoPFRZ8jzPLg9LcVELnknmLFtGlWBorFt3vAzQEDot6hy6xjo5K0L1ZpW1Iw+rf30MGma9O8Bwr3vSh3bxDaZYvKviy7bq0O/GSgWxKyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782522584; c=relaxed/simple;
	bh=cGWoWNfJrGJ0ITUtYPgpR0iy+uM43rkz2fY6kafwZiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3wzzpw55GjdumCSO3GB8vOLYQIC5T244UlD0bZmAyUdgf+StAVXBfPRzF8FyTZC7hCLmawwvziCzy0n1L3Caq1PljL0Nda/S9O03V0rkz8BxpgKYAtsUc5BnoqGdk44H2IcJpoI0HKceyQPaxo3XqXBMDWTzdnMs9gXP9PcGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY5nuNwZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C41F000E9;
	Sat, 27 Jun 2026 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782522583;
	bh=18ZyS1+GL1I0U9VQ5nRoZRnBU5LsQ3VgtvNPyetNtyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hY5nuNwZfbkNRSCm/bBgq4qtg+87aqMqT8n5uwRBjrheG63kewr92kbNuOAVluyVJ
	 6Bg1/xnobim9+QZ0dwW0+DusmP6cgbRtb7R4rmFnvLxExiSSLK322/79ORqCkyQChF
	 Opn5GiT9VcJnzpbxA1vCaa/8XNjDOecFa7dH9i6hzcOWUTAUIjJpTB2newPBY6AXIn
	 cVMK1YEY//EKsp+H9k3rZqyk433jcTEnA/+Q52UL7Hbjv71WFxDPmyRRDUmST/zXPY
	 KZKE78ixolnYs0xSdTwBkdpectVC7169EUVZJSjR/YTj1FVrnoB5zT0qexQ8+JYHXo
	 NZ8Ei0lHBN7UA==
Date: Fri, 26 Jun 2026 18:09:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, Shuah Khan
 <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] selftests: Open /dev/udmabuf O_RDONLY
Message-ID: <20260626180941.45158025@kernel.org>
In-Reply-To: <20260625181557.1086105-1-tjmercier@google.com>
References: <20260625181557.1086105-1-tjmercier@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302289-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tjmercier@google.com,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:shuah@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE6286D0AE7

On Thu, 25 Jun 2026 11:15:55 -0700 T.J. Mercier wrote:
> Write permissions on the /dev/udmabuf device file are not required to
> issue ioctls and allocate udmabufs. Applications should be opening this
> file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> 
> Remove the write access mode from the drivers/dma-buf/udmabuf.c and
> drivers/net/hw/ncdevmem.c selftests.

You need to explain "why", too. Why change it if it clearly
worked for everyone running this test until now.
-- 
pw-bot: cr

