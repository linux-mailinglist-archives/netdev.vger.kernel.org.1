Return-Path: <netdev+bounces-247335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB2CF7A43
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D95793002D28
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645332DC334;
	Tue,  6 Jan 2026 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CildlK2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB74199E94
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693195; cv=none; b=sl/n+MD2XyXxgh0X8N9/WWllMkzD7YIeJcdJIQMDF/qLlIrw9fECDQVS3kOv8IJ4xd8cskl9y+zWLQYctJc+FeFsYyutxcuyaOokgzLQerz0kD4lQbnRpeSaCTLF+RpiTUfP6DteaVop444Zl+9MI41POL6Hc/vQB9MAZnmDkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693195; c=relaxed/simple;
	bh=k6pEvULw0mF8EctzHs4ZXAGf23E6Z7bk02bwoHhEHTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rk/dFSmM0tyEn5F64igZmBcFzbJNhLtr8GDvWtIzEioAmyFcgUbgdvWo1+MlywACgG43DPcgxRHFSqz1zStiT2ksiSXmLE5kTyfwYubFJ9oZkM8sTMvDZj72X2QVqqxLFU6Lf065xaBYyjhwfvOWdA41zWtfe9OF96OZ5elV1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CildlK2k; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-790633e6491so470587b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 01:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767693191; x=1768297991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xR4lds7IDmGVUwnlmcXe1ITrTnNOFe/cKWbsTvlK3A=;
        b=CildlK2k0mGCStbtey9YO4LiMQmelMazcfVgygP85KBMOY2VpTQ+5T+zKfy7VgHSXo
         3LGg/EZIp/jC3bxf3HcewOUFbDblVMWmbbgAWswrReUll99pcU0+O9uBzXktshUMxkTE
         d1DuloYsr/rQlNMGA2PowmnBbp1rPrw//nul6NQLN2IuLX+xOAZfE3PciD2J80Xa4tM/
         dQgkmoTZus+jD2QoXmJpzewq0TKaX2/bBzQO3V03meRNMpgL7SLs46opaw1eiR8Xk3JY
         Vz8rsM0CIRroADptLoZvY0D8zGAQhE+eK79roXfkQwmvAQHmWaBd9ATbp/74gwgfMFvv
         oWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767693191; x=1768297991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xR4lds7IDmGVUwnlmcXe1ITrTnNOFe/cKWbsTvlK3A=;
        b=C8kSG5a+WrgKW0QR2CvbchLn6NLqmHz6FH+xAsmYSG4zrQUDaIz6U1hq+AF1nnK1b9
         nG5AzrYi7ApazziKqFVHVzyvZZNkv2sh4q149Qg3HugVBDkeU3Tz6jiQFpMV6WRXmCMY
         /mC/Ds2/aEahS3e4GcySi1V8Wkaz2ZpphMVKyE7jm59mHXNTXyzBNoL/UYWGAvWWQJgg
         FCJYQK41Ujwzp8Y56iX0+zaWPCLW5JG3e7RJcS2lJES/n6tLRkFMg7qM8XlEjMj2xMwS
         3S8o+9pc2jN8Jh/oXrrvEvXbsKv6tdhMDSdnrWglOOcOuzVojlvj7kXxtuMeq/F+DaQp
         5Vuw==
X-Gm-Message-State: AOJu0YxRUMb22uxmfvF9ajI5d84dKrIm8W0ty86aDnhhu5zEC+0RqVai
	Wv4o4Qp9egf793NyO56V/oUq4GvBnv/f3Xtgoog7wK8D/Nb7SHEKfglVtmeUlq4P
X-Gm-Gg: AY/fxX44zpI/py/FSczQ8tunz0DGDT5ECsLcc+XlkYiIzaAvU3hRdVIj3gDYFD7rFPe
	ktFlvMGjUtVLrhq+UEHunKdS2OndsaDdgzAYFKhdFiMpaoA5Vgvn66KJaaj4d9gUWu+YJbcpHlZ
	4LLrCeekMEhjTXNNFaG5hbkYAzU/nH7X99Ogppmbt9ViLvLeddfain8W+Lql7u7yvT+qxPIJhMF
	+f0H426438DV7wBON9uEZ6aEdkhTxxBNI2+ngHWc8f8NPtI6PdD11leL/mTWoIUiw9k8FD49p/6
	KLP4uZ+UzcnlTOeQLKdVtM+4tWfBCXhtqrRd3P78zj243t/dp4zPuUG9X+CKzDpd4Aeewzv+F6p
	oupEzG7WOVIDDGpEYqVz5XOiSfyoheKnDb7v/5ufURn232sL/MpPESRWyN24YH6ybSC6IBw6UfH
	dVHOBaQ5vG
X-Google-Smtp-Source: AGHT+IGDCWmrg+r69TTcCz4Y+PVv54sZgyTrmeSKnWiMeajJYMxddlyY6i80YdOR2qGldgdkRCwRMw==
X-Received: by 2002:a05:690c:110:b0:78d:6aae:9cf0 with SMTP id 00721157ae682-790a8b796c3mr16944877b3.9.1767693190616;
        Tue, 06 Jan 2026 01:53:10 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6dc249sm5722947b3.51.2026.01.06.01.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:53:10 -0800 (PST)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next v2 0/3] net: gso: fix MTU validation of BIG TCP
Date: Tue,  6 Jan 2026 10:52:40 +0100
Message-ID: <20260106095243.15105-1-maklimek97@gmail.com>
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

v2:
  fix jumbogram check in skb_gso_network_seglen
  add jumbogram check to skb_gso_mac_seglen as well

v1:
  Link: https://lore.kernel.org/netdev/20251127091325.7248-1-maklimek97@gmail.com/

Mariusz Klimek (3):
  net: gso: do not include jumbogram HBH header in seglen calculation
  ipv6: remove IP6SKB_FAKEJUMBO flag
  selftests/net: remove unnecessary MTU config in big_tcp.sh

 include/linux/ipv6.h                   |  1 -
 net/core/gso.c                         | 14 +++++++++-----
 net/ipv6/ip6_output.c                  |  4 +---
 tools/testing/selftests/net/big_tcp.sh |  1 -
 4 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.47.3


