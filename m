Return-Path: <netdev+bounces-183629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5ECA9156A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F923A7853
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA12185BE;
	Thu, 17 Apr 2025 07:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19B2153CD
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875518; cv=none; b=b9XTiRx95MVDh0zkZpKwZ48ejmp059K17QVv5EPaYlUsMslZ6/tki/qy9IRm2sZOFYUErZnqLgY3zYRLoQNpqrVDxeOCIbnFOWpyN0XRmDjL/hj5VCFN/HPfyVYu3IYfMEt9aZOQ0dBmdbmhXgdyYgMHYwWo3YagQnt/kAAd9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875518; c=relaxed/simple;
	bh=LpoHdi4pCBtTMcTaQRXr5UtLvJk8nq+OKEnCuGucOkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IbgIgSaZmSF89da6m67izY71o4GUX6tXXwGQAscDjj/Ovyc5cT2lUJSIxi+w41oYLcy6OH2JJqB6StP2tl2V62Q9r4ugY922bOeJtjkaGA9stzQZJn4jT5d/49fmAqSIQMWokwQ5RNAWpB1gdDhGFnQRWRbdhNEKjHOToJy3p2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz7t1744875476tc5f85857
X-QQ-Originating-IP: 8FWEwk81tULp258+pedQTAR7651ExahAEDB2T+cs4Gc=
Received: from wxdbg.localdomain.com ( [36.20.107.143])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Apr 2025 15:37:48 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 386562581067472111
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
Subject: [PATCH net-next v3 0/2] Implement udp tunnel port for txgbe
Date: Thu, 17 Apr 2025 16:03:26 +0800
Message-Id: <20250417080328.426554-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ObFHHlrAm4402Ro8pPHC/Qx7jb3vwZcXwjZ6FadjcB0xh7TyPwXRaEXU
	37Z07KcTnT9NYVxfmz6ibhuGnCa2VmDXx22HxVEazwmR1P+DZ5h7OGn57ZNum1Az1FHU5Vp
	llndG3Hl3R4Pn+xpDzK8fRgasmEQcsBdeblWMa+y8VvujGzYrqs0n1GIBdAx/jxjCg2EHbU
	90WFihJgmb9+Whw2kn4dBelgKuyV/ZQd1Qc5Y21zRocpI4CVhuFQa8gbY7SuVYpqQO4PnjZ
	/USyuT6vYpgamggbv4R2CbaLK9oOlR+LisiXXUeOPT6hRWC23LHzzt39yxVjWx3yqT/i10c
	ca2zQgEULQOcC8sD9TAhnhXO5BXUD22DfqtRDF1wlrvHKDr+8zEdyMIwdFrCQxKEu6Kd1zl
	aTBR2B898v9lniVArhCL06OzrCS5aFg1SWWwrKed5d86WObIO9isFdblsFJeSULGFU2S8dN
	BLj7BTAVCoyPMWIWryq/XBoJvQHjIwQeun/ryOY/4d6Gh+kntaxsSd2Hd7nCkFvmwCbT9hT
	oBDP/99Kze8Y0pXrw8Pt06C8/yVFzU+ndJhtL6k2OHIt0DluB17YKGCSxH7ptCCyMrigVz5
	rpyHo4i15M+HGOU/2BmOOdFVTXebhvLpLaCH944L1NG3nZsE1oz4k/NACsTjTu8Tp8qZ+xZ
	9xyx+BvFOMA4O78mruOjiGknFXUE++ojMtmLxSB65tDAlBmhT5RZwH92lSW58YT1WY2tE5Q
	vmTFugJEWHvPXG+JxA7DU7oGDic3uD7ZMBXQsG/NF0tQrTKm8lvIC/jViUW2Rzk+Nr/frje
	yPFyrh9CXbhxA6/o7VzFZEGqUc6YiPuHXS9kmFxM0UZtXhDoUYZCn1FauULgh6qelLVHe71
	6VkHzc5Ilolrjvr+V8FF8tOSj1TwcHDQWo+bxvO8A2BueTXk7ohRBL5k/QuuvoYpFyp2PSi
	LfFB5Ol2tG7S2t+K6Cfk3YlgS8cW0quPDPdie98+uNLh8UPoepEhbByXiM7Xt5SzqKQqlYZ
	iIYMBSHdo1jeeuJ3ZPZTbkqdzx/xFne9k0SUam9p0Yte7TIiAhRoICAX6Fsf7VV0VLlh2OX
	A==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Setting UDP tunnel port is supported on TXGBE devices, to implement
hardware offload for various tunnel packets.

v3:
 - Link to v2: https://lore.kernel.org/all/20250414091022.383328-1-jiawenwu@trustnetic.com/
 - Use .sync_table to simplify the flow
 - Remove SLEEP flag and add OPEN_ONLY flag

v2:
 - Link to v1: https://lore.kernel.org/all/20250410074456.321847-1-jiawenwu@trustnetic.com/
 - Remove pointless checks
 - Adjust definition order

Jiawen Wu (2):
  net: txgbe: Support to set UDP tunnel port
  net: wangxun: restrict feature flags for tunnel packets

 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 27 +++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  3 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 39 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 ++
 5 files changed, 73 insertions(+)

-- 
2.27.0


