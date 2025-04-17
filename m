Return-Path: <netdev+bounces-183575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE5A9112B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1430219073B1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246B61AAA32;
	Thu, 17 Apr 2025 01:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Niit9KmY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3D74BED
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853588; cv=none; b=GJnLwiheV7sebo6K6WMnKsrw3dFfLfEzYM5urcEVDlq88tPEwolu6NgiXgKwiA3gvICF2fTuagB0lk/vQJtyPxfgArThVj5WlPS9onmCDXtWJbvsDg8BN0pISYn3NrKsQE6DzMUg2tCnmVvi3l5p3f0jYoCbN1r2lRB9nwAVTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853588; c=relaxed/simple;
	bh=2xULYgcWmIJIehHFYM/bibVezPdaJmAJv90YTx9g74U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZGVL8YcBj7U/ca7TGdW5/tZo+GKQym6YeMqrSdNnubERjaBpN4U1AJJ4YHx3DEAQnjbxctA81Og87/AhW0dX5TzlpWhVMhLH9NlyE0/RQBVsxGicwM+IM8+pFD7vZq3BWNAZpoM+ny8qYRq62Ll+Gvhpfyt6ImRP5OQ4F+hO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Niit9KmY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2255003f4c6so3180225ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744853585; x=1745458385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl7lm0q1pdo1TJIdPWC7UtnUlQ76D/cDOJLKOcjE6io=;
        b=Niit9KmY+zeqZb+KOolZ0UPw8k+9oFE9HAUxH+EOggwLn0LbFnpTqB7MfJyHqc3jYz
         dskzprgL1yZRgw4itsd7cz188OasiYGAbtVbw2KnKTKziHlS2ZQy0dfkoMvQpkqANJss
         BP1B3dONTAbPh1auPbTt4EqMAVe9IuB6h1UEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853585; x=1745458385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cl7lm0q1pdo1TJIdPWC7UtnUlQ76D/cDOJLKOcjE6io=;
        b=MwaqUYPpftGITBkvjGrbQyR48X6oYwhMT79Wf5DLSociPEddUjfVd+RAPLuBqe0F1+
         ezJpi+dfI95TUyb5+di/o/q+PocbaGqomuDfIRriI2tiHx1zdS8hOH6oiSAW218EMGjq
         ZXbK2iK6sQGy0hcLUfrRMlfRIBOA4MnWQHLThNUCAaw9ANVawtsc7yhIEVN/ffivUXqh
         GK1PxD4GR0Tj9x18y4Til4Eozy3WVtqpe1qyczMAPeoI6crBr7Wn2b90sGEYhfwUf9y6
         +LVGPrk9/C/5VaQjukcCI6P0cA2eFmLSQUu+czcJb2h5Mt4o4Z2ArM0XAfaOzWvEaTTq
         3a0A==
X-Gm-Message-State: AOJu0YwTcc3e8b9Q9krTrMJ8yR/IJ7QA23CrJRjvqj3kTl8ydXEBEpnE
	UagfHJhD4mhlXLDGxLdryrTVV5ce52cEy16gghmsPEjhMoUSEIvJUT7zXKya//goW20XMQ44P16
	RzO0Nl1A32lLY2LpusKYDBPF/4FXrHjIaYxsVnG4vHAA52MFRdN7WcRChrOZYga2nKmHFmwKoPj
	vH8IojorAJ1LDvK6xO40mmGiI3fqNHz5RLFX0=
X-Gm-Gg: ASbGncuH1261yDwrxmr/fzOLGSnLtytM9PMRruUKK3iPhYBCfStUHFaGgBVVnBuyDDJ
	iwYT8XFsvX8xlVqNz/kspJNSXzMgBb3QfU5ax36QLKbt9fg/GOQ8cyB2B2w/OgRJRtFvDrzoEV6
	F20iSGBdRxLCu4sp86JLF3H8jIuIMWWSxZzR2wtPqEPE0nsSCA7+FbIOp5pTtFd9XzBfzlpSDAg
	XDuA2ZaWAy+8b/Ff6bbkXxISyrU8hisQmmyzW6rrsFQMf0FfLJ+e2O5/jXCfrphGTp5/6dNOhWS
	oVkEXRl1fA+MuhQtCnPwNeCIrOyzPRUsfP/QZrSYEAYth64o6TsCcW25+Gc=
X-Google-Smtp-Source: AGHT+IEfKQ+r/gnTBZHe1EymGe3tKAmJ5TO38k1pfoylMUgPGDSds01vW9UdN7R4QlZfSpduWCIKYg==
X-Received: by 2002:a17:902:ea07:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-22c358dae13mr58260805ad.21.1744853585258;
        Wed, 16 Apr 2025 18:33:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm21349505ad.37.2025.04.16.18.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: [PATCH net-next v2 0/4] Fix netdevim to correctly mark NAPI IDs
Date: Thu, 17 Apr 2025 01:32:38 +0000
Message-ID: <20250417013301.39228-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2.

This series fixes netdevsim to correctly set the NAPI ID on the skb.
This is helpful for writing tests around features that use
SO_INCOMING_NAPI_ID.

In addition to the netdevsim fix in patch 1, patches 2-4 do some self
test refactoring and add a test for NAPI IDs. The test itself (patch 4)
introduces a C helper because apparently python doesn't have
socket.SO_INCOMING_NAPI_ID.

Thanks,
Joe

v2:
  - No longer an RFC
  - Minor whitespace change in patch 1 (no functional change).
  - Patches 2-4 new in v2

rfcv1: https://lore.kernel.org/netdev/20250329000030.39543-1-jdamato@fastly.com/

Joe Damato (4):
  netdevsim: Mark NAPI ID on skb in nsim_rcv
  selftests: drv-net: Factor out ksft C helpers
  selftests: net: Allow custom net ns paths
  selftests: drv-net: Test that NAPI ID is non-zero

 drivers/net/netdevsim/netdev.c                |  2 +
 .../testing/selftests/drivers/net/.gitignore  |  1 +
 tools/testing/selftests/drivers/net/Makefile  |  6 +-
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++
 .../testing/selftests/drivers/net/napi_id.py  | 24 ++++++
 .../selftests/drivers/net/napi_id_helper.c    | 83 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +----------
 tools/testing/selftests/net/lib/py/netns.py   |  4 +-
 8 files changed, 175 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h
 create mode 100755 tools/testing/selftests/drivers/net/napi_id.py
 create mode 100644 tools/testing/selftests/drivers/net/napi_id_helper.c


base-commit: bbfc077d457272bcea4f14b3a28247ade99b196d
-- 
2.43.0


