Return-Path: <netdev+bounces-135173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B4299C9ED
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF71B23379
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4974E19F46D;
	Mon, 14 Oct 2024 12:20:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CC19F13F;
	Mon, 14 Oct 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908415; cv=none; b=azAnDmBHHclcpp67P7BbQgzja7lHIWERVz2u1S9SdruPtpkE1rM2GsbjuwFJaj6hdXtu2cKyZnRdp8LJQKMTAY4NR40/YHcvpdLw757CQjiW23p5AxEzBEAIcoRT+uMMMYl2srIqFHHLwrHiaf6FrBxSdJzluJr9tOXfwJw0QBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908415; c=relaxed/simple;
	bh=AUhjtHtcecM/dEzpdM3LcT0mXsfkX+O7EhREQ5NNmRM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rOhdsx+y6kJuFOPyJpWjEknVbL8Ti62CLILj90iyWirTdQqdECu1WAVqk6LqRXFk22M/UKb+dBsGmqlHJssE2ZUkLsoBPqeQODu4BwI+KMb+3et3xDx/CQiGPGJf+VM4Vl96ViB3KrIoKDD1sPHt7IGdJelW16SZiJL8KfuxoiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XRx8W2l42z1T8dZ;
	Mon, 14 Oct 2024 20:18:19 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 524F91401F1;
	Mon, 14 Oct 2024 20:20:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 20:20:08 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v2] net: microchip: vcap api: Fix memory leaks in vcap_api_encode_rule_test()
Date: Mon, 14 Oct 2024 20:19:22 +0800
Message-ID: <20241014121922.1280583-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Commit a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in
kunit test") fixed the use-after-free error, but introduced below
memory leaks by removing necessary vcap_free_rule(), add it to fix it.

	unreferenced object 0xffffff80ca58b700 (size 192):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898264
	  hex dump (first 32 bytes):
	    00 12 7a 00 05 00 00 00 0a 00 00 00 64 00 00 00  ..z.........d...
	    00 00 00 00 00 00 00 00 00 04 0b cc 80 ff ff ff  ................
	  backtrace (crc 9c09c3fe):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<0000000040a01b8d>] vcap_alloc_rule+0x3cc/0x9c4
	    [<000000003fe86110>] vcap_api_encode_rule_test+0x1ac/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80cc0b0400 (size 64):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898265
	  hex dump (first 32 bytes):
	    80 04 0b cc 80 ff ff ff 18 b7 58 ca 80 ff ff ff  ..........X.....
	    39 00 00 00 02 00 00 00 06 05 04 03 02 01 ff ff  9...............
	  backtrace (crc daf014e9):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000000ff63fd4>] vcap_rule_add_key+0x2cc/0x528
	    [<00000000dfdb1e81>] vcap_api_encode_rule_test+0x224/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80cc0b0700 (size 64):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898265
	  hex dump (first 32 bytes):
	    80 07 0b cc 80 ff ff ff 28 b7 58 ca 80 ff ff ff  ........(.X.....
	    3c 00 00 00 00 00 00 00 01 2f 03 b3 ec ff ff ff  <......../......
	  backtrace (crc 8d877792):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000006eadfab7>] vcap_rule_add_action+0x2d0/0x52c
	    [<00000000323475d1>] vcap_api_encode_rule_test+0x4d4/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80cc0b0900 (size 64):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898266
	  hex dump (first 32 bytes):
	    80 09 0b cc 80 ff ff ff 80 06 0b cc 80 ff ff ff  ................
	    7d 00 00 00 01 00 00 00 00 00 00 00 ff 00 00 00  }...............
	  backtrace (crc 34181e56):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000000ff63fd4>] vcap_rule_add_key+0x2cc/0x528
	    [<00000000991e3564>] vcap_val_rule+0xcf0/0x13e8
	    [<00000000fc9868e5>] vcap_api_encode_rule_test+0x678/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80cc0b0980 (size 64):
	  comm "kunit_try_catch", pid 1215, jiffies 4294898266
	  hex dump (first 32 bytes):
	    18 b7 58 ca 80 ff ff ff 00 09 0b cc 80 ff ff ff  ..X.............
	    67 00 00 00 00 00 00 00 01 01 74 88 c0 ff ff ff  g.........t.....
	  backtrace (crc 275fd9be):
	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000000ff63fd4>] vcap_rule_add_key+0x2cc/0x528
	    [<000000001396a1a2>] test_add_def_fields+0xb0/0x100
	    [<000000006e7621f0>] vcap_val_rule+0xa98/0x13e8
	    [<00000000fc9868e5>] vcap_api_encode_rule_test+0x678/0x16b0
	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
	    [<00000000f4287308>] ret_from_fork+0x10/0x20
	......

Cc: stable@vger.kernel.org
Fixes: a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in kunit test")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Add Reviewed-bys.
- Remove duplicate memory leak backtraces.
- Subject prefix: PATCH -> PATCH net.
---
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index f2a5a36fdacd..7251121ab196 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -1444,6 +1444,8 @@ static void vcap_api_encode_rule_test(struct kunit *test)
 
 	ret = vcap_del_rule(&test_vctrl, &test_netdev, id);
 	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	vcap_free_rule(rule);
 }
 
 static void vcap_api_set_rule_counter_test(struct kunit *test)
-- 
2.34.1


