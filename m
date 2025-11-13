Return-Path: <netdev+bounces-238201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC89C55E22
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 07:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CB43B3E8D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 06:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431E3176E7;
	Thu, 13 Nov 2025 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn5duSd4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD08A3164D4
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013985; cv=none; b=C+ev7MTutZuB1nwZBd8GLGIEHrptVT23tDyHsBr9u0Z/7dMq8sL/O5HiuMHfGOw7F/fLQJ49GX72gvbACGNjKzT2t0Vo6ZOnz21oBBAwPpZfv8I2cEwgsCkTf6ZSBz2GccrAwRo9M3tg1KyzJZXFw1JHcm5d/wbfV41veBIR/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013985; c=relaxed/simple;
	bh=Ba15DeKaI5wxL6ogHVQCTAa0tH1WPz1Fdy2OZQhGAsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul8FJG44peTwbt3+AHX0tlFLL98q8lhjux3gt3hNF0Rd01pfTXEZOHrOvAQklCum2yLhFjqaFQ9ZmNO3o1rxVPUa/nh4yxbzy29EBFVcZzRx45uoigebQUXuhH964AKh2YqC/K/oBAs14jFrHctFbDXHn94zqKrajQ/JfsYnwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn5duSd4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso364839b3a.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 22:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763013983; x=1763618783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7D69+yc1mCILj7k+TZ0obAweSm27bqM48vgoH4mYiLM=;
        b=Nn5duSd4kzcHiD/pzmveALbGuIXe6Fi5iGdrN4qWNWxRl7FcaOJU+HvdEK6I9mfxJg
         buykc9lRc3uuFin4/47DbXTU05edHmHLc6ArtUs+Mxt02t2xqlfkL9fB4cyZHw73Fq8t
         LUHDHh5KfFdEThbf4i17HoHqaQxZwG6lQb3SPy0QTeeH3JCovoUIpqIW2QF4rAyQgR9I
         jrx1baPxS6i8wdmTDccgQpGdp972Gy5zpmNqlzCMqk8d748+v/2g5cxwVHJLEQrl/AS7
         QZfYpZhOM6GdFKe7236RWSPlOt2wlTX8E3QGds40Ama4pgTiLkFVzcWUBx1/7lBg2UzR
         dp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013983; x=1763618783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D69+yc1mCILj7k+TZ0obAweSm27bqM48vgoH4mYiLM=;
        b=poz8e/EIe0Ixfwx//GdiKY0MWshqzszE4queNWTSahNvudtQZ6yX1un48nGpgGTbY9
         nscNGiiA859OfGjFlN6QQL4sZo9s2c1a277urq9aOwfFKBAYF23LJ4i6++Q1RAAaYj6a
         uxYXoabOumWJ6B/9+6ksgTZ83scKjyd+FlVqZfZa82gngfdmwddkwdOmVJqMdvUwT4fJ
         bDLpJOmJNPKNXiAM5wEFYMvSq2GEnlBMxmoAAay7v2B/Ptj3XDcCv4dGKJz2s/SehSzo
         /AnUQ5vnba2ZgNHunvtCob7HxOF6JkFvlO27fWAVoPy66YbZWWOo8TZeiR6/ILvL+jX3
         L+sA==
X-Gm-Message-State: AOJu0YwNlWjH/XxrZMqhZrjcVE8O9umTAR8eyiROK8oIgM3hcoG1LVSc
	6eJBCWTGq6RJHKZIUpHY3NMtmcL2DobDPfr1UJCGKnf7ohzjSVrLfssO
X-Gm-Gg: ASbGncvzRtrXcWZNVHS4t/Q0oSYgRS3DlFi9yUmnLuSQHGPI0ja1h7xOccpbw/7z3YA
	clnXFuKNVqFKRhUrqXe8uuwgo3/pgjWq8g8eb/5kFYQW6IlJHXwvNyqsBCA+bCZiwJ7rp/fZzvG
	O7MUhP+Y/Vv3TWfVXMlxPpjFyP/RzgeG4S6P7i/RGYm1nmMqC0xciSHGYYFnSxnVKNlfkjVq1tn
	8fRvW9bCZkJAgS7Sq4CBxbT0l3WAZ9h7kpKLBtdqGfZBTxJ8DyR8x+z7HfBnJz1vXfbAoxdbqe8
	dUa5jiLuNBzrjVt/n71cmJ3cxo6cmW2wtFSuxTHsWeHpPlsD1ilAtb1EDZK10buZdrBMr4iqii8
	hNB0XnzyjDIGiI4RR2BehKKVuM/veELJeIUQLcorw8+jsB4za1917k91fyNinHRtcrcpTMowoxa
	cSHA/L
X-Google-Smtp-Source: AGHT+IEoSHxdxyu8fHNYMiZvmtyJ3/jsicgDEqdnAzGM2xmQtX9vOLhnio6a0eMwrdZc3Q5kwDX09w==
X-Received: by 2002:a05:6a00:928b:b0:781:2291:1045 with SMTP id d2e1a72fcca58-7b7a2b92e8fmr6159468b3a.8.1763013982661;
        Wed, 12 Nov 2025 22:06:22 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92782d39bsm974573b3a.63.2025.11.12.22.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:06:22 -0800 (PST)
Date: Thu, 13 Nov 2025 06:06:13 +0000
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
Message-ID: <aRV1VZ6Z-tzbDlLH@fedora>
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

Oh, BTW, do you think if we should exit with the failed test number or just
report failed number in test and exit 1. i.e.

Option 1:

test 1 (pass)
test 2 (fail)
test 3 (fail)
exit 2

Option 2:

test 1 (pass)
test 2 (fail)
test 3 (fail)
echo "2 test failed"
exit 1

With Option 1, we will summary all the failure number in the Makefile.
With Option 2, we will report failure number in each test, and report failed
*test script* number in Makefile.

Thanks
Hangbin

