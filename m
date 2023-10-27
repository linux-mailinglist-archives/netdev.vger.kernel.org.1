Return-Path: <netdev+bounces-44763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472C57D994A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE36B210DA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB219BA9;
	Fri, 27 Oct 2023 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jrk9TbrI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE5182D2
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:06:42 +0000 (UTC)
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5F9128
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:06:39 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SH2xB0hRRzMrYlt;
	Fri, 27 Oct 2023 13:06:38 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SH2x93d5Jz3W;
	Fri, 27 Oct 2023 15:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1698411997;
	bh=HsPAU7kFJsQktIBFDD5A3oJhVu7AcVTsWYgBif0Jgno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrk9TbrIAf2xa+L+LrodNvyNVaPSTDKge6pv5wboD5TYW+coVvQYpZlwAJv5vK+LA
	 hJvjFIYMmrJA/S55O3eBBzOAInOXIbMmksOn5lA9KlIifdUI3fDcolTSsamTWI4X9d
	 wKj+3JiN0n4YWWch8Ql+bqFtxHFY7qt1Jev+QnzY=
Date: Fri, 27 Oct 2023 15:06:34 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v14 00/12] Network support for Landlock
Message-ID: <20231027.weic8eidaiQu@digikod.net>
References: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha

Thanks Konstantin!

I did some minor cosmetic changes, extended a bit the documentation and
improved the ipv4_tcp.with_fs test. You can see these changes in my
-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

We have a very good test coverage and I think these patches are ready
for mainline.  If it's OK with you, I plan to send a PR for v6.7-rc1 .

Regards,
 Mickaël

On Thu, Oct 26, 2023 at 09:47:39AM +0800, Konstantin Meskhidze wrote:
> Hi,
> This is a new V14 patch related to Landlock LSM network confinement.
> It is based on v6.6-rc2 kernel version.
> 
> It brings refactoring of previous patch version V13.
> Mostly there are fixes of logic and typos, refactoring some selftests.
> 
> All test were run in QEMU evironment and compiled with
>  -static flag.
>  1. network_test: 82/82 tests passed.
>  2. base_test: 7/7 tests passed.
>  3. fs_test: 107/107 tests passed.
>  4. ptrace_test: 8/8 tests passed.
> 
> Previous versions:
> v13: https://lore.kernel.org/linux-security-module/20231016015030.1684504-1-konstantin.meskhidze@huawei.com/
> v12: https://lore.kernel.org/linux-security-module/20230920092641.832134-1-konstantin.meskhidze@huawei.com/
> v11: https://lore.kernel.org/linux-security-module/20230515161339.631577-1-konstantin.meskhidze@huawei.com/
> v10: https://lore.kernel.org/linux-security-module/20230323085226.1432550-1-konstantin.meskhidze@huawei.com/
> v9: https://lore.kernel.org/linux-security-module/20230116085818.165539-1-konstantin.meskhidze@huawei.com/
> v8: https://lore.kernel.org/linux-security-module/20221021152644.155136-1-konstantin.meskhidze@huawei.com/
> v7: https://lore.kernel.org/linux-security-module/20220829170401.834298-1-konstantin.meskhidze@huawei.com/
> v6: https://lore.kernel.org/linux-security-module/20220621082313.3330667-1-konstantin.meskhidze@huawei.com/
> v5: https://lore.kernel.org/linux-security-module/20220516152038.39594-1-konstantin.meskhidze@huawei.com
> v4: https://lore.kernel.org/linux-security-module/20220309134459.6448-1-konstantin.meskhidze@huawei.com/
> v3: https://lore.kernel.org/linux-security-module/20220124080215.265538-1-konstantin.meskhidze@huawei.com/
> v2: https://lore.kernel.org/linux-security-module/20211228115212.703084-1-konstantin.meskhidze@huawei.com/
> v1: https://lore.kernel.org/linux-security-module/20211210072123.386713-1-konstantin.meskhidze@huawei.com/
> 
> Konstantin Meskhidze (11):
>   landlock: Make ruleset's access masks more generic
>   landlock: Refactor landlock_find_rule/insert_rule
>   landlock: Refactor merge/inherit_ruleset functions
>   landlock: Move and rename layer helpers
>   landlock: Refactor layer helpers
>   landlock: Refactor landlock_add_rule() syscall
>   landlock: Add network rules and TCP hooks support
>   selftests/landlock: Share enforce_ruleset()
>   selftests/landlock: Add network tests
>   samples/landlock: Support TCP restrictions
>   landlock: Document network support
> 
> Mickaël Salaün (1):
>   landlock: Allow FS topology changes for domains without such rule type
> 
>  Documentation/userspace-api/landlock.rst     |   96 +-
>  include/uapi/linux/landlock.h                |   55 +
>  samples/landlock/sandboxer.c                 |  115 +-
>  security/landlock/Kconfig                    |    1 +
>  security/landlock/Makefile                   |    2 +
>  security/landlock/fs.c                       |  232 +--
>  security/landlock/limits.h                   |    6 +
>  security/landlock/net.c                      |  198 ++
>  security/landlock/net.h                      |   33 +
>  security/landlock/ruleset.c                  |  405 +++-
>  security/landlock/ruleset.h                  |  183 +-
>  security/landlock/setup.c                    |    2 +
>  security/landlock/syscalls.c                 |  158 +-
>  tools/testing/selftests/landlock/base_test.c |    2 +-
>  tools/testing/selftests/landlock/common.h    |   13 +
>  tools/testing/selftests/landlock/config      |    4 +
>  tools/testing/selftests/landlock/fs_test.c   |   10 -
>  tools/testing/selftests/landlock/net_test.c  | 1744 ++++++++++++++++++
>  18 files changed, 2908 insertions(+), 351 deletions(-)
>  create mode 100644 security/landlock/net.c
>  create mode 100644 security/landlock/net.h
>  create mode 100644 tools/testing/selftests/landlock/net_test.c
> 
> --
> 2.25.1
> 

