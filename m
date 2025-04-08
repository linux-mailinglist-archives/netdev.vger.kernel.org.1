Return-Path: <netdev+bounces-180444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15852A8153B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23D84A4A9F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD8423C8D0;
	Tue,  8 Apr 2025 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1h0z1hz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF91DA60F;
	Tue,  8 Apr 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138699; cv=none; b=n2Vd4kk2VWnBMBdJn0HAk1d2nAq8kXJFrNkE9j4JCaOHxWwWjyrIeV+oKH7QsiFdcpVmGsZpWNqQm33Llq6h/xQ/O6ITcKiVZtAQVaGDsihPdAP9wifK5lijU2ePlQFZG6HbXw6Ruqo5ZCjAnsLtvGUkStZe/md7PXuBukUhEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138699; c=relaxed/simple;
	bh=qi68FPqjWeIImJbScaOCfWAjXU8ANBLoLMNxd/yYrOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7KBOoLLiZ7uVcmeKyIQ5oTBE/HXs5u6VpGXZmmT7HEE4y2AmNb3ZKPZdsUuVj7u/PoQSvM56o0qix1IRj7NWc4fI/x5yfKlbcn+8m83F7mAd9sCyw68p4ZVQ1LufUrq04Rlrlm8svsXRzvOPXG+EnxLZCvBFELagEUn4vWxXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1h0z1hz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c3e7b390so5637727b3a.2;
        Tue, 08 Apr 2025 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744138698; x=1744743498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzHI83MKSiqIfFaxsOKY1zS5wH4MOVgY9NicZrnKBJw=;
        b=I1h0z1hzfD14lluDBOL+UxpPMWiTgNz6baX5TCLzvoZyn/QWnuhj9zMjRJabgd2MuE
         kKjfqYw51EqoMjacptHqKalnQly3Ke3MK6vHeDtXeypYMRSmsfUO45/5IZnLDJ5nkopC
         ce7bdAHJwiqlPvYCuGw4C3e7KHQqxY35Wbdh4Gnyb1bQtC6ZXI9jAur3iyB9TT5Frsuc
         gPvckJOIQmByko8Z698z3Ue61PMQ8x4O1CTRTN1Dxf2d4nr0ATyitp8L95XdaWmDj0tw
         PQInFm/GLapPJPC/oela5nJBZd6LyOQ1bcPRFvx4QOOskXAIewg/RgsxSjV0e8ZYNChP
         PCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744138698; x=1744743498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzHI83MKSiqIfFaxsOKY1zS5wH4MOVgY9NicZrnKBJw=;
        b=c19ZDKLhd9le0fLWjQR4sU9RQnuIqj+qX/hGb4Gj3c6LE+SmWAhowfztwqbhlMf/Y7
         kiVLhEUiA+ohV4cyJUpPJpkcv03dSwZMlH4I/OftOlJs4wUi3QXOkwmEmlcYs+Pg4QdM
         qQ2S+tCVXZP0icg0EM5r4RNhNjEq2C+0M2sMd3OJx9K3p0fhyjJRGNVc1FLGaEgSkIXG
         Mhtmmt9MKL6M47Fyr2Gck2hrPy1qdDmRgLBQqfJntBLmxXEINRJJd6Enhttjr/JvUo8P
         jxNiGJeM4oZU9eUi7KqpcfCWPskCEGXRRsPNm1EGEmz5p5y6cBn/hWGnZJKpZkSEVQr7
         0crQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJV6VgE8WwUdwsvgzoHlUUGvBJ1xeP/ViGGioKSWZgNAn0NikgGv17DI2vhefje64oD5rJwEls@vger.kernel.org, AJvYcCWjAPn4fCpuiBJustVjGrio0Ggl4OwP1nIN7LFcdxdBZmS6maYJ1ZTiU5y5eIRKulvcNRIG0em7IEME21I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlkMyCZKeVFRxg6XxUHV2cGjWk3Ma9jRtkklW0OEPrbsos7biG
	+9hiG5fFPyAv3jfZWBKXYxPVNw2lqutapVJHL/7Wp5L2N+L9csbS
X-Gm-Gg: ASbGnct7a5DaoQjMfxPBDzssBwuwlkTFg+Z7EK6NJqp0fggTpf7YJyeo5x2Fn7nqhcI
	io+2ZHlVGhK6dfg6co5aM9B21XJm/Ih+ItPvy3MrSeB6coLcO8CgXm0Yrr+TY5qfXvHJskAlajH
	UfjjfpERewxARFNW8HtqWqay30Sd3kh9RrokIXD4Vl+Dah3qdAMz9BSQgmNQUUwA4GUDmn3lXA7
	ib0/qNvrQv5Qgo+eBR07qjdpQGSQ2YBwl11jcASIMt/gZRyoNYaKgC3Fj3ZfvJ9jrY/izTPvBt2
	mz2ZeFI31STkNMkD+7+jcZrt+COEZG/LYtu5pJXnXkR8smNSQ57T5qch55JHwcOFCVCOTYrodhv
	e/Q==
X-Google-Smtp-Source: AGHT+IEyktfEPtKDikhNj7ckXZr1w1jnHWGuCEGLWVYLsgrcs35m+q+VlCXtvBz1nUhwKzx3fbO2zA==
X-Received: by 2002:a05:6a00:3d13:b0:736:4e0a:7e82 with SMTP id d2e1a72fcca58-73bae4b9085mr216548b3a.10.1744138697594;
        Tue, 08 Apr 2025 11:58:17 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:5c08:585d:6eb6:f5fb:b572:c7c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0dedd4sm10900752b3a.166.2025.04.08.11.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:58:17 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	skhan@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] net: ipconfig: replace strncpy with strscpy_pad
Date: Wed,  9 Apr 2025 00:27:59 +0530
Message-ID: <20250408185759.5088-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated strncpy() function with strscpy_pad() as the
destination buffer is NUL-terminated and requires
trailing NUL-padding

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/ipv4/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index c56b6fe6f0d7..7c238d19328f 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
 			*v = 0;
 			if (kstrtou8(client_id, 0, dhcp_client_identifier))
 				pr_debug("DHCP: Invalid client identifier type\n");
-			strncpy(dhcp_client_identifier + 1, v + 1, 251);
+			strscpy_pad(dhcp_client_identifier + 1, v + 1, 251);
 			*v = ',';
 		}
 		return 1;
-- 
2.49.0


