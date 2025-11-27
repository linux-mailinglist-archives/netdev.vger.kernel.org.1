Return-Path: <netdev+bounces-242204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A18C8D763
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D43E34E4CE5
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B0032692B;
	Thu, 27 Nov 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCsUdsHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DA326923
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234858; cv=none; b=vFMLLCkqDOpRX75DQsizgtf6VHZfEWVjZrI3tckX4ixJPOY0RYGdZ6OMasqZYUwdEloKJPzNIDjvR26nfxwJ7M/8IzGm/ZLSrXAGmmdq7TOUGpKnaxlILkaTGgfFJp8QVMrQq01LHQEc1Mr1lsWCElmZX8yWAXS5mTwURwS9iDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234858; c=relaxed/simple;
	bh=9o6F9dF0Bk44efPsTy4eIEAUB2CN1uDz6zXDBwR8zgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5Hby58gARdnZvKncVtl7KIddqEdjmgjs/K0OFPI1oao2smN5VuwDD/eBra64taQAWqZQhpp+hOzSWN1orWivYlQ+XuP2uEy7uU3vltw/kI54puy/2RUGrYSH0kyvbsiO7adAyFSrZXRtJ0o3a1trXLnNGx1VkyZxEp0svP75e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCsUdsHd; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-640d43265c3so100814d50.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764234855; x=1764839655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CV5SLM/9YsiVAzX5gDV6KouqTgAMBYR2PB6gAo+JnQo=;
        b=gCsUdsHdIEa46asVi9lqxrcOc3ZwC5EVsMX0nTxQGPtT3ZghCEtxX4F8uXPQGe+8y2
         p1kUZk+I+m0OpXrv/4IFU8EaREmbCxmndRdOR5kxDGelKKykRPXRq8wQO2K5fh1BvWrw
         1IB8topUbWX/fOV362vbqmFIyaxYye7wDjRURWJtwnjdonQsU2GMD1gEFrVXu0tiGP+e
         QR7HamGr6RNu2qREUgvmsTKZXtGs78ORss97VBOAtKorU98L7Sui7znD5W9URp7a4aky
         MoaaKOx8Fh3GSln+FZgLNAv71tKvgX6zcZf1roCfUZJ04Z5YD9vqY33cXS4NGwk7L2II
         LJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764234855; x=1764839655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV5SLM/9YsiVAzX5gDV6KouqTgAMBYR2PB6gAo+JnQo=;
        b=ZCZcgkjcKywGoc7w9f2hC8NjqbnwjHjr8gzVbPBH+4+6A+9TXj0NEi+JDlxGXvIdJO
         arwjHz16PzT55U+5ar+07zwZ4xR39V1sdEBBPE0QlAYjiRigVhWn3G9XFRiY+/scIJbT
         Mg8Y+RFL/Vi9pU1RxW8WEASvsYYKGCVmnuKy0Qz0iFCz7Q9OTEfJ4ydtUHATlI/OOzWp
         pG+N8rhW35BSNx/6P5CtF60g8El5q1VoAvzX7wqLUgEPHr0dNkORUIHJv/7TI2xzKkKk
         6zwtGSrjSnQBsLYHWutHBWaTTKuNds1OG63tSzyuf0qb71OsmwHUiXpBMBDATWqaOcCY
         hgxg==
X-Gm-Message-State: AOJu0YxGj+I7L8NooFTX4iUfYJ9Gw9Z68NA1Z1JkZ6nFZPeS+wh3+mVR
	/DJXlxf5u71vVEjuwHEwtgNXefBAc38aZB0rwPmPGEUPX2lnE8fWGICljDvSfriO
X-Gm-Gg: ASbGncsFek+SkUG4X5kiakCsf6488vsvmApzNRdV/fmq2TYwyIZ4j4HP0NwT+n+3LLa
	8OzDAs+NM2HFn/zH9/hiDSg5MDw4WYvumoO7N6W/0EvzBEFZ6yJFZLPfLxMN9AGuyO0RjnrIu7b
	XWsw1CRfwAtmuA/RaSCVF1MVua99eHPneh98Fw28kKBvSGmh9H6zUUwoBWeBdYe6br4Zy48/E46
	Pbrrkzik+z3CD6ZnZKBLwdtZWsZb7GO/aekFr2jajB+eHs0XY7QEZoDD6c/77FkTtRgve4i06L+
	pjpsAIiBPqhVgx1ZeocKKardCUh8Y4CYOxaQ8zdzX0Y7XHzup4DrF9tdCqtQw10nle/x9ucev9M
	farNbRr5AxBrqeMfCCA1qBbHDWsrig7BPdWd+dHjQjz4V5GUDgp0jZLUrzfEPWZw+G5wj0GmQs5
	PFzhI5D4xB
X-Google-Smtp-Source: AGHT+IF6EnbLx02rNvmtLy5sI8Y9n7mGR774bIUER0uxyNTh+UuOQvZ98HNH9OHK+t9jlPsQB7+Vkg==
X-Received: by 2002:a05:690c:14:b0:787:deea:1b85 with SMTP id 00721157ae682-78a8e12ae91mr151302097b3.7.1764234855550;
        Thu, 27 Nov 2025 01:14:15 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5bbsm3796167b3.7.2025.11.27.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:14:15 -0800 (PST)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 0/3] net: gso: fix MTU validation of BIG TCP jumbograms
Date: Thu, 27 Nov 2025 10:13:22 +0100
Message-ID: <20251127091325.7248-1-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the MTU validation of BIG TCP jumbograms and removes the
existing IP6SKB_FAKEJUMBO work-around that only fixes the issue in one
location.

For GSO packets, the length that matters for MTU validation is the segment
length, not the total length of the packet. skb_gso_network_seglen is used
by skb_gso_validate_network_len to calculate the segment length including
the network and transport headers and to then verify that the segment
length is below the MTU.

skb_gso_network_seglen assumes that the headers of the segments are
identical to those of the unsegmented packet, but that assumption is
incorrect for BIG TCP jumbograms which have an added HBH header that is
removed upon segmentation. The calculated segment length ends up being 8
bytes more than the actual segment length.

The actual segment length is set according to the MSS, so the segment
length calculated by skb_gso_network_seglen is greater than the MTU,
causing the skb_gso_validate_network_len check to fail despite the fact
that the actual segment length is lower than the MTU.

There is currently a work-around that fixes this bug in some cases:
ip6_xmit sets the IP6SKB_FAKEJUMBO flag for BIG TCP jumbograms, which
causes the MTU validation in ip6_finish_output_gso to be skipped
(intentionally). However, this work-around doesn't apply to MTU validations
performed in other places such as in ip6_forward. BIG TCP jumbograms don't
pass the MTU validation when forwarded locally and are therefore dropped,
unless the MTU of the originating interface is lower than the MTUs of the
rest of the interfaces the packets are forwarded through.

Mariusz Klimek (3):
  net: gso: do not include jumbogram HBH header in seglen calculation
  ipv6: remove IP6SKB_FAKEJUMBO flag
  selftests/net: remove unnecessary MTU config in big_tcp.sh

 include/linux/ipv6.h                   | 1 -
 net/core/gso.c                         | 4 ++++
 net/ipv6/ip6_output.c                  | 4 +---
 tools/testing/selftests/net/big_tcp.sh | 1 -
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.47.3


