Return-Path: <netdev+bounces-132480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85868991CE0
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 09:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86101C2133D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E2C172760;
	Sun,  6 Oct 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmKHhRnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF41EB36;
	Sun,  6 Oct 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197883; cv=none; b=Tu41ULwLkJq8l82FhAzowmb4Erbhg/fY0wG1HvAIudLvbavnsq1OTESAGQ39OsVZkrpxqsU0ZVQh8BAb5p1ZG41EjzIR053r+2rV0SJL/jbD/YCPOHhuuG960c4FSJdgS13ehWUMgOyJR/If7TYLNs7P/FB/LABZmFFYvYiVosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197883; c=relaxed/simple;
	bh=dKbZM7+rvKdCAftLsIqRMrR/jd8BPaE4KCzu53bpfvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgMQb4Y/B+DBCY1n+HWDHVXKu1E1NMHo+Rm6LijyhjfcuEL7DnmiFGC94AfasCnd/H+rZ0Sesfae3vadWtKwavt9PJvsd0WH5pSPSt4WcNLc2K2H8FAmTMEDy2y7X5/rrE8eTSdI50FdPh2AidkIjgBoPb8WJBmLb+XBaunSIE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmKHhRnb; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b7eb9e81eso40353855ad.2;
        Sat, 05 Oct 2024 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197881; x=1728802681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwQKLkW+/qRHGLn4gTua8kQBWJmQk8KcS+aTLWa1XwA=;
        b=mmKHhRnbppEjbB/Rtkgbsx5F1GIrjzFhOkyoLRKfcrckLrjZxRMlXeXyHKfzOJVI5R
         ya13Gw3Gi2SGD89apdqiGczHh4+qn6UbA66t+/BduSmRwQTQwirycahHvsa/LR24uHs2
         4Em7C90vY5jPmZQhxFIzEA5UIf91M2MF03zfx2d3cZWHvfLppjblw2++S91O5fCWKRGG
         meHOO3/Fjl0nTuOs4c/fPeCUnQc55MAoXaXO2ama0BKtHKMVMdesPoSByXub02XiewCV
         SSF3+dL/k3uPrTZ2W4qpWxceVK/Z5kBkbQRIodOPX0mTVuQHM3UCfiAzKfElTZQ9JDlu
         Lskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197881; x=1728802681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwQKLkW+/qRHGLn4gTua8kQBWJmQk8KcS+aTLWa1XwA=;
        b=aYUoC3I5A9TiyQIcIBG137JQ9IRSOClpgHkZzOQhM9CEOvs2Qth7BweGoq8rOOW5Es
         AAWwSOLwIfvnOIRGuLqL/ZgmSC8sqRed2aQs7K9UYANBjaUK212yVLIj80qZUlrjGwWn
         Bfp6i7TUPsDMZuZztixI4ioAbraOdAWTqdI23BYq7fNkvONS1wsXtEe++2mJLBIAoE6H
         xAGr2m2e5LdrV0I2M2tYs5/mSwy7tx5rzeBKXXO9wsve/+Gso3C2KgKF/QuCWlRgohpZ
         iLHeggHRYHUUDuK2Fck9jrDEZLh8IWvREVSw3iKWKX/jQAFN/12ycAyEb+vaqzzVnItD
         1NcA==
X-Forwarded-Encrypted: i=1; AJvYcCWFCD0HpsQzr05zuPF3RgPrtOULsczCkmB+sDJGII+xKO+KybDpoqwkqfHahbRQrW/H7/9yR6hk@vger.kernel.org, AJvYcCXDUr2iWz6YeGY3YhYhuluTIpvQMhXhGbQ0pQT1r/4o8iVRHnjCpkwVcLIgvtBbZtrXo0VxWfJusnjAh+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7iN22em2CyYtDgXnN9XkQPfbgemdlFOiA8XWByaARccC8cRe
	xLjM71E2rqL6jrYDFBsATPjRUyBiid0E42HAfir1nCxuhTyGkdfc
X-Google-Smtp-Source: AGHT+IEfC8ROF4RbEcTIyUxsKlI8U1ld6f3g9Q0X45WL5SD8P+lfFDocjmki6uJYpIN4UeSd7MEnIw==
X-Received: by 2002:a17:902:f651:b0:20b:9b35:c62d with SMTP id d9443c01a7336-20bff194c27mr115722935ad.59.1728197881433;
        Sat, 05 Oct 2024 23:58:01 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:58:01 -0700 (PDT)
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
Subject: [PATCH net-next v5 11/12] net: vxlan: use kfree_skb_reason() in vxlan_encap_bypass()
Date: Sun,  6 Oct 2024 14:56:15 +0800
Message-Id: <20241006065616.2563243-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb with kfree_skb_reason in vxlan_encap_bypass, and no new
skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 508693fa4fd9..da4de19d0331 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2290,7 +2290,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	rcu_read_lock();
 	dev = skb->dev;
 	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
 
-- 
2.39.5


