Return-Path: <netdev+bounces-140945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08BB9B8C31
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E69B2176B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 07:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C6154BFC;
	Fri,  1 Nov 2024 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy41UKK2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098B134BD;
	Fri,  1 Nov 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447177; cv=none; b=qDIDIWhGfLacgFmwG+OK6T9y2aP4+4U4brz941k7ooznNd9WN3L2t4+66JRIywX9/rLpm0MQT9b/SLZL8NuZvbyD9GQzsnT/LkB+tc7YWs8WPoH6txxRtkCdfIZNinpm0YpoOJkuz6bwb7W8XQ0b4DfYJR3dzyIfpL8mkIXKJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447177; c=relaxed/simple;
	bh=jH/nLC15YkRExpP3tulUiqJbd/PDqSVRlZXKxTN1DxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4sOwnzQBaxkGdNlimGl1FpFF3OFQdIlJs6DGUHjvcKM+MgIyGDb/dFvmtlOF+Ziz0b64Q5N+ey+SMA4RDfawmco3/X9lL3dstt5iJjY1ZkaPmTbLjAppA8IPBZH7bRBxLbOGNEwfhd2gNuTEWKMGZLvjghemo4nCigs3j2HIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy41UKK2; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7181885ac34so865071a34.3;
        Fri, 01 Nov 2024 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730447175; x=1731051975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJtSUcpB68z8zWiNNK4MwRVeVpoZZtUwSySXvd4AxyI=;
        b=Fy41UKK2OlVzcNogKsYCYc6fV2uNLTlKiXjNFSBGYqhvh3dUIDFsba2WipfZu5luWO
         VfemZ7qMf5HaaOkks4chbfJnu0GveKHyg8hJ0b4kheOBUvPeVRbSVRE9gHKvlPe6qmI/
         bx9FIDMompFtOz4c0xUZYWnWUflbsoZ12pLt2GLvogoNqozm4Fhcz/Un3rx9lU2/cBOO
         PjYXu67+7JK6jzc3AD+goMQ94Hm6fVNRXEB8QhBp/B5tZ+ryr2Cnyeo/wUTKvJDilc4W
         CTmocdvKk7UeJ6Dg7y6PhBGytrq3+H/eI26GO39qaFTS+sP2+1Tsu/U6vr1N/iruzrwR
         GQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447175; x=1731051975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJtSUcpB68z8zWiNNK4MwRVeVpoZZtUwSySXvd4AxyI=;
        b=RUqEIGKsk7Rq39WSZsRGMvvFjn863ltBWjKVG6qsD/fOAQ2kGsImFgYX+wI4ELuo1R
         7r6QizW7sS6OdMgsH/NSlfYc8CNJNFNshqmbA4McUleSrFh0tQrB7iYRvFDDcMhHNWbw
         KNgMLRIPUTq7/L9IXjXS2buFruWrANJaj9PRdfAhfC/PySGQBimn6RBn4cq8K1yHtbvf
         5h7Xlcj3w9RDXfVsq7XaITrdLjOLuU5kdpqYOC+2NrOPMFpe9xAVnQO4urfswnDsx3gV
         hksx1TGGgTuodjThlSt7huJ+MU6SwvJEKdWGNduAZ2t56JM2nd0Xc0ASPPxL8XFn/Z88
         gihg==
X-Forwarded-Encrypted: i=1; AJvYcCUOtXhp6kimLAez5jD2iWqRyPQBvlNIy1SN1E6ENDsOeVT9XGgzvXroczNPWqTbnSrYS0pXzeWeaN+/Xvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynANukGCuMzSBVkQ3YG0U1Su9wXxqsV2CVF4FjJrtthz/pFLUe
	f7LT/evq8T0Jd+nUJLjnC9sIhCfSBQ1Lmwb/rJmJSKwRHoC9CZbi
X-Google-Smtp-Source: AGHT+IHWXaZr60rymtWZewJXiehr0u0BXjdpxKMaqqRaEKnPi1OYPTN849axfJOCh9sR7Cwr4m7Q9A==
X-Received: by 2002:a05:6830:6309:b0:717:fab7:f7cb with SMTP id 46e09a7af769-71868285d37mr18325376a34.21.1730447174747;
        Fri, 01 Nov 2024 00:46:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:250:4000:8246:8007:bb90:49ad:3903])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a9480sm2028920a12.35.2024.11.01.00.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:46:14 -0700 (PDT)
From: Gan Jie <ganjie182@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	ganjie163@hust.edu.cn,
	ganjie182@gmail.com
Subject: [PATCH] Driver:net:fddi: Fix typo 'adderss'
Date: Fri,  1 Nov 2024 15:45:51 +0800
Message-ID: <20241101074551.943-1-ganjie182@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo 'adderss' to 'address'.

Signed-off-by: Gan Jie <ganjie182@gmail.com>
---
 drivers/net/fddi/skfp/h/supern_2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fddi/skfp/h/supern_2.h b/drivers/net/fddi/skfp/h/supern_2.h
index 0bbbd411d000..cb0348655aec 100644
--- a/drivers/net/fddi/skfp/h/supern_2.h
+++ b/drivers/net/fddi/skfp/h/supern_2.h
@@ -341,7 +341,7 @@ struct tx_queue {
 #define	FM_LTDPA1	0x79		/* r/w Last Trans desc ptr for A1 qu. */
 /* 0x80-0x9a	PLCS registers of built-in PLCS  (Supernet 3 only) */
 
-/* Supernet 3: Adderss Filter Registers */
+/* Supernet 3: Address Filter Registers */
 #define	FM_AFCMD	0xb0		/* r/w Address Filter Command Reg */
 #define	FM_AFSTAT	0xb2		/* r/w Address Filter Status Reg */
 #define	FM_AFBIST	0xb4		/* r/w Address Filter BIST signature */
-- 
2.34.1


