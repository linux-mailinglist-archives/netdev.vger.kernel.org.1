Return-Path: <netdev+bounces-223163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BECB5814C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7411C3BD82A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB61237180;
	Mon, 15 Sep 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pclnnEKp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945B22A4E5
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951598; cv=none; b=AGoLkFoX9k6qs/PsYNHClhoNMQTrTIxVBrSw55G9t9O+SEqK7Qg3OyGIXlTAvvLA9+hc1jurfj9v9QeYib+7YdoTq2t+yJfW9jsiVbSBEOLdJQYaTyTex0V+Pu9jvOaNbhHZbIQFTmj4ThhPUUcstpvTbX9A5ZbVJDKEFdQBFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951598; c=relaxed/simple;
	bh=XeY6dPY5kNIfGRbcTXPtmU+A3WlvUcKDEK/+I6EPuFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9ylAv+NBCGcfBqkw08d5D53XgHx6asOxcZRLZEBNokZdL8bofWMeTS6XQtiuWA8TxRwyi+ga0xe+wXhm+kHcoVcjxYYBddVMI+fxQkmf5g2JcBByW0usZsJtiaDKr0MlW5XVOYOZWr+qr+1/ldvQLluuCWZwDx4zcZaIatXM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pclnnEKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8AEC4CEFA;
	Mon, 15 Sep 2025 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951597;
	bh=XeY6dPY5kNIfGRbcTXPtmU+A3WlvUcKDEK/+I6EPuFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pclnnEKp4uw27oZww+sI3ZKZhJT9dU2zfAWM3J0Fmf93aHD8YSOCavYoLQnl/SnqZ
	 RWBorIfUfUnPZt6fzDt1HXe05nuuyLxpuI50/JKXnNEee+2ZYpqje42Fjd/mR4S51O
	 r/ci0j5WldXLZ71Pltb8Tjtj5jGdNJsf1J94aMe73MmvIqp5TJwx/Pt7OFJRVEjM+U
	 53SEzbRBgvide0JH1jptaTEQ/VZBi0/IIvESxBA5HJ6aIsX5wRsZCuvyA8jI7Hu9Ex
	 ldVQzdduAQlW2/iCqLRYNOLx5UDPkHLYzXfyqcuJ9YRsIH8IPsofJdDjeHk8G4ttFJ
	 UPXygMHr3Ra3Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/9] eth: fbnic: support allocating FW completions with extra space
Date: Mon, 15 Sep 2025 08:53:08 -0700
Message-ID: <20250915155312.1083292-6-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915155312.1083292-1-kuba@kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support allocating extra space after the FW completion.
This makes it easy to pass extra variable size buffer space
to FW response handlers without worrying about synchronization
(completion itself is already refcounted).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index be7f2dc88698..d4c0fb4c94cc 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -100,6 +100,8 @@ int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 int fbnic_fw_xmit_send_logs(struct fbnic_dev *fbd, bool enable,
 			    bool send_log_history);
 int fbnic_fw_xmit_rpc_macda_sync(struct fbnic_dev *fbd);
+struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
+						  size_t priv_size);
 struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index e40dfd645414..621a574e0b0d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1542,11 +1542,12 @@ void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
 				 fw_version, str_sz);
 }
 
-struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
+struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
+						  size_t priv_size)
 {
 	struct fbnic_fw_completion *cmpl;
 
-	cmpl = kzalloc(sizeof(*cmpl), GFP_KERNEL);
+	cmpl = kzalloc(sizeof(*cmpl) + priv_size, GFP_KERNEL);
 	if (!cmpl)
 		return NULL;
 
@@ -1557,6 +1558,11 @@ struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
 	return cmpl;
 }
 
+struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
+{
+	return __fbnic_fw_alloc_cmpl(msg_type, 0);
+}
+
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *fw_cmpl)
 {
 	kref_put(&fw_cmpl->ref_count, fbnic_fw_release_cmpl_data);
-- 
2.51.0


