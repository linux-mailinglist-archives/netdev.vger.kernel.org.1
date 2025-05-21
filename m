Return-Path: <netdev+bounces-192207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D23ABEEB2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48419188ECCF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C4F23370A;
	Wed, 21 May 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHO0BeDM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C24236A70
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817839; cv=none; b=Rk6Elb8PJTs1pAkOFs7z4cU3PWYK9MM/xa8eYDEzA7LfZLJmWpeMy0ncHZ5t3fvtqAu6b0xyO9Q+PIttA52j0V0GB49cg4yomEsHIciAt6EtbYVt1Lj3g46xEq6frrfnHtne2vofLVKkIcEn31rMfpX7V3W+Py5AnVgyyl/gRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817839; c=relaxed/simple;
	bh=CuiAzH8TWBQ6hsj1XQd5STMsT5oYgE3ZD+GMYGuQ7p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSaUt+M+cbkZGf9nleWfryDsckvgUgbefz93ct58yAiPsSPHoKY8ELUhtyhLMd+ddQrlVJA2hJjcFG+HUmZumTfiQUcIfuWrELCfDHGFqX9nEnU0AJMCIz+3LcefQauAfNIC0g4VjwHZkQjFMuLGMCW20qwHuOfYzF/2hHovm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHO0BeDM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so5623266a12.2
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747817835; x=1748422635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N387pxHdVSd/OCAm1SX+gl4E1/rug0lWTP4/Ovt1H+c=;
        b=CHO0BeDMALOqONbPGLSROmOAN+twMMcjWUMK6ikvTDiDoBBlhFTxNYnVyuJhCEchxL
         FRWBsfEQEgi0hmKV9vtZerBeN39/kiv7MeqCcIebjHCvwY4PpkOhvCoMHAWa8ngWjAYX
         iVQOXSowfkDAjDRPBHrdlhMuzOASb1TlPssv6RTJv8S/P2eu/vOJRKGDXM2tmMFE+eGu
         3PKJtJS2dOFh4G32zkDXMeGpncAcisoMdDUWzg7SWXcdvfbRKIqeqSsfY5dyYgGYwaTr
         6NpRLcfoEEekN27v+DkK2ljExVaXZ0qq64TuBqyls9vhcpYPj6Exosf1z6Hmjr3cuPIm
         wTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747817835; x=1748422635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N387pxHdVSd/OCAm1SX+gl4E1/rug0lWTP4/Ovt1H+c=;
        b=XrSQpbxlWcKstt+arD/Qx0aPe+TpA5bor1D2m9AzhIupOx7B7nCZNO6+wfFsaq6qxr
         ggmFcnNRAZVyX/G+7T12fpHr+laGd0pmx4+LuPoApCu+/Yl1Z+dVZof3aBT0ttf7j8S5
         KhzlO1BeoqtbdGM/FrdXzAs0sXx5+E+s+LMWW9HkXmw6dQ7hr0mr4CV/vywSH6SUV5tm
         oCAi4F7AsdpCVPHw6NY44o7jR0Ki6Jb4Hr1znVo2hCs+xPGhM8mMn9mqtV1AEmJ3y7Le
         C1qguWsaWjp845m9gUpfI7x+/LSC+kuFAlru9wGkP9Tf7Gv+Th2xrKUWBm2nehQn71a8
         OdGQ==
X-Gm-Message-State: AOJu0Yw8xO+nz1Llr/vcb4vW36r+bjNTxoTqA+XBJCCI615ZesWrHEyd
	mc1QOWNU0MMXZVoFraxby8MaQzUQnI7GfD0uFbVKkGq/FN2w89JXoEtPQdSrcQ==
X-Gm-Gg: ASbGnctFfsS85jj/kEDUbqjfYc3JME9zb2LDnrthjp8z9i56nqIk1v2Mobr/WVPuzP8
	pumOMXszsmfracuCdQ5Ntx5ol56NG28QDzP6Acz2ZjNMQJEWYkVbcsvssopWo7QnpHSvNzvQD4o
	Q2NbF4/zY4qNlpYQtCneh0CeIN/YvI3W78n+0QXI27qkPrBly+m3r1tjh+t8faK0HAVIL7ObfnX
	90LMPmL0zGd86DvY1XnPgoRtqm/86d3PnfMDNrYRDRDLqzPLDtMmoKgW4c636nZESHwp4wZeUqq
	Xyqy0dh2GBqz88WGK1VrWLGdd0NZKCMQqNZHsUmPBet8/WwkhXUvYMHUCZiuOf427PFNVGMwigV
	cww==
X-Google-Smtp-Source: AGHT+IFrHANQwPoEscKBHncbptskBNmqwsabtBklfD3HDRcV94tEDBU/UX7+kJ5CUcfjf8t/ARW+WQ==
X-Received: by 2002:a17:903:41cc:b0:215:a179:14ca with SMTP id d9443c01a7336-231d43dcc65mr266271375ad.2.1747817834532;
        Wed, 21 May 2025 01:57:14 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:3140:a3fe:81b6:f3a6])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-231d4ac9fbdsm88877335ad.50.2025.05.21.01.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 01:57:13 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net-next] xsk: add missing virtual address conversion for page
Date: Wed, 21 May 2025 15:56:33 +0700
Message-ID: <20250521085633.91565-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 7ead4405e06f ("xsk: convert xdp_copy_frags_from_zc() to use
page_pool_dev_alloc()"), when converting from netmem to page, I missed a
call to page_address() around skb_frag_page(frag) to get the virtual
address of the page. This commit uses skb_frag_address() helper to fix
the issue.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 net/core/xdp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index e6f22ba61c1e..491334b9b8be 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -709,8 +709,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 			return false;
 		}
 
-		memcpy(page_address(page) + offset,
-		       skb_frag_page(frag) + skb_frag_off(frag),
+		memcpy(page_address(page) + offset, skb_frag_address(frag),
 		       LARGEST_ALIGN(len));
 		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
 
-- 
2.43.0


