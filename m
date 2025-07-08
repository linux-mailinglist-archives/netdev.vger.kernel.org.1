Return-Path: <netdev+bounces-205062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2178EAFD01B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3652168D5E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A881D2E0B58;
	Tue,  8 Jul 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyWhgxPm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069C1E412A;
	Tue,  8 Jul 2025 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990818; cv=none; b=ooBkndAFIdMXrBsrqem2sGcz8qnrLdMQCGyUQdFsVwAgTG9ShxbPznTjVmQX7Uzwm7FMsrwmDZR2kqY/Co7UrGgMqGNmBXKOurzbBnOJ5s4n75aDXQNQIVqRuSGqDAm00iwYFvwwbDsZITnkBofoNSgd17tfInDn+uz1uWNt6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990818; c=relaxed/simple;
	bh=u/XqwXMvGwGUcQMh5nLy52xMhImOmTCmv1c95gYdotM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dsuh7PF3zY6OnpPgJKXkj73PfeNmlnd6kBeP/X7zYw7s+KiLDgE71Ua+IwlANqpSrBOuNdB4j+S6+mS7o+S0UdwUUIxEvbe6X1ZkbFzz2LrdVvgNA/2ejm9GpA0+IzhAvXZYqq6zalI/LdjlOqlprpuRRHkq2/BDcRfHFsoF+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyWhgxPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFAFC4CEED;
	Tue,  8 Jul 2025 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990818;
	bh=u/XqwXMvGwGUcQMh5nLy52xMhImOmTCmv1c95gYdotM=;
	h=From:To:Cc:Subject:Date:From;
	b=AyWhgxPm4VUthsW8kH0LLjf4nC7Z3OyguNy6KeGSZfahJSZhDpml7QFLHsDtvzjAw
	 UmjpQxTvuBMz8LihCgODJIryzaeG8lF1t+aDfz0Zi75I5+LPhHleZIrwbVPFpxz0mt
	 QGeGOlZIsNo6LwErHOx/DORkFI1/vJyIWKf+8491SantSMN9MZxN2LEmp+Eq+Wy1/7
	 hklB/ZXDnB3oxuScQyCf4Hvro0d8nEpm/SpbmC1XiiZHhMeAlGY6jtTsPz0gZGXeUN
	 B8s8Bw1WkEP2jkzNIlAGC+MBWWxthPqesZj9jAzPel6zHy5YQy56HRTVq7H/ln/XD4
	 kvLmI1z8bOA4A==
From: Arnd Bergmann <arnd@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] devlink: move DEVLINK_ATTR_MAX-sized array off stack
Date: Tue,  8 Jul 2025 18:06:43 +0200
Message-Id: <20250708160652.1810573-1-arnd@kernel.org>
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
---
 net/devlink/rate.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index d39300a9b3d4..e4083649748f 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -346,19 +346,23 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
 				       unsigned long *bitmap,
 				       struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[DEVLINK_ATTR_MAX + 1];
+	struct nlattr **tb;
 	u8 tc_index;
 	int err;
 
+	tb = kcalloc(DEVLINK_ATTR_MAX + 1, sizeof(struct nlattr *), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
 	err = nla_parse_nested(tb, DEVLINK_ATTR_MAX, parent_nest,
 			       devlink_dl_rate_tc_bws_nl_policy, extack);
 	if (err)
-		return err;
+		goto out;
 
+	err = -EINVAL;
 	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {
 		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
 				     DEVLINK_ATTR_RATE_TC_INDEX);
-		return -EINVAL;
+		goto out;
 	}
 
 	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
@@ -366,19 +370,21 @@ static int devlink_nl_rate_tc_bw_parse(struct nlattr *parent_nest, u32 *tc_bw,
 	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
 		NL_SET_ERR_ATTR_MISS(extack, parent_nest,
 				     DEVLINK_ATTR_RATE_TC_BW);
-		return -EINVAL;
+		goto out;
 	}
 
 	if (test_and_set_bit(tc_index, bitmap)) {
 		NL_SET_ERR_MSG_FMT(extack,
 				   "Duplicate traffic class index specified (%u)",
 				   tc_index);
-		return -EINVAL;
+		goto out;
 	}
 
 	tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_BW]);
 
-	return 0;
+out:
+	kfree(tb);
+	return err;
 }
 
 static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
-- 
2.39.5


