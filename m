Return-Path: <netdev+bounces-251405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AF5D3C3B7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A782523601
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09EB3D1CD8;
	Tue, 20 Jan 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7DnOmKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85E3D1CC5
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900962; cv=none; b=THw/Bv/nuhA7Act2OwfbVn/gEuAkokhjWl1jCiZr1MC/qz+Yhx7wVUNgTxv6B9uh0mRxm2pLeWvfUI/KhQfMOR080M5fx1+zpA7W4e9fudiXpmXO8AZUKR8R7PTD+HEGfuszTrEAEehUzQM55P3mCQpSapcF7dBTJ4k/VMza3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900962; c=relaxed/simple;
	bh=lD+mKH/VoL7U+Xn8rlClapNXVv2BkfA7db4D0sWd64Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaVsOnuuz4Xr8mshsU5N+kVScM77N7ZJmtBKBTjdyMQi7TcaT0VuEGSkoqN4/2PaYAyskcO8P1qdFyz2tpjPqVwzAXi6z+eSkXdCv+Mrmd7TPgtU/z35pbG3ufKtdbseSbvtTlclqTcnGD3Gdj1JPjBEagepEyu9XZnUuJ64ZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7DnOmKh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0a95200e8so33292255ad.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900960; x=1769505760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWSMDHHZmGWMxvi8CWFXwngeoN3yjP8cY0r0efHq7Mg=;
        b=X7DnOmKhGAuCbMeGGoplek6HbG1msMHmbRqtB6t7P1aBzrY7MkxSfLg1sQ1OgKkbFg
         bH5knZmt7n1lko3cMfUimBCvQ+pkx6CLKFw99eQR4pX1UFJ6ITaJJ6dtk8tdpoNTxjRu
         48bZa1kGgkO7W9eHijSlI7JUpY7YkeiHskkljg6sFFWVylwGWtOIeYJ/3k9ugigQ3gQh
         ssAFiCKngpaXgWADJufQ9LCbXSumZmphgenannh5pMDmCQxto9ldRL9gYcwtp9nLh+o7
         C1vZ3mJTHewVHwx1B+xYyVXh3TutFy7k88+piBNZiX4hsVrrmy0NNrxtMV2zgKGxPJav
         jLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900960; x=1769505760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWSMDHHZmGWMxvi8CWFXwngeoN3yjP8cY0r0efHq7Mg=;
        b=qdX+3/o0aSh9H96N9cd/ep2Wkr/BTCQqBR9XCQF2O9NAZ4Nat8sz4fbH3mv7ThPdYZ
         TS6TEnkg3rfQfaB1nL2jkZA7W5OH1nA8c21ZVld9ynMcdBVyJvakb9rDl75hLCT98KTz
         5grVtENH9U4FnACOvKKihheVz/3QyKtWtSbbOywVaHOft8m8Sn/GdBaLaPVZAdGG5fgq
         h5mbfPfOUaxFhexQP6R9Hr+ln1zbGeuTEMOYn3FMpxTllzdxQiQkGhk8iD8CzogeWdpa
         tz5sseegzwH9RVFuTEIRvNJBMtOF0xV0E7JXwa0ExnF7YRajDSkBfqpp6iI2Q3aEVrLA
         eIiw==
X-Gm-Message-State: AOJu0YyxGCW1qgt73Vgb0+FJGFkomxX77dfzE1LcCbKmQ3rdhedGrL0m
	LtA3XceaCC6chYlDSG9lXLRyYHtaTPZ5YEBC4fAXy2/7elUonGoRVVfQIFQ3tA==
X-Gm-Gg: AZuq6aIZezGZp3dOeM8hPvx6APh6zScVcXWDJS762ytB0Fo3Ynb4cdA2U3L6mcXihyA
	MII2JFeJc+2kNfC561dAWteLDtJRoFBFLrUxnKRKEV/ETCA3MWajde7GTVkjX1oTSCM9qfoUFDw
	Mn/P2qI1xXheoYexYZ7z2dHHevE3raczZIbi2Xw7T+FEOy+GdaczdPNim/Y3q7tjJZd/7eqoc2c
	4pnHhNzzNcyFP8DXnxi5I8spAMN+5IBnbxABhbEz1zr78GeRsQ94F3XeubbNCMdBa4LBuoIDyLQ
	+V5v2kBAt0Hqn18BDFalPWdvouriW5oN6+rOa5ntd0cOmv6Dbm8AEaqjgBsXL4GHfg/lfRhpl1e
	gxWjZuiCnRb1E4x1q3sOalv2HOoBHB74e01rfcLccDB5BJS8h63o0QrmIjiMS5T5eqMlxZsIYAi
	YEfXerUFjaeYC9ayVU+iCGJP8/HIo/FMuozIkrivWwqGoM3L+jzP1Bbg==
X-Received: by 2002:a17:902:ecc6:b0:2a0:afeb:fbbb with SMTP id d9443c01a7336-2a768b7a743mr10676105ad.1.1768900960214;
        Tue, 20 Jan 2026 01:22:40 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm107330435ad.87.2026.01.20.01.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:22:39 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Carolina Jubran <cjubran@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: [PATCH net-next 0/4] u64_stats: Introduce u64_stats_copy()
Date: Tue, 20 Jan 2026 17:21:28 +0800
Message-ID: <20260120092137.2161162-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() should not be considered atomic
against u64 values. Use u64_stats_copy() instead.

David Yang (4):
  u64_stats: Introduce u64_stats_copy()
  net: bridge: mcast: fix memcpy with u64_stats
  macsec: fix memcpy with u64_stats
  vxlan: vnifilter: fix memcpy with u64_stats

 drivers/net/macsec.c                |  6 +++---
 drivers/net/vxlan/vxlan_vnifilter.c |  2 +-
 include/linux/u64_stats_sync.h      | 15 +++++++++++++++
 net/bridge/br_multicast.c           |  2 +-
 4 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.51.0


