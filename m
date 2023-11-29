Return-Path: <netdev+bounces-52197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7697FDDBA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF29B1C20D82
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C093B788;
	Wed, 29 Nov 2023 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Tp265x1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD5D1
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:31 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b27726369so50860695e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277050; x=1701881850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=Tp265x1fhPLXtlKDHuVj5etiN7JYsgEtxBISRdzxuZZU0HwArfSUI3KpGecEM84dzY
         Zihc23R+ePWn5NtRAhrQpRqAOUNwio2Yg82pq2u/2OVKbmCHoN0kQ7Jf5d5GDsCBNj2W
         DtQnOKJo0irihLhy3eueXLosXVWrqcQcN7gL65JsJCOv1Sxj0KzWQV5nVGPvnY3j+SMD
         awlodOIqem9lH9wjHogG7ihyUeftCSgHHXSFtfwHY6R5ejzXZaIBCmwOIU8ilTetrPJH
         kOHGq0t0ss/gYnowWWuf0Ie+oDuWc1np+iqxrnMI9H/WrKBClBzqpH50FHMu6l8bzQbx
         PZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277050; x=1701881850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=TYIAaU7gHmVVVHBck0awRn70p1CZElmYOupNT/RsdA2dvfk6YNjtL56VufAAXZPdsq
         t41OYs1XZAZNqqhOO/AbtlfIpZf0usdax8WCmsi6DwvGuMCkj7/kcjfmA8sm1ol3jChf
         31skglknPiAu5JTknPnLw1EYkmLI2k6ap797O79lSU47cG5HxkAMssWgpoqQCTR/Xv+c
         jDPKJzemL2YB+XyMpH9kO0u+7Og34oE/1Szs5QEGXcsFLV1z0HbThbAh+2I1Iai6IDAO
         AVbolLa+jjUj74U+ET2a2hGR5pQkxg6OB5pKZPmMKkLY8u261bEGG4kZOMkwNDDEMir9
         26rw==
X-Gm-Message-State: AOJu0YxxA2ajaArK3W6q4s0HY/vVjAT63A3m/J/d7PweSt5Z/RHkS4B6
	zFhhJ4gX/97z4G3i0HYvlRvm0m/EKGx4bdPXols=
X-Google-Smtp-Source: AGHT+IGJnXl3K0OuahWJysbyTRWRNB8Me8pMC0aRC2KPiav1kUKZXJAHnaxaCezYw9nnmAEbaRY6hw==
X-Received: by 2002:a05:600c:524a:b0:40b:4ba1:c502 with SMTP id fc10-20020a05600c524a00b0040b4ba1c502mr4512827wmb.37.1701277050092;
        Wed, 29 Nov 2023 08:57:30 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:29 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 1/7] Documentation/tcp: Fix an obvious typo
Date: Wed, 29 Nov 2023 16:57:15 +0000
Message-ID: <20231129165721.337302-2-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yep, my VIM spellchecker is not good enough for typos like this one.

Fixes: 7fe0e38bb669 ("Documentation/tcp: Add TCP-AO documentation")
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reported-by: Markus Elfring <Markus.Elfring@web.de>
Closes: https://lore.kernel.org/all/2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/networking/tcp_ao.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tcp_ao.rst b/Documentation/networking/tcp_ao.rst
index cfa5bf1cc542..8a58321acce7 100644
--- a/Documentation/networking/tcp_ao.rst
+++ b/Documentation/networking/tcp_ao.rst
@@ -99,7 +99,7 @@ also [6.1]::
    when it is no longer considered permitted.
 
 Linux TCP-AO will try its best to prevent you from removing a key that's
-being used, considering it a key management failure. But sine keeping
+being used, considering it a key management failure. But since keeping
 an outdated key may become a security issue and as a peer may
 unintentionally prevent the removal of an old key by always setting
 it as RNextKeyID - a forced key removal mechanism is provided, where
-- 
2.43.0


