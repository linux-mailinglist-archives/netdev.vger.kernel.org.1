Return-Path: <netdev+bounces-184240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3AFA93FB9
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44D5464167
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900C23E329;
	Fri, 18 Apr 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0C8iYHND"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CA2AD0C
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014380; cv=none; b=OqrJ8Cg0Vdqlf4znPHDbSgR8TRCSkqR8Th7CoBHEMnTgWZ+Ec+I71g+zpKV9qG9GYKS4RMCZIFo0gJjOPcITzUo2iS9b0lnIl20Jc/OTM78VcK75//G5JxLGeExR8nnIoWbFPTx10Z6rg5vqqQgQAjpsoKyBqo7N09J6E1X3i/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014380; c=relaxed/simple;
	bh=OaB5clm2Fd55nvf9AoEoWbOeuMTD+ebuClMlN2bpD/4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KL7Gm/QPyV+ft5J4RsYwLf8IOEmFMSYvswngdRK2Pc/jl/G6t8EHb2A1l+VymB8kCRWvndjLs03F7wJRCS6Ui0C8xxE9X1QxKFoXG+mNAEEpq7IovnI9c/Zip2mW0igAvLY5APdp/D++YhV+gaJqo2XN51RsWpHzSHy5VYmdE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0C8iYHND; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739515de999so1925113b3a.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745014378; x=1745619178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tzhfGtY+evoE9VxfviqLe5VC5CnC4BKePYDzdj0PjBk=;
        b=0C8iYHND4avrxkgCWpcGohmatfBYtjYOmfXZDiD/zr2Jktum0FcIpVeV1qBP/Byg1h
         7XYhH8RvPKnxiqwF088rxwoBxPoH3bpiG6Jk9gPHODkp/+9+lwzBWfFd5rx2YO1vUqQS
         D00Owftx4oS1duH3cKEpDSxY6pCnOJxlH9vNNVqA7VM90NcPILS6zAqR4fkhFdGcezs4
         sB/cDu9/XDyxivGAQjWxiG/uU8p+HOT44UiOTw18TRiOuwHSgMamgocxmRqrhaOl+t8B
         HEU12zh5WJVntpQgbs3dVUwOeVxoOQBa2ROAieT3NiGrY07mHcvuzXpU1AhhHIIxhV9v
         G+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745014378; x=1745619178;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzhfGtY+evoE9VxfviqLe5VC5CnC4BKePYDzdj0PjBk=;
        b=qh44GPORd4xe6tBOPSzOBuMwgqyi/1ukEOUkQhB6hKitQ+EvmBcbTc591FkXpqnVwK
         lvKxkbq58R+qIrkm2UFXpIbdM0eLracyVut2J0E9twR4SrzQeeO2Mu/jRZa2MRuBDGKj
         Bt+/ZidC0lgNUKUyRKYBPcJaotFCR34qMBJDLY819Z2WlGWpG34zLaTGQlmxjZAT/DWj
         3ChrVSlXz8kjH9yC1pttnXVK1qXT9jFqJNNreAuRqa/dvJu73tB/Vu4xDSqFblRkle3d
         /XXsGvGjGXkSV+c8wEeL6UFergc8gGZnh4H+0igQTQkC+3Cxqbqn6+pa6FIpuUeLNWFg
         UpNg==
X-Gm-Message-State: AOJu0Yy5NpRBI0TJWbZTOFBA9eofln9MEbQwnGP8eUuzLVSQZ82gcU5D
	faPla0KykuVfzejET9cEw6M2VJ1Fmyt/OzHurZ8PiSkWNwAlp1eGgcvre8gwoX9ldRN3+rTWe3k
	jeT02wD0iSl0J/04DH+Fj0+nzZ6tRssACpPlap6F4k3pzrsUVqa2WOK5WD8Zxw/rTVb0LJ5wO9h
	pkEvQFjKB2GU5FX3HMxvEXnr1h3fBOG8k1nzMrLILdvvzhmWPH3XrXUuzp+tc=
X-Google-Smtp-Source: AGHT+IFCgH6BBYC32pNbnQJa/WcTnXHZ2uCUfF0PiDlUPN0capH4EV5S2WQAQipAxHlB+1TR325seKlefI81vFED5Q==
X-Received: from pfbcw17.prod.google.com ([2002:a05:6a00:4511:b0:732:20df:303c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:e8f:b0:736:6ac4:d1ff with SMTP id d2e1a72fcca58-73dc14573f4mr6212653b3a.3.1745014377884;
 Fri, 18 Apr 2025 15:12:57 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:12:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418221254.112433-1-hramamurthy@google.com>
Subject: [PATCH net-next 0/6] gve: Add Rx HW timestamping support
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

This patch series add the support of Rx HW timestamping, which sends
adminq commands periodically to the device for clock synchronization with
the nic.

John Fraker (5):
  gve: Add device option for nic clock synchronization
  gve: Add adminq command to report nic timestamp.
  gve: Add rx hardware timestamp expansion
  gve: Add support for SIOC[GS]HWTSTAMP IOCTLs
  gve: Advertise support for rx hardware timestamping

Kevin Yang (1):
  gve: Add initial gve_clock

 drivers/net/ethernet/google/gve/Makefile      |   2 +-
 drivers/net/ethernet/google/gve/gve.h         |  14 +++
 drivers/net/ethernet/google/gve/gve_adminq.c  |  51 ++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  26 +++++
 drivers/net/ethernet/google/gve/gve_clock.c   | 103 ++++++++++++++++++
 .../net/ethernet/google/gve/gve_desc_dqo.h    |   3 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  23 +++-
 drivers/net/ethernet/google/gve/gve_main.c    |  47 ++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  26 +++++
 9 files changed, 290 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_clock.c

-- 
2.49.0.805.g082f7c87e0-goog


