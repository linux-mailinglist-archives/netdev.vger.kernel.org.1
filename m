Return-Path: <netdev+bounces-69231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C84584A6EF
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480F2291B2C
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 21:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9D4B5A6;
	Mon,  5 Feb 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctCHsjg0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581F4EB31
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161375; cv=none; b=EmWnwm7Ws8zeyf4/qDnMCESYtqOJmKY5/XF/ySH86AOwRSmizSHg//xXwP9nvlQVmyTIqkm2aIUsEsmgjCgVQT0b93QSr68792h8KJKnET02QOew1VzRrvScFx4fYHkl3O3tPO2Ss3MOWSXEPuIMUNhHut0zWWV1zNvc98LEkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161375; c=relaxed/simple;
	bh=z7NL4Ojbk0fuXG6PzZ3Ih5Li86YoEV7+Cv3IEBNBzHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbh2Gf+OZkZJM1v+fJ9PBk4lNNQXGznq4QFrzJWYInMaoqs1FUAzi437Fjh1y+oZqtKohCH+Ax694NuFj3bbNooDuhrwgQ7NPTrZMs5ZfObXctozBFfQYF5KV/OrQv2m18lOza/zzq0wN7O2T4qY2HX1dMSRuSgA0baJ6wBswOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctCHsjg0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fc6578423so30507695e9.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707161371; x=1707766171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTTlKkPn5ZFx+wYzcyPp3AZcM0QMOYHt0SGvWEDOgpk=;
        b=ctCHsjg03Zu/5/bS8AzUzNhZ5exLZt1YJ27edl1Foh6sISt1F+zgZdZ4g/IHbRzp8c
         PQNd2QDRapLcVTDSFaQSNOXmPzNLdM8Tc9px3tr+qGiTkEpauZysIeU5lcO3OopCbHqp
         9Nw/f9wID7N0PO1xKs8NGN7bA8MH0vIaOW7c/FpAjHwJ2Dn5FGmGfIHw0QAf7d2I4St0
         F12ZzZjjpwV90M5IE0dUkKjXwgnc4uHMtUG+9zkaErctI28kovsEUmA0kO77c7fwcviL
         CR1eVeLTaJEKX0+QExpNQWHRm8aL23E92PFLEz4R9lx1kW6AP4eI6ItnudYpEMhBEvTc
         llwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161371; x=1707766171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTTlKkPn5ZFx+wYzcyPp3AZcM0QMOYHt0SGvWEDOgpk=;
        b=f7MPYs0x+lEQBShKTSVY5dnPnmStR4SJpXMbW6SXCbAN3Sv6bJEmoghjEHvmQrfB4T
         ACstD7NkfuNlfWWcQ3ILVgqxHJBIs3NzpbWHluexo62rSHc/TI+3+4TEpGtCyY+wqD97
         2IDI3evvdWGzZekuCKMxt5tlqWILtOXrbY2gb+RLWf+i7rpMiJkoDib3igiSV+jWpYos
         Nl8QLnNGp/JMOkGnpdyoEPBCgbPICtafE20QdF4HASGt1bZ4DG5XXakHtAuH4iTuofV4
         j25eQdkuNun6ozRlcx0UTeeDSfuV3YZXNI6+cYgEqGoLM0rMVZGHB3qWOKNWOPVfLRaP
         4Nug==
X-Gm-Message-State: AOJu0Yz5ZNuMskSYQQCINgU6OxoJcZgG3YF3BF5s/jjzyjpuzp9/k9oD
	izb8MbSX3lgv5d0GNvY2VCxbJR0tkn/2OS/1y/E5uhfc1cbrqLpgB1PBNuTP3k8=
X-Google-Smtp-Source: AGHT+IH8hjT80e6RbkKxzFHZS1ZwEkMBhzyjykXa6U7ILxIXIss0uy5+b0pH7UqYKWpOri0cT2XYBw==
X-Received: by 2002:a05:600c:4708:b0:40f:b691:d374 with SMTP id v8-20020a05600c470800b0040fb691d374mr566408wmo.17.1707161371225;
        Mon, 05 Feb 2024 11:29:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUB1yertpJSsCTOkEnxXhCiERrtVcd1guBe6OTttbYjxIZzioUbtuGZTrFvhC6b/Ko15euUSfx9Ydaz9l9UN6c1ZvtSJltuxnQQ4gr0VM4NSR2+tx00uDVdFjlpxTmMAA==
Received: from lenovo-lap.localdomain (109-186-147-198.bb.netvision.net.il. [109.186.147.198])
        by smtp.googlemail.com with ESMTPSA id az25-20020a05600c601900b0040ef95e1c78sm9660400wmb.3.2024.02.05.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:29:30 -0800 (PST)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Add missing -echo option to usage
Date: Mon,  5 Feb 2024 21:29:23 +0200
Message-Id: <20240205192923.3246-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit b264b4c6568c ("ip: add NLM_F_ECHO support") the "-echo" option
was added, but not to the options in the usage. Add it.

Note there doesn't seem to be any praticular order for the options here,
so it's placed kind of randomly.

Fixes: b264b4c6568c ("ip: add NLM_F_ECHO support")
Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 ip/ip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/ip.c b/ip/ip.c
index 9e81248ff7f0..e51fa206d282 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -70,7 +70,7 @@ static void usage(void)
 		"                    -h[uman-readable] | -iec | -j[son] | -p[retty] |\n"
 		"                    -f[amily] { inet | inet6 | mpls | bridge | link } |\n"
 		"                    -4 | -6 | -M | -B | -0 |\n"
-		"                    -l[oops] { maximum-addr-flush-attempts } | -br[ief] |\n"
+		"                    -l[oops] { maximum-addr-flush-attempts } | -echo | -br[ief] |\n"
 		"                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |\n"
 		"                    -rc[vbuf] [size] | -n[etns] name | -N[umeric] | -a[ll] |\n"
 		"                    -c[olor]}\n");
-- 
2.34.1


