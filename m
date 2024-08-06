Return-Path: <netdev+bounces-116219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A3949854
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBDA1C20E3A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD451459F9;
	Tue,  6 Aug 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0OV04/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D6143C46
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972817; cv=none; b=Z8du0Rp/rLK3zyq1qRJlD97unfqcxH6MbxAVUG8Oete4tAgAmxpw1CyBuVplULhDQxVKeM7OdLK+i9ukp8gO4Ft2UuE1gfjc6sFsd0pYpejXMqUfux0OOLqqQdw/j97s623y3Sk+XGiYmTU+io2jQ5VJ1HiKjl/IADXC4PfLtfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972817; c=relaxed/simple;
	bh=KisNNNCfQT3YqpWIenhbN16DNRy6W+U6stCIScrNpco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwveLSXtNKrB9vkMXCbAN28H6n8VwEQXOlgso4iIFbWoiREFCl4+tSUtth1cg1r0sd7eC9QoccEtYtD9I9ofP+lQQrnmKyd8+5znohVy+GL8z/EndsLkGg8bJf2AqKYMVVrR5HCFgYkxCLvdNgOwJlzH51Fps4tl0Mz5PW128Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0OV04/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E79C4AF0C;
	Tue,  6 Aug 2024 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972817;
	bh=KisNNNCfQT3YqpWIenhbN16DNRy6W+U6stCIScrNpco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0OV04/5oNAFn8SxZNolocYJv/ZVglvvjAvvrZgNiUhim/wLQ5SwtNpgyIoa6OAXw
	 0i1nzEwNatb185OLQws7nHuaeh7iCethmPjDoLgSQWDxekYK5S9ImNnAW9RvtZaPiI
	 yrZv2wGDb/vfx4e4q+X2LhAsR5yrXBRI7wSdp8wf54MKR+izdcBoZSTv2ehr6ke/6t
	 Qik4UGEmFG8lNqWMpvg9Xfd33KBKexTf56c7MG2I9zxcAVX0CFwLhoPFJ6KkzN1e7r
	 VsDZXwW6nbPKk+H0mC+H9aT8K5x1y732KR1F+YRJxGSvfjGfX/v02LfGVACE+864iW
	 VAMyu5rnP4bgg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 01/12] selftests: drv-net: rss_ctx: add identifier to traffic comments
Date: Tue,  6 Aug 2024 12:33:06 -0700
Message-ID: <20240806193317.1491822-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806193317.1491822-1-kuba@kernel.org>
References: <20240806193317.1491822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include the "name" of the context in the comment for traffic
checks. Makes it easier to reason about which context failed
when we loop over 32 contexts (it may matter if we failed in
first vs last, for example).

Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 011508ca604b..1da6b214f4fe 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -90,10 +90,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     ksft_ge(directed, 20000, f"traffic on {name}: " + str(cnts))
     if params.get('noise'):
         ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
-                "traffic on other queues:" + str(cnts))
+                f"traffic on other queues ({name})':" + str(cnts))
     if params.get('empty'):
         ksft_eq(sum(cnts[i] for i in params['empty']), 0,
-                "traffic on inactive queues: " + str(cnts))
+                f"traffic on inactive queues ({name}): " + str(cnts))
 
 
 def test_rss_key_indir(cfg):
-- 
2.45.2


