Return-Path: <netdev+bounces-289705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGOBJ5AWDWq5tAUAu9opvQ
	(envelope-from <netdev+bounces-289705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:04:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FF4586B16
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B7F300213D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833762DAFCB;
	Wed, 20 May 2026 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMJV9gD3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79DE2F90E0;
	Wed, 20 May 2026 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242636; cv=none; b=RF0vWM87au29OXPmqaGvbbZWt4R/4zfWC5O4Xx3cvugBTFQsZlAp0tcxiuXGPsm0BIWYEd6EkWXi5Mmd9KZN01AIoWJB5CLtlCbi8dDwjSMSHK7BqIK07NGKimWy0iqzpPC5ntzWkzcnsJIChvOLWn9W5iPkOESC563zpBogoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242636; c=relaxed/simple;
	bh=PHSFUb2xWIygaB8BdJR82vxTInMPaKs6a6u2JDU/0lw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LP8HY78iLMh7yte93JcikYQ9hCQxnixyZNWcjHTMiY303eQmKr3Gb9dF5eZNakcJx3ZffgKt5YO/FKUX7466Jkp2bPFYSf3xaf8+m1LE6/wteFfiStYC1ZGaD9jjYLQHSQfPkF1Fw+RWwCeTfXyrrrdXv2DupgQ/5dWYVvHuXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMJV9gD3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063CC1F000E9;
	Wed, 20 May 2026 02:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779242633;
	bh=ocQsq1+vFFGeT8pSDWvbVmrW9r1vRZSSi+UTV8IUDNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HMJV9gD3J/8FSm3yRMprBfuOceeStGwP5AhKcy1Ib3GU+WgYPnGZTMTW9Jt+xjNSj
	 GcXSRbJaBaDyj0hnOTZQEB9oLr7AVmQfameeSa5rJApEjdCeV0tjVO7Zs1tt0scDYD
	 YonV5zcGWv/RKm2FFo9zbOWDW63jO0/Ev3eJUDMJn9VVO84ik8olQheaMD+7cMEsNP
	 Iw3+BfVApUtvoerjG5/derKvpN0PzGhde6C1qWf+iyFpf/L1vUGpX3PABGiRjHS+jX
	 i+QgaqBmyYKbwtQQXekTx2U/ebURKMuWobBBnxrrSWV/p7DiKc8qFpXhZqqdalij2r
	 HnIZRyNlj75rg==
Date: Tue, 19 May 2026 19:03:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pavel Emelyanov
 <xemul@scylladb.com>, Laurent Vivier <lvivier@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>, Jon Maloy <jmaloy@redhat.com>, Dmitry
 Safonov <dima@arista.com>, Andrei Vagin <avagin@google.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net v2 0/2] Fix race condition between TCP_REPAIR dump
 and data receive
Message-ID: <20260519190352.45c8478e@kernel.org>
In-Reply-To: <20260518183424.3144867-1-sbrivio@redhat.com>
References: <20260518183424.3144867-1-sbrivio@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289705-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 27FF4586B16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 20:34:22 +0200 Stefano Brivio wrote:
> Stefano Brivio (2):
>   tcp: Don't accept data when socket is in repair mode

Not sure Eric is on board with this patch in the first place.
Sound like it's not the intended use case for REPAIR so IMO
it's up to TCP maintainers whether we want to support this.
And it's definitely not a Fix.

>   selftests: Add data path tests for TCP_REPAIR mode

Please don't add a new target, fold it under net.
Targets are a PITA to deal with in kselftests.

