Return-Path: <netdev+bounces-241142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B629CC802D1
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608523A218A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368752FE053;
	Mon, 24 Nov 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtBnu/Q6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61132FE04F;
	Mon, 24 Nov 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983193; cv=none; b=FelZU/pDtUVAmQoz5v8FZ8DydGdcEmHepN+0wz6cHZWROEMHWA+MABA0MNdJ7CenXbbfOKwUCRZmk+x76Yn+2xQR19Lv4NaJgyIvwcx5bD+qSii3wZaOf7WNotFNco05wuZm3ER/eHWyj0QgwMQTaF5sUGMro8k0YBYgIMwtaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983193; c=relaxed/simple;
	bh=Ijk5pe9mMQ9Z2WSXWd9d09O4dX0EBa2qbR1Hznf3iSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLKqYVzO4JPOWBsG0H1Sw+IIyH11Z1dYCed6ZNB/tf8NOaXq1gY1jyA6A3D7IQYb4+HG7FEeG8nI8NbVdxKmRByXycomu4jt6VC7JmEBtc7niFpjweefCnhUdyvj/Z7RUWw2Nenn4CG/RQDXOgyiRiEE30vpLMvSt32hAlOzJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtBnu/Q6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69FAC116D0;
	Mon, 24 Nov 2025 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763983192;
	bh=Ijk5pe9mMQ9Z2WSXWd9d09O4dX0EBa2qbR1Hznf3iSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OtBnu/Q6vcsuIzm0Rm60kGn1nRkIHAsRKnDft/Efaz+3ICQNiiLCNQh4Scab4x46l
	 CeJl7bolEdZfN6FpvhimjulAHeQQMg/uRb53L2WJydKcTF4RY42ca4fhhHiRVEVkeL
	 /3YmoVeUgrOBSFVDv3oCXSwkmyjxmsLhdEi+P6zIsmgR78mhrxX0mf7sI42PRhvG0D
	 YVT/D0e8okjrX5u3CT8U1xAJ0faB7Ce6X/57Proiz0/Oz0UGF/QhmU2my49hw8u+4c
	 k3IcmJdZFOpvk2UGQO9M0nrCTAu/uWMUBYG1sw4DQsvfNKtehSbbSltEFe8X1BECMh
	 fFmcOfA/TR6fQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Nov 2025 12:19:26 +0100
Subject: [PATCH iproute2-net 6/6] mptcp: monitor: support 'server side' as
 a flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-iproute-mptcp-laminar-v1-6-e56437483fdf@kernel.org>
References: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
In-Reply-To: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ijk5pe9mMQ9Z2WSXWd9d09O4dX0EBa2qbR1Hznf3iSQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJV7H36Je9qZDpZa8k4hgYfWDXvTeP/yuq2oqROSbWbd
 zM/KpZ3lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATMT9DMM/BQ1G/V7ZKI+9O5Ou
 yC35sPin6PGlVrO/bDP1ncW/UdWEheF/cX2ojoxI/oElQmzT+3QEue839Tazqe5+omL98GMDpy8
 nAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In the v6.18 kernel, the 'server side' attribute has been deprecated [1]
in favour of the 'server side' flag [2].

Support both: first checking the new flag, then the old attribute to
continue supporting older kernels.

Link: https://git.kernel.org/torvalds/c/c8bc168f5f3d [1]
Link: https://git.kernel.org/torvalds/c/3d7ae91107b8 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 01f6906f..acd008f3 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -535,11 +535,14 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
 	if (tb[MPTCP_ATTR_RESET_FLAGS])
 		printf(" reset_flags=0x%x", rta_getattr_u32(tb[MPTCP_ATTR_RESET_FLAGS]));
-	if (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))
-		printf(" server_side");
 
 	if (tb[MPTCP_ATTR_FLAGS])
 		flags = rta_getattr_u16(tb[MPTCP_ATTR_FLAGS]);
+	if ((flags & MPTCP_PM_EV_FLAG_SERVER_SIDE) ||
+	    (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))) {
+		flags &= ~MPTCP_PM_EV_FLAG_SERVER_SIDE;
+		printf(" server_side");
+	}
 	if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0) {
 		flags &= ~MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;
 		printf(" deny_join_id0");

-- 
2.51.0


