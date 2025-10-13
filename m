Return-Path: <netdev+bounces-228949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6EBD6562
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB033A5C57
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 21:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D82029CB48;
	Mon, 13 Oct 2025 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktat3RsU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDF219E8
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390094; cv=none; b=jSrgrHw7KMjpRL/ELCVzif7Hl8tVxKmwN2JEnFJf6ez+l8nEa6+I2+C7w1Jw0JAMIHJU81dww+vdoUEo14eXo2aH4/FN7zxS4/T8/z88dNp/41z6jBJHcLPXsw8O6erd5lb8SodO5kBWZoSX8U+x1fMTcQZf+CDEATR91E2ydd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390094; c=relaxed/simple;
	bh=fiVZPoISxgdsWpDRlbthWnPi3DmwLnYay4eQmY78Rj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6m6+FJEMBUwKOBGYm8c6v9KcMVGTVqrm/vdjTrjlEF+gkK+bMvwIqt4OtreTlsjf/h3SCyqtHkAYlwJDMSP86oiEAwSlQv4j0os5aGGZ9wWfNrkg2Dnj8av2QvKLhXRWN+7EPBoH58CYnR3JanfcVp1uV0f9jkilTrokXVB8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktat3RsU; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7af40016ab3so3250534a34.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760390091; x=1760994891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxXABW+Lic03ma+LulOIrKLZk3KJJ9CW9RVHua2P8ns=;
        b=Ktat3RsU6+72cLRCsqcDAp5e629WfZFDGJdkVT/KeAPRN9qJJI0bvS12zOy1/5IaUs
         YrjKBXwMuwXLMNS1hF8hakXs5Ij6cIPu+Ce903ILi7F8MxBiGQga2NGuHlgzVw3sbhRE
         e/Mgdo21pSLVRFTpn1qQGlXse1p05EPakn/8q4maC3M6WBgoxdOrHWCPxcuCju8CxTuZ
         Qf6dQNzIAh9GMf7Xj6gBtm0HVk5k7WA14ogR431KQrIHaczU8CotadNjGndAtMl7ryvo
         jY0u27xT1S9rdCesvv2Q3OZevOGA5wh76xFCYueK9KxKg8ISrNyJSkmkAdKMIzYTgr9Y
         6OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760390091; x=1760994891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxXABW+Lic03ma+LulOIrKLZk3KJJ9CW9RVHua2P8ns=;
        b=VECyWmYCG5byyF1mJZh0iVJ4sXoq00qkRVI28tMVaqJxNYkgzSaKhKBooPvcDqenoQ
         ehSTBjzukT0G30cxBG0RywZbfeDYeCOzmD4AJZOJU1oIBrVzI9DCIrF0aVHvehKT4ahD
         akYGGw1cqge2eDJBRBKubziH7OjQMqRSlnLN8/DWcq0YclB0qMFZq/fTykhFp27blh4+
         39iys545jejazltyDEWtL6UVyYskFBdukWh1TahaEHa1DMmLlCCP6LrkxGupdIGOHntt
         EgAQfjpR0YpQP8k+GGAE5pDr7e7FtuY/yLpktFrNX4MMPj/fFX1ncZszPi5CJ7kRx4cW
         Xv+g==
X-Forwarded-Encrypted: i=1; AJvYcCVjnFHoAv7CugupC7l+QeGAdpS0wgHBr0BHVDV2O7qAD/7rCuueF6EDC8t+P4RWlSktcJtf7y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrF/AiXCm3G+Y8VCEbzYIBXWk4kIbvNjiyqdybzpjjM41LdQN
	OLPh7tfUfxvn7zyX6YZXeVgXIawyX7uL2nUKgqFeJBQn+jNAWBSMhG+/iUSW/A==
X-Gm-Gg: ASbGncunXYs3yqYanehUl745Ys92xX+w/oi6XnYIZh62xA93YKgrcL2B4F8jOHJo7S+
	UgC5su6EMg7iUNM1ZyHLrOT1719pNrhyBUlbNZ+5qTgYnAmpMlMg1fhBrSoJWQFxopRLTSbdbFZ
	Lv1TAWy/mS8LlQtb2IPNFm+z2yhKcNhzIeNKXW+7ybBk/r8j2uuXRevQTTCBlIBYgocJjIu5zKo
	6D0vs52peYhj7A4DasbXDKzMj5KhNS2/O7Rd6dT52nHPqQ1twDfjmuUqejTAwmDR1tCaqYybqd+
	ZCLC3IhfQMs82qltd32nmB18YzD6FDZ45LyFAsyE/mZx8/sxf3eC5UeatJLpnMzgoAhsWGo/1rU
	R1cx2O1XggyhXgo37EPDJ8c0c6tpZi691D8nZw21KNK3VMlccTynrXEc5cYHxfUMOytTd
X-Google-Smtp-Source: AGHT+IHjM1R93jlJk9QAmUVhPTRkSV5Mb7eLKP8CacnnDAFfvtuQiWEdtkuXnbSSCuIc5CBbP6GNFQ==
X-Received: by 2002:a05:6830:3c90:b0:79d:ebe:f238 with SMTP id 46e09a7af769-7c0df71598cmr17132862a34.12.1760390090878;
        Mon, 13 Oct 2025 14:14:50 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f90fb2b7sm3823153a34.22.2025.10.13.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:14:50 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] Add aarch64 support for FBNIC
Date: Mon, 13 Oct 2025 14:14:47 -0700
Message-ID: <20251013211449.1377054-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to support aarch64 with 64K PAGE_SIZE, and I uncovered an issue
during testing.

Dimitri Daskalakis (2):
  net: fbnic: Fix page chunking logic when PAGE_SIZE > 4K
  net: fbnic: Allow builds for all 64 bit architectures

 drivers/net/ethernet/meta/Kconfig            | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.47.3


