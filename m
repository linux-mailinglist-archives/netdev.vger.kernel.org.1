Return-Path: <netdev+bounces-251834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEgRAnekcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:03:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E054DEC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 459E1601968
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3C247ECE3;
	Wed, 21 Jan 2026 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eXUPOhno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D047ECCD
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988964; cv=none; b=qb3UVWRDn1zdKufbqT07v0omJ2tcFopJ/ZgLp99W5lGcKxWtszYmKSLmzptPs1W6zD6IaPMpWCcLa7bxYLevbLkab3/UrlkL2POHlsKf9G+pxWf9a5cr0GfqrfnakPR8zZVFEqCRxsUniFcwGU7VQPJ1J1GqB3pxezLn+pOddlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988964; c=relaxed/simple;
	bh=0sxY9/hbT9jAvcK9hvO6t82kEcRLh2+R2jzBqHhBPE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ogNbpTEqwcwuSbvI0oyM7EU+ldtwhOml6nS42GTHPlOVRQpUR6LwDgppOcLPVZgbw9hzBPKC+4VBow95XBtCXFdSuhA+eu/xeBaIhVlAmEabhYKmZAMqrP73jwPg/JZJW4paHIvyeOR5JE3pXe32GfaOybh+vXsvZw06o0n9YdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eXUPOhno; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso808569266b.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768988962; x=1769593762; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0sxY9/hbT9jAvcK9hvO6t82kEcRLh2+R2jzBqHhBPE4=;
        b=eXUPOhnoJ51DmemQ2dvwrDxK4Yfw78ZBICyI1xXQgexfhd8EMzoGShsQqFKRi/NleP
         mxqsV2pcHW3aJATMZqerU8Dop0ZM2ZLyWehzMa8rcpCGUEdfvovNStli7hbz/LjIxgrp
         r2QbD4/bay/iIycBXP9LKVm4+xZ289SNcbP0G6qACDttWLVLnZGGgIl8YSOdP9bvuSXG
         Eg870u7iC5trubXs4E+xeHe+V4TEwwSDWtFoUBGnK+UtU8QElQfvSG//VCwIOd41qsSZ
         kz4FndnD+KAodc3vhStkxYyY31HnZLl/3mCw7XA0X3mW+F6OAh19P+fNp54nt/6BbQbF
         QgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988962; x=1769593762;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sxY9/hbT9jAvcK9hvO6t82kEcRLh2+R2jzBqHhBPE4=;
        b=Wn8WbQXTUnDty5U1Zn5Qws1PxkgvlacaoBX340N3iYljpHFa7Q0urRyRLpnok3IX4B
         OuisUA67Jz/h6nmWR5SBTksRqs/OrxPaKS1oDKvpaj911aWKzsSYRaRPYWimmHdvcQFq
         KdLiN/c7eM0MvWmIFDIQd849+znhxwvNtyy+ik67Dlft0+RshOfqI6CK3jBAWELr+yME
         RAQPfrbEGv9YgMDVmqJOo9RrOa+StvXi2SqTR+x1zSwcWfZeY56vg+6CUkppRGQOKxXQ
         7wCV6fRtD75Pz8dmx2YX3drEi63YPSSJHHPQumducmzFfPRgax8835ED3f6mzjhxvx57
         sxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXughK4BUplh9g9MCM3I1C3Knxy6HRJUekl9oablTXiskB7NcY/smIHxbKCQIFDH6MsfAWB95I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aMoFc9XUkqg4GZimq9wPq5Uve2FmYw/P3r1xIGg1exXI2yRA
	l3wRG44mhXDzcYGXjnTiGgwIGAxye5RPlkFDRxhN5HAJStx4658/YYhT1cvD4vivE+4=
X-Gm-Gg: AZuq6aI5U03BNtjHWR3MEzgBQB5dNJkswszhQuJ81j6YFVO7G5eKLY2n4/LjVhKQe+Y
	+W4Fnsku4X4xX5zysHp3Fej+9FykpibzUfT3IDlLyYwCHK3pF/pj/sTljVy/i+Ds6J+sQhbwNeQ
	+rgWR6D8AG7zm1AWFcnSaYMXeNPYbUdx2h2/klZtuKDJkOUAFnWLsZXnosTAEqpzjUZWr2OazA0
	XCKTPNLeGWHXMXTv8ufuLegSegbe5WsPN/62IdEHMPTQfi0gRSCyqpYJRioQClMkHsVzDpBSV0p
	d1d/qztgNvEKoOo7MxwxxEuaKJCfGmfwkV72MOVlrvE4ZWJ5NyIdzVIZIejeCZHEykpJQwuic/6
	CoAeKgoeAxTvjMUs39PTnD6SRZXQvNYal87ddJLaB/7X39MUWQY2KI2ak9m7+JfLKG7SXn/bD2q
	IhQ1YELwSefLYD
X-Received: by 2002:a17:907:980d:b0:b87:d826:8113 with SMTP id a640c23a62f3a-b87d8268b60mr760209066b.54.1768988961653;
        Wed, 21 Jan 2026 01:49:21 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a2f1a3sm1521409366b.62.2026.01.21.01.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:49:21 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Amery Hung <ameryhung@gmail.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Remove tests for
 prologue/epilogue with kfuncs
In-Reply-To: <d4563561-c507-4876-8a03-40e4dca2a34e@linux.dev> (Martin KaFai
	Lau's message of "Tue, 20 Jan 2026 15:48:06 -0800")
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-4-e8b88d6430d8@cloudflare.com>
	<d4563561-c507-4876-8a03-40e4dca2a34e@linux.dev>
Date: Wed, 21 Jan 2026 10:49:20 +0100
Message-ID: <87o6mnthwf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.96 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,vger.kernel.org,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251834-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A25E054DEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 03:48 PM -08, Martin KaFai Lau wrote:
> On 1/19/26 11:53 AM, Jakub Sitnicki wrote:
>> Remove pro_epilogue_with_kfunc test program and its supporting code in
>> bpf_testmod. This test exercised calling kfuncs from prologue and epilogue,
>> which is no longer supported after the switch to direct helper calls.
>
> Is it easy to change it to test calling helper in pro/epilogue?

I gave it a shot and the obstacle is that bpf_cgroup_from_id and
bpf_cgroup_release are not exported symbols, so they can't be referred
to from bpf_testmod. We'd have to move the whole thing to lib/test_bpf
so it's a built-in.

