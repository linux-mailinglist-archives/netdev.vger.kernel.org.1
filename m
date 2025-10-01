Return-Path: <netdev+bounces-227471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5955BB03F0
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 13:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB8B1896E66
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A97A2E54A1;
	Wed,  1 Oct 2025 11:54:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86F82522BE;
	Wed,  1 Oct 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319662; cv=none; b=NETzgbbi2q7SxCnBRFIzEQVE113FFIvuwDfOPanCMDQGOMO37yyBk3G1FLsR79ttcfMKChKVbxSfsa+Xs8tib5e8CSsNo1yjDxj8IdQk3hN3LtIutqsqYN5DZrqJIWNEQPB+IRjptUfD/G6BHsAJK3piJJ+tb4nNFWtiautSaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319662; c=relaxed/simple;
	bh=dn/RO9C44OLTk3vcWX+GfhcDgE79GFNrEnVQCO2pM1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9GPT6kCCQ9t4u6VkzPN0r9cv3sJejC13+u5Pc49DiJZVuJqlJmxhOWMSZ102y/dNyPoGEIE6i9lhpcnWoaSHbxpbdDQloqrVV5XBqurDKThzmqQ8/ZaooykE3lJuoiRzpzR53DvzT5ddV7dN6A/0C7FXP7PK9izMsSgUBm8NSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [111.225.242.229])
	by APP-01 (Coremail) with SMTP id qwCowAA3j6FHFt1og8oGCg--.6039S2;
	Wed, 01 Oct 2025 19:53:45 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v3] ice: ice_adapter: release xa entry on adapter allocation failure
Date: Wed,  1 Oct 2025 19:53:36 +0800
Message-ID: <20251001115336.1707-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA3j6FHFt1og8oGCg--.6039S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUtrWfWFyDAw13ZFy8Grg_yoW8KrWrpr
	4DJry0yr40qrsYgr4DZF4xZryUua1fKrZ8KF4rJwnxuFZxJw1jvry5try7KFZ5A39agas8
	Xa1DZw1UZw1DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsCA2jc2sWFEAABsz

When ice_adapter_new() fails, the reserved XArray entry created by
xa_insert() is not released. This causes subsequent insertions at
the same index to return -EBUSY, potentially leading to
NULL pointer dereferences.

Reorder the operations as suggested by Przemek Kitszel:
1. Check if adapter already exists (xa_load)
2. Reserve the XArray slot (xa_reserve)
3. Allocate the adapter (ice_adapter_new)
4. Store the adapter (xa_store)

Fixes: 0f0023c649c7 ("ice: do not init struct ice_adapter more times than needed")
Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

---
Changes in v3:
  - Reorder xa_load/xa_reserve/ice_adapter_new/xa_store calls as
    suggested by Przemek Kitszel, instead of just adding xa_release().
Changes in v2:
  - Instead of checking the return value of xa_store(), fix the real bug
    where a failed ice_adapter_new() would leave a stale entry in the
    XArray.
  - Use xa_release() to clean up the reserved entry, as suggested by
    Jacob Keller.
---
 drivers/net/ethernet/intel/ice/ice_adapter.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index b53561c34708..0a8a48cd4bce 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -99,19 +99,21 @@ struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 
 	index = ice_adapter_xa_index(pdev);
 	scoped_guard(mutex, &ice_adapters_mutex) {
-		err = xa_insert(&ice_adapters, index, NULL, GFP_KERNEL);
-		if (err == -EBUSY) {
-			adapter = xa_load(&ice_adapters, index);
+		adapter = xa_load(&ice_adapters, index);
+		if (adapter) {
 			refcount_inc(&adapter->refcount);
 			WARN_ON_ONCE(adapter->index != ice_adapter_index(pdev));
 			return adapter;
 		}
+		err = xa_reserve(&ice_adapters, index, GFP_KERNEL);
 		if (err)
 			return ERR_PTR(err);
 
 		adapter = ice_adapter_new(pdev);
-		if (!adapter)
+		if (!adapter) {
+			xa_release(&ice_adapters, index);
 			return ERR_PTR(-ENOMEM);
+		}
 		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
 	}
 	return adapter;
-- 
2.50.1.windows.1


