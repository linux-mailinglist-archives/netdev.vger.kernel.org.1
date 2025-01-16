Return-Path: <netdev+bounces-159036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87976A142F3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A5F161C3A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F46522DF8A;
	Thu, 16 Jan 2025 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bwnAbTm2"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625B1FF5E3
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058684; cv=none; b=EHbbTlMK7/1xiE8lyTaUDRDO0iGZPBK2RZOSot5WAMuXg5sbR6aPgIE4l86Z/Uwogj0dtX4vzRNTQrCOTePzI0gteutRst4VQFbXUb0R31LZ9LvvU4d97TYZuoBYcbQww5bldYUH2tzxSNog2JPFJbx1iSrE8ePQNukLTtLhuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058684; c=relaxed/simple;
	bh=eEAzvnmmdxRnkwoPD0jlP62NE1UifJ+8GgaBM0mD2iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdKi0lSFbj3Dlw3p5e/iS0X2wJEAsHamzpbrPyOGw/CMpz1On7vOLcJivoiswYzzr1wrAYvQO/tReHmkC0M76I0QUQTr0NqOIHXzMRRuU9h/ygaOG0fJsdW1W7IihnTMlwJpcurvUnt575Dyx6JMR9MdARkfOka3DauQirQ/Cl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bwnAbTm2; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737058665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OEaqchGpqFs7ia2RUQXyKa4Hx60PtaDnpqmkbPWn2KM=;
	b=bwnAbTm2wMkpL6S+30yZXkLp0DC3cWRziPU0oC9mQ/NsbgCVcDXNyzjukQDYtttIN7UhpB
	YN7tpvi7+taI/vxc4obmqu+BxY1m+2Jb7Jki38qE+hjc7nSp8DUrmUUAZIQ3IR54ZSyyLK
	2UKnYsTa93DQXwNR+bHjoVHGnZnAXqM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hv_netvsc: Replace one-element array with flexible array member
Date: Thu, 16 Jan 2025 21:16:36 +0100
Message-ID: <20250116201635.47870-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct nvsp_1_message_send_receive_buffer_complete.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/hyperv/hyperv_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index e690b95b1bbb..234db693cefa 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -464,7 +464,7 @@ struct nvsp_1_message_send_receive_buffer_complete {
 	 *  LargeOffset                            SmallOffset
 	 */
 
-	struct nvsp_1_receive_buffer_section sections[1];
+	struct nvsp_1_receive_buffer_section sections[];
 } __packed;
 
 /*
-- 
2.48.0


