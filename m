Return-Path: <netdev+bounces-73811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ACD85E8BC
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 21:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4B328301C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F027286158;
	Wed, 21 Feb 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3m+74o8S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24A82D9B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545866; cv=none; b=ShufR5p3tu+AE5vNZ1+7racVhkfYivy/cqxslGb45p9JCk4+B4X7MMYwe4FIyihHaRizMU6SIVSbtecq4HJNKjkvDr1cf5w9GB7s3DpOtRZnvwAi1q+OweH3RDhdVabJuJWPtAzCWDkFYNZMrrbqb+sK5jKudyT7G+Wf52TmUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545866; c=relaxed/simple;
	bh=OA1/1MIUS+P/xii3X+kUs1opugBAYp2FXnCE8iim2Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU/e4OZc5JihjIycbBXGGSeHOi1JKJatvLam7Ow4tKKiMfa+q6hzp/j8FQA9or3/Nzu0XTp8NOUoFR1Xl/49j4ov7Z/3GuR0UQiT4jPkgcht02zPqElpfMrWU9AjdRHttoZcmR5k1df7OdfZKDIaFwQ/eUofZMKa3irlM9zCrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3m+74o8S; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c48fc56752so288061039f.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708545865; x=1709150665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HUxWnozNASldM6mLZUsm3giXihd3A7IaClJa0LXBxNU=;
        b=3m+74o8SjvRsdmUgcYcVhHtkQ5gtjFXUrXn6POXh1c7bs4FNNLFfqhCoweEw0t6rVC
         1gwzCq7K8wG2mewcUH2FA551uDimGj2Ajm4SVSdCyDNHl4+rqoAO5P9Hn6kzTK4pM6mD
         MJCR/dYGEVDqVbPN3yr6STHiC8ZpEXAyZ9MD29xvbsWnaImAmx7Pc4PwXmurgb/Tes65
         8/+sCDGnn0uta56Orh5loeKJolOEzWejwsObm98RrnI5Go2s4sZH+4qQj7IVSLUSRbGc
         H/N8zYGffOrHaABy3J+cKHCtTG0ogUFtzi0InKaEuFy1ChIC/QCz2GxbDvO9cJSuogPd
         RhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708545865; x=1709150665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUxWnozNASldM6mLZUsm3giXihd3A7IaClJa0LXBxNU=;
        b=SrDatrqtpfR2YG7YfwAMkpchOkR1U7/Jmeo/1u0VGjnPFczgi60dmnESj+5hOP3frO
         1l+tSakFTZkIXqmJU1Rxr0M5YsiCqIRQAzOPSA3wGlH64yI/YNqfJjdpAaTqkRT4tMvm
         AkXQqP2FBUqvLtKubC/zAm9ZUMSh4E2neA/FMjJSgQlg/zNuZr7hZG8xmbEZuw257M3t
         eDv5bdZGCrXn+QyCDjWrd0M3BALRjO0VVHjTsz/pTh0uCNVZwV8QsMey4b8/dNAUHj7R
         zGmMrLX5pR8XouLPLoxEzIC+wwriGmvaRzpdUjyyZlnYqQZcDOR1DVwpnSMshd5hdrwU
         Niyg==
X-Forwarded-Encrypted: i=1; AJvYcCXWHae+DIHZpgAnON44SlEIBSKQz1p8JCfw5wOO0VPI/PvRG/RoSqCBfaFdmsZ0oVmWrtLVydEFPfISbsghR1QAyUI4qlhI
X-Gm-Message-State: AOJu0YxiJdqOmJ0vQuy51h9xMVN93tUXPQ2TdOZYQxeenwNKD2bESzgp
	WhKevBsDZpa9G3tWa/bLT+EMBq6qmESGO2ehQMnADN74IQgnW2FAsllbC2gwOQ==
X-Google-Smtp-Source: AGHT+IERZJoWhG4EWPF6TTNxmVzRySC9KGEbeq7lW206WSkBdenSx9MWqz5eGYR8XIoLVoQASwKcyw==
X-Received: by 2002:a5d:9b10:0:b0:7c7:6e49:2208 with SMTP id y16-20020a5d9b10000000b007c76e492208mr4170773ion.13.1708545864703;
        Wed, 21 Feb 2024 12:04:24 -0800 (PST)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id dl5-20020a056638278500b004742837424fsm1881404jab.53.2024.02.21.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 12:04:23 -0800 (PST)
Date: Wed, 21 Feb 2024 20:04:21 +0000
From: Justin Stitt <justinstitt@google.com>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/9] kunit: test: Log the correct filter string in
 executor_test
Message-ID: <20240221200421.us26bqteeihiwiwu@google.com>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-2-davidgow@google.com>

Hi,

On Wed, Feb 21, 2024 at 05:27:14PM +0800, David Gow wrote:
> KUnit's executor_test logs the filter string in KUNIT_ASSERT_EQ_MSG(),
> but passed a random character from the filter, rather than the whole
> string.
>
> This was found by annotating KUNIT_ASSERT_EQ_MSG() to let gcc validate
> the format string.
>
> Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Justin Stitt <justinstitt@google.com>
> ---
>  lib/kunit/executor_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 22d4ee86dbed..3f7f967e3688 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -129,7 +129,7 @@ static void parse_filter_attr_test(struct kunit *test)
>  			GFP_KERNEL);
>  	for (j = 0; j < filter_count; j++) {
>  		parsed_filters[j] = kunit_next_attr_filter(&filter, &err);
> -		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[j]);
> +		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter from '%s'", filters);
>  	}
>
>  	KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[0]), "speed");
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

Thanks
Justin

