Return-Path: <netdev+bounces-94619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA58C000D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533C21C23378
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2CA86644;
	Wed,  8 May 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="fiG++FY1"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C186254;
	Wed,  8 May 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178878; cv=none; b=ENvFJLlYQoBXDdvpT+y+rjZQ5rXtLH12hItyn67VocswYFCEuLSWSnrUvvTkvKyFO9dpMpugUznKB27Ea21SXHK/IHd85pNsln+sEKEV5RybxU3kMZ9WnRuS6S9sAOz6KcFi7YoxvDYYdsBmCEi1vIljN6RSpVasZOSPD63hVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178878; c=relaxed/simple;
	bh=SkoT0Uk0es2G81IY4lemOptjyc0r3NPOQ9SxNmgHgUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcYWx3Qgq9bu2cZUI3VBIj0uX83Fj8JDuYJeYpIXbowt0zpwwzSbh0g3oS2KsEwM/q+vgigslS1KjNPEQvRKLb4MOT6Zz8wHZ264xZW/6rUfZc8v5NFOQMpjxTaXcU/GhXYmwiB9etnmhLdxNQmtITAh9yWdWMOklGHm2a6qqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=fiG++FY1; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 961A7600DC;
	Wed,  8 May 2024 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178869;
	bh=SkoT0Uk0es2G81IY4lemOptjyc0r3NPOQ9SxNmgHgUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiG++FY1HFrnr8wnRZb5PucCL/uuXFhWSXsqPWx4rR+J9vrdCQZ2SCMdujUkHDZMY
	 1pw/58E+pCe0TsE3jik9EyMQWCSPj8P8Lk8SJpbT3XTSdN8LRpDW61UDSsBpNxfDF7
	 UGad2IJ5QnF/iWHqP9rNWav6RV4kec+x6R5BTOxNRRMKg0QKe65pII9OGhdMxj2FEi
	 fYW1NiPUd9D7n6Nk/ozjuGoVtXyRJvx12BImpidhwapQTuGd5l3G/CHqwDdn/mF6Wf
	 jORdob/eHPul0z5wdWa+3g2M7PyHIgkQlFmeDu4VMbTEXm8Yl3AUJgPr122vanYEoV
	 7WXcf8kiITIGQ==
Received: by x201s (Postfix, from userid 1000)
	id 480FC208F1D; Wed, 08 May 2024 14:34:07 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 12/14] net: qede: use faked extack in qede_flow_spec_to_rule()
Date: Wed,  8 May 2024 14:34:00 +0000
Message-ID: <20240508143404.95901-13-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508143404.95901-1-ast@fiberby.net>
References: <20240508143404.95901-1-ast@fiberby.net>
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
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 8c1c15b73125..b83432744a03 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1990,6 +1990,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 {
 	struct ethtool_rx_flow_spec_input input = {};
 	struct ethtool_rx_flow_rule *flow;
+	struct netlink_ext_ack extack;
 	__be16 proto;
 	int err;
 
@@ -2017,7 +2018,7 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	if (IS_ERR(flow))
 		return PTR_ERR(flow);
 
-	err = qede_parse_flow_attr(proto, flow->rule, t, NULL);
+	err = qede_parse_flow_attr(proto, flow->rule, t, &extack);
 	if (err)
 		goto err_out;
 
@@ -2025,6 +2026,8 @@ static int qede_flow_spec_to_rule(struct qede_dev *edev,
 	err = qede_flow_spec_validate(edev, &flow->rule->action, t,
 				      fs->location);
 err_out:
+	if (extack._msg)
+		DP_NOTICE(edev, "%s\n", extack._msg);
 	ethtool_rx_flow_rule_destroy(flow);
 	return err;
 
-- 
2.43.0


