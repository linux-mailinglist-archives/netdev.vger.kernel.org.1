Return-Path: <netdev+bounces-227649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA7BB4BBD
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C863119C85E2
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB2224B04;
	Thu,  2 Oct 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVGTfPfx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AA199BC
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427189; cv=none; b=KaQ+7Zi3BydFgqegjxJN47+JjGNNQaRVsy2xRXxkzLx9InoOfqFtlLSiIN1mRXEEcJcvFULk/sp0v7CBzu8/xdA9YTM9iqsyyfJEyRyJIyhpLTjRQIZJwooueEJS8mrsRsikza0Gn99HMakaFhtos7AAjLfJ6Nwqbyb3G28yqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427189; c=relaxed/simple;
	bh=d8JhIBf9djcZXIfnCciHGMpxUiYp6eLd6xES6V8e5b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pv0l3Hd9E3qlTJ5PTt5dIE5/Xt/FCi4b6psFMUnAWvXSChdM3FMA0urnNRdBsMzMdv5jTiDVbFANNKpqhHxos/fjZgYYVUQP3Lz8AKDyT52FTS6zPnP7nEXOZAD+3OJhHH7wyfAFQ92qoaGgXKB8Adv5e5JqRiE7y2vR5kZe3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVGTfPfx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so6461375e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759427186; x=1760031986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9sNcmKDNcl/Dt3ZzxXXGUrNG+YQTuMkF7kiQoXtwf4=;
        b=jVGTfPfxVhVMhkmsDF+t7oSZfg4gnmuGPOwpaeSwkFBUD/50nnhMYzq0Cnt3EZN8rm
         OgcjZt/+08HKhmT6NKfQhNI+tiYtg7pcN2cE9un/y1+fR0kcagV6ar5d3r630WiFTXQe
         Qm/uWOPnnUSGG8CwRj2bVsBawLAlUe1Dd1B6OqK8+6wy3IJFGkRaBFjfuRS84jsfYfbN
         VVawYtsjuxCMBWwm19qt1LD5XYR+jGo3QwBO5dfUroy8Z5A7CbRd/AyMqK9hXY9rue1j
         KklufSGQzC1CUq6r6qPUkNaV6v+MAvx/zLTZnNDzsIqKJ1Zbx89fCoe6B9aa+91OCZ+4
         +Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759427186; x=1760031986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9sNcmKDNcl/Dt3ZzxXXGUrNG+YQTuMkF7kiQoXtwf4=;
        b=PYERa5AXRPnMkRMMPHov3+hkpKh6JuxGfpa5W4hVE7jE4nycNDrzqjnXmLHKshw6Ew
         ZX3hjBXtRmuHuDcx4415tIzZer4N4VEzMSmX0lKCR3y3/y3pdrfr/jzD1qAjoDCrTui2
         FqBImgdDB28fdRpWAJIlaB5T606/cD6RTNRpClaZAhI3EFEZdk/+WJe77VIB5ZaOMoOA
         jSz81ts1mVVrZJstccxwvwjeMQYURhYdA4+mbqrib/88mxHQaNVjV6FCkdmrE6zkjCxz
         dMJaJiVG1ifcuI6MRjk5Dt6HICUaBYSJpvMv01iLFAcAEvzSBv2Wk5nPtN1E1wRmMnCY
         VSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJmeEuP9tk0mub+SSsEYv0ao0Pzzdhryvg4DO5ZcHCJhSmq9h7HyZFf9E38nxYTszTfPc0Jns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jeRLg7EIcPA7UexVrfaP9fBEg8JOaoPqwFrJAv30+nmvami4
	DIeBiwysLCA9UzDxgCMULZ+RDjgtGCpDK1Yd0+ILUXuMV+waRNBLRfFO
X-Gm-Gg: ASbGncu6zMm2P+L0l5MurRcXMPpHDnRVCHMEoDaG28fGxUqJDdrNQcKVKSzIYMJECYv
	k1IFRHXSsUUISvYxnFC3Q00xtrgkWllN7zRKGlsKUOIZWLpwrYAks7vskj8dCoNctCePSYf7XcP
	5bEQGLmkQI8JI/NTwlLjwQkidhVDSJYiJr5StXs9vd/Lx1JDtcguL9c3Iocfa2Nlt1Q68jeqOFw
	kd867sjYepjgl8GTEbTbBJD6WuFzpPcaAZT2vJZYb/vl4fB3mHzo11pulQtt/L9VZrGzTz/lVWJ
	BUlZtUhKQ4qBHGdUhK/3fVl20DxQCEbU8ilQbCy162zlK1zi/c+ECSJX+Dp+z+HJEHnNu8g5YKC
	tR8c+KR1ZUJkLIKejMG3KoGTaFywlXUz64yiN7ixc1w==
X-Google-Smtp-Source: AGHT+IHDGwwW7vV9OjeTKcYO8fMtxK6OUhwxnDACT7Snh7gOrjwK+iCQOUA3HzoB6hu+zfULqCwkWQ==
X-Received: by 2002:a05:6000:2c11:b0:3ee:1296:d9e8 with SMTP id ffacd0b85a97d-4256714ca6cmr97372f8f.17.1759427185491;
        Thu, 02 Oct 2025 10:46:25 -0700 (PDT)
Received: from pc.. ([105.163.1.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693bcc2csm43640665e9.12.2025.10.02.10.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:46:24 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	david.hunter.linux@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] net: fsl_pq_mdio: Fix device node reference leak in fsl_pq_mdio_probe
Date: Thu,  2 Oct 2025 20:46:17 +0300
Message-ID: <20251002174617.960521-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing of_node_put call to release device node tbi obtained
via for_each_child_of_node.

Fixes: afae5ad78b342 ("net/fsl_pq_mdio: streamline probing of MDIO nodes")

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 577f9b1780ad..de88776dd2a2 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -479,10 +479,12 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 					"missing 'reg' property in node %pOF\n",
 					tbi);
 				err = -EBUSY;
+				of_node_put(tbi);
 				goto error;
 			}
 			set_tbipa(*prop, pdev,
 				  data->get_tbipa, priv->map, &res);
+			of_node_put(tbi);
 		}
 	}
 
-- 
2.43.0


