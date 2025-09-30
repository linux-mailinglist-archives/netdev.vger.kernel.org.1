Return-Path: <netdev+bounces-227268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65092BAAEC6
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC4D169174
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F21A9FAB;
	Tue, 30 Sep 2025 01:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F120B22;
	Tue, 30 Sep 2025 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197124; cv=none; b=vDtaJ9Zct//zUxwZ/YPIn5bFXwyeDuuMfO1CVckWbxpyQLqJh75TgOXGQQddokZpO12M6BL5Ett/Xa9vahKqHFRvdBcKiHjK3aILEJHIlnhw/yGJ9E5JQJ4iWPZliBkvzCXAAuZgKv4NGUtkuJFzJQBcuMC6Lfdn3hqPFzSqu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197124; c=relaxed/simple;
	bh=tVEldp/5VrBGQPwzo4l8dsB69fJuysfXQTe7HYA876A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ato6Pm0MVHJp30pINnBBckTKlevzdFUqj91XxxqETg71Ct/1NOwKhO8FDmFZgxHmoT6yl7NBtwyj5TJ89KSm44evy2JopqdJtvgdTJrLKKEgW0yXiw+bkJqqmrEg4013b6/MxKdIe+ayLNKf1+q5brzOg1GrtPzQb5DgVcmWygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAXtg+nN9toIWUcCQ--.31124S2;
	Tue, 30 Sep 2025 09:51:36 +0800 (CST)
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
Subject: [PATCH v2] ice: ice_adapter: release xa entry on adapter allocation failure
Date: Tue, 30 Sep 2025 09:51:25 +0800
Message-ID: <20250930015125.617-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20250929024855.2037-1-vulab@iscas.ac.cn>
References: <20250929024855.2037-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXtg+nN9toIWUcCQ--.31124S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryUtrWxuw1DJF18Wr1xZrb_yoW8XF4rpr
	4kJrWxCr40qr4vga1kZa1xZryUua1rKr98KF4rJwnxuFZxJw1jqry5tryjgFs5C39Yg3ZF
	q3Wqyw15Z34DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsBA2jbHlldZAAAsC

When ice_adapter_new() fails, the reserved XArray entry created by
xa_insert() is not released. This causes subsequent insertions at
the same index to return -EBUSY, potentially leading to
NULL pointer dereferences.

Release the reserved entry with xa_release() when adapter allocation
fails to prevent this issue.

Fixes: 0f0023c649c7 ("ice: do not init struct ice_adapter more times than needed")
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

---
Changes in v2:
  - Instead of checking the return value of xa_store(), fix the real bug
    where a failed ice_adapter_new() would leave a stale entry in the
    XArray.
  - Use xa_release() to clean up the reserved entry, as suggested by
    Jacob Keller.
---
 drivers/net/ethernet/intel/ice/ice_adapter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index b53561c34708..9eb100b11439 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -110,8 +110,10 @@ struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
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


