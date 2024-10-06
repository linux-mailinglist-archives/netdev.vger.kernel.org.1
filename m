Return-Path: <netdev+bounces-132512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9E991FA2
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57F0282C14
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA348189B8B;
	Sun,  6 Oct 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Crdolgg6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C7B28EC;
	Sun,  6 Oct 2024 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728232722; cv=none; b=KwqImw5lgYUhsgzt48QISYvO7uhIttjk4uUq6jj3XwT6pcvh9dJ9AhtJYKKk3NkeR+LR/4QBTjGG/V5lFFM6wbUCmoCTN6aSSeFX8PY2ZozzM34YIfK8L/0Fpngcw5mYbqL4xfiuiRUjDzo5ORzLdZdXy+uS7hZxpvPT/ijE0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728232722; c=relaxed/simple;
	bh=VWm4oyt+q/H26Q6olzPlcr3lDdTKwRVp5KSTyHE/4Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKYGs01faDk66uiw5R55gOUmD3QhoQis6QGWvnLl1skLEhc7kSmTNG3IREv/cUgAReN3ZSGYGHzojBfaqVQrRimT+XxC0grbP7IQbawpA5Ej7fgfGGBlA13QefqyL6dsxNCtD8RXLnclQU0K3Q8AcubrvNSB7tElGdRqEykdJ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Crdolgg6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b5fb2e89dso26981625ad.1;
        Sun, 06 Oct 2024 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728232721; x=1728837521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNHhoZBFa3Uje7LIonwSRSX64aKenWo/TA87EI/AUBU=;
        b=Crdolgg632nUeLPZxjcfBO+9XbPxERFO7pLL3hlnxfT+1eVcetK3SYVn0/h0+sD0Aa
         Ba0xM5R22ruNjh45LhojBrpSj2/0vVYDuChbrs7qqGytTnw/lV7TyoJl21QzX1mtetNa
         9/9bCBTRDHuIWnb23q767UhmucvzLyN4zIj2A6BRtb7lJniyz3tN3gvkmUxCbHCi8qJx
         gyzS9RWfmqUerHSBpzikfc71QqsPBGCDe5P2v7B4JvWWZRChZFTB+RwFjXPJ+KHs1ocy
         vvcVJ9SW+N89VwU1BVAyWMZGRZwNOsv9r6CxDx1sqa6FW6HOeRSDcoEOFSwObOUMXAYI
         eBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728232721; x=1728837521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNHhoZBFa3Uje7LIonwSRSX64aKenWo/TA87EI/AUBU=;
        b=i0HeDl+099KrQO7WJ/Dxuh8wp/SoW+TE1eJWeCxeE7s68CacmZI75H1F27B6Yhzo5M
         o/kglEB0LnW7qh5oDlTHMOFBnZUXdli1yc69M8AlKN50+UpxfdW0JDDsP1S38tOalZV0
         Ushic/MqUGCoidbH8KZ7nvK+CRuqNt4uWcTfVzwmvWUyNe6N/mwwEonMtXxuUXrdX++5
         T4dXA+jR/jYdCU7GwoVmpl/9PTKq8ywmv9DsCLkdEDAHqGA8CvnsUVDGF4FA9YycJcRd
         QqdPEVviCQr7imdbr8xYRRrGPLIlh2OT6TCXu3cCtrastfwQgZPLdFSqIjmp//FlUFwH
         4Brg==
X-Forwarded-Encrypted: i=1; AJvYcCUY9/DCwH2UO3G+Iis1fLUBoW3MyRNCMu/yei4Hfq1FwDHRkBWMJ4fhVYzEq22zTFW1UJaI0R+8uts/rIU=@vger.kernel.org, AJvYcCXUrplqeytU4z/1QE7wIyVY2bWYNeC8D+a5syvZKcKzVNosmrth63AEZ1knxyAlHpdHolbVpD1w@vger.kernel.org
X-Gm-Message-State: AOJu0YzneY2YY/+Q9hll5qsfRo6kY4maW7rtq1cJtItDkZ5x/BmYtw5H
	iTJ0VebHUDZd6Fm8s9P7Or4+nhUlIrdUQ06nCA+D868PPR2Fw062
X-Google-Smtp-Source: AGHT+IFAw5AW0FjyEB5WJG78rA2dOp5vKvfGCwKMBBREJd/jpcaEfMm7zwlFORuG8Tm2bRl4xg3tTg==
X-Received: by 2002:a17:903:41d1:b0:20b:80e6:bcdf with SMTP id d9443c01a7336-20bfe17e008mr133297215ad.23.1728232720731;
        Sun, 06 Oct 2024 09:38:40 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a32d6sm26915075ad.302.2024.10.06.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:38:40 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
Date: Sun,  6 Oct 2024 16:38:31 +0000
Message-ID: <20241006163832.1739-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves error handling in the Marvell OcteonTX2
NIC driver. Specifically, it adds error pointer checks after
otx2_mbox_get_rsp() to ensure the driver handles error cases more
gracefully.

Changes in v3:
- Created a patch-set as per the feedback
- Corrected patch subject
- Added error handling in the new files

Dipendra Khadka (6):
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
  octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c   |  5 +++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c |  4 ++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c  |  5 +++++
 .../ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c   |  9 +++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c    | 10 ++++++++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c  | 12 ++++++++++++
 6 files changed, 45 insertions(+)

--
2.43.0


