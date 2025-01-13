Return-Path: <netdev+bounces-157573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D564A0AD7A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 03:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552D93A71E7
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804E7145B03;
	Mon, 13 Jan 2025 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqBArcGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F313DBA0;
	Mon, 13 Jan 2025 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735855; cv=none; b=gXSR23cr7MC2yE7nG1w+/hyujQ2G1mASFCTqYIiZRyfkvmwOwon3wex9oHsvu1zOEAkMQJDZ7jBd2BleDKLlMuKhr0bwzmEAHKpno7o9Q7tJ9mgdd7bmsEeqVnYvR6R/5sI90AN4LbuQJ4nNqFj/uf3BC6kwVPXeoqfMX0JQG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735855; c=relaxed/simple;
	bh=K6gzNZaHfAuSLirvtETdA1F8MqDRR3VW1Q2Rr7rYRM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxnyEcdBekZvUgCVN3P0Rt2szQrWKIYVKaSlDGJNFpldiVLJUCQriKh1D2W8ghI9JoEV3pSf1vuYFTQ8WlurtnYX4/JXA8tUE0ApSoC194eTkkremvAzI8sZAA7KUWBxm2CTkQdgAUBBFwmlBJ/J8Zups2dsHcKlgNVX9P8ITNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqBArcGd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21619108a6bso63169015ad.3;
        Sun, 12 Jan 2025 18:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736735853; x=1737340653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCIzEBmjHcbdVFsyOCq/K70+Hj9yCzWnlFxUuAaeM4s=;
        b=TqBArcGdWaKvcPr0q8uRsVNvuaVPvcLl8mdChLY3IEa5+fOGg9emGr7VzS9y7waitb
         IJ5BJEndP5yL4qyw0yKsNVOOXHyAGH1Z5CrEs3jA4zL0akIJbs365Fws3HdKzTLHBWec
         9VGhVHGU7gPqsPnaZ4mi5UkcDVoorAdvxVDQH4kR/7qBJG0azPk4yTEv4stdt07bGFlG
         4dpLbRrUcCC0fz2Pb3uhftlQi6yGx1VV81GHFdXWPECzzm/d6hhF6bbrK10x+rxFSmAp
         RbB3W5D1K4sETEDFoW/pEjM1bD5P/PE1jSVUdPBE0RVfyf5VEMXkFo+Pa1XRJb7UVRde
         S3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735853; x=1737340653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCIzEBmjHcbdVFsyOCq/K70+Hj9yCzWnlFxUuAaeM4s=;
        b=Nmgm+nmIfCLAbsVLdSzgGgcJIfv+cFSYJW2Jgvl/LGL+I3gidIJBiyyCU6SxyLameJ
         s3rQbP9SGcQaMJimpXTbCCGu3+5KD7nac4g7JdGa72oumDDVSZKVc/J5EbsGVa5i1PxM
         KgNOhj/kmIn6s0gdStWr1UBWhCN1dM/+PdjfJr0mFkpI3B6+zGzrwHL07YUndPjH0aCi
         sb9mQu0msDxum0Y9JuUAhkV1EPSAS0A4OQxHC8kYLDUG+bd6QjLKu7Ny8R0fNgn4EaPp
         WXYnCBNzogFGxnBIZvrgWA+qESKT/4eLomG27deMi2lQk5rn+KZW2HJWcW8rPHy6GQ6M
         crHg==
X-Forwarded-Encrypted: i=1; AJvYcCW88SBJTrD3H3n7DFYuYOqmoEMmcOpatqceLUVaSOPm8Um4+g5QgooxpV3zE2d1fgimWDOHgJtEJ2Q3wt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuFbH9IQxpXtfbNi5s5agoiIelj8+2AbFG3orSg8AOZMLIQWTp
	yD+Ip2pwnSKd0uBgR98/g3rGUiKFE6CW5fpmSbqzr4zztqddagp9
X-Gm-Gg: ASbGncvA3e7smI8PdzpbCICW9HccyDEaz1vcPVdAR7VA4qNfvmmloYWzF3f7ABsBwsk
	cb8jpaHIMZ9VI2ELehWs8aeR+yWfK28CgXeke4VSH51GVWv1cGbnxbvCIYueR53yx0PEIHqsG/L
	jxdlPwHdEUFkkR4z7rXtP98t+0MYm47IsHqFrOtH8iqhA9E5DkG2pHPiKk0Wm90c7IA/FICI3Xi
	Yd06ucQsu6HXBaAyDscQ3dTuZv7BAOjge3nufG4gB1g1M6GY8OeP7yFM7ruF/92UzsCbl9w4wKw
	WPaHPj0KRw3ex+Pbe4nvV4zv12yYChq2gg==
X-Google-Smtp-Source: AGHT+IEdVuOZqroBYneBSuzqVyU9sDDFzZLJWh0eJOjqT0/6Z2B7oluRtIlYJlqEnXcdZ2GgwaZX5Q==
X-Received: by 2002:a17:903:41c5:b0:215:19ae:77bf with SMTP id d9443c01a7336-21a83f4ea67mr292329925ad.19.1736735853291;
        Sun, 12 Jan 2025 18:37:33 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d2dasm44639045ad.172.2025.01.12.18.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 18:37:32 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 13 Jan 2025 10:34:48 +0800
Subject: [PATCH v3 2/2] net/ncsi: fix state race during channel probe
 completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-fix-ncsi-mac-v3-2-564c8277eb1d@gmail.com>
References: <20250113-fix-ncsi-mac-v3-0-564c8277eb1d@gmail.com>
In-Reply-To: <20250113-fix-ncsi-mac-v3-0-564c8277eb1d@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Paul Fertser <fercerpav@gmail.com>, Patrick Williams <patrick@stwcx.xyz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>, Cosmo Chou <chou.cosmo@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736735843; l=1067;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=sce396V6hbw9EP8vuzvWyCBvqGSZSlupwpRkXmGkS5Q=;
 b=eVD64J/F+uLmFWqeWtNdl/FAGp9te8QtW83zFJZsaMwkR45JYAWdfknrNtmfoO7qnnsv+uoks
 z96oBCVl1MLDqza4hRznZsIK47UjmVUbsS42+ayl/olq0Ts8QEzWGP9
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

From: Cosmo Chou <chou.cosmo@gmail.com>

During channel probing, the last NCSI_PKT_CMD_DP command can trigger
an unnecessary schedule_work() via ncsi_free_request(). We observed
that subsequent config states were triggered before the scheduled
work completed, causing potential state handling issues.

Fix this by clearing req_flags when processing the last package.

Fixes: 8e13f70be05e ("net/ncsi: Probe single packages to avoid conflict")
Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 net/ncsi/ncsi-manage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index bf276eaf9330..99e3a5883617 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1491,7 +1491,10 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 		}
 		break;
 	case ncsi_dev_state_probe_dp:
-		ndp->pending_req_num = 1;
+		if (ndp->package_probe_id + 1 < 8)
+			ndp->pending_req_num = 1;
+		else
+			nca.req_flags = 0;
 
 		/* Deselect the current package */
 		nca.type = NCSI_PKT_CMD_DP;

-- 
2.31.1


