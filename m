Return-Path: <netdev+bounces-147695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBEE9DB3E4
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5804281139
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638B114B945;
	Thu, 28 Nov 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fig4u3tG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2C13FD86;
	Thu, 28 Nov 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783108; cv=none; b=mHhj7/qj2zbyH2aW29MKL4rH/4jPg/Btq3Y1PfKZID9qNaTqEUB4xLV+GHSmqDiEvlF5tv3zPWIHkoK6P1W+7codRoYBPCPDLyDeBf6wvyt5QhMOUmSEgS1jwJ16uvgPrRVv8oVwyDd9KvnZR30pgn+gQW6L6pt6x4VKVFzVVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783108; c=relaxed/simple;
	bh=ZhOoTD65cO9G5cot9yrds4u/ScS9iWVgFSa6sr5zrXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AB2ROnrGIWfl21+HY+fxL0iMZSqCqXmqCOFBchNMxFrLlfSlaDORTTRZ/GL79VUew4uKJaCKDzu7tcy/fhYS1upV8YkJxQhynXiBs62PwP/NQVF5yI/Q8YB4ggzM0bAXqIeASES/IHZRMpaxhLXARm7lAkSfX72gV2B9Iy89stA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fig4u3tG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382433611d0so517691f8f.3;
        Thu, 28 Nov 2024 00:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732783105; x=1733387905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xZOFn9eZsgpVjHqMRK72WMVAC06nVMZ/Hgtle1iP9/E=;
        b=fig4u3tGlCXvgdP39Z2wE496q/4BfeyBN9nTF/UWzcQg67kfWRYa6W6v/Dko/X8g4E
         xnUMN1iCeo3Vk18cvOQFKCASkoZZNIn55AlbVQMub3HSf9m73o9pt+6Yt6EADzu742wh
         hdXhzKjdlUwLCmjW3vyYTVc525dI/fr7/oFJgwom0VQPHn03X5ecveS4ge3Ve2VeCd/s
         5XLaU2ZcelytqXojoit384PCX9YEzcifMef8f48HFXpVFOae0+NuYtLSFzlJFUPj3bQK
         M9tJtYpgSDEIe7VpN9Gwo/jK9688/eiHQkvGmg24LbLW+SGLZynZXOTpoyq7tmeUwfOC
         CZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783105; x=1733387905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZOFn9eZsgpVjHqMRK72WMVAC06nVMZ/Hgtle1iP9/E=;
        b=KOruaqr7XMrSlRvUz1zF1lPxDC8pnGm+AdvDqAKnExZnB/4gzBMLb0LPWAcTdhmlMG
         /eWwWCZ3Kn0qceKTCFrwSRKO27LPeJnslFhzoCR9HAyXXEeeBG+8iLhl8PTUDdwxL1oC
         QiOPrhbWCZPxZSjt1mCfFeD5KRSs7hV2gNWM7T7ErxOM6xjYtLTMDlNOjLrcTRiScsVv
         6/QD6QTJ++jvsF/xATteMzZtIPqb88k0iStRvbJFgdCXpmLSHs32vcTBfbiQc9GZ1oZ/
         dcwe+xxuWufOF+Rbleyv4mRpBPkzkikcepOuVYWD1YwP5pS1Msc7DBTEoQP/8vP38p+n
         qlhA==
X-Forwarded-Encrypted: i=1; AJvYcCWLeiE3bjOnEmUY500hWB+7QWPyMG/UB46TDkqYO5pVYA8MHqvSgrZLw6CyTJCCaj5qadet4Dg3Lczp7ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqpNRJrFM0TeHnaoiQLBhTzd+HxEKuzKeqo+A3s8HS+WpPIyW
	oTgIzymd4cusJOd61qMEJ5soTu0rJxr7r82kjrtmOdVjBIgRkVk=
X-Gm-Gg: ASbGncucGs3HTf7dFk3ikW7v9JXAc8ewo9NssWxkH4XGjMT1mRQW+6io/d+K0q4ouT3
	Xg0AzWTmw1/aG1x6YJ3fmDX031DdwBdN0F0MWoNkXcG4bCllgmoFwQxP++6WZOls5h862hD+cqc
	ZGW5re+10hGvLZI9Ve10tY/Uo2j7EFE115NNSQMvxO3CxQSuIivpxWMI/UtSKH0p1QvmANCdhiY
	5xBNY9dU6NkfoHf6do8cQiMp/okr4KrBg3o+s3xTxMMr6g7H+N5Zc/vcX11RAG30Sz6W2n6WxOt
	DkM=
X-Google-Smtp-Source: AGHT+IG+2lUxaTLwUsoey3yYvit6KwJzncqkwP9hrUQJ3lMjs2mR9DUk6V9wbAYXt/KZnD/gSPC2WQ==
X-Received: by 2002:a05:6000:1acc:b0:382:4b9a:f51f with SMTP id ffacd0b85a97d-385c6edb878mr5242924f8f.47.1732783104657;
        Thu, 28 Nov 2024 00:38:24 -0800 (PST)
Received: from LINUX-DQNM303.production.priv (10.124.218.46.rev.sfr.net. [46.218.124.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36d85sm1023714f8f.28.2024.11.28.00.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:38:24 -0800 (PST)
Sender: Louis Leseur <louisleseur@gmail.com>
From: Louis Leseur <louis.leseur@gmail.com>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Leseur <louis.leseur@gmail.com>,
	Florian Forestier <florian@forestier.re>
Subject: [PATCH net v2] net/qed: allow old cards not supporting "num_images" to work
Date: Thu, 28 Nov 2024 09:33:58 +0100
Message-ID: <20241128083633.26431-1-louis.leseur@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 43645ce03e00 ("qed: Populate nvm image attribute shadow.")
added support for populating flash image attributes, notably
"num_images". However, some cards were not able to return this
information. In such cases, the driver would return EINVAL, causing the
driver to exit.

Add check to return EOPNOTSUPP instead of EINVAL when the card is not
able to return these information. The caller function already handles
EOPNOTSUPP without error.

Fixes: 43645ce03e00 ("qed: Populate nvm image attribute shadow.")
Co-developed-by: Florian Forestier <florian@forestier.re>
Signed-off-by: Florian Forestier <florian@forestier.re>
Signed-off-by: Louis Leseur <louis.leseur@gmail.com>
---
Changes in v2:
- Fix commit message (reference to 43645ce03e00, add Fixes tag, change
  phrasing)
- Link to v1: https://lore.kernel.org/r/20241121172821.24003-1-louis.leseur@gmail.com
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 16e6bd466143..6218d9c26855 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -3314,7 +3314,9 @@ int qed_mcp_bist_nvm_get_num_images(struct qed_hwfn *p_hwfn,
 	if (rc)
 		return rc;
 
-	if (((rsp & FW_MSG_CODE_MASK) != FW_MSG_CODE_OK))
+	if (((rsp & FW_MSG_CODE_MASK) == FW_MSG_CODE_UNSUPPORTED))
+		rc = -EOPNOTSUPP;
+	else if (((rsp & FW_MSG_CODE_MASK) != FW_MSG_CODE_OK))
 		rc = -EINVAL;
 
 	return rc;
-- 
2.45.2


