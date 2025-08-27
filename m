Return-Path: <netdev+bounces-217165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D33B37ABD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7854C17FAE7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450242D9499;
	Wed, 27 Aug 2025 06:47:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE92E1757
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277279; cv=none; b=O7qsCcYL7tpB9X/9USu5F290qSVY0sd6/h6ORf0sYvRvBqvmCfhGQyK55Wd2taV1SjnP1wjqDMHdv6r1xfqp4Hl6qtAoGUhNbkzO7AKFUlq0WXjuuw2wcbD74PdtCysE+e+QmJnSevUM0HkR19ZtMt8J6JSU/RB+9HeggC7vfw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277279; c=relaxed/simple;
	bh=GDK1kPSTSykCMvp7PDaqfI8nnhPXl/+lFG1bKUEUBaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPjWFd4nLOWifDrU49RM0qbTi4g2gxT02/eQ8cYfUiWgdifylifdkMvEjQtjg+Pl43F28XTe7FlGEMsmwVygfvTzYx8JAmzUQp3Ih+mgA2UyuBXAno2UmgpCS1NMV+teyW3zp2MWfRH78F0nUk0pL00+JwhXoMD+Wx2A4y/6DZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1756277213tfbb8c4b1
X-QQ-Originating-IP: KQQ0AkwFaoS1EXpTBHPJlMgghFOYPTpd0IDZfYLoUF4=
Received: from lap-jiawenwu.trustnetic.com ( [60.188.194.79])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Aug 2025 14:46:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1701092373270820135
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 0/2] net: wangxun: support to configure RSS
Date: Wed, 27 Aug 2025 14:46:32 +0800
Message-Id: <20250827064634.18436-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N6Zfg3wJ/Dj45C6323Dftpx+1GzY9epc7zFvcSCAcOWyAX1ZN8ES9Z5j
	cIA2tsIYGuizPYjf+lOVD9BkW5H0c1PeNJlQo7M19IWwA493wyuWsV/uI9huISuRUzvef1R
	/GaxvRbG/0U3FmkWOkyuhvzqR2+B72k++3i+yQ7/VA+Wd6J0X1kg2pa0ZO4KLjjuVk4QyvA
	TdHlMmQhl8by9JTjTlbmimqjZYwnV4Gxj077Esu9a9FIcaAyyV+2O1OceB1g74d4CtJzl5k
	b6i1hNBSh92VbqnzkbX0tdwgoLYeG/W/5gtuVs+PqoCu6ixAxFRUFd6AOva6WKhC4zNg6N6
	yZ5pW3bRst++HBEtuiFvWTzgtvjcx7d5q91l38rDSCjXi/oLebjOQ1JuZORk5D3ql5XicfL
	stQgCC/Grss9dgm7Cc3jqIS6QXEdO3/+c8x0W5N79oL2R/j2y3OPrwG4lcLqM57dyNvt6pc
	Dy+oCNFNKgxwIg4gzqwgqIrxjw9QMq+opY5FBwnEBnh4wkZQWY0GnZnKjRRDHr4PGGZrY9W
	Ro4F5DXE1njlFz1T4gzKQvIXZzGNsTteBegncNtwbxuusLM8L0VSi1vEYT6pI8/FeyypMX0
	pAU5LetaTVo2U/pcTj4XfITlK4+3Xoj+mr9W/XYWcGiJJxQM5X+KVwOjfgsugNWXGPSK82Q
	jjjzfkwJGAUsizPbhlo3MJnweIUnHTYTpDZifTXSBL25Ma2472OdBQHr/NdMVGBeuJKAnje
	KCtoGbW4r0dKlFMyup54gwik2StHJLlT7waJ3+YTMsmmRpa9MT7ZMOBsoo3ZBCTR0L7wi5h
	RllIGyIpMRORYJhqIYG6C84Cu79PLQU/LAHF7L9F2OWb3kYJuK1CTXXe7eAEv8MfkysUd0/
	lJxgjxDlQzjvwpKHdwUwu2a7hash4zy9sNNLTlJp5E5H04mqcKNreFs144Qubqnpo4Wnoay
	wjXH1k7hnqmbwFEFT+y7pGL/HLtqHUqbxP4bFgDauVVhl9n90nO1vk1Z/Ojzhv5ek20YWlk
	hRhp2ATkOjx4ue/2MKKpUPTV68Nbk=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Implement ethtool ops for RSS configuration, and support multiple RSS
for multiple pools.

Jiawen Wu (2):
  net: libwx: support multiple RSS for every pool
  net: wangxun: add RSS reta and rxfh fields support

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 152 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 111 ++++++++++---
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  24 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 8 files changed, 295 insertions(+), 31 deletions(-)

-- 
2.48.1


