Return-Path: <netdev+bounces-206124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85AB01AD8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5172B3BE6B4
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C32D6418;
	Fri, 11 Jul 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5qC+HRS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f201.google.com (mail-vk1-f201.google.com [209.85.221.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553CA2D46D7
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234012; cv=none; b=HZE5RTSGyrqd2VxuEsVpmlo+4HYn7S6xdRv3vkwjE+MlvonO59m/VnIHbsHzVXrx14Q02M2liuEK2OTrjZ5J+uBj0s0Bm1FwbIFdtYCsVGKgHzOLAKvxttf8Kpw6RrFSUAldounGbUPywupo1+KuNxwWNqtoSvVyM6iPC1U/syM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234012; c=relaxed/simple;
	bh=jJ7Rox0auvriBvOtzVOahIBnhql67Qe1ndCDRqr5+/8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mZgBpZYP/qA9tuzE2FeXV22TVdD9eCAcUBEVyj6XoR6xzWtATjXUzQHGrCAdIDsGMQZwUEVP+zF612UcNHr4Rue2uJ7UHcCdlO3dCt1QmcAeGrtXhqjgLW+GqHsBrz9y1VRENJ/Nr2LrUOaUL/VMA7F07fWvRbNx8MfLEddg0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D5qC+HRS; arc=none smtp.client-ip=209.85.221.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vk1-f201.google.com with SMTP id 71dfb90a1353d-5314dd44553so683760e0c.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752234009; x=1752838809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e8ctUtDikb650iS0xEC+RrELuptsXBndDjm74OG/GF8=;
        b=D5qC+HRSKLFEQpcaeqoJQ+w2RZxnf2gmM36PoqfuoAEX6B0i9EiA8TxiWtJyh+whgc
         SmDXBacxn3NU/M3XsGLXQwz6LkWfZ+Z6YwgVo9CARXMvSyjK2FmxyJ/vjCyhLvgPcFGg
         LSp5qBdBJIVimCaX9mqmnuY2zoVeLsjvQQ142B6egRDPMSayeFPiHUbYpuyh2M8Q5Djt
         SJdXldawAlkDm1Ikbxwgb5Qrb5SvGeMORk8N9P2HBAm922RU5I6OASdhUEl8cnqPDcSH
         LvxEB7tDw8sA/ZJIbmOt4S3D3IJffjhF/0jdF1UbNiRpNeom1R4zbMj16gqvcX/oQ0Ia
         etkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234009; x=1752838809;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8ctUtDikb650iS0xEC+RrELuptsXBndDjm74OG/GF8=;
        b=oThAkVvlo5sLd+qvixEpyIFLAmLgq+cfYZBozT3r0MX5UCaF/EdfsGnDWvTcb/6TWd
         KqQUf17BWgP4XGItAuemg1NPPllq80VZxBLoqYh5AZQ8HCSAjj7yNlavnHYLb4Hipwi4
         OYPCSnhly7Tgj4bsEWiBHdPSPWBZVajzc9ENuNFLk+4mKaqdw/5erQzYUE4FQODMilYF
         PhhxmTaX3a7R9ZEgD2zAAJeX+stW37yW4mkaQGx75MvOVU+HxV0H4LNzY/bxbRgAbJu1
         yGTp4MzVpXb+uT8fa8cIKNUoEW3qVcHEp3ebiRfLvguqXmxcZ+OKB9CC4tqY3kzu0Pyu
         1g8A==
X-Forwarded-Encrypted: i=1; AJvYcCVM1A9/fKZjUWAkCvXNbtCM/inihJE4cba5gGCX9Jd2KLT1KXYZnsqSHCeA+DtI++H7vFRMGyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbJv2iur3T7yc87fUkvDDz77y9O4m3Q4xKDuRNuQf64/mSPFc
	lhdAn9VKoMtDbC8LxZ9owJfXd0741sKFW98vQ5SPgQjvcMW/mW25lxheLhi63AcQji0/+IC9yM+
	MjPgZO9v85Z0YPw==
X-Google-Smtp-Source: AGHT+IEdLbzvN8h00LB/3fXrFSi+IIdYgew4V3jrTLWzUysSZiZeCcG1pD0OLiD0Vdcu6eIqkTdDujin+TV8XQ==
X-Received: from vsbka21.prod.google.com ([2002:a05:6102:8015:b0:4e7:f538:5e08])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:2c84:b0:4eb:eedf:df65 with SMTP id ada2fe7eead31-4f6e2d30769mr942533137.11.1752234009177;
 Fri, 11 Jul 2025 04:40:09 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:39:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711114006.480026-1-edumazet@google.com>
Subject: [PATCH net-next 0/8] tcp: receiver changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Before accepting an incoming packet:

- Make sure to not accept a packet beyond advertized RWIN.
  If not, increment a new SNMP counter (LINUX_MIB_BEYOND_WINDOW)

- ooo packets should update rcv_mss and tp->scaling_ratio.

- Make sure to not accept packet beyond sk_rcvbuf limit.

This series includes three associated packetdrill tests.

Eric Dumazet (8):
  tcp: do not accept packets beyond window
  tcp: add LINUX_MIB_BEYOND_WINDOW
  selftests/net: packetdrill: add tcp_rcv_big_endseq.pkt
  tcp: call tcp_measure_rcv_mss() for ooo packets
  selftests/net: packetdrill: add tcp_ooo_rcv_mss.pkt
  tcp: add const to tcp_try_rmem_schedule() and sk_rmem_schedule() skb
  tcp: stronger sk_rcvbuf checks
  selftests/net: packetdrill: add tcp_rcv_toobig.pkt

 .../networking/net_cachelines/snmp.rst        |  1 +
 include/net/dropreason-core.h                 |  9 +++-
 include/net/sock.h                            |  2 +-
 include/uapi/linux/snmp.h                     |  1 +
 net/ipv4/proc.c                               |  1 +
 net/ipv4/tcp_input.c                          | 48 ++++++++++++++-----
 .../net/packetdrill/tcp_ooo_rcv_mss.pkt       | 27 +++++++++++
 .../net/packetdrill/tcp_rcv_big_endseq.pkt    | 44 +++++++++++++++++
 .../net/packetdrill/tcp_rcv_toobig.pkt        | 33 +++++++++++++
 9 files changed, 152 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt

-- 
2.50.0.727.gbf7dc18ff4-goog


