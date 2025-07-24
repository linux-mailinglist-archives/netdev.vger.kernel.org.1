Return-Path: <netdev+bounces-209577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA0BB0FE75
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D432587408
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94941534EC;
	Thu, 24 Jul 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTQIJC0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39904A28
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321881; cv=none; b=QuLcdE7L1YSwEKoXupLJ26USAMHzklBHJIn8SroFNOQE4yVvSCx14CeJg0YcBE3S2v0EJsOaIQC07yXZmGWAgTuHYEQMqRvk57/7WCyYzARQv4x92oiVpDcbMtBL14koNy7QtoUdNRnajbAJYIw4IbJdm1onuqI4JJpaJWxEfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321881; c=relaxed/simple;
	bh=A1ANpJUXs8V0+Nvf4lKaDUQ4pugrKdc+C60/pduo/iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TU1yQIu+vs4R0jxkqe0e6Vu23bDu7Q6Lk92AiKyTrwZlLiHB1UEI6bBIqdPtmuEMYIp/iV/UN7aAsq233NQX5rAvXljyrSiL0pOuMGrVXjgJ/Aov/nezKYMutJrIJm6oBLlxvdUzFXWOpscemtN6IKV3UvclJYYUr0i9U9L1moY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTQIJC0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE649C4CEE7;
	Thu, 24 Jul 2025 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753321881;
	bh=A1ANpJUXs8V0+Nvf4lKaDUQ4pugrKdc+C60/pduo/iU=;
	h=From:To:Cc:Subject:Date:From;
	b=MTQIJC0EqVjvMigX6X0k628CkCz45g3BBzeKfzo35B+6RFtrNHYt+ROTkQJ/S1BVR
	 DQQ1tWdAgoXKnlXnpZFQPgz0q7DHqW1kG8L0nLQ8Syq1iur/iAbELcYzYS1SiXWD8S
	 5WHK2M8XEmoW6a0sVXkwo1JT/ujTfrQnzePeZQOl+AWvqy0oeZrU57Tt7p1vhojvex
	 thBWLT6D8hlxnuC364rht3V0Hney6T9UiGlDFUYgmIl279tVFSFVy4tZFdBaVm/G+j
	 U9sUyl8DRH4jDug3kTcsBfY2eTt7QVWP2u8ABFOO5yeg4bFMQke3YgoMqaEdsilo2L
	 pxBYdpD52KUlw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/4] net: ethtool: support including Flow Label in the flow hash for RSS
Date: Wed, 23 Jul 2025 18:50:57 -0700
Message-ID: <20250724015101.186608-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for using IPv6 Flow Label in Rx hash computation
and therefore RSS queue selection.

v3:
 - change the bnxt driver, bits are now exclusive
 - check for RPS/RFS in the test
v2:  https://lore.kernel.org/20250722014915.3365370-1-kuba@kernel.org
RFC: https://lore.kernel.org/20250609173442.1745856-1-kuba@kernel.org

Jakub Kicinski (4):
  net: ethtool: support including Flow Label in the flow hash for RSS
  eth: fbnic: support RSS on IPv6 Flow Label
  eth: bnxt: support RSS on IPv6 Flow Label
  selftests: drv-net: add test for RSS on flow label

 Documentation/netlink/specs/ethtool.yaml      |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 include/uapi/linux/ethtool.h                  |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  20 ++-
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +
 net/ethtool/ioctl.c                           |  25 +++
 net/ethtool/rss.c                             |  27 +--
 .../drivers/net/hw/rss_flow_label.py          | 167 ++++++++++++++++++
 11 files changed, 233 insertions(+), 18 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_flow_label.py

-- 
2.50.1


