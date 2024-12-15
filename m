Return-Path: <netdev+bounces-151974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70D9F21AA
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 02:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E449E1886DD9
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 01:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740E3D68;
	Sun, 15 Dec 2024 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsUxgNXH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EE653;
	Sun, 15 Dec 2024 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734225522; cv=none; b=WCUFNwP/3weTJubem6nq3xnghrd9jCOnO3U7dNwWqN3L+q7dWjqz1QlDRBjkxWn6sfiawfUZcsFnthRteS9JWcjAntzW/Vo17tuiPsOCKaC8z/rL7joJb/rrgUFpmVlgPRrWN+3FyGNnp0R+Udiz3tIuuW/0WjVUxiTtfvA6yLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734225522; c=relaxed/simple;
	bh=YlHkbt3tePvX7X7IByQFTY5AkBD+DVAnyhzhoA5npuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/kJk0X+czKt9loPilluqZx9tRB9YWc+p8qSXMYZ15qDTUcmyTqWv+PQq7PC5YJ6niJ11PZgdI1krfsA27L8oyJF2BM9Nwm/NJv/NqUFlWf7BvMqmw5694k+aLe5J2vvYEIgSFNRa1YY5QyFAFt4kNoliko0VL4FSkTSQusPB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsUxgNXH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so4585941a12.0;
        Sat, 14 Dec 2024 17:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734225519; x=1734830319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gr9U8DdcBeN7Mu/Nb5DDW2vscsZ1VbNBPFvgA81tiOM=;
        b=CsUxgNXHjF5zMHqUf+C7OWyF7dchvNsM/2DhLye9io64M+j89hszfplRZx885Dk+wM
         4bAGVGK7csP4xR8Fp/aC3fvFOw2mrLVy6ZCmEzArCYZv1lseiXt4ODXZQM0SEPP6uCyN
         5tCZS874XoWEK8Vpm+BsiZz3j1GgWCLHOtVG22eK3MMla9ZlBITddmjQl+5XpZaIjFv+
         0S0R302DCKDdAfis7/FMS02QCo76k2tEvQCewovFpJUPD4OUH2dsDAN3abC6ZPonseog
         kdAEmBUGMWhwKWEsG5iB1UG37XhRh2oRP3qC9ulQkK7KWFeIxD01fLzmMDPI9ONq+DFV
         Fw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734225519; x=1734830319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gr9U8DdcBeN7Mu/Nb5DDW2vscsZ1VbNBPFvgA81tiOM=;
        b=uNNx3AXY6COYcHdOTKMYNGCPlJ4cUH+3B5xkb2DmpnozoG+5jcnXN7Z/lqzmSxWPKF
         /N7bB9q7iITtXmQgBfX1Qe0ya/cFQ9wYt6pxbGuXieQO8cXfac5QvIsKE2vBFqc87p2t
         3SFYZTTAPnlL9PTH5uL8d4wUNVthFcOy5OR6GOm8gmjey6mlDQ0lBNLsw53wXD2HySc4
         xF0asZCdFwKuW36BTBxZRuSekR7zEqZqXwRq3YS5EL7qJSRCxJDDeRn7yBT5kE2KcZe0
         5IMDHKdqEphv+9slMjZtZ9xz++yAa3Mw6YCuabhOJXbmbsEQUIbVyx/jEtmF2HZlgf2V
         gO/A==
X-Forwarded-Encrypted: i=1; AJvYcCXdYw7JLc3L3o8rs1S1LVjxm0hC5VyUi0T+PgpFMD0S9NdpetOZl3/Jx/ninz1/SsCfLzqQTgDTvoild0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvW9X0rwgW828I7nyE3A2Lmryocv+rKxSm/aezDtCdOKW7vOoi
	DLnDXVod+C/NbB3D5SgOkR/EyqOIolmsDrmBZeI/hjUEtCcwUuez
X-Gm-Gg: ASbGncs6/9Qeu8wOZfAYooH1yHKVxzIXQ27Zil/AUc9581JGEunCRPE2xPQQ1RENI1m
	E81ZyybU4WaJ45jOm/U0x+K3oozvWYqtDEE2TLnOp28Dk6cl+kNgNHoLHKa538OosiDeX3kmJXi
	/+JeK8wBivUG/RuUW6CmViWir++phiOqfQRBKHh3LGEtcceLWxCIT6JLlkJf4oCKeR8wxrktP37
	AXJTt/bIRmhK2UiZSCTM5RVqp7E3qvW+zYYQ9vYP0wZH5wepFEIq40NL7Yugc8Upog=
X-Google-Smtp-Source: AGHT+IG4hArG/ixVtb+/cS+CZ8yiFFcOEFmEiniQAg6inYTChMnOc+I2k3+qurTFadr/PbHqQIEyZA==
X-Received: by 2002:a17:906:c10c:b0:aa6:98b4:ba4a with SMTP id a640c23a62f3a-aab778d9ddfmr675192266b.8.1734225518587;
        Sat, 14 Dec 2024 17:18:38 -0800 (PST)
Received: from gi4n-KLVL-WXX9.. ([2a01:e11:5400:7400:2afd:8633:4d49:50ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96359c82sm153369166b.120.2024.12.14.17.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 17:18:37 -0800 (PST)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: horms@kernel.org,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Gianfranco Trad <gianf.trad@gmail.com>
Subject: [PATCH v2] qed: fix possible uninit pointer read in qed_mcp_nvm_info_populate()
Date: Sun, 15 Dec 2024 02:17:34 +0100
Message-ID: <20241215011733.351325-2-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity reports an uninit pointer read in qed_mcp_nvm_info_populate().
If EOPNOTSUPP is returned from qed_mcp_bist_nvm_get_num_images() ensure
nvm_info.num_images is set to 0 to avoid possible uninit assignment
to p_hwfn->nvm_info.image_att later on in out label.

Closes: https://scan5.scan.coverity.com/#/project-view/63204/10063?selectedIssue=1636666
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---
Notes:
  - Changes in v2: set nvm_info.num_images to 0 before goto out.
  - Link to v1: https://lore.kernel.org/all/20241211134041.65860-2-gianf.trad@gmail.com/

 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index b45efc272fdb..c7f497c36f66 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -3358,6 +3358,7 @@ int qed_mcp_nvm_info_populate(struct qed_hwfn *p_hwfn)
 					     p_ptt, &nvm_info.num_images);
 	if (rc == -EOPNOTSUPP) {
 		DP_INFO(p_hwfn, "DRV_MSG_CODE_BIST_TEST is not supported\n");
+		nvm_info.num_images = 0;
 		goto out;
 	} else if (rc || !nvm_info.num_images) {
 		DP_ERR(p_hwfn, "Failed getting number of images\n");
-- 
2.43.0


