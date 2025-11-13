Return-Path: <netdev+bounces-238189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993EC559A1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 04:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DC83A5E6A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 03:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB125BEE8;
	Thu, 13 Nov 2025 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htF79OEk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C37E0E4
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 03:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006237; cv=none; b=cLoCF1xECJpXWP4N/RTplZqi3vChXWO3GRZ4mf2CJCUEayiwYvdJPRH8uJlGy1MTRwGV9WOCr8Dk2yyLnfUmvP+d7Trzq30SHO6i1sx543pRzHq03himDSDkgfwEwfJeECMWzsdjqzJA3nVEHcEejhWUqn8WyBUDYLUaSc1Yg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006237; c=relaxed/simple;
	bh=+P2+2CZfdjKu2J/Pa8JD4SJBhHlacxgRnanOxFShp8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glzTQQCrza/+r8xtgUHIf4bOtbD2VhioNDMRkTGWVRlFK6BAYx/yfFsWEj7QlHmyxcVYdIBQRevQgxnwu+lqPW5272QOiwHeK0bv1c/SGGxlUyoS3QWrn8KlCNybtb/h1SCOPzvw7JQrvnUOS/Gv7de6nyq5yNWQuEFUK/EAF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htF79OEk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7ade456b6abso265806b3a.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763006235; x=1763611035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B748lG1lzdocCvgGvVxib/+kpH4740D2BGTgZy2aY+w=;
        b=htF79OEkEup16IeU1oRsf7MAby88KfLNujhOSX0caezF/GqbBa3S1+Gxl5CdkQ2Sf8
         CpLcmQhgtpc+8YNVllGhrC1ENru216SqRaN2vboGu+5dFNmELQ6L13nWE309bXWUXmIl
         C5D5d/p/5hv74Hy2r1RMRCg4i6fm74hSCikRBl2EkIEAZ1S/ZE97hx2xA7l/AwKkWfaB
         DaszWqgCVSUi8d+0In8G9X+YfunXVGn2CsYk3f4BK7Ga0jKDNGAGxooxM8LhjaPRFUOB
         lj1RClkZY+fFcofyCcGcwXUPY+BR103oUcoYBSt3hJSLcCDTR879vRvQg7RKbo4nljux
         TJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763006235; x=1763611035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B748lG1lzdocCvgGvVxib/+kpH4740D2BGTgZy2aY+w=;
        b=J+Kte58p3T2JXj8QBjkLK9tUDx+H2MJXkrEJ/14BbFdmWeURjAC4cctxyFUOPAevyK
         69iI2Vpn1Rx7nM8YdZ1g0jOaWJ258kb4sAHCTXT1NttuVxXt70dkVEuUlQnVMutfgUrY
         KeJplMRiCFNqAtFEjVQQN2ry08homc3WYDZylhI+W5WOTQ9iXZdsBOOFnMjvQWDSjFKR
         27jLpwRVy1KqfI3hty8QS2Nia6zlrqoOVO8h3/+19xPv1bK0qLkmTVDGvtjMIOO73rBX
         z6vwO+x/E0DmXIit0gAuqCHJz8t0hNRZML56O6hYSbBaupm/SVdvgrnk9KF0l0qXhCV5
         TU7Q==
X-Gm-Message-State: AOJu0Yy+3Gm4nuVuCsXkSvkaEPwSw3/bvVyR9v8QEDr3aEekV7FnwRCr
	8FccTJvs61p1qWJPw6V1JTOWAxgb99eLmKmQ73ek4jpSdAFuWfEceDpO
X-Gm-Gg: ASbGnctlsi+t3CP/p9QJqIBWMDx75PNVZmCcHG/QG4YCT1kHwoha0LVxRkikrL1Ypj9
	4lRf+mJLk5AWDxNZ+c4TaTaqA80MM1FCLOwl3B+8gN5ozmsycQCOdJ0LkQLhm9H2e6fTbyIn+y+
	yW6UY4RsYyIKfeDDu4HcTZNT4zDhj87dkSFKSYWfo8DoAgkZAMtehv1X3mSm4nKX+A9DsLmol2X
	gDp64tRpOrlvYkn49cfYiW3H8paYqYp2HVkT7Rtt/q5XfsTFr0790uUbLqAHtQ4YIRqUZbPful6
	eAaU2w7+v7z17TNDIMmfSUYS2PvqMbF1jpT+R8prfi3eIubvP3sPsN2ixyAkbnVvry5G06G80tk
	X84lz7Nt7mYT9T4NaCtJS6CQ3OlsewaLIE62Y9hsjLGSSpcJd5/bX6rHW7fC1ZPMszEQ3Y3j30g
	n0ho/G
X-Google-Smtp-Source: AGHT+IH2R81AWGWCpjBOh/560HEB4c0Cy5SAnffGD4mPqCjqZAspI+d28k/BSrMeJlXih6h5cQPCOA==
X-Received: by 2002:a05:6a20:9185:b0:340:db9b:cfe8 with SMTP id adf61e73a8af0-35909385f92mr7947566637.12.1763006235413;
        Wed, 12 Nov 2025 19:57:15 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375177be4sm607227a12.19.2025.11.12.19.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:57:14 -0800 (PST)
Date: Thu, 13 Nov 2025 03:57:06 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv3 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <aRVXEmUowd0rqnLU@fedora>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
 <20251110100000.3837-4-liuhangbin@gmail.com>
 <m27bvwpz1x.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m27bvwpz1x.fsf@gmail.com>

On Tue, Nov 11, 2025 at 11:51:38AM +0000, Donald Hunter wrote:
> > diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
> > new file mode 100644
> > index 000000000000..4d527f9c3de9
> > --- /dev/null
> > +++ b/tools/net/ynl/tests/Makefile
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Makefile for YNL tests
> > +
> > +TESTS := \
> > +	test_ynl_cli.sh \
> > +	test_ynl_ethtool.sh \
> > +# end of TESTS
> > +
> > +all: $(TESTS)
> > +
> > +run_tests:
> > +	@echo "Running YNL tests..."
> > +	@failed=0; \
> > +	echo "Running test_ynl_cli.sh..."; \
> > +	./test_ynl_cli.sh || failed=$$(($$failed + 1)); \
> > +	echo "Running test_ynl_ethtool.sh..."; \
> > +	./test_ynl_ethtool.sh || failed=$$(($$failed + 1)); \
> 
> This could iterate through $(TESTS) instead of being hard coded.
> 
> > +	if [ $$failed -eq 0 ]; then \
> > +		echo "All tests passed!"; \
> > +	else \
> > +		echo "$$failed test(s) failed!"; \
> 
> AFAICS this will never be reported since the scripts only ever exit 0.
> The message is also a bit misleading since it would be the count of
> scripts that failed, not individual tests.
> 
> It would be great if the scripts exited with the number of test failures
> so the make file could report a total.

Yes, indeed, I will fix it. Thanks!

> > +# Test netdev family operations (dev-get, queue-get)
> > +cli_netdev_ops() {
> > +	local dev_output
> > +	local ifindex
> > +
> > +	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
> > +	if [[ -z "$ifindex" ]]; then
> > +		echo "FAIL: YNL CLI netdev operations (failed to get ifindex)"
> 
> This is a bit misleading, there's no ynl command here so I don't think
> it should be a FAIL. Can we just report SKIP when it is an infra issue?

The test reported SKIP for infra issue in setup() function.
Here the netdevsim device has already setup. The ifindex should be there.
Maybe I should use ip cmd to get the ifindex number and skip this checking.

> > +
> > +# Test rt-* family operations (route, addr, link, neigh, rule)
> > +cli_rt_ops() {
> > +	local ifindex
> > +
> > +	if ! $ynl --list-families 2>/dev/null | grep -q "rt-"; then
> > +		echo "SKIP: YNL CLI rt-* operations (no rt-* families available)"
> > +		return
> > +	fi
> > +
> > +	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
> > +	if [[ -z "$ifindex" ]]; then
> > +		echo "FAIL: YNL CLI rt-* operations (failed to get ifindex)"
> 
> Also FAIL -> SKIP ?

Same here, the dev has created, I will remove this checking.

Thanks
Hangbin

