Return-Path: <netdev+bounces-211076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBCBB16788
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 22:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310451890EBC
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8834B1FDE3D;
	Wed, 30 Jul 2025 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVqu95eF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA21DF754
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906905; cv=none; b=suAhcc/hp8HTVFXphG/VbyN8hhXCgV+iRV4B+a9yxbPu60QebXFyVrEHU3UQypUOJfTi0CF/GN4UZIiITOA9/7C8uWfNK0nBVQhtvWe/LjWHNs5G8OshQ8KR4foaLm8ca4mjGCXPTVSDSoWrBIklQjMIn5KwWDd911TLR7+CBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906905; c=relaxed/simple;
	bh=NxKe2478qmRI5Yudeskx2LhyyqDBA8HqDWGnIvafIKo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cpp9qTiDKWCLyIv2Qj6Jwd48FoqGbrDRf3JMqBkoEWtN0lkLSu4VDUa5ykHCfyb+y3i7UmK/fXsIiGgxVs9Y1wAifVebDHV6i8aW0y3DeeMxcNSosLBfMftQLEr1nHZRWF9dueMiezpcdSfzd4yS0+EIaZOzMEnDsJnIp20paLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVqu95eF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78310b296so120231f8f.2
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753906902; x=1754511702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1q0g/K1YQpsv2+DtnbG5yRxD/ZgmAOkaRG1PJnaA5o=;
        b=VVqu95eFsvjI9OrwPMWKw9n4I1GxEL4LLOym7a+id+9SaTM5481qqyXwqzSrE4TgiL
         iNc2cSUg4D4f99ka5qGlrwEb5cqrbKwO9cWgRHf4XCMe41hMs8tPK0q8FPCGcCIbJgNM
         vwHEt8w8JW+8qNpIJtJKEpq52i+6A6CKQnhCk9H6m9gwbo/mcf5rc0BhMM9inYpQ7/+i
         HoeP9SipUMS2ZHf4tGmGsIxrpbncP2vEqAhdiSxenuDnh8DaPb709krUVp6NHuhG7aJL
         ttFogTrSo1WkCDlQmXwyOneJY7WgQPGUGyzKvuAxTIHu7OFIXoMeKkKFcRjW8tEsUQvP
         iL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753906902; x=1754511702;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1q0g/K1YQpsv2+DtnbG5yRxD/ZgmAOkaRG1PJnaA5o=;
        b=gT6Np71l0p8/bsqXLOTu7WeUmt5kwzkQBaxI2uqJ9fJdi2JAURHGlAIJeevFYsxpMj
         RfTw+w0YmklpUV5COiciD2vGFgX7MZstldAS9g8LVqcutGveAiAtzpx81NYuFuOM4HKw
         zKdNEviUIQ+M3DRrk27kTPX/n1pfVTypIpLF4Q9ZO+l1Yy+nfyYxWrL/4O+qCgXm9BSg
         yI64HfND51sxCNZ0hOr9BzF2q7FyAn8lLDfl9SeTMEB9QYBIZm0WH82iK8V9NvP3No3r
         2pF0kVsX8Ca4oPDdCXhYRlj3X7lJOamLkRCq1AbS+wrpexGhDbP8jI2uUN5Yi8I5dXiq
         pczg==
X-Forwarded-Encrypted: i=1; AJvYcCVz/MxOz+6wwMd4QpD6OkKR8sVx20BfUuNCaV/z1sLeuxHEdG0fCYsZUGuZBXfNd6MTo/c+0hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipVJfjMDiX9e0gT3xKVXO+nYuQYqecgJfXsWTVmLWz5cCOK9+
	YQb3F2V0PtIBKz+I+HwOIzrioI//r+0d14oOZ4D7yVTcDDwLUY/5dtYA
X-Gm-Gg: ASbGncubbSOkyPXeOx+j8Q3ZciVhLVFjA+wMpD4t7vczqWTOJQjPTuzsUxtq70Qzv0Y
	NFHuyB+Lk6DmV4ogAMjdHI7/9SqjrMRHvktUmE3qLUsyhnA2DiTWBv8Fgzg4C3QPGQTRkoUAuuD
	YkOrQkchWtfdlv0A8KKgOYYQxdORjN/p/0ZJQM93PiBREYXr2MEGlvqT03D6bQdS+Tu+2ijCOIu
	iyw4RQggxXkLC2akEVDzbXoruYWoX2ih1JXSzVR7OEUzdXIRQA/0vCEHvOm11fCQ3ZQexYCBs7c
	Tqs/hvzfIk2GkkkGc4uyGa7xT27SHey859XyT+IQ2yaUKOclpRM/l7aQKN/uFyXXwLmbLz5SdM1
	I2qP2u5BQ+uWZdZPwiNdXrzeqqxsQgJ8soCO+Wp48w6xRZX9ouLz1JCybRpUanr29ObdLUHYrEK
	Dv+p7/1Kn+URiVUGkVdYfRs+JH3/hZ2F3P+WhCT4ZBy9EoMqucDXxPRCSJ2E3pDw==
X-Google-Smtp-Source: AGHT+IF1xmF7BOYz4F2CwxJBSG7/U0IrPk3tskIiSwflQ8+T8No28sAP+4WCdTDH5dOH8ErPuZEnJg==
X-Received: by 2002:a05:6000:40da:b0:3a5:8a68:b82d with SMTP id ffacd0b85a97d-3b795028f8bmr3224891f8f.43.1753906901731;
        Wed, 30 Jul 2025 13:21:41 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f20:b700:4588:566b:f7a8:c4ac? (p200300ea8f20b7004588566bf7a8c4ac.dip0.t-ipconnect.de. [2003:ea:8f20:b700:4588:566b:f7a8:c4ac])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm14343f8f.49.2025.07.30.13.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 13:21:41 -0700 (PDT)
Message-ID: <2b80a77a-06db-4dd7-85dc-3a8e0de55a1d@gmail.com>
Date: Wed, 30 Jul 2025 22:23:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] net: ftgmac100: fix potential NULL pointer access in
 ftgmac100_phy_disconnect
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After the call to phy_disconnect() netdev->phydev is reset to NULL.
So fixed_phy_unregister() would be called with a NULL pointer as argument.
Therefore cache the phy_device before this call.

Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 5d0c09068..a863f7841 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1750,16 +1750,17 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 static void ftgmac100_phy_disconnect(struct net_device *netdev)
 {
 	struct ftgmac100 *priv = netdev_priv(netdev);
+	struct phy_device *phydev = netdev->phydev;
 
-	if (!netdev->phydev)
+	if (!phydev)
 		return;
 
-	phy_disconnect(netdev->phydev);
+	phy_disconnect(phydev);
 	if (of_phy_is_fixed_link(priv->dev->of_node))
 		of_phy_deregister_fixed_link(priv->dev->of_node);
 
 	if (priv->use_ncsi)
-		fixed_phy_unregister(netdev->phydev);
+		fixed_phy_unregister(phydev);
 }
 
 static void ftgmac100_destroy_mdio(struct net_device *netdev)
-- 
2.50.1


