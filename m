Return-Path: <netdev+bounces-167051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2EA38903
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC02188747D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4574D2253A5;
	Mon, 17 Feb 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyF6omMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181722259C
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809339; cv=none; b=hbs8M8gkRkSBeAgrB4I+VUsK+/hpnyKC2OqE9q6k9JET8T68nexUDYlpU8A9TniMac21y79Nb8gREVNR7ZdlFwSFVjgF2/vLokpJWvnT4gT8Nes3qYW8dbKDnQTAiCEdr3+8nDGTeYNzTaxoK+0p2SjARyUZ9JJBf2pTQDhzzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809339; c=relaxed/simple;
	bh=KIoynSTrGPbwBhubec3dWE+Kk/BFWUsb1nYs7nKdIV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b5xUnUbheqEIcWAEWGxGXFqVsjYhbDK/zeeRfQYCoyZ1jcmTvWebjSV+StvxsvjlKCPsZh6BDEQ/iGCKaGPWv0BeIHWTzfrKLKBsty0GB7St8Nh0wVhhMGlmoX+T/WK9lZkNbeoCKrKII7qB7zlndcKoLnd0WZ1YR2KlArwKQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyF6omMw; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30737db1ab1so41564111fa.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739809335; x=1740414135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASrEOVQkEZPh+kN+v1J+KP132rtpIrDrnqwoPnNxMqo=;
        b=KyF6omMwqPV1qj0QmBZ96Bd7BYljFutFAVagd0ResMWZnv0w01x101s/JzuqAg2hC9
         kQIthGeChlHvdvKxcNx7+W3n0bh3uPb+v0MOWAj+wO/p/1QBmC/gXw7euPbCVD5jztZW
         Bor+JSy99uqYmBPa0RVPP/7kXXMZOKJVVM8x7m1VTDVV14X1s5ruDY7Ud6e1JV85nHVw
         77ImIpqhxDhAz03FocyIUmdNHdAyUrdYM4BST4zKwOnHuS/jb0AqI/q8krW8TUhBhaNV
         9SHJTUc7LrY5tn5rttvXKMRCkDz1PzK6WoyXuJpPmrAMjy4wPuTu9N/hpeX8PnQQu0Ou
         XpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809335; x=1740414135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASrEOVQkEZPh+kN+v1J+KP132rtpIrDrnqwoPnNxMqo=;
        b=gmXQLY6ciwMlx1ChnuQKCCf0nquGKxfDQKZYkJKLOotsICbCYCON0m9uOPHesbtCYo
         VgkvZng9nHM5OdWGOFd0wHJWjg94rVpr5YhgXGYK2RyCPV0n4tvxzHa2v73vdcymDEXv
         uLC+ZwokqylXqzmgxVyQadlkTN6xVZfPhMijibpYt507q1AB3B+Dh34nOlQOBKsk/5ah
         U8GXbFW6D1PZO23ZZECCGqdlB9amCSiOoHEAJbQN4+r25yfG5XSnP2/zMFKtBAC4wzPe
         H8JPaWoeN9x38NB1atiICt770jG/CWoqy15iRnWp6Ef6NAxf/s4yC4ejx3jTuPYae+fG
         T5dw==
X-Gm-Message-State: AOJu0Yyv2DjeSqDP317Ry33eGzv+omwqHPKxL10pRJdH0Kdb4KdBinfK
	OlMPwREDFoWp7v1nAtFFDv70CiqvViXrYB3HIXOY85RB5zo+nF+k9Xk+HSNX6I8Pvw==
X-Gm-Gg: ASbGncv2XkKw9GV4I2UuRMfnykP19STQpDOUjF5/MsQd3cUig3S85o+tGOv2/upmcgL
	Qa4c5xBsdxHC0EwUUNx8Dxb7uxoRxA5MgOBOtrhSTivss+HpQ5jQu7Gv8LQnK+8Z1SyJSrjqIZq
	hqnukHumklJHrR+9S4EqEEfr1Bh/xM2VESDMs0NoZ4Kf+kBbD/tVRS35XNZcmk6ykbyETrhyhqp
	QyuSeXVLOFwnmMqHfCODYy7UVA6b0myJf6Y/qPEUkj7W2BOh1cQRPCUOoJHWklphrT8Cq+Rn8y2
	PJLubPx8dx4mQwvFNTZ5JJj9MzpT6oF6mA6iFyYuxrZ8KXb8BbM/B4GNflAUhEaVfMJfTYi3
X-Google-Smtp-Source: AGHT+IHcBSiiqx1P7B/L9av/WPontHY2BVJxJGldKPsxPf/ScRzgPqFNZmcdO+XIvVV9whda0RhQEw==
X-Received: by 2002:a2e:b607:0:b0:309:bc3:3b01 with SMTP id 38308e7fff4ca-309279833e9mr25894291fa.0.1739809335129;
        Mon, 17 Feb 2025 08:22:15 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru. [109.252.121.101])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2794fcf2sm6817331fa.51.2025.02.17.08.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:22:14 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH iproute2-next] ip: handle NULL return from localtime in strxf_time in
Date: Mon, 17 Feb 2025 19:21:51 +0300
Message-Id: <20250217162153.838113-2-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250217162153.838113-1-ant.v.moryakov@gmail.com>
References: <20250217162153.838113-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer reported:
Pointer 'tp', returned from function 'localtime' at ipxfrm.c:352, may be NULL 
and is dereferenced at ipxfrm.c:354 by calling function 'strftime'.

Corrections explained:
The function localtime() may return NULL if the provided time value is
invalid. This commit adds a check for NULL and handles the error case
by copying "invalid-time" into the output buffer.
Unlikely, but may return an error

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 ip/ipxfrm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
index 90d25aac..9bfd96ab 100644
--- a/ip/ipxfrm.c
+++ b/ip/ipxfrm.c
@@ -351,7 +351,12 @@ static const char *strxf_time(__u64 time)
 		t = (long)time;
 		tp = localtime(&t);
 
-		strftime(str, sizeof(str), "%Y-%m-%d %T", tp);
+		if (!tp) {
+			/* Handle error case */
+			strcpy(str, "invalid-time");
+		} else {
+			strftime(str, sizeof(str), "%Y-%m-%d %T", tp);
+		}
 	}
 
 	return str;
-- 
2.30.2


