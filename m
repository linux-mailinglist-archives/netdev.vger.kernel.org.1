Return-Path: <netdev+bounces-76060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE92986C2A7
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CAE1F250F3
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F047F6F;
	Thu, 29 Feb 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmcNXPue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5214778B
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192295; cv=none; b=t6GYLiCWgAg7Oj0SqCS76O3cxNpzoIwK7ZGX+ulEY+BOM0ylIME/gYN6yFfAY+pA0tLwNUh58FliUFnEFddKfEETudnBK9b5q7wHz8WOelNq5TCZhyVlRRLFlF0DRfD+y7UXB/pGklCrxDf/TeIYOCef6v1Q1rsMZkWoXNqIhAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192295; c=relaxed/simple;
	bh=tl75N2CGhDjnXTSrTY5rdqeNRq9K7Ks3Y9LMi/AcODI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JjBsWjDEzhvqvao5ZJ65GzIE++q2xkPAU1Xu8XMvIH9d2KXVBu4Cb/BWzXY4pgrfJU2xh3D/M6qxeYTRopiVRYXd8eOPCUyj7vMWjnI/diqWhe1IJalrFqjs43V/SVAWeelFVchhhxjumUQgY+a6JkrKlGiRNJpa6MmMeC0dZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmcNXPue; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so6762671fa.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709192292; x=1709797092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFLx+tSBv6PzGsn8m41UxviEbtjNxE1Scp13oG6JlA4=;
        b=gmcNXPue4zjdTHjdrbwLG8svZ0bVduhJel010B5+w1c97KeG2aFornSZ9jVZDfWreu
         EG5vIrT0Zd/CniF6RpFqQa5AUV5p/gdR2MgoKus84g7ehErrq1GFIOhHb5iy332hDSMu
         b9ykVabywy+KLM2fuln5/8g1D4tLFlK2l1GeixOmOIOU6euNNDco/IUnqItXIb0eszOL
         /fpW+nSznfdMeHrjF2bv3218UoBgBJ8vtLbDBv4V1EZ7na4Q93zSktPS5RLrPoOBxW/5
         PsXOH3KkfppIvxWuEVhmhJsKybYofmkzJ+mw9Lxt29QRZCPhp+LRIMDVZwKkQODEfC+S
         NsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709192292; x=1709797092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFLx+tSBv6PzGsn8m41UxviEbtjNxE1Scp13oG6JlA4=;
        b=oc8qDu3wn6SAiT5oQ8n5Zr5BaYQjLX9gtZ4vUYoBs117xnGpKBB4HPi1FWrBybiwZl
         G2SUJV4fyN9l4vY46mq4sayRVMmot7XOSfMau0ZHjZtE88q7mSkOhgvYr6BzhGxa698h
         Fe/wYEOU0PfBJh4vl4I54WSU61FNw5326VA6COioGXiCmmCu8WPF60+fiHqAnUWSkCFP
         yKM60XIKo0r2YmDEsWa06LdMntZzr68eStnH9D9OcYbbH3q17u+9EkCeTPMD0JnWQs/g
         GwGNnvpHUi/6DEo+4v7Jnv9J8GPZnmjaoPQGDuVUhhlW0iXXwp69ZDiXwfxd1UYJn/mr
         InhA==
X-Gm-Message-State: AOJu0Yy5LPSDA72k7qHBy+72Em6IXnRxEGA/xF1tNI/Rx/Z+L2+wbJ7A
	v34RrD2y3NRAdTZgeRPMKJKbKxg55FQVXH0yQEwqeDV46h99PujqrOVcJtbF
X-Google-Smtp-Source: AGHT+IEPptxZCeqOERkL5AbVgFB/HqN5zvoWubCnDw4+59bV3cpK3vTc2Ss/0Uh2VYBPs10n/5joqw==
X-Received: by 2002:a05:651c:1a21:b0:2d2:c5c3:df9b with SMTP id by33-20020a05651c1a2100b002d2c5c3df9bmr995426ljb.0.1709192291564;
        Wed, 28 Feb 2024 23:38:11 -0800 (PST)
Received: from localhost.localdomain (92-249-182-64.pool.digikabel.hu. [92.249.182.64])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm945017wru.112.2024.02.28.23.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 23:38:10 -0800 (PST)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [PATCH net-next 0/2] Add IP/port information to UDP drop tracepoint
Date: Thu, 29 Feb 2024 08:37:58 +0100
Message-Id: <cover.1709191570.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In our use-case we would like to recover the properties of dropped UDP
packets. Unfortunately the current udp_fail_queue_rcv_skb tracepoint
only exposes the port number of the receiving socket.

This patch-set will add the source/dest ip/port to the tracepoint, while 
keeping the socket's local port as well for compatibility.

Balazs Scheidler (2):
  net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
  net: udp: add IP/port data to the tracepoint
    udp/udp_fail_queue_rcv_skb

 include/trace/events/net_probe_common.h | 41 ++++++++++++++++++++++
 include/trace/events/tcp.h              | 45 ++-----------------------
 include/trace/events/udp.h              | 33 +++++++++++++++---
 net/ipv4/udp.c                          |  2 +-
 net/ipv6/udp.c                          |  3 +-
 5 files changed, 75 insertions(+), 49 deletions(-)

-- 
2.40.1


