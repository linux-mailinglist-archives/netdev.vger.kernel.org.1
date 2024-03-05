Return-Path: <netdev+bounces-77667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8FF8728C5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 21:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A01F225C7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936912A159;
	Tue,  5 Mar 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JhjhrrLe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78538129A9A
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670711; cv=none; b=a5ZHEwqJ4BKzJE0RxaxVU0jxeWhXxPMtTO+mLZcr1bascMWmAe4E2bzU/HfAuDSjav5wUmXl6Mg3CElL1wR1Paw7r0AP+Sf1nz3mCE8DA4p0gJd6T71xBJ2koEEnu2on/LhiOSrizKHQcTgwdDFr75TS/7P6Rrm3f8BEgZG24vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670711; c=relaxed/simple;
	bh=pw3G19sacPvgxxjDa+F7GfDDZnTry5voAGRccl7XUhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaDAagCTorUU5LoIqS8dtVMru9MCKELcjZtUkrlKXMuZJMWBYTV4gpp8Ihq/7WqIE3vmbBwjZPyPpG+Hw1+n4rk/DCYImTbh0ffcffiznu6sDVQI4UJjMAudXt21q2D6u+BaIQTHz7VCHvCh8nJoLW6EaLFjxdXIQaNA3kWpAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JhjhrrLe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e62c65865cso147828b3a.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709670709; x=1710275509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4EwXdmdUlhrJr7UjQPFyD/UJ5/e0VwSFBZlmIPUM/vk=;
        b=JhjhrrLekNSFp/aKxTSWqR/6QpEKkt+GqwB7duR/KKTqfD2CKo5HNLMkIlR8zas4Td
         m/DhF3HpVAomF5iWm/eIqwxxKv9ew5oSSBW7BtIsgNz7ed5K4j4S9Qix1IyJofElVw1z
         fH0C8lejeJK2S98fleJvSV4GvXSbtElR4jpOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670709; x=1710275509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EwXdmdUlhrJr7UjQPFyD/UJ5/e0VwSFBZlmIPUM/vk=;
        b=rtoln5NU8RUIP8IMHn3hlr+Oh0oFREpl7gfV3jOMzstCRflcsLSDlGbkXKa3H8Sp7h
         rrdDSmDLnm7U0rJHuAKspeiNWKWdkyNvfg8Oe86uZAwv4vrgYRH1jwdr0zHFTN3g7JYU
         gLbUOhOVIOBxPrj0Jdpomtj7Ixd4QDz0r+TwN6eNXR8nJqXR6T7pR/2qahD3g5jTJP3B
         R9oMcml3aeSBLjKKOVj7rBAvgIFNm1KDasj+/KIDricUuFDQdSaLzTbpqFPP8j6Sjhaz
         ATAUduUT8PZVoSbh6at35U48KaBTty3xaAbFvpSQb5ZofrqBV4uB6Umt6FSHXLLYUywr
         reSw==
X-Forwarded-Encrypted: i=1; AJvYcCUrCG2EgkaJIidsqPmjEW9+efqLpQHQL+1qzqGlO6duPt5yopphGCc7GenaVcHNzs0N3rGod7Mennt+gKvPl+uAz2WZ89ly
X-Gm-Message-State: AOJu0YyVBVqeFwv5shkm1DGEGSgLkSs+hbNgRsMHoROS99oJluRtgbYg
	/8rVonqwrwAdx8kNaB02fJlXUzv21xhWRn7lXRLeWv/quULtNYeyZZCXvbfqwg==
X-Google-Smtp-Source: AGHT+IEWfc2imOj+NVA7L8pf1cvVI2z/GXhu88fbePla33Jy8RW0G93koevb4py4GfPpafR7599Vlw==
X-Received: by 2002:a05:6a20:85a7:b0:1a0:e1b6:4306 with SMTP id s39-20020a056a2085a700b001a0e1b64306mr2544108pzd.57.1709670708732;
        Tue, 05 Mar 2024 12:31:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p20-20020a62ab14000000b006e47e57d976sm9354568pff.166.2024.03.05.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:31:48 -0800 (PST)
Date: Tue, 5 Mar 2024 12:31:47 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>, edumazet@google.com,
	jakub@cloudflare.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/harness: Fix TEST_F()'s vfork handling
Message-ID: <202403051225.B2ABAC80A@keescook>
References: <20240305.sheeF9yain1O@digikod.net>
 <20240305201029.1331333-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305201029.1331333-1-mic@digikod.net>

On Tue, Mar 05, 2024 at 09:10:29PM +0100, Mickaël Salaün wrote:
> Always run fixture setup in the grandchild process, and by default also
> run the teardown in the same process.  However, this change makes it
> possible to run the teardown in a parent process when
> _metadata->teardown_parent is set to true (e.g. in fixture setup).
> 
> Fix TEST_SIGNAL() by forwarding grandchild's signal to its parent.  Fix
> seccomp tests by running the test setup in the parent of the test
> thread, as expected by the related test code.  Fix Landlock tests by
> waiting for the grandchild before processing _metadata.
> 
> Use of exit(3) in tests should be OK because the environment in which
> the vfork(2) call happen is already dedicated to the running test (with
> flushed stdio, setpgrp() call), see __run_test() and the call to fork(2)
> just before running the setup/test/teardown.  Even if the test
> configures its own exit handlers, they will not be run by the parent
> because it never calls exit(3), and the test function either ends with a
> call to _exit(2) or a signal.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
> Link: https://lore.kernel.org/r/20240305201029.1331333-1-mic@digikod.net

Sanity-check run of seccomp tests before:

# # Totals: pass:70 fail:21 xfail:0 xpass:0 skip:5 error:0

After:

# # Totals: pass:91 fail:0 xfail:0 xpass:0 skip:5 error:0

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

Thanks for a quick fix!

-Kees

-- 
Kees Cook

