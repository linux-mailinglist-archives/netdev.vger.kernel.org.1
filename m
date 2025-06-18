Return-Path: <netdev+bounces-199233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39473ADF82C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75441898510
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5004C21D00D;
	Wed, 18 Jun 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+ndTP98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC221CC57
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280179; cv=none; b=pE0n3H9i6oxTRv9X9bYdquoj7+xKR/YVFIIKmR/sD+YZ0LfskBs/jXE6NskDMJbVr2trX428aVEy1xh9ajMdc0BQEBKRJb1jEgoWOf0HKMTSKe28hXRSb15sJCRxZp4zoWzAVrxCBdQRBnmlq2qymLx3erzgNTml2BwDrImGmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280179; c=relaxed/simple;
	bh=yPuRJawzEWJ1EyGIWK1zT50vZKMJKo73qria//lQPcc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p2E/1FHUkB7JeiAXvDoycuEpgmN9t1hqXHvDktWpn0GS1jRFcPyJbs6VRXSctBuySSTrp/G/essSnXNTCp7J/pW0kuGZ45yzXxjNuBJBOepyBCLQsYfP7FrnJ0zpP52zjFQKfztJ2mmXTUTsAXLrGsW0r9TTpy5iptVK9kJPXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+ndTP98; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740774348f6so49353b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750280177; x=1750884977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mgEMhBGnSzoypEISslS/Kxa6JMNk8Qvu76svdRFkeqI=;
        b=c+ndTP988uqDrlxPPwYGFNBSFUR3l0RfkzD/PPmMrdRN/CyS65CMsHZaJYf096zQur
         3g0g5ypbJozgtEkf9kmhxAg/9v4X0cNl+vg2prNwmTCd7OD3DQeOHiTdgt8zaoaOr0sL
         a2GytWRurqrGs8snCBq59yalgfWBYZxILt+7FjI5OX4iIth9IeKp7QFHuL0bIw20mXCn
         XFzo5Ka2fKVckRZLTTNMqENjBver40jSYF+NYppqsNKsrjBFTs8hnOWzApKMZu0iQSrW
         rR3mjleyEbdhrYUFpyKdjXwHWCgygLng7Iz4hfiMBV/8VjWFvq6VBH6MbzTpr9IvXFAU
         4zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750280177; x=1750884977;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgEMhBGnSzoypEISslS/Kxa6JMNk8Qvu76svdRFkeqI=;
        b=FEx55vomRN8iEQdoMLAre7xLt17xPRRyaNMSekunQDiwWFTfhfhQov0jf1iVXhvwNy
         5E4g2pUAtpW6BJNyVgG9o9e227ILK98FKM2bdDtwYuUg1KvgUBb3uxJaxvhYrdAVcYJq
         QXwb5fw1Zy2gzpoR25TfiiAjvXTym+DbdzLD3gn9n6R3OkrQyx7JvUBZmj6uk6HcXwKz
         ZhgudlPHB+GvA1rfXY/ep4n64bYKUjfnnSecytg1XAdcsBdd3d7Kg2PF/GXLeJoWs4cC
         w/E1XQjDvrhmfF6pbs7iIxo9lK5+a5zaK4UjEj9ZvTIohpM7SZlRoHCifwVTuklVMDZ3
         6Vew==
X-Gm-Message-State: AOJu0YxOPOZs89TUID/vnhZmrqcj5Ni5OqNzv2dv7f0ODhlt2ooqwbn+
	w4WM7t0ODenBqWTQqCSbz+j04t8//Sa48H7Owu0QD5zGYiLNhJnkyLQ6hQ5NFCWkwAkCjSG9LS4
	4w68hy2jEhd14bcw97RWKc6P5Ak6PRSMEaChQY4QYDVCGpkBGGAjAAA+WXK3bdK2WjMtmdDgD4k
	3kgmd27BBASUOadfy+4zDqfVAp2A5ffY+1iy7KdBfpZRVDTPwvC0dzRMpQEhMD6QA=
X-Google-Smtp-Source: AGHT+IGdAVb11hevfXclChQEtCUtIDcLel0+esqPqUojNt899+GV78+G2AgxOj7MIf4OWrM+5N7MZSNtAetIGbCT4g==
X-Received: from pfbjo8.prod.google.com ([2002:a05:6a00:9088:b0:748:fb38:1909])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1aca:b0:736:ff65:3fcc with SMTP id d2e1a72fcca58-7489d03355dmr28313713b3a.16.1750280177074;
 Wed, 18 Jun 2025 13:56:17 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:56:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250618205613.1432007-1-hramamurthy@google.com>
Subject: [PATCH net-next 0/3] gve: XDP TX and redirect support for DQ RDA
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	ziweixiao@google.com, pkaligineedi@google.com, joshwash@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

A previous patch series[1] introduced the ability to process XDP buffers
to the DQ RDA queue format. This is a follow-up patch series to
introduce XDP_TX and XDP_REDIRECT support and expose XDP support to the
kernel.

Link: https://git.kernel.org/netdev/net-next/c/e2ac75a8a967 [1]

Joshua Washington (3):
  gve: rename gve_xdp_xmit to gve_xdp_xmit_gqi
  gve: refactor DQO TX methods to be more generic for XDP
  gve: add XDP_TX and XDP_REDIRECT support for DQ RDA

 drivers/net/ethernet/google/gve/gve.h        |  27 ++-
 drivers/net/ethernet/google/gve/gve_dqo.h    |   2 +
 drivers/net/ethernet/google/gve/gve_main.c   |  42 +++-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  77 +++++-
 drivers/net/ethernet/google/gve/gve_tx.c     |   4 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 236 +++++++++++++++----
 6 files changed, 314 insertions(+), 74 deletions(-)

-- 
2.49.0.1101.gccaa498523-goog


