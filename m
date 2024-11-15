Return-Path: <netdev+bounces-145399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C199CF63E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBDE1F23EC3
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777AB1E1027;
	Fri, 15 Nov 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPcl2fPh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6D1DA23;
	Fri, 15 Nov 2024 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703313; cv=none; b=D43xkOQR/1geHBK71BIj6F7FAdvyIzYjhxqevZvM6b8OaksilHHqEFLly7rlvj7PZkX9yI1HM51L3eRNIxHKUbHeFjBNfqBoNyXYdANBS+lo/tC3zS5VRfXErrhmLhdvOiIviEPyBr+Y8mvPk20ZcGjy0qkyAACVBNK9QmzOxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703313; c=relaxed/simple;
	bh=RTZeRnUyy18FvckOzgr/ZUbTYukoPq6ymq5mt1k/gIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkmrFVRdgGB4ac9Msj3UvWb2wISJj4O+bhqSRbjfrqIapb4y3xRvCs43J2J5ox1vIkV4FJeNq7Vks5itoONh4pyu4nB9JvoWlbBSWqILUsZwQUER//B1kz6KMWKuIyICz6bD1ttwQQAd/l0L5sBBvm8bWMGGXY2KMmY4QwO+PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPcl2fPh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso1665861b3a.1;
        Fri, 15 Nov 2024 12:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731703311; x=1732308111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0dH4KYwPYTXs2oneQ0T///Q8kmHce7mxjnZ3QqESaw=;
        b=lPcl2fPhgdBnf7r6l6lPwjyn/iXOVt/5lxy25Y9SauGaJAqMYhiziUGBSPYRcw6UdQ
         A4xwb7N65K7YKii6owdbsnoV7/TUf5jdybpSRzJdioWIUSO4D5Eqac8M2VoNVS4dH4fT
         6gpol5bmLhn1T8SZa6pfzyTwyy2kX3ZKtY259UUbdjcxLkGQGkG/coDzf6EAdy1r4Ugb
         uOCoBPEBf3AxExaJ+o1Gszp419z3vNtt7zws9IGPmu8+1l12cBUiPwIlk62JpCZOsHfI
         dgUBTpvA08PFBk7pemKrtZWB/7uqTzwjBh9+HlQ3DYga1s9pmuISmT9StudpYsjmRktP
         YuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703311; x=1732308111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0dH4KYwPYTXs2oneQ0T///Q8kmHce7mxjnZ3QqESaw=;
        b=cDJ55g4/dyrKjCaryzP06YSrEu7lNeRad1TZ9xDbuLGvKwkd+BdMoE/tq3D5qzUg5Q
         /Lqv4zBkKQdeXUfbmFUWUAgRiilBZLbinl/fFkPzE2ErGHLO5lJcY6som8xZwFXllEEb
         hQPUAF1CHmusy0fBb3aTtsOuAjwujcY8fOBbbfG4O91zfTkxCt9UFtsuRkvwV5RtiXCF
         G8eRC11d5jw82JV/am7SmZ7t7kM+7UBfXizX9AmHouliH1xHSuCmGBzYTJapGBLPuc4A
         cICqZUDxbrksREjpQbG84Ea//FRp/10+lkgiOz2snF9Y+rQmCcK3pfWF8qK818nYvM1a
         2G6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPYc8mxsQmF+1VOJwLO3bFgrEPHAnHgvHzvnBFVyIW9qdrxf3ObT/VRbtQiH2p661rYm7dX0/4GWEwPTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Zq/0jVhoKvItA+QuKMtEJcJ9GAqarU6ZaBTQZV7X3a54xXO+
	tTnjA+4g9ytFET3AnNoY3S4RexNZ4Za8Uf1hptH3GduOvR3AWCvnivOGQYDP
X-Google-Smtp-Source: AGHT+IE9ofXSvux3YX/yH45g8SX+RrnSMWx8+/mR3wiKSr5ON5hCzHGZm5aPu+WWvuDw4KG26ilKLA==
X-Received: by 2002:a05:6a00:3d47:b0:71e:4e2a:38bf with SMTP id d2e1a72fcca58-72476c752e2mr5176905b3a.18.1731703311117;
        Fri, 15 Nov 2024 12:41:51 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1ffesm1782744b3a.155.2024.11.15.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:41:50 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/5] net: fsl_pq_mdio: use devm
Date: Fri, 15 Nov 2024 12:41:44 -0800
Message-ID: <20241115204149.6887-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various devm conversions to simplify probe and remove the remove
function.

Tested on WatchGuard T10, where devm_platform_get_and_ioremap_resource
was failing. Added a note why.

Rosen Penev (5):
  net: fsl_pq_mdio: use dev variable in _probe
  net: fsl_pq_mdio: use devm for mdiobus_alloc_size
  net: fsl_pq_mdio: use platform_get_resource
  net: fsl_pq_mdio: use devm for of_iomap
  net: fsl_pq_mdio: return directly in probe

 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 92 +++++++-------------
 1 file changed, 31 insertions(+), 61 deletions(-)

-- 
2.47.0


