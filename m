Return-Path: <netdev+bounces-245273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A69CCA1DF
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 03:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D6D3017EFC
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D32BEFE3;
	Thu, 18 Dec 2025 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf/KF8kA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4B25DB0D
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026782; cv=none; b=BgJ+LnbFUgHDobBwovYXsO9iCVLsghoTU4mGZHugIw1dyAEGt8Avk6z/JbnITe9aExfO4Fi+ItEMckv61HKTHvRyTqcCHRwMWMQVfxtb0UHaFgqMBYDWPJkgBg+SGeRObFvhq8CHETLW5EanfVLLJJ7nuaMqNG9b0lTGPSAkutc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026782; c=relaxed/simple;
	bh=3yJqIUEUeZVkFXlqRTAntvExydA8frPoRSgPiza+JEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F3eMazALVMZYycJNeE29cfFhp1RSmQt3Jx7NntjErfIMtXBET4XYaHN77eBEJP9U7go8zem4ENmFicRQNwTN6+yIXIT/7J+p2p7Mkcgyopo9822O4BO/NMRAAH4WwlC1XxD3TZA0sFlyVg3ufXICPFIBF5v9K1z3hNfxgxz2pGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kf/KF8kA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0f3d2e503so272265ad.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766026781; x=1766631581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEuwYEAlKeJ7VBeR49Tc0CIfJrf1FLJO2ifR5/NXxnU=;
        b=Kf/KF8kAWAhe5SrbJeFnD4qZOL2c/yZtigs/SYDh55h1EbUoBC9GJIBicGCpo3c07X
         s81yVmQIEsl/2MLjjtD9SPQmJtCJX2DQRdeU8J0QNV/TPn5lbN547sxxwd+qT5l9E/CL
         JfMok/nR5v7YSLRPjIoP1Yo2ijufYx/L/bK1tmwlddJp/9e8n8LrhwxnLzVBJUcaynYh
         zzBvzyJRDhcjJZsDrZ3oeXnDiGcSWfGeHPwMciOvQylXcZoyWPnxpg6pjUBZkJ3Kq+lS
         ORWy70qcbdst8NI/LsfK2UOIGtm1mGBKwNu2l9ZzVYc4KhC4c1jRMpH7JHIuM4XfpUuv
         BEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766026781; x=1766631581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEuwYEAlKeJ7VBeR49Tc0CIfJrf1FLJO2ifR5/NXxnU=;
        b=bFRbOb+xJiAzF0YJL25IIaac21JX4LY4HdOGkOQfMsJtEBK6l39o18wXjh2FKXA1KE
         eNifinXiKi1SQxx2VXjNtjNCMLUoCkodfzNsIkPzx3f+Q1ZorZYHVRl1Rpc3/UbeOxAn
         UJfGiYlIUBP8V0cFZKyOqKw3Tu+TjPVxazI1ziU6yxpgEeAlhTiK4UkZgYtp3JP5mUCM
         d851fj4UnWL5aODUgqtXHqZk7o6lhKNNz9z2A9sdprb2llBaGtix+zHg3JWfkL3OemM4
         pbVkpynOqReceHm8tFK++CNI+1Fy5F5gd1Fdl2LRS6BtlBWrPNjLcq/LaASUx0V4VmMN
         PXdg==
X-Gm-Message-State: AOJu0YwLh/I88oFpf00tZFj0G8WLWxcPz6JFo1ZKXJXQcg/RjxCkG/wJ
	XEpqmNU0ETJ3F4OD9AGJZKX6JsrxR/trZsfxtkLryTcW76XXcEXqJbfDHpr9jFo5
X-Gm-Gg: AY/fxX7jMq4NpjP0Oya+JCka3WrjFGBw6U12FuBMC77IM4ZEDwZ8CmkQzEIwHbxW7DJ
	OUH7L2kIfgeGD0bj51oBMnBBmepdsTH/px8QZTGIkfQwUtdxFQpiivKp471qVSfoaaWnIz1eNSt
	GPdOuwcnqy67+4S3ZHr/LH+IDQfnYn2DGj68zmcR705nclVwbVU16Sa8VWGFc4ocvaf1r/V7M2w
	2+3NvypoaqRx0hBAN0aqAzgCIOlIl7AcRjSs9ASuAaHJjIccflHCVU7/OytyetUDKIzFmkeqiY+
	IFPuOGzdPtLJblMhgmpugaUYsBogtW3uZNvIV04h5raTh6W1FLH2CMngi8clqxH/Ijd4bZoM0L7
	ZaVb6XT6TRS1o+pTS4nTsetjfrZd1++of40V7KkXjxI/CaqYOLE84+buf5+AoyqBHdAW7fd0N9s
	pgM0w7/dT2/qDdKwH23nZaaDmBNXusUU+RpyDcS2iaWjr8OUE0wu9HzbtxWKZTFJaSf9faxpYX
X-Google-Smtp-Source: AGHT+IFCBiK4vkjcQkByNE/wNdhbQo7lMtKJmkgvLn2E0ZvZv7wYpskVlyPQVdr53mJhO4ELd2OXcA==
X-Received: by 2002:a05:6a21:6da2:b0:341:fcbf:90b9 with SMTP id adf61e73a8af0-37590b7592amr547611637.4.1766026780872;
        Wed, 17 Dec 2025 18:59:40 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe14a5727fsm800985b3a.69.2025.12.17.18.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 18:59:40 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v3 0/2] nfc: llcp: fix double put/unlock on LLCP_CLOSED in recv handlers
Date: Thu, 18 Dec 2025 11:59:21 +0900
Message-Id: <20251218025923.22101-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- Wrap commit messages to <= 75 columns
- Use 12-char SHA in Fixes tags
- Verify Fixes with git blame (both handlers trace back to d646960f7986)
- Run scripts/checkpatch.pl --strict


Qianchang Zhao (2):
  nfc: llcp: avoid double release/put on LLCP_CLOSED in
    nfc_llcp_recv_disc()
  nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()

 net/nfc/llcp_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.34.1


