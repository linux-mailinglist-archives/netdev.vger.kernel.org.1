Return-Path: <netdev+bounces-128400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB07F9796C8
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0F92815E0
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE91C6891;
	Sun, 15 Sep 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiLPXRR2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E1433A0;
	Sun, 15 Sep 2024 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726406502; cv=none; b=p4v/0oMAdYhBJU/SxeD6l2+ZJdvquMGSHdma5rcX9QEn+M0h2EYeQq3gMwwANtIDkB0DCNoxJSZnmokg0N+GH7dKCKdciKUg1vxNT534aOo+Jt16efufs4cy/Q/lXtss7JWHTHdxpDuvhH1cKaoGOfMpOp8snoptQJLIyeJu2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726406502; c=relaxed/simple;
	bh=rPcG3DiKC0POFq3uDEREDUk8yp6MATjJh6MMHGkzhws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ck51FBjchokoYdy4b8SXAC0w/BqFkci9KHYcKpV4NayEMfEVfja99lkPLQapynLL0CsLZVmyeHv9CsBP03ocvVQ+k9/2jZqK0Cpxsdu2YEUc6g7Sg4pMDdcJdjTZPOuutbtuNYBZ/YCpOUP/A2P+POltiVUtPVym5syElrr63fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiLPXRR2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so29775135e9.0;
        Sun, 15 Sep 2024 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726406499; x=1727011299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idfczeylpw7MsiF2AYkY9wjK5lANtO3xiTFwo6El3Vs=;
        b=CiLPXRR2wyEuu79yfSQFzIavMgPIl3D6KLLgMORGxHqR0N407X85m4JpgjK0Eol7XU
         /f13nIM3d1rsNAJObo+qZ97Z3r8HmwL2cNorWcfEzdH2Y5jYQdFv5jxnRAHdEq2hxBwD
         rTLmVGJuHXW0fHOa0cHnYXdaOKXon+9t8KDcD0wI3N39QQIsjNwGwrMaAmlevyf51NOe
         iYy2rjul6xevMnPiMFhBrB4budJHKBrYJsv+RWaLW7UW6/MGKuXY3x6UBTcNTLMSJSlK
         f3YmhwrKbGE2lgP5ynDuhnHgn07+0AwgwPAGp3G2hqqW6azinsV9icsBYyh9Q0DoLOsU
         9lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726406499; x=1727011299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idfczeylpw7MsiF2AYkY9wjK5lANtO3xiTFwo6El3Vs=;
        b=Ohn9fSbsNwyr3hV9Y0qt+AFAyVU1u4UlpM5xmKaRNv4lNtiNmbPRwnaakznRe0du2f
         uoWTu/9hsjiw9MM2JKza6kCXIl5nyvquLAp+OwCzkMRmPI92ObpWY/Muih16ytKVAUUH
         PehA4bBqfG7tKLqcJupU5U2eR/8OeOx3XWuCMwFf6SHTzx7q/EW2vhlhELH3AHnzl8Co
         D5+2MP7KbdXVsiRuEyBFy5a5uw2uEc+6y3mswdXDs3QfpqMIpnDbXvlUJuJGVr4VpYoo
         9vkqpnizxQyk+AyzvR6qSv67U0tjDSBPl+obBRJElrWvDcqKxGbASFDe8YEmu/LO9JM0
         T4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKn3R/TdyN/2ktMsJBfYwUTo2gg28v0HWBCSkdhYGErLnCeZ4JOUS8S6b3niyqcCalD6pV7Z2rZ12x9Fl/@vger.kernel.org, AJvYcCWqZ9xQ7uodwnVDcD9HhvD1TtqM4TgmkG9RIpWAF9zGeTH37trm93u+NkLMcMRB8plyHL3TpskhX30v9sNGrFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+/pBl2mgWzvZGvgxZ7AspjL7dyZbqGHBLyzc+XKbgQFeLL5J
	T50+lr52ITAybWZHAfDb76A3k8UTssFdHipyMwxaOwrtVisqOd/s
X-Google-Smtp-Source: AGHT+IEdu2PhHg9YVIjt7bz4TXO2DH+7s5JJg77yAikm7n7y3DdL7llEuZiHnUqGtBPPqexmNnElAg==
X-Received: by 2002:a05:600c:4f51:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-42cdb487cfemr86339375e9.0.1726406498448;
        Sun, 15 Sep 2024 06:21:38 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da242138bsm48815275e9.35.2024.09.15.06.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:21:38 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] ethernet: chelsio: fix a typo
Date: Sun, 15 Sep 2024 16:21:32 +0300
Message-Id: <20240915132133.109268-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
Keep the layout intact.

 drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
index 4c883170683b..422e147f540b 100644
--- a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
+++ b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
@@ -49,7 +49,7 @@
 /******************************************************************************/
 /** S/UNI-1x10GE-XP REGISTER ADDRESS MAP                                     **/
 /******************************************************************************/
-/* Refer to the Register Bit Masks bellow for the naming of each register and */
+/* Refer to the Register Bit Masks below for the naming of each register and  */
 /* to the S/UNI-1x10GE-XP Data Sheet for the signification of each bit        */
 /******************************************************************************/
 
-- 
2.39.5


