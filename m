Return-Path: <netdev+bounces-243499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EBCA282B
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 07:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AD95309E293
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC9530B50F;
	Thu,  4 Dec 2025 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq1/35V8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5632FBDFA
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764829472; cv=none; b=LGwwXg7Isaln8LrtrMQtO1RsHVafXf3I/8KI/y/HbUe+QEi6azZsl+6VbF0e8Aj0faljnNtC+wDSMh5bq5HwI6hexuvBjWEOfRWYP95dgzEprVYrsn6Y93B3bgaS8DPvtV6HGh/IFfKJ3Ktw0wEGmrDKA3YeLXnXtjLay9SNjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764829472; c=relaxed/simple;
	bh=rGBLF8xwLKCOiVEtSg2zPEOPq5T39ES9h1TujRpxN3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mubq6lOQyd2lpLhRVBsMCsKATd9TA8QusACIUgdu+X0NQ5BLmjrbFW7Mdw+HQNlY39Tvme/ImoE3wRVAOZESHgkjzBN9B4dV9dhWJrIHoGgW8wnLECSPlebyLzFtGyB17haZ4f3AzEegWHTlXymD7W++OUCZrHC75E+K9cQcwAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq1/35V8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso979713a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 22:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764829470; x=1765434270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lf4adP25J21BobodMbUDwTjByfXhO/jZrNevIrKqLHg=;
        b=mq1/35V8pwQP8dbJFAq5vycHQF/u/r5yOx9QvvfEEg3gwcXGgObtXdI+CEUtknSBZV
         R2yzp5/+czp1Ia71uZ//xtYGfBo51q7mylMD6AAFpMEu6yYOqza21laL842MhAcoC/d4
         RTH4KS5tAOPvzgtauQgAsQuwDaJOnujPf1HeruCMFutBwm2Vfz2wJSFxGmQDvVikLHMY
         5Oa2d3BNded4l6kVixo1Zl1nHAH8rrdtOcF5UZEanUDreb38IEdcnTlPzjj5JK5joJil
         +Q6bFCWBzejBIhTWcoEthqNE7CiZbQRhbKaZhz38Xo1kOT8zQ1XgMmheQV/3icjxSHL2
         sSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764829470; x=1765434270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf4adP25J21BobodMbUDwTjByfXhO/jZrNevIrKqLHg=;
        b=EcIIAD0zM/1bIskIc+sjKzq6SFzq8sDktDsbRqdZgEFB4CGD0JNYC9bvMwAdCP3+VV
         B/68EVBH6Kua2aqci0hasXJruDF8u3vcI7is5viLWBdlT7eC4BI2QJA2HqyzR3cUB/94
         lj3X9P+HsGNr0ZusbwtpO09LCqlNBPd+CwYtmIHfPCjWZ91W7eIe2iQFYILLX49ry+90
         vUEzo7ogghZhSl8Qdxg29txlQag1vbkkBltTmxgy+1l4N2amAnpLFDf1q0dKdxvOCGaR
         r1Hj5dyrdOEwHzokZpmQvSjjGkWndO1SSkSbnP4FSxzCr/buNGhyB9FDLvd+ATnHxMNl
         sOSw==
X-Forwarded-Encrypted: i=1; AJvYcCV2l3S3cMjCd2L3P3dbP/3dVfQkdZIkeDPflT+/ffzPBGpU2VMNhjiFjJ/Co+e0ejdNCG86fUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZblAoOaUza03Lx+P49uvShzMl3yBGusb2yMnSDEdHEfyCnDq
	52w5JeDA/blSxQRHu4HlfudferdbnumVWyuw2kSe10CrPzi3H1mM1YQ7
X-Gm-Gg: ASbGnct/vY5/hGCsI27f7+ajMIKsLJM1cRMfOy5iKkLvRFlby37d9/Vb1sfivTp06Wk
	wCuxP5nHZJgZa7ITOCSStTSmXGEapyAmeTh1K5usHPK4OTFwCD19S9ggcSCs8KMyjQnXxBVA84x
	nk0U57+fRKKsLyKU0LgbCAc2Pd87symxAlzC/hHRv03+L+UEWoEE0WGThwUFz53aK2vGknWzKTH
	JMj6Ox9L+Upn3Ha7bkggMiSGs1UTCZANYaueKmWwmec/UE6i+C6KSE71sMulcacZEc/6HTixwd9
	9BFxPg7u/cLMimXgRa39PMyxMlQOhdNDCIaERnZjhclmeEEyWxLIhn75b9Nhtthoh5imQ2EHBve
	IUoRenIb4tTP7js6G3aL/b6XXO349RetT9OePRmAQgVxcxgzaYRb4k0Z/3qJHA+dQJGpAxj1sSg
	EO+re8IMNvdSiDrin9r+0qnwqmD6iAsXnkPNAONbeF
X-Google-Smtp-Source: AGHT+IGBvaGoSQkbX0Lb2blhJ1LWK3OjM1EcejMl2JusU2e5IY4nYHQbAfzWPiHGhz1tIYeMAr3JaA==
X-Received: by 2002:a17:90b:2c86:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-34943872580mr1905706a91.5.1764829470036;
        Wed, 03 Dec 2025 22:24:30 -0800 (PST)
Received: from localhost.localdomain ([121.190.139.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea63e87sm804640a91.12.2025.12.03.22.24.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 22:24:29 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minseong Kim <ii4gsp@gmail.com>
Subject: [PATCH net v3 0/1] atm: mpoa: Fix UAF on qos_head list in procfs
Date: Thu,  4 Dec 2025 15:24:20 +0900
Message-Id: <20251204062421.96986-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
  - Replace atm_mpoa_search_qos() with atm_mpoa_get_qos() to avoid
    returning an unprotected pointer.
  - Add atm_mpoa_delete_qos_by_ip() so search+unlink+free is atomic
    under qos_mutex, preventing double-free/UAF.
  - Update all callers accordingly.

Minseong Kim (1):
  atm: mpoa: Fix UAF on qos_head list in procfs

 net/atm/mpc.c         | 184 ++++++++++++++++++++++++++++++++----------
 net/atm/mpc.h         |   3 +-
 net/atm/mpoa_caches.c |  17 ++--
 net/atm/mpoa_proc.c   |   2 +-
 4 files changed, 149 insertions(+), 57 deletions(-)

-- 
2.39.5 (Apple Git-154)


