Return-Path: <netdev+bounces-250995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E6D3A028
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2E1D30390DA
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 07:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9033033B;
	Mon, 19 Jan 2026 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSGxNPNp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA52571B0
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808230; cv=none; b=UBW655eEQ/A45MGqKlV9Aj/EeHB88J4ufMq+2JXZcTkirmzs2ryrfISVTUcH4hP804lHoZWTKy6cYcyt7TkGu1k8mLV1AU6FIaJJRd8rfJXxmUYUJne/jW0BHgnh2jlQUNKu9G43yo1yxlkeUtTdbDsp9uYs+N83uLWjw+LelLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808230; c=relaxed/simple;
	bh=AKf8bOjx1Suk0z9VdmcOaWD5druBd55Erloo4+mcjJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYY3udvPx4H6CpE35RgMqZIO2VnsXMQbwZf4c9m8aCExcAhzb9h0z7ixpPj42v1eGyNEARY0F3ZkdahJ+jX8W9zBFwDUV9wNsN+ezMxrj26DDXAc5njZJqP9SmTbd43b0zNtl5LFAcsR5J17jCSVgVoYigwij8bR2bAETITMYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSGxNPNp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so3198335b3a.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 23:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768808228; x=1769413028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+kBx4QcKLVaWXaktso4/8lWc1DclQv7nA4KvLYpveo=;
        b=kSGxNPNph+oaUbp9ofNQNzGNI5Wm93T+uCAK8tXDhRHu8x37AHCqz/ExkmwSv51wno
         qGGAwqoKCk9uNuqjk9fmSTixlkc3hK6fQ2vR67NBZlXPGNCwQ1AAfPMq9o0IrrR+S1QH
         QUDLMvspENIP3NUpaj2UfAYb960Z+NgAlB3eI38AkImlIj1JG8729HPoUk0nM+QuoRXV
         OCyKRuN6kKkGx7JjL/1Rm8+aoq1wTP6VipgCPngbGS/CouoMoLH3GAgL5LD7DJ3iFQeR
         QCH0tgSy6nYU1F+NB4z9kKGsVrsHERvpTPlNVHbCPx5oTdxunmSag5wj6KM54WOZaEkv
         S+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768808228; x=1769413028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+kBx4QcKLVaWXaktso4/8lWc1DclQv7nA4KvLYpveo=;
        b=F2LzItG+ZXEQd/CNZ3BQRHz+7VD+nP8kQ8MiBxGU3ZGjGXUrfFkn2F50qiS49t+f3Z
         QM58fFgaiafeP6hvl70O/G1E3hh6y6RrSkzUoqV7ejHguPHOYci423B2lNe1FTxbNTJl
         1c28S2nfECpYrap1LR5FQtzMbybP7O0EEv3kwXUpaK66zZ/i+Yk+A8G/WU0MQYhGYqq2
         LXi/4+mz/VG/5nllfnZz3sxMKbqvpwLaUSsnruxM19LZOikCeOymEeNQjdf41Ene1sgc
         1igvn2KyCsjYZAoFuWl1Pn9VKhbgOP1lIf9TEhTXixN8w+0klx9HL4zsw0MD4Q3JT4Uk
         6svg==
X-Forwarded-Encrypted: i=1; AJvYcCWAx6FmXz/chjt13ocUoxAGnSZ5erJ5lSLu0YazHnFFqSMODvAlqUwF0PiFKDHWjQpO3DZEdxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygXUvQlh/RgaHvhSaGGuJcrRZc8v1TmZX/hYnIiEXQw9C7PQFP
	FEwLAYyYUvQxNT4vKNadabnAVD5Mk22ujvx8L6oQOyjKI7qSjZB32xsN
X-Gm-Gg: AY/fxX6+DEUTpadZMg6tCf++fUWDh3h3JDB5IuNOFwA3ZxIi6H1EQo88pT3ZKC0Dbym
	l6hYuX285l481jjexjyMBc+VvXhxMO33EOzRctMf4PqTIMEdUCh2s5Uzq6aZVUDdZ1xa7NydEeL
	zHOL6PZfrj0ns8+/fQEg40C/cvc4G5xqK/PfO9/RoHB71Tj56vgohr0Kjb7pcYiGzFHybSowGXs
	VU84GuzsR80Dg9xh1F5i8/+HeUOKF4pMVYhDpLyiiRC3NAGsy1NuwU2Sehx7WL0qlD4Ux3bG9x/
	SY6lrICN6rg5tamV1fiaJm5ir5gBw/4hor2IzO+QYy/4h65H/2oK7ibepoMVgVNWNoe9Vp8Ky3C
	E2KDZJdkY7KGS42Gk+GkB7NzZJvqYb1l5v6jxE/OfaY4nzNfEx679ZKPNDSjIOIzKuuwq+M/oOM
	go+hntW7/is1LLcBOZqIDC4L4=
X-Received: by 2002:a05:6a20:3945:b0:38b:ebaa:c167 with SMTP id adf61e73a8af0-38e00c2ef84mr8843037637.20.1768808228293;
        Sun, 18 Jan 2026 23:37:08 -0800 (PST)
Received: from nbai25050028.lan ([2409:4090:807d:4601:b49b:a111:92a3:e6d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d1f1sm8170540a12.22.2026.01.18.23.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 23:37:07 -0800 (PST)
From: Sayantan Nandy <sayantann11@gmail.com>
To: lorenzo@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	sayantan.nandy@airoha.com,
	bread.hsu@airoha.com,
	kuldeep.malik@airoha.com,
	aniket.negi@airoha.com,
	brown.huang@airoha.com,
	Sayantan Nandy <sayantann11@gmail.com>
Subject: [PATCH net-next v3] net: airoha_eth: increase max MTU to 9220 for DSA jumbo frames
Date: Mon, 19 Jan 2026 13:06:58 +0530
Message-ID: <20260119073658.6216-1-sayantann11@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The industry standard jumbo frame MTU is 9216 bytes. When using the DSA
subsystem, a 4-byte tag is added to each Ethernet frame.

Increase AIROHA_MAX_MTU to 9220 bytes (9216 + 4) so that users can set a
standard 9216-byte MTU on DSA ports.

The underlying hardware supports significantly larger frame sizes
(approximately 16K). However, the maximum MTU is limited to 9220 bytes
for now, as this is sufficient to support standard jumbo frames and does
not incur additional memory allocation overhead.


Signed-off-by: Sayantan Nandy <sayantann11@gmail.com>
---
v3:
- Document that hardware supports larger MTU (~16K), but limit to 9220 for now
- Target net-next (netdev/main) as this is a feature enhancement
- No functional changes

v2:
- Clarified commit message regarding DSA tag overhead

 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fbbc58133364..20e602d61e61 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -21,7 +21,7 @@
 #define AIROHA_MAX_NUM_IRQ_BANKS	4
 #define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
-#define AIROHA_MAX_MTU			9216
+#define AIROHA_MAX_MTU			9220
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_QOS_CHANNELS		4
 #define AIROHA_NUM_QOS_QUEUES		8
-- 
2.43.0


