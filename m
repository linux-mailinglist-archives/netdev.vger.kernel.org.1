Return-Path: <netdev+bounces-225184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C0B8FD26
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55997420FAC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B028B415;
	Mon, 22 Sep 2025 09:45:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C992882BD
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534301; cv=none; b=EHgDRVWRzKpvRRCsqODQTMbfbPuilxURy0xlgEn7KO3HM/yOBYp0ndQ4QQsMhW911Zq3ojJcAm6kIRHj5tx+QaSSvqenAEMmc9rh1k9nuvg/Rn9xtiu3V1nss0jhAuGrk0kxdGHDozFWm4SXvlSS7sKgrya003nd38oTco2lor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534301; c=relaxed/simple;
	bh=71QoRnjmC9O6tJOfIG+QtNx1cgT9ZhV3L3W1ETBRibc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QKZR/hsFzpMRpr0yhDpHaXWFMd9q99j9LN1Efgp0uQRFRaxFqP09fjgOIVXGq2We8Fuq1HxXgm3njZLi5Xt2frdPhmg39csTsaOY1/iHpwVqiACxTHIv77crn2TeMWjUbjg+pLcEc5WkQIIxkkrGnaWOKoZvMyqUadBW4fkqCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1758534222t65769ba5
X-QQ-Originating-IP: k9BSMidXsNlL1aAM08WsQBanaINTL29gtjHIqDH7tM4=
Received: from lap-jiawenwu.trustnetic.com ( [122.231.221.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 17:43:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 872683074116194761
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 0/4] net: wangxun: support to configure RSS
Date: Mon, 22 Sep 2025 17:43:23 +0800
Message-Id: <20250922094327.26092-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NiJgP/70eYXd7LhKR9EqEUdnL5EnG9lfx1Cx4ArFOXVq85LN86jo3MgC
	e5WHepI6OcYjA47rASW6lqJPv+uA7y9hqkT6uT/EDgSd8zQavICyBN1kog+xIAkHRQlgIN+
	u2OYN9+tBpyJmoyrSqpYGx4NDkFGCD50Ab6CcX/RJpSoy0pSE8968OtFm/mZ8kb6MwBlpG4
	3Re0WoC17Entkzox4NmYkCMuZZRbFWOMGQnrj2IAVx4ndhRUKD6UQKK5y7LAb1rRlD6zGTz
	gCWs1m+RcM07bOtYeFDdDptIRWeLkMK2tkjw+kY+gHcQW/pBbHB0zkPfKieFE0im4+aiOrG
	73mlRSkBsbvd73637UbipdQ7pNHa+hgXooUDG6THQ2MqmdlKfeF1i8xWwDNSlttAesLGCQV
	VQ9kZH5iQkcqNyZmH4Hfmoj4TWWVHXvcyFoWUIbxoLJNJ5SehnyqA+56oqtdB1e/4SdmxGm
	3RPR0IsogAWvuL+VwK1ppGpobQLNaSgt9LUtjd1qggVx4a+pyhA3IJ9ErQszi9F/9qdXHhq
	aySH7k/BnnRFrb18A8EP5gQWeSfes01cjRXTKVJG4rER1H8+v7o7ohjkfcXLuKC7vXcatOu
	3cg0an6tMHrSv/dz4+ib6cM4O8Q4dTH1zuvW2gy2Rm8jCf43yFIqDhDgDQ17mzbr1IO42ZP
	8Nn2SXzx6njBQzS4iba8yqTQkbV82g+ln+FkMHgOX6pTbAR9ZamWQBuixEngAz4v6qq9fud
	cIpeIQdny9lD2eOwCSqvP1RUqEsHCA24wG1Gh/ICZwptNHYTXvwQQaTsnsciS4F+baNW8ro
	S9/7s+Mz2CwXvKWXTk1NPbTKDjPnn1XRuLRPBWrjalF60JB1Oydt0StKkDMBnkHgj9V0EWK
	PLaFvvh63dIxiDSKLjGrzpA4Fm7BylhqGZiJviFcbydcVDyOQvmEgIxB8ycFX+CVAtQK0g6
	I+j9DN+bcfDsKjLREsgKTy/rPIIMI4GP3ZyUV+mAphbQ71ehJ6qZ+9WZShaW+k1LyDXbiil
	HIDGMrDmzVepocew0S6+oJ40i7xoA7LndlkIhXf4pl2CnijHd7
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Implement ethtool ops for RSS configuration, and support multiple RSS
for multiple pools.

---
v5:
- add a separate patch for moving rss_field to struct wx
- add a patch to restrict change number of ring
- rename "random_key_size"
- use wx->rss_key[i] instead of *(wx->rss_key + i)

v4:
- rebase on net-next

v3: https://lore.kernel.org/all/20250902032359.9768-1-jiawenwu@trustnetic.com/
- remove the redundant check of .set_rxfh
- add a dependance of the new fix patch

v2: https://lore.kernel.org/all/20250829091752.24436-1-jiawenwu@trustnetic.com/
- embed iterator declarations inside the loop declarations
- replace int with u32 for the number of queues
- add space before '}'
- replace the offset with FIELD_PREP()

v1: https://lore.kernel.org/all/20250827064634.18436-1-jiawenwu@trustnetic.com/
---

Jiawen Wu (4):
  net: libwx: support separate RSS configuration for every pool
  net: libwx: move rss_field to struct wx
  net: wangxun: add RSS reta and rxfh fields support
  net: libwx: restrict change user-set RSS configuration

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 142 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 133 +++++++++++-----
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |  22 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  23 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 9 files changed, 312 insertions(+), 47 deletions(-)

-- 
2.48.1


