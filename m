Return-Path: <netdev+bounces-237596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55AC4D991
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C7B3B31C2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB97357A32;
	Tue, 11 Nov 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm5MItlB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65899248F78
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862775; cv=none; b=gDigycQ3UO/LOUQ+IA90qtYaODfCZZOxbenmlApNJjPN+Dle46fjKd0m5a2bEbTqD2VUM+OFVRJK6uSRfjLmLOW9ANQjtDK0bJ/uw4l3sWU1zHQZWv0zMbk9z4TIrZrZAV8mvOHPh2hUb03+B7s+e/mlu56wRRyjMjqzHCEAT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862775; c=relaxed/simple;
	bh=Ta7KzUU3TCvD9JrfDH771bh3vDN4RkkgXbcB7ULJpIk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=XhRw14h9NqbWeI0c99zYra91jZAz5/XvbZWgbkfnvB/Ao/QIQMkFVx6m5d4kcA/cidHuwafVzf5ZygiA/roZqPi3Fla8s+b84mOGKCxjO2RSVf+tpAv3Vt/YBQHPwcV6a98cEsdQ5FLroHWP7RHedaBCDOPQkfFKi8GEDdsRyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm5MItlB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477632b0621so28126005e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 04:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862772; x=1763467572; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hgB5cuJcR8wV4fQjTmS+0idfx/+DwBlWVctnGobAu0=;
        b=Hm5MItlBP9wRkaklmTxx5ThYL3i0Vec/I4qryAl/Cz7PMkx0rKBIDL30f7/igo0nmt
         Y5OnfW211/RmuNJFNZt8yAAQ0hhECbAcnfEgEAT+9Q6ZnLKTOkLQVdLfnGxe6BdJ8Kbk
         mt3QibMyK9icRG3miDerbl4A/vIFkFfBU5SMnxJjSCZznPp8fuv1mNdHHEXq7MyiM3uF
         EcvPVU0rwWKS9d11kXsLVZq2fCo/g3LSqXF1FhLDrbrjPZIH3Nvhcc0OWAdQhY98bNcd
         pr/3z02v+bf9vuQUB2bKUxOPk4qw6vBwUSEWubbxeCZkN/hAXFTQVOClYa3cTwlZga38
         ZAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862772; x=1763467572;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+hgB5cuJcR8wV4fQjTmS+0idfx/+DwBlWVctnGobAu0=;
        b=b1iPSfOWfWhd4ANgOMoG74rt2WvwEAGA/ulA37f6YGjpk+YoxzIS4V6xpXa85Kak90
         v27JIxeEHx0uv0WrgMi6a74jcA/vXYpNG4IF8Y9pbrziiIIhZwVGV/PO5572aeqBUj34
         Z1QLGK+PWKhEwKZU0hBcTzeVKro/GkvOCI5Rt9AFBN3OWTGEs7xC/YFZ6JENnNzPVX8a
         8/GnmiQ7oncIZxA9MTbHLciMgpeyHlc9fisDNMFK/838lyDA4XghTIG72I1R8PrR6FR2
         hZenWWrSi8epg/uKNNql70icrQi/6ugmirOlbde42u+O3iR8s115UYXp37MTkr6lEYtd
         Cj1Q==
X-Gm-Message-State: AOJu0YzUBve9wW4hkr64sOb2iC22N6KKPT/ARrTSufE9sdY0IVf5eQsb
	jqiZPET+gDZhHit856lIyc5T1A905MPeZE8vILworFDjTJGnp8nK8oaL
X-Gm-Gg: ASbGncsgXJE3baLtfVctF9qCzhxXDB0scT6NDRLYVZ6NpFYF96Jcx1I6pBChjxiLc71
	/ZlgXolVkIkKQsLzMt7pwcO9p3vXkDg2CmFucmpdXeEEd8fH1n0kxX6FyfKHn75JpByaxE7LqdC
	7QlQ0ubdGZJsRiHMTD8ktYXeQfw1THVoes/2P995fRigoJu6mhS5NpRoo5NwlegQmHSxcg6Mlry
	AdpH8ETDaQSe6GGpQbrq0nOHcy7wSpOWXDMM/joDQzRquBvkIoQUUNcKqkF+x0s095KERD1uUjF
	GAiqU7EW4/5o76OMpB6vdJjn7/ohoCNdXtv4Ml9OjwhLg+gn2fruiJEx7g3/HVaXlpsOyQbvKqO
	xFxbZ1jZNRdXEFz8OhBoGYyQDurTn+pb4au8Bi54c7JLVzI+69LO48slAP12pWoWKK3Qj4QF3Ef
	5LlVaYkWzZoZ7Xe61KyNizJpoqehPE/110fQ==
X-Google-Smtp-Source: AGHT+IFkMGNkvhR1Akc2IqjoN9pNIwRov2CV+ZDBve/iwGfcXprMWtErWXJCOOSzSbjnOdL+fqltnw==
X-Received: by 2002:a05:600c:1990:b0:477:59f0:5b68 with SMTP id 5b1f17b1804b1-47773228717mr101729825e9.6.1762862771520;
        Tue, 11 Nov 2025 04:06:11 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:f46d:4de5:f20a:a3c4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778164b7fdsm19314285e9.3.2025.11.11.04.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:06:11 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Jan Stancek
 <jstancek@redhat.com>,  "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
  =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Ido Schimmel <idosch@nvidia.com>,  Guillaume Nault
 <gnault@redhat.com>,  Sabrina Dubroca <sd@queasysnail.net>,  Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCHv3 net-next 3/3] tools: ynl: add YNL test framework
In-Reply-To: <20251110100000.3837-4-liuhangbin@gmail.com>
Date: Tue, 11 Nov 2025 11:51:38 +0000
Message-ID: <m27bvwpz1x.fsf@gmail.com>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
	<20251110100000.3837-4-liuhangbin@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:

> Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
> ethtool functionality. The framework includes:
>
> 1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
>    operations
> 2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
>    feature gettings
>
> The current YNL syntax is a bit obscure, and end users may not always know
> how to use it. This test framework provides usage examples and also serves
> as a regression test to catch potential breakages caused by future changes.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/net/ynl/Makefile                  |   8 +-
>  tools/net/ynl/tests/Makefile            |  38 ++++
>  tools/net/ynl/tests/config              |   6 +
>  tools/net/ynl/tests/test_ynl_cli.sh     | 291 ++++++++++++++++++++++++
>  tools/net/ynl/tests/test_ynl_ethtool.sh | 196 ++++++++++++++++
>  5 files changed, 537 insertions(+), 2 deletions(-)
>  create mode 100644 tools/net/ynl/tests/Makefile
>  create mode 100644 tools/net/ynl/tests/config
>  create mode 100755 tools/net/ynl/tests/test_ynl_cli.sh
>  create mode 100755 tools/net/ynl/tests/test_ynl_ethtool.sh
>
> diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
> index 211df5a93ad9..8a328972564a 100644
> --- a/tools/net/ynl/Makefile
> +++ b/tools/net/ynl/Makefile
> @@ -12,7 +12,7 @@ endif
>  libdir  ?= $(prefix)/$(libdir_relative)
>  includedir ?= $(prefix)/include
>  
> -SUBDIRS = lib generated samples
> +SUBDIRS = lib generated samples tests
>  
>  all: $(SUBDIRS) libynl.a
>  
> @@ -48,5 +48,9 @@ install: libynl.a lib/*.h
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
> index 000000000000..4d527f9c3de9
> --- /dev/null
> +++ b/tools/net/ynl/tests/Makefile
> @@ -0,0 +1,38 @@
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
> +	@echo "Running YNL tests..."
> +	@failed=0; \
> +	echo "Running test_ynl_cli.sh..."; \
> +	./test_ynl_cli.sh || failed=$$(($$failed + 1)); \
> +	echo "Running test_ynl_ethtool.sh..."; \
> +	./test_ynl_ethtool.sh || failed=$$(($$failed + 1)); \

This could iterate through $(TESTS) instead of being hard coded.

> +	if [ $$failed -eq 0 ]; then \
> +		echo "All tests passed!"; \
> +	else \
> +		echo "$$failed test(s) failed!"; \

AFAICS this will never be reported since the scripts only ever exit 0.
The message is also a bit misleading since it would be the count of
scripts that failed, not individual tests.

It would be great if the scripts exited with the number of test failures
so the make file could report a total.

> +		exit 1; \
> +	fi
> +
> +install: $(TESTS)
> +	@mkdir -p $(DESTDIR)/usr/bin
> +	@for test in $(TESTS); do \
> +		name=$$(basename $$test .sh); \
> +		sed -e 's|^ynl=.*|ynl="ynl"|' \
> +		    -e 's|^ynl_ethtool=.*|ynl_ethtool="ynl-ethtool"|' \
> +		    $$test > $(DESTDIR)/usr/bin/$$name; \
> +		chmod +x $(DESTDIR)/usr/bin/$$name; \
> +	done
> +
> +clean:
> +	@# Nothing to clean
> +
> +.PHONY: all install clean run_tests
> diff --git a/tools/net/ynl/tests/config b/tools/net/ynl/tests/config
> new file mode 100644
> index 000000000000..339f1309c03f
> --- /dev/null
> +++ b/tools/net/ynl/tests/config
> @@ -0,0 +1,6 @@
> +CONFIG_DUMMY=m
> +CONFIG_INET_DIAG=y
> +CONFIG_IPV6=y
> +CONFIG_NET_NS=y
> +CONFIG_NETDEVSIM=m
> +CONFIG_VETH=m
> diff --git a/tools/net/ynl/tests/test_ynl_cli.sh b/tools/net/ynl/tests/test_ynl_cli.sh
> new file mode 100755
> index 000000000000..5cc0624ffaad
> --- /dev/null
> +++ b/tools/net/ynl/tests/test_ynl_cli.sh
> @@ -0,0 +1,291 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Test YNL CLI functionality
> +
> +# Default ynl path for direct execution, can be overridden by make install
> +ynl="../pyynl/cli.py"
> +
> +readonly NSIM_ID="1338"
> +readonly NSIM_DEV_NAME="nsim${NSIM_ID}"
> +readonly VETH_A="veth_a"
> +readonly VETH_B="veth_b"
> +
> +testns="ynl-$(mktemp -u XXXXXX)"
> +
> +# Test listing available families
> +cli_list_families() {
> +	if $ynl --list-families &>/dev/null; then
> +		echo "PASS: YNL CLI list families"
> +	else
> +		echo "FAIL: YNL CLI list families"
> +	fi
> +}
> +
> +# Test netdev family operations (dev-get, queue-get)
> +cli_netdev_ops() {
> +	local dev_output
> +	local ifindex
> +
> +	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
> +	if [[ -z "$ifindex" ]]; then
> +		echo "FAIL: YNL CLI netdev operations (failed to get ifindex)"

This is a bit misleading, there's no ynl command here so I don't think
it should be a FAIL. Can we just report SKIP when it is an infra issue?

> +		return
> +	fi
> +
> +	dev_output=$(ip netns exec "$testns" $ynl --family netdev \
> +		--do dev-get --json "{\"ifindex\": $ifindex}" 2>/dev/null)
> +
> +	if ! echo "$dev_output" | grep -q "ifindex"; then
> +		echo "FAIL: YNL CLI netdev operations (netdev dev-get output missing ifindex)"
> +		return
> +	fi
> +
> +	if ! ip netns exec "$testns" $ynl --family netdev \
> +		--dump queue-get --json "{\"ifindex\": $ifindex}" &>/dev/null; then
> +		echo "FAIL: YNL CLI netdev operations (failed to get netdev queue info)"
> +		return
> +	fi
> +
> +	echo "PASS: YNL CLI netdev operations"
> +}
> +
> +# Test ethtool family operations (rings-get, linkinfo-get)
> +cli_ethtool_ops() {
> +	local rings_output
> +	local linkinfo_output
> +
> +	rings_output=$(ip netns exec "$testns" $ynl --family ethtool \
> +		--do rings-get --json "{\"header\": {\"dev-name\": \"$NSIM_DEV_NAME\"}}" 2>/dev/null)
> +
> +	if ! echo "$rings_output" | grep -q "header"; then
> +		echo "FAIL: YNL CLI ethtool operations (ethtool rings-get output missing header)"
> +		return
> +	fi
> +
> +	linkinfo_output=$(ip netns exec "$testns" $ynl --family ethtool \
> +		--do linkinfo-get --json "{\"header\": {\"dev-name\": \"$VETH_A\"}}" 2>/dev/null)
> +
> +	if ! echo "$linkinfo_output" | grep -q "header"; then
> +		echo "FAIL: YNL CLI ethtool operations (ethtool linkinfo-get output missing header)"
> +		return
> +	fi
> +
> +	echo "PASS: YNL CLI ethtool operations"
> +}
> +
> +# Test rt-* family operations (route, addr, link, neigh, rule)
> +cli_rt_ops() {
> +	local ifindex
> +
> +	if ! $ynl --list-families 2>/dev/null | grep -q "rt-"; then
> +		echo "SKIP: YNL CLI rt-* operations (no rt-* families available)"
> +		return
> +	fi
> +
> +	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex 2>/dev/null)
> +	if [[ -z "$ifindex" ]]; then
> +		echo "FAIL: YNL CLI rt-* operations (failed to get ifindex)"

Also FAIL -> SKIP ?

> +		return
> +	fi

