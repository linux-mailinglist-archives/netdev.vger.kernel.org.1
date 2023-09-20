Return-Path: <netdev+bounces-35175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCEE7A7757
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD98D1C20B87
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571611C84;
	Wed, 20 Sep 2023 09:27:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977F1173F
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:26:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71BAB;
	Wed, 20 Sep 2023 02:26:54 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RrCmK4DbPz6HJc3;
	Wed, 20 Sep 2023 17:24:49 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 10:26:47 +0100
From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
Subject: [PATCH v12 00/12] Network support for Landlock
Date: Wed, 20 Sep 2023 17:26:28 +0800
Message-ID: <20230920092641.832134-1-konstantin.meskhidze@huawei.com>
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
This is a new V12 patch related to Landlock LSM network confinement.
It is based on the landlock's -next branch on top of v6.5-rc6 kernel version:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

It brings refactoring of previous patch version V11.
Mostly there are fixes of logic and typos, refactoring some selftests.

All test were run in QEMU evironment and compiled with
 -static flag.
 1. network_test: 77/77 tests passed.
 2. base_test: 7/7 tests passed.
 3. fs_test: 108/108 tests passed.
 4. ptrace_test: 8/8 tests passed.

Previous versions:
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
  landlock: Allow filesystem layout changes for domains without such
    rule type

 Documentation/userspace-api/landlock.rst     |   93 +-
 include/uapi/linux/landlock.h                |   47 +
 samples/landlock/sandboxer.c                 |  114 +-
 security/landlock/Kconfig                    |    3 +-
 security/landlock/Makefile                   |    2 +
 security/landlock/fs.c                       |  232 +--
 security/landlock/limits.h                   |    6 +
 security/landlock/net.c                      |  241 +++
 security/landlock/net.h                      |   35 +
 security/landlock/ruleset.c                  |  405 ++++-
 security/landlock/ruleset.h                  |  181 +-
 security/landlock/setup.c                    |    2 +
 security/landlock/syscalls.c                 |  122 +-
 tools/testing/selftests/landlock/base_test.c |    2 +-
 tools/testing/selftests/landlock/common.h    |   10 +
 tools/testing/selftests/landlock/config      |    4 +
 tools/testing/selftests/landlock/fs_test.c   |   75 +-
 tools/testing/selftests/landlock/net_test.c  | 1592 ++++++++++++++++++
 18 files changed, 2815 insertions(+), 351 deletions(-)
 create mode 100644 security/landlock/net.c
 create mode 100644 security/landlock/net.h
 create mode 100644 tools/testing/selftests/landlock/net_test.c

--
2.25.1


