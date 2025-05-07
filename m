Return-Path: <netdev+bounces-188785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F71AAAED22
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 22:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73F64624C1
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C3D28F933;
	Wed,  7 May 2025 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iumttYGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E928F940;
	Wed,  7 May 2025 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650262; cv=none; b=CegK/aB/56R6bFVRbMXRUrt/BCv4kLg3+HQqgp1QS4hoMSRKb8+qpMCYf21kIAJfByv7Z1SZTtE7Qx3vf+Xj+DtZcHt0j/Y4GjE345zEHphUx9URyT7f22eazW91pXjCX0AcPWj3WZAUWE4mlUabNYrRwWk6hNjAGqqUFPOTtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650262; c=relaxed/simple;
	bh=UpxWey3Bw04ZuvPug91OW+SV9bDGVrjm7kInnn7Ugp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqefDrKy8i02ax8+96Y8k5EqMtZEHE0C8WCB8CEtp7CfPoxV2d5ZDZageDDZC39fB2H5uwhMevBbk+Cb6n621d9yrQ7Efi6ePNxVJxe4grrfzQXT3n23KBxQTB1MHjGVsTN+Dx4xIIVFzuv94ajb2q86e8MKK68G/BKE2HLOWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iumttYGI; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22c33677183so3391895ad.2;
        Wed, 07 May 2025 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746650259; x=1747255059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1+zN4Yxyjl4lmJrdouerVL0ZdLm1z+cSeAbjCfaYnY=;
        b=iumttYGIpUij5WwCeF+RuqV/wpaLgDoChSH+pLLBh8RTI04b0zt+n7OqHNeysD0kYc
         xM3v7QzV5AJOCvxSyLmexVnjkJNvSPU3gOMVzYLEMryFo/ehWAq+/lj5gsfDnlEFQxMd
         f62X+IVZqk6q3WxkI85GAjqG+AZZzcP2onoWUzYhn6SC0KXvt4PoGehbU6XFex6IVwd1
         EkFdefIZUPR6qgVEc4RIYGKzGHvHIDPPQDIGqKmrqzEZoHosld1LIPA1XlkPba1TbjI8
         K5eJNTIcx6tYACJyBozJKOU/ZBdgqfyZwDxJ9qVoD9rOxsyQw/+Z2ywne4PdnUMtRF0H
         jZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650259; x=1747255059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1+zN4Yxyjl4lmJrdouerVL0ZdLm1z+cSeAbjCfaYnY=;
        b=LbpsE/3EZjO3Umrxp7BaR1uqcI/wO31nLeOxJdpL+GSgSDU1CxrXdqHjFGWz+UaBXi
         i7zPao7WVfXmBCjALvqQOXHjbLetXKklRA7YQGdnZs61KCrrPuJCs+vq1UWrmB8zXW0x
         gh3PzpgAcj1mjyUyQ58Lsf0MRggxLGJ0wfeNbClk8Zvh6lWggY6ZDdQq9QZLhTdDQ18J
         NewmdMMxS6acE0ll1aiF3qHcOYLnH/7+oAz43T6UX7Zi4oX2dlIIMnCccXkrVu+gtGMJ
         piZ6DYe46pu0Dvr3hU35Jb9Vi3solB0PQ7S9F/VFacc7+q82BQbBucH2vlVZXKGhz+Sl
         dtlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDVugObgk1eUX7p15ELlJwmpUcvkYawfS8MxO996ewDqmf0eFasiRxyuTgxYiNXV6x4J31HfrAm8ovPEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/P4+RiBC6HNcuFJM+XfZYMobB46VGjvh/j5dY8FriaBAMoNf
	mO6YhgvBrrMqKkudUaBH3u6oSbQ7jAPlZduKF7NEEye9Y+lLGbUv
X-Gm-Gg: ASbGncuj5f4+4Efv3Yg4A7loOZzamEZA1gsqb//yUt/bFw6g7ErUrBTL3Nb4n+t4l0W
	D/k23iiz/LuqLyiek2JBUwf8jcqteyGZrD5hzBM9KZXna3sfxjH5rFe8i7ZJhnSH/7jrmbWowdI
	jtBojD+sxGcdRxMyjGDmFYPSZ2/USXePftBpL9AfV63K0WOom5H0LFhh/UVla+nW6tEBwf37iQW
	Oh7kttgYr0Q815jl2WzFzPOrqprJ7Ep2+dFjU3DP7TkmzB2rvwr8fJ/5WP++MUsk2CU0zNHaqmA
	TTRk3nARydpJUibqYPE8nQe+8aH2XIrG76As+xNSExb9elzo2gQSyOAeruw=
X-Google-Smtp-Source: AGHT+IHCh/GQgllGZkJ6rLLeRRGN+OTcp4gpIRwI6kl2YE70Sn8rCja8TtxtQAAUAvKV+Xh6HcPOnA==
X-Received: by 2002:a17:903:fa4:b0:22d:e57a:2795 with SMTP id d9443c01a7336-22e5edea81bmr71012345ad.47.1746650259078;
        Wed, 07 May 2025 13:37:39 -0700 (PDT)
Received: from sid-Inspiron-15-3525.. ([106.222.229.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e62ce540fsm20193525ad.160.2025.05.07.13.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:37:38 -0700 (PDT)
From: Siddarth Gundu <siddarthsgml@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Siddarth Gundu <siddarthsgml@gmail.com>
Subject: [PATCH net v2] fddi: skfp: fix null pointer deferenece in smt.c
Date: Thu,  8 May 2025 02:07:06 +0530
Message-ID: <20250507203706.42785-1-siddarthsgml@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In smt_string_swap(), when a closing bracket ']' is encountered
before any opening bracket '[' open_paren would be NULL,
and assigning it to format would lead to a null pointer being
dereferenced in the format++ statement.

Add a check to verify open_paren is non-NULL before assigning
it to format

This issue was reported by Coverity Scan.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Siddarth Gundu <siddarthsgml@gmail.com>
---
v2:
 - fix commit message
 - Add mention of Coverity Scan
 - Update Fixes tag to reference initial commit
v1: https://lore.kernel.org/all/20250505091025.27368-1-siddarthsgml@gmail.com/

 drivers/net/fddi/skfp/smt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fddi/skfp/smt.c b/drivers/net/fddi/skfp/smt.c
index dd15af4e98c2..174f279b89ac 100644
--- a/drivers/net/fddi/skfp/smt.c
+++ b/drivers/net/fddi/skfp/smt.c
@@ -1857,7 +1857,8 @@ static void smt_string_swap(char *data, const char *format, int len)
 			open_paren = format ;
 			break ;
 		case ']' :
-			format = open_paren ;
+			if (open_paren)
+				format = open_paren ;
 			break ;
 		case '1' :
 		case '2' :
-- 
2.43.0


