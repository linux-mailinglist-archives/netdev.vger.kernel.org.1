Return-Path: <netdev+bounces-285563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SpYiMxwo/WmgYQAAu9opvQ
	(envelope-from <netdev+bounces-285563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 02:02:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 148774F0685
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 02:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CAC9302AD29
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 00:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2378F7D;
	Fri,  8 May 2026 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhcupM+b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E86FC3
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778198553; cv=pass; b=mGs4WO2akIB+SCaYNk5iGKwlEpLA/lPkWUiwazzKL9Futedep5E7hiipFOvWB83LPVXxhXSO9nw4hTjDIDf4shKgazGw8OrVHgTh1GQVjz9yLtBRHVWxL4HtUj4meU3ECVfn2XojRyoTYYlDjHKujFcQN4TEswF7aIK6uGnmz0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778198553; c=relaxed/simple;
	bh=oFfABAtl7XJ4aCa2ntG4VPME+ZQ99PC8dnfR27sLcQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQ4OIYxFyfvz4hkGxxBKVG2zx1qeMLe+YPtE0vufMun2BXvJBPPSXpOIbSSVzjcRFxN2xpkG+qJWRaEhFrasOm915T0lnnpPEYuDE6JWMY12tBPHXLiQjWXK3hQUOvuOHmnOYqSdpFEVWnvMxWH3fehWgjUAmKPCFgc2J137kBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhcupM+b; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c1a170a50so2133899c88.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 17:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778198551; cv=none;
        d=google.com; s=arc-20240605;
        b=dbwk7h96lYDIpFfh6gGFKXln/+uMoIB5iOev0v0zuKjN79cRwpHVGIh0lly7pDmpT4
         3BYP/JKX4c5zly6W6JSRklg4fMvV1XhCV+62InEbbeCWcgZKrtG2fukzGV5n8vnja0fX
         R5e8eda1dqznpnsr9kcG5hkvo6X8gQQ4fjc9/Eela2HqJOpo4CWpg9a3bVoGx0ORC1Yc
         AO/uI8yKRJFlXpfkGvFhaly88kiCZnA6KxHsuGwytVMCb88bd0gXnCVcE6Amk8k7Ci4s
         tjNZAWoNn8c8l6hvVNWe84fYBjfxfqIm7nUK+0SdOgkWAXxWlEzyOWb6vDdAWl1mU5AL
         bk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oFfABAtl7XJ4aCa2ntG4VPME+ZQ99PC8dnfR27sLcQ0=;
        fh=9QP6AXCI9q8Lms2O2uP+NHRYHFETEgyRyhlMDp5oiXQ=;
        b=IGCGBxFMCx9BKpovciYk7xVsyB9SJel6EmTMHxJP2u5lCj66/o7hEqChujsjR8YBhH
         V2R5tpPATQIkOuAYS3/V4+a4r268cOQdGWukxLjt5KXKoacZZpUAr62YFd1STlw3BrIw
         nok0OyGFfIV9pKHW/E2G7YN2Tg+ZpG+69+Bar6bWQ+2chNDhULSOfXxCNXsZTSu1rkwi
         YD6s/bLCRtt9VGR7NkxTFGVxDjoI4eUTzyUkfSuc6yWChQgiXjLFtsuzQDNfj8O4cW3g
         OZf0rUQW8RqOD6eMpP40N0jtZBPT7jSJmOdFzBgkcnLD0IxlwWzaROevr6RRjQYo95Uc
         6xkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778198551; x=1778803351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFfABAtl7XJ4aCa2ntG4VPME+ZQ99PC8dnfR27sLcQ0=;
        b=BhcupM+bvUylKh5/9wOJJbZUBF5dT0wDbmcvX4lR+tFO4/g/2rwjFhDkBrhv4N126V
         secqJTzdagNtuvgnofc4J42jMZuRGmh1etUJPno9Dgu32hbts03QBnZJ5fmO2o0dhMA0
         2jY/rNXGs25671zaOOsG3z0bdj8eJSfsS1vMU3JtogUXpHtwpPC7fFom0OvE+jGCEntF
         UOlrV4WMV7YW9eOMy/cW0jwhvjohB34Pqn121Urpo1FX6nZfD+x7Cc9sHDnARHsYmTWg
         OikYkF5/zdcpxiMUyWprwbHvVtWCRKhtifSxyO4KMlA/djovVrD37epegZWqLWKXa62p
         kNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778198551; x=1778803351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oFfABAtl7XJ4aCa2ntG4VPME+ZQ99PC8dnfR27sLcQ0=;
        b=jvAtkSiHahtWrNWelqR4IETGg7nbb9Rhuxg28gvjYzS42Ym7xB2JD8uU0x18H39SGY
         q188z3P8ays8pETtQGhS8O/6W3D2aN3KWmWO4pHvm9IcswR8tv1sTfqmqA00P8WIw1ap
         WjwvQOs7n+yl8QS7fOPkgTXzo9rU0HdjajJiwyZEpACdsCeWicunK1QRXlUDNEvH3QJI
         kROj8cdxdkRglYqJDcRsHrosjdO7zChGgMRYdCy7x6jktooTsye0fmaFGImcAwdRPNU4
         YVFPmlI0TwsWqjrjB6ppFMhdS4/WZ2Q99F83MXlEPM0yuJcoekIKOLK/+MmQRc+QonYC
         OGaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OyESK/dvLqkySV4K+FHFKvQlxbbIBOcRBnCUE2irCobR5XS+Uns3xTLGsWtm/+dkv5eiNZCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SdpLbTm7PzSw+otDR2xLNX0Z9mtaOPUFBXBcmz0v/kt9s9E3
	ayXewtqoep+CJWxV99oKPLo0CBcdGZpyGU467OK9EAMmZW/ETNypFALAXOpODZuZM8Wc1fmyN42
	6I1lFnTlSW/TahVnAjegRE5LSTmIG3V4BNbUuJzxe
X-Gm-Gg: AeBDievR0VA0qYLZq7M/Qfd3yPDL7sEZZ0wJh30jHtcgBSFgK7iMjgFsrR5t4JFcAac
	qtkrj+XiN0P/Or9KtbE7lOk7xI9yVIhH8l+Pd0frkzRYc0AgNZNrgsv2koxzCg885HyPehza/5W
	LCEAsqggjxANOBtcYNlmti4jtdINvrDwMP7F0EOO7gUxBor21OdUkYrr4ASKQ95rC1ZDaatEPrO
	dGCD6c85jrCA29dhscqfOBoTx7ZP+z1H5yqmQ/97gwZeMG/e+tq18i6qfNvVKEmKwS+cHYwR0Pl
	M+gCZ5PI+x8L2ihtFfoHxgBKuZ7mc0gKVifqASoXIrYOpxUZQgEMQM+nR+6VMIJIdF1STGu8NZR
	1VaOQKVkbHUGFS3prNDrAhlSwuboIIjYtep+gL87XMA==
X-Received: by 2002:a05:7022:ebcc:b0:12d:de3f:f3ea with SMTP id
 a92af1059eb24-131a6af412emr4764432c88.42.1778198550715; Thu, 07 May 2026
 17:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507174547.4125412-1-edumazet@google.com>
In-Reply-To: <20260507174547.4125412-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 7 May 2026 17:02:17 -0700
X-Gm-Features: AVHnY4K31ARfYe31Hhx0jEM0M5-ktzAmdOXXBrF35Urh4fGDUOyLMjNf5YNwgs8
Message-ID: <CAAVpQUDx7v7agBhoXeM5jNKZ2HRGCbB9HUDn2hZht9G=eE_zgw@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: add RTEXT_FILTER_TERSE_DUMP support
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 148774F0685
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285563-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 10:45=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> iproute2 can spend considerable amount of time in ll_init_map()
> or ll_link_get() to dump verbose netdev attributes, contributing
> to RTNL pressure.
>
> Add RTEXT_FILTER_TERSE_DUMP new flag so that rtnl_fill_ifinfo()
> limits its output to:
>
> - struct nlmsghdr
> - IFLA_IFNAME
> - IFLA_PROP_LIST
>
> We can later avoid using RTNL when RTEXT_FILTER_TERSE_DUMP
> is requested, as none of these attributes need RTNL.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

