Return-Path: <netdev+bounces-284923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLd9M2pf+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:34:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B054DD4DE
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDB623001D7B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5239544105E;
	Wed,  6 May 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/O1ZBHG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60764921BE
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081637; cv=none; b=ZpPvm4pzK+cxqVo1vC1oIRGLdgtkSDjoBW5M2GGaLvXdesg+HjuGXbEIxfaTN/OkIn3Iza95y72zB7gECr5mB/BNjRrB0cV+QUvcr+c3QvLdFiXJp8Qk+VV2D2k2ieNywigvBQaEdrPeTJ3GZWy56DJxjYGJ7Y9SWmBL/8AId2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081637; c=relaxed/simple;
	bh=v7iWJA7AOWqAM5g8QOaOTdACaW3JaQX1YwwtDoobk+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLw7U+8nrIeQ4pZM1RRCCFWk9ccLPyT9p8T1zdWOrrAVOhuqRd0XrxThWwnN60Bb9cQ322xFUpay5RUubM5ww6cMO+r4uo1CYdkTQZoNkS93aoTE+P5602GXm9tgeGztFjii/2h9KfkhTtOk7bXDaoOx3LObReE1W5VvRe1qcec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/O1ZBHG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so64908035e9.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778081629; x=1778686429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPgcwkvVhL8aXocPAgoIRAhV9vFqMpLjuj83PIidEBY=;
        b=I/O1ZBHGO+5NYtv/Jz2fe90F87I4XbCwMI767rGH4xPBExZDXi1S1dANoOUY1+U/O/
         iQpEea5bZVhTq0A0E0e95IsDY/R68RBGTk9NfOtHLJqrGnrsthwY5au2Lmx33YsjV94S
         Cm7e2DYF+7Oo9fjkO6c2OArRKhPOZ2uV/k/m2Qzj8hhcNL2z0m4RYRwkBVkXJndfWJiZ
         ShHYg8pUmSOiD4VsEr60z1T5t4sQLGSsCCQwtDEWREXDGJ25E/sk8RdQy17SDCp9fyVQ
         4ow8Kd2xDtXvVlehyU4lBrMunGPrh/H4e5xzcXL8mJV19LHUrtocfVL4rFOQz/aY9ISz
         bobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081629; x=1778686429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPgcwkvVhL8aXocPAgoIRAhV9vFqMpLjuj83PIidEBY=;
        b=KThIcchJBL5mWNy5yqmSttzwqW1bgq0/yaBkifbMUettXYnL634hksOPc7Jjkmk0Iu
         825+FNyv8UAzXifgIi+NWbKtmsdGcIbNcWsoUJtEYL0eqT7/zGSw0R4YwrFuKKpJVGVF
         zIHKhOjmD3TeJp9Kk8KE9te+6zVbLNQPUfYLdnhgczsWzNRv4ou7vsJuc3nOWW3U/K0P
         6SOXrSuvHYGUkUaxp4kRQ9vDsmKCNTgmxna6HWZRqU7WRkBfVPF0P4gNLmDcIAY78Qtz
         nvIUB01k1D/EGep3GTxbPEXAvP6jIZlfSs9iLmDw3Ig9r/s47w6WmoSvU3Me5zkKiAAh
         /oDA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZxXKj3AZQhP4e08lnXkHXWJVrngPWaPA3qmPT5Emb+tW1C1fcG3B48rJ9pAzX93uoTHGTkuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03SB04c0AdcYMlu47kK4ITeS4FozyB4y4PBJPEVAH7ttnKhaT
	h9OLoe1liNjG5HdF7nbmGjMGBsBNAPiJSUtk8gAjndkn2nCwldQF9JvQx82jnnwWOA==
X-Gm-Gg: AeBDietwpN8iRxkfVfWPHgDVEqE3bqHx361gQmSG+urtDqSmhm70IAJaoHw40xcY+zw
	mTzABSlCpuwXheQoA3i3poKGDL9AY3prDyt4RRstD91ZFJoPYw7iELqpWVMHzwGrUMpyPOvYfZe
	L0py+SYQUBOmHVRDiVFmZkdHFaX/o8Ln9Mq5395c70Dnz7qbNbcXtfXxICAW7DeONNUgMI+1/gh
	Swuh856M7K15Tqze0PtKNGxCwteej4HFfkFy0HpnJ7PZUEWn7vCK55AazEArtKVz93Nx+YuYvXa
	tnOxFAG9lolfgxab0ifeF9tYE0ypFWF95yWVniPrn5EFvQ5eK1we/+gEiluaJUkh/Ieig2JdkGx
	k3/vmflksR8TisUm81AsyZoRJNfFzHdKvvOOGYHtRu2qIa2OPYPig4n8n+xZdkYj49Ox1c1E10+
	pUo3lP6kCZ6QokERZuBlU8K0aDM+86DCmVZvvFA17eFyGwlLB4b9DxGbLOigVg5ycCLcg0qwSB8
	2N9A42Rp9jZHg==
X-Received: by 2002:a05:600c:1d18:b0:489:1a63:509c with SMTP id 5b1f17b1804b1-48e51dd689fmr66886705e9.0.1778081628773;
        Wed, 06 May 2026 08:33:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:ad61:8ca1:7cb9:f2e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a50d0sm91608975e9.5.2026.05.06.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:33:47 -0700 (PDT)
Date: Wed, 6 May 2026 17:33:42 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/7] landlock: Add UDP access control support
Message-ID: <aftfVvru3npQ9kWq@google.com>
References: <20260502124306.3975990-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260502124306.3975990-1-matthieu@buffet.re>
X-Rspamd-Queue-Id: 91B054DD4DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284923-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello!

Thanks for sending another revision!

On Sat, May 02, 2026 at 02:42:59PM +0200, Matthieu Buffet wrote:
> This is V4 of UDP access control in Landlock. Thanks to the round of
> review of v3, access rights have changed to something that seems easier
> to use and understand. It adds only two access rights, to restrict
> configuring local and remote addresses on UDP sockets. The one that
> restricts setting a remote address also controls sending datagrams to
> explicit remote addresses -ignoring any remote address preset on the
> socket-. The one that restricts binding to a local port also applies
> when the kernel auto-binds an ephemeral port.
> v1:
> Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
> v2:
> Link: https://lore.kernel.org/all/20241214184540.3835222-1-matthieu@buffet.re/
> v3:
> Link: https://lore.kernel.org/all/20251212163704.142301-1-matthieu@buffet.re/
> 
> The limitation around allowing a process to send but not receive is
> still there, and could warrant another patch if there is a real user
> need.
> I'm just not super happy about the clarity of logs generated for denied
> autobinds ("domain=xxxxxx blockers=net.bind_udp"), due to the fact that
> addresses and ports are currently only logged if they are non-0. A later
> (coordinated LSM-wide) patch could improve readability by replacing != 0
> checks with new booleans in struct lsm_network_audit. I'm also not
> exactly happy with the integration in existing TCP selftests, but
> refactoring them has already been discussed earlier.
> 
> Changes v1->v2
> ==============
> - recvmsg hook is gone and sendmsg hook doesn't apply when sending to a
>   remote address pre-set on socket, to improve performance
> - don't add a get_addr_port() helper function, which required a weird
>   "am I in IPv4 or IPv6 context"
> - reorder hook prologue for consistency: check domain, then type and
>   family
> 
> Changes v2->v3
> ==============
> - removed support for sending datagrams with explicit destination
>   address of family AF_UNSPEC, which allowed to bypass restrictions with
>   a race condition
> - rebased on linux-mic/next => add support for auditing
> - fixed mistake in selftests when using unspec_srv variables, which were
>   implicitly of type SOCK_STREAM and did not actually test UDP code
> - add tests for IPPROTO_IP
> - improved docs, split off TCP-related refactoring
> 
> Changes v3->v4
> ==============
> - merge LANDLOCK_ACCESS_NET_CONNECT_UDP and
>   LANDLOCK_ACCESS_NET_SENDTO_UDP into
>   LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP (everything that might set the
>   destination of a datagram)

I wish the name could be more in-line with
LANDLOCK_ACCESS_FS_RESOLVE_UNIX, but since this does not need
resolving any more, "resolve" in the name would be confusing.  I also
failed to come up with a better name for this access right.


> - make LANDLOCK_ACCESS_NET_BIND_UDP apply when kernel is about to
>   auto-bind an ephemeral port for the caller. Block it if policy would
>   not allow an explicit call to bind(0)
> - only deny sending AF_UNSPEC datagrams on IPv6 sockets, where there is
>   a risk of the address family changing midway
> 
> Patch is based on https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
> 3457a5ccacd3 ("landlock: Document fallocate(2) as another truncation corner case")
> All lines added are covered with selftests, except the "default: return
> 0" in current_check_autobind_udp_socket() which is not currently
> reachable (net.c goes from 92.9%->94.6% line coverage).
> 
> Let me know what you think!
> 
> Closes: https://github.com/landlock-lsm/linux/issues/10
> 
> Matthieu Buffet (7):
>   landlock: Add UDP bind() access control
>   landlock: Add UDP connect() access control
>   landlock: Add UDP send access control

For the final revision, I think it would be good to squash the two
commits that are about LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP.  That
reduces the chances that someone backports the first but not the
second to one of the distribution kernels.


>   selftests/landlock: Add UDP bind/connect tests
>   selftests/landlock: Add tests for sendmsg()
>   samples/landlock: Add sandboxer UDP access control
>   landlock: Add documentation for UDP support
> 
>  Documentation/userspace-api/landlock.rst     |   89 +-
>  include/uapi/linux/landlock.h                |   35 +-
>  samples/landlock/sandboxer.c                 |   40 +-
>  security/landlock/audit.c                    |    3 +
>  security/landlock/limits.h                   |    2 +-
>  security/landlock/net.c                      |  161 ++-
>  security/landlock/syscalls.c                 |    2 +-
>  tools/testing/selftests/landlock/base_test.c |    4 +-
>  tools/testing/selftests/landlock/net_test.c  | 1146 ++++++++++++++++--
>  9 files changed, 1341 insertions(+), 141 deletions(-)
> 
> 
> base-commit: 3457a5ccacd34fdd5ebd3a4745e721b5a1239690
> -- 
> 2.39.5
> 

—Günther

