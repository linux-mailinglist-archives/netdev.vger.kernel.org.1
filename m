Return-Path: <netdev+bounces-82413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A855788DAE9
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4921B1F250CC
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0AB4C9B;
	Wed, 27 Mar 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Azphf6o8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A34779F
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533813; cv=none; b=uDVVWmHe3nWZv/W45VyO9c2l/dilTuaBpxRYxBcaHIhuySFXOFIoYRjqlINAyMclPdLjyBMlnXG9K4KFik51bfc0znSwfxLCR0o74Acm02rjwSJMZOfl+oUgqqUIS6BCl/xMZwYjjnoL7AYg7mN+oLPNfR8jZ2/ViHEeSQJv81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533813; c=relaxed/simple;
	bh=fQTBIUAiGkXYuD5xVW8MURUJ0Dahjd/SgXU1PZygzrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6Az1kEsU/fzIUzqHjLVQp41nSO66hUk/6Uw5+N2E1YGBqUhTaFt1mJwpWzB/n3462pSlTaGALOdVscTAivMaFW8cq5QRWUtM+oqj8TnsXFijVCXDbo76VytJou0XTeMoi9dMF+Lj5hPy5jmZ7boHygFhH5/A47f0Oy0bIsoMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Azphf6o8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ea80de0e97so3224352b3a.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711533810; x=1712138610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGM9t7/0q9Uuzeh5v2c61gXobkBHvCAyjzcKCQV7mnI=;
        b=Azphf6o80Brmlb5KKY4lfFp2Eu0MorhuXRahg8wu0BJk+GT5EweVSdsOyiK6oJx7XI
         sLGtBZQBYnqhtLxNAlfnZeXC2WMbtNULH788bsqYCyuQruXpBRzSwoXAtffp1ez0yXob
         UtJJolsM2dcZPMUv5Kxos4W98938FKJCAPXk+4i1PrhCD4M3WFu9+37FPZ2OZTW5VXxz
         BpPW4m4pUqm5Qg+0af4RDp+RxzX4lmOpmARFjWg3g3QRzCqebNnFSPaYSCuGFz0iFW5h
         iotDSbGBRRuMS4xyy+tn03DGp3Htk2oCdIHf9tlSDV1EFd7DScMVmN5IZgtCHVOr5HbJ
         jxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711533810; x=1712138610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGM9t7/0q9Uuzeh5v2c61gXobkBHvCAyjzcKCQV7mnI=;
        b=tigki9a1BPXpbr8E7j/H5jMSacd/duxKDUsqaHi14QRqnP3TEu857IUKD09qJwqSGK
         Yfth51bpC53TCsXiHnCEka4O8Vm/51x7IgrGbuUDhaVQriYWdV6G5FqO1rn4AR2CBajN
         8ZmDDWOVJpcoZpSTCgvXZ+9Iw5ttZ2ZNP2au9ZX9MTkoiXOK9Vu/+8DC3HNI1GRcwn7T
         xSE6qlxcDNfX/QOfhIn8nGHP/RYnKlT/plko93APokPez0yHG+MzVsCXaxRgsJM3r6UD
         5D6Gb9QS3mZH9Hbb3xgacI1j59oZ1ULinPOTNrRYdEIDgxkS7WzFY3b6VxkUhLRc1AY0
         eCtg==
X-Gm-Message-State: AOJu0Yzt4Lihe7hzoAPgv1rTjodnDVTsWIqdQOLxIlQm54e8noFjlgSl
	PaGozM641ZOLZ2lovcXoD98c9UBkk85dSTCK/dkXwLUjn538IaQZRvIFYeSWCMN5a2JT
X-Google-Smtp-Source: AGHT+IE3fTW5TZWCrwGvdEQ5sM2S2Kco8ErYNQ7QujbjQ5NJ+9+VKD67LMUPt1+Fnd9zXuhywEi0lw==
X-Received: by 2002:a05:6a00:3d50:b0:6ea:afcb:1b4a with SMTP id lp16-20020a056a003d5000b006eaafcb1b4amr4073589pfb.8.1711533809808;
        Wed, 27 Mar 2024 03:03:29 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b006e6b2ba1577sm7478913pfn.138.2024.03.27.03.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:03:28 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/4] doc/netlink: add a YAML spec for team
Date: Wed, 27 Mar 2024 18:03:14 +0800
Message-ID: <20240327100318.1085067-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a YAML spec for team. As we need to link two objects together to form
the team module, rename team to team_core for linking.

Hangbin Liu (4):
  Documentation: netlink: add a YAML spec for team
  net: team: rename team to team_core for linking
  net: team: use policy generated by YAML spec
  uapi: team: use header file generated from YAML spec

 Documentation/netlink/specs/team.yaml    | 208 +++++++++++++++++++++++
 MAINTAINERS                              |   1 +
 drivers/net/team/Makefile                |   1 +
 drivers/net/team/{team.c => team_core.c} |  63 +------
 drivers/net/team/team_nl.c               |  59 +++++++
 drivers/net/team/team_nl.h               |  29 ++++
 include/uapi/linux/if_team.h             | 116 +++++--------
 7 files changed, 350 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/netlink/specs/team.yaml
 rename drivers/net/team/{team.c => team_core.c} (97%)
 create mode 100644 drivers/net/team/team_nl.c
 create mode 100644 drivers/net/team/team_nl.h

-- 
2.43.0


