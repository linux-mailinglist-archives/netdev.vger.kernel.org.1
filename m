Return-Path: <netdev+bounces-146703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F168A9D51CC
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 18:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78E428268E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD161A01DD;
	Thu, 21 Nov 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxDUa83R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6D6CDBA;
	Thu, 21 Nov 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210194; cv=none; b=Nu4jkNb/C7cCWdOUJFWq+hyMXuM8gr3piqQN6spTlwRB3z+zT1qBEE8UEnsFqauYAX0Q6fvvLzJeBwKD5BR+1+V7eBjeZMBxdI5KXIEvRPAVjnKzrVyTTShgQlewv0fHjDSgKcMrgcjpQdE8RQJRQ+IbuVUwb57PH/rGyKE5QHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210194; c=relaxed/simple;
	bh=pwFx0/X8PtHlmudeayYhqBhhT+wJBbl9lv31lLjUFiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOQrhozVT2yvef2rE+zmAZSB0PZainjZzYdDCG+vM1xpGzXwazCJI8Lr0mQXQNwUQ+vHrIlyYWDfqsRQTGkKEfFUoX5xEAcxHzOrurJZ5EaAYb8XTnwVqoxUh8KZ9FTbxYORnKNzbblVrh47J1NfE3ex0YESj0ZPzFwEXwrT6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxDUa83R; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315eac969aso6784565e9.1;
        Thu, 21 Nov 2024 09:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732210191; x=1732814991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GTbAdxp0GTcyL45H6qzLKqwHog1M83ap9N15e36oQyI=;
        b=RxDUa83RmrJRkapiKr3VFbzyI7yf+tMVIT9owk8a8F5beMrt0NFirOsrNWJbO6p+TY
         xrSU0AAfmhhWhYtw3WOewI8320W64bTxEFXwhYJ+MtIiwBcPRHRxsOSGaUGhAkfZsNl4
         LC2PU7j2IigMTUuZGfs2nV6UUnvqobl/MslV1xpEKLGnT7xrfr0HE0k4p/9rMZQDPMKX
         xHkItPPwq+wcQQYSzjogi+On7S5YPOn1XETvBaRLMk7bamJwjqiXBW+XWUFNXposNzsu
         pZ+rVuzHCXyjU6iIJ7sLTk/42wFtedERFFygOzbs1uVR2f1dEuS69/ZxIeoShu+ppBaf
         e79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732210191; x=1732814991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTbAdxp0GTcyL45H6qzLKqwHog1M83ap9N15e36oQyI=;
        b=dPEVDUe9ssoINAy+6RijsoTCCWYiS6naaFpXBpwZ/7hGD+gQbBmeT+WczVq+HFTUzy
         7RRr2flEw4BlAqeVUu/SqPeujtLcrat3lNUnolgkCoITozLE9y5TUkX4LJQ/0gLNitVr
         r/V2PkDQ5kwudFNStd31O1CKEv/e1ujEbCRxrgf0DAi5lw0dXkSS/ZroeXkJGT0xuN+t
         TdQYOZI4q2rP4k7za1Dh3QeCYU+e+yMnUgKce3zK1O5lxgTB42du7dIw3k4jpnlJTTvk
         T1cvh9w65YLXpZj29ZgmYo3J9Ula+qG3/uct1wzjqBfxQWtWlJBgy583rPupjkQAG1d3
         Cc8A==
X-Forwarded-Encrypted: i=1; AJvYcCXa2/pBh50Y8ShaG7mv2WrgVVtOwygf3qqf7ZUUGzv07Cxj1kxEovJtr3FbNC3gVyJL6zAghe0fuSsiUAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1iUw+EpcRidRBxadNaTwDjOrLlfBDMDKaKk0yIvKFk6qxbka
	WUSGz2pwGU/15sv0gGdF0fxPm+j4FQxG4/UuNaX/AaRXZXpfozY=
X-Gm-Gg: ASbGnctT211nORN7veBGwlItCT34oecErMitBOSTX+LEZ8r7HZO/y3orIfvUcWRAHRt
	I0l5tVHCGHU6WaSkgEyGlrYQ2EHnCFJ4AI926Ia/dIkRQorPObcY7pyfqKAzMCuXYjJHrzAGYLq
	vlKrtZtB2heDdDb9MrQD4b3EG2Za9BTSyr/U68jByEq7gn7zPmYwSO+47O8nizdBs0ix7TTaivK
	io5Q6+BOZ28mcw2yLme+n0DO+ehc/Pt5rL/0hmKcaYHh0YABkm3LZH4hcY95dW67U7ouTS4kd4q
	CTqFWldO
X-Google-Smtp-Source: AGHT+IE6bYWFl3d5aGKXnTjwGCIMDgTOZ6TkNAXbUC44rGmzgLLKpr3hJ9Ygx1WAw+p2DLbF4FwF/Q==
X-Received: by 2002:a05:600c:4f09:b0:431:4e25:fe31 with SMTP id 5b1f17b1804b1-433c5cd3921mr35516805e9.12.1732210190924;
        Thu, 21 Nov 2024 09:29:50 -0800 (PST)
Received: from LINUX-DQNM303.production.priv ([2a01:cb14:893d:6d40:f84:32a1:fa27:9eea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45f6b78sm65206385e9.12.2024.11.21.09.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 09:29:50 -0800 (PST)
Sender: Louis Leseur <louisleseur@gmail.com>
From: Louis Leseur <louis.leseur@gmail.com>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Leseur <louis.leseur@gmail.com>,
	Florian Forestier <florian@forestier.re>
Subject: [PATCH] net/qed: allow old cards not supporting "num_images" to work
Date: Thu, 21 Nov 2024 18:26:22 +0100
Message-ID: <20241121172821.24003-1-louis.leseur@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 43645ce03e0063d7c4a5001215ca815188778881 added support for
populating flash image attributes, notably "num_images". However, some
cards were not able to return this information. In such cases, the
driver would return EINVAL, causing the driver to exit.

We added a check to return EOPNOTSUPP when the card is not able to
return these information, allowing the driver continue instead of
returning an error.

Co-developed-by: Florian Forestier <florian@forestier.re>
Signed-off-by: Florian Forestier <florian@forestier.re>
Signed-off-by: Louis Leseur <louis.leseur@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 16e6bd466143..6218d9c26855 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -3314,7 +3314,9 @@ int qed_mcp_bist_nvm_get_num_images(struct qed_hwfn *p_hwfn,
 	if (rc)
 		return rc;
 
-	if (((rsp & FW_MSG_CODE_MASK) != FW_MSG_CODE_OK))
+	if (((rsp & FW_MSG_CODE_MASK) == FW_MSG_CODE_UNSUPPORTED))
+		rc = -EOPNOTSUPP;
+	else if (((rsp & FW_MSG_CODE_MASK) != FW_MSG_CODE_OK))
 		rc = -EINVAL;
 
 	return rc;
-- 
2.45.2


