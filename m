Return-Path: <netdev+bounces-205459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED4AFED01
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D665C0D25
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF52E6D26;
	Wed,  9 Jul 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM5Kv/pE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB12E610F;
	Wed,  9 Jul 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073153; cv=none; b=gG9TIm/IcDcHv166j2ungoT878u7MCVGeBWoN9PWOm3eGzmX+rX/cvhysOp1GtsP2k1Y2oBo5TyScSooTp1qa2DSwCpFvP2Vvyw3vNLwLnAyaIMRYGlAPlh+Xfzz1o3wM7EmhXOfPlECgwu6UFAIq8vtmP1qX+xPGSoYe5dK9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073153; c=relaxed/simple;
	bh=1CeZul5hY2ntHtGKA2dLPFSaFc71yvfAyz7ig1jnzU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l98Y/xkNmA5w46rOuN+8p+HtvHFIRxMJ2QNvAuD7DXxz+WpVMBYi8zMHpn7pfOijO/P3SLIjgOwSc9DhhR1gxnp2eVl+l1vZd7crLnNaGDTLyw1Y0zHk5P6TaeIuqKYTRoBAty6BBgbGrwc23AxKkETY33qglWE98fzkzjIgyu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM5Kv/pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A8EC4CEEF;
	Wed,  9 Jul 2025 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752073153;
	bh=1CeZul5hY2ntHtGKA2dLPFSaFc71yvfAyz7ig1jnzU4=;
	h=From:To:Cc:Subject:Date:From;
	b=mM5Kv/pE+vbUINtkrIlWm0bImRp4MudOR+/qekSMwYSInWQxQLvAnKPE1IQb3KweJ
	 V1OtlX5BVW+7qr2nRpKAk+bgraaqplJ3qZSl1vSAoEDIq/Cfom/2xkcrhatUk+0AS3
	 jit5PhCBOjlgu/AB7t8cS3ghBNPyJqGLsO6S+I+d0hZAgCreZahIXTpLaGWuZeSmbA
	 BSrt75TaSi2w+bX2qIL9bL/N6d1tzh2opNLSCLjPIAWe5t3yuOLC5/hF0H4y23bk+h
	 PygM4xNHCLuhdlcAavHtTovOZP+mgqGs/Zuz1mobGu1o/q4yxewHWvnVNpiDvUweV2
	 XiEvpiz+NBN+A==
From: Arnd Bergmann <arnd@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] devlink: move DEVLINK_ATTR_MAX-sized array off stack
Date: Wed,  9 Jul 2025 16:59:00 +0200
Message-Id: <20250709145908.259213-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There are many possible devlink attributes, so having an array of them
on the stack can cause a warning for excessive stack usage:

net/devlink/rate.c: In function 'devlink_nl_rate_tc_bw_parse':
net/devlink/rate.c:382:1: error: the frame size of 1648 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Change this to dynamic allocation instead.

Fixes: 566e8f108fc7 ("devlink: Extend devlink rate API with traffic classes bandwidth management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I see that only two of the many array entries are actually used in this
function: DEVLINK_ATTR_RATE_TC_INDEX and DEVLINK_ATTR_RATE_TC_BW. If there
is an interface to extract just a single entry, using that would be
a little easier than the kcalloc().

v2: use __free() helper to simplify cleanup
---
 net/devlink/rate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index d39300a9b3d4..3c4689c6cefb 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -346,10 +346,14 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
 				       unsigned long *bitmap,
 				       struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
+	struct nlattr **tb __free(kfree) = NULL;
 	u8 tc_index;
 	int err;
 
+	tb = kcalloc(DEVLINK_ATTR_MAX + 1, sizeof(struct nlattr *), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
 	err = nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest,
 			       devlink_dl_rate_tc_bws_nl_policy, extack);
 	if (err)
-- 
2.39.5


