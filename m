Return-Path: <netdev+bounces-290114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK93FIYqDmpq6gUAu9opvQ
	(envelope-from <netdev+bounces-290114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:41:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F759B340
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 500B63028661
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73843939B0;
	Wed, 20 May 2026 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+iesas8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FD37BE6E;
	Wed, 20 May 2026 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313260; cv=none; b=biZdKQwSMnO/Fw+zd8zrDZ4AQGdZ3EZM3mKpZ4lV0yqda75DECL5wNxFpY1CYn3eWV2tA8e4I55KIEgnz3P1qoduwir0qo0cfWyegCOTOGC5KSBOqqMARsA7NF+e7g1cAp8toaX5oxgVzubm/CxZG0Enwynrz8UMmrDefBOpf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313260; c=relaxed/simple;
	bh=9seufv8THWEq9UNvU+ASZOlTFZquZrw6C9S120RkteY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAq6r4JuzJQxywDd2FTVM8m+TnHu1xbTFx6ZiehCYpjPl2rVqciaHNjlIF2PGfaUiFxeUVbcslAexC842a+8boExs9987yEHOFrFThqo5xtwu5dt6pn5/VnOVJEZO0l+87ENCHd4iXDpY4dt8E1rFeYN5eBngbquAteaWOA4vw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+iesas8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20FF1F000E9;
	Wed, 20 May 2026 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779313259;
	bh=9seufv8THWEq9UNvU+ASZOlTFZquZrw6C9S120RkteY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B+iesas8QX+kIgYNx+Tpxs3Y673kLpk/MCWZ28sAZ8zD4J4PnlQbdVu4WXM9Y4W5J
	 CzXuFmhuaK634Bykf8jk9uukTaxkwujGAt4ISz305TDe/9epyQvub5UgT76bYXADNH
	 Dl82oZnChNciS3cgO5FCwTtkTpVRIvU+gdJrMy0Lsv5EXcmiLMlRiUowiJ2J+8qk0n
	 QL6fTHogsrH9QJJQCcBugpuYlTG3D2I1PZYdz/eEoaIZxiSkC/sqIOR1SF58AJog4Z
	 F4zlbvVt4livETcXv9pOhN+zeFSDT1heFmkCJVn7FDJl9mhSgyjiKCa0slNgUONeBw
	 fHr/ew0ElIu4g==
Date: Wed, 20 May 2026 14:40:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net
Subject: Re: [PATCH net-next v7 0/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
Message-ID: <20260520144057.1ab0e15e@kernel.org>
In-Reply-To: <20260520064310.4154268-1-ntspring@meta.com>
References: <20260520064310.4154268-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290114-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A67F759B340
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 23:43:08 -0700 Neil Spring wrote:
> - Check post-rebuild busywait return status to avoid silent false pass

still flakes:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/655182/43-ecmp-rehash-sh/stdout

