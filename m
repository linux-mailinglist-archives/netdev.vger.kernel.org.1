Return-Path: <netdev+bounces-132494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F9991E67
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D62281FB2
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3F176ABB;
	Sun,  6 Oct 2024 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieYJAmpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54563D520;
	Sun,  6 Oct 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728220119; cv=none; b=P3OpdLaGNsEvrjkcBBunqF9pv1RMl3OR/U7eyBRDmCH74aNcsrRxs1/IHB+UBfoG3EJIxuvOPZhexWy+yOcLreJOLGoOL5v2yxUXi3ojXon/F4qMJVZaTck2ZSk8xBKaYjImWnq2AxvexIQTl3gSGRDYkdNwugVyEXYJ/ALSbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728220119; c=relaxed/simple;
	bh=xv6qdNSiQ8gOa1nlcDtSV32bn17n4tkidPNGmzeQCzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EHrPnVe6xfckQBIY4CZlZPoS4Pv/WqvH/zPqPgGtIGAoU2qgGRlpFiT+aTXsZtcRzExlfVZQ6wtz41YkicbBd6YNYyYq2FzvOy1+VbXTbRAlcxP2Y/l0i+/4yfE4KnghgHO2B0Q1HZnihdimQ5gVVSea2GOkvNunHl9DDa5nOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieYJAmpI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso46400755e9.1;
        Sun, 06 Oct 2024 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728220115; x=1728824915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dmx2sBdekqi6blVgKnA1R+7bIKWb4LbSOPTUFdSrnhw=;
        b=ieYJAmpIVmTSLl2GC3dbDDwUgdGjN8XKyh2uSo2z9zqFPtDAT8/ZP425xZ62hmuYOA
         PGDFmx0VRVzqorCtCcbqzK37u8LIgvk4JtvgS0Qprzo/dbupGwqUbfB70ii7ZQFpBu+1
         PL4icl6QByWtBiC5WXo/+2lEe3dBlfAYMJgxs6yquOOHXYAMAABJ5GwqvdSuMyCkVLT6
         Hv9kgRk2q1brJCFefqfcBjF45J3rDScQjHxMVPju170a1r35ab6i4lsLGFcpVBP/nk1H
         qU9rcZdz4Yzj9lqeZrdLvwEQ3RYXsTAak495zhNAgbq7jYo1dDrNRI/q62EMDwDZTWFB
         j6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728220115; x=1728824915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dmx2sBdekqi6blVgKnA1R+7bIKWb4LbSOPTUFdSrnhw=;
        b=mUH250opmMDjHMg1Sf2lvEdn4btk/8ZAqHrSQYUXTa0mUawUCbxUHBQNbY5c/DKk0Y
         HkQmKUI/e1R57mMRU8EUw/c6GVX3Mu6izVeV1mtyKs7R74p/ODxSwSytI0MhKx22IsPG
         Gc2AkaVHtx1a7fh3ZHjlW6XXQkgNLR19/G+ZDAEczZkeP6IeEDYwAHNMR6WdiImnw1fy
         fZEbd6QczY4C56zX6Vyzi28hlepWwj7kJC8zh+Dz7XSgIHZ+UX+mrmGV0HD80zKGLu9z
         hQ/tn2OCl95vCstlBh8QGJc9/dIFZh5lQhaxLLhj09Q0P4W6MdgptTtdrHBVQVrClk/m
         W2dg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1N0fRtsbkSgNsYkzqDD1YC0bnCgsylwuFw/A3jWq7kfh0FC04OprdWv0+ffE0OHjuApndv5Gm0qM9HT8@vger.kernel.org, AJvYcCVoHBfTxBV4EveD61xWI3F5hLEKSTBCqlr57kYo5DQ0ZyQ5hh6BTtEaxnKymC60e3XxDDBpbE4V07s2wDCYAFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/ILFXDHHvQ7IscBeTXrW47FDCxNjh+wiB7ftAkPJO98WxqbM
	V1NMI8yKuebKC3CWWxcdk7zmVn2QitOsfdRxdG0NltwwC4QToBjT
X-Google-Smtp-Source: AGHT+IGwxivZnuEN5XKlBpvTGO230c6u4ynVhRjTSIWMFNkQWoNst0fALCWQawxL/pOCNzrlmqH8bg==
X-Received: by 2002:a05:600c:35c9:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-42f85a6e147mr74444355e9.6.1728220115311;
        Sun, 06 Oct 2024 06:08:35 -0700 (PDT)
Received: from void.void ([141.226.12.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed952asm46201535e9.45.2024.10.06.06.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 06:08:34 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH net-next v2] fsl/fman: Fix a typo
Date: Sun,  6 Oct 2024 16:08:29 +0300
Message-Id: <20241006130829.13967-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments: bellow -> below.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
v2:
  - A repost, there is no range-diff.
  - Elaborate on the change.

v1:
  - https://lore.kernel.org/all/20240915121655.103316-1-algonell@gmail.com/

 drivers/net/ethernet/freescale/fman/fman_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index f17a4e511510..e977389f7088 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -987,7 +987,7 @@ static int init_low_level_driver(struct fman_port *port)
 		return -ENODEV;
 	}
 
-	/* The code bellow is a trick so the FM will not release the buffer
+	/* The code below is a trick so the FM will not release the buffer
 	 * to BM nor will try to enqueue the frame to QM
 	 */
 	if (port->port_type == FMAN_PORT_TYPE_TX) {
-- 
2.39.5


