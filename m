Return-Path: <netdev+bounces-237016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E334FC4334C
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 19:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A25FC4E1BE2
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA025B69F;
	Sat,  8 Nov 2025 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rDON74Ns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D173199D8
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762626313; cv=none; b=RoDB4K5AgHdBBGlelq9gxVit0KW022Qh7aqpFXO3TnH7jrjim9ZtDYikd+EdbK8iOID6jUgkihKTDDh3+JALf3jirCHsTY39QT8XzQGdeTo5ya412Lk6Q8wG991XRDWKPXnYjGgEba0mpmMt3ignCiTTxlm79mllR2W7A32IIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762626313; c=relaxed/simple;
	bh=OGxf28Ekd12gM5+tjODLefvhvfrvhPeU6fcrodsZnxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5RY5vAjh61fBj7A3T894GD48pIt7kY6ygoXaBuAoKWncYJAuFw9+mFM+pPS/glDDZca7uGNJ9UsnDFPMsvQG3bRJdFws3J00Q3+uVeIxzgQ0Xdt/Tk3FGt2fZCgKy1Tv+/7Ckuj8QpBTJlcBpYbSegQJ6uPimyQ4nN4LuNjaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rDON74Ns; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297e982506fso6291015ad.2
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 10:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762626311; x=1763231111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQV4GnxUWhH7PFGCxN2Nr0zgy8swadymqAEd1586zsA=;
        b=rDON74Ns9jTc3CyICEFzIHM73bdux+GFo5c05x7MOI4U8uDjipLizBor1il2rEInlz
         GgN1G12P/qVidlueGJlnG6LIkuCTor8DS99DVJWLVSuxHgTYOw2mmHV0C01EXtTUP58v
         B6mAJqML/m3ARj7M95u1XyUwbLjhcrTlgVQVsSE35sjM2eAKz4PIA85ydCYreQ7dhzPA
         lAlQwaKGwwSfyZk+dqxtfeuTSEuAwlxszi7sYWLCOnRFVT7hf38G0KH+BimJz8zHvyIt
         yqqu8uOen3Unxf7GUTPzPkJhs/9+MPU9UuzseCgBPe3tzbaVZOEwJ579pjMLTd8zV5xH
         g2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762626311; x=1763231111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQV4GnxUWhH7PFGCxN2Nr0zgy8swadymqAEd1586zsA=;
        b=I/9ekJ+/Iv/Q7ESqCKqRKGxebuojPU5IehAfe60xvoD7qJHDRbvQmPl3q8C2a4k2YD
         Za7R/VBolMRiIOd8LljtKXWn1hHHLOzLqu9tKwkVltiuLO4S6LIIh86XNaqnBoGCBAdL
         3LYYSGDcSQTJhnPqDmSRQYLaR4FCMm4nPamEjPR9cjWTCQ/84MJimX7x1rf6APDN/Zqr
         L0oo0bZgcEn+B0n2fNcdw/vocofHuamwGbEKElnQssx//W7Dq7HtD/5mR0fPgv41lSDQ
         ZbInDwDKZjBmohXl+N6v+nXVm06Y7UVdzBmyfpuFSs+cRiQvIp2T4Y0Me5Xl2XKvvKK7
         HHeQ==
X-Gm-Message-State: AOJu0YxnBH5n7NvGIuugCPDoKzLQQZxeQyDj1gfJejAeuyOpOZdFunIo
	b6VXfKmB6idW/4c779XM9xqsFgwLR6nbttINO7rhadqpsMlarT2JbNMrVb8mU0zZHnZSl1LMNy8
	dLIsprTA=
X-Gm-Gg: ASbGncvCvzmMXtxvmLRFghmPfEMUMVhJqzVgXtqyRzeLLFM0aSlk1xW6AIit8LMm0jk
	joVvzMxuOSTkPRrs9zuZyS6e7rkl7LowHc5kEUQ658Nqxlw/7PEN8nneeeL73uBCVsCOjIGnggi
	zHUxZEBEkZLwt9eGVZhPzRv0Xp/5udqC5nUXsQLE9JX5j+hURYJHeIb35fQaQQkkpooDddM9+jg
	CgrryRr0rGYtr2sQIoMF/NuoxmAT1rjiGmXpNbs/DdoVRQQbtjHb/WmKLyBLO5n4qZ2P/mxVkNT
	9hL+o37Le5LJuYPGqdesxV48FeVJa4Y1bDIiBjM75QTYWUQQllLrizfaZPTsKUB1VhTWQKFYZEM
	zlWAPiLZt2yv48Lv8YP0FOtiAJ4xs9c9J/5Wo4v7mvOwNkDrgT+u1SgkGU5VdGi9F1PwSMYI7wl
	k/NqTi6azFOlRU3SL5TWTq9qohMK14EYYm3KXuPVMGLnZ6vTV6Yw==
X-Google-Smtp-Source: AGHT+IEZtrtIN/j5JMwINA5KqZYQWuaeHH6Xks9rn0T/YvaIRWGE/56QDYRgNPxkG4s1i3oHKnm+uQ==
X-Received: by 2002:a17:903:2f88:b0:295:24c3:8b49 with SMTP id d9443c01a7336-297e56cf5bemr44199895ad.46.1762626311417;
        Sat, 08 Nov 2025 10:25:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8ffsm94870795ad.21.2025.11.08.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:25:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] netshaper: ignore build result
Date: Sat,  8 Nov 2025 10:25:08 -0800
Message-ID: <20251108182508.25559-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If netshaper is built locally, ignore the result.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 netshaper/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 netshaper/.gitignore

diff --git a/netshaper/.gitignore b/netshaper/.gitignore
new file mode 100644
index 00000000..ec490216
--- /dev/null
+++ b/netshaper/.gitignore
@@ -0,0 +1 @@
+netshaper
-- 
2.51.0


