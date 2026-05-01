Return-Path: <netdev+bounces-283072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO90MWAJ9GkM+AEAu9opvQ
	(envelope-from <netdev+bounces-283072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 04:01:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C4F4A9BAA
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 04:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 500853011F3E
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 02:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875872D47FF;
	Fri,  1 May 2026 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLjukedS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F440DFBB;
	Fri,  1 May 2026 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777600860; cv=none; b=rLHsWi2jionKMB1VejwNqZfJdSsPb9pbPqjHnn93bzZVKlKvkH3keJ8Lpq0xwnaqJgZPQxzWRYeu6xP9SQR1bmOjGDZe/yRYZmEhCbF/7R+yC3A1bzEKOgBEeya5Pjy4o35y3yJWYpOttpO1F/DRDBGNAPTrqERr3/+bG8zoKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777600860; c=relaxed/simple;
	bh=W6ZGP2XotdXWcKQjnMbUja6SjOA3Izm4V/R6L7gJQ50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxWLhWFlaGN7mQV6QQvAnO+drsSmkaNYlkEbaIWJSu0YJOkaSLICj375ItxT5rOdrQyriQwpGrNnuGRbzUhimiaUetMm+CNfDHh1CX3Iuzwt2/5xHOSfW78k9Js24n8nCtU6aoOJ1aVG0piY7OfzNzUXNYST7cTaZsvQKUK/lSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLjukedS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E73C2BCB3;
	Fri,  1 May 2026 02:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777600859;
	bh=W6ZGP2XotdXWcKQjnMbUja6SjOA3Izm4V/R6L7gJQ50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SLjukedSIcTGpRBuXLChLR6VhkBJvs/l1BUgnIuaKUR3KFVk7b8675YoB/C4HovzQ
	 kHogfVia5R6+yC6QIyzohMp48k2wXjUBi2te3iuRTXUdIqfnpaBrkNUZTwUyRB/beo
	 oqVNrCXVd5MA1tW43lZdlaoy3RB80t6K8PJIS2JXIyEt1d8sZvxbrBXztq3ne7vWr9
	 x064K2GuH9iMLScxi3KYVpZ5HsgGcBH193nXsNk6mCyLYFs82+Mm8U1pAtZWEenA0x
	 zmeWmx3rc33WLmPPp8MF+wf1QqztXmbdXkgOcR6i8PAC3IY1YYEbXCxBsubgjjnfMp
	 APQdy6tlvki1A==
Date: Thu, 30 Apr 2026 19:00:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: hawk@kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, Jonas
 =?UTF-8?B?S8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, Breno Leitao
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] selftests: net: add veth BQL stress
 test
Message-ID: <20260430190058.5b20b15a@kernel.org>
In-Reply-To: <20260429172036.1028526-6-hawk@kernel.org>
References: <20260429172036.1028526-1-hawk@kernel.org>
	<20260429172036.1028526-6-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 33C4F4A9BAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283072-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[veth_bql_test_virtme.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, 29 Apr 2026 19:20:32 +0200 hawk@kernel.org wrote:
> A companion wrapper (veth_bql_test_virtme.sh) launches the test inside
> a virtme-ng VM, with .config validation to prevent silent stalls.
> 
> Usage:
>   sudo ./veth_bql_test.sh [--duration 300] [--nrules 100]
>                           [--qdisc sfq] [--qdisc-opts '...']
>                           [--bql-disable] [--normal-napi]
>                           [--qdisc-replace]

Not convinced we need to carry this in the tree.

Honestly:

> +	close(fd);
> +	return 0;
> +}
> +CEOF
> +gcc -O2 -Wall -o "$TMPDIR"/udp_sink "$TMPDIR"/udp_sink.c -lm || exit $ksft_fail
> +}
> +
> +setup_veth() {
> +    log_info "Setting up

This whole test looks like outrageous slop.
Did you even read this? :|

