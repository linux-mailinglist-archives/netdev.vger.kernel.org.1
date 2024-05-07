Return-Path: <netdev+bounces-94044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632B8BE013
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978AF1C23454
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540015DBC3;
	Tue,  7 May 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="CYz80e0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E41154450;
	Tue,  7 May 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078691; cv=none; b=PHurapU6Gqvz0warILPkP1G13Z5oNuXaEpN1uEM9DhE75nAV7MnV7Wxu+aNe8BK/llAF1VNGrkbBB5zh0NGAfIx4nptKhiG6WlyK2PwaFJJK+Y6gLaklob7vcFMF5QrqjSp8qzDc8e5AII5v57WUTgzE/T1xcb0sLwGWeg69jdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078691; c=relaxed/simple;
	bh=BXkqTGf4ljiO8BNjQTNrgJXmlT/C/AanHIXAnkbe1W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3AcZ7wX6mE4YieKvThv77iXyE393aIjTQdN3WXohHMyoZl6og1vVz6JWnrU1SOUd5RA2xkBKgm5bTpkbOFgw3xdgwXbUnzph54c6GR+FjJsQ+DyKuFDer5nF1TwLXeDchTl0DWypGZRMtu4c/o1JuYyDTRxbotn/yCSSoR+nCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=CYz80e0s; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5B51B6016A;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=BXkqTGf4ljiO8BNjQTNrgJXmlT/C/AanHIXAnkbe1W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYz80e0sPA5wEw5rSIQ7nlHRJyjF8l9bjP7kzn8ComkDvhgPbyNxJ3Nc0JvTJL40a
	 XTKsttYh8NjiKa68lZ5+bcTDa5VLtpwkCJcn7+3/dUkfKeb6FCxx0xEuuMXj2MUP8Y
	 q67RMDRdChhGKufsUkHWEs5dYmNVd8Sjv5B79oALukd9jyDrZtif9vPamoq+kIq7/a
	 ii5LsFILTX9z5+pnXYjFnhFGw3X8Ub/TYuZPPXNFRF2F4YgukfTSt2Wh/Eyd0FLQ+q
	 lfWBJ9f5Z2SohloS4a0zCpCDFj8rlRJVsMRAslmit2krLqiV/CzZmkuvrtsNDsJapK
	 GUszAd9QAKuow==
Received: by x201s (Postfix, from userid 1000)
	id E9930203F6E; Tue, 07 May 2024 10:44:24 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 13/14] net: qede: propagate extack through qede_flow_spec_validate()
Date: Tue,  7 May 2024 10:44:14 +0000
Message-ID: <20240507104421.1628139-14-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507104421.1628139-1-ast@fiberby.net>
References: <20240507104421.1628139-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Pass extack to qede_flow_spec_validate() when called in
qede_flow_spec_to_rule().

Pass extack to qede_parse_actions().

Not converting qede_flow_spec_validate() to use extack for
errors, as it's only called from qede_flow_spec_to_rule(),
where extack is faked into a DP_NOTICE anyway, so opting to
keep DP_VERBOSE/DP_NOTICE usage.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 3727ab5af088..7789a8b5b065 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1952,6 +1952,7 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 static int qede_flow_spec_validate(struct qede_dev *edev,
 				   struct flow_action *flow_action,
 				   struct qede_arfs_tuple *t,
+				   struct netlink_ext_ack *extack,
 				   __u32 location)
 {
 	int err;
@@ -1976,7 +1977,7 @@ static int qede_flow_spec_validate(struct qede_dev *edev,
 		return -EINVAL;
 	}
 
-	err = qede_parse_actions(edev, flow_action, NULL);
+	err = qede_parse_actions(edev, flow_action, extack);
 	if (err)
 		return err;
 
@@ -2023,7 +2024,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 
 	/* Make sure location is valid and filter isn't already set */
 	err = qede_flow_spec_validate(edev, &flow->rule->action, t,
-				      fs->location);
+				      &extack, fs->location);
 err_out:
 	if (extack._msg)
 		DP_NOTICE(edev, "%s\n", extack._msg);
-- 
2.43.0


