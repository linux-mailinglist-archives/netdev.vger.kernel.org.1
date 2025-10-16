Return-Path: <netdev+bounces-230088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C7BE3DF8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10B854E1349
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194D33EAEC;
	Thu, 16 Oct 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="geS9NYee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B82F510
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624562; cv=none; b=ehbCac3RY7yVLGYb3KOsW3MC5EGM0RTRVnyMkfbT1XtdDjBj/kuu5O+w7U24xd0TRWCKfkNsKCKt4MArYy86vnbrfgRpJspfvWuTeMchS2eAHSyps69hDbecxiEF0sowVtOM5N9Z9mLhFQwolorfOb4mXwDbqsOaEEjACLwRNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624562; c=relaxed/simple;
	bh=tZaf+A2PvXcH2tDAW/A1moNekw2CEZay02GbTV9AItA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IvZrg3RixazIaBaJTulUQwf6aH9ue45yM7IEHXbIUZmszjSt1eQ9tPKmncz/OHYSWcNnGh+QO6mIuHUz0Q5qU4HM8FSspddIwfBuljdGlIgoP84Uc+0QMxeGEuRGS66yUQ9+RJSKuIjvQ3JmAr+6+gzqRNHp0ctODWgkuinHjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=geS9NYee; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so1240085a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1760624559; x=1761229359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqp+JTzhgzE/t840OjxkqysLCCK0h7QQJobJ/qJ+gYU=;
        b=geS9NYeeVjWSna/LnbSqsyFAWwn5Z1ZJI4AYqJHBSb9mUes6BBofUDoBaMIAyHbUKv
         cTkuH9WeQd86OqGw50x4HwxE8WIaNY/V4nUCpnY09Z0wRK6ElzsuQsu5/BatfKxMb0Yg
         lmNUCh/TOz70Mb3U9UH6ilLW/3NX7h70tSdr765VqlNtFotWhbnsEcsW1EQK98AQYrQD
         0x1jhFH5R2LWCNAk5afp7iSP0eqoaewLpzFVBZZK4rDiM3331+35HbmfLnNQ1aLKuWvB
         JH1wvQwA+gUViI34obIaPDMqhCa3m0ocFexWqsgk1dnWJ3DwbWJum5WpeEPuIuA3rQUz
         P+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760624559; x=1761229359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqp+JTzhgzE/t840OjxkqysLCCK0h7QQJobJ/qJ+gYU=;
        b=p7rAEy+C58QYmlvdlVCfjZaCNcp/B6xJfFGXlnKYg3YG7Lbc4brVEcaRodlXDKdZsn
         VdsK5yccvQD6aLNPBWkeScla5O9VPtevgeRuk+xyFTz8mcMGYsSLwXpt7WyGiW9LpE4l
         YUg3GazxNNfNBfgMqWWSs6vfnWLxTQ99Omvr3RvChkIuYeaqn69/HJCaqvZxAEvq8rDc
         /zYrpQbYkwCOX9eZWHzWFHhyPmfbsbcAPjcqinEzuEF7GzzCs/KnutHNe4twAi7DTvbD
         8PkUSSFCY/L56xvna8pKo5aT3Jd1Zf67AMZYZve/C2ry5zXOx+sV7VjwrDqBlPJyHpfz
         v4tQ==
X-Gm-Message-State: AOJu0YzYG2yK2Xryo5Wzk+E4iabaS6Z3B/beov8zf6cbZt3wHuig0j+n
	GFtbqbhODT0RWemMHe4BaCxU+b4chqqgx9b8svF4jjpo1He1Cw6xgGFh6vzYH7oBAqnujv767pY
	etp+HsTQ=
X-Gm-Gg: ASbGncu7U7IMaOC1MGRtqr77vU5GU6/3AP6bieEATcnDy1HD7rn0LVV99w6dW1FHkqA
	K7PmVy0Fz4OyJIeVvyVzXzKxIsGLMCDdHOyNtbKCfeDqSKvY+7MdOfT9u7wdSxrH12pjJrMnHzS
	1MB/lagAnEMUe1Om26mGYxZM50j+7O3QzvR7NtA7+IxxtHByXoSY22YvTfrF+SOQWSW78QkZiEy
	VPCm7HfLLbihJ6Zw53MiqSr59Xb/vl9PhkO75hovt7RkvVWm9gSn53+94sgArc6Wjx1cdaUst5y
	w88UTDt21ryj2uRNPLRsvewr732TCQ6gdQCWAQpaQ8poNMYoTNQgLuULzp+NpJ6YLALVq8vdrtS
	0ZNGaoLLBcJ9yZVdrcWRl4PIeO2fU/QZr86HPknx719+GMFBm6/gRsoNOQzqCXWoItrqL005845
	AcmNP4Gg==
X-Google-Smtp-Source: AGHT+IHZHmt5G+LlAeHCBeTMfguw/70tLFFC1LmxxzUGib1Obv4xIAGDu142Eqea3ubkDLKvbJmA+w==
X-Received: by 2002:a05:6402:5cd:b0:61c:8efa:9c24 with SMTP id 4fb4d7f45d1cf-63c1f6f62a6mr27000a12.37.1760624558968;
        Thu, 16 Oct 2025 07:22:38 -0700 (PDT)
Received: from fedora ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b1e89csm16174574a12.19.2025.10.16.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:22:38 -0700 (PDT)
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/3] fix poll behaviour for TCP-based tunnel protocols
Date: Thu, 16 Oct 2025 16:22:04 +0200
Message-ID: <20251016142207.411549-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series introduces a polling function for datagram-style
sockets that operates on custom skb queues, and updates ovpn (the
OpenVPN data-channel offload module) and espintcp (the TCP Encapsulation
of IKE and IPsec Packets implementation) to use it accordingly.

Protocols like the aforementioned one decapsulate packets received over
TCP and deliver userspace-bound data through a separate skb queue, not
the standard sk_receive_queue. Previously, both relied on
datagram_poll(), which would signal readiness based on non-userspace
packets, leading to misleading poll results and unnecessary recv
attempts in userspace.

Patch 1 introduces datagram_poll_queue(), a variant of datagram_poll()
that accepts an explicit receive queue. Patch 2 and 3 update
ovpn_tcp_poll() and espintcp_poll() respectively to use this helper,
ensuring readiness is only signaled when userspace data is available.

Each patch is self-contained and the ovpn one includes rationale and
lifecycle enforcement where appropriate.

Thanks for your time and feedback.

Best Regards,

Ralf Lici
Mandelbit Srl

---

Ralf Lici (3):
  net: datagram: introduce datagram_poll_queue for custom receive queues
  espintcp: use datagram_poll_queue for socket readiness
  ovpn: use datagram_poll_queue for socket readiness in TCP

 drivers/net/ovpn/tcp.c | 26 ++++++++++++++++++++----
 include/linux/skbuff.h |  3 +++
 net/core/datagram.c    | 45 +++++++++++++++++++++++++++++-------------
 net/xfrm/espintcp.c    |  6 +-----
 4 files changed, 57 insertions(+), 23 deletions(-)

-- 
2.51.0


