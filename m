Return-Path: <netdev+bounces-109682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67BF9298B6
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2CA1C20749
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509620319;
	Sun,  7 Jul 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFs08Mjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D793DB89
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720367376; cv=none; b=hEhmlhVf48kf7HhsvoK0K5SKXCjvwG7af+aqr/NVJNSkgxziipMZYGUwlbiZJuJjdgiXTwpqhm1O25ltIzg8ILkWiOBRhwZhRCGMPbHCetzF5tbcJgaPD20YtB+HfGCvM2YjiURiLcR6+IqjQzsa+4u1tJxBLiWvxmd4tXnd3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720367376; c=relaxed/simple;
	bh=yBrCkdYFiQ2guIUbAEfOCogNE20QT+kpPkdWnqKvAcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uKaJZNQpZfEAbsysyl37xkA6p+yOP1ikOuGxkVrSdBkiLiqcDm7JSCUuzeNeMEaKTHOzG8Hu3r8Ne8JT2SQFgoJHoh7SXtuFHl+R8sCkY7u6bDD0jN78yQZfca+9t8C4bQeBT1nzJ4j5bDn/YZcsD2B1ZVbbyuaEUHITJyJyG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFs08Mjh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e9a550e9fso3583854e87.0
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720367372; x=1720972172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Sc4sSS8LNOhoLq1ww6yWKbh4XfmWNwcSuCrYKpnUak=;
        b=YFs08MjhjC9WQjYSeTX+BK416/YcQKDL5lL6B7i4Aow8uMDawozIGcVjpLMivDKBEC
         1rSBraieBnZFN2nSSzfNQ+JGmby+sezZJAEYe1o3X3znOHHFSOSsKB2zkj/Xtax258Df
         P8FEu1f53OxDOM3LBygKA+oDUSxfsdbRQjMo/XNHzE8tYGAQWDsNgf9tW7rnWQ5X9P3G
         0avposLp59ZnMWF1FPzMFN2dfenO7nrZjnTtBXNZYKJYg262BqdCDmfBPPwigQYCzMvk
         tW5xc50ApwfNKNHlz3XELcFfhzPXjWZW61IwCVi6ddYcg6lCoAMZ+UOyEiPmXm/gUVz5
         f/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720367372; x=1720972172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Sc4sSS8LNOhoLq1ww6yWKbh4XfmWNwcSuCrYKpnUak=;
        b=aqe9E/DwGMbsIh0ayW6AtBDy7Oyd4atUtP0k9DLNZulArJQPLQjTRZCjzHUe8JmZ0C
         gXoAw3fwNjyx/jC89FG7tBFXbh0joFJXJG0cIkbJ5v8ITsKpG1vPPr1Bvq2Mxw7L6TP0
         7n8X52D6yZZJHAQ9vlsb0QRYkJrob4JGhec0G+KD8y7BW+vCdvyRa1aeo1O99XK3jz91
         jiOGz7ni09xN3JHeCwkPfM0K2a1wj/4S0HGAQSlsHjMdlhavVswaV00N8IgP/tPYJF5t
         y1u3OKqDt+BQnUKRW4LqDFoDpss/p9gInuAAGANMV2OhrZwKmuK2vsyxT+42wDBUWLgM
         zYrA==
X-Forwarded-Encrypted: i=1; AJvYcCWhYIjqt58LgEr+2fKPxs1pQ6N64JoJubhApd+pGBAYxhcak1s3AyqeMZPF9yClBSudoCnVXxpYFxwkGkPkpxR4CRDx7/Gr
X-Gm-Message-State: AOJu0YwdEPcIYE2P/0u0sQS5E/Y4kxZtMVHM54PZJu5LHiMd09vmGS5q
	oz+YAicnis7TNzWfXsfokSdlRjD891j8RuZhemRYsWQYw9PWIaPWejcyUg==
X-Google-Smtp-Source: AGHT+IFqiVz5/LUi/KtlChey5M6DbTJpoplFFFbu46AsYMAX2G46/L6T8/sNXiPcZf6Gzlx3seapOA==
X-Received: by 2002:a05:6512:1149:b0:52c:ccb3:71f7 with SMTP id 2adb3069b0e04-52ea0de40c3mr3836792e87.9.1720367372206;
        Sun, 07 Jul 2024 08:49:32 -0700 (PDT)
Received: from lnb1191fv.rasu.local (95-37-1-112.dynamic.mts-nn.ru. [95.37.1.112])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb10e19aasm121791e87.36.2024.07.07.08.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 08:49:31 -0700 (PDT)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] iproute_lwtunnel: Add check for result of get_u32 function
Date: Sun,  7 Jul 2024 18:49:28 +0300
Message-Id: <20240707154928.20090-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 ip/iproute_lwtunnel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index b4df4348..2946fa4d 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -1484,7 +1484,8 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 				NEXT_ARG();
 				if (hmac_ok++)
 					duparg2("hmac", *argv);
-				get_u32(&hmac, *argv, 0);
+				if (get_u32(&hmac, *argv, 0) || hmac == 0)
+					invarg("\"hmac\" value is invalid\n", *argv);
 			} else {
 				continue;
 			}
-- 
2.30.2


