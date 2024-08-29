Return-Path: <netdev+bounces-123490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84522965104
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C9A1F23DD8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA318B46D;
	Thu, 29 Aug 2024 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2mRxlhG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598E18950B
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964553; cv=none; b=p+8sJwkMAwupXLf1XAUBECDRd512Hp1Nwc2Evk7irEUjerQW2VS8Gko9DB3mAG24CmhG5D7m8J2aaoQhQtq1sHAopDI0FvxoaRSuiBaesmNY49uma+S/UaOMXsfEhL2RZHI0M7Dc0aDRWkwmNeOPOjCqMbYhe3RfUE5U0VaOOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964553; c=relaxed/simple;
	bh=6V1zQyb4JJQe1x1GsfPpxi5B8rqhMNM4ly+Ac85hImg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FavWYXGZm21MakLFugCNtwpl4Cd+5NZtbrI0yFNfp1/1Ga9FHZRmjwTFc1bRW3+Fz9jeKoMRMZuAicstC6aZn1ckAXHL4D+ZVc+l9kZQ/axQRTuqGck5ItM2AIlZBRCqLoOdXTtwc/YxuxKJHLdmAo6ApjrLTuLrKeeHWwaGcfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2mRxlhG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724964549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VFLjaq4t+p4ySJaRjHHMD+djaojUeqjD8JR+7Pp4jkk=;
	b=h2mRxlhGpNNSCmA10MuMxL2Ffq/MSsiY6bRS8qxBbjKZEDUGpDCrMTYGLtJk2GInD5WDRs
	vNu+vJvgMl19bwvoKbRGAdzVnjtGErJkNjHekW+AecwfrBa4ZMJ7RjzDcps0gkSJGfNbje
	5uqvTu4nJ4qdvXQNkEe9bO/JBlTnXQk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-yaIPwkzpOXOrZT3ZburtkA-1; Thu, 29 Aug 2024 16:49:08 -0400
X-MC-Unique: yaIPwkzpOXOrZT3ZburtkA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-45689398751so5593351cf.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724964548; x=1725569348;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFLjaq4t+p4ySJaRjHHMD+djaojUeqjD8JR+7Pp4jkk=;
        b=lBELRLBNVr7KnvArBSabFc0oRkrlo/wVkMAHB1c1Ie2luPspeoo1p3tv4yQUM/akWF
         prnkveoQBsscj5WfySdKj6IWIAUWJPHDFXMTHuJW6yJKH9usHeYEIwy3cDnHZMbgD4WI
         y1Ubi3VqKYF0lcbTBgqf8lzqmLk1JnVF074b0gXHkWNDxqw3IYtkte/Q9rMMF628agEm
         PGThMwYfbGqIH7xhYC2jihK5016naMVNwk0Au7HWO3VRDh/hpUG4iRiI1HuRpK7ssjjb
         ddW9jLjAZbvQpQLg0KnExr0X4UUBx62z/xp3bu0CTjUGDfCGRlu6YSzCAygJ1vNU+xXr
         7xLQ==
X-Gm-Message-State: AOJu0YwMB9bMTgPLm55sxevFa39k9Q37HOj8ctw6ZhI9vCVQJWBDYFHb
	QjgzQ1trp5tZCWTu9ozORgL2tw7ZWme7MWIfsyK5eBSvtYtiynubK4Ii697Uf7O/2SHbQXNTW2H
	6NmIlll7xMl7JTZL6mcmuvH+XyT0X9TcwAzNnwqB8G3B6dDIILLIQmw==
X-Received: by 2002:a05:622a:578f:b0:453:5d83:6275 with SMTP id d75a77b69052e-4567f580d8fmr43858641cf.34.1724964547719;
        Thu, 29 Aug 2024 13:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeb+yBjMEz9BPdapOW3IkPpcjpvG1lfzUxlrzusYIy/pZk9xn7Op0zmI0YQmjcAC+y5+roSg==
X-Received: by 2002:a05:622a:578f:b0:453:5d83:6275 with SMTP id d75a77b69052e-4567f580d8fmr43858371cf.34.1724964547321;
        Thu, 29 Aug 2024 13:49:07 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682ce3058sm8168951cf.52.2024.08.29.13.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:49:06 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 29 Aug 2024 15:48:44 -0500
Subject: [PATCH net-next v2] net: stmmac: drop the ethtool begin() callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-stmmac-no-ethtool-begin-v2-1-a11b497a7074@redhat.com>
X-B4-Tracking: v=1; b=H4sIAKze0GYC/3WNwQqDMBBEf0X23C3JNgj21P8oHmzcmIWalCSII
 v57g/Tawxwew7zZIXMSznBvdki8SJYYKtClAeuHMDHKWBlIkVGGDOYyz4PFEJGLLzG+8cWTBHQ
 31TpyusZAXX8SO1lP8xMCFwy8Fuhr4yWXmLbzctFn/7N3f+2LRo3K2JY6q6029Eg8+qFcbZyhP
 47jC+FGFz3JAAAA
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
 Dmitry Dolenko <d.dolenko@metrotek.ru>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.0

This callback doesn't seem to serve much purpose, and prevents things
like:

    - systemd.link files from disabling autonegotiation
    - carrier detection in NetworkManager
    - any ethtool setting

prior to userspace bringing the link up.

The only fear I can think of is accessing unclocked resources due to
pm_runtime, but ethtool ioctls handle that as of commit
f32a21376573 ("ethtool: runtime-resume netdev parent before ethtool ioctl ops")

Reviewed-by: Dmitry Dolenko <d.dolenko@metrotek.ru>
Tested-by: Dmitry Dolenko <d.dolenko@metrotek.ru>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Changes in v2:
- Rebase on next-20240829
- Drop RFC/RFT tags, add Dmitry's Review/Test tag
- Link to v1: https://lore.kernel.org/r/20240429-stmmac-no-ethtool-begin-v1-1-04c629c1c142@redhat.com

I'd still like a few more folks to test this to feel more confident that
I'm not breaking anyone, but at least I've gotten one on list feedback
and one off list that its fine for them.
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 7008219fd88d..220c582904f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -438,13 +438,6 @@ static void stmmac_ethtool_setmsglevel(struct net_device *dev, u32 level)
 
 }
 
-static int stmmac_check_if_running(struct net_device *dev)
-{
-	if (!netif_running(dev))
-		return -EBUSY;
-	return 0;
-}
-
 static int stmmac_ethtool_get_regs_len(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -1273,7 +1266,6 @@ static int stmmac_set_tunable(struct net_device *dev,
 static const struct ethtool_ops stmmac_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
-	.begin = stmmac_check_if_running,
 	.get_drvinfo = stmmac_ethtool_getdrvinfo,
 	.get_msglevel = stmmac_ethtool_getmsglevel,
 	.set_msglevel = stmmac_ethtool_setmsglevel,

---
base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
change-id: 20240424-stmmac-no-ethtool-begin-f306f2f1f2f4

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


