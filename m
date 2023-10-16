Return-Path: <netdev+bounces-41114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED187C9D17
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 03:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E685281675
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A548115B5;
	Mon, 16 Oct 2023 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82481842
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 01:50:43 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5069DA;
	Sun, 15 Oct 2023 18:50:40 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S80NW0GNlz67jkV;
	Mon, 16 Oct 2023 09:47:23 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 02:50:37 +0100
From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
Subject: [PATCH v13 00/12] Network support for Landlock
Date: Mon, 16 Oct 2023 09:50:18 +0800
Message-ID: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml500002.china.huawei.com (7.188.26.138) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
This is a new V13 patch related to Landlock LSM network confinement.
It is based on v6.6-rc2 kernel version.

It brings refactoring of previous patch version V12.
Mostly there are fixes of logic and typos, refactoring some selftests.

All test were run in QEMU evironment and compiled with
 -static flag.
 1. network_test: 77/77 tests passed.
 2. base_test: 7/7 tests passed.
 3. fs_test: 108/108 tests passed.
 4. ptrace_test: 8/8 tests passed.

Previous versions:
v12: https://lore.kernel.org/linux-security-module/20230920092641.832134-1-konstantin.meskhidze@huawei.com/
v11: https://lore.kernel.org/linux-security-module/20230515161339.631577-1-konstantin.meskhidze@huawei.com/
v10: https://lore.kernel.org/linux-security-module/20230323085226.1432550-1-konstantin.meskhidze@huawei.com/
v9: https://lore.kernel.org/linux-security-module/20230116085818.165539-1-konstantin.meskhidze@huawei.com/
v8: https://lore.kernel.org/linux-security-module/20221021152644.155136-1-konstantin.meskhidze@huawei.com/
v7: https://lore.kernel.org/linux-security-module/20220829170401.834298-1-konstantin.meskhidze@huawei.com/
v6: https://lore.kernel.org/linux-security-module/20220621082313.3330667-1-konstantin.meskhidze@huawei.com/
v5: https://lore.kernel.org/linux-security-module/20220516152038.39594-1-konstantin.meskhidze@huawei.com
v4: https://lore.kernel.org/linux-security-module/20220309134459.6448-1-konstantin.meskhidze@huawei.com/
v3: https://lore.kernel.org/linux-security-module/20220124080215.265538-1-konstantin.meskhidze@huawei.com/
v2: https://lore.kernel.org/linux-security-module/20211228115212.703084-1-konstantin.meskhidze@huawei.com/
v1: https://lore.kernel.org/linux-security-module/20211210072123.386713-1-konstantin.meskhidze@huawei.com/

Konstantin Meskhidze (11):
  landlock: Make ruleset's access masks more generic
  landlock: Refactor landlock_find_rule/insert_rule
  landlock: Refactor merge/inherit_ruleset functions
  landlock: Move and rename layer helpers
  landlock: Refactor layer helpers
  landlock: Refactor landlock_add_rule() syscall
  landlock: Add network rules and TCP hooks support
  selftests/landlock: Share enforce_ruleset()
  selftests/landlock: Add 7 new test variants dedicated to network
  samples/landlock: Add network demo
  landlock: Document Landlock's network support

Mickaël Salaün (1):
  landlock: Allow FS topology changes for domains without such rule type

 Documentation/userspace-api/landlock.rst     |   93 +-
 include/uapi/linux/landlock.h                |   56 +
 samples/landlock/sandboxer.c                 |  115 +-
 security/landlock/Kconfig                    |    1 +
 security/landlock/Makefile                   |    2 +
 security/landlock/fs.c                       |  232 +--
 security/landlock/limits.h                   |    6 +
 security/landlock/net.c                      |  198 ++
 security/landlock/net.h                      |   33 +
 security/landlock/ruleset.c                  |  405 ++++-
 security/landlock/ruleset.h                  |  181 +-
 security/landlock/setup.c                    |    2 +
 security/landlock/syscalls.c                 |  158 +-
 tools/testing/selftests/landlock/base_test.c |    2 +-
 tools/testing/selftests/landlock/common.h    |   10 +
 tools/testing/selftests/landlock/config      |    4 +
 tools/testing/selftests/landlock/fs_test.c   |   73 +-
 tools/testing/selftests/landlock/net_test.c  | 1688 ++++++++++++++++++
 18 files changed, 2910 insertions(+), 349 deletions(-)
 create mode 100644 security/landlock/net.c
 create mode 100644 security/landlock/net.h
 create mode 100644 tools/testing/selftests/landlock/net_test.c

--
2.25.1


