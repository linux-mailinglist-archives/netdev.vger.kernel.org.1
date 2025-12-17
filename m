Return-Path: <netdev+bounces-245136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E679CC7B6C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34B2D30985F6
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41A634A3DC;
	Wed, 17 Dec 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv9ns7cC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DBC34A3CC
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975661; cv=none; b=MeS2A7gfs/+FTI5I3RmL4OHh/ou9ej0jwTo2MCfNV5i+waRYbdX8Mkm8b3rzKTfi7a5yzQIM8lOron2fA+F8+GjUkNoFCLtMP3ZIezCY1QB6aJ2WYPNY3hx5GxzrOIpThFgpKzQ4QzU7Cyd3zSdPIlp5nWvrFoJD0rVEcgyEsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975661; c=relaxed/simple;
	bh=JR4+kJaBlmpbY4kjmuT+WtD5sCcuiWQvS1lbYm26OEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XMUVlChCeAe/fXBmIEk7FPwqHUCeYyPUG51gWFyspfCZg1pbqycIUJ3D1Qh45cGzT89GWdmX7JInLubh4vJ/0P6PDgQmj0YQCLOzelmka1dIUCQ2jMHKJf17Kt+cpqg5W2D7hVk7HWtHhpvmHErnZRUQZwEJWZxyyXYmJaxuF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv9ns7cC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a097cc08d5so8584755ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765975659; x=1766580459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3j0D4wFBpoCqxcj3+92dqkBBHNQldTemKoyK60bvQY=;
        b=cv9ns7cCE11T2uc7BE/THK0dhyaErs2Z8WdzvHVhc9cxS/MwTYHfDTFmchqUSF+c6a
         2rv9+2/9yFYpbDFme7rnXi0GC7HMGYj+GchWN/8RbtHu+1QH85/dtnh5Bdg93iW+nGRU
         f/zHZNcgMSwqaAEddSHydnhvwGiGd9aH58LRkbBzgHB37O9v3ikzh07H/1cXClZlO+Ci
         0E590474L5Zm4Kje38WwgID1gB1E1WA2MHZp/lKSblLokucQ4yj9M4lWIozDhxUr63x5
         by3r1D08kAFy07kr6ncQO+4CiA4t9IHfAouV8nL1CQUx4B7Tt7KOKg1gauIsAOmpyrSt
         eb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765975659; x=1766580459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3j0D4wFBpoCqxcj3+92dqkBBHNQldTemKoyK60bvQY=;
        b=evZB/e10Mm+qkYm7ndy6Vtv7Vgo/PSLfPPRuYgf27V1386mVYPFy4K+nXOLwuzCbjg
         ntSgoP4SdrCVGV+c5+a/vacejAj60TOrNuEmuD/ElWY3M/xi52gB6U1b/KTS+qKAkK/A
         u393yRv43hu4sBQNZCZNAK0VlHny9YZJJfXR06z42UTYbPYgfYWsRxmTLfDtNn2gplF/
         Rzaou/sA9OEQs/odgjnN6eh1RSpJtqzU8VQqgvhLmyrkfy/Yl/Ms2rr0SkWDHkQ3yjkF
         AxbF0PHU9Uqmowi5VSgKUgN1773Eguim8E1c9GyNlSheuJe2cOxwtbH8OfhIkPpcUI4c
         Klvw==
X-Forwarded-Encrypted: i=1; AJvYcCVli97G1NjPWOVFO+nKE+Vt/+jzc208Hc2LbG8NiHIK0K52odqp2ivDHROu1l7gKEzt11l3sAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymzJKKR5w8nIsKUWTAz5fgFBQD69lxCik3bDKIdzl90rF5Srov
	GKjn16xdxIDvRtdEjHCnzz14X+0atUmNXL+j8ip+pFXm/D2vVEe4v3uV
X-Gm-Gg: AY/fxX7zykNgCnT3mWz1pb+pbdJGZV3SMqKjjcnJVsog+b9E7hsFsYHF+fddpemsipB
	o1jsMLmnX7KbHWsJf0XHyU8i/8PUJNuyHsiZQ1abRjl2AuaRHN8FU+oXoKGpIocDwj17Syj/d8s
	hatRlr5C+ub2fmfMC+kyhXu6/mWZ61fXFfq/vHJnZAYUcbFDNW3NjGCTdk1xQh7df09O4bBkvml
	GhfycCx9VB8yp815f17GIQVOvP/xfWMB/EKq8GsM6CAf/4X3IXrwqfi+gUH5uquRVco0moSfjXz
	bETHEPFVpQ+1w1N3KBJOGQ0xJust1Ct7o/hjop8yfLicgCn/NnimrneqMzGMuPx6ZXhBKqUUVou
	MlhK2Sza68sL2nf2Eb+LfJsz+VK/j2QQSuFYhYvmkm7muVwZr7zW23KDZwOtWEhQ3AHipmq/V3U
	T250HksMqhz1wscQdad9tEJ75Cl0ExjAKT6X3qg9I3NLOCy2eRHxOS15H6rEf8Ss0kah2PIPpj
X-Google-Smtp-Source: AGHT+IH2v3JUr3tYGdDGzF39tRQhcdxW5++x3/G76FKsq3X0gc2QFhfLukE8mQjsMLw71amUacV/Gg==
X-Received: by 2002:a17:903:8cc:b0:298:2237:7b9b with SMTP id d9443c01a7336-29f24388becmr116421805ad.7.1765975659178;
        Wed, 17 Dec 2025 04:47:39 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0e96df1c9sm98306795ad.39.2025.12.17.04.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:47:38 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: linux-nfc@lists.01.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v2 0/2] nfc: llcp: fix double put/unlock on LLCP_CLOSED in recv handlers
Date: Wed, 17 Dec 2025 21:46:57 +0900
Message-Id: <20251217124659.19274-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a refcount/locking imbalance in NFC LLCP receive handlers
when the socket is already in LLCP_CLOSED.

nfc_llcp_recv_disc() used to perform release_sock()/nfc_llcp_sock_put() in the CLOSED
branch but did not exit, and then performed the same cleanup again on the common
exit path. Drop the redundant CLOSED-branch cleanup so the common exit path runs
it exactly once, while keeping the existing DM_DISC reply behavior.

nfc_llcp_recv_hdlc() performed the CLOSED cleanup but then continued processing
and later cleaned up again on the common exit path. Return immediately after the
CLOSED cleanup.

Changes in v2:
- Drop Reported-by tags
- Add missing Fixes tags

Build-tested with: make M=net/nfc (no NFC HW available for runtime testing).

Qianchang Zhao (2):
  nfc: llcp: avoid double release/put on LLCP_CLOSED in
    nfc_llcp_recv_disc()
  nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()

 net/nfc/llcp_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.34.1


