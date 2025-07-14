Return-Path: <netdev+bounces-206497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 923BAB034A3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F1A1898ED3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8121978F54;
	Mon, 14 Jul 2025 02:49:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21D1448E3
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 02:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752461383; cv=none; b=GXPlDDNx+2WGgx7vFLSfkzUKO6mEPifOUG+tUKEXef/zxL6le557NAzN+n2b8idIUFPQytIVhdUXmO6/FA5eMfJBB3wQhXeeZj7hdiukNai3jZ4q6iZ2A7SBDFbyDzIYmQas74Hoh6+eRQqFQOIHGqTUwErDh07U9G9HrBw4lPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752461383; c=relaxed/simple;
	bh=Wm803i2f63O+l4rwwTM+bCWk+h3wMSdAfjMloCkfoLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VFpb3+5pTjogpfJ/5lFGNXnCNI7X0+lOvi864EYxKE5wN9RGHq1lf1taF1vXHawcQoTufMbuMFqlrnuUFe5WIQHrb8/Fnxm1uQivYJaGbfBdchZ5ykrbLcOfS6eSAWwuyKRkQ5NTx3pQn2t8+dxEEecmdVLgVyOWouBi3sLPFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1752461292ta9229bb1
X-QQ-Originating-IP: 2GnXr+EB/qDKQuS5X9XpYJiSAFHQ92HxF8sEZDuh4XI=
Received: from lap-jiawenwu.trustnetic.com ( [125.118.253.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Jul 2025 10:48:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14934807709353301416
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.kubiak@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 0/3] Fix Rx fatal errors
Date: Mon, 14 Jul 2025 10:47:52 +0800
Message-Id: <20250714024755.17512-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OPyRvWmxDTDeI1qX3TgwVNWqfC+lHV/1zqGGksazTiA9IxwBk0MYKO7c
	4a6lQlOldTe6dO76YqRkfEWu+ERTHPlh/tfDkEG9vcUGxPkhMCmbyisLWC1fbFcD6Y1fUVe
	YJXxYf8rEOUgxVRMpZCmp7tQHp/JYGLFtyKgkJnFY9cda1l12I4m+oem7DWX2kCjSW7l06V
	nzUAUYnVbvAH6P4QpZb2JQAsMVXeE9YYaJS0J8pmAfVgCCKVnkAqNalrxtx5gc7XzZ/vBoV
	5vlo8/ssvBdhrK0GDuooFzKHRvYu79hoqobE9TtgF7/GaeQKBJ50Y0ewEbBToJQxKoMVbVo
	wvlWiJsqJCPDffKl/+AcJFDuHBAskki5rAir5RwRMOLDhI6gKKLlwVRzfqWJxnWH+gBKQiC
	PpI2QNgvCajZ/aDcm+zUze/w7sZVqf7mpxlOOtQRHTl4qA8O43an8iJQT5hM4xPmWFvT/Gf
	zA6rs2rlekxN1UlTgmmpqnSBYeYBTVhh/1yD3cA/bQqT7FhxCXitahdmmyla94NjKCVLoXO
	uZLUVofnrTEirEDDkx/Nd3zkohApLmo0SUuq1V0RlwV3FV1qmzEGwmGg31h527v6lrUG68b
	NaE2gf90D20gjhJbc32mqS5Yi5byOqSGCQEHQTAj9dhUs/C1QsvLO6k48/bsPh2ryJkK8qo
	hAYuqjJEdvvOGeDXWa8RjEox7vWy6j5+lfJ9sk8zW0Ag4Jsmjm4YXy7xbCNUPLLTVfon4CN
	xLpxmr8l8UD1oizLnzi2ZPbZS46LqN/qOemgfs6EjgMcwoEvQw6eou/ib0OxFW6JcymtbZQ
	0QUh85M9t0n8MiTONS6HFueqBQLizgejGuo4qHwGtZu4+y8/W6gMQtsCJ4ZMSYKRmT0gbWi
	4cz9DDGdtl+ZpEVRB3ALqQlkaZGuZfUA66MOgzNXhPh4IksKIYJd8CRM5L7507+1M5CtCc6
	bvw+e9UAfbOtyf09tNMC8ubZerzX1bH5Gm60YEHh7IQWeK7HWsomNvwqODZ2Ktmj13IB/2G
	OrzniXqiQ9+BbgzS1hH3njxLD15dadgypRnvSaKCvHvAjEeHuN81k608jmqRA3RlL1YEYzv
	JVwKUmJmO32PqWoY/P9qFZ2CjNtEyqGUzm0FrSkHgfuN2kJ100Ww7U=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

There are some fatal errors on the Rx NAPI path, which can cause the
kernel to crash. Fix known issues and potential risks.

The part of the patches has been mentioned before[1].

[1]: https://lore.kernel.org/all/C8A23A11DB646E60+20250630094102.22265-1-jiawenwu@trustnetic.com/

Change logs in v2:
- link to v1: https://lore.kernel.org/all/20250709064025.19436-1-jiawenwu@trustnetic.com/
- remove the unused member in WX_CB
- correct the spelling mistake

Jiawen Wu (3):
  net: libwx: remove duplicate page_pool_put_full_page()
  net: libwx: fix the using of Rx buffer DMA
  net: libwx: properly reset Rx ring descriptor

 drivers/net/ethernet/wangxun/libwx/wx_hw.c   |  7 +++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 20 +++++++-------------
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  2 --
 3 files changed, 10 insertions(+), 19 deletions(-)

-- 
2.48.1


