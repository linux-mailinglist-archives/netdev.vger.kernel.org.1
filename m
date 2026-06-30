Return-Path: <netdev+bounces-303232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EFxXD5PRQ2pRjQoAu9opvQ
	(envelope-from <netdev+bounces-303232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:24:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA7F6E5648
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:24:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nNoNpynb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303232-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303232-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B329317246D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8DA346E4E;
	Tue, 30 Jun 2026 14:17:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238B1A0BF3;
	Tue, 30 Jun 2026 14:17:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829023; cv=none; b=YyVR8nt67wPU3HztEpFg04Zdnbq9IjNTe0kJOBqFjJ/m2xJR5dmId1TweTarIS7GFEPt24N7ZhJm7WHViRw2KhS0/g+RNAPS1+PqUCpxkdkrPhd3UNDvA2EIIwZcVcT/2okbj2B5rtmYZt0RT+Vyk4L/PmmQMRX40LY7ULoMAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829023; c=relaxed/simple;
	bh=ZGQfzpYt2YhIwe7v+7wfMdBXIFcnDDnaDTtgO6fkcmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNF8TmcIyhIogUYmCMVcYpTQp0lp4Wuoh4RSmERX1CwBFRIgUrFaA94wZLM30HpRdX+5k3wqLkC1V1cPP+qsoD8BMLEsbvhopNya0ubz2uWGw1f48WXzoq2p4wxZ7xw4blahS1ciDZXl00CPvVtPw18ubF4j3dP37P7uEYw70F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNoNpynb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB831F000E9;
	Tue, 30 Jun 2026 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829022;
	bh=OrryefzzWlDGUbQu3WPT9xvectgqeQ8dLjRQaVeZG94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nNoNpynbXbYCgClLn48fWff7gcLhhu4NgGd08gG1gxpoT7mtlBWwgSD/8falcRKVq
	 fnUjDMJHb+VHZQspo1bklW1k9h+ETN5UfPc1iGWIsvh/NSAnUO38WxXVIU0wk+q0EY
	 nc/koSKYyTts1CKem8i3cOhxmtMElrE47iH6S40n4nlBHxM4Nh1RNqAaC2URRaBZQO
	 0BhD/VwhxAiWVDGKWYvA5qrnBE1Zakha8mAaJREHRh+oIOtAELMoCcQIZhVvgKi/xG
	 PR881jCiAlQbepNHwDt9SF9zXM8ThqUCtfAy7WmLQUMzuCEz++3+/Arvtdr/t5FIiL
	 Z1dmvCbP7OH0A==
Date: Tue, 30 Jun 2026 07:17:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai
 <cyphar@cyphar.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
Message-ID: <20260630071701.6b583d1e@kernel.org>
In-Reply-To: <20260629194327.2270798-6-jkoolstra@xs4all.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
	<20260629194327.2270798-6-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303232-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,100.103.45.18:received];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EA7F6E5648

On Mon, 29 Jun 2026 21:43:27 +0200 Jori Koolstra wrote:
> The test uses the following Smack labels:
> 
>    "Sender"   - label for the sending process
>    "Receiver" - label for the receiving process
>    "SecretX"   - labels for the files being passed

Not sure this test belongs in net/
99.9% of people running this test do not use Smack.
At the very least you need to use XFAIL instead of SKIP
we use skip for problems with the env which are fixable,
like a command missing.

