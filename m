Return-Path: <netdev+bounces-170716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B9FA49AA5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C713BB068
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7826D5BF;
	Fri, 28 Feb 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeWx7vqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AA26D5CC
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749690; cv=none; b=PMvKQ/Ay4f+aH+jH/4gyTqD5P6DHzhI8xtBleFcVBMj6h/z2TJ5XKK32reFf6zyyKIfPE3tR1H7s+bR/leKwUGP/R0gvQiDqcwHLodkrEUKTFYotBRnjXyf6kQpjihdr4JZ1l6CpfKCxSTiYdJyopkYOG76fqk1kMNhMjk/8Siw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749690; c=relaxed/simple;
	bh=fM1vGbtn9BRrqauH7jzB0nWHvk07pSjPfl12eOWKxfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvrjGmVjLyqdiczH1gx/lilKRcML96S5Irw4y99p1GhdlRCZM8rTnrgZprvAmDL+XPIzU8ngfzdLhNT8J4ybH5chL8+nN0T6xknxwxoSwWzzar5748lJaUxUly7L7qdG+N82Mh8VSOyCj8wZokZgjXwQQIQhdDuJH7+MdZCbGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeWx7vqy; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30b8f0c514cso9993271fa.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740749687; x=1741354487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZe6QW5+O7em4pV86qIKjF01aAF3X24U/srLa/IV/aU=;
        b=ZeWx7vqy2QhGO6ExC9vtEPWNFbHSwutqCFB3gqRs6J1hwNWXtOghgoJIkbmygdmHsI
         AEHYGbJbfsiRwHJDQf0TIJwh2S/yfo2RG2S0eqgJ+pigS4YYfA4UvhtUFEwOG8DGwCX7
         55CoMxooK4A/l+mXb+C8KoXno9fZnfNVR/vk8HaIAjV6qGtnazw2W5S7icHe/o8T06ZX
         9htR3odLRdOGVz+4wPk+Vx+952DfQeRkvPw3WbLWg5s4X2bStRKC8b4lw2R3eHPAYyob
         NCzEY6DouM/DpjQbyDkqe3z+4IdHNBzZVPhC3drx6/HLmNRpJv9mZz8cAVucmC0/KNMe
         WgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740749687; x=1741354487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZe6QW5+O7em4pV86qIKjF01aAF3X24U/srLa/IV/aU=;
        b=Mrbx0UuhrQi87BzrnKXEbjnHxJUV660S4XTGKnjySjAhDnvqAuQ2cWCSsyYbnJXW01
         dshjlPlRwSTiXBaXpT02Cs2Smk8K+tQ32j/Ps7cm4yxzliErX4EOXgzUIB8vEOB6EB8p
         g5Gu/l61+trgynYcxdHXHGRKaS24445EAl/nnw/wNtwCS/deY6+1M03wbo0u+RugFipG
         8onwH89PUnSRDXkUh4dqBDPm6dgFN29HD1M1XQvSE/zwiKbXiUPmWi5rzviP9ekE6VBv
         0AySVNuwMvWWTliQVI+XDIedeaCjv9ca9Z3rEXRDbM1Zxn3At5Xl5Mm6zgAbTZLb+iLd
         TpAw==
X-Gm-Message-State: AOJu0Yxz7Hgpb8OoxZvRmDIPuXU6R5lN0Q25qEdo7OfeFaLFWGPr7hdP
	LR+xP53Cn27pzmpjjcKMHyMxpH3YVOf2PZJ4K7F8oDKs1QyM/PWEhPNUO3VSlU8=
X-Gm-Gg: ASbGncvLaxSV8TOTBPWM5L5ShutA0iAYp9TKay9aTE+wFgxxv7LDEulMccAWMjzph9S
	vjFPZB6qKGpbYJwLZJWQnnVlSnCwwGAvEI4BfG3iy6Dqv/3mKyse1fPVAwrZxqi8IFjniFOrIK5
	vne1dh1arnr/byJf/0DYkNgkNx0mClqBXTNIhn7UyzU2ABp5e3wVcqNo+VxMGHmytCGBVWyW/0n
	JOloA41H7SOcGE8Y7EIZyjwAzRnwLFDhquQEalG6vAju8WicQYhvtbCAit548XUBaL+l9MXH0m6
	Qt9jP6Qi7wxrssjYCdGV3X3e0Q==
X-Google-Smtp-Source: AGHT+IFX2Zs6lrn0UuEELdnNGIKp3IAGsZAPhdnC7P0iel+GGDXg3THQd/lNb8l0JwcOAoivCIV0nw==
X-Received: by 2002:a05:6512:e8b:b0:545:1d96:d6dd with SMTP id 2adb3069b0e04-5494c330ae4mr1151751e87.26.1740749686484;
        Fri, 28 Feb 2025 05:34:46 -0800 (PST)
Received: from X220-Tablet.. ([83.217.196.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443c074fsm492361e87.204.2025.02.28.05.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:34:45 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <kirjanov@gmail.com>
Subject: [PATCH iproute] libgenl: report a verbose error if rtnl_talk fails
Date: Fri, 28 Feb 2025 16:34:31 +0300
Message-ID: <20250228133431.20296-1-kirjanov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currenlty rtnl_talk() doesn't give us the reason
if it fails.

Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
 lib/libgenl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/libgenl.c b/lib/libgenl.c
index fca07f9f..9927af84 100644
--- a/lib/libgenl.c
+++ b/lib/libgenl.c
@@ -58,7 +58,8 @@ int genl_resolve_family(struct rtnl_handle *grth, const char *family)
 		  family, strlen(family) + 1);
 
 	if (rtnl_talk(grth, &req.n, &answer) < 0) {
-		fprintf(stderr, "Error talking to the kernel\n");
+		fprintf(stderr, "Error talking to the kernel: %s (errno %d)\n",
+			strerror(errno), errno);
 		return -2;
 	}
 
@@ -103,7 +104,8 @@ int genl_add_mcast_grp(struct rtnl_handle *grth, __u16 fnum, const char *group)
 	addattr16(&req.n, sizeof(req), CTRL_ATTR_FAMILY_ID, fnum);
 
 	if (rtnl_talk(grth, &req.n, &answer) < 0) {
-		fprintf(stderr, "Error talking to the kernel\n");
+		fprintf(stderr, "Error talking to the kernel: %s (errno %d)\n",
+			strerror(errno), errno);
 		return -2;
 	}
 
-- 
2.43.0


