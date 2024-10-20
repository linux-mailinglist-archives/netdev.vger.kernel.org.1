Return-Path: <netdev+bounces-137266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B047F9A5388
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 12:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379AD1F22604
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 10:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FBD12C470;
	Sun, 20 Oct 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Phd4w9Dn"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A029145003
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729421335; cv=none; b=OzoI7U/tkFpSOe1AxF5GTOFxJZK2NmK0bOiQwsJfZtaFkuS4gD82omJvLqXhXhiniuTR7+2fbtIrWVrVHMEcahsiK4E8Qw4qsz22Vpwspv+mLJZriqGF6tEMvj5fmkPEe+FcebWZPeRlgJfodbieY2Guz5rOSnaXxLhRUciaGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729421335; c=relaxed/simple;
	bh=SDKtvxc6BdDUdcS/xBbukopdK/nzFQdN0uyG01misAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnPwHOsZvzqmvj6senbGUH6HQzxEBdzzXpX7xmLOQquMCrKHwOvIQlDLcMsELrjsDDCN/JH5Ecq5q9bOko2OjiRkTXV4hqScKj8o8gWsWOjipfgZwNo4Sy1vZbomzq1kpm5NIZHWGF+ZBMMnAoDSjM5MiaFOqBAmPLiAqPGb8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Phd4w9Dn; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729421330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q2dkOgqWwR9XgMPnHIscHjM3nX4m78fOsiQRAow4grE=;
	b=Phd4w9DniHxnwASXS7nn8tbTMKmZkOzAcY55nGas4aTbwgJfiK9e6f75rJ6q9iYZjvkECZ
	BeY3qwc4C/rWzPXah6PrsBCShSBTZUw3bLyxArqob5tg5D7cDX0ZvFzPPVKNFipDU6OexW
	u12rwyZ9RgCsupWgP7y8n0zIKe6nkRA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: sched: etf: Use str_on_off() helper function in etf_init()
Date: Sun, 20 Oct 2024 12:47:59 +0200
Message-ID: <20241020104758.49964-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the helper function str_on_off().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/sched/sch_etf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index c74d778c32a1..c62730f5df4c 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -369,8 +369,8 @@ static int etf_init(struct Qdisc *sch, struct nlattr *opt,
 
 	pr_debug("delta %d clockid %d offload %s deadline %s\n",
 		 qopt->delta, qopt->clockid,
-		 OFFLOAD_IS_ON(qopt) ? "on" : "off",
-		 DEADLINE_MODE_IS_ON(qopt) ? "on" : "off");
+		 str_on_off(OFFLOAD_IS_ON(qopt)),
+		 str_on_off(DEADLINE_MODE_IS_ON(qopt)));
 
 	err = validate_input_params(qopt, extack);
 	if (err < 0)
-- 
2.47.0


