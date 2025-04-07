Return-Path: <netdev+bounces-179841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29805A7EB8A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E263C188AFFB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC102580F4;
	Mon,  7 Apr 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME+Zy0sR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8172580EC;
	Mon,  7 Apr 2025 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049995; cv=none; b=DE6dv9fwQToNtl8ZYvIlBUBUxptsLPM5azsBWu+MwrksxPIFIU0dioWa5Byj54vwNnNIg/oY1SfrQ2k29iSSZ1qSpqp789PYrdNIKpEqXqYAB8+t/FPxK4oVDnivtVHo83M69Pa0VvYuPrjdp/665BHHrP4EG8SQpi+08vHET2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049995; c=relaxed/simple;
	bh=8t9I3M/OoDdOwuvx+sh5pUZ+oo+lNCu+25qg/OpdLq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VHXuw5TApjX45MgWlRvlPEW3OpvrEKPYYvdx1JxFj5jyeD5aPEL9Z2bdP1IFVBL/inmTzyqcBKXIx0o7rQLijQ3Bc8F1h6/FlvtNScrrF75suSylU1Tb18vHnTjY59YOvRZd6LTjdz/MH944JlveOd58cFJevWpOWMhJrMpr2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME+Zy0sR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227d6b530d8so40349495ad.3;
        Mon, 07 Apr 2025 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049993; x=1744654793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y92qqv7Si8DM+cyIuUMii4FZ1oGPZ3qD/oWMPhfaWak=;
        b=ME+Zy0sRlmdMGKOHMJpXfYEW7+Z1QbnxZeT9HCqZWgp3HBeY/U8KuEt3wSfhucSVMY
         5YRq+5/7C8EVe03QJaza0kuhaLygFrpc5QvFjxm4teFvdAr4GQPVJX3crb+btLp5gLIn
         TVGe6QPTkmcUA2cUokpn++5dwgcesZ4dxqgv4ixH5WAWa2q+Y+5wBDlIbL9IT0doh0g7
         MSydcSnhL1d84DLEYpcBjbr9UbblG7u85XheQV+nTglLKm5xAqISzOXIgGTD0w2gEn8q
         RM1pso3GW6CV1JPHdzBp1EXrVbttAv4+WItwhAIn39q/d2OytAmoVmTPP4mbDfCdLlyL
         u+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049993; x=1744654793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y92qqv7Si8DM+cyIuUMii4FZ1oGPZ3qD/oWMPhfaWak=;
        b=T27a1Afp62DkA60UFfzl/XzcCPHp0AWdKQH4k+mhi2BySJTwY9kUmfHqmuasOz3AIz
         oZZeLjo6w11ZonBIAdxgnZjg5a30iToMN0/8izsTsQ0zFxrJssGdb3YwgvSRhgKW7t/Q
         yx1mkGEbHURUVU5aCfLUiW6Qb7xFiLsr0J6khXfvg5iPh48xpJcu10CQ8PUTasZx3/V5
         TROS8E6jGmWDFUfj5j3of4yl0obTn5JDS8hBdCAhRe65sN1bEzpfV8wrrPtiAloo0riD
         tfsZdnFxUbqxx42pS/dU3CyIx3UXV0mgG4BmaZ799YyJWdlAt0wbxdjWL09IOT6lbF7h
         3hMw==
X-Forwarded-Encrypted: i=1; AJvYcCWTt+MbxbSPwxH64j5wa96GQzGB6O/mEDFiC5qiIQklaH7A+lYRPL4wS9rVvJs+sdizk+sjl7ujcOborY4=@vger.kernel.org, AJvYcCXwrPVMof1WtOC66dEfSMmIuZ6FK72NRzUmYWPmwB86Z7Z0meAqFrDrdG6wp6mPsvHOFcF3FINV@vger.kernel.org
X-Gm-Message-State: AOJu0YztzNkWlQumZDAItZQlBQFcBqzs94g8hgsh5as7Q54q2OdPnqBz
	awliLecSlJzA68FHxz9gOoNlQcT53F82hYyIbELfc3vcu1QvyZI=
X-Gm-Gg: ASbGncsQcWKQ5JY1pxN93EVu3mlY4J9ZQM0W+Nujxc31dgWXy8epyTZBEk1IvwRW3t9
	KWoGK/+CJCFvb4g6s5TMTyyC2SBuLxhp2sl240NW3iq2N9QLSQqF/fayrg5Pz5TVXMpFVc9kjXa
	fYawJwgL8ZeDjTtB1WSStw697JW44x34c24NAFS1KmM5G1Km0/fyEsz5yetIVC/JMD6Kk7msFH5
	ZR0aXPcXcFFZ6ZtK4yu/obG/jBsd5l9oJZuwixRf00/XDBRxN02onvD0h6WiveVQcNV7gwIre0W
	EFUFiSm4ZTXdTMDoGuEnIHpX/IFFgvMwcjpbcf9iwW2u3rMLAKrIHdGra9FGKpKnMytkL/5gUHg
	=
X-Google-Smtp-Source: AGHT+IGpX9h4LkoziHaRfryu8mhOvj9TvgeigMtuO3BC1wBWT5M21Mp4xRJUif7kKVU1fH4pOq5YJQ==
X-Received: by 2002:a17:902:f683:b0:220:eade:d77e with SMTP id d9443c01a7336-22a8a0a3a86mr201394445ad.40.1744049993129;
        Mon, 07 Apr 2025 11:19:53 -0700 (PDT)
Received: from L1HF02V04E1.TheFacebook.com ([2620:10d:c090:500::4:6c4e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0bc052sm8809243b3a.156.2025.04.07.11.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:19:52 -0700 (PDT)
From: kalavakunta.hari.prasad@gmail.com
To: sam@mendozajonas.com,
	fercerpav@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: npeacock@meta.com,
	akozlov@meta.com,
	Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Subject: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
Date: Mon,  7 Apr 2025 11:19:47 -0700
Message-Id: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>

Make Get Controller Packet Statistics (GCPS) 64-bit member variables
spec-compliant, as per DSP0222 v1.0.0 and forward specs

Hari Kalavakunta (2):
  net: ncsi: Format structure for longer names
  net: ncsi: Fix GCPS 64-bit member variables

 net/ncsi/internal.h | 21 +++++-----
 net/ncsi/ncsi-pkt.h | 95 +++++++++++++++++++++++++--------------------
 net/ncsi/ncsi-rsp.c | 31 +++++++++------
 3 files changed, 82 insertions(+), 65 deletions(-)

-- 
2.47.1


