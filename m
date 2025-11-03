Return-Path: <netdev+bounces-235001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05455C2B0AE
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B3A1890D5B
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA142FDC4F;
	Mon,  3 Nov 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMBbxG/J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D382F28FB
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165702; cv=none; b=HG6R/hoWM9rHGy+DhUauM44cbytlEsKjUUaeluQ3cGhQsw3SNs5qdDUvaikFZ6J01ivjJvEfO0NyLljY017uioBkb1eW8AXfrH9myJgJbXnI9gOxMjBwvb2hglhvjVFunhRFWa2F/VU4/5UymgMs6kRsWY4gUsersF7VuAtjwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165702; c=relaxed/simple;
	bh=R6HeLI7JDCTVZupquML/vCC+pYaZ4S+yt8pXUQACxto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cq3lfVSIeARKBUCGJcfdYx8lm53zUIlKLPgZmR9CwHTd4zAUEyxugMqRz/PVumDcyx/Ej80RfCraBdvvci3U+x404XJ5dFqm65CR4CeWFMP1e56EjIKfUXy/Avscps4WezV5JnTnhf1mplKYPXF+z558AZ7xHDFOeDb7ZA9NjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMBbxG/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33422C4CEF8;
	Mon,  3 Nov 2025 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762165702;
	bh=R6HeLI7JDCTVZupquML/vCC+pYaZ4S+yt8pXUQACxto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JMBbxG/JFgkLStq6fa/BiyXiO80VoBi0IRsp5hFdV4bD/jmiAOs/xvHFFRH+hTQAS
	 0XRYH9LPnap6RvzNJp9cFYDkM9VTqIMSUOMcF3Yq357jKRJaMfI81HGOFtKJUIA0W/
	 +JkUwtYjIvridOy0V95he6RZCzT9IE5aTqtPJT0KR3Zn/JOMQtXHS5J47RndaxmkVr
	 wTiAX99PqI4r40+Fh8sggDUoW4HKMObmjgV15WT8dJjBL7LVfPp/gN0jTMAuqneOo+
	 UkObvOY7iRU4UhdCqPUoAJKIzYK4pAMvlaEQsgJz3CTjNMhvNXQxPfNRhctwWDONjS
	 9u0t3+g8qUX8Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 03 Nov 2025 11:27:56 +0100
Subject: [PATCH net-next 2/2] net: airoha: Reorganize airoha_queue struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-airoha-tx-linked-list-v1-2-baa07982cc30@kernel.org>
References: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
In-Reply-To: <20251103-airoha-tx-linked-list-v1-0-baa07982cc30@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Do not allocate memory for rx-only fields for hw tx queues and for tx-only
fields for hw rx queues.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fbbc58133364baefafed30299ca0626c686b668e..750dd3e5dfecb5d3d0ff754f6a92ffa000db3343 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -185,19 +185,27 @@ struct airoha_queue {
 	spinlock_t lock;
 	struct airoha_queue_entry *entry;
 	struct airoha_qdma_desc *desc;
-	u16 head;
-	u16 tail;
 
 	int queued;
 	int ndesc;
-	int free_thr;
-	int buf_size;
 
 	struct napi_struct napi;
-	struct page_pool *page_pool;
-	struct sk_buff *skb;
 
-	struct list_head tx_list;
+	union {
+		struct { /* rx */
+			u16 head;
+			u16 tail;
+			int buf_size;
+
+			struct page_pool *page_pool;
+			struct sk_buff *skb;
+		};
+
+		struct { /* tx */
+			struct list_head tx_list;
+			int free_thr;
+		};
+	};
 };
 
 struct airoha_tx_irq_queue {

-- 
2.51.1


