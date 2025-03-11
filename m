Return-Path: <netdev+bounces-173808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F6A5BC45
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A77B1887F74
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8D22DFB0;
	Tue, 11 Mar 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPwjP8ac"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0582E22D7A5
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685308; cv=none; b=kyP1jghTqBEHSC7QaK2MgzPk1nL4+nMQZGINxqu6gm6jhqBkNq++13XF4Lb0NAFdlOt3+UX8f7mzbcf7JMMHYsng+zGt76sUcWONO8MAOI4KamWQbWbqWjQWbjWBgZAExY8pmYvK1loxXSdkipsL/U0F56X/PgVCoP/nuWZtAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685308; c=relaxed/simple;
	bh=RIkrKUlWy2PrJZ9KBDCozoglQTjUmUryVfRJcopyYsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzSuhxcnw6MI8CPq6RSuqN45EpbhNvO8qUSuWfasrXEwT7F/Uar6v9WtsLp10PQ59U8HHRHlHMiKZuLnNSCxUj/2+hJ22UbY87FZxBShFHKiv0wwQWxDYX9+Y0OliOwdQALU7/hxGtaBTSsgA71Bqn+xogbqtM8kyN5j/DGGojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPwjP8ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B79C4CEE9;
	Tue, 11 Mar 2025 09:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741685307;
	bh=RIkrKUlWy2PrJZ9KBDCozoglQTjUmUryVfRJcopyYsM=;
	h=From:To:Cc:Subject:Date:From;
	b=HPwjP8acPOeKdngydmJDQLo7xm//EgjxXCcMhiki1Kgqr4lAuoG21azV0/fV7bkTG
	 CvDWkX9hDU+lToWCCGs9jHyOF9E+LxrYv32etVhkNeAsza/ylnYfGbIk+p8Y+DTw6M
	 HBwwD1vp1cSHhTew0tkaE263szDmnuUHaTvcTfIWmd2dE9e7L8hZCWs0ryKbpqRVFT
	 MZf5wWZFOa069ryd9jc3Cbih0jg7uhKsAKbVJuMJGXpNqkcRfAroTNAylb7xO5vDWn
	 ON1ekFeIhz4ne6r4UnoSbGSa43uOhgKiNnLUlNjQ1TvX5sW5Uhd/4c2kuBonusy1Cn
	 nI5rksZgFkPsw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] netdevsim: 'support' multi-buf XDP
Date: Tue, 11 Mar 2025 10:28:20 +0100
Message-ID: <20250311092820.542148-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't error out on large MTU if XDP is multi-buf.
The ping test now tests ping with XDP and high MTU.
netdevsim doesn't actually run the prog (yet?) so
it doesn't matter if the prog was multi-buf..

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/bpf.c    | 3 ++-
 drivers/net/netdevsim/netdev.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index 608953d4f98d..49537d3c4120 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -296,7 +296,8 @@ static int nsim_setup_prog_checks(struct netdevsim *ns, struct netdev_bpf *bpf)
 		NSIM_EA(bpf->extack, "attempt to load offloaded prog to drv");
 		return -EINVAL;
 	}
-	if (ns->netdev->mtu > NSIM_XDP_MAX_MTU) {
+	if (bpf->prog && !bpf->prog->aux->xdp_has_frags &&
+	    ns->netdev->mtu > NSIM_XDP_MAX_MTU) {
 		NSIM_EA(bpf->extack, "MTU too large w/ XDP enabled");
 		return -EINVAL;
 	}
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index d71fd2907cc8..a5e5e064927d 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -116,7 +116,8 @@ static int nsim_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct netdevsim *ns = netdev_priv(dev);
 
-	if (ns->xdp.prog && new_mtu > NSIM_XDP_MAX_MTU)
+	if (ns->xdp.prog && !ns->xdp.prog->aux->xdp_has_frags &&
+	    new_mtu > NSIM_XDP_MAX_MTU)
 		return -EBUSY;
 
 	WRITE_ONCE(dev->mtu, new_mtu);
-- 
2.48.1


