Return-Path: <netdev+bounces-56795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB1A810DEA
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087721F2109C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BF22231F;
	Wed, 13 Dec 2023 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="Yjijo1rU"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E72D5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 02:08:03 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SqrlK06hsz9sps;
	Wed, 13 Dec 2023 11:07:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1702462077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tsQLLRpnDsVMTVYA/DDMG6+HfwCM1AaQi256XlTClvE=;
	b=Yjijo1rUyGlx6McYjDVdAhqExki4aGo0QRnIBaOlx6+HCEqNnTYA7txe7XbDIb1mRxK+YX
	Dp8hA02G4W9cFvASklgp/WgEYuaSV3Q4sG6JcxAoj45NNrDs+Y8k0P2WjsvoM/kiXnaA6g
	30UM6V6+KZZUN/OMUjxNzyKGR2TBkzB5ctPaLbRFJeJV174ksDnYKqJ972+ykhHLVAHqGl
	6V8QZW/globGLxtLnVibhy7imNFKfzsoz5HhSUAFHLlOiUoabGxK2Rdnq/sx/puu5A4j7g
	4Lo9ZJznpSXQ1uLlbryk03L3EVPLJyzanmsUOUj+APDNcFd6XR89ZRVKUQaMSw==
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1> <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
From: Petr Machata <me@pmachata.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Shuah Khan
 <shuah@kernel.org>, mlxsw@nvidia.com, Jonathan Toppins
 <jtoppins@redhat.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Date: Wed, 13 Dec 2023 11:03:06 +0100
In-reply-to: <ZXi_veDs_NMDsFrD@d3>
Message-ID: <877climn45.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Benjamin Poirier <benjamin.poirier@gmail.com> writes:

> On 2023-12-12 18:22 +0100, Petr Machata wrote:
>> 
>> Hangbin Liu <liuhangbin@gmail.com> writes:
>> 
>> > On Mon, Dec 11, 2023 at 01:01:06PM +0100, Petr Machata wrote:
>> >
>> >> @@ -38,7 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
>> >>  	source "$relative_path/forwarding.config"
>> >>  fi
>> >>  
>> >> -source ../lib.sh
>> >> +source ${lib_dir-.}/../lib.sh
>> >>  ##############################################################################
>> >>  # Sanity checks
>> >
>> > Hi Petr,
>> >
>> > Thanks for the report. However, this doesn't fix the soft link scenario. e.g.
>> > The bonding tests tools/testing/selftests/drivers/net/bonding add a soft link
>> > net_forwarding_lib.sh and source it directly in dev_addr_lists.sh.
>> 
>> I see, I didn't realize those exist.
>> 
>> > So how about something like:
>> >
>> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> > index 8f6ca458af9a..7f90248e05d6 100755
>> > --- a/tools/testing/selftests/net/forwarding/lib.sh
>> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> > @@ -38,7 +38,8 @@ if [[ -f $relative_path/forwarding.config ]]; then
>> >         source "$relative_path/forwarding.config"
>> >  fi
>> >
>> > -source ../lib.sh
>> > +forwarding_dir=$(dirname $(readlink -f $BASH_SOURCE))
>> > +source ${forwarding_dir}/../lib.sh
>> 
>> Yep, that's gonna work.
>> I'll pass through our tests and send later this week.
>
> There is also another related issue which is that generating a test
> archive using gen_tar for the tests under drivers/net/bonding does not
> include the new lib.sh. This is similar to the issue reported here:
> https://lore.kernel.org/netdev/40f04ded-0c86-8669-24b1-9a313ca21076@redhat.com/
>
> /tmp/x# ./run_kselftest.sh
> TAP version 13
> [...]
> # timeout set to 120
> # selftests: drivers/net/bonding: dev_addr_lists.sh
> # ./net_forwarding_lib.sh: line 41: ../lib.sh: No such file or directory
> # TEST: bonding cleanup mode active-backup                            [ OK ]
> # TEST: bonding cleanup mode 802.3ad                                  [ OK ]
> # TEST: bonding LACPDU multicast address to slave (from bond down)    [ OK ]
> # TEST: bonding LACPDU multicast address to slave (from bond up)      [ OK ]
> ok 4 selftests: drivers/net/bonding: dev_addr_lists.sh
> [...]

The issue is that the symlink becomes a text file during install, and
readlink on that file then becomes a nop. Maybe the bonding tests should
include net/forwarding/lib.sh through a relative path like other tests
in drivers/, instead of this symlink business?

