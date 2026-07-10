Return-Path: <netdev+bounces-306657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +UXGNDc/UWrtBAMAu9opvQ
	(envelope-from <netdev+bounces-306657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:51:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C6D73D6F9
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:51:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tZVSbLdW;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306657-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306657-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BB423018AEA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7B537C925;
	Fri, 10 Jul 2026 18:51:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31BF3749E4
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 18:51:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709490; cv=pass; b=QUlm1eb4Ux7UE2b7RRtuoj+YusiUQztoW59PU7otdECIfZAawVeAWZi+fPld813nLZN3LCEGotHfvqrQrBxl3bRGGZMdGC+czavTzTwSXqMAf4RP9uhyJf6EFRDY6jErF9UqqHP9M8xjyqX1/2KAENbRfL3SkVaEqGCQ4+2a4V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709490; c=relaxed/simple;
	bh=n5p78zc2rjIyApVm9wtHFVD/tFOi9RjzwbbxuAlVOl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVQb1Urj9raq5o601rN81J+M1RgPQAhOhoc8lSLtsnDvgZa/Y9+tlyhCH5m48aX9xEki8lNLUpb+BUjOr09U25cZNTWjaerLedip9NNWih04EMpQdvH6motalOZDGiENXA98Di1GqHjCN3gx6hmsq7KoQIJNZBnpDsFiAHpmM2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZVSbLdW; arc=pass smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c5eb6dfd3so294190a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783709486; cv=none;
        d=google.com; s=arc-20260327;
        b=bBb+HP2vl1N5CTLpWd1U2jWXR5aIDgn9C+YfuPr1oJXQXb0k9uXOc/z3x/UV+Vwpmn
         faAUxZyXWvwLrVYOqsW/W12zAkBbjTB292vMwv/CfbDOAYVSyvIIikwf09wETt8pyz5B
         DbQqK/mPrush/5xUMWPxct+naWOGpYpe65i9gifX5iiXMU3GWGboNApAZRcOWtvx0RL9
         1FievTIXFLtotSfLaHM1pB6z7L6/oFh5XK/4aksfOk4PYaxFzkXiVQnixKP/FKHM3ADJ
         4loJWGHc20KpNRjJk8RYktf5CdJdJjNUMXq7fnueuB63tEnz85bMliNi02S+w6340WU4
         o5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5p78zc2rjIyApVm9wtHFVD/tFOi9RjzwbbxuAlVOl8=;
        fh=3h9ciKSjoSpTRnPToBUXk9k6CL7Eju4hRaZo7fyBwi0=;
        b=aw0KSaZFR1x8bHqMUJdSHOCYeRwZIvjHLt5ZgcGaYSsMiFiWP6gaNiPR82rNKmBE4y
         O/iK8w04I8YheUA1Xh4KBO1g5J5fsyjfWfID+FJmeWdDTtWCAInSJykqC9Ho3RZfTr0J
         epgBhOGAyEG813cKq8/GZ7x+15UerqHKpOYwNw8Btn6/sIqEF3rLPs4O4A+TA3NdpfJX
         5GTUGyiOM3l1MRowwwnyquP2N9+WKLVHkuOU89D2MgutnCn/akEnd/J+/exCkArfUXv+
         BhWXz6O89pKGv7+BDeyULiRaxFn7u916diekBGVTy6tN1K+5JaVZrONCR39GepIevxcj
         2TDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783709486; x=1784314286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5p78zc2rjIyApVm9wtHFVD/tFOi9RjzwbbxuAlVOl8=;
        b=tZVSbLdWfOSR/J9P/LE8swlGv5Op6QPCC/DUsnme/OZG8G/f3pghh7WSEztp6dp6ml
         pPiOQjHSjmyEMMcSl1aqbeP3BnKA6GukqBlmSwzYwQMhPNDk48aS3gv6G46HMNvCdWTW
         h6muqa6eeldp0u2ui6yg3seyK2wFwaeubIDDtGrrkPK94LCKJnVd6V2aPUWwjkrtw1wr
         r4yXrMr/mp34UTclBT0R0CDwRm1GvMzbw/KlsC95hwmOKSPyVELq4VmzTdTvyVciJiUu
         SzVLUrWHLMBkr1ykId6gAKOahRgeGY9ZKFM4d+eymmLcorSsYDAM8mDULva/9IbcaaNJ
         8fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709486; x=1784314286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5p78zc2rjIyApVm9wtHFVD/tFOi9RjzwbbxuAlVOl8=;
        b=p/fELFUuq2sP/n02v7bUSqMFUHQJCcGrK19JB1jOm/3R86mHHPZgnP4y9ZXSFBqR+T
         8jGjChysQEVSmjyqxZA+2B6pyxFnLd5MXkwyc8QyUo9SHGlgmU9l7ezQVSQq1JM46hKA
         NiQSJEij/KiXd+oAs6PLwVA1ImwBv/qDdswNlU6wqskc0KJVsesMXyMWT+hcTIltba2b
         2DHMJ8lq2c4t+eg7L7gvkpds62Niduy97yclbN+8FytmJ/YASM+hGUJQyyitbPPTV8zx
         hP1rkgaQLJNY5Z/z7cpaB+MG1jrU6Ti8I69g4b8dVtQ+lmYethGo6Y9Yw/m+0UOy89VS
         lZmA==
X-Forwarded-Encrypted: i=1; AHgh+RrzYt6sl/0HF3GWfD3yGORxohWttof2/9JM5OSpdGyJOFGvKDTsa3XNzm/BfAJz6wjgj6Bu0xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrjwKp2Vbr4UawJewS7Dtf1kn9QmC7kzwnLCJJdwAcH8W33NXS
	lZaehXjUTOzy4mXjUqbLuspY1Gah+dxHhysuDBSkUhfyuZ4iIZxeh2giB+EMSb712yBwZT5V73T
	t7ioNm3ugRIi05ohkVJJMSbyLCOVAaNhYUQ57c/nB
X-Gm-Gg: AfdE7ckiipfmGId9yRGu+Fr4BLfFoDSaNnapX+Qg4LR+fXi+ydisKsSe0SSXrkKFluE
	gLC54BV/CZ6OceASs/DOZMjHPvI97A9p14oQpb/34ASAoLm9Z+V6/D+ZAFDbdB5NIjkvz26gFke
	jmE4kIpDSrGptENQwgAyo3FSfZjw/2Grb/ZLGydiY2pygQyt7kdYrLJCqvuklmeE3dPJBDCXBbJ
	BWgAUHcuLcfJtSHZES00WCbVqbkIaOfkPhQK0Fn5Hxncnka87Q2zuXD1PaqRNmStEGVboJRBMsC
	bSs+voaUPco4hCGDWcqFvnZofYtXoTDOIHzr+KIIl96sL8x9+Txa6ENIG/rtSvvxrUnNmZYjpuZ
	OHMRG57daivGQc7jpEErX8jOpni90YJUznCRbundjYA==
X-Received: by 2002:a05:6402:13c4:b0:698:e595:a54 with SMTP id
 4fb4d7f45d1cf-69c5f22db6cmr205883a12.25.1783709485858; Fri, 10 Jul 2026
 11:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org> <20260710-net-sft-fix-containers-v1-1-a2915c294ef5@kernel.org>
In-Reply-To: <20260710-net-sft-fix-containers-v1-1-a2915c294ef5@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 10 Jul 2026 11:51:11 -0700
X-Gm-Features: AUfX_myqvOzaMsIaJBI9tHYQ2GZKEYBZ6ZeliutyzZ2d-SAppn0G7CeVtue5cr0
Message-ID: <CAAVpQUC18R6CHS9sDyN-dqjzkU_qePVCbLN+qs+R3+uLeJ0scw@mail.gmail.com>
Subject: Re: [PATCH net 1/7] selftests: af_unix: add USER_NS config
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26C6D73D6F9

On Fri, Jul 10, 2026 at 11:05=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> This is required to use unshare(CLONE_NEWUSER).
>
> This has not been seen on NIPA before, because the 'af_unix' tests are
> executed with the 'net' ones, merging their config files. USER_NS is
> present in tools/testing/selftests/net/config.
>
> This issue is visible when only the af_unix config is used on top of the
> default one. This is the recommended way to execute selftest targets.
>
> Fixes: ac011361bd4f ("af_unix: Add test for sock_diag and UDIAG_SHOW_UID.=
")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

