Return-Path: <netdev+bounces-210599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B66CB14050
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779FC17DDDA
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D7215773;
	Mon, 28 Jul 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juDGpBYz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498ABE4E
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720298; cv=none; b=NMsBMcnqV0el0qE5qasX8OP3RmKcdNrtIoCI6wOLeEGSD46IGRy5UGZuRwBpAEW761juNauav1T4C1CfD24mCh3+hG4RjVosSjASZtX57DTxgBYRGXyhIwVnrKmUrTyYjH36gWBYjnt1YyshAaXSEJWRuMb3Ih77BiF1FgIyIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720298; c=relaxed/simple;
	bh=MeDNw7QJECtn20GI5kPS9me3PP6JPHNofJx5rD00NYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqNveU8kufPu68szPVqlLdf2kCWUqJCg4dFaZ1zMtIq4bURw8UoMNM2xEiHlO6VHkN7wSbx7g2RRVbYBuRV0/NxHwHlUdO1Etoj4/ANIH5mXav3FEJmAjRaDQCOOwHbOJ9RnXFTtF7oxx9W7dvaMFln2S5szqgfeUu7K08LcLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juDGpBYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B819EC4CEF7;
	Mon, 28 Jul 2025 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753720297;
	bh=MeDNw7QJECtn20GI5kPS9me3PP6JPHNofJx5rD00NYk=;
	h=From:To:Cc:Subject:Date:From;
	b=juDGpBYzGPJxvIMlKNiWFGBysoF4YRpBdGusSmOwy5t94e7w8WC9F4GAUG/UmxY+f
	 ZOEkpQ8GMfgaBzUUynTIVKbClMHnQzDwY2vDJM+UosV2m3bj3kDIfNxum7uM3T7H5D
	 NgZWnbPvUmZZLN13KZ1z24cQu7FcZ6lzCaF88SDIdpg725j2TfamislJ7ypWHffJc8
	 cbe/vGpuWehkcakntAgPO1TXDSDBMi8cLggZ8pYAUB57n1w6r/e0bPfZxRCofsDOwq
	 28RFWAthy3YnYuonxQ3kyZA5XdFYymvDwjPg8qp4ynQRcn1bhGZpqHnFZJ4+MlDcnp
	 X/3zccwboFPUw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net] eth: fbnic: unlink NAPIs from queues on error to open
Date: Mon, 28 Jul 2025 09:31:29 -0700
Message-ID: <20250728163129.117360-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CI hit a UaF in fbnic in the AF_XDP portion of the queues.py test.
The UaF is in the __sk_mark_napi_id_once() call in xsk_bind(),
NAPI has been freed. Looks like the device failed to open earlier,
and we lack clearing the NAPI pointer from the queue.

Fixes: 557d02238e05 ("eth: fbnic: centralize the queue count and NAPI<>queue setting")
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: mohsin.bashr@gmail.com
CC: vadim.fedorenko@linux.dev
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 7bd7812d9c06..04bb6e7147a2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -33,7 +33,7 @@ int __fbnic_open(struct fbnic_net *fbn)
 		dev_warn(fbd->dev,
 			 "Error %d sending host ownership message to the firmware\n",
 			 err);
-		goto free_resources;
+		goto err_reset_queues;
 	}
 
 	err = fbnic_time_start(fbn);
@@ -57,6 +57,8 @@ int __fbnic_open(struct fbnic_net *fbn)
 	fbnic_time_stop(fbn);
 release_ownership:
 	fbnic_fw_xmit_ownership_msg(fbn->fbd, false);
+err_reset_queues:
+	fbnic_reset_netif_queues(fbn);
 free_resources:
 	fbnic_free_resources(fbn);
 free_napi_vectors:
-- 
2.50.1


