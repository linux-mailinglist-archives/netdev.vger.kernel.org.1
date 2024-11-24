Return-Path: <netdev+bounces-147047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295DB9D7486
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 16:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B790A16785B
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE6241FFA;
	Sun, 24 Nov 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwg4azeM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE9241FF6;
	Sun, 24 Nov 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456468; cv=none; b=uRBOvam/GPiZsuU21kg5m/NwLI97CmKbKN4izsuvNgJ7UkwdBJE+kkERSrE4BtMgvkimN9RMxcHEIQ1+NWoTuhWkoTJmkiS0RBegHfVPNlau5IU1Digix1/ti+5UgwoIsx7IBR3ny6bW8wl+B3GPysA4z4bzkUUmGaWOUqAe2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456468; c=relaxed/simple;
	bh=n55YT7Wi8CHxVO7jPVw9PQUWQPpm+0t64NX0EBIj1zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+dVKGLpFUGxjousjqAVQ+X9mCDKyPEJekVxJkcCSSmWKZV20kR1+CNxvXgD+4vVtyL2S8wwQ2cbfDO8ruCOCVCRfxaCoeK9PHjTTR1Zygurlvb3FhylsW/Ep9xxdV140rEaGJY5sdesBphmaTSl9fjlm73E33RFRvSmg3kM0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwg4azeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B17C4CECC;
	Sun, 24 Nov 2024 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456468;
	bh=n55YT7Wi8CHxVO7jPVw9PQUWQPpm+0t64NX0EBIj1zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwg4azeMepuNXabpwn7J1xHFzWOgwpwvgf2TNlKurfF4U4kYZoOHB9tY8CmR+AV9r
	 jw6mgyS6/0vrKcznpGWSQTStnBZ3Sn5NxJk3egOYAaEERIqdkbHdsLro+8+cF+c0Pg
	 7Y6o6X8+09VO0NobcNcT0Mp6cZ6yXuxAVFkOfYmG8clqP9vjCWx/XLgu9U5Brs1MRL
	 u9THmhrKsrTewXFRaJLF7zqbq+Eye4XdIx74FN3JphGCBKbSHaRYTYr1qO4MWUwUnW
	 cqNiwh3eeSn0nH1IAsHpZiypZP/2A+7xO9NNBAj9bI0nJrYsJZWToCwkU+lTcuMje4
	 h/gBV+ojho9vA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Elena Salomatkina <esalomatkina@ispras.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/33] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
Date: Sun, 24 Nov 2024 08:53:21 -0500
Message-ID: <20241124135410.3349976-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Elena Salomatkina <esalomatkina@ispras.ru>

[ Upstream commit 397006ba5d918f9b74e734867e8fddbc36dc2282 ]

The subsequent calculation of port_rate = speed * 1000 * BYTES_PER_KBIT,
where the BYTES_PER_KBIT is of type LL, may cause an overflow.
At least when speed = SPEED_20000, the expression to the left of port_rate
will be greater than INT_MAX.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
Link: https://patch.msgid.link/20241013124529.1043-1-esalomatkina@ispras.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 2eaac2ff380fa..db92ae819fd28 100644
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
2.43.0


