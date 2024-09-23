Return-Path: <netdev+bounces-129282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF73D97EA70
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC891F21C92
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F0F196C86;
	Mon, 23 Sep 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URInqhho"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C941957E4
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089601; cv=none; b=NpJh4aFg+2/lkpNMYchvqIWOHLm5a/CgSAx0nk/Jca2nIn0gYHdlQY0vflyQcsY3UBQlSOvxY/dgWel3QKtZWGjB0Ey47xnvlQt9hFowWMxHrZKSsdMRAsgVctP8CilbjtewGsHEwRStmcwyvY5yJDpaNq1VUkRPss7g/uOQr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089601; c=relaxed/simple;
	bh=Tee7zcVwoDDsEJIzgUEMvpzrHJcWSDnh18M21vR5cSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iH5fr7yC3wfpcc4loGVJVUxYpv55/9z0Z0mBuL+trWY+Wd7WUyOm1rt6wIU44Dpc4o+fJ3lV+3PabNYWVYJYOujRE7IrUNcHe3k+v5WxwcTbpNPYKEjYjqPaiI2SSjHQPF/GeMqE2CIK/lR9XmA4yQOzvPKcdbVr0whSKCVRJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URInqhho; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-207397d1000so39265545ad.0;
        Mon, 23 Sep 2024 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089600; x=1727694400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALzMIsr9C6wb+tUWEyDPK1xwWfwpXF6BlrUcpniHhvc=;
        b=URInqhhojAItSQJBokw85VApdbPGACHXBJEXp3WkBjt/9Iw5w4pZgTRhC4PLsHYjTq
         b02KEGiSyaUuqNPddD6MgKzItmHRq+YMArw+orI7eQVP3/o1jzF8vq8UOWUOJGm8vdrF
         040nXBtR4ecJizPGsbKFSSK/CG9MC+MbfXg02YJlTjoKzasg2r6BEGPPyjMxqqMVtqCm
         sa+Kr1MkYzByzxsOLOMR/tKv9Nl0aXh9HGAENRkO7uX4HnkPW8YX43ewqDyg0w+l+S8d
         uBXU4m3JOTHuyRJMH0a26wGRulkbu5RGCzetjFVcsDtP+AZV6fxa3JFhT5sP1EOvbAyA
         PABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089600; x=1727694400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALzMIsr9C6wb+tUWEyDPK1xwWfwpXF6BlrUcpniHhvc=;
        b=QldnCDIKeT0cAGyEjvU1djj+9Nts8FrCkYyePDmVdasNyq1/2+ruIoyt4BE0OMiAvl
         GXftTBhQ3uw797x6oXeQcbcIwaPknlBAyoh5zDsmUXoYQuRC+KJchcelyZqEdpyASxfU
         lwwQ5AOt5IXjCIMDPXjZFdIk5e2bFn1fDzSQgcSBdNI4ULLfrGSrRWwgsX/Jc648ftY9
         o4xsgd0YuflM00AFGhflrO9dZ9U3hAtHqQgy/mrMI9SS3AFVxgn95REQXVlBpIRxCk0X
         AspIaWU7fIMPqqkpBOykcmd/RXoeB/LcZlRoSX9TvsgFmQ1ZAIHfRJmvKVt3AWR7Jumh
         k4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXCUzL/3I+xgYLi0BnAh9hQrnmScPsoiHiwzG+p0GDmdhLnrmrs2rKKPUlEJrY4XBgxKTFY86nY@vger.kernel.org, AJvYcCXUG0OdhiDuj6f2j2Jo9OOR2vxhI9DvU/pmC4I2aivwXLaVebm1ZDKBQuAe+PHfC7dFIqHsXgjOyhUqJ3/n/qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwIyHlwpp0Wsr4x/J7C1WlOrIz4GdHptpQLP5lKEL2AIBBbI+
	NqvhapmI0AQbpJkp/qklC/uCqR+6tlLIF8IS5h76SkJNdul6EhCx
X-Google-Smtp-Source: AGHT+IGgaNI3FZCvsMmYHm8OCxmiHznfU823OH1g3vQ9GLPhgRHEv7jiKqwPhRM8VNMfNoJZZW7gSQ==
X-Received: by 2002:a17:903:11c4:b0:205:656d:5f46 with SMTP id d9443c01a7336-208cb912140mr228403525ad.28.1727089599779;
        Mon, 23 Sep 2024 04:06:39 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946fcb50sm130885485ad.204.2024.09.23.04.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:06:39 -0700 (PDT)
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
	netdev@vger.kernel.org,
	cc=linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error pointer check in otx2_common.c
Date: Mon, 23 Sep 2024 11:06:32 +0000
Message-ID: <20240923110633.3782-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer check after calling otx2_mbox_get_rsp().

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 87d5776e3b88..6e5f1b2e8c52 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1838,6 +1838,11 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
 		rsp = (struct nix_hw_info *)
 		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
 
+		if (IS_ERR(rsp)) {
+			mutex_unlock(&pfvf->mbox.lock);
+			return PTR_ERR(rsp);
+		}
+
 		/* HW counts VLAN insertion bytes (8 for double tag)
 		 * irrespective of whether SQE is requesting to insert VLAN
 		 * in the packet or not. Hence these 8 bytes have to be
-- 
2.43.0


