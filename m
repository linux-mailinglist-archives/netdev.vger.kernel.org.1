Return-Path: <netdev+bounces-227857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E96BB8D69
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 15:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFCF34E11A0
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 13:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C902264BD;
	Sat,  4 Oct 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5PD8unk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AA3207
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759582837; cv=none; b=pmYjK9tG8kct5MdAZySMotbd7zJeYmRW74nSkLRiaIj10EeXxYcwuphse0Z+4yU+hsZU2PEwqtCG8+tZM8ikXsfIu6KrbYfX9+bydz8sQXKP9GmKWPbpP4j/HAyT8bApKu8z7f4YAhLDm9JaLm0pqGhhcsbey+9ETettEISfG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759582837; c=relaxed/simple;
	bh=WOfQbqiLQi9ug8/YQkft29gfTq4eQoaDLobj1fyXQyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9XEi/zlIh+4dNQTYbge7UVFTBQx1zyK/cyM2UjvMVRFi8E64noR7hcpXZcm1ZEsjGaLYQfP4X812XeYp600ZLdcDAITFAYjIx66BeRLKzDE2rizB17Ay9WxZSuTbrILZk/AuqI6mgM07XmVPhphRytfY6YO/kog9xpvwuC+3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5PD8unk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so24366475e9.1
        for <netdev@vger.kernel.org>; Sat, 04 Oct 2025 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759582834; x=1760187634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUSacOpwUkhYQJEzSIzuhZ2iBaIm5JbEgWtQG+WCBds=;
        b=c5PD8unkBngKFa1tOK+bMdTHslO0k/9coSbFAbZioSrZSEFrUWs7FKsuk36yYluARe
         WTDjVnYOXyNW1foqfVvhIWcOS0hxiex5ILgvjvhXN1B41Rw8Dhp7znkaLZI0Dov0eAhb
         deXiKfZjzlHBviz374jemFmQB1VUP6ZPQkt5vQJePp9pgRYG5pTpOUzWacB43vpKxUBo
         SRk5IdQj9uEmnv7Y/H5iqJr07y8qryWd3j7Tsp5+XoZv2okD22MSiPo9btoqNQeTL1E0
         wEA6KxJf539UaJp+GrQg9jNXibSBDGlqQ/BlmAepwseBM73aMe+nuVgoePlo2Up2hOVp
         9RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759582834; x=1760187634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUSacOpwUkhYQJEzSIzuhZ2iBaIm5JbEgWtQG+WCBds=;
        b=ZxY6AnZ1rsQp4l4qTQeLwcLtdAsxYiu1V01lCy6+kndBN+szRgX/cytvGBpXOmcPb8
         seVoQK0Opn7f27atc/F3/8SCl6wBCCItyS47Tw+sYpEHr8Ve53Vn2Hv3PHTxqpoHw4Zv
         iyCw0b4gSpss2v1g3/QFk/hWnt82EisS7n8ip89bzVT4N803T2LeqRqed4B8NbXl8FGU
         aAJ+G6xmoofwJ0hqFhA0qxaqsH+QVhOg1QNsmJ9BO4MUV74clvxSxkuj/8YzMQ4vkBoP
         USoO8eD4VabFnHOmT1VzFbvRa+v/1drSKDcHbm/FpbB47lOc22WDdcYVLsTKAHPxhRJC
         kBcA==
X-Gm-Message-State: AOJu0YyCiVtX5uhivp8gLcUIWMRSVMcrJTYpk5lcMlEqChPgmb1lBTZE
	jiEpDYTc8oA49Y/hnYNT9M6VZrYA2OLErY3J+elEo+VU0Ete+5PM5Ksv
X-Gm-Gg: ASbGncsBWscwPEXSEUlPBnnLV4utubn6wljeaXROPNmjWE8Nw5g0PA5dgJi9y4I52He
	cCkfe/nMfWmvPCYueYEYTRRWKGlZsHvIcNGswslkF94Trn669MNtGfkahVw76vM0ILIHLjwUjzE
	xnfNAFWQabZiBFASUA5m9+UB/aZoTq4x6q/p7JL2JGScPDb7wH4WGUBIee93rFHkib8IbBa3nRz
	IhKii7iiypZnfsmU/rzr+DRrKCAozoPDEmOoJdkMShP/bSxC0XjEQmmjSeVqfq24QEZDDJFB/z7
	VNwB4fNlYwPWlPNEwcjPSe/3dic6Hj9qum6GCAYoED2A/LfXvvQAEO+XVT57BWMQhVQI9CuIcv2
	ctDMD7zy/plqpUNBIAmVNxDfNIsmhOOh/KYyhmbbRfSo+hxFiDg4=
X-Google-Smtp-Source: AGHT+IFZ/EV7PHa6pizueu5EVPvTjaqTLNqkpxUOwAYwb832MSFSJZcV+KGHkGs97t9Qc27EgHyU5Q==
X-Received: by 2002:a05:600c:19ce:b0:45f:2919:5e6c with SMTP id 5b1f17b1804b1-46e7110c3d5mr55360575e9.16.1759582833527;
        Sat, 04 Oct 2025 06:00:33 -0700 (PDT)
Received: from denis-pc ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a4161bsm181597935e9.16.2025.10.04.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 06:00:33 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH] eth: fealnx: fix typo in comment
Date: Sat,  4 Oct 2025 14:59:42 +0200
Message-ID: <20251004125942.27095-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in a comment containing "avilable":
replace it with "available".

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
---
 drivers/net/ethernet/fealnx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index 6ac8547ef9b8..bf72fe6ca187 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -196,7 +196,7 @@ enum intr_status_bits {
 	ERI = 0x00000080,	/* receive early int */
 	CNTOVF = 0x00000040,	/* counter overflow */
 	RBU = 0x00000020,	/* receive buffer unavailable */
-	TBU = 0x00000010,	/* transmit buffer unavilable */
+	TBU = 0x00000010,	/* transmit buffer unavailable */
 	TI = 0x00000008,	/* transmit interrupt */
 	RI = 0x00000004,	/* receive interrupt */
 	RxErr = 0x00000002,	/* receive error */
-- 
2.51.0


