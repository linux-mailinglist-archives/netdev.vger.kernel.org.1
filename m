Return-Path: <netdev+bounces-224598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6C5B86AB7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 21:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DD15668E6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD302D3EF5;
	Thu, 18 Sep 2025 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gx2B8PRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F7291C1F
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223544; cv=none; b=QPbhA6MIDtO79OAOmtpCAXNb8rhFneW0JfE3BM7bsrWvB2TP/HXm+sXOPFA0Sa6tJIoctlkfOPhntWb5LTrcoAEmLhDVjTQtEdx4xCDlu+n8cdMqhFgGYYm/1Fh2WNyLBMChai1kYSij2InoP3e0rciTl9vNdhrnJOdEm0LITaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223544; c=relaxed/simple;
	bh=x7bf+1ts/ziZ+5YJ23geD4Z3AhU/qaxLpTGasxWhr6w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dAhTpbKL2d0akIJsFB+8QGWwHzuDIxNYE90PeK+anJhJkuWkQ70l5kSG/CWDs0ouNYQD4Ei2DZWLRpyb7dVo6U2EtVsthylZoPxuDyYI6LkTI+Wvo2wTVJSCF6h82u3rYAJLNl/rT5WhTBqWet7DrXYa7zSY4SKCm/hPzRnWWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gx2B8PRz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee4998c4aso1230366a91.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758223542; x=1758828342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MAVB4a9j47f42XzXNjUiGhx9jwX/Qdw9E8LR/fZNG74=;
        b=Gx2B8PRzYCIklaiDZWsHAnmUJNeJe5S8xPMuBFUwfBu17t3dzHOHtFDoa5pXWebXxg
         TWMAXGbUMsny7jNMPm2SA3q5S7Hc0r+KmmPmPA65febp+w8NXdHi9FQSIAQ2prdpsi+c
         bnPq62HUexfOeGAN9E51UfqaT6HFg16wLQd/GZErxRWduxyqpeS0kdi6uUpn8dGPOaI+
         qDT4eIqYfcXIsYj0R3BphEaTv2n4NV/ec/AoE2Kv/2w3Pc5YutPMLyvWza7ej5hy7l5j
         I9owqeRBC+pRvYKp1OO07rJuZhDM5/j4M1OfoP9Vyf3waaZWwnrCNFNZF/kLVpyhj78U
         eaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223542; x=1758828342;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAVB4a9j47f42XzXNjUiGhx9jwX/Qdw9E8LR/fZNG74=;
        b=NspjqHECMDJDMUPLBAUKATdzMe1kCTSrtrplb2q6OiO4AaVz5vgn0piWAMtID0OJeQ
         E8R5S4QKL1hosVgM6c68CvwEC9uMsQ9MZ3kDDK4LOsdfRW62QC6QepDbEb9LfsZcor9U
         UdCFzdwD3P78zWAa04JnQ9d2cKKW6fv6sELeoExd0l5SBgG4XdsyurOGFM7KcjDQbM+Y
         KaI5cQw4TrDccEoClSv3W+mvhZ8dwFHp2ayLZXFEdPtqsLY7bfcjlgaI7PDxSddlqGi+
         MMV6UhRJeQvSDNfdG03GCnX2om2pJgKS2ZFM97AOoCsn8lyzvBTbPL/kz/oPAMhhRTHR
         oe5w==
X-Forwarded-Encrypted: i=1; AJvYcCVC5oOSoE9ZSD/30sF13IekdUCHnS8Yx7J4+Jxgyz/0q1kLxphg2o1FUHlrx+eAr4EMkJZnNLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsjnvZAPnu6/kK1XcRDlqLBrayj+ULsiS+UO1rM7Cru28v9z1
	1S+9gd5a7CUCnFxwkZKvctv4HqkLglt3VdnNyP0evUmNauJ5QBNLAz1Po/ekWIF9MvowRZy140I
	sbeSHUg==
X-Google-Smtp-Source: AGHT+IElXdvd5v50K8W97DLSHukOitZRlAYQZqGf74AKv/O6f4TEJiBmu9KzBMiB5KsTWqZBs3DK5PDO8/A=
X-Received: from pjbsd12.prod.google.com ([2002:a17:90b:514c:b0:32e:b34b:92eb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f48:b0:32e:2059:ee88
 with SMTP id 98e67ed59e1d1-33097fd0ec5mr694422a91.6.1758223542300; Thu, 18
 Sep 2025 12:25:42 -0700 (PDT)
Date: Thu, 18 Sep 2025 19:25:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918192539.1587586-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] psp: Fix typo in kdoc for struct psp_dev_caps.assoc_drv_spc.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

assoc_drv_spc is the size of psp_assoc.drv_data[].

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/psp/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index d9688e66cf09..31cee64b7c86 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -98,7 +98,7 @@ struct psp_dev_caps {
 
 	/**
 	 * @assoc_drv_spc: size of driver-specific state in Tx assoc
-	 * Determines the size of struct psp_assoc::drv_spc
+	 * Determines the size of struct psp_assoc::drv_data
 	 */
 	u32 assoc_drv_spc;
 };
-- 
2.51.0.470.ga7dc726c21-goog


