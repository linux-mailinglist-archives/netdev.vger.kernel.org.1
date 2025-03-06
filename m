Return-Path: <netdev+bounces-172559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8260A556A0
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51EB3ABFE3
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695F277803;
	Thu,  6 Mar 2025 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCGr7WxH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A06277029;
	Thu,  6 Mar 2025 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289251; cv=none; b=e2LgZOwWFc+jAcJudeEG+rMc2theWD9s/VqZ1xOtqMQOGlhCY2mb4l7nKZig/L+4pOWeWxQxmuSqzPpAGOE6l2tm34HAJ6GKCMZnpF3tVRhgm75McUdCdMlKYpcJfmbdctq5CAhItvjHEVS3Bg2R9H02Ell6pdh7AeVsAqL1GXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289251; c=relaxed/simple;
	bh=x/5U11tfFOGkJjnZlOhXzeFUNNhCZdavOEif4Ham/8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqa+9Wv/2OGlDyG0I3uDzsaO5n/mIoGJJkOBKaiymPfG9XB0YSbPT1O9YFiZrftKmFRBgmmrJL0lXFuwHqoYAlt/rZtaO7ccJWl+JqDYuOdhWVWND8X+ZS2f9WUUQhqUTwySHku4oe4guF3QKTzYWiHU74J1GrOc9jHoydghuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCGr7WxH; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f4d935084aso723147eaf.2;
        Thu, 06 Mar 2025 11:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289249; x=1741894049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2utW+gDjzlNJ1wPa7OV1/6d7rlz+gUEUoG/flq259i8=;
        b=CCGr7WxHYVinS4aeabwm0nav+5Uascjby9nbqm3o+DoQfvs4uSTBA3jFI6oCOuuHB3
         nJ5lXCb4OYucbkn5g0xTO2dJlvUFLkFixyvhDT7yfkgWe9U2pZmpYlGKLEXuRnyko6bl
         g2Kj21O0jOn016ONLVOK7UbPR4awyZOfGJzx8y5GwCfbUCK97W/GdK76KAW+zFdU722w
         d85x0XfakbIg8hVjFil3JRnaRPmAfNnZoSaKZ8vAHrC4ykzApLnnnMjZe729M1tBl77l
         NHFt4ljbGDSmwLTnzPqLHNsjt6p2nDrS62cYulrtzviUXLW5z7eW2lsjcxn/696HHt6V
         ggLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289249; x=1741894049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2utW+gDjzlNJ1wPa7OV1/6d7rlz+gUEUoG/flq259i8=;
        b=V8EkhVphya3nsPIpvidjyVmiLLrCnz5tFjNsOGwS+moo158vvrwYVi/n1J1Re0V/eo
         qDXZ07SV4ZkmlUNjoNQpq0+ZV3PbABtAqRYU3ZkOGuIzVRa2p6n3pFNd3h01QwwKrQnM
         JkcN7WiePnRy/p3tI0HqfjlPdtrwlWAJGTIHw6CdOaB+7mc5/9dAenWDbKCi7MmPokeP
         Vxhnbh1G+eDKb5EbJFSTno1uaN4I1OZm5cFIn5XvYEPyD+0Z3SJHPIRUPf8UMVTWOETx
         KR4fOOUJ3zz2QWxj+6UQHcL12DAmz2sqRjixx9HMqaZvhxH5IRxGojtd0nec4yMoHoXk
         WKqg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ1GncFNNLZisx+AhqLGzKcJCYKmCIjFA0oJ57JYgjZCXkEeu6emaw9AQZvYgd6lWccNh1w9c@vger.kernel.org, AJvYcCW77UY+OuEsmwwqQbp8RcNixBfoL1vT2oRNvVtvqO79gqFrbFleW61UCJvkyENlXryfjxpvRbxu1l4CTgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzOMs9a3TbfXnzMmurMsWK6XKKsyYFRYNK68QfMdIOmuS88L4G
	QE/TOWlbGjVgU6mwKXQr1SY0rbci1VejRQZp2dyEpOf8puIY3yEm
X-Gm-Gg: ASbGncvZypbOEiejQLVnbyUfb9AAHnDiVJDBGr6LrsRnrMorLr9/MoPJSjErhqqS/N/
	1rDa0u7KRSlgpUREKPxEe9ERGUH1NTRvgJNmqyQIQhQw5CaT1KWMQAj0xtrX+1l0LrWycqNZBpS
	aCcd7gFCuiWHeOHFNpurHQnwPk9f39yY6GvNPU3q1n7U1S2PfeyORKuLjShVegxzNlkMPOHhFur
	AvTVdVPOZeDn7++aGeimEdQtf6w0Q+1v0IBJffXMhKZPvLYCgjyozSUl4hb4ESifWdMHj9xc88y
	fIE1Ir5qbpTDVqoELQT7M2Jj3swRddmQjnzF87qELVfn+X2b6Mzn/q9xL9Y7p3uTTvOwQqm2LYA
	pyO/rPzhaM+W5
X-Google-Smtp-Source: AGHT+IE63b/7W2iM5rV2HL+AaPUnINq8FG+IF90UwN/FOVscVF60nUfS1S+5hWdqrWyoGclqNnPSwA==
X-Received: by 2002:a05:6871:889:b0:29e:1cd8:4a0f with SMTP id 586e51a60fabf-2c261145f02mr276725fac.17.1741289249200;
        Thu, 06 Mar 2025 11:27:29 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:27 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 04/14] net: bcmgenet: BCM7712 is GENETv5 compatible
Date: Thu,  6 Mar 2025 11:26:32 -0800
Message-Id: <20250306192643.2383632-5-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
References: <20250306192643.2383632-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The major revision of the GENET core in the BCM7712 SoC was bumped
to 7 but it is compatible with the GENETv5 implementation. This
commit maps the version accordingly to avoid a warning.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 48830942afa8..e6b2a0499edb 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3825,7 +3825,7 @@ static void bcmgenet_set_hw_params(struct bcmgenet_priv *priv)
 	/* Read GENET HW version */
 	reg = bcmgenet_sys_readl(priv, SYS_REV_CTRL);
 	major = (reg >> 24 & 0x0f);
-	if (major == 6)
+	if (major == 6 || major == 7)
 		major = 5;
 	else if (major == 5)
 		major = 4;
-- 
2.34.1


