Return-Path: <netdev+bounces-289317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICzmJ48aDGpJWQUAu9opvQ
	(envelope-from <netdev+bounces-289317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:08:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E62579B09
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38E623007E00
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BF53DFC70;
	Tue, 19 May 2026 08:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107CA3DFC67
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177737; cv=none; b=p0gxpkarHitNwng7pjpDueU0GmxIvGfXIL4xliR8bTIbGZGAVmJi1zus+9zUhUIgpuOwwEtDEk0L5XYaeXwgZHnZNHeJAJzXBU3aIjGewkkjn3JuYz+3IsvjwO+0DDkQ9Pv/JAqUOdO6sbbDS8p3IN7N8HPRKBrgMCGmJyZYSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177737; c=relaxed/simple;
	bh=/P5M35IQE9vQyqcjhsDYw03NSzXCbPfgsBSjaFmFNnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LliiFAfbcyfv4noHGnzFtgsdOn+IKJ7+BM1aybKWgUYdC9kK3YB6T0Co0wjeQ1rA8LG6Y/9ICGSuWgdc8eG5mUxEOdCfWq9XkhBYHdLuejImf2p+zR7nVIVJRki8rOh6EqP6/SpH7943R6kBYg7GRovbZQK0Ss3Qt8V74MVIC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1779177662t37fcc5a2
X-QQ-Originating-IP: Z0PmF1hD7tec2Er2OlF4LVtKK4MVe16XMH5wko+gypY=
Received: from lap-jiawenwu.trustnetic.com ( [115.196.16.37])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 May 2026 16:00:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2616492091751621176
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v1 0/3] wangxun: improve service task synchronization
Date: Tue, 19 May 2026 16:00:45 +0800
Message-Id: <20260519080048.7448-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NDTqPPo9fG8xRwhI4+hzsfAh5oRv0dUK/kWbZ4W5wffxrZZ7yzqSyuK3
	/jZMduisE2bCq+mtTEwlx57SU9EDA96Vl8t6bO3bWX413YtQoA5y5TTuX+PwHsxOxY6ynEy
	8v8RyPSzzyDOK1GkMgpIMB2vP2VRSNHKb0FE+NR0v8iSjg6d3IgzpmJaisOP/yeb0coYtLq
	7Jyh4SrWPADouZaQDCHrE/I8dWZ4rGuadCGx620fr9IorUtBQgNoUXV2ojiUYbHf/nrhyU2
	K6SDqMkx2elh3AAwLhJQpcTyOHrgRxMBGrYxzyRVwXv7D8Axj8AWR5b/XUawme9IHbuCQK9
	GoQ++i3UjYq9BoahLg2m/ffkS9UJ7zxm02QTeZXSCIcJ1fsHZ/vqiiec1BPE3MkrEpKz4Ak
	2eWGCpxxsvUYBlP79qjGfcvRm/LYrscyeUEiX1Vgw0giiFGLN8bLuBHclOh4Epzvk9TwtnM
	kkw2FljNrNDERVM/1hTnj8Hk5RVS04vjxh7K1O0RJzi9eLYutRNeuLn0mx2ZHirf+qAzTCI
	i6giRayofWdboD2FBCnKuFc+hYse2DDLtq2AyIN+rRsvsrTy8Zsm+p+8BTP1J1E9jiyz/Ck
	uzwrEadgmFrbtVRF/8HA01xJ+yR9rgSpqBGnlR66szrjstOvn8jH12RFI69Kf9G/ZsdjHu0
	47TbW0yTu7UBzcL7nQHWovCuwAShidcJWh8bn+hH8bbg+/yZriUGAP8Wy0ID5152QkbpviU
	zw9K7n/8kk50fU21anmu0H+WQ2KYNEh+SKhQBozcaQgD5RKEq0k9rmvQUaYWZEllndDQy4F
	xoJ54nmrQA6p6KuaHktECMKNRFbUTa73I1/1grWrs7WVDwC9n0BLUmt/56D2qNaF6Wy6THc
	3NwtuuFQvo5R67dDXAC9/EfCMJdyp4PlPS3SSbjMk5P2xcEWZCjho0CYeeiJO3o/mp/Epjd
	Ntmm1enVaTopRQO6vM8pWPGSmkh9Fx7HFQZwr3I+dRVBBcrJykazQWXhmNgivkSCw0St0dP
	eEDgAEx0V7pIETe6A2ogxBZGwYS1AU+Xk1g3/pfA8zbyjTo5sq/xQRs1hStgY=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	TAGGED_FROM(0.00)[bounces-289317-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustnetic.com:mid]
X-Rspamd-Queue-Id: 03E62579B09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series improves synchronization between asynchronous service work,
device teardown, and module event handling in the Wangxun drivers.

Jiawen Wu (3):
  net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown
    state
  net: wangxun: avoid statistics updates during device teardown
  net: txgbe: rework service event handling

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  3 ++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 ++++---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  8 ++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 14 ++++++-----
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 10 +++-----
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 25 ++++++++-----------
 10 files changed, 39 insertions(+), 37 deletions(-)

-- 
2.51.0


