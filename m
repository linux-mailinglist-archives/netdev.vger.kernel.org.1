Return-Path: <netdev+bounces-241053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D8C7E332
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 17:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6FBB34802A
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6972D23AD;
	Sun, 23 Nov 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVZZ9Qrl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA620FA81
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763913864; cv=none; b=ILQpD+MJI+GKYY0pr76Tp+j/AcjuudUa3faNpyJSS7lyUMXiJlwwYbV+QkfSx3dZCxq3QzDo4axlPGKthvTdN5PNbgP8N2eYGUDW2LWVI6No8tnf+jJleziZf/R9s4ieoZoh8N1SrphT7UXdqb1zeEbrgqZlyn3XIp06oi/5a1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763913864; c=relaxed/simple;
	bh=CL1KNqvx3hKWBDdtbcfQkROj6ESl02CxpZWcnQNp1BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt3e1wtqqc6nIVkrd8ZEtnU0qgcJ4XhbSc4JIKEG5mJpRlKui4C4AVProq5eabtyw0kHz56etH0Gp1dmgVLJ5wPVB3y4t71aadRuqACzZcKLIjUcazlfSmTe7CRBaYYfToGgZTsANQV4L41TKYoYigAtZnyzqpdcXFbYxpbcOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVZZ9Qrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD59C113D0;
	Sun, 23 Nov 2025 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763913864;
	bh=CL1KNqvx3hKWBDdtbcfQkROj6ESl02CxpZWcnQNp1BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVZZ9Qrl0gbpvoGGLasTjdrJFq/XfVxJnPN/hJqBaAIgPqjnF+EQAipvUrlXbi+Pb
	 0iiQVjK0wgp+DVQL0XPRj84m92BkFZtqciApVbJ2p5bvJ6P8hrj8oWPUShg7+CCbHi
	 ebiLg+diSd86sWsPbimLomHHpzs0ppQApl/1ihVy7YgylIwXLt5LoLrxcCAxZe+0gF
	 fH8319xW9aAXjual2RCHDrCV6bQaPDZR/Tdp53DqV1Uddod/AFwGYsJtwUUSuxTgLm
	 bmZRwUwOZ6KELyWiHTPleIfuO9cAYQhbeNwxsw893dGePupKJPh+6KqvfkNPwUSQgR
	 Yp+2Bnge6VjSg==
Date: Sun, 23 Nov 2025 16:04:19 +0000
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv6 net-next] tools: ynl: add YNL test framework
Message-ID: <aSMwg9vRBobjhiw5@horms.kernel.org>
References: <20251119025742.11611-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119025742.11611-1-liuhangbin@gmail.com>

On Wed, Nov 19, 2025 at 02:57:42AM +0000, Hangbin Liu wrote:

...

> diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile

...

> @@ -49,5 +49,9 @@ install: libynl.a lib/*.h
>  	@echo -e "\tINSTALL pyynl"
>  	@pip install --prefix=$(DESTDIR)$(prefix) .
>  	@make -C generated install
> +	@make -C tests install
>  
> -.PHONY: all clean distclean install $(SUBDIRS)
> +run_tests:
> +	@$(MAKE) -C tests run_tests
> +
> +.PHONY: all clean distclean install run_tests $(SUBDIRS)
> diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
> new file mode 100644
> index 000000000000..38161217e249
> --- /dev/null
> +++ b/tools/net/ynl/tests/Makefile
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for YNL tests
> +
> +TESTS := \
> +	test_ynl_cli.sh \
> +	test_ynl_ethtool.sh \
> +# end of TESTS
> +
> +all: $(TESTS)
> +
> +run_tests:
> +	@for test in $(TESTS); do \
> +		./$$test; \
> +	done
> +
> +install: $(TESTS)
> +	@mkdir -p $(DESTDIR)/usr/bin
> +	@mkdir -p $(DESTDIR)/usr/share/kselftest
> +	@cp ../../../testing/selftests/kselftest/ktap_helpers.sh $(DESTDIR)/usr/share/kselftest/
> +	@for test in $(TESTS); do \
> +		name=$$(basename $$test .sh); \
> +		sed -e 's|^ynl=.*|ynl="ynl"|' \
> +		    -e 's|^ynl_ethtool=.*|ynl_ethtool="ynl-ethtool"|' \
> +		    -e 's|KSELFTEST_KTAP_HELPERS=.*|KSELFTEST_KTAP_HELPERS="/usr/share/kselftest/ktap_helpers.sh"|' \
> +		    $$test > $(DESTDIR)/usr/bin/$$name; \
> +		chmod +x $(DESTDIR)/usr/bin/$$name; \
> +	done
> +
> +clean:
> +	@# Nothing to clean
> +
> +.PHONY: all install clean run_tests

Hi Hangbin,

As the parent and sibling Makefiles support the distclean target I think
this one probably should too.

...

