Return-Path: <netdev+bounces-151698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A879F0A68
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4687D169C0B
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79CF1CBEB9;
	Fri, 13 Dec 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I//GKY3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5961C8FD4
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088116; cv=none; b=QZ6WSULGwOHlBA/RjIaVW7OZqRowYDKx2pshLvvC9Js+5hK4kjVjYIFpZC1a0a8u0kDPjGeFZFjHt4A15fCnPFkoyP/Fb7zr4TtvOWSK1oK3rlGtdX5X+DsO1guqEgJzJtONvCYB/jvflMNRu4u8LJrN3bPhSDrxy5f7hb9mNCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088116; c=relaxed/simple;
	bh=lbbqJqo2HRp7VpY0UlKyQUacObxkW/KgR4INRm++4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqr9U5tG2dZ86Wap99VaQwIftqJUCmiHxttdaGbGOOqCopYjnsAeBf5K+kDnTzy4Bqh+puHqX25MjsQ4o4Y6VMDoYeynratvUph1d/VMc/uYysW27O+G7XVaR+CV3zssGKiMz1r/fL2vUZ/lG3mEHCGHjWxAKJa2u7rSfnoFMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I//GKY3T; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e3621518so760910f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734088113; x=1734692913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ4blGxlluPeBYaVfrCec1bwwJc6f9bR30P9uNxoMjM=;
        b=I//GKY3TfnTgdi0/v+QaYP6FKxxEffMHqRMhg5wSSEuJs7wdPJHvUPGaO9BuruHWnM
         1STN6yQeI6EW9uaaYJNrOxgU6UdjEVWkxrMaVv/wFWsZZXZ4Duf2yKiDcmq9sXSUiE4I
         VWSCf3ffE7RLeIW0MGUnoszkwqwuU+WZaIVE8PTGd+xvfNC2KC3uekHl/u7wYWAZX9HV
         l7WAfhWr4+BnrnY8lMv5fLIbv9SbF3/x2ehWoWMupuWD7/aBTm+5+SQ8Bgy9YEDXDpdr
         z8aXwQxN7nxaPNLjVD0NUiqrTKB3Lem/xVclrgQE2kZKyY0bl9/opwztWb3oTFnWN2PJ
         rUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734088113; x=1734692913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ4blGxlluPeBYaVfrCec1bwwJc6f9bR30P9uNxoMjM=;
        b=eksmJhPEH6nHJScjWyYLbO0BhfLjf9D/gyw/rxvnpFCQVdJ7V5ZGUTUbJQXUftLesw
         s4PYxbl5elTifh8P0jKl9T2dwLhmtWYja4k3dJQ2KIt3CJOiUcw116jx3fyxcBPUnYpr
         hv70LHPw9W9wEsUWDrx05StR5cmoEi9VTCX/Je4DnNSVriYwYL71pXSisoct/gJCtLVy
         SkBaI2iExJBTTbr6mbjsjn2SLRAMgGCVe0XIGh48eU7AMUJksM/f1UsinVP6CsnOCpps
         A1u1WogfC2jRTjPUrEDmX3XkAKBLlxDPWrBLU4U0UUqIRyqdF0MOeTZs50ye+yRAnwZP
         HBzg==
X-Gm-Message-State: AOJu0Ywzb1Y5Wv8pBKpnFojzMxMor5kyW1ic5btJvGU89cPubke+VDqe
	Ftx70dIC+VJM3BrJdxd8MbIwdvuPm3pkb2heIRfAe55ZBTEWt+QV8MOmPA==
X-Gm-Gg: ASbGncuVdBOzy0y/Qr9SSzUXQ6rZlUZSREL0IyqysWgqcWpiEePz/D3s2bqwrwvM3hT
	xgHftsxdeXaFbNoTbjUWOShU2KJMKPkso4wDWAIOW3bql/dCoOUBVIHgvzCVImh+knEKl3csNXl
	BMtNY7PwSwemDU4nZGFt3TCqDq8iRcIansBcw6LLGaL5mS1L8WmTZOqeH+Ez1/jRuM2abL7iLDQ
	5hpvHUo2JBLYXg9FgbNTMml+VOaFUqPZpwKmYDpr6kw2W4wpDKxklFIEcmvNA/Nr3CdZwt5b1Y=
X-Google-Smtp-Source: AGHT+IE22j6UBKyiKr3RkwybbxhzbhIt2F6iVXbqCjk7PADx6drmOxmjN1mmC7Fe0s0g8o64bIAzWA==
X-Received: by 2002:a05:6000:1ac9:b0:385:f6c7:90c6 with SMTP id ffacd0b85a97d-38880acd940mr1693319f8f.20.1734088112405;
        Fri, 13 Dec 2024 03:08:32 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:dda3:d162:f7b1:f903])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f521sm6709004f8f.16.2024.12.13.03.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:08:31 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] netlink: specs: add uint, sint to netlink-raw schema
Date: Fri, 13 Dec 2024 11:08:27 +0000
Message-ID: <20241213110827.32250-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add uint, sint to the list of attr types in the netlink-raw schema. This
fixes the rt_link spec which had a uint attr added in commit
f858cc9eed5b ("net: add IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute")

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 914aa1c0a273..1b0772c8e333 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -221,7 +221,7 @@ properties:
               type: &attr-type
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
-                        u8, u16, u32, u64, s8, s16, s32, s64,
+                        uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
                         string, nest, indexed-array, nest-type-value,
                         sub-message ]
               doc:
-- 
2.47.1


