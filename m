Return-Path: <netdev+bounces-130739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A0698B5C9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350201C21AA9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4F1BE242;
	Tue,  1 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V50/wGcr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3491BE230;
	Tue,  1 Oct 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768148; cv=none; b=Zzqx9vwD6VOoJ349Ig8M3Tp+yWO17hxt2/LGneGv6Co3blBguPmHGYscYhX41xwvJ1Kr02Kate0jxGhCuSM1fD3D6Z8DMktLnVuq554TPZrY5nqO6HpLAwhvRayjjfB+G/AjorpnNin462xhyvw8TplNnDvJiTJPZqFIkaG0NEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768148; c=relaxed/simple;
	bh=DRruHCRnENQ79ahhT+FzmIftKb3nQXcCDlCBOH6ItHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FTm6eDo62bJV89qR6jneJJmH65f4g9ZYJ8Y4w8BXZ4Wf898ZhcK4EdoHnguzM+aWs1AF0ES3xRsHlVATkD9e99jvS92kM6e1DSzW3ve388UIGDt+sTkxulI8cymIFFgOkT6LKnNdcvB17IrF4ow6tH8IQYDxslrVfXRll0KvyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V50/wGcr; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b7259be6fso23196265ad.0;
        Tue, 01 Oct 2024 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768147; x=1728372947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1V9N70oMJz4WUMe5EpbB18XlrU5zPmMhWoAOGvVh9M=;
        b=V50/wGcr41susTZYVn+O0G+h2gA/Vl3dWbzpLH6wGVnbszE8p7EIFZg4Bgp2bH+wic
         UTPiuSXn5yKWqR9HwqWMugcJkUEktQs/3EHz2bU5wGCmWIFxc3kWA2RMIFfaqWdLLEcM
         phAQ3ZTFUvDtnnP0F+KcJEpVXhQVQEpIzrsHl1zdorlgdFssv3sTukLOhhugcGBt2qfu
         G4gDaanwBQZnN4YGOk7izDECXV9YEkEsRrHkSsdIawOs+8GHje6P67/0GD0iC5UqxjOv
         kSeA00TTUMiKNVshXoPYB/LkycOlYPyH9o5kqxcG2Rh67txCw2S4+hdPARSuqWnswraT
         PNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768147; x=1728372947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1V9N70oMJz4WUMe5EpbB18XlrU5zPmMhWoAOGvVh9M=;
        b=iCZeEmaqjthJAPH9YZIVPr1ZgajSOwdjvXcaakCPnLNbks6KNDCIJ74er39a0oY/W7
         rps7rHp5OytLgLEv0UcGaoLih/wBjlv0iJbl0ilwliXFpcI+hZvX/Q3zJTRty8pJXY3F
         kn6FeSFpDlhqKyz7zEPOnkrXnAmkLnNg/e3UDM+9uGS+Z7Xi17ixCKnxJZPDbskS5yo+
         XsbdnCGyz5jMhsFrrCXriMm/xPc8VUFZ0Wip4LtPGNmrAirfn492lJ1Ai5hbofGYmsjG
         D3AbHEvsF/rlD4R7LARBUfEm52Lm+4k+6nKZltE5u0CcHWXycIz5YfZNJYCpbKd4dl4E
         1BXg==
X-Forwarded-Encrypted: i=1; AJvYcCUW2LugLcx78GGYbmbQvExVEjAmDHJNzKMRp71ZXEtByvjb4lM+I7KTsDcKx4JsWi8Ov0j89em2GJ5Du4o=@vger.kernel.org, AJvYcCWZL1M14thS+uxlIir0BGQMzMEm369r/72cyprW2UDlYMKexzMl2prWvjHrPnl+RX8Lj0wvEt1o@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQZ6kG2jFz2It24vLug+8eMbYAIJJzJbEahnuqfn/TtzKEKcL
	ARZkuv/UdAZ4mHem/9AO0wmVMdTlD36thGLvhk/mTo4eBVSxCMSR
X-Google-Smtp-Source: AGHT+IERNjlw9YWO+skQmU/xdIIE2M8GXqLKUErOo5pJwNMno/5VeXiFbXGd8CtLHqajrdgxoFSXDQ==
X-Received: by 2002:a17:902:d50d:b0:207:1de9:1014 with SMTP id d9443c01a7336-20b37b7631dmr216756265ad.34.1727768146655;
        Tue, 01 Oct 2024 00:35:46 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:35:46 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 12/12] net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()
Date: Tue,  1 Oct 2024 15:32:25 +0800
Message-Id: <20241001073225.807419-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb() with kfree_skb_reason() in encap_bypass_if_local, and
no new skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 4610f3e194e0..7ffbd06bd6c8 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2341,7 +2341,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_INVALID_HDR);
 
 			return -ENOENT;
 		}
-- 
2.39.5


