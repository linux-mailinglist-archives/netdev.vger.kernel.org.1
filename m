Return-Path: <netdev+bounces-71518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F314C853C5C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 21:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50C028AD06
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 20:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729F60BA4;
	Tue, 13 Feb 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtgOJIX5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED9612DC
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856863; cv=none; b=a9w8yWG2fEnIOIdqZPrWk+1CSp1LumaFUF4LcurTmYs1tNZgQaffPTWHb0vqYp7i7znhKGIHjLoVkkhBuG2u0IBFZDXRxL+V4xrOEeEEV2+lv7kuvWFbdCeCbkvGLzVZRqnmSh8ZnCl1VfCzE6oFCmj7nhW8hdkh+C2Rn6/4Hyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856863; c=relaxed/simple;
	bh=wnGMXO1yWL0/s51sS5dQLYCUTPYqELP1cR19VXEmK9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYOMyOp1s4qTKkQQdf39YUhw0pQNuLaKiittqxDc+KkviiV4wbOhjkc2tp7Zz3IxkQHAQcgmis3+Gb++C+8vG8S/JBWJDr1WFN2e8tg9ZV6wrUVxN4PFTy5GusF5/4f2Bvh9Yua08mO1Kvx7LO2efMteR9C3mWArMXC67SIq/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtgOJIX5; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso57371981fa.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856860; x=1708461660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVN7WZM1vN11/9aVF6RRCVUAgbFWXc12sz8wzPGseAE=;
        b=NtgOJIX5COGJrQywHgY1kLD0KG0WQCv6eoEFKotmDZmZ4BDYf9w+1efuLcNYt0yhxS
         Z+St5EA/eiez/2pisVUySIX/tVCSvZinBiGMGRo02ERJ/9a3IG8lffZyHVzRSUKZYfVT
         htDgqpq4Rl5EjjAOxJHagrcLDsZT0sO3skQ2ZFK+OF5lrX6qrfbw1Kak69mUzwh8j7+4
         B01ZMvbq8f+TfrsJRIpVbUP2UpmcqC9tnKw0Vr5mBVqhQ6BaxPfsH62xlBLpetY4sw51
         MV+lEHCqgYOK9WjKC+ppfbgmX0WvBZySdZNtHzATrij0aQKr+YT6jBzrb+2iq3XOmcwr
         Z8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856860; x=1708461660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVN7WZM1vN11/9aVF6RRCVUAgbFWXc12sz8wzPGseAE=;
        b=oRfw8UsFQhkRWqqIKvYPGQzECx6ijqUz3Y5dGEGMGD1abHTPqGLKOu4d9QiSi8Pl4u
         8KfxYtO55dxpjGZzl2wqqwSaZQiKNTKqsBpUfmoUpkdcjqzcViyJD3NTZLQv3F/ba6k8
         NxU1tV8optViUWgoshAS32RIcKbF1QPnqDgGSzR/RFLwYwTUxf5GBVVlVZgrpgFKFwRD
         TT9dGTZ8HIfyYZSVy/smmqg9OgX1iiH6L/FLi7vd8tsg9S+LoJ0C1Z3B7FVMA1Untyg6
         tvHB0INltAEXNx1m4SkfQ3Bq4Z1m/fNKz2lPKrmYM2/84JZ6snkGsUQpptg0fL+enu7/
         0TBw==
X-Forwarded-Encrypted: i=1; AJvYcCUPyJ7SMTy6RbPScPW+mnEqloQJPSCWdscIicZmVf888ibPHqHyV8P08D5Rwiqm8Ngxhm14IrY16O/zPiNAecDWg+DHuwZf
X-Gm-Message-State: AOJu0YyELH+BKKggXMF5qjrV8XKy0eZ1TU9Qil8m7EtUDpN0rOqrJ69N
	WOr4Q3+kExBKqT3D4uQtmYzVV2pUvM1i82Ipy12efYw64NgD9EgH
X-Google-Smtp-Source: AGHT+IF2gX2EzaZnpKWW5iwSUQiRDgWa34G0QT387j14XL9wJtZJDRJ1/HZ8NMPi+uCW1PBoC5xp1g==
X-Received: by 2002:a05:6512:55c:b0:511:9c3f:7b69 with SMTP id h28-20020a056512055c00b005119c3f7b69mr451904lfl.28.1707856859686;
        Tue, 13 Feb 2024 12:40:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZvc5N/r4vqtd7bCokTKpr3rbCTFfLNhcWDA+drig36QBNuUb78K9z5IHAspUSK4yWkONVo+jHbHt8UCR0sfoxoh1v5K/4
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id d11-20020ac2544b000000b005117d40d658sm1408193lfn.140.2024.02.13.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:40:59 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] json_print: Add explicit condition in print_color_string()
Date: Tue, 13 Feb 2024 23:40:09 +0300
Message-Id: <20240213204009.13625-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added explicit condition for check `key` and `value`
in print_color_string() to avoid call `jsonw_string_field`
with key=NULL and value=NULL.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 lib/json_print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/json_print.c b/lib/json_print.c
index 810d496e..a264614c 100644
--- a/lib/json_print.c
+++ b/lib/json_print.c
@@ -170,7 +170,7 @@ int print_color_string(enum output_type type,
 			jsonw_name(_jw, key);
 		else if (!key && value)
 			jsonw_string(_jw, value);
-		else
+		else if (key && value)
 			jsonw_string_field(_jw, key, value);
 	} else if (_IS_FP_CONTEXT(type)) {
 		ret = color_fprintf(stdout, color, fmt, value);
-- 
2.30.2


