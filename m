Return-Path: <netdev+bounces-228950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 939ACBD6565
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C3A19A0202
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 21:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202A2D9ED1;
	Mon, 13 Oct 2025 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPvG3u0F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39422D4E9
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390095; cv=none; b=PAlmv2LC7rJI3e8FmeWGJ48n22/qOXFiKCtUGQ+1vPp9ncrL2x+NpoHz2+3+7UlpgBSvjZScnPVrJCmMruhBCGwpjiCG4NTyYl4eFMkGJMPcUDwV6u6aHW91Dz+eM9ZsxETnR9jmz6BUEdDXsLk55M6G+fH3tK899F7DQfSeZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390095; c=relaxed/simple;
	bh=FXKnWLipzyOjCV/JuxZOMe9e34W/o2jHr9FpwFUq5U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXcNVMTqLUqQqM1Lqht46098lQIV/1RmwmsoK2bLzJ2EXQK06vDcYd2QJ1zhbV2GgvFhEfcZzoin1skDg9CX874O516UQgII6AgKxu6sqt/GWTDvL2On+86Qu0JunI7sEG4Eq2ZiqUqkYEaOEXS5SMBp9Ogz5GccuAvMG7+XP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPvG3u0F; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-64e5f669511so2474570eaf.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760390093; x=1760994893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goaqvGEJKuS2hIGX+Z9ykCyJxu1Z7XvKkjtUr71VoHY=;
        b=OPvG3u0FCUVOv/Xkd8x1EsNkSIlzVew2lYIBo92lp9tPgLlMiA4d3/HBmKp99GirOi
         tw1dsXYvd4BxPS5bq7k3+HbdrzvEcCegWjdEnrjJv6bLNTKBlcARxQK1eJEO+9JwUTDQ
         o5YHP/dZ0bPHbjWG8msPSEyzEg8OizpqQVUV1Nih8eGVVHHKHUXbOGDPQNGd/uvCrm73
         0t9v237AfftLcQS0wQ8qX31PLVW5PA71jFh6o6QDpeIdYFXKHIk80gMhvRKg3epBkQTx
         dfCsN6gJWVZ9//aGyPxv7oHKNJaa1vmkkzGmUr6wI/7CSk56/xS0H0sOrfUK5CCOJ++b
         v9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760390093; x=1760994893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goaqvGEJKuS2hIGX+Z9ykCyJxu1Z7XvKkjtUr71VoHY=;
        b=o8ZJR40NC/M29MTmD7CV4hTwCuuRcntvXWgmOVd2oT0pjJCqfXHj9ZKV8xBU8FP7ij
         BlbLt+NzUXB+mYupx/fRcqBGDlM+Vcsxs2nL212NMk8Gy86Kg7m+Tqk2yxJ2b4n1lkzi
         Emu43IPsH9SBjel+Qj7C34XQtUchEAEb8icBhuxIqaeHcdyrCotO0gh2wVboDAeM71N3
         gu89a5Wd3yaxS6C9otwGZSHJ2D7e7YJgd1LVNtotkGQVI2V6DoPtMtGcTVbPuYh1q78c
         lA8LwrWGHDRo+J5BcTTxUhWdFN6ZeE8fA0timkBqr/nBvQqY9HR6r7Dpjbc3KACLgeZU
         5lfA==
X-Forwarded-Encrypted: i=1; AJvYcCW28ctkqj+9OeFWYHujjTjtRccgl60i+aeKzajk7aIr0NujB+lbWvGSidCVU2pqjy/gPgVlwn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7sHqK0noBJOzSlfTsXkk7GqzwWjhpZKOK5Chn46MGu0bOMWQ
	VXmBykJZa5E1Glgggb4pwME4huJuGhyKgKZdZM7iBbF7iRoZggZisHCW
X-Gm-Gg: ASbGnctcJARyMViggbXHngZhZb/hwFUnIrcD2GOb6Iyd9wtrcYPrdkXRhwiNNlgoHkp
	IOdpmF9U1P+M8XWxFMO/S0ZQxRijIGWxCWf/AsozD9di5DxIPz3EDNGo6SXDehBajQcCA4HQVJz
	35w0viZaUiya3GoaEUDQ0LYISmTV2vvreq9NjPkNID+bwoMMbk872+6m6aybgwx2u78bI6IXmqz
	/vMv380TJkmwoRs7F5ajaIkDZj08kIIss+RrsdL9J/DyDnGQ58/Gd/Td7HT+QEMiGJyPFNmr1Ha
	ebOMXbcHl6O1SnTDW2Yr9TuBZDFuImlsiIPKa3kP+scuwcuqj/aSdT9jBMBPAikrRTCh69krW2j
	DnVYsYIHyEMNvqkpCuI3P2ZLiAsCovFhiLUD5PZ7/FfB3pyJZBecUIhWE1ZY=
X-Google-Smtp-Source: AGHT+IHOm4T5kndyJ81BzVXfixdjwFiRd6ZkzPpg5/xpzlvS2dZLJIZ8e0ALBrmih0X9cIJOBJsahg==
X-Received: by 2002:a05:6870:6122:b0:35b:11fe:3d1b with SMTP id 586e51a60fabf-3c0f6bf49e1mr9624051fac.18.1760390092734;
        Mon, 13 Oct 2025 14:14:52 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8bd683fsm3834751fac.12.2025.10.13.14.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:14:51 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/2] net: fbnic: Fix page chunking logic when PAGE_SIZE > 4K
Date: Mon, 13 Oct 2025 14:14:48 -0700
Message-ID: <20251013211449.1377054-2-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013211449.1377054-1-dimitri.daskalakis1@gmail.com>
References: <20251013211449.1377054-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW always works on a 4K page size. When the OS supports larger
pages, we fragment them across multiple BDQ descriptors.
We were not properly incrementing the descriptor, which resulted in us
specifying the last chunks id/addr and then 15 zero descriptors. This
would cause packet loss and driver crashes. This is not a fix since the
Kconfig prevents use outside of x86.

Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b1e8ce89870f..57e18a68f5d2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -887,6 +887,7 @@ static void fbnic_bd_prep(struct fbnic_ring *bdq, u16 id, netmem_ref netmem)
 		*bdq_desc = cpu_to_le64(bd);
 		bd += FIELD_PREP(FBNIC_BD_DESC_ADDR_MASK, 1) |
 		      FIELD_PREP(FBNIC_BD_DESC_ID_MASK, 1);
+		bdq_desc++;
 	} while (--i);
 }
 
-- 
2.47.3


