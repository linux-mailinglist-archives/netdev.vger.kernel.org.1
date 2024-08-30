Return-Path: <netdev+bounces-123560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0513965508
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6411C22AFB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE21537D1;
	Fri, 30 Aug 2024 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYicaLPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3742139597;
	Fri, 30 Aug 2024 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983395; cv=none; b=JWkPSpy1tRN5zSj1ZNFDElKcHW+Blq64wK+8lWTsnjEWDqqrfTWO8tv8meqg2IpN9gGYA7goYkSAK7IdqlV+OFaNTaL1eu+iWdoErRcZk7dfQQeXhj9c1K1fitzvn5epEHjX753lG8OGL714VZ/7fJDRskY7stKdJnp0EkQDfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983395; c=relaxed/simple;
	bh=R4gv0SPgrsRUe46OTe7crquVQ/CEzuw0FVvWWYYcPE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZ1pUjrrdsq49Rn/r2s1M6BllYglrW9kVxnNgwJDUZsRRSQr5PEBqSBcSHIrBDCHruhwbxusjEH4RiLcwDmG5diQ69atR6nVnrzzybxTMsQ7NgtSj+byB20WX2j9eL1FR3BZDQxWF9isrFj/kU0yfdVJQ6HTvXs85DPn9hk58cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYicaLPU; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-715cdc7a153so1058306b3a.0;
        Thu, 29 Aug 2024 19:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983393; x=1725588193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywfiqKh4u7bFVVs+tIwjEBC2kXxlfEwBoFKokKTsO+g=;
        b=CYicaLPUdovYO2xTbF97dLVgbo8nqjChQi9I6/C19jQOu3yYquCWa73vrzupS2KHJM
         EIi3JRuSQTDpoSMF8mCFf/XB190Aruh0lD9GrsVMnBmbW5whTUxGSdWkfU+k3S9e94gC
         aHsXciWpkDyIchlmb+Hwaz0AuYjnI0yu1qMObWtUryQj38ip5qzKWiCN2ZGA2pOOltdy
         n26g8gpQT3zErZxVDqyX1FfEh4hsvZVWTBpueLpetAnWSXG7ISWRPEKjW8PYIlt3EorL
         XcwIM3L6GTPtLTQVlcceofAKle4ARg9KaucJrRtoZlruqIoKbxwy0ju0bhGrgnIuaMJf
         jgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983393; x=1725588193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywfiqKh4u7bFVVs+tIwjEBC2kXxlfEwBoFKokKTsO+g=;
        b=S54mq6GqEwUahcgGr0gjTc2e/yYqx5POSLbjRxY7hkZD4TKVreD1dbuiGoWCG42A7q
         baNph/M7ke+KuauJrn9RszVfMslCXXW7Wo/pCzpY0GS6/wRGqP8ZS6wAt/yzfBZ8ntRL
         ut0c6z3ticAiR2YG/IOabOUZAHGsWuJUAexAIqg3q9+mXLhu/o+YZ6QnpqK7iQyhQq0c
         uEsuNt5mafDeEbr6dEECngflwcChnYC5cVNzIKDDDiNgy8sk5QaDkFimAMO4idiFHBXE
         iNz4xt0K6gizxN/IAi+wjCEXTx4sILxquPYNKJm+b5bGi5Kf8qZ1w+DlGCm6nSOQPLv5
         MBlA==
X-Forwarded-Encrypted: i=1; AJvYcCXB/di7YINEE7iGfTc7kkBZBOEUe0TRGhBe5cTZCzuOY1x8rSMbksZhPndPGpQ9UDW/HvhGqFXF7ZVvXzY=@vger.kernel.org, AJvYcCXr55TMwjvep3UmZur9BesiFSEHmyiueR4U0ZaBJHM1E3nGjKf+DFEl/oKM9MYGiyZLqttW4MTF@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/6+Lfk8FpOlEX6y0fSQldE1b0M1vTKrCrk1K8mA9YobKBMIq
	PyE4qkpRjfMWyR58zNPybGPa+Hlz+is9QLzMQV5hBTWwFhhNI9e8
X-Google-Smtp-Source: AGHT+IGOA/23GIGeKGBXHChGL+a631mrZR4C27wtUJFcsLMeHEsTgBEilGmHKdpL/ERsi3koNdAH1w==
X-Received: by 2002:a05:6a21:10b:b0:1c4:779b:fb02 with SMTP id adf61e73a8af0-1ccee886705mr1352666637.21.1724983392693;
        Thu, 29 Aug 2024 19:03:12 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:03:12 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
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
Subject: [PATCH net-next v2 12/12] net: vxlan: use vxlan_kfree_skb in encap_bypass_if_local
Date: Fri, 30 Aug 2024 10:00:01 +0800
Message-Id: <20240830020001.79377-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb with vxlan_kfree_skb in encap_bypass_if_local, and no
new skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index adf89423e5fd..65f532a000f0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2339,7 +2339,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
-			kfree_skb(skb);
+			vxlan_kfree_skb(skb, VXLAN_DROP_INVALID_HDR);
 
 			return -ENOENT;
 		}
-- 
2.39.2


