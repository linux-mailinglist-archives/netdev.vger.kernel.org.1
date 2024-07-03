Return-Path: <netdev+bounces-108661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A6B924E03
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 04:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2931C23FFC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 02:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE98F7D;
	Wed,  3 Jul 2024 02:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AC944D;
	Wed,  3 Jul 2024 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719975529; cv=none; b=HwGesafQgBEIJ+LzVYdNVF/dUN4gvmu1XQgYjF5akkUY+qxjXqTzMxCJazT9hs1fxt9qRXEUhDxGKQ872QiVSPPWyZMyxVglIBoQbwi8d09gD2I5DVTKLGq/Z3qslkpsR1ZMdrS2XP/ODvZrfGRRdeXM9C6ZysnTQHVkVGdtNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719975529; c=relaxed/simple;
	bh=Qrk/6G3Md9UfugO3hY29T6CsirTndzc8hz2z5i6uvMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyKWGwv4YWEgw+/VtE8Kb1bLw0YnGEq6FDgU7VMtmBOmyiL9iIsmuQxr2aBGZ6+9smMXd03kZQeUCjKZLyuFdkhNrYJkCA6J4DPOMnyGsQL2ON9ruoZMcGjlf8wm0Jaw/6PY/9maXHz+5LCNDPBctxMECzHbDYLkYJ5pkqRZ/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAB3mCVLvoRmz3_BEw--.43516S2;
	Wed, 03 Jul 2024 10:58:20 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: louis.peens@corigine.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	yinjun.zhang@corigine.com,
	johannes.berg@intel.com,
	ryno.swart@corigine.com,
	ziyang.chen@corigine.com,
	linma@zju.edu.cn,
	niklas.soderlund@corigine.com
Cc: oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net-next] ntp: fix size argument for kcalloc
Date: Wed,  3 Jul 2024 10:56:25 +0800
Message-Id: <20240703025625.1695052-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3mCVLvoRmz3_BEw--.43516S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4kurWrCr4UWryDJr4UXFb_yoWDtrbEkr
	1xuF93W3WDJF1rKw15Gryaqryjvw1kZr1fZFs7CayfZ3yDAFW7C34vvF98Xr13W34xCF9r
	Xr17Aa47A34jyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The size argument to kcalloc should be the size of desired structure,
not the pointer to it.

Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 182ba0a8b095..768f22cd3d02 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2539,7 +2539,7 @@ nfp_net_alloc(struct pci_dev *pdev, const struct nfp_dev_info *dev_info,
 				  nn->dp.num_r_vecs, num_online_cpus());
 	nn->max_r_vecs = nn->dp.num_r_vecs;
 
-	nn->dp.xsk_pools = kcalloc(nn->max_r_vecs, sizeof(nn->dp.xsk_pools),
+	nn->dp.xsk_pools = kcalloc(nn->max_r_vecs, sizeof(*nn->dp.xsk_pools),
 				   GFP_KERNEL);
 	if (!nn->dp.xsk_pools) {
 		err = -ENOMEM;
-- 
2.25.1


