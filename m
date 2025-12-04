Return-Path: <netdev+bounces-243495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BB2CA25EF
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 06:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5A0530095F3
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 05:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C772930101F;
	Thu,  4 Dec 2025 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A21DHbVp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6762D3750
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764824468; cv=none; b=qxnFjucnyZ359KgiMiUCQI6KXC0iz6lBJsuh65KPAmfuRiQSEHIVrlEWcRiwylXmonWEO89Yu/AfRFepKrArOTvCE4pA8If8zUpxQG7CCDDdw+eE1GT7EPd2ePPa40DN4NgqdyD8yTL7abgj3Mi4Tu6QrbaQiFby6Dwkv9cXGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764824468; c=relaxed/simple;
	bh=6BM8cMAU7MDhGZrkIWgKdkSh/o44JljU5wOjAzLD0RI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QWGH8S+uDPo3aah7iExOCVcA30rzKjtLPKvzrzXvgfau/6+FK3LuYeN2Yiu+iWvV11PO2Pgecd/2nELJyV08qe79q3KLp40WbbT5uF59/Ihn9krq2FSL7TvPAWDLfU8+fMRQjSdzr3XhXKVruNTpfGBSuP6nW7C8hGFqkq9XldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A21DHbVp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so403604b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 21:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764824467; x=1765429267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vpoC0gDWQUM6OfoTGp5yRLJ6yIkO8unpnEQeTBxH3Ls=;
        b=A21DHbVpg58IfnlkUdx7+Cb9FtxWEkkai/TYLFfYgugVMyAk8v6ipXAbLCjwHF2ySv
         KicpwK+YBcMoCNjk1H/pgne8pvnotURxgp+CYqqAJ65JgpDQTgbjqEva8J4tVxhn9oAD
         bMCC1KFyW9HJDyBA3n65qZTy66g2BqYKOVNCddo75FQw9gUf8barpmDVK4netnljHa8M
         /attjOc4FnmAcAHOgMreoJIJlHOZeXc1eO99IlsFES3G+6dLDw/aizEjPnjwE2oyl2cf
         VDDIfS57L/uQE5HUhVRpVDPT3dtF/GH+ncTm4w3j5bN2mdb2XivHpWhSWUCy1G69fdWA
         4MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764824467; x=1765429267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpoC0gDWQUM6OfoTGp5yRLJ6yIkO8unpnEQeTBxH3Ls=;
        b=Xl2vy7+Jv6qKF8pthVsakXbw1XYaFAFK7cILmwuDdeAOIs1aB06yFPxzy7Ua85AYl1
         IO6XkvtQ5CZqsi3Tb6XJhpyszu7CU2A3W0U4RzdAVBrCZG8Y+oWuMPYU7wbJcKeTO60W
         fBX8oM/YGxv9aOrHpDWeFqBhJmKVqBnGn3q4+8OFzpyDFwX3jSz10BkufOXyTlTr+uuO
         PY1dRmzS0qv/AojpdhAGlo6YjX9PkoBbVjntr3Xe3D40Vcwtu7W4hR4xlzGQGbAgqEkS
         Wzccvl7lWFYkV/1w9Ws9Yyn0A5C7jAPR28Jr9eUl1qAgwXOT9qSXEZNQKuZ2CPYayMQY
         ofMw==
X-Forwarded-Encrypted: i=1; AJvYcCVJTv7TVDUuyHfByuSDuBGcD7pKx6x1XqHD0zkTXH3heEOPNnetm7dmDekB71Y5EynOldAs5tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCz1RDI4n3uewLejsIPIOStttGJwOf5QI5xH5vBDuoSKsoZPb
	wcs7kBYNCSXYzPD/ISmoYVUkHZWZT7aNmvMt+ZJKKhpefrKLqfSpEbgb
X-Gm-Gg: ASbGnctj+Sa5R3DkCNi+keFSNOH3rZ1ns7oDPdjK80bF6DukfcgrGPxcHyyoEi6PNHe
	Cde/oWGvZaPTAliYErGnHf6ZetXh6RJbUrNgJ5ouISgnWn5FILVSPMIxOeEVqSYGuaQbxH3myx4
	K7/A60HTR2xaKA/3gy41ELR0JZZq+gV66XEyWyYyry3TDW93dwk1iywkfkQX/+gGjuJVtq6T2+N
	mT2/xAumpQIzZrsE1XcXtfUppPLw8XOdvtXIWQ1F0rIqzUpAjac4aDvMGEyrZAcAKqopbhTub9q
	srNe6LaCQVxBM4xDlCNQ1I9u69uqAt5qjrpkaEK4Htr7HCwWJRAx4tp0pSSo93x/p/5mRAgC609
	CCFPotYaOARKoBRWVBK02W5vUVPPFieYeuvHfTG3NU/XqPVgglfSIgFEszpqzl74yfiTKzir8gr
	11Qn4lUWtBzQLZp4278i9+xMd7HQE0Nw==
X-Google-Smtp-Source: AGHT+IFOb/dtmngvWJT+TrkNmu1/17WRg6lkKaYKP9pKleJ6P1s+XSJUpq95mc5+UwEiQ2ZrJZdDeA==
X-Received: by 2002:a05:6a20:3d0b:b0:361:3bdc:916b with SMTP id adf61e73a8af0-3640375e456mr2045822637.7.1764824466518;
        Wed, 03 Dec 2025 21:01:06 -0800 (PST)
Received: from localhost.localdomain ([121.190.139.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf681738a34sm419440a12.4.2025.12.03.21.01.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 21:01:06 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minseong Kim <ii4gsp@gmail.com>
Subject: [PATCH net v2 0/1] atm: mpoa: Fix UAF on qos_head list in procfs
Date: Thu,  4 Dec 2025 14:00:38 +0900
Message-Id: <20251204050039.93278-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a use-after-free on qos_head list in net/atm/mpc.c by
serializing add/search/delete/show paths with a mutex.

Changes since v1:
- resend using git send-email (previous patch got mangled)
- add Closes tag to satisfy checkpatch
- include trimmed KASAN report in commit message

Minseong Kim (1):
  atm: mpoa: Fix UAF on qos_head list in procfs

 net/atm/mpc.c | 117 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 32 deletions(-)

-- 
2.39.5 (Apple Git-154)


