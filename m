Return-Path: <netdev+bounces-215012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342EAB2C9E6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78114175B25
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE6C2652A2;
	Tue, 19 Aug 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bMF8hfBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0810F1
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621597; cv=none; b=JrcS/iw9XkHohKXhGpdqe94YOhdIdAQG+Ni9L+9YYtPPRS7XnodCp6l03kZWmaFXArWAaoB4TZMi3j5UV9HoxFkFEu0n63Z1/TiynVmUouoUz6QZY5n3dxgs3PolUxegr7MF3pbX2hf9Mt5r5UpCn7qe1x1cduMDL7Eqty5hl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621597; c=relaxed/simple;
	bh=dVmtQTwXTcGRfFV4WZuJy+7jj4nT5HAGMKRqT5rv3Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YM+eLwQpN4oNn9Z2GkiMljgl3SjDmg4YW9p82Lx2a6ABAuznuuQjgSF0Jz0Ui2NVcsGsh2QBk0I8WdHG9Ix759akQsUrxfyZrq99QF+87SSlBrqt8J4PNm4bmkHj5q/bbQ0OJ6heNDmyb61FUM1xwyFdpeRB3/nfjFccrM0hO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bMF8hfBx; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3177498b3a.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621595; x=1756226395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZv4PyGpzpi/8f5KliWXTv3hzYsqQHi/vkbQgwNFZ8s=;
        b=ZWIHkgLc/Jf3J89pzDBXm1lvKRV39O3U7MQUvYngnsSEGRpN07ozXHPwsJHZ4v1I4w
         6HDvv3iT5uxhaJ5upp3BWLh/fT2V4uEPw4KAmV7IxIv0Lp5w72FVrXeiEEE+4oyILB4Y
         B8mipvMv0FxGG/hieVZsNtHmI4GyIKQ6B8ZJx4rBpR0EyHiZGBh3d3amyZ6toAqXikyH
         I4rD0ojlB/9VxAdXr7LQ7J7OPDjKKSled3tnYV+X4zt52MBiJORw16pVLk/2g3W9VvJl
         SfQPrNYbCGdEpoFMh3+Pi7eS5r6UwKsZDNMoMacjxYefjZGlVXNXtTB5bvm74f4+UWck
         oGew==
X-Gm-Message-State: AOJu0Yy85HxhP93DZa7FyehF+QY1ZcsMf0N8lEqNJoPX6PxtIGui4P7u
	uERwlt5BnytdZKbHf/Gr9P7iUGyJAxWQWaJlYyOSv+dfsg+8XXzFSNG6D8Mlpjvwapgoz4Si8I9
	uzCJJDuf484w1XANyiGGFi45zSCNcKYjpfKRvZHvUqukQG6zXqCjO/j5vFka093Img/le+fcXuV
	gKDtKeVDPWe54ygzMh91m7i/UDgfZD/i3lOp+YeHZZhlK17rUSMwNwOSHMPZf5zz+JObUpb9qB/
	avD/9rMP8E=
X-Gm-Gg: ASbGncsYiHAWHdv87oPAu4xCjKjbpaEYhClUoSM93wSgVkqwtaP8RN54MPksdLqqFSD
	X2cKVlleVqGXtIDHOJ1y50UeNwvBdRrRfqUcUC7QU3qzbcAkMu0IfxAJjZRMY+MWgBvjnZVB9bN
	V/VgZpWIc/O9zpqTouGeMniqoUb91Mh8vEG9mMuSVYEF6LcoHL8HT8ar4u4HzqieZQ+GZju34X+
	ohevav1nMwmE7WbTdUA/N7O3KG2pZ21kHiAPEPMZ2FFtuOi2Nz7C15y2lN7gUPquVDKKxWL2fyF
	Ui9w2Ac71rX3BzMwX/7Cr7SJ2SmosTtbKrL+e1Jqm5frVOr+dsQQU7aZ6JqE59/+1GNEFvcczpM
	ANsCi+9g1p6J2fzRf41fgtP+Vf5XIRJsSyXAY/StRORftli9mFKZWW3XN2a4uhgIpp08ExFnzYY
	FF4Q==
X-Google-Smtp-Source: AGHT+IGf6zFaiSxPVPxfsik27IbcCIEFpFX/Z7LLaQ8Pa4lhurEU/8LIvopjB2HKluQDb2Zc3GwCLU4xJTvI
X-Received: by 2002:a05:6a20:728b:b0:235:5f88:32fc with SMTP id adf61e73a8af0-2431b753031mr44264637.18.1755621594659;
        Tue, 19 Aug 2025 09:39:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b4763feffbcsm12106a12.9.2025.08.19.09.39.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:39:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870623cdaso1422861585a.2
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755621593; x=1756226393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZv4PyGpzpi/8f5KliWXTv3hzYsqQHi/vkbQgwNFZ8s=;
        b=bMF8hfBxtWpz5nUYIp1pJj2N0Ut8UPEMuFnf1mOAWXeK2Ohze8+CzYjlOu46680jEl
         NzE+WW56L3zCFqM+j7SR0AcqO3odjnMlqD4CLeEwGZA+z1gAukKJ8QYGrHRC5gzCW5TX
         hgMyF5oKchije+Qvt8YbMdBDcOn0Bzda/+B60=
X-Received: by 2002:a05:620a:a481:b0:7e9:fb93:7c82 with SMTP id af79cd13be357-7e9fb937dc3mr77527785a.60.1755621592616;
        Tue, 19 Aug 2025 09:39:52 -0700 (PDT)
X-Received: by 2002:a05:620a:a481:b0:7e9:fb93:7c82 with SMTP id af79cd13be357-7e9fb937dc3mr77524985a.60.1755621592198;
        Tue, 19 Aug 2025 09:39:52 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e19b14dsm791908085a.39.2025.08.19.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:39:51 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 0/5] bnxt_en: Updates for net-next
Date: Tue, 19 Aug 2025 09:39:14 -0700
Message-ID: <20250819163919.104075-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The first patch is the FW interface update, followed by 3 patches to
support the expanded pcie v2 structure for ethtool -d.  The last patch
adds a Hyper-V PCI ID for the 5760X chips (Thor2).

v2: Update Changelog for patch #2

v1: https://lore.kernel.org/netdev/20250818004940.5663-1-michael.chan@broadcom.com/

Michael Chan (1):
  bnxt_en: hsi: Update FW interface to 1.10.3.133

Pavan Chebbi (1):
  bnxt_en: Add Hyper-V VF ID

Shruti Parab (3):
  bnxt_en: Refactor bnxt_get_regs()
  bnxt_en: Add pcie_stat_len to struct bp
  bnxt_en: Add pcie_ctx_v2 support for ethtool -d

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  84 +++--
 include/linux/bnxt/hsi.h                      | 315 ++++++++++++++----
 4 files changed, 317 insertions(+), 89 deletions(-)

-- 
2.30.1


