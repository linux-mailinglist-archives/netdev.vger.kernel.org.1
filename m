Return-Path: <netdev+bounces-233204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80EC0E6B4
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE7214FF2B8
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C92BE7B4;
	Mon, 27 Oct 2025 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apxUIWZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B7C1E32D6
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574550; cv=none; b=MBFXClRwRzd2Nk76AvaawiKIx1zGxSSZ0ADcrbqKLzXnx2QIOzWMjs3AsRlqe/lOE6LfvGnX2Ici9nxPxcZUZVjY+cGuKs+iOujd00yT1VIMuA83pnDI6IVtTteqfLp4npM6ZM189a1ggzmMkKZf+qmi5XimTMOBxBZd8oaQG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574550; c=relaxed/simple;
	bh=BN0B1viip5cEGxYQ8Byw7+3n3EaaPjNb5qWKQKHhO44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8ueVOeHXqzYvssLKK3m2sCeQCZUB2Mg2NVX7waEjqnGhmzoFyhbUAAgtUFSI0FoMquHvq05Rps2FFsM6TTX2kZRMLcws4Kg5+mq5HTIQLCHd99PSlU05qgmtNWDeQWwnBpcUSxLzGzjh9GLJvbHsyu96CVk0OXqCqEtA+7M7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apxUIWZO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a2738daea2so3957713b3a.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574548; x=1762179348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqP/tFEEHDNzJ0xzPMLOoGVbbMkSCsGCa36SLEX5bKQ=;
        b=apxUIWZONSSbH0uCX73zg60qcHKl0lxDfcqREhnzpfoTaSxd/UN9ZLZx9sG8PSptsZ
         9wZQwtbEWiBwXtXWmQuMRZSXMcZ2pLRu9FqciIDu4GcnH15ja7Ydacv/2RqXngrlqfHD
         Y0xJtxE79XdlGdxKAmmOP+LNvSF725AdyFbZ7qhu2eTbwjhrawyYcqUVRSGFXBEvewxD
         ajZpLcLEC20oAV0+7t7aKsGatkcFkztCsKeUcmHMlBgyxAY5YefTENlpgq2OqdbqIccJ
         ufeTcNFq5oeK24/matDRkAwV1kZxKqhXVKUWArA1jFFnCNn5y4APtc1hT03ClkyyQ+/p
         8v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574548; x=1762179348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqP/tFEEHDNzJ0xzPMLOoGVbbMkSCsGCa36SLEX5bKQ=;
        b=EoHw3hEezMp9/MjoEMnw9Y3K0IE/fB3ls2Gx5yrJTDbbXL+E2XPxmgQwDvEN1ZFdfR
         so3xtdcAeOW4Y2WpUtfXdDhjAPeWoFqYxTr3gw/ylSCCDKr1wVXvIv8uct01I03VixPl
         pR4pRpWhMvMzJJMRaCtFqv/eX7nK/9BIaLTEhQHiqE6uoy4iBrf/bA+3gR2Vb3yE21s2
         Y36pSzIl6MI+n2H8mUCf9BBBD13Z9gM5m0h3KogdTfPdrPQXFsljk6Aemboq5eDcTS17
         VPiUl7sJl5YJ0kvEgaLjYYuMUg6vXZn9hTS2u7uiSFlx8OEEesMACfyx8M/gohvGNrGg
         i36A==
X-Forwarded-Encrypted: i=1; AJvYcCW3Ta5+zBqb4SthLffOd6cq+xL+UGd1p4USkLW+jk5Y6Zol39B6yy9RCpPaDjgY0eT3M9hQfmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSEP13YiUNMjjdG3MlSY68w3N/MZ7z0flR85Om1AWW0KVo1/b
	EtlODaAe9f5Hgc0OVVenoaHo2bc7e39EakYfzTbHSF6A+GDj3Tks9Ik2tJFEFa3d3s8=
X-Gm-Gg: ASbGncvIQxBJaI3BeQs5i07uuX3wvAS24Lix96Hi0aWlR6oQOWy/Lirr1WO7JTIUdWn
	weqAU4/lbz0wbXYRoSHqZMC69acyi3CM4UpLivvQ6j7tmWrsuRBbbnV5qXa9VQ2mk9mj1SKl/71
	y/7pwfZSGXRDt20d21NQjr5qqZxxeALCA1cFW28efHMKqBqqpmrumCQlVjLFAkhB1J0UK8q+khk
	/A11fkdoIa+2HLY51pyrBYNuyEXKCSDaM2F0HOd9RvpPFTishAYQG0pqPNJLnRSkofdlZCFw07w
	FNrRcg3ktHkqrlf/ebwVEoim2ul4mMdnpEbrw5civ5+yLJ2cgpL3DiQcNAgHbfy1qFh+mZ5ukMv
	wN5nnLeDb0lJT1khFQXEz6ptX+77t1RR3ZHvceWd/TdvSu1Yp7lqMhPsxhsyTN2VpHumtPfsbMx
	bOu5qC/Ll66q3N+9yvx2gsmXo=
X-Google-Smtp-Source: AGHT+IFsmR+a6JhgocTZ2HjeLtDvl6LPTelhCD76lVrghPUPZVlA3BMKDebbFVo6wETGuCyRFuuP5w==
X-Received: by 2002:a05:6a00:22d6:b0:781:1a9f:aeeb with SMTP id d2e1a72fcca58-7a441bbe803mr147243b3a.1.1761574548086;
        Mon, 27 Oct 2025 07:15:48 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41c70ea64sm6788166b3a.3.2025.10.27.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:15:47 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: kuniyu@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	wokezhong@gmail.com,
	wokezhong@tencent.com
Subject: [PATCH v3 0/2] net/tcp: fix permanent FIN-WAIT-1 state and add packetdrill test
Date: Mon, 27 Oct 2025 22:15:40 +0800
Message-ID: <20251027141542.3746029-1-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
References: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kuniyuki,

Thank you for the feedback. I've shortened the test duration in v3.

The test is now:
- Moved to tools/testing/selftests/net/packetdrill/
- Reduced from 360+ seconds to under 4 seconds

Please see the v3 series for details.

Best regards,
HaiYang Zhong

HaiYang Zhong (2):
  net/tcp: fix permanent FIN-WAIT-1 state with continuous zero window
    packets
  net/tcp: add packetdrill test for FIN-WAIT-1 zero-window fix

 net/ipv4/tcp_input.c                          |  2 ++
 .../packetdrill/tcp_fin_wait1_zero_window.pkt | 34 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_window.pkt

-- 
2.43.7


