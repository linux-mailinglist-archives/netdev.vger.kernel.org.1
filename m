Return-Path: <netdev+bounces-205277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF50AFE01A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50DF1BC77B2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 06:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B47626CE3E;
	Wed,  9 Jul 2025 06:41:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A926B96A
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043319; cv=none; b=A9Zfyuhs4gEgFhssmkEbmUeqY7MuqPKnddXq1iYnoZ0Zbj6BNw8SVcZJUfKj2nPP1f5Bfl9J3TZRsYJvg557s6l84h7Y+VSSIi2/+RYmRtF4qHyMP8gcfreQX4rjktf9F+Co+ONVa/G87jQA0ohmQEa6mK95icGcYvKQX0mY6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043319; c=relaxed/simple;
	bh=ST3X6UAnlQHvBgEeaB+GTiZNXNe0+OIR9F5Zd8U3IiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JL3x6/ndAbuXAPdaphmJLEGKSHm3E+5SILAI6O4Xd9TfreRH/SpKmmx5BKy+RhxBm3OR87colKEINgFSfpCUHsLzP7wobixORBiHMP++pETwJERukkMM/hDRi4RH/4Z76y4LypENFa7IZRux13aFc5dBjtrJ7+NGh16Sq5IQ558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz10t1752043242tf0ad3802
X-QQ-Originating-IP: fJI8y6x9OdiHR7dMuuZjvX4YTFtaKrurT55ZdeDMOzQ=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.45.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Jul 2025 14:40:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15461137682457919814
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
Subject: [PATCH net 0/3] Fix Rx fatal errors
Date: Wed,  9 Jul 2025 14:40:22 +0800
Message-Id: <20250709064025.19436-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NvGGTAUhB2iWJeoK5ai6KYrrEah0F5+EQMkoYtcbwEZ40CYft2Aw8/vf
	kXkbYRlYZdTDWIAhfVJTS7rU9qb4KV4Zt1StR12g74dI7iDzo9gZj4vVvF3BQa6NVTEYw1w
	9YL9kehcsQF5Jp4hm6dS7738frNiBR8j3HPdyHH/9nFdi6IHfY1UVfD1F0lONMelgEibKQh
	JV39+LrJlLkyYha+fGjrWVvr3DVzMK3JgftyX+/qYZ2E5Md3GZsWdRHgh1LQZJ2xxjIdvU/
	q5e4aCwwo6+vmq7A0HAIsgoSyEm1vg+vzNSzDuCKKNY0OUBPm3RV20NiUZGCFwzeOCo9kNc
	TI+TE9PIQjBXKnV9KaOaDJMt5EV1CIspHJ1DJBdrKV6YMa2Nx4ufIifwjb8UbBr7GjuSHkc
	N3TP/A69y/wjr6KdxJQEeixIYAd02pUq/yIpnt/d8Du5hHJvC4Wqs/zljUerScwxAsMTiyV
	F6jlVYc5aF6l6Y7PhOQTFFy0YFwF8JMS6mkcKQpPVl6bXxCDpd/4W1cryaMsVfdWYbv3LIA
	MDMcGrHByJhdSruKrLFeAcdYN43+fSkDVrM+9PAXseXcdG21hUN5c7H1oIr7qM1r9ReP10u
	g8t+BAFB+rLtWGyrFz7Gd4H1A+Z76ZXn4dsXZ+8rWjrnu8UosawhHM1InvyQSIU9lr7Ub/3
	8ipav6+NnPfpG4+8/y8k/XELvvik2eKH+elAvesv7FdB+Rig1I9SwDPJOv2u7VLbIPg6F0C
	qYNSjlffDSEWnNvtmjFL9rmYDGNl/Bg4xarBody2pACZ3tm/vd9uOaivK5u8axf/pn+I2tH
	2DHomEAa3fmCZ5pXmaMZh1LAQj3vbfAWtkl+QdkTKmUhD9zVR7DCTL3cHOgzAir2K2HcQij
	XDdgdjfYJbVBZ61C8N/hCL2AU8FdcLHw/CS+UhaDVg2UM8Tl9GBqkAiX1hB94orQRfz1FHN
	lQHp7ASEwI0F72ednHtnQOe2G1qt2JSgBMFHH59OEUUbTh4QRFRTaeBEXKVLeokC29e2Yen
	uL5/rB2xejXhqvuqvh+EMjBWUvfikBoOKP15Nv1QdEAIGS6BGTfoREm0NfqH4=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

There are some fatal errors on the Rx NAPI path, which can cause the
kernel to crash. Fix known issues and potential risks.

The part of the patches has been mentioned before[1].

[1]: https://lore.kernel.org/all/C8A23A11DB646E60+20250630094102.22265-1-jiawenwu@trustnetic.com/

Jiawen Wu (3):
  net: libwx: remove duplicate page_pool_put_full_page()
  net: libwx: fix the using of Rx buffer DMA
  net: libwx: properly reset Rx ring descriptor

 drivers/net/ethernet/wangxun/libwx/wx_hw.c   |  7 +++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 20 +++++++-------------
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  1 -
 3 files changed, 10 insertions(+), 18 deletions(-)

-- 
2.48.1


