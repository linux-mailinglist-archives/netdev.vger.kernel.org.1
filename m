Return-Path: <netdev+bounces-134932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A6F99B96E
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 14:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE731F21748
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 12:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C913B592;
	Sun, 13 Oct 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="baiiGgVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622336B;
	Sun, 13 Oct 2024 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728823619; cv=none; b=sDPocrN+8Q4bxk/AJ2kzX6+Y6Y/0+G8GMxBqeSDLl9IYBQpCBOaz18gZ9/udo+wzTcjz9FNaHp6UypLRmGpWap9SQwYO1ZMXDsZ7uMqvdYbS7331NaALsOjdQU7oKtSx3A99VVmIapjtyhfJJ39CUaw7OCBWRMCIRjz2m4zCocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728823619; c=relaxed/simple;
	bh=F7g/vq7HceSS0Kuvc/HfkkfnvYzJC17Isl5FKGg5DY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MpuWT4ml6vNNn7vH9ZmpHrmPT6qsNvnD+FpQnWkpqJWtPEMelmnykeAuFlSScfWxHQvJujRADaJf5rRe8K5WrTeEz/uFkpeVj+N4AXrl0pNt0RJnd0HEnaNDg3BMe8BzfJw+lkZIMyHnM1lH/Ai6a8jnogsuhhxNncwZoGIh0lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=baiiGgVk; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [109.252.171.178])
	by mail.ispras.ru (Postfix) with ESMTPSA id 12CB14078507;
	Sun, 13 Oct 2024 12:46:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 12CB14078507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1728823608;
	bh=RbI4xvpLlIIRDNbMXmNSQos0V7si5yEzs9WRtwQbybI=;
	h=From:To:Cc:Subject:Date:From;
	b=baiiGgVkTMctq/PRPAZNIreKz7/eHFHE6DunvachhEXMN2tLwgHi5e1oKT31vZtRP
	 Rvc/79wmGlOSPThP1UgcbhwXj2Yk2IpVBgQgeZ/+hQH1hyYvUOuRMhVwxZn9TPsP60
	 JikPJxGtJBA4RncQ068iWy+eo+3APow6YqPC6uvM=
From: Elena Salomatkina <esalomatkina@ispras.ru>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Elena Salomatkina <esalomatkina@ispras.ru>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Leandro Dorileo <leandro.maciel.dorileo@intel.com>,
	Vedang Patel <vedang.patel@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
Date: Sun, 13 Oct 2024 15:45:29 +0300
Message-Id: <20241013124529.1043-1-esalomatkina@ispras.ru>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subsequent calculation of port_rate = speed * 1000 * BYTES_PER_KBIT,
where the BYTES_PER_KBIT is of type LL, may cause an overflow.
At least when speed = SPEED_20000, the expression to the left of port_rate
will be greater than INT_MAX.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e0a7683d30e9 ("net/sched: cbs: fix port_rate miscalculation")
Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
---
 net/sched/sch_cbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 2eaac2ff380f..db92ae819fd2 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -309,7 +309,7 @@ static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 {
 	struct ethtool_link_ksettings ecmd;
 	int speed = SPEED_10;
-	int port_rate;
+	s64 port_rate;
 	int err;
 
 	err = __ethtool_get_link_ksettings(dev, &ecmd);
-- 
2.33.0


