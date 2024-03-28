Return-Path: <netdev+bounces-83011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FF78906C1
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 18:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34751F213A2
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591C3BBC1;
	Thu, 28 Mar 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehXVrij2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246B3A1CA
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645393; cv=none; b=VSu9AlnLzz7KaVtNtjCWB+dsx7RfRRAkD9tXqQeK91ymWPElPK0h1p2mDnFvXXGV6NEIXaIqxIZvERah/hV58voEIsiu+IcRJrIOxmOqR9bg2g6rCua+jdkStpt/4cWouoD+H8YncM/uujCAXfqFnZVpAZvwKzYxQvdUM2tXE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645393; c=relaxed/simple;
	bh=1Qg2Xc5fiWdAmKN9yq/8NkAysiHrSJCCl1JhDAAV+vg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SIKOAb6p0Kv0WzLB1863bdGCUblojLxGcPafbaPuUpCQhW9+Lt1bZajoMDeDzZZ0P0pZlCRsjPVlj1vC+aLWyip2IbjhK8AAG41BswWOKfjCOGcksXnO/lPNsbv3AuM7+UbS/EO8rroXX2G9DM1xzVVPdkvYA8hep1sT+x47MRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehXVrij2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd944567b6cso1579066276.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711645391; x=1712250191; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xxjDnxP6o0AUca5bsnyIPePhIklV+eKqxglGpH7BpLg=;
        b=ehXVrij2LNcMZj1OEIA4KLAHUJvFQpwbNonqTS3EpPOpf35FC5bDGq9FkLcLiTYMlC
         kZ/i2K0hbP5nbKqA+67dCKpdLd08RakfT+94vqiqUpOBk2EBF8/pF8nBcEa9WWvzKrnZ
         oh4F79XSLp2QQRg7AfzSV3WAPxuS/NglNUxx1I+10yYhYT3ZcI5T8BrkrCvrxTpBeezS
         rYCrYaAgJxxWirtMjDLi4h2uGG9UcgtJRAr9WxzfoCmjw4GZxV1XYXHIL0jwJ3bHzNne
         s/mWo4fbkmiE5cIeTMk//zx4HIptafvATFPyeQZtJEaqC7FFebXDKt00Y2gNMGHf7+Sk
         tr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645391; x=1712250191;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxjDnxP6o0AUca5bsnyIPePhIklV+eKqxglGpH7BpLg=;
        b=saZPu8r1f5bJQ3bbIP3qsBvZ+MLeWO9uwrG9oSJl6dHihhD9sZoUwo6h3qBY3stM7I
         a8N/6ApAVBykFawFCUQ3V8eyXyIFCm12pwA7/8iZWzEqz2pvMz8xWZI7E8s166bfa2KB
         3tjXyvQ1U/jXrwYH4nPicUWeeGenneM/lSAXuRcEAP0BH6uUl3UTLauvIBpwcoZXBxj2
         FYkHZggI3kfdD1T9xHZo8yvBjURdbHbkRulxGD5FqxA+MQxs0oBROofpJmzAeCpjYzrE
         meXPxW4P6e9vDyBK/daH/TpNUdGQN6W1oe1JyEmbXqbMyV8l8p2EPuigwQ7sQX2s0Rxe
         wsOw==
X-Gm-Message-State: AOJu0YxlG3aNSqWjIgSs0SEHFdEeR4QKMAAYo8xJfvAM9ekUxa5m+Eky
	PeiCBQo6o59/0YIM/HuKYcLB2c9hRQIb5fUVT6JtV2YsoSeqapKJgnkymm81UbMxzChaB/fjscb
	h66HOQZK0uw==
X-Google-Smtp-Source: AGHT+IGJda//3CGXNO9415eevvQo9YysVQUaGLfgpqxb5HJRI+5uO3MiuYDGntpfSeFHdaEwKYzJ1vQ641bc+w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1009:b0:dc6:b768:2994 with SMTP
 id w9-20020a056902100900b00dc6b7682994mr256723ybt.0.1711645391304; Thu, 28
 Mar 2024 10:03:11 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328170309.2172584-1-edumazet@google.com>
Subject: [PATCH net-next 0/8] net: rps: misc changes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make RPS/RFS a bit more efficient with better cache locality
and heuristics.

Aso shrink include/linux/netdevice.h a bit.
 
Eric Dumazet (8):
  net: move kick_defer_list_purge() to net/core/dev.h
  net: move dev_xmit_recursion() helpers to net/core/dev.h
  net: enqueue_to_backlog() change vs not running device
  net: make softnet_data.dropped an atomic_t
  net: enqueue_to_backlog() cleanup
  net: rps: change input_queue_tail_incr_save()
  net: rps: add rps_input_queue_head_add() helper
  net: rps: move received_rps field to a better location

 include/linux/netdevice.h | 38 ++------------------
 include/net/rps.h         | 28 +++++++++++++++
 net/core/dev.c            | 73 ++++++++++++++++++++++-----------------
 net/core/dev.h            | 23 ++++++++++--
 net/core/net-procfs.c     |  3 +-
 5 files changed, 95 insertions(+), 70 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


