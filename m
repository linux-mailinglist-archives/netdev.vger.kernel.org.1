Return-Path: <netdev+bounces-137254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172449A52E6
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 08:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9BE28272C
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 06:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E3FC12;
	Sun, 20 Oct 2024 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="J0MbgVZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAA79D2
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729406333; cv=none; b=JFA/+cGjZl8hYdHIp+r1169WnJxNqsSdVHt0NWi16SaZD1nOqvlFS8rk4Tb4OckE7yNBTcO6FDvMswpbQTYhOK0NQnVzxjnDN9Qvg3qCRd/6OyycNrDSRWUXK0UULqq90fZzskveyvuJ98HTE7G5XxM6LAZl8VNho6DgXnc4DY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729406333; c=relaxed/simple;
	bh=z1NWtZoqk+cAT6rHeYSYSkrsw1S2GOFf39qVMH0yqDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7lBpyEmM8NzoLMt90wslZSybdwXmHEGuO+Lxh5ifWmdnsGnh6bGGB2FdwTkTiBDZB4WLUGTFTXGcTft+f+bp/AKs6QxCNi3tcGGwXi+fap98sGtOJSx94nU41UPTke/2ZKpXlCL5M/Cx+7TzXSowa7TYQmxlUI4Bi16WsM3R6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=J0MbgVZ+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso678258a91.1
        for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1729406330; x=1730011130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i503jibShokyzKgJRjluslQgf/GXzJZnNEpbSYQCOuk=;
        b=J0MbgVZ+X4ANUTBLEy+Qw8V5i498Q3cOZ4sY5hIgYasSuPj2tqlgkV14RxKJQgHG+Z
         65pTPidoSmSI8tXSWC9eynm24awgeBuulk73Tv7p3uyk3tIbET9NjQCIYaF9HBruPPpq
         CRzvVBK2k39Bk08wAFOUqkyrvMCauqXE8R9nqJ8FN/sRA+0byubzv4aHZ43UvBj4lOBc
         BTv6xKumSYsZA1TYovj3r7g3paCvlBaeETT+eams+hFnq0lan3a1Cs0syDtxwPRgCkIf
         S7fbVB10rl8miiMfCPCBWcOjTJscWyffW4eP8B/DhQb4Wcahc/TKQ1r8HClIPC4LvOf4
         SBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729406330; x=1730011130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i503jibShokyzKgJRjluslQgf/GXzJZnNEpbSYQCOuk=;
        b=Ai19rItJEHQyqsBnW5Ej+bUt6qWpGW0+Pj3yABmaNTGDHjJDj4GwaD+2WL4z6yy6mU
         jU4z0weQRD0cjytwGLBgy2TqrNfV1jQ6LhjoKEt0vNnjzjFiQfoTpQjTwYFrLT/kpt1S
         WrqTNR9oh1Yqv/FMuL0zXuL27Y90y1mPs8uC8I0IbbNFnbWVRyEBmftvYWkgMvCqsuZj
         HzymqGKims0YnD1zblPqml4DBNGwp7EbIIt6xuWho1TtNQITddekX+a9X7P4fWIVnDhV
         Z7tvYWf82LNX6MCDKthOZFO2TdHwSgaexCMHt/cvAlrcwtrSSBpDjEk033MaSe1Cb6GV
         qUTw==
X-Gm-Message-State: AOJu0YzcbAA22W2heM5breCv/9rd3p5hzOnPrPojQE4IXU77eje2uS2y
	2hhrZJTo5+1YUfcR+rnbC0lP2f+upL1PSDK5xP2Xiver9MxwWLyhF+l2M9Acgwqmy8Om3zZVAJC
	W0wM=
X-Google-Smtp-Source: AGHT+IHFX+rspk0TJCyu2wNA7g544rqoY1uyUeTZ0L8BKsldY5n6Fs8I+LybZm5ovO9CZoGnUqkHwA==
X-Received: by 2002:a05:6a20:6a10:b0:1cf:35db:2c3c with SMTP id adf61e73a8af0-1d92c4bac8emr4867191637.3.1729406329929;
        Sat, 19 Oct 2024 23:38:49 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71ec1312dffsm691987b3a.15.2024.10.19.23.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 23:38:49 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	kuba@kernel.org
Subject: [PATCH net v3 0/3] net: dsa: mv88e6xxx: fix MV88E6393X PHC frequency on internal clock
Date: Sun, 20 Oct 2024 14:38:27 +0800
Message-ID: <20241020063833.5425-1-me@shenghaoyang.info>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MV88E6393X family of switches can additionally run their cycle
counters using a 250MHz internal clock instead of the usual 125MHz
external clock [1].

The driver currently assumes all designs utilize that external clock,
but MikroTik's RB5009 uses the internal source - causing the PHC to be
seen running at 2x real time in userspace, making synchronization
with ptp4l impossible.

This series adds support for reading off the cycle counter frequency
known to the hardware in the TAI_CLOCK_PERIOD register and picking an
appropriate set of scaling coefficients instead of using a fixed set
for each switch family.

Patch 1 groups those cycle counter coefficients into a new structure to
make it easier to pass them around.

Patch 2 modifies PTP initialization to probe TAI_CLOCK_PERIOD and
use an appropriate set of coefficients.

Patch 3 adds support for 4000ps cycle counter periods.

Changes since v2 [2]:

- Patch 1: "net: dsa: mv88e6xxx: group cycle counter coefficients"
  - Moved declaration of mv88e6xxx_cc_coeffs to avoid moving that in
    Patch 2.

- Patch 2: "net: dsa: mv88e6xxx: read cycle counter period from hardware"
  - Removed move of mv88e6xxx_cc_coeffs declaration.

- Patch 3: "net: dsa: mv88e6xxx: support 4000ps cycle counter periods"
  - No change.

Thanks,

Shenghao

[1] https://lore.kernel.org/netdev/d6622575-bf1b-445a-b08f-2739e3642aae@lunn.ch/
[2] https://lore.kernel.org/netdev/20241006145951.719162-1-me@shenghaoyang.info/

Shenghao Yang (3):
  net: dsa: mv88e6xxx: group cycle counter coefficients
  net: dsa: mv88e6xxx: read cycle counter period from hardware
  net: dsa: mv88e6xxx: support 4000ps cycle counter period

 drivers/net/dsa/mv88e6xxx/chip.h |   6 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 108 +++++++++++++++++++++----------
 2 files changed, 77 insertions(+), 37 deletions(-)

-- 
2.47.0


