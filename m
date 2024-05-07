Return-Path: <netdev+bounces-94043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD618BE011
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECA928BB3D
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ECC15DBC1;
	Tue,  7 May 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="U32LXCVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F1152E18;
	Tue,  7 May 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078691; cv=none; b=qzb/bO2QJBCSK6W/xS42BetoKpPFH8kutJikHlzdHYBjLYQhwx7yTc+m7Q9x8FtwlEBU9Ovx8CoWZO5VmZ//xMhlh7cgIOXT+rp00VNq78cHZwvFMoTadainVzkxqqAeSMOGuL0tpzf+lirxlhQX20NaVNtdIW8eep4D+07m+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078691; c=relaxed/simple;
	bh=GSOXcR4bbFPjJZ3frmuY6IjJLkcw6hvn1PqSul/wOIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXzx3FEMLP91JffP6zlnuVhY7BRYdLEvOcxZ6YN9AXwZKDwJcGLMy0OIgJ1+tZoJ7DGTauwimCbdHruIEeSzP+9y0fR+S/rqn4f09FcrhemGjsjC+O4LNSQMVyW4uQt22uJZbZUNkzlQ2+uQP+jhYKSNz4Sf5QOBLkcsnR5H0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=U32LXCVC; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 33909600B7;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=GSOXcR4bbFPjJZ3frmuY6IjJLkcw6hvn1PqSul/wOIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U32LXCVCnDhD6Lcvjt/wky2/xmMGL8Wzq9LX6Lnn/BR8c+J87p6cAhRKO/IrxzUk3
	 VGD8HcJ6q43QvVuVTikOUMaf6+8tBbQz5jcNtURUQ7wQajtfAn+9DfvB9gLpRMcxQQ
	 hWwBjslbk8VUh3J0IUK1uIDhbpw8bqtKBkDM/iP46Z9j4VDuXP6xYrWHiiHLdpMPrX
	 hb2MAYzBGatTLFnLuPuy4bxy2qajLAdhJVqJRQoOpO6KnVDlnoaNXj88E6Vs/YdmDs
	 E0yrqw9QfYLC0+D49D2FWA0Hf57SRA+dmHeyVGLTi2A+dp/+uF8ukgffdJEsYAvR4h
	 yR9+bO6hSGV6Q==
Received: by x201s (Postfix, from userid 1000)
	id BA7B0203D5D; Tue, 07 May 2024 10:44:24 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 12/14] net: qede: use faked extack in qede_flow_spec_to_rule()
Date: Tue,  7 May 2024 10:44:13 +0000
Message-ID: <20240507104421.1628139-13-ast@fiberby.net>
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

Since qede_parse_flow_attr() now does error reporting
through extack, then give it a fake extack and extract the
error message afterwards if one was set.

The extracted error message is then passed on through
DP_NOTICE(), including messages that was earlier issued
with DP_INFO().

This fake extack approach is already used by
mlxsw_env_linecard_modules_power_mode_apply() in
drivers/net/ethernet/mellanox/mlxsw/core_env.c

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

Note:
Even through _msg is marked in include/linux/netlink.h as
"don't access directly, use NL_SET_ERR_MSG", then the comment
above NL_SET_ERR_MSG, seams to indicate that it should be fine
to access it directly if for reading, as is done other places.
I could also add a NL_GET_ERR_MSG but I would rather not do that
in this series.

 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 8734c864f324..3727ab5af088 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1989,6 +1989,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 {
 	struct ethtool_rx_flow_spec_input input = {};
 	struct ethtool_rx_flow_rule *flow;
+	struct netlink_ext_ack extack;
 	__be16 proto;
 	int err;
 
@@ -2016,7 +2017,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
 
-	err = qede_parse_flow_attr(NULL, proto, flow->rule, t);
+	err = qede_parse_flow_attr(&extack, proto, flow->rule, t);
 	if (err)
 		goto err_out;
 
@@ -2024,6 +2025,8 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	err = qede_flow_spec_validate(edev, &flow->rule->action, t,
 				      fs->location);
 err_out:
+	if (extack._msg)
+		DP_NOTICE(edev, "%s\n", extack._msg);
 	ethtool_rx_flow_rule_destroy(flow);
 	return err;
 
-- 
2.43.0


