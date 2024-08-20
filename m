Return-Path: <netdev+bounces-119946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988EC957A99
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9E61C239A7
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386CDDC5;
	Tue, 20 Aug 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW9ITyGE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A617753
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114935; cv=none; b=KH0RGnGD6yrCXYeIgoyT1TrQqr5d6lSNHLqav/DxWA3VB/BMs80upvav0ExHzpiFsyrBTLPqS9BSUpYLB8EHF8olK9zx3HYqelH9S3fe68cM4A7bgKOezrLR4jaKB0RCm/hJpAA6045fExTXHF/UT7hi787T5N0DXolwivpw6fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114935; c=relaxed/simple;
	bh=V0JE3X0+WRFXHPI9e0FXv91nnCghysSFOghivn6t11M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KolC7Iqwy3IQ13Fz/DAQeoRnhqp+L1OpVMZGO/0TEGnoB0yWoLLOqlUN4hpKXdrDxGKhWD2XRvRJ7sYHHm69F6FvSkFdENcu2HYd2y5qTVn7yvD1hsDkyUSSeVZbFJxefIqJjIULIRsRpwc/LdJSHZOGXE07l+R3Ms0YVfp6R7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW9ITyGE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201f7fb09f6so32981425ad.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724114933; x=1724719733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1MNabgbUUhdEM18WLBdSrt9GEAgMl4kPk3eNthFhRs=;
        b=NW9ITyGELYviqb0kSbNab8Cgpt3f7+F3qyi3tpMnZW/gu9yXAQoNCkJRfC/KgOBHpU
         krF4HDXPMtayATsNvVDi+oP/Mb8R8YA2dx9pUHhvUeu287jSYZgjwYynl8dYowmKQ58x
         GUJnPAH+r30sOMBDkCClxQ4Tb4baokQU9WmQPTdGeJ6K9MVnlJAZEee/HPshrjcczK6P
         kPUPMV8Hf2kbmGixN86t6dGXE1ys5x85ldEfsFXHBIsfcPAnr5gqtfSTbHM63nEN0Qt6
         3Vy3DGLgRJK/+HGyoRhgYLhB1nVOAuVDdXWYw1GHpA6RT4bmYhx4rI//9OOCY5R1TuNL
         OClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724114933; x=1724719733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1MNabgbUUhdEM18WLBdSrt9GEAgMl4kPk3eNthFhRs=;
        b=TqO0+RI+SiGYwQQuRwI3eZ/3/Ykrejkka5rlivzY/LD/GgzZi0v1jqcnZaWKGlByjr
         19e0ufkuXSn/FEq4BpV2R/lQdLCC3rPqxvJQUwyeH1HdkE07InnOUAvPxAgqCnu0/8PJ
         P0TkFSHiqZ42z2+JZNvKYPEkWMXjLYSik8bovzqeapC65olN4LHvJelNbWZfaAuSLEwS
         zEK1W+S9UsRba4g3dk8pod8NEEhESK+WaNhOek2uPt3GzuZUnHDMm3FvxchIZdySxncc
         ngMI2NicQtWknvT/DFtYp3NbMpI8iDrA44otLKNRSLnPaDK+r9zPXEko3NwVC1feWQWI
         aifw==
X-Gm-Message-State: AOJu0Yx2EaI0JuRB6CWDg8780KYc5pvTTOOap+c8xAqQggVDXU3y/GqL
	z5eIzqQIk66U/A3i8PvbAA2/s7JgpDtIitdXV/THGT1scBLNqDmiQEtPCC7V2hc=
X-Google-Smtp-Source: AGHT+IECk7tFnEBKKXTXFCgifIOuYxM0eRMfLjZNLiUnsFHaaVMSMMF2Qeni7oqWR3qCFTo056ZnCg==
X-Received: by 2002:a17:903:41c3:b0:202:2cd5:2085 with SMTP id d9443c01a7336-2022cd53218mr55728995ad.32.1724114933271;
        Mon, 19 Aug 2024 17:48:53 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0300522sm67861455ad.6.2024.08.19.17.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 17:48:53 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 0/3] Bonding: support new xfrm state offload functions
Date: Tue, 20 Aug 2024 08:48:37 +0800
Message-ID: <20240820004840.510412-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 2 new xfrm state offload functions xdo_dev_state_advance_esn and
xdo_dev_state_update_stats for bonding. The xdo_dev_state_free will be
added by Jianbo's patchset [1]. I will add the bonding xfrm policy offload
in future.

I planned to add the new XFRM state offload functions after Jianbo's
patchset [1], but it seems that may take some time. Therefore, I am
posting these two patches to net-next now, as our users are waiting for
this functionality. If Jianbo's patch is applied first, I can update these
patches accordingly.

[1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com

v3: Re-format bond_ipsec_dev, use slave_warn instead of WARN_ON (Nikolay Aleksandrov)
    Fix bond_ipsec_dev defination, add *. (Simon Horman, kernel test robot)
    Fix "real" typo (kernel test robot)
v2: Add a function to process the common device checking (Nikolay Aleksandrov)
    Remove unused variable (Simon Horman)
v1: lore.kernel.org/netdev/20240816035518.203704-1-liuhangbin@gmail.com

Hangbin Liu (3):
  bonding: add common function to check ipsec device
  bonding: Add ESN support to IPSec HW offload
  bonding: support xfrm state update

 drivers/net/bonding/bond_main.c | 98 ++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 13 deletions(-)

-- 
2.45.0


