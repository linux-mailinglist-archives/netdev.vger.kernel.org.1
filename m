Return-Path: <netdev+bounces-176627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4284A6B238
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 01:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2413B46816A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AF2A1D7;
	Fri, 21 Mar 2025 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgdvrwBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B6B5684
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516960; cv=none; b=OECWplnn2MJ0xPPw3VTmVaT1d971jB4bDqBtZJNDLmeppgRjCcBO8BHb5jsh9J6P+q8skcVZ4TyU06fZWnLVKWEM9ve+E25Dz5QPOss3k4N1RbaX7M77corqyk/xM5HEY3qEdovA3kPoB03YZ9wTor2TEfnrENJipSR6RfGNvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516960; c=relaxed/simple;
	bh=8MVYxagd5dG7kf5hN7h7VzvIdu4/m6DAUtp4/vVYTbk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eKK/ZI10/aTBOVedqeX6/5cwY/G1iwJfgAXMwfwi+t8KlTPJBxXIfbDFmDUEkfDEfgF3kC86qRJuQH3R7CXMCurVLnght5BVHD2o2Bw/zkSC+mDoHVN4dFjLBpCv/4UsfhS1dIpB3IcCuQUuf5XMYZdP3AdNajDat4uLeVx6s94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WgdvrwBu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so2013602a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 17:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742516957; x=1743121757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sqn2OSqZkWea5X1sVmFqhBGOcsyY48b9clHP1PvkAtU=;
        b=WgdvrwBu2V3TB1+B9NDudxaMyrHJxmh/Z3JcsfCqCHdB4kASX+tuh+L6V03Cr/eIi9
         Z3mA5NEHJuB1XYGWzVKWk4fJEeaFGiFQXcI07Y9q1NEvdPK/wFDk4ocnow/32w+jovTf
         7zUYIthM76fmnh2+PBAnij6Low0I6yK4Aw06b6T0LsVTWjsQUzfie5JpoBtUsg9pNELf
         i6lEFlEq/QssBjmfiehk/mUqNRgTzVzJPxQ0Lww17ffSRf3wZDNNXdznnfhcVMdKT1Na
         PJc6zvFtv2NNf3uV+olg8RpdQnpbiKNnZm3OmBzu33Dh3UPY607VhrO+p2jUc4tBEds/
         qA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516957; x=1743121757;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqn2OSqZkWea5X1sVmFqhBGOcsyY48b9clHP1PvkAtU=;
        b=akgOGgL0OTaA0QMt4Pa1nZx2NmIW70ntmkp7rPZxZpojLhd/i7gVEgGl3WTvK5i/Tp
         1yTZNest6GEGHecYDeMy0/vc3nAKeWLUUXFBn5jiIfw47OmhNm7v+3DhJRJslFCBvATU
         SCsuRUL6PL0L9ZzPTJDdml10unZ5xwiihmpc2hi0FGtMzWDPKJF/ggtXTUcxtpm0ZYTG
         JxiS+iuBBeVkN/chBUtziuy5n4LwiSADidYErvoPwXcPX7b6fQQ/s9EQm7gpftFlljmI
         mCyJSo4CRrZI4CkMZ3drvncROOR2ycbcE3nFFTiUV6qEkCzdDijo2Ma8w1HXBk+o/7Ws
         g41A==
X-Gm-Message-State: AOJu0YzEGnshVP/Wz0LbQUy5Qc2WC9PBM/NEcXKExCw5wEJ51nl46iEb
	YT3cer6XGBDdyGjBEI1pKoXTwhebSfrLWRhKhewA5wNdZdkliclgbdu4cNUMLO/OUo2hXY7Xfhr
	XMCLcGOzG24IafDfNhMjiWC25n3HSoCdkdTCPDo6aKdq9rPid5c2BSR5rArEFo4SUFAE9KAVpDR
	u7AO4Il84gGUBc1h3p/GI9DothwuLSUMoxarNwT4orqBtyu8SXzlCAFAL8RdY=
X-Google-Smtp-Source: AGHT+IE7CroiKkICZlfGpgVa7tYfssQoYcG0aQDZsojHVA/nr5/4eL3ObbDEmfpeF6tEEyGeQUYTXMcGex5qUwNJVw==
X-Received: from pjk16.prod.google.com ([2002:a17:90b:5590:b0:2ea:29de:af10])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f86:b0:2fe:e0a9:49d4 with SMTP id 98e67ed59e1d1-3030fe56b0fmr2141537a91.2.1742516957286;
 Thu, 20 Mar 2025 17:29:17 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:29:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321002910.1343422-1-hramamurthy@google.com>
Subject: [PATCH net-next 0/6] Basic XDP Support for DQO RDA Queue Format
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, pkaligineedi@google.com, willemb@google.com, 
	ziweixiao@google.com, joshwash@google.com, horms@kernel.org, 
	shailend@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch series updates the GVE XDP infrastructure and introduces
XDP_PASS and XDP_DROP support for the DQO RDA queue format.

The infrastructure changes of note include an allocation path refactor
for XDP queues, and a unification of RX buffer sizes across queue
formats.

This patch series will be followed by more patch series to introduce
XDP_TX and XDP_REDIRECT support, as well as zero-copy and multi-buffer
support.

Joshua Washington (6):
  gve: remove xdp_xsk_done and xdp_xsk_wakeup statistics
  gve: introduce config-based allocation for XDP
  gve: update GQ RX to use buf_size
  gve: merge packet buffer size fields
  gve: update XDP allocation path support RX buffer posting
  gve: add XDP DROP and PASS support for DQ

 drivers/net/ethernet/google/gve/gve.h         |  72 ++---
 drivers/net/ethernet/google/gve/gve_adminq.c  |   4 +-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |  18 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  30 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 288 ++++--------------
 drivers/net/ethernet/google/gve/gve_rx.c      |  30 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  81 ++++-
 drivers/net/ethernet/google/gve/gve_tx.c      |  41 +--
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  31 +-
 9 files changed, 250 insertions(+), 345 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


