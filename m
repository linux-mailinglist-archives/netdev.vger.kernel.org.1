Return-Path: <netdev+bounces-113916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74060940604
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 05:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54761C2118C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 03:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F5146D6B;
	Tue, 30 Jul 2024 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXRtoH4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83D22315;
	Tue, 30 Jul 2024 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310837; cv=none; b=mr8ughudO0VwKZrHUQ9phujFpgvBZN1byqw1+KcT/RhvdG+oo6dI70WgOF8s3y1MKf90lvvlm83rhqRzmIzAb2VTCGv++Ij5asKcyzSbdCVUxkC0Qpn/H+8IDqzQVOuhGzRSKKZgsvLukfus0JDtVhrmem6Qect4j9K1wsuD27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310837; c=relaxed/simple;
	bh=YIVJK7qavlVu/lpvL1z7Y0qhDDDzATFp5dl2mGa9m7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CNZr9IXpgQK12k1XVllOiuJvgVEEHSGQm2gDGHkv2Ba/WlgNMbHACyglbUlrHltHgBBRFcANDxB0PVLQiVOPIOH6fKt02PAnOQQzO6n/WE/8C6LLqwYNDNV9RUtYZQ/nE8/vz4OW2wij+DOHXbKJGpPXnfQ8oWZTdID2mgxBVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXRtoH4O; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7b396521ff6so17253a12.1;
        Mon, 29 Jul 2024 20:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722310836; x=1722915636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJtNZjx9etI7bcF/1fKvF0Zp9I41hOiDShU7BUYb0wY=;
        b=DXRtoH4OsSNiSR8t67HraRXdVjv3swX1JbzSw0NmfIYTa5OTcvt+P4IYZq/WmAIj4N
         6vc994tLsKid5eg0CEwV+rm/TPqiFCEY2/aGgB5UoWIm+lRxx+osci+WJ4AcLOvO6YAb
         G1uQ4d4IhF+HAo5mvxU47D9DgTrSs9bF/tgjp4c+F62mH0wW3mrjOK9jyCmxU6ddGIqi
         djlhbbriWBEBidXh+92A1mLq7kWJHLjvBiRNKTTiWsJynbk1tLkNDWdglPNQi3NHDDeQ
         8VrNo2FbkE36g5IG0ti1/zohr3EWRyQf2VPdJUPpkM6wIUaQdtkPUwg/DJv/K2v0gAfZ
         z3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722310836; x=1722915636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJtNZjx9etI7bcF/1fKvF0Zp9I41hOiDShU7BUYb0wY=;
        b=OtVR6ej+Z+7eT3mJ0PMUW/eGm5UaN2D+NYYwC1SfbkIdZkXRsPZ7dmdWz99pTVTtbv
         KGBBU9/z+zWytQTmv7+wYDimFHybGbrCNd5tDWe567INiIefyyDH5BK3RoO3Hpb6yNNk
         aUYhIo9TIjPGEIoAc4WlOO/GPypnNxK8Hdo+QsXa6GLhLNTjIRcgz1RijiDb5CIhLV3H
         tgeJ2+yWdLBXPRr1F8PFiZ7n5PthH55HO4LY4hYqSf7QLhuiVCRZ+Vloe2LRhRhBBYXx
         +V97p+Yh2t3EbkeaTPPFoIKA+xq+NAuJnMygkmhZX1PBupBaKnk4WN182ouOlvU/5O8X
         AlPg==
X-Forwarded-Encrypted: i=1; AJvYcCUQk7gA/VGAENsziFLhX0zZ7TMgXL/AiblZ0mpEHMtUeXdy+HG6sHCbqneHOnFK4a1GgMh8pCtMVRu9iFNiz0PLtq/abpGddfyjZxRF
X-Gm-Message-State: AOJu0Yw6SDU/DG8jqDh82GhXVBT5CQe3QRvW6lEfEFhrIHBRepGQ9iA8
	cooIaDG3n6CfnhDUahqRdmcxqruZilfcdedRbIaCyvU//iMv2M6BO+qbBkEqkECZyw==
X-Google-Smtp-Source: AGHT+IEGS87IyT+labjUGMdjw2ZzjPMOQqC0653x45y64ZRQiTK/H/AX89AkmIBqqIS+88CphDWs1A==
X-Received: by 2002:a17:90a:8c07:b0:2cd:4593:2a8e with SMTP id 98e67ed59e1d1-2cf7e1df145mr10575470a91.15.1722310835144;
        Mon, 29 Jul 2024 20:40:35 -0700 (PDT)
Received: from localhost (66.112.216.249.16clouds.com. [66.112.216.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb76013b9sm11364797a91.53.2024.07.29.20.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 20:40:34 -0700 (PDT)
From: John Wang <wangzq.jn@gmail.com>
X-Google-Original-From: John Wang <wangzhiqiang02@ieisystem.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: mctp: Consistent peer address handling in ioctl tag allocation
Date: Tue, 30 Jul 2024 11:40:31 +0800
Message-Id: <20240730034031.87151-1-wangzhiqiang02@ieisystem.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When executing ioctl to allocate tags, if the peer address is 0,
mctp_alloc_local_tag now replaces it with 0xff. However, during tag
dropping, this replacement is not performed, potentially causing the key
not to be dropped as expected.

Signed-off-by: John Wang <wangzhiqiang02@ieisystem.com>
Change-Id: I9c75aa8aff4bc048dd3be563f7f50a6fb14dc028
---
 net/mctp/af_mctp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index de52a9191da0..43288b408fde 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -486,6 +486,9 @@ static int mctp_ioctl_droptag(struct mctp_sock *msk, bool tagv2,
 	tag = ctl.tag & MCTP_TAG_MASK;
 	rc = -EINVAL;
 
+	if (ctl.peer_addr == MCTP_ADDR_NULL)
+		ctl.peer_addr = MCTP_ADDR_ANY;
+
 	spin_lock_irqsave(&net->mctp.keys_lock, flags);
 	hlist_for_each_entry_safe(key, tmp, &msk->keys, sklist) {
 		/* we do an irqsave here, even though we know the irq state,
-- 
2.34.1


