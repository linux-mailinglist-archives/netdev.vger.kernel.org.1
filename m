Return-Path: <netdev+bounces-199824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B8AE1F87
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7461715E4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D12D29CF;
	Fri, 20 Jun 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2DZ94K2b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3E28CF41
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434953; cv=none; b=souy8NPFsi+Xwe2of2Sy9U2YoVSQ13hCHq+emnm2HWBNmJaBpMNBavrDEY950q1OMrToVvJMUwIjUeXQ483sneI1n0OaiLNLM29yGdmgWaJfkcHt7DbFfKVNUe7LUKUMJ1zB5OZQYF+9mleq3RCzCD5muXg4yZDik33cSHdZbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434953; c=relaxed/simple;
	bh=qKoNp2CvpZ/6Wod67tIjgSuau7j9cjXTQzpTBvdtRBw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bTTNs3C+mPKqV8bmsqQPLxnh8fBT/aJv8jr3dZ88zsiz8O+UYDFzI9g+qULFhImYKHzPJ/KP85GB1rVmsrZX1vF/3EigssEFH/BqRjfNXp/OCmrEaMpe23uOoCCGI1k5f32I2YF18BceZIpynfGbYKHjOczsMOfTKhJg69zrH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2DZ94K2b; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a461632999so33173321cf.1
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434951; x=1751039751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A3DHwD9UsFR3/XWD/0wybIaZl4MROknASS96LPD6bUY=;
        b=2DZ94K2bjjR16VuWQH7IlKhAMs0zDiWcRSfilMoVvsJCJyVSSprMOx4vJmVcxBDek0
         BLV1U+HWEucYmI65Aa5DpiewpgmvZ+evV62GsWtSB3wOnVkj4oMlISU9danSnnREIkhF
         +DPD9HwpScZJwr696BIF71+GY5mGqYkMmOJOFdrFJjdUGja2l00BEhXNbs9BqamzWKbM
         MROrqYCUYnMdKKyF5J8zXHEsAffTNXuwRzIkR3WC2KOX5PWnTO2AXt3G/fKHG05+2sE2
         eCUcLvR24Q0ahcBVGUCiVk7piaF0O6+4H59Qy8WNdrrnHJPq90DJYOFTVJn328N5spEW
         AFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434951; x=1751039751;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3DHwD9UsFR3/XWD/0wybIaZl4MROknASS96LPD6bUY=;
        b=mvuwp2ZHXum56WidtYXvLzTKVHr9A4zpyZTVAn0FtqltTxc91Nd+0m63rcODSJx3oj
         VsUJqJPXLvjMZcVJBqBVklE3G84lNkdZOnFSeTmcYQFcQWQqlF62z4joaev5BPzmUtrn
         zoMzcjLuiBbFEhCgC4DKn2vv5czK0ZTpRJlmVVXxhyeh4W/FwRwOp9ZhN2u3jnma+Tav
         zN1s3JgvG0BUJvPxnSMORQjnMLI2W5/E49Kd7B3IcQZNwh+ycDr4mhQgtARWK5agaUAU
         JUMIiyaGIopL5P3R5ilOxKPlRIlTDicCDWJxKDuYhVarUaR7bg0334sh9p1bYuIOxntP
         I1uw==
X-Forwarded-Encrypted: i=1; AJvYcCX0CbXKVay+mXrOezTeqXWHddtku5fm7gTJs1ff7oHINlZmMw8ucHn8e04xhk54YXYFLZcySCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSsQUUp8k/oJBAjJTrGHT5xWZ5SOOQljNjSglU9do3w+ggrG9
	yMbZMPVTrLIr4vj5mi29E8YHW9KBCR0BIk9LDxi6r1TaWz+lYVTSPSvAtFuAcwPDEWEMh0z4gS/
	QGDSMKmLGunXh4g==
X-Google-Smtp-Source: AGHT+IG88NmhivlnDRRlDapaaHs9DlE2ch/aSj0KX9kBAsf4BTXuv2L+1o7SCpK3O8gUZlZ1ibkkXueCraRfxA==
X-Received: from qtbfd5.prod.google.com ([2002:a05:622a:4d05:b0:4a4:328c:ff59])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4f0f:b0:4a7:7f3b:d922 with SMTP id d75a77b69052e-4a77f3be1e5mr20314091cf.45.1750434950900;
 Fri, 20 Jun 2025 08:55:50 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:55:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620155536.335520-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: lockless sk_sndtimeo and sk_rcvtimeo
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series completes the task of making sk->sk_sndtimeo and
sk->sk_rcvtimeo lockless.

Eric Dumazet (2):
  net: make sk->sk_sndtimeo lockless
  net: make sk->sk_rcvtimeo lockless

 fs/smb/server/transport_tcp.c |  6 ++----
 include/net/sock.h            |  4 ++--
 net/bluetooth/iso.c           |  4 ++--
 net/bluetooth/l2cap_sock.c    |  4 ++--
 net/bluetooth/sco.c           |  4 ++--
 net/core/sock.c               | 22 ++++++++--------------
 net/llc/af_llc.c              |  6 +++---
 net/sctp/socket.c             |  4 ++--
 net/smc/af_smc.c              |  6 +++---
 net/smc/smc_clc.c             |  6 +++---
 net/strparser/strparser.c     |  2 +-
 net/x25/af_x25.c              |  2 +-
 12 files changed, 31 insertions(+), 39 deletions(-)

-- 
2.50.0.rc2.701.gf1e915cc24-goog


