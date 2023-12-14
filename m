Return-Path: <netdev+bounces-57674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86991813CFF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 23:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F2D1C20BB9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 22:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF94671EF;
	Thu, 14 Dec 2023 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NILdDd/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E759671E6
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77f335002cfso2008185a.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 14:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702591240; x=1703196040; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nD4fuZGGVi0F/76CQdbSIgduljJzBZKzvOmFura/fls=;
        b=NILdDd/bhGEhHZVrs+GTX2R8jhQSLPDMnfnhmsm1b3rRO5rmCGg9fTy8JS5lPUQ44w
         XbIKSjHC1cpizKNDXussW9Wdjip9GDcO9djYsUtUVd9x3rAZgTptV15rvR2CO8O+tdHZ
         gTg8BRJ0QLonVB5CtcvGLp7mA0RnJIbhAXPeDr7Z/Gf3WcfuDmBooVauizTacUJY0tUw
         kBwpQfoTMYZaVzMEeES00KVCabm/fWLJFcuo79sWZoAy7K07qA8g2ZJOIUSut2PNehQg
         IQ1vfY0D1Tg7bOzE80KVynm7gTxST1Sy61n+ou2nDaRNrFd3yMsWgTyYihR/fohFtrP4
         Fz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702591240; x=1703196040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nD4fuZGGVi0F/76CQdbSIgduljJzBZKzvOmFura/fls=;
        b=apw9EDDDxbBzsIkwXy07GVeuogSS034vVykfFSXSVXNNeTaT0CjddRhTkRikKiY27i
         ZTP4QMapQ/bSKL0OSeFs/CSTgHmurM2VKgkhZBz4NdBGQUvgpwDVpwyD2gztIq0dWZvo
         DhV76v8PvLJGRwqkd6eUnz/14UI9/lYLp+cMsepNqdp5/UiZPezJxy6Am4u2xxFSBtAF
         g8qfhz85qQoj6Dkyff5kwcx0BWNLrRLfxUQN61l44Xia+tQloCC0l5b7o4FQynrETW/h
         eMV1rqWNwi2TWK/0GRjzqCFE0nm2pJ1jnUwjYOfXeQlccJIp+o9hjHplPv7+D9L9+yFm
         XQKQ==
X-Gm-Message-State: AOJu0Yxo08b8nlz7Muze8qtoWlrvKg3oQ8UIffqiDEEmkY2NKOXZTTjX
	+HvjramyAOHwHP/TKgMd3t2pgPVOmHhJ2g==
X-Google-Smtp-Source: AGHT+IF0WBznCCyGmeErwcxL6zTzPZf1CE/hXXET5ENcUokhO16Ofgfs43XLGnp+ufR9Pwu6tkV1Tg==
X-Received: by 2002:a05:620a:857:b0:77e:fba3:a221 with SMTP id u23-20020a05620a085700b0077efba3a221mr10945227qku.123.1702591240180;
        Thu, 14 Dec 2023 14:00:40 -0800 (PST)
Received: from localhost ([69.156.66.74])
        by smtp.gmail.com with ESMTPSA id m1-20020ae9e701000000b007759a81d88esm5550146qka.50.2023.12.14.14.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:00:39 -0800 (PST)
Date: Thu, 14 Dec 2023 17:00:31 -0500
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>,
	Patrice Duroux <patrice.duroux@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jay Vosburgh <j.vosburgh@gmail.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZXt6_4WCxYoxgWqL@d3>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
 <ZXlIew7PbTglpUmV@Laptop-X1>
 <ZXok5cRZDKdjX1nj@d3>
 <ZXqpieBoynMk0U-Z@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXqpieBoynMk0U-Z@Laptop-X1>

On 2023-12-14 15:06 +0800, Hangbin Liu wrote:
> Hi Benjamin,
> 
> On Wed, Dec 13, 2023 at 04:40:53PM -0500, Benjamin Poirier wrote:
> > > Hmm.. Is it possible to write a rule in the Makefile to create the net/
> > > and net/forwarding folder so we can source the relative path directly. e.g.
> > > 
> > > ]# tree
> > > .
> > > ├── drivers
> > > │   └── net
> > > │       └── bonding
> > > │           ├── bond-arp-interval-causes-panic.sh
> > > │           ├── ...
> > > │           └── settings
> > > ├── kselftest
> > > │   ├── module.sh
> > > │   ├── prefix.pl
> > > │   └── runner.sh
> > > ├── kselftest-list.txt
> > > ├── net
> > > │   ├── forwarding
> > > │   │   └── lib.sh
> > > │   └── lib.sh
> > > └── run_kselftest.sh
> > 
> > That sounds like a good idea. I started to work on that approach but I'm
> > missing recursive inclusion. For instance
> > 
> > cd tools/testing/selftests
> > make install TARGETS="drivers/net/bonding"
> > ./kselftest_install/run_kselftest.sh -t drivers/net/bonding:dev_addr_lists.sh
> > 
> > includes net/forwarding/lib.sh but is missing net/lib.sh. I feel that my
> > 'make' skills are rusty but I guess that with enough make code, it could
> > be done. A workaround is simply to manually list the transitive
> > dependencies in TEST_SH_LIBS:
> >  TEST_SH_LIBS := \
> > -	net/forwarding/lib.sh
> > +	net/forwarding/lib.sh \
> > +	net/lib.sh
> 
> Yes, this makes the user need to make sure all the recursive inclusions listed
> here. A little inconvenient. But I "make" skill is worse than you...
> 
> > 
> > I only converted a few files to validate that the approach is viable. I
> > used the following tests:
> > drivers/net/bonding/dev_addr_lists.sh
> > net/test_vxlan_vnifiltering.sh
> > net/forwarding/pedit_ip.sh
> > 
> > Let me know what you think.
> 
> Thanks! This works for me.

I started to make the adjustments to all the tests but I got stuck on
the dsa tests. The problem is that the tests which are symlinked (like
bridge_locked_port.sh) expect to source lib.sh (net/forwarding/lib.sh)
from the same directory. That lib.sh then expects to source net/lib.sh
from the parent directory. Because `rsync --copy-unsafe-links` is used,
all those links become regular files after export so we can't rely on
`readlink -f`.

Honestly, given how the dsa tests are organized, I don't see a clean way
to support these tests without error after commit 25ae948b4478
("selftests/net: add lib.sh").

The only way that I see to run these tests via runner.sh is by using a
command like:
make -C tools/testing/selftests install TARGETS="drivers/net/dsa"
KSELFTEST_BRIDGE_LOCKED_PORT_SH_ARGS="swp1 swp2 swp3 swp4" KSELFTEST_BRIDGE_MDB_SH_ARGS="swp1 swp2 swp3 swp4" KSELFTEST_BRIDGE_MLD_SH_ARGS="swp1 swp2 swp3 swp4" KSELFTEST_BRIDGE_VLAN_AWARE_SH_ARGS="swp1 swp2 swp3 swp4" KSELFTEST_BRIDGE_VLAN_MCAST_SH_ARGS="swp1 swp2 swp3 swp4" KSELFTEST_BRIDGE_VLAN_UNAWARE_SH_ARGS="swp1 swp2 swp3 swp4" KSELFTEST_LOCAL_TERMINATION_SH_ARGS="swp1 swp2 swp3 swp4" KSELFTEST_NO_FORWARDING_SH_ARGS="swp1 swp2 swp3 swp4" KSELFTEST_TC_ACTIONS_SH_ARGS="swp1 swp2 swp3 swp4" KSELFTEST_TEST_BRIDGE_FDB_STRESS_SH_ARGS="swp1 swp2 swp3 swp4" tools/testing/selftests/kselftest_install/run_kselftest.sh

This is very cumbersome so it makes me question the value of
drivers/net/dsa/Makefile.

Patrice, Vladimir, Martin, how do you run the dsa tests?
Could we revert 6ecf206d602f ("selftests: net: dsa: Add a Makefile
which installs the selftests")?

Do you have other suggestions to avoid the following error about lib.sh:

tools/testing/selftests# make install TARGETS="drivers/net/dsa"
[...]
tools/testing/selftests# ./kselftest_install/run_kselftest.sh
TAP version 13
1..10
# timeout set to 45
# selftests: drivers/net/dsa: bridge_locked_port.sh
# lib.sh: line 41: ../lib.sh: No such file or directory
[...]

