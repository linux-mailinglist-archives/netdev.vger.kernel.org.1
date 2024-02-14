Return-Path: <netdev+bounces-71647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A188546E1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 11:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB1728C600
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1605E171A3;
	Wed, 14 Feb 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AhWjdqNb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33034168B9
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905539; cv=none; b=oNrfC+8wIErPZ6plB5inoCZ9OKTbrkHA1k/b2lWgopyh//GD6lesdanFwUK/AqOoAy9HR1bhi5MonKjgbwC0i4SU2fxeX946swOKee+dk9Y5Wia4JXUzu1cmRDxF/PzE6kcWu7kAmnsdBdJvvQHsiJ6pi0d65OTWeZV93zn6GQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905539; c=relaxed/simple;
	bh=ZA7lBAuu4IeO7veD1hQyEQD+pH4US1HdwOPX81wGILU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=D9SlqoIW2GVErS7Oftj4mArwwVfpgByucJEjec7Y2IR+v/gmoFwR4Hv7HzwB5Zr+Y8FmFJxUlSdY9jiDM8GNgb9ldDLnVZJWyil675BnVZHPPJrP68NHlUQB+3v/mxFu+Gm00b2ETjrka1eZfvRQKIh5u92VS4yorDmHneqjMro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AhWjdqNb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5638aa9a5c2so272849a12.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707905535; x=1708510335; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=yL2Gp4X3tVI985N+UUl3qGuOrQx4ao+my4zw/XZTNmo=;
        b=AhWjdqNbpo80cBDjuFX2RB3i+9LWO+pjvHEXMEU2zY/BYvjNlaF71gweSSg/AWVhfN
         UA9kMJSwDzNWRDPNSeZMALfexLez/d9C0H7kNGBtWs2WijmHjBnBO23Uu8C2tpEYrEmy
         Feti3uJl34Md42KUVN8apia0u1tTuGd8FSN52dUjitTZKoaZ7Q9t84dj28j/bH+wTk9r
         2rTtDN4n0ScCwYW8EGUprGxrakfh1kndQdt5iO0scFGXiyUq8cyZ356oGJ8e0RZM2efs
         yW/bf6r7nGJBt6lIXsRQlePAhdkqOwJJx3+XDbSBpELfXHq3DZzF6tlc5N3ZS+Ydxggr
         HCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707905535; x=1708510335;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL2Gp4X3tVI985N+UUl3qGuOrQx4ao+my4zw/XZTNmo=;
        b=tCbsO4CvsJZ6Gp7V8IKZ2/3xkN+Iu9mNwRbWaOa9tNAt/tswr4snNG1PCHspEL3r7u
         xvLcvX+ucTNVF7fIA4Ty+yF6IWHpm5D8Mr6U7axV09f8PGBxpChdjpqafyay4cTwPt0w
         o4IvwTZWOsaOHGVT2ym55gRx/8fCAPKQd17DsCG3ri69SD8jFBEM9CwMlpbqRmMdYcyt
         3gwLSRlRStkjJTOhMhDrk0P8WdVW09hZJXCm719Q4/GCaqsEx9lMPO0Z6mBYWOePJu7v
         EElcGfLxTK9yrD9gEQn82qvLU2gbmORw0Zbb7Sqfm5v877seHDrQ+2rSu4IuX5nhrb39
         Ykqw==
X-Forwarded-Encrypted: i=1; AJvYcCVL/Ks0/toO8vamRSsQBgDMZpZoUVcnbsV6Nhf+65Z22ZlfBoUX4miUCl7+hU5W9N/YnPZdKvetilNphhMjumCrqOWDZy7m
X-Gm-Message-State: AOJu0Yy93Fp5MEcs1nT4c53pw4qoDoCXONFy4XWMMSipu8B+3w/RnLjG
	uQkKxSq94ttoFvVRIi7xt6UkfLPNwhLj4a7p6ce5tTzCC0MRJnlTPD1aGtgYoV0=
X-Google-Smtp-Source: AGHT+IE6HfCBKI8ipHwZQRRuAigOuMfS2Z2p3RbKCNtxo8kUeRutYbq064h7UR0N1eCp+8fqkggX3g==
X-Received: by 2002:a17:906:bcdb:b0:a3c:b261:ef4 with SMTP id lw27-20020a170906bcdb00b00a3cb2610ef4mr1424543ejb.27.1707905535398;
        Wed, 14 Feb 2024 02:12:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtTxI2r/rgD1LU72IOl5H0q4v8Zbjy8x8FLN6LcmC23oiTHWvwWgusMAdig152OgO2wkMG3mydSJzF+n0t9k7Jd4kM4svfAHzfxAUdl3+goLwq/g06nUCLDQQG+ehiZ68KkEgtds9W+0oGv/qJV82gY8rKL3D5O2QeyJ04mwg=
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1f2])
        by smtp.gmail.com with ESMTPSA id dv6-20020a170906b80600b00a3d62948fadsm78638ejb.173.2024.02.14.02.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 02:12:14 -0800 (PST)
References: <20240213154416.422739-1-kuba@kernel.org>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, keescook@chromium.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] selftests: kselftest_harness: support
 using xfail
Date: Wed, 14 Feb 2024 11:09:50 +0100
In-reply-to: <20240213154416.422739-1-kuba@kernel.org>
Message-ID: <87sf1vl5he.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 13, 2024 at 07:44 AM -08, Jakub Kicinski wrote:
> Hi!
>
> When running selftests for our subsystem in our CI we'd like all
> tests to pass. Currently some tests use SKIP for cases they
> expect to fail, because the kselftest_harness limits the return
> codes to pass/fail/skip.
>
> Clean up and support the use of the full range of ksft exit codes
> under kselftest_harness.
>
> To avoid conflicts and get the functionality into the networking
> tree ASAP I'd like to put the patches on shared branch so that
> both linux-kselftest and net-next can pull it in. Shuah, please
> LMK if that'd work for you, and if so which -rc should I base
> the branch on. Or is merging directly into net-next okay?
>
> Jakub Kicinski (4):
>   selftests: kselftest_harness: pass step via shared memory
>   selftests: kselftest_harness: use KSFT_* exit codes
>   selftests: kselftest_harness: support using xfail
>   selftests: ip_local_port_range: use XFAIL instead of SKIP
>
>  tools/testing/selftests/kselftest_harness.h   | 67 ++++++++++++++-----
>  .../selftests/net/ip_local_port_range.c       |  2 +-
>  2 files changed, 52 insertions(+), 17 deletions(-)

Nice!
We've been ignoring skipped tests in our internal CI.
But this is the wrong approach, as you point out.

For the series:

Tested-by: Jakub Sitnicki <jakub@cloudflare.com>

