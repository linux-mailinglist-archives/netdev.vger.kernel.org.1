Return-Path: <netdev+bounces-72584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7E1858A24
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 00:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C821C2210D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3231487F6;
	Fri, 16 Feb 2024 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FgYNol8o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D939856
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126210; cv=none; b=RPqLU4uJuFHVZ7cZbstITJoLX/wIhHSthrpjKlNEpNbXmDuV60a96qL5VOVsA9kUEaQmlN53/44aDi1GmMYEPmw0pqWE4fvMJmat7mlRS0OPTmolRwM+6yh4vA01A/vOxk0yVb7keAqz6lOjWH2yaxP756N8rflcj7vQ5kPpcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126210; c=relaxed/simple;
	bh=N8SWEam9A1kUZnQAkUusNza4SpfF9G3Tl7KB3Dv0a+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LaZZX5J03KDiO3nvmyAUZkwoKHsYzYZ66io9Khwza8VMr3rlxRHOYh3AfoYn/QbFSpDLVLMmQ9uJO2JgQguaDgnIiat8puVSu08h9rQVjsdZ6gLA3fWOv0ZPCdiMlXBt8NFxsCNTEoQiJBHDdZM1fQXEkzPyvm3bIk6eetEjx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FgYNol8o; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso942217a12.3
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 15:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708126207; x=1708731007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0M9H+uKm2YFk/vFzLDf9keBJtUyzrYL6KC8P62658M=;
        b=FgYNol8oVtCGDGTyPNtvffjaXBJo3IhIdi2Pj3vouNzKG+PwAlnukfH0AqBs46Xim3
         AqQErSj00ToeNkb7jJVeYq6qqNp9o82mLJyRBvv3Hm/xKhhKQ3J0SvCEgbKOw89nS21r
         Gbn+1XGfFKp/DDqocOZ3r51M5IN9EdGWB69nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708126207; x=1708731007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0M9H+uKm2YFk/vFzLDf9keBJtUyzrYL6KC8P62658M=;
        b=hayFheNF4k0tR8oo3ZUyM+/3ujtETuMiEY2+QDyJVgZiM07WgIsjSnGjdvsxrPR5eO
         ApLTTneA9BwL8mfL5XXdeut2DDn1d3X1CqBQ+Ok0csC7NamfE0Z0ojmj0R6tUYdvZYyp
         wShFvwemIMr/18YsaP7NowTKGnUMDV2AlnP8G4gM69TzN2TQ7YmxbzjaTCccMQ3Nqbdw
         Ix4Ljy7OR44NHUBomWlsqc/4H6EBkAUi9ejqfC20GgmYhEjkeWlEf1T4IufYzDf7ioMI
         2tyN99KMX9rxNskWkrFnWwHsL+SH7ST0aq1nljGkMI70Jkg85SwrX4WGMAikl359hUW7
         GOmw==
X-Forwarded-Encrypted: i=1; AJvYcCV5H2EIUHrgvlmqYY71dKBRmdeLMVif87kCYwe6sUOaxCobxTHHsaK4Ykw4JgIOW33+gFYxkPSul+9JjKa346384NJkv5M9
X-Gm-Message-State: AOJu0YwnZ7ODNVuxKwUVUvKS7gQ7+eW2ejRURTtFQq9hGJ08EFKf/NfH
	UaFwo39wKFY1W1BYu1X2+0WUr39yse5cXiYMtDf+pRDqMyE7QIKL/MKB6/C7hg==
X-Google-Smtp-Source: AGHT+IHLDngRzVnt3PaLTBd99dKYJp4xFnvTjecToZpLjHNMXyYWqFfP0n9Z2AGZ2Gv8wIpZON41YA==
X-Received: by 2002:a05:6a20:c78e:b0:1a0:762c:7c9f with SMTP id hk14-20020a056a20c78e00b001a0762c7c9fmr7240423pzb.36.1708126207106;
        Fri, 16 Feb 2024 15:30:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id du5-20020a056a002b4500b006e0a55790easm466312pfb.216.2024.02.16.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:30:06 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Christian Benvenuti <benve@cisco.com>
Cc: Kees Cook <keescook@chromium.org>,
	Satish Kharat <satishkh@cisco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] enic: Avoid false positive under FORTIFY_SOURCE
Date: Fri, 16 Feb 2024 15:30:05 -0800
Message-Id: <20240216233004.work.012-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=keescook@chromium.org;
 h=from:subject:message-id; bh=N8SWEam9A1kUZnQAkUusNza4SpfF9G3Tl7KB3Dv0a+E=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz+/98DESvFGFikq/0c5rAXVNW2jvDZ5ZdvQsL
 mU7EaKbFGCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/v/QAKCRCJcvTf3G3A
 Ji9aD/wJ76bdgoqZWSC+dTOnrSCAtpdSTGT0TYNd0E5WDFwXtv/ju5qL2URM/kXi0qw4A/nJ8HT
 mQmgTScQTSQHancdPF/ow4o0623XWG8Lhi7zX4Aga7ArrngyLmoMUVzLbEc5r2t4tAL5uM/3mG5
 yRboorFeOmWeG/gKm2+DKeslq4o0kk7kiDrHHqqix4W05WJqOkEyhBxl3UGRt/Inxn2QasEIgv3
 Q4qmhn+J+zNJUDB/Cw97dZ1AYd+ILfULWCj5ewdLF148SSXa7bMSaJtuciASjVS3bifRJWhL/Kr
 dksz0Kcj2/K3BFeJzLF0I6A4VYMq13vcSAFf6C8pCLPphpgma4+gzVGE/K42gCUkxf1osxLV1Ni
 0XKZMLZudf6fcM4vVpruc6Yq0LctwFZoOcdtNjGo44QjUw3SxYorBUlrjB0nZIKTpSiIiTyZerZ
 yGt4KFEe9KE1QWLBK0dZNuF5xuJD6TRbZxcYW3gnd0d8hntPyda3gjWtglmWRXdKLD6SprT3uve
 J+VAEUd5UbRXrGSUaLxUZwe7IcYwwlcSLeh4JsEa3hMR3euf+97r66AJ2f5U0LN4pcM/MaPN5Tx
 0kq1INBYqjbjZe0/PrjlMJh3uvs4vr1gY8PwL+8jomC+wBvbpSSL9FYP82hH1QHUId3b9yZHMC4
 FUU3ziy zehgYZ+g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
code base has been converted to flexible arrays. In order to enforce
the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
destinations need to be handled. Unfortunately, struct vic_provinfo
resists full conversion, as it contains a flexible array of flexible
arrays, which is only possible with the 0-sized fake flexible array.

Use unsafe_memcpy() to avoid future false positives under
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Christian Benvenuti <benve@cisco.com>
Cc: Satish Kharat <satishkh@cisco.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/cisco/enic/vnic_vic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/vnic_vic.c b/drivers/net/ethernet/cisco/enic/vnic_vic.c
index 20fcb20b42ed..66b577835338 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_vic.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_vic.c
@@ -49,7 +49,8 @@ int vic_provinfo_add_tlv(struct vic_provinfo *vp, u16 type, u16 length,
 
 	tlv->type = htons(type);
 	tlv->length = htons(length);
-	memcpy(tlv->value, value, length);
+	unsafe_memcpy(tlv->value, value, length,
+		      /* Flexible array of flexible arrays */);
 
 	vp->num_tlvs = htonl(ntohl(vp->num_tlvs) + 1);
 	vp->length = htonl(ntohl(vp->length) +
-- 
2.34.1


