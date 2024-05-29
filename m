Return-Path: <netdev+bounces-99124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B538D3C6C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B6B1F21C19
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EEB18412C;
	Wed, 29 May 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZOtG9jb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BA18412B
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000167; cv=none; b=DN0ywRzX/XyDApuzSRdvH3S/YRdMy4+eYkwAFQ45/NlLzUC662lUucLUptBtYadoldGdZwkZyRS9+UUVAZLxlGB4tUygW9ooBGT2GU7MKWp+MEYJnbej67SOk1cX5BMMPU3rC0ZWh7fRDcVI5CYaA7eQGHIPVMEBFDhkIZ7g+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000167; c=relaxed/simple;
	bh=Ye8FQX2KCdU4R4YgdHL8D2G6Vtx2sITZFYEtidACnls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAnKIA/hCKgZzCa6L7muE/zvNOtLns01XBaKL4eRWhABGTtTxExB8KB492sk1QUMMBv8ZeVxtOW/o/ki6vutKE9CHmtc5/loTMExfPFTgL5koWRmx8UY1B4UJ1qnoImms6vK4Ve+82Rmnu/N7YBWOriopOe/GOqiW7qYflIxUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZOtG9jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE6DC4AF0C;
	Wed, 29 May 2024 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717000167;
	bh=Ye8FQX2KCdU4R4YgdHL8D2G6Vtx2sITZFYEtidACnls=;
	h=From:To:Cc:Subject:Date:From;
	b=dZOtG9jbC9Gh51PRdUNmCyiCcPaq/gK0QBzhJmtyQR+/Vawm29d6IThMOiSU9K6dj
	 LMuz59lfLpb+8mpCZutSzTxniAc0RB5ExVABsXWnLIokxSuFKwkoFsxVHTdEtbfOn6
	 EnwCMMnSpJW3M5yaTfJcR/Qy48bX0atkSMjVt6nuisLN2yyhLTGejSSw2hkN+pUGDE
	 NRCr6ZlMJLD6OFjZhiIL8uNOxp7/l6T5ypEQPapXv3InVeSe1cgdunCsp4+KCcwxgJ
	 /SYuSJoVFTaIoSYEJg0X5UkE+9YdSWON0f9TJWtX3F34JaPe2P78wZqPY1Gm8iRerl
	 vq8jqgoD1KzDg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com
Subject: [PATCH net-next] net: qstat: extend kdoc about get_base_stats
Date: Wed, 29 May 2024 09:29:22 -0700
Message-ID: <20240529162922.3690698-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5 has a dedicated queue for PTP packets. Clarify that
this sort of queues can also be accounted towards the base.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: jdamato@fastly.com
---
 include/net/netdev_queues.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index a8a7e48dfa6c..5ca019d294ca 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -62,6 +62,8 @@ struct netdev_queue_stats_tx {
  * statistics will not generally add up to the total number of events for
  * the device. The @get_base_stats callback allows filling in the delta
  * between events for currently live queues and overall device history.
+ * @get_base_stats can also be used to report any miscellaneous packets
+ * transferred outside of the main set of queues used by the networking stack.
  * When the statistics for the entire device are queried, first @get_base_stats
  * is issued to collect the delta, and then a series of per-queue callbacks.
  * Only statistics which are set in @get_base_stats will be reported
-- 
2.45.1


