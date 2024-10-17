Return-Path: <netdev+bounces-136743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C149A2D6B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A41F263B1
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9321C169;
	Thu, 17 Oct 2024 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqp/ECDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D01E0DC3;
	Thu, 17 Oct 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192248; cv=none; b=RIQ/ZTBegs0TKlP+B+NPHP1pbauJZYtfHfkdYWGuPZvHRsIZ1YLHYCHOxRT6IpfbfMOspJpt577YbHfnn/0iFBm6PXHu1Og9fvtCmEX32YPoVIEs2xeDLOdfiiV2Td/4nf83+LdRLEaflpBZrv0GeRwpesk065JrR+9UK8e1rgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192248; c=relaxed/simple;
	bh=oCKDw78LrAsv8hrtp90tMl9gQsFT8ys/qO6FDSn/vEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUPIalWH5ynsDnVxf8BV3ukK9FbxR54pd3YQXHHn/093nYd/CjOP+aTqpQ5JHmTxpGcUpZRhhV0rkmxkIiYzfv8BJfZ8J5Fv+mTlgk4b9QfDKfgObYoDIZM6UUoKpkLh3QXENrXKMmyQh7s4M5AV0GXJcZIaksTsLWzCfu3qH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqp/ECDd; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso1805791b3a.0;
        Thu, 17 Oct 2024 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729192246; x=1729797046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDSXLjvpLxqWxXHVbrKPpR5QLgHr8pG6IHSrQY1XA8c=;
        b=iqp/ECDd9Cl6nNN+CcDnCJal47DRp7BI47LpSf0pXSvqsEFxDlGm09bLJLOUywIGRG
         s2eG2LSjDEoYcu8RcwCP4Vhpehr9uH+JH2qS1egp4uY2xf2i2l9hGOs+TqBX23qkXqHk
         hWka8TceQSoGpFkDChuDqeOV4nyEfVJZ2tPen/EPoaeEOKgN/yiNvAITiPFnqDmApJoU
         AHZ+xH1vYL7a9I1sk3JF7+hMrl7B2qNBpSVYm4BGrvkEvud001XHG/cTHJYfaW17lbYP
         cdkSvpVbLQdxXZs1+IBdrQ9H/tCAGumKalDf1JKivqOvzMSSItaAPI4FIF3tgsem6XEU
         vRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192246; x=1729797046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDSXLjvpLxqWxXHVbrKPpR5QLgHr8pG6IHSrQY1XA8c=;
        b=KNpxHzOElH/wpmCoDVWXISgCZDY5gmdXi1TGn2Ab6MakVdQmOZQ5t3faz4XPOCKEtH
         W/6aAm0tkaevA4V3eAtQ2HSfq7UB3cmdClH1uRuGqe0mLXTwFdC98V8BkUEKugB3TgXF
         xvhbhHejZkJ2jzmOcqxXwGE1VSgV6V8dZ1FrLKsGHROlPXYuZ5xRepNFc+ifWlHwUF1a
         fKiK8z+/6bzZDhUu8KEm5WMXaj7pqGPd1SxHPZriEFmp4EVSqK58qRiUPiKJAsCE/sUz
         xLm6ArHjJfmCYOtcqblHTF/sNbUub8+lf4JR5lsN8x9ygfDK2qC7XoVkTOXfWnLw9Laq
         7vxw==
X-Forwarded-Encrypted: i=1; AJvYcCUxOuYl9MRlpBYgpu3WSuT/YsI2+1eo2uX9SPFMjxjYDXwh1dy/oV/f/cZqHddiuggLi7WX9s7Z@vger.kernel.org, AJvYcCWPnMOwOEJUSSrIWEdxvOFHRGqbi8rzc0fzm816nK0HuKeJ3I/b0POJbOFiGaGp2coxQt+xAgfk/hnxEDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGfIWArmYaoNyK5TNHdHSzsD/jHSzIWKxGYwSa7jdjumypbIPp
	FshaihqF/Y9SgJrK9CUysHLMESWMyynqrscGmKJp0nXnAtYIjB/w
X-Google-Smtp-Source: AGHT+IE+lmXYD1lA4neFPxR805oIpg0QWSGDEfq0rF0jsi9ai/gClkbvdKd5J2eifnTP/ui9M6VBXQ==
X-Received: by 2002:a05:6a20:b598:b0:1d8:aa1d:b30c with SMTP id adf61e73a8af0-1d92b64713cmr323401637.1.1729192245699;
        Thu, 17 Oct 2024 12:10:45 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a41a2sm5061081b3a.124.2024.10.17.12.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:10:45 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
Date: Thu, 17 Oct 2024 19:10:36 +0000
Message-ID: <20241017191037.32901-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017185116.32491-1-kdipendra88@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer check after calling otx2_mbox_get_rsp().

Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index c1c99d7054f8..7417087b6db5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -203,6 +203,11 @@ int cn10k_alloc_leaf_profile(struct otx2_nic *pfvf, u16 *leaf)
 
 	rsp = (struct  nix_bandprof_alloc_rsp *)
 	       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		rc = PTR_ERR(rsp);
+		goto out;
+	}
+
 	if (!rsp->prof_count[BAND_PROF_LEAF_LAYER]) {
 		rc = -EIO;
 		goto out;
-- 
2.43.0


