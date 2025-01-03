Return-Path: <netdev+bounces-155034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B83A00BC8
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436A91884D4F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AD41FA8E3;
	Fri,  3 Jan 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XksFYb1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECD1A8F9A;
	Fri,  3 Jan 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735919995; cv=none; b=WCjsYC7Xoihvuz6kGIcm+Gp+DNx+N0oM6BDLir++OgeF6M4RD0xO01podmU4mxjJx7VR6mKsoJwvZEMB466/JsBPoMjiWHl+vf1FI4RFQodCUvBQVnmYn4uKjbM4ehl/8cVARDbIRlRLBn5UbqlPGyttgJFUlod7gthiDs1BqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735919995; c=relaxed/simple;
	bh=BY4XzCp/Xpc4l1+JHQf/V8lGcV8TSYShSIamjcrkwu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usLHDEQIlpmvpiI6ykOx5K8W9glEnQXUiDPzBtjIPnFfxpG2b/C19wF6NXGyt0GNxHHYaOhas7SGlmyrZ1tP935saLVOsVHQtcjPSjFerAqrdodeMyHCrN+C+1iRTVSqvcr2OtzZnGA63NKM+eJFwJeJNWUbPkJ2Wnb0HmH2kJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XksFYb1Z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef6ee55225so2515787a91.0;
        Fri, 03 Jan 2025 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735919993; x=1736524793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gV4JrXnngCdUeIcGvdTNDUANNvqICigqrTQBMLPkFk=;
        b=XksFYb1ZUWuvlfKn+RX2tV7R6QKwzCmbKugcqXXbVwTheX6jH8Sb8vl1bEN06IHJVE
         TMvAUDvj2nz4tzf3yUyd27LrRrAemogz20wP1VJuvInB1epvAjF/X4LrJMogZymylNLZ
         c76iPaDwULa5B4jyw7OMYAEuJeDA1oZ4b3yOWBbEI4kMDqkWWoMsMb2qR8Mr8uQYUs/5
         mL9NoAlixe9tnqeeP9Tz7rBxaqEcPMQY1knXDXTme42IOp6QYJY/VG7QEbMtKN8maPQB
         fGRKaHBqqv8Xe9SEC/SD/54hvBwwFMf7RZK2ua/HUXfx2urFrXql9BzLGmzbRIU/uRl6
         bNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735919993; x=1736524793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gV4JrXnngCdUeIcGvdTNDUANNvqICigqrTQBMLPkFk=;
        b=oUJ0gVkp/YJlS+SQxmfXrJLcGyNdCz5UJEqJhlNpNTCwjcQWXFIT072xaqH3e1cijU
         OGgFTvT0XdoDW1/AB4CUNdT6xHtAwI505woZ6By7MxancoGQ/A4vvroqx/UE3Jst5d7M
         vMUeSsQ6nK68GlKF196mNi8ZSKQ5J8XRc7Hgx3Wnycvmim3BcMr8pmbwWU+iDvnS2FuY
         pwXzE3vQI0L4qLJta/ljuYV/Mc5dHwHlNWWOMJ/i5oO69i8XzbM0goaEfogJ0xwuUofg
         NB7CTTPpoKRXSFXGvI/CgAsV8GvH9z1vZO3A3aOC5fMH5XyHI1B96U/5ZF7Bs1y8UP7q
         TNBA==
X-Forwarded-Encrypted: i=1; AJvYcCUEo+s1yOuTUxfQidHPzmPDFhOnwPF0diAjbrbQNeN+uizwofYt/OdAFQqvIWltzxHbDXAClKCY@vger.kernel.org, AJvYcCVry6GyKXWYa4hKPrP5IKXzDKvz/CVyIz0B6JeZqUcrBCC2KYmFFZ4fciKnsrCrD02Oadp1PqTF0t4LtoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEOWjf6PKdFOUnSid11Y5abwwy4Vteko+nNlOx1b/MNSAba9Wg
	KWUGjHIiVwHum1TDtWVRXjfMrmqt5Cfc+HUa4Fj/opOMyx6bcF5P
X-Gm-Gg: ASbGncvq0YEkINy4K5oeUvUk7xSna0x3h/er+EKvn4jauboqwrQwqL7KT01Guy+rnfh
	8IYycsfMFOOYw8hsHMt8Gz3TUaydfwmGd3GzF+Hjw5BQ43H7uTjauaRP55PRMWBJ08XykpPSmGx
	BA7io+uISWk5o3Pa0uL38EJZCPA+DF1Cs57ccJcl9ks+OQp2OdGkkXMp+s4OcDH1WYQL7HcceoY
	ejlrzCF4Hk5XbQyZUNcdQ8WrnOnF0fI7s10faAmNvwvKE8Y3CKpBQ==
X-Google-Smtp-Source: AGHT+IGzgwdYjzESvFQtWckEGUzHKryn0ey7FziwWyTcpxYolLVaEcex9fW9p251ExnR7NtJ8uaV+A==
X-Received: by 2002:a17:90a:c2c7:b0:2ee:d372:91bd with SMTP id 98e67ed59e1d1-2f452debc95mr27082913a91.2.1735919992740;
        Fri, 03 Jan 2025 07:59:52 -0800 (PST)
Received: from ice.. ([171.76.87.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52cf40sm33581706a91.1.2025.01.03.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:59:52 -0800 (PST)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>
Subject: [PATCH] octeontx2-pf: mcs: Remove dead code and semi-colon from rsrc_name()
Date: Fri,  3 Jan 2025 21:28:26 +0530
Message-Id: <20250103155824.131285-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch-block has a default branch. Thus, the return statement at the
end of the function can never be reached. The semi-colon is not required 
after switch-block.

Remove the semi-colon after the switch-block's curly braces and the return
statement at the end of the function.

This issue was reported by Coverity Scan.
Report:
CID 1516236: (#1 of 1): Structurally dead code (UNREACHABLE)
unreachable: This code cannot be reached: return "Unknown";.

Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 6cc7a78968fc..f3b9daffaec3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -133,9 +133,7 @@ static const char *rsrc_name(enum mcs_rsrc_type rsrc_type)
 		return "SA";
 	default:
 		return "Unknown";
-	};
-
-	return "Unknown";
+	}
 }
 
 static int cn10k_mcs_alloc_rsrc(struct otx2_nic *pfvf, enum mcs_direction dir,
-- 
2.34.1


