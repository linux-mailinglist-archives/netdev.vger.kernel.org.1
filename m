Return-Path: <netdev+bounces-306481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DlGeN5S9UGql4QIAu9opvQ
	(envelope-from <netdev+bounces-306481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4228739278
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:38:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Hppr5b2A;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306481-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306481-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1217030F5E93
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303E3DCD9D;
	Fri, 10 Jul 2026 09:07:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5803D1A8E
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:07:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674442; cv=none; b=nwigIWMoStzQBzgKYtewu4DpqLpXzntj9pv2tpeG458d+XidWWrIfaDPyqDcQtuTbeYerZEJrRSMHPb5H+kKkJBJ+vUDaI65+dlfb67QKhW8dzXFNXPEIfDDuEdAnDC8cGb6g9C4vbdMBB1zDSxBUS3i/JkYFNg+rjsMkYp13fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674442; c=relaxed/simple;
	bh=FLES42Rxy33cINN6JXcMQAsosNS8p9fsFR9zPpgsvpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yn9CVx5X/HirW/qw32v1i0V3xMVnEV73AEAzf7C7YXEiwsSwnC1JVr7c8L0DRQScgaB3NmuXaCpeIY/crlbLc7anCUdX436MI3ea/gUMd/WWOUBixOSlWADXvDb9Cr9z+tuCE6KOtH6qarFhojV0psOnewJzTYnfxXUUpGw1nyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hppr5b2A; arc=none smtp.client-ip=91.218.175.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783674428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yYMMh/W+IAPPdZfIO6vGDfigZx+htl6ZRBZny5XLWw0=;
	b=Hppr5b2AFezieW2dnMnx7mcPVTe3p0+YDUeVMmQSk8UBffzD/hzLSZpaMfRrmLHXE90hea
	j4twTT0kilh5BopHOWLwc0cUqig8GxEE81pi7UIHIcPwWZrBTGDmyqTtIy9Y8MlmT6Zx1h
	F/qs6OCvbHO2bUVUWrYapzPNaF1Nb68=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Fan Gong <gongfan1@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Jian Shen <shenjian15@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1 0/3] net: fix stale TX skb pointers on DMA map failure
Date: Fri, 10 Jul 2026 17:05:21 +0800
Message-ID: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-306481-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:rmody@marvell.com,m:skalluru@marvell.com,m:GR-Linux-NIC-Dev@marvell.com,m:gongfan1@huawei.com,m:guoxin09@huawei.com,m:gur.stavi@huawei.com,m:shaojijie@huawei.com,m:shenjian15@huawei.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ivecera@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4228739278

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

While I was backporting commit 1a303baa715e6 ("ice: fix double-free of
tx_buf skb"), an AI-assisted scan identified several suspected TX error
paths. I reviewed the results and found this issue in the three drivers
fixed here.

The drivers differ, but the bug is the same. On a DMA mapping failure, the
TX path frees an skb while its ring entry still points to it. A later
transmission normally overwrites the entry. If the interface is stopped
first, teardown can instead access or free the skb again.

I do not have these adapters, so I have not tested the drivers on hardware.
I checked the error and teardown paths by inspection. Still, these small
fixes seem worth posting for review. They are independent, but are sent as
one series because they address the same issue.

Xuanqiang Luo (3):
  bna: fix use-after-free on DMA mapping failure
  hinic3: fix use-after-free on DMA mapping failure
  net: hibmcge: fix double-free of tx skb on DMA mapping failure

 drivers/net/ethernet/brocade/bna/bnad.c           | 2 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c    | 5 +++--
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.43.0

