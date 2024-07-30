Return-Path: <netdev+bounces-114150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2594133C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8CF1C23739
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649619EEA1;
	Tue, 30 Jul 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJWMRqc2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1019FA8E
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346523; cv=none; b=kuLjYSsENA0ObMHAsB7ARJAINyflLLaNXwZWxnxf2rBsXMJHd47spxbN6Iakb7kq1iQN7tZ3JTHcfHltSd0fLzemVirVUN12hM9JurOj4cx46NfMEwgiV+25Lqd+n30oNFLYxTgxll0D75R46RR0S6F5AUnwB1GoCGyLPg3Ta6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346523; c=relaxed/simple;
	bh=5lacQbjwZC+SooAuvZwqNITCRLEPpX5cTP98yjdI7Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iw+xUChyoqoBvoqGrpf1BDYop59SV2Z6kjuaNZLofqPkgaH1ARcckDgZ0GO864ztLqterqz0um4qRdXh8VtqKFtbiv9lrvXTVr1Mu8vpOGBzXIWCmfSRV2zxftgYsFu7laMSr1Xxe3NAWAu5Z/fnxtrWdLi4Ht45qbsqU0NCf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJWMRqc2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc4fcbb131so38898005ad.3
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722346521; x=1722951321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbMfIOfcyD/XnqHRwxptJwbYvDCQDYJbWoREsRt80YY=;
        b=SJWMRqc2nCXSB+L/R8UyjdS9ZS/VEhKW3XhCRmk1tRupKxyVOffl2cUzJvYIAybaF2
         LAUmDom83w6088ezsvbBull1Rbr+mzLIoNFYm7Ce54/UIz/cSCjT/XUT7+OLqu6W0w53
         MfVG2Ee++8olBCBoQvfxefbPTRftG+jZKh9RERFKEJGCozbXwXmFe9yX0Y3YplRIQs7w
         qz+J6LVU54+aQfVwYpFDAK+JQVGbWvZNIpRCUxXv8A9hM+136rQSV2QTqb3tS4/cvt/Y
         j8vVttYctLYBREge8pA0fogvcVpAfhKKk+xnL9pMOvzrscdUyLeQ30pwYGTzyYSPvHxE
         aUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722346521; x=1722951321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbMfIOfcyD/XnqHRwxptJwbYvDCQDYJbWoREsRt80YY=;
        b=c3VgD1Lw6+e2PXKI1CPu120ND6twOLOjro1/tScA5lreHg7HzkHHo4aLGH9g4ubctu
         PDX7sYFTmH1albO7vGuIVaBaa5yclBsfjqKNlEZSNsChIkBkTIW5Nfm1wI5SqAdn9I2U
         ceIlWLtsAeEMoyD8plB/0YV0Cg3rtG4ml1XprIqw0E6xGZ0QhDoUsGTodkAP/gzNQSZA
         iQxCBKO3Vq62rpVmER03PLvTuTMbp6iVZ4NTlVo0g83hHKnYPzIXnZIKR2NCinDLU06z
         jwjwisv0nU1Y68A5dfHq81VpfJhc2utpMVWV/CLIG95BpLGTE18evF8FzkQ2qfqXquO9
         0mCw==
X-Gm-Message-State: AOJu0Yxd9ypBxYCCYa0S67fUzBynb0ZGZrsWVitBhood9ZSo4QXDDQfM
	LTe/jRKPxHv8/8N6cG6lbEsJu0xO/5neWFk2D/GHl/JffHB68JdE
X-Google-Smtp-Source: AGHT+IE9FUa8Q3PC1vKhlRbtVDw+fGzaM6ItZq6NBIh3H1176Raivyi9Ezdo2SYJic2DFkpQkzhYdw==
X-Received: by 2002:a17:902:d294:b0:1fd:a360:443f with SMTP id d9443c01a7336-1ff04839446mr102385555ad.24.1722346521202;
        Tue, 30 Jul 2024 06:35:21 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9f279sm101562515ad.256.2024.07.30.06.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 06:35:20 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/6] tcp: completely support active reset
Date: Tue, 30 Jul 2024 21:35:07 +0800
Message-Id: <20240730133513.99986-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This time the patch series finally covers all the cases in the active
reset logic. After this, we can know the related exact reason(s).

Jason Xing (6):
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_CLOSE for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_LINGER for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_ABORT_ON_MEMORY for active
    reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_STATE for active reset
  tcp: rstreason: introduce SK_RST_REASON_TCP_TIMEOUT for active reset
  tcp: rstreason: let it work finally in tcp_send_active_reset()

 include/net/rstreason.h | 31 +++++++++++++++++++++++++++++++
 net/ipv4/tcp.c          | 10 +++++-----
 net/ipv4/tcp_output.c   |  2 +-
 net/ipv4/tcp_timer.c    |  6 +++---
 4 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.37.3


