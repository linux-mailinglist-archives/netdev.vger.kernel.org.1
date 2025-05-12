Return-Path: <netdev+bounces-189722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004AEAB358A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87A317A42A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E66277039;
	Mon, 12 May 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1fyMQpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE827587F;
	Mon, 12 May 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047639; cv=none; b=ZFS3HuiCmRvW76utWmOEkqhRQbIw7btnao5BR3XQOxxa1jQ5smVAR74U8GdpcPgnEnZRKccstyH8uQ3oESCFdriYwu7mpI4nvFIl+nWQgQUMfusCkiQiIS7A7MfF7aH0cEFKXPcTn5RY4nFkvYh7Rk7YPBJfSrAX/YQ0HOx1dB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047639; c=relaxed/simple;
	bh=pwYBeR97BIxNsN8CElT/32bfkmC4wOwuawHLhLij1fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnATCcRaJd6BV43rOi/wgoG1Nq3X9QUq/udRrBtAhDAHH8Q9mW0mWUsvZJu05JKBOzwA7fw7yWpV4rSAc5c5unt+3A8XH3+ILl5AtF8RkyBA2w2qfeOPE/zzmv8lJS+kaJHZdcfzlRCfFX1hEbJdj3p1SZUWvs/jK4KF0XiimVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1fyMQpZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30db3f3c907so41238071fa.1;
        Mon, 12 May 2025 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747047635; x=1747652435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AiibmBb2TgKHLZaSpGFjEjGxFWFoz4TNIUXPov39aMI=;
        b=P1fyMQpZDzIVOUPIZCcZnpud5AIB9bwcgoSO6HXYdvZCxfBgDYDKosmXtIMwTfcvjL
         +zB21Pihu+fKL7sUG1Swymft54AZyT+F+Rm61iacnS7X6vT9Y1Tv/NvJl9eYnewAxX+X
         oYNjZwtFfjWKqrwPMqDmScrdeZUh6ke7BDqhJylSDIwBEKU5h/RnyBMImNFOItjGNsBG
         xkVRk8tEO+OrEPXH1P27DAJPs3d2E0v6JoOvxeu8nzpKBHKul78MUqZ8rPlU5wSSYYWJ
         ZuoXrhjIjz/7+c7+K1kPAHehnsxqM+ryZdkwGRpDXxPth/egF5PRPNXgh9kKti/qga11
         Bosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747047635; x=1747652435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiibmBb2TgKHLZaSpGFjEjGxFWFoz4TNIUXPov39aMI=;
        b=EznaiiUJ2M1QZaaX7E+yq3NSHSsb7GrLI00PT2Nwd2nKIILWWN5pRaNnJ3EZ62kvVv
         vvMzVgokzySPpcr5FBjdXrecX/IOAEQ2hSwkAB5RkegUur86nASUfAUo4ss4ChuHzUv+
         B12Vrdtm8cQKdZHBH9KuSyM/NDcZPD0isD3VDkygg+BVu/cJy0jV9oJ+ZR3kTHSAVA23
         rfDEEWwC7+QxHSuzlyQPahP/kX8dNdssubtTLbCtYj7Z6lvSF1a+qypYHZPMqJFkNVtj
         zGrqrjdkZ1scxmyrnKPjIYypNv9GqaCC4ugDTr2HCNqky4ZwHIu2dL8EaD1jrrIfeqm3
         FYCw==
X-Forwarded-Encrypted: i=1; AJvYcCUNop1F5EL/eZzw1sdU/yCKrji2/JzI81KnPneJpAhUm1MsydIF+zV583kjy8X+fpf6whTUBB3KSMc=@vger.kernel.org, AJvYcCVynIYEy242wTbhQy2DdTkc6qeBFVnSRCnmMFFnGeRK1lpnZa0qR1DKg3nxjoXQ/gMuSKbbxitNlBA0Rpbk@vger.kernel.org, AJvYcCXUjs+mltXaW4IbsmiZg1a4sxlrSD3KmeEOLWU3MKIeYPxb8kxLeWqgoHy+I4fG94HBm7LG1q9x@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+RTWIKF0au9XAmcKo/bH1zlvjzVynrolO5Hw++ZAPy9wmIx2
	IfGq79A33xqKK9Dmwhgtm+YI8k1cY8bHRKXLwM2fDCbOoQ2DNplt
X-Gm-Gg: ASbGncsgMYoeiranH+tT2v3vnGnsJeAcKRH05AqoqNOMfcPfpnUxqUKeFVyz60821rq
	2hRFetXnwDnihRlo+KZKD+bHDf/EHp2ZZAmu0Njy90nkCZaTzbDlMKE1Ix5FGHuEXFWPcdBiW7N
	3kPfkipEaBi1y8SLUtt0zlu9thxee5U1nHkztSYVQ0UnZ8dXpzM6pKGDd9bvnFKduRkfxgQEQBQ
	yR1JEwHjAvg4D0/dxf1/xqKXUSq4ACpOuVK7+uu8RTgyfZNV6qGdcBZFsOHp82X4agcDWy4ZVrW
	/a+ReUXvjCw35yis7raHXx0b06kok/mt0gsnc6novacmXPVYQMPDFZ+jyVfYI5Pr/yl5
X-Google-Smtp-Source: AGHT+IFHwwb0Wf277goCmSM/dTazqu+h3MJl9DvtXNpnIfB4xxp80sRGBAvvHMgiFAubjDGUQyi90g==
X-Received: by 2002:a2e:bc17:0:b0:30b:be23:3ad with SMTP id 38308e7fff4ca-326c4589014mr46473731fa.10.1747047635186;
        Mon, 12 May 2025 04:00:35 -0700 (PDT)
Received: from localhost.localdomain ([176.33.65.121])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326c3585c7fsm12756831fa.88.2025.05.12.04.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 04:00:34 -0700 (PDT)
From: Alper Ak <alperyasinak1@gmail.com>
To: kuba@kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alperyasinak1@gmail.com
Subject: [PATCH v2] documentation: networking: devlink: Fix a typo in devlink-trap.rst
Date: Mon, 12 May 2025 14:00:28 +0300
Message-ID: <20250512110028.9670-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: alperak <alperyasinak1@gmail.com>

Fix a typo in the documentation: "errorrs" -> "errors".

Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 Documentation/networking/devlink/devlink-trap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/devlink-trap.rst b/Documentation/networking/devlink/devlink-trap.rst
index 2c14dfe69b3a..5885e21e2212 100644
--- a/Documentation/networking/devlink/devlink-trap.rst
+++ b/Documentation/networking/devlink/devlink-trap.rst
@@ -451,7 +451,7 @@ be added to the following table:
    * - ``udp_parsing``
      - ``drop``
      - Traps packets dropped due to an error in the UDP header parsing.
-       This packet trap could include checksum errorrs, an improper UDP
+       This packet trap could include checksum errors, an improper UDP
        length detected (smaller than 8 bytes) or detection of header
        truncation.
    * - ``tcp_parsing``
--
2.43.0


