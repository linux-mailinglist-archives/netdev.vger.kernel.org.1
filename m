Return-Path: <netdev+bounces-119425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9435A9558F9
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C066728256A
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF90145B01;
	Sat, 17 Aug 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWch3KFx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5B1E511
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912522; cv=none; b=oR9iK6fJPnlieMpkO0o6rhCEMGPI6u9ighL5vg0fLU4+CLYgqt5d3sQ4Q292algg95J4RPuELahh2pOp5ZMMch9r5/8we6+cMzNUY/0IUFwsFhkmJUTUyMUE3JZQJ2DhUGvhCSQEljtjbw8LyuhDa5DbTG6sKtm6/q1iGqYKmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912522; c=relaxed/simple;
	bh=rMFvv6vHX8svCi7LbYgX4+r9nX4Q/YGbR4El1itBHvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nXKrEdkmnoPP0HSKJ8Bxq7EiaIsOfZ/XvJFH3HDkEdQm+3zRQVzIakzlocUq2/Sphn8/si63xXvusoBxqMPXFPdhdTTECOeP9TN19ISW0LsWoWTjJKPdKKGDEPeeCb9J+DSvxxr7r0xEFuvHcnH2HJ7mvsfNqZz4ryVLGUJ/swk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWch3KFx; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf790944f1so13084046d6.2
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723912519; x=1724517319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOFGqk5RmG2+a/AzWrsEKC/gZcw+dg1iCUahbGHqR+Y=;
        b=BWch3KFxDbI5ti3HTl4MRu9j9e6MenZW5Th7s8e/+acc9b7fS+bEpfstpEpjYwTS5b
         K/Ys/0+imGe4py26mImQBZNlmmvYSG6GkBHu17ku+YoAEPUccLay+SlTgSvGIMN/E8rO
         twKk8WcNrtEwhePHAT+Eg8U7ddNDcww0I0o4W/18kdiMPk/BbrEfwhiap3XswXZJiCev
         wMJNuO/yposG7IL8cYYidGnD8Q3eDtkGpPXHNRKL9B/yENLT+AlHulFGMAxcuac80W3K
         Nx8G5oB9vQl7iUQlc+JqNh7p4A50r6Ar5iZnoiWwx3scUxYdkacLM9fSZQUZnIsHepy1
         4o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912519; x=1724517319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOFGqk5RmG2+a/AzWrsEKC/gZcw+dg1iCUahbGHqR+Y=;
        b=jbC3DYe/QM0K9FEjrem6Znf0kE3MAKBK41EkfZg+jzzYWxznQ8XZZgsMo/m2i707cV
         cxlSjHWciRDOrryxsPDtSCHPLTR1wD+nMjUci2lWBWEJ50FoyRcwnpSOHVAdi5ZIhu0f
         ZzSeUg79+SS0UXRadn1N+EM5869vskxAbQKGv3/anCBbgwlFLB6u+skTuonXskFE3rhT
         VmsHr1pxElbTj2c/jv2R8iHZYnZZSDMiDmFK1d/xn0WQPz32OMF9xfI7KYZXAVPI21+P
         DV8TWv5niyb9CyRVtHqLK+v7UyeVGuke3mOI6rmxx1VeSQt0gBKILEJg0Xn46ZPTZNfU
         oYLg==
X-Forwarded-Encrypted: i=1; AJvYcCVeuyzV2L1L3ITMJypLSJGRkRS6oMThtEh10v8Sv4phoGLTkFtR3w4HHFSxfqgc5tnSdGeLcvwq+9lbZSDyjKtbrVklSGI3
X-Gm-Message-State: AOJu0Yx6mzlwuj+SzVF1JL8SpWdad7cySItLAc0gLVaFTNqZXT6txQzO
	nlnDEZkU0sHNwl4EO4aWs+pdAw+n6tBp468EPhK4URenLxSKT9ki
X-Google-Smtp-Source: AGHT+IGLF2FkIas7pZQAmbeWcQT/c1ELu3Bl28uydnL9btUMJaajUl1/eUPnIz2WsEAd3dr0SFHcPQ==
X-Received: by 2002:a05:6214:4885:b0:6b5:e403:4418 with SMTP id 6a1803df08f44-6bf7cd8b492mr74257866d6.10.1723912519196;
        Sat, 17 Aug 2024 09:35:19 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef242esm28319406d6.118.2024.08.17.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 09:35:18 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v4 0/3] tcp_cubic: fix to achieve at least the same throughput as Reno
Date: Sat, 17 Aug 2024 11:33:57 -0500
Message-Id: <20240817163400.2616134-1-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series patches fixes some CUBIC bugs so that "CUBIC achieves at least
the same throughput as Reno in small-BDP networks"
[RFC 9438: https://www.rfc-editor.org/rfc/rfc9438.html]

It consists of three bug fixes, all changing function bictcp_update()
of tcp_cubic.c, which controls how fast CUBIC increases its
congestion window size snd_cwnd.

(1) tcp_cubic: fix to run bictcp_update() at least once per RTT
(2) tcp_cubic: fix to match Reno additive increment
(3) tcp_cubic: fix to use emulated Reno cwnd one RTT in the future

Experiments:

Below are Mininet experiments to demonstrate the performance difference
between the original CUBIC and patched CUBIC.

Network: link capacity = 100Mbps, RTT = 4ms

TCP flows: one RENO and one CUBIC. initial cwnd = 10 packets.
The first data packet of each flow is lost

snd_cwnd of RENO and original CUBIC flows
https://github.com/zmrui/tcp_cubic_fix/blob/main/renocubic_fixb0.jpg

snd_cwnd of RENO and patched CUBIC (with bug fixes 1, 2, and 3) flows.
https://github.com/zmrui/tcp_cubic_fix/blob/main/renocubic_fixb1b2b3.jpg

The result of patched CUBIC with different combinations of
bug fixes 1, 2, and 3 can be found at the following link,
where you can also find more experiment results.

https://github.com/zmrui/tcp_cubic_fix

Thanks
Mingrui, and Lisong

Changes:
  v3->v4:
    replace min() with min_t()
    separate declarations and code of tcp_cwnd_next_rtt
    https://lore.kernel.org/netdev/20240815214035.1145228-1-mrzhang97@gmail.com/
  v2->v3: 
    Correct the "Fixes:" footer content
    https://lore.kernel.org/netdev/20240815001718.2845791-1-mrzhang97@gmail.com/
  v1->v2: 
    Separate patches
    Add new cwnd_prior field to hold cwnd before a loss event
    https://lore.kernel.org/netdev/20240810223130.379146-1-mrzhang97@gmail.com/


Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>

Mingrui Zhang (3):
  tcp_cubic: fix to run bictcp_update() at least once per RTT
  tcp_cubic: fix to match Reno additive increment
  tcp_cubic: fix to use emulated Reno cwnd one RTT in the future

 net/ipv4/tcp_cubic.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.34.1


