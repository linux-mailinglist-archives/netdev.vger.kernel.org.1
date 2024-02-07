Return-Path: <netdev+bounces-69833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0525584CC9E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3817F1C2653B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58A77CF34;
	Wed,  7 Feb 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcQRwVIi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E77CF00
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315922; cv=none; b=QjRyIRLvTk++E2GxlYf/fxNxy52D+nHNWaetNCVTbHaNuqqicS1GspotPGMNJHOhyAdco+2BpBbJWWtHik+L384sFfxwLs7c9XxiIn7UJs6GFKN8HJDovQYUrGEFt9mbmKGhWYnttV4q2rRPagqtQYdr2tr16TpaKM8t/fBrjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315922; c=relaxed/simple;
	bh=FWXcLug3X6Apwrnxl1zWel+QZGkrU2J/BwiEYRMIrvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceg6D7Q7FeKGRIXQFbS916Y42EcJwAob862eomoik9YdUAoridFGm1N4bR/4ZBYCa81Qw3o/OLIib4p55C9Kgxic5kA6Srb6I+qREck1lv1dwtG+SeZt7gjA1nR9F+4GoI+Wh2ktgqa4AUiFwsUsybxus+I3GOAQz05UTt4Goys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcQRwVIi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a38291dbe65so77373366b.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707315919; x=1707920719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oeSPDdj8dJDa1rFnwzIsL7GG42CNJI37P9BZ+cYMswI=;
        b=bcQRwVIi6PAiAIC8E56tNJ6Nd25zep97sm73DKoeRkqmNIONUxhAXxc+kGyMmsdMix
         mWt7w8ra3thwFCu5RGj01qz0k73dy6BSIn8ucQSPKVDUoOPqKFPf/4zalzjj2+7CAq1A
         UlhD3wSgcWqVaVv+OhivF/LsBK9w8TThCRoZ4HQCc/3sxYkXEzX6uuFoB9S5rsvGVbpq
         zGB5zUua5GpAXxjk4jJGDELR2LiqqMxHUomCTnnFvDelg5Vk17bGC4iArYFeitg2ZDOg
         w7svZKe2x73fZVZCTIdK4ZAHAB0qaWYPBDDl9oo6VWH9sxvf4N6zbxjd4pyV4KUkHAqH
         0wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315919; x=1707920719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeSPDdj8dJDa1rFnwzIsL7GG42CNJI37P9BZ+cYMswI=;
        b=s1zI5/rSUc2LcPUnZG87lZcgp4FLz1kOngd7NpPQGf0YSGlKZvGLeSR0mPUiUIPPP0
         V2HeHkHrf42gsIPYs6w6RHQVV1CpzskbKnl23kNDCYjIg1Dbgmos/trCPw2L+0d9Y3T5
         pNjWHW1dJFVYcOcpi6mXdnD7neTN7F/YcjUAy1hIs5G+lb9PGPduETvYHo7hXjEAX04Z
         pqcL1Hf/4h2tiMxuTAxpW+9mjPgNCGeska7SzGlVedsEogLv2PaD26b5Ad54t2NvmAbw
         Ej06drfKgCu0tYr+5DA1jAJsPmvO+lttvOLAjLzqJUF9mV07cB5zKrWlEX2ydtBZUfNJ
         Agbg==
X-Gm-Message-State: AOJu0YyOegIg/Q7tdET50YdDgSvELzKaZpbLaitmt8rb3uv7UtuzQs5x
	jKFCjczm3QYWxUR0iWjLoX2iVHfTIxZv9s9Aa/hFdHavJLqIyitZOd2HekWI
X-Google-Smtp-Source: AGHT+IGfRTwg/6DY7ELd7oPAhZNiR0Qza4YDAE1ea2efPKCfPle0Aft8GUKAziIBawNqK9hfyIJmKA==
X-Received: by 2002:a17:906:1747:b0:a37:ea:ac15 with SMTP id d7-20020a170906174700b00a3700eaac15mr4107720eje.35.1707315919031;
        Wed, 07 Feb 2024 06:25:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGWYg5LNDYfl1WKjKxnQ9HrTNuunYaQ1575/YNt6FKBIZWCJanj2EFFh0MpljjiOYh7tq8TBe3LQ50Uyr+9TgvfqJpcdw3Tp99oPwP3mF0Xx3qSxY49n0HLZX6Utz7uT73zWbR6VXghC2BdqNnc564Lj+q32YxkOzeUr+um5QZo2uq+KPNdXIm4mVsifLt410=
Received: from 127.com ([2620:10d:c092:600::1:283])
        by smtp.gmail.com with ESMTPSA id vg8-20020a170907d30800b00a3807aa93e1sm808913ejc.222.2024.02.07.06.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:25:18 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC 0/2] optimise UDP skb completion wakeups
Date: Wed,  7 Feb 2024 14:23:40 +0000
Message-ID: <cover.1707138546.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sock_wfree() tries to wake even when there are only read waiters and no
write waiters, which is the common scenario for io_uring. It'd also
attempt to wake if the write queue is far from being full. To avoid most
of this overhead add SOCK_NOSPACE support for UDP.

It brings +5% to UDP throughput with a CPU bound benchmark, and I observed
it taking 0.5-2% according to profiles in more realistic workloads.

Patch 1 introduces a new destructor udp_wfree(). The optimisation can be
implemented in sock_wfree() but that would either require patching up all
poll callbacks across the tree that are used in couple with sock_wfree(),
or limiting it to UDP with a flag.

Another option considered was to split out a write waitqueue, perhaps
conditionally, but it's bulkier, and the current version should also
benefit epoll workloads.

Pavel Begunkov (2):
  udp: introduce udp specific skb destructor
  udp: optimise write wakeups with SOCK_NOSPACE

 drivers/net/veth.c | 10 +++++---
 include/net/sock.h |  1 +
 include/net/udp.h  |  1 +
 net/core/sock.c    | 10 +++++---
 net/ipv4/udp.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++--
 net/ipv6/udp.c     |  5 +++-
 6 files changed, 76 insertions(+), 9 deletions(-)

-- 
2.43.0


