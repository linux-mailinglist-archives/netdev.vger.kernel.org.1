Return-Path: <netdev+bounces-182071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C73A87AE1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE43D172AF9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7508237172;
	Mon, 14 Apr 2025 08:45:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4A76034
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620332; cv=none; b=rQoZvyODshWvXlQSHiN1BL14pmHtaajdKzrenkHJzhAhQ1Qw+za1aqvWPOdNRon21OCxbgs1ozDHWmxns4AkBaK+6dzzana++HYwsnoV8s3lwDiBFXtL23WX2oJeFfICNguhYUDQRjl0AJOVc++/VobvGTs6gQVAVcUVKAfajw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620332; c=relaxed/simple;
	bh=d5FHXmCede1zH9H5B9HdkWAKMjLvzlpb/T254D9Ow78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h4DtFrY68qIdwjaSZXM6MSNHJmUefY1oJxFpZ9/CAOalRFkM/DfQ/LduEjaq2/q78ZyXst+YuamZcLtXo0haAc8CpADfsd2TjE9mveqIsjPQolMH97ZAMuSkhun69o3tGQ0fsPK97B9joMqgDE5pTdsCXOc8i4R51Obe/dDiryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: izesmtp25t1744620289t36ba5566
X-QQ-Originating-IP: 59YUwYE+nOTeNVHjrTSAlFUExHYJoz3/gB71FGatqRs=
Received: from wxdbg.localdomain.com ( [36.20.107.143])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Apr 2025 16:44:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12153390173393797489
EX-QQ-RecipientCnt: 16
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dlemoal@kernel.org,
	jdamato@fastly.com,
	saikrishnag@marvell.com,
	vadim.fedorenko@linux.dev,
	przemyslaw.kitszel@intel.com,
	ecree.xilinx@gmail.com,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/2] Implement udp tunnel port for txgbe
Date: Mon, 14 Apr 2025 17:10:20 +0800
Message-Id: <20250414091022.383328-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ODmRr9XAsEUImkTk1Qt1p/pl0HFQXtargB74D2+26pTrks4bqa/UPmm3
	qfwr9xSQk5LYN8fbFm9+H9lCAXg8oz44hQ+NQ3A1rsBlNrSNfAvCuNC8wax+M9wbcwy7aY/
	09gAHj1dXcrzlALoIJZ3J4SD1aDw3I0fw14tcwiBJ08+eARYAnJLliXsxsT9bNtfyiKLDju
	7WbP8QZsw9f+EdZerF9e5CpKIQKcE07A/dzwq3xqN8nUSR6Lthl6s14nDJvp0eTOP0OUt6c
	RQu96katXoiavm7WmHvLfkWK3SXr4+51Z5t/Usj069H3Iv2EjhHEymqEwk68x8G4rri7lQS
	LXDNVCBiPNBkVgWMUMj2V0luecgJW8XC95YJ37t6EkKFKRTXUA8gst8hJKQBYnj8S7520te
	AHh4ikDjGWZp3J5uzNsnuZK22dDwEM0xL7FIct2ZL85NYfHjAAjAatgFLF7qTZBgUH4j3D+
	V894IpCrfUBaPuKAKju3c34ro7pO4pTxydVpQg+uU8KH2RHG9oxsQ+zVD9if/KFfd4Dmmec
	X0vcoPBg1RGpMztFVX9UwKLXQ8B/Yx6OvYQs2ZYoe/ZlxqsmPti+sGGPIvVLfUcV+yLIszI
	uNLPQCSDLs3R7U8B6n5OAiYFCYjdu84n1svAsleDIEjTcO+kVw7hZp3121M4dg7u+SzkYfe
	TWjHtxw3YzAueF2LviqouM0bUZ+N3urjn9I/zB5x/kpggkyCOWlicLTeFUmxCqf2LPU5dSX
	QpqMPrQVCh/n9Q1NTc/pCIB9OEJZ/qxln7p+s9R2RqEPDhTnNqsNniVsPKb2O/wUtDG2KFv
	yamtHJ5JGErmeft2WpTJRv4oISkMc9eiAb5JaUFhUUD3Y7fRJoh4Ua8MYBSde9EsadFEtum
	4y5Bsu0WLmGmb0tzg/TNhe14kOQQDLGfkfk/M/d7tRUbo6kjRTuqIz1oQtXzX5cfKqHP30w
	l8i+ZES6eC8mV9TB4K2hAuzTMF67aQpT0IF/h6htN1kqtx/bMyYryrtJBtfLI3RfJizaROq
	17hCUIog==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Setting UDP tunnel port is supported on TXGBE devices, to implement
hardware offload for various tunnel packets.

v2:
 - Link to v1: https://lore.kernel.org/all/20250410074456.321847-1-jiawenwu@trustnetic.com/
 - Remove pointless checks
 - Adjust definition order

Jiawen Wu (2):
  net: txgbe: Support to set UDP tunnel port
  net: wangxun: restrict feature flags for tunnel packets

 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 27 ++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  3 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 87 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  8 ++
 5 files changed, 126 insertions(+)

-- 
2.27.0


