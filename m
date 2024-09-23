Return-Path: <netdev+bounces-129231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E197E605
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 08:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59DE1C203F5
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779B1759F;
	Mon, 23 Sep 2024 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBf0ECyK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3E1FBA;
	Mon, 23 Sep 2024 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073213; cv=none; b=H+tFv7C7lqx7hkR2JY5/pq9zyS153ksnyRUAEsqMRn9jQW3OIUCH1IfQbxlGBDw/HlZM5XOVO6UAfD69WHWymdQPmabagE3HcfBK+kYduo+0mOHQvyl0M0PsNSIE+tdwuiZadpZ0BhYMMWLih+wDLRtd3dgeFnHLP4e9lVRqwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073213; c=relaxed/simple;
	bh=HoqH35/uhLHu6YQQgMWBupbXqYpXpJ7jqqANl3QxUNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tg1HGicLLolxELZzoD0z98oZPVqVdSdtCvRNe5YXjFmeQy4xI+cTpp9kKbqUtv9kt8srchnnnn1bGb59K3PjA3Dfy2A9jjupDi0cWNQjgbfFBsNiuwqe9yiOZLw6pJ2QIhGsZOyT7BLvfVZNGLU7P4s+VgWtUInb73okvs+2uDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBf0ECyK; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71781f42f75so3801777b3a.1;
        Sun, 22 Sep 2024 23:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727073211; x=1727678011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUNAWChZzn63ZWt73jGOo9/03BQgMS0LVs0hv21VT9A=;
        b=jBf0ECyKvOOGsTAdo8D0BY+hOjg2MlbvlQRV5bOUD71Tl9h9GL1m39AA40UpbQZIMt
         W2GF7XhcfudxGj5oUOff4YunFI0zogueBGIXl6RZL0GupCs+xfxeCjF/2m8A2A4oHq95
         3boJh1XsMnkuPt9pIe6HHydOcMZdECQhki71325tuIqUekxqZsOyCtUPsTOkFMVpNwDV
         F+t8sMNOfNDT8GELaDzIsULAbcskig4h3LqzSiw0BjRKUGMTqAEPE5n+igefBWDbIHGx
         yD+4XpMdIEE8dr/5FhA8NboY1NQVw8GgcB6JrcF+/XIyF04Xho97ymytg09XEPCt86BD
         pB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727073211; x=1727678011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUNAWChZzn63ZWt73jGOo9/03BQgMS0LVs0hv21VT9A=;
        b=fGEMJFNLyXK4yjAhPFQ35kxvME0G6eItHQcotIH9Qao4X2H+HeklGpZ596ECCCeCf7
         WSD6CNBFq//+8zji71y0nvY0GywHXzDXnkNhxs0ji9YGVPqUZIx+AGlKGpUUn2+xZ3he
         nFa8QQIm7oTvGl/dPeY3pXzS+gG+Luxn0whdHBpfSkWewVUe3+8mMwVcVWIr+hkzPjWf
         Q8g8rJpHpY7NsFDbHJntp/7U+W82e+TpfazZdsGH3abA1yIygnkaAJg/gDcRp25/9Bbs
         N5dJ8UQyRXIhvNpUEPs9vjFZdq7K26xaKmWG5pb2q3TzrrDvjTttxRf9l04wQFSSaAjE
         UCkw==
X-Forwarded-Encrypted: i=1; AJvYcCUUJsXGCG3cT6vjpBg0NISSy0iUTPAkH37sQt685zlgtF9sNjA4u9H6BZoGHCCBne38aaLnavFK@vger.kernel.org, AJvYcCXe+GWEsW4cHcDf4Zp3iORNihcwFUA9HK/0sihSL3VRaUJ4pL1KatYccp9ssglOte6DSnGEtc4I+lwFldo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEzmM7dn0R+shBhta5z1lOo00EKMzK5Yg/NE8rA0RA4f5jiP/
	gtoG6VaC1XAIAVSlU+RtL7eBKP6tauKBrMzOMIdBN5GopnT8OSIY
X-Google-Smtp-Source: AGHT+IHpr3/+5anyPSGDpDUjVQqA7orBqpYHMdacDq9TPV+nYsjdiRnqo7YZkIN1PXzrlzYTo4ofbw==
X-Received: by 2002:a05:6a00:2ea8:b0:714:2069:d90e with SMTP id d2e1a72fcca58-7199ce40a7amr16058208b3a.26.1727073210953;
        Sun, 22 Sep 2024 23:33:30 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ae04afsm13643812b3a.95.2024.09.22.23.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 23:33:30 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	bcm-kernel-feedback-list@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net: Add error pointer check in otx2_flows.c
Date: Mon, 23 Sep 2024 06:33:22 +0000
Message-ID: <20240923063323.1935-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding error pointer check after calling otx2_mbox_get_rsp().

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v2:
 - Changed the subject to net
 - Changed the typo of the vairable from bfvp to pfvf
v1: https://lore.kernel.org/all/20240922185235.50413-1-kdipendra88@gmail.com/
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 98c31a16c70b..8a67c124b524 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -120,6 +120,11 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
 		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 			(&pfvf->mbox.mbox, 0, &req->hdr);
 
+		if (IS_ERR(rsp)) {
+			mutex_unlock(&pfvf->mbox.lock);
+			return PTR_ERR(rsp);
+		}
+
 		for (ent = 0; ent < rsp->count; ent++)
 			flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
 
@@ -198,6 +203,11 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 	       (&pfvf->mbox.mbox, 0, &req->hdr);
 
+	if (IS_ERR(rsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return PTR_ERR(rsp);
+	}
+
 	if (rsp->count != req->count) {
 		netdev_info(pfvf->netdev,
 			    "Unable to allocate MCAM entries for ucast, vlan and vf_vlan\n");
@@ -233,6 +243,11 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	frsp = (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
 	       (&pfvf->mbox.mbox, 0, &freq->hdr);
 
+	if (IS_ERR(frsp)) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return PTR_ERR(frsp);
+	}
+
 	if (frsp->enable) {
 		pfvf->flags |= OTX2_FLAG_RX_VLAN_SUPPORT;
 		pfvf->flags |= OTX2_FLAG_VF_VLAN_SUPPORT;
-- 
2.43.0


