Return-Path: <netdev+bounces-223199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96921B58429
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0041AA717E
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF4222D4C8;
	Mon, 15 Sep 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/ocnuNA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9927442
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959086; cv=none; b=dBgvyoAM/nfTD2CmPxukhlLSkC05GDvJCVz9CirNJpZ4bSDFeAclE9eIgckGA/i/Ei+zK9jBwJmq8qE9sgAdmd1qkt6csvFkhD1s9RrKS9O8uppYr3NaLcOnyetAOWwUebe0QaONXE7vFpNlbL1iDA9TBSLF9hFDdxjbJl+3Z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959086; c=relaxed/simple;
	bh=S6AYIUqZuj+29Za+Z5p9GYQaH/iOstnmtVFh41Bl4eQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y1jxYUejAuX2nCZ/frSlYdhKb2N2tNIzqsauFPXbY/3eQ9VXKnVizyhDwTQFE9WhnrIZr2vqqncKUVROeMOR+cvXOu0/xQLXYS3bxKsdxU8leC0xioap6/aL17qUXTkmkZsSbLQG5oPIepUpF1m6IqX4aI9x2TXA1xPXmz7iOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/ocnuNA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b522c35db5fso2976598a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757959084; x=1758563884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f5E6fcbXSjyuILVnYyyYIio1vYZ0+VSuZo/De2Xr4gI=;
        b=x/ocnuNAGt1A+xITEgxvycWtkH9BG8fHf++HXOJT1+EbXqIwaN8kWu/2CyIRG0LIoK
         ioWOuVy7cU8+SjmpOGRSw67AqNi7r28QwBjB/jS+ULDB75+rw4CaBUp1un+8/wgZGpG5
         VoNUNhMugMfNGjcuXi3C2ATbp7yW5grWvobxumM/uXtK2V5HFe7KGYwz8B5x9YUUVUvV
         5UqN9wUQuRHYr9zO+7/1MrfGOFhyq4fVf1KpMeOKGV2da2P4fYgbGCJxTMM7IuQxSv4i
         /ApMGDKMdiSWw8PHerTj/Wuv45cSxku5aZRY2r9dKr2hyhVxQLMBq2DqMxbJGfR0UT/t
         B1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757959084; x=1758563884;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5E6fcbXSjyuILVnYyyYIio1vYZ0+VSuZo/De2Xr4gI=;
        b=hmLXnc/6PJ+1J5EpT8GbLORA+TQLbSPQu2qBmN9nX7dzYvt9EekpHYQD0bd/pdTBV/
         a4Ga61ARUeqwj7Xau85P0UAZbv+33rHnesYZkInAh+l6O2jDFRUOXe/XtC7ULGADaKub
         ADWJBwXfNHd6ITvkkU2W1W1eR9lkxIJUewID2Grs3U5P2Nd8GIIo0ih5kEKkq16K6dDX
         lHoXpcSJd9PNgthxKCD2Ooga7OlCZv2gQRcvC58THqO/LFP07viOKd/N93BfSWsdVUxW
         uc9Q99cCyGbVJieTVonEb7S0o+NpVSnszH/S2a4hKOwYg20uT05ruKZ0Rb/wzEyzJbFr
         qfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7qeZ1gDeqWsZlWvUqza7d9ZnP4OxRGQocRR5TYb8JCjP2OGsXCn2EU75sFoPBC/fxWXX6kNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2VAgMcM6CT2v/coR4vin+De6r4LOICd+RWy9Hfie4d5aaIKA
	lFjLHMKp260QVR1KExHEEHLVSqXNbn5Nca8/4SS7ZgbcmDGv7+HUMOdjdc0uUDwg/lrd9MwDW5b
	ZezohjQ==
X-Google-Smtp-Source: AGHT+IFD4HQElR0ew6DKw9Oenavico71i8TnPPOHfW8i/fGGDtO3jsdkcZu7IBxTsotT02PF6tOLKodsuII=
X-Received: from pjd16.prod.google.com ([2002:a17:90b:54d0:b0:323:25d2:22db])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f90:b0:24e:95c2:9081
 with SMTP id adf61e73a8af0-2602a59389dmr15715289637.3.1757959084023; Mon, 15
 Sep 2025 10:58:04 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:56:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915175800.118793-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported a warning in tcp_retransmit_timer() for TCP Fast
Open socket.

Patch 1 fixes the issue and Patch 2 adds a test for the scenario.


Kuniyuki Iwashima (2):
  tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().
  selftest: packetdrill: Add
    tcp_fastopen_server_reset-after-disconnect.pkt.

 net/ipv4/tcp.c                                |  5 ++++
 ...fastopen_server_reset-after-disconnect.pkt | 26 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-disconnect.pkt

-- 
2.51.0.384.g4c02a37b29-goog


