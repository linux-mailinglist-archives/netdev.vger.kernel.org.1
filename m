Return-Path: <netdev+bounces-116697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC08C94B622
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B691F21F04
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9467145A11;
	Thu,  8 Aug 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="FCBvexmp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11A13E41D
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094127; cv=none; b=FlGIBIYh8+eDzQXPrB8t2qZqBoBPzRE2kLtLPaH2RiSv4Rp1yzuer+zZdlz2neo14kETJAkPjhaieRx7RnTnSSJFkjFuqlT2F69KgxHrOu1nWENegXL/CbPewtOq6M3yRGD7dwP3I1ZH9GAr/+W7wj9KalEvmn7bVSdtYxZ07fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094127; c=relaxed/simple;
	bh=211NJoltnjQUpKWPtKwuZhy86cbAsMtVexZwXfGx0xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUZbDnJrY3dbWRAT5orldJAor6gAKPMUYBOKDgiQVhE+hm0CIE8tjAVUKdcZ9eCACJ6AWMwVYTxBnolfnF/l+KdOUuSNCKPO+px8vVqpGBUCrlRuveljhxdbHDgU9H4xKXhIhzX8cq6vqaqzJKD1S6Drp+J8a7N6zzzhth1IbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=FCBvexmp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd69e44596so4124955ad.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 22:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1723094126; x=1723698926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubcT5XFjfxHfSYCtrvemnyeiUlVLmKPl/IH6RG+dQAs=;
        b=FCBvexmp6TjMQLC5sJQopDn3u6+YiStNZ27NPHkD+jnkktqZDknd96vnjfR0UQLXI6
         POys836///S+K8VHoDPo7Ox09IY42XlvXHA1mgDTOkzfEFWDSjH8Bmr9boiMukQKkxYq
         PhhqZOT3zk9KRwoCfvCMtikonbqPQsW52Uzcuo9FowFYDlKfX9YRYR04oZHbP5+08wjt
         HWKjgvPtoV8Dt8/c+pb7ZUcpOqtDyMFGbDdvUnEwtRpqCrUDxftUjT6TS+/RSpc6qxBh
         Hpz009zCbQwd0LZ976mkDny1/AhWCGhhe0Xl0VElq03wIcKCBvwKQc0z1BKYkLTCbER2
         XF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094126; x=1723698926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubcT5XFjfxHfSYCtrvemnyeiUlVLmKPl/IH6RG+dQAs=;
        b=dPhqL8LbWyee6OuVidg/stZfMswDTajPhhPM+NEbReky5nAuRHjTNjiAdD4ddUFPOY
         VuKsjD9U0QCMfCLb1B1OVvivz3zBuKtLi556YOXA2jcYn4z+QTgsd5Z/la0Akr8bILWO
         1AZHdTzeeYqmibfErEIY3chzbktCRY9CNx6wLa+eBUG97/ePXpyPww+xspDL6qMIqvXW
         9Y7HzgHf7nZbR91FgfmtptIfByttbsqlt3tJle3iX2Ey+m18HmZ1lBwv0LRrvaECwNgJ
         dSWTtOS7EAr3GXqH1nPLN/HrIvyMffn/b040te4JI7eon1/7EXJ3opAk+pyNNx4i1itX
         bNEQ==
X-Gm-Message-State: AOJu0YzQo8QuhCBxvZej7d1wq3yuTuhZqeaCVaoXOi/+jz9T0WvrUY+z
	2/jXGX7T1RbUhcQnbEAN74C0kmJ8QC2hArFQ60hsjsUw98oP5X9ZZKBRd+bLY5mn8ztogNfN+x0
	7
X-Google-Smtp-Source: AGHT+IHEwJf1IOI8zuVpnaOTqbF9NTUPKzPNPXx/fi7AXXVXUcVlx1sC+XNsd6QtjBUS57UPCYZb9w==
X-Received: by 2002:a17:903:1c7:b0:200:869c:960d with SMTP id d9443c01a7336-200967f6570mr8541515ad.3.1723094125662;
        Wed, 07 Aug 2024 22:15:25 -0700 (PDT)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19e68sm115321845ad.45.2024.08.07.22.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 22:15:25 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v3 4/6] bnxt_en: set vnic->mru in bnxt_hwrm_vnic_cfg()
Date: Wed,  7 Aug 2024 22:15:16 -0700
Message-ID: <20240808051518.3580248-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808051518.3580248-1-dw@davidwei.uk>
References: <20240808051518.3580248-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the newly added vnic->mru field in bnxt_hwrm_vnic_cfg().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 97fb570679f2..cfa4178a84a4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6579,7 +6579,8 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	req->dflt_ring_grp = cpu_to_le16(bp->grp_info[grp_idx].fw_grp_id);
 	req->lb_rule = cpu_to_le16(0xffff);
 vnic_mru:
-	req->mru = cpu_to_le16(bp->dev->mtu + ETH_HLEN + VLAN_HLEN);
+	vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+	req->mru = cpu_to_le16(vnic->mru);
 
 	req->vnic_id = cpu_to_le16(vnic->fw_vnic_id);
 #ifdef CONFIG_BNXT_SRIOV
-- 
2.43.5


