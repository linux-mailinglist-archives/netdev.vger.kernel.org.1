Return-Path: <netdev+bounces-121166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1707D95C043
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF011285190
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F61D172D;
	Thu, 22 Aug 2024 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijfZ53FY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA013B5A1;
	Thu, 22 Aug 2024 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724362456; cv=none; b=KZeVhlTNyeKr47quF83UBj2iUFRshj0O6IQi+XvP5aOQ4DnM2Eej17wG7QL7HJjHCimNnJxvQ6Wjgc46mHonDVWtWjALNwi8Ugz7MnrGbcUw6lyCvM7imztlBBPjrR8JpO4i8b+lqcfO5Z+qfQnc6WeQ/Csw2524hv/P3p6lheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724362456; c=relaxed/simple;
	bh=WKpVnR6wmTzdQewLRNVlooHH9/7lyDdUabbFg8nWtpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=alOWu1BMpRl7ZHlZ76XwarQMYWJdjNxp6m8hCbFJ9pjChp5ekxJIOlFm0jW2XipqPFuwpGLUM5Nmd+GAoJLWuwjlqwXc5vuRf2/O/D6HnJZ0NqEDEXqpqejd+7pirFJT1t1FO4Bmat5kVdf11r0pcVeXsfC1RnIPjHxpJQ6lHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijfZ53FY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso1822160a12.2;
        Thu, 22 Aug 2024 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724362453; x=1724967253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFWX2cinBIO6xOaffSSaIYHyRanL2VaLxGkBzU8S0ko=;
        b=ijfZ53FYTID82o9SkW2fTAomweT49zqTfvUSkzuf+75WOdWUJH/u8EimBjQjUYphTJ
         lZFbZQXh71bsOXDbjZ6wjr8jtUdmvg/O4IjVwYDvTFSyIf/Q1yEX+CnpP4J+nAYZokAg
         RpUq6X7W3osWA3P/ux21xESrSLkgXbptalIPlgIyDD95/UBuN48QnGh0u6qYvN3niUHj
         vbBVpwugzrUHHb6d3srr+kVMsEHyGy9Kt9Svy6q50wcr2VbRnnUhnDU1sC/YWuezsXVl
         8D28c5iXhRElnlJKxN0g107wrUF00paA4b+5jczPO5tZAdtk6Ywdv/dlQceoDaShb9Tz
         Onwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724362453; x=1724967253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFWX2cinBIO6xOaffSSaIYHyRanL2VaLxGkBzU8S0ko=;
        b=O7ch9Bt+kJIv9Tud3qdqiweCs9ZEmB/vpSa20gqOQy2tBNavHanIE5NioVQ01wW5+B
         GGfYNtvsEDrfrR/ZSQDIon2S+OM/eqyV3L5Si6U6rCFPb7RWRmmpqOpiVgkufiFKxete
         DMJ1Uet474em5WlCMr+DTlCQKtqXoyjWou4cdVB/8nh9IVk0wViA2tBs1PwoVROyJQWC
         pvsEaCryihy2S4F1zULglryHlSSyZuXEOzjpwEvDoNXJPidQ2iDoDBkdFrhRwHN2PiRo
         T+uihRUGA3Dcv4raSC5rSgL6+vz71BB7lilEyfK2WCi/6Hj7SFlERilHI4q0CSncLJG3
         EOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfzL9gzxsuaXD35dUQ65l2YRuuBanRvVBHryOHEZ0M2HaoOldejti1us+TKlhLjKdv/i46rDiq@vger.kernel.org, AJvYcCVMkK+3PiK0hJA0EWJXw43JyhSuHzr71bMerclwaVZASJWBzGEy3GjLdAQAXFLvAK2Bx9EYkiikdHZtabg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgBxjvRybWsWdsuGqq+BBbC+3qBZC/9bdcYbLuukcD/LCaxRq
	MqF3sDMEZNDJUxlLGi7t+Nur/2nUkgPK6SLej1LiJTogwElmHjFF
X-Google-Smtp-Source: AGHT+IEVB3TMuJPdwSDpRWpHTVyOYscabrPsA9ZAKrw6yJXPdtiCdNU4xwQLMzzGWoF1fR2IMqAp1A==
X-Received: by 2002:a17:907:1c27:b0:a86:7ba9:b061 with SMTP id a640c23a62f3a-a86a54d1230mr1371766b.64.1724362452654;
        Thu, 22 Aug 2024 14:34:12 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f43795asm167582366b.98.2024.08.22.14.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 14:34:11 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] idpf: make read-only arrays tx_itr and rx_itr static const
Date: Thu, 22 Aug 2024 22:34:10 +0100
Message-Id: <20240822213410.644665-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only arrays tx_itr and rx_itr on the stack at
run time, instead make them static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..d50e5cab05fc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3149,8 +3149,8 @@ void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 	struct idpf_adapter *adapter = vport->adapter;
 	struct virtchnl2_create_vport *vport_msg;
 	struct idpf_vport_config *vport_config;
-	u16 tx_itr[] = {2, 8, 64, 128, 256};
-	u16 rx_itr[] = {2, 8, 32, 96, 128};
+	static const u16 tx_itr[] = {2, 8, 64, 128, 256};
+	static const u16 rx_itr[] = {2, 8, 32, 96, 128};
 	struct idpf_rss_data *rss_data;
 	u16 idx = vport->idx;
 
-- 
2.39.2


