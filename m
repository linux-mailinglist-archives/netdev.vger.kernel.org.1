Return-Path: <netdev+bounces-201670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C124AEA633
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA9560EC4
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3567423535C;
	Thu, 26 Jun 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfud359F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD69212B3B
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965359; cv=none; b=Nm7530hzE1qTD5TfOLExmXpTDOyLdZUNkIDPZllYPwTje+YVDBVcElztCvqum28SEjGDdmHAxOqHdM/Wr+8hJy8r9JLhUYr1cYXBtC90bmUrUab1WBUYD4Vz76V+CErqlhc49DZsBavB4Vfh5UDY/0fQmjeLu5+i4JUP24wG0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965359; c=relaxed/simple;
	bh=+50tg79GbyGyIkQXWa4tdHr3DrG+EFSqgyh0L0D6wIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNyQF2SivZ4xgHDE4uQ+IIeLQpStbQzvULMKK7kgtHqj4nk+ZTzQ7geN8AdwWdk3Hz33C//vbFgeVGkL6ZunPAEVo6DB1EX/dbuFj4mQYWsLidVPKqPyvoJawdFKsaE0jmgtV9lDZf2Ig3tnHjh0nUBdCUOL74qvD7bS57AXBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfud359F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B545C4CEEF;
	Thu, 26 Jun 2025 19:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750965358;
	bh=+50tg79GbyGyIkQXWa4tdHr3DrG+EFSqgyh0L0D6wIc=;
	h=From:To:Cc:Subject:Date:From;
	b=Kfud359FeKPpzZF5cWkkCc29MJq2RSeORmEckgydUUHwm0hSOwrPvps3fg00hvqVU
	 Bx7Ewn0yj8z7yLaTWvTNorz6NfsXJtoXNrTQjqTd6zVZbwoLNnFhGjDcOl/TZ9zP0Q
	 G5P+y924cldKCFaL9ODFuyuYb1LX4iY6QueIpYZNXWFZP+t5n7RW5CY1FhIJbyOYzl
	 7HmTCcNbfgA/sV9Ey33JhP1PveB2ltP/2imH+pTAMxw7hhZWYTeBN+zHsjq5g5hOVO
	 OnVPHc6qFD+kleprweD4L+Twx9cqvv4fF1pi4mlIal/NuoaXutq7S+vo3IXTO3B0Hy
	 arJ8fkCn9VDqA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] docs: fbnic: explain the ring config
Date: Thu, 26 Jun 2025 12:15:53 -0700
Message-ID: <20250626191554.32343-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic takes 4 parameters to configure the Rx queues. The semantics
are similar to other existing NICs but confusing to newcomers.
Document it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../device_drivers/ethernet/meta/fbnic.rst    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
index f8592dec8851..afb8353daefd 100644
--- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -28,6 +28,36 @@ devlink dev info provides version information for all three components. In
 addition to the version the hg commit hash of the build is included as a
 separate entry.
 
+Configuration
+-------------
+
+Ringparams (ethtool -g / -G)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+fbnic has two submission (host -> device) rings for every completion
+(device -> host) ring. The three ring objects together form a single
+"queue" as used by higher layer software (a Rx, or a Tx queue).
+
+For Rx the two submission rings are used to pass empty pages to the NIC.
+Ring 0 is the Header Page Queue (HPQ), NIC will use its pages to place
+L2-L4 headers (or full frames if frame is not header-data split).
+Ring 1 is the Payload Page Queue (PPQ) and used for packet payloads.
+The completion ring is used to receive packet notifications / metadata.
+ethtool ``rx`` ringparam maps to the size of the completion ring,
+``rx-mini`` to the HPQ, and ``rx-jumbo`` to the PPQ.
+
+For Tx both submission rings can be used to submit packets, the completion
+ring carries notifications for both. fbnic uses one of the submission
+rings for normal traffic from the stack and the second one for XDP frames.
+ethtool ``tx`` ringparam controls both the size of the submission rings
+and the completion ring.
+
+Every single entry on the HPQ and PPQ (``rx-mini``, ``rx-jumbo``)
+corresponds to 4kB of allocated memory, while entries on the remaining
+rings are in units of descriptors (8B). The ideal ratio of submission
+and completion ring sizes will depend on the workload, as for small packets
+multiple packets will fit into a single page.
+
 Upgrading Firmware
 ------------------
 
-- 
2.50.0


