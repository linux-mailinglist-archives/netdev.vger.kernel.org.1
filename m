Return-Path: <netdev+bounces-92157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC578B5A4F
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D665AB27AAC
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A7670CCC;
	Mon, 29 Apr 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zjsqv3IL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C5BA2E
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398029; cv=none; b=AYVpxN9rkBNNPekAfMD5MzqDe27Z91Z7R4QN//YsgP4DBYH2PylIJ4sw3rzEyqdCFlolPlyfjGq7zsW5md0iz/4CwKmSFGdAo6V4mTxqlrib4+QPAiY13mBE1lm+RrVxaz9qoqRrUpnBP735l2vYQ02WvA56BGYeBhEnv0p/erM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398029; c=relaxed/simple;
	bh=dZssHpzkfw14XvhNskP7/xIr2YhtCGWNzzMap/xatnc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N8Vr4hhJMdlQlGk3WF0Eg9UpXfCD7UHJi91fgNXhHoTYJjYwGU3/yzc9Rt5OnUP4QQe91ELTQMFvFs+pAaKRM3PPVfuvZPbPzvXvtDjhkIfFqnFhXSRr1CXDBtGFEHruXmPY/GptpsLog+TjgcpPuV+xjRVRGf5r+0G9ABG4Vvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zjsqv3IL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54be7066bso8242321276.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714398027; x=1715002827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uNnGhoj30uVuyW5JWvdaz4Oj0HM/2XjrIk1JWPu4JsI=;
        b=Zjsqv3IL/21eMdqNV1IhpN7y6ro+H7itzP/6HZ3FRUxuXyPayHq2rzM9duzxjIlOGl
         5TjnefsoYlXMNJWEj4scgwu+d2aDmEoeBDWcWQ9fYJI3Qhf9HiDTKvay5fMaXusQ6C3z
         foYINjue/AtB0rRQaJZkALnmaXTL4N7KdAO437IjuIVcPalTlTSxf/5AwmG5kkbUFcqy
         gV4s00TsguebwaCw79+C0SlJau74tkt2nEXan1Dpq8Jb5BXIMPF/i+RJE4zqkF568rCx
         YsXRM37OcaImrPiMol8V1nfcogt0lP2jfGzDbmL+Wdb0gzBWnkXsjDsLRzu5IFzc0Ngi
         cHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398027; x=1715002827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNnGhoj30uVuyW5JWvdaz4Oj0HM/2XjrIk1JWPu4JsI=;
        b=Q5WfD8GeZrQwG//asAgzFLCCWyH1NTQ8slOPhD8SRsYi2cwBMN15gNh6quPQwqE6li
         tQ4EhOpmey0NwrTVBxvVfXg5oiL/lmwbMeyaa4F9jDzB1ZwUHFR4M8e9QJs126ASh0YX
         Ru8m1Z5eaLhAFC2AyBYg8El8MredQ3EKYwc7mz2n6KvAtt1HM40UujlJdAsOEBWBpak6
         hmOHsi4EsXOQOViD9aKVYGsKYaXXXk/o7fPnwlgaavhpm2pcanV+mSjXXdpIDKzuj+46
         Xgb2BHSl7neDoyTrAM5ahgnuZ3/iaNK8LGBSNsYzyizE2uS/I9CCFjn1hH/0/xbnu+24
         9l+w==
X-Gm-Message-State: AOJu0YzUUcgPoWAsvJGEpFYlHhYDbfjcU/e2cG3IXIkoVvbYm5BZiEN5
	HZVVXofPQhp53Jl6ARroQatREq/K4ZgtWVHJS/ctkRMSmy82l0YCNj94wB88LQ6ZkZO1q6/IR4x
	+kAAxLuzivw==
X-Google-Smtp-Source: AGHT+IFuKREJsqNGQjE/xQsRCVKxyiV16fxjfpqcdxFAFHQ5JfTtE1YfMMZSfAG5zfwppI8fkfDBToR0iktXRw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100a:b0:de5:a7a4:ebd6 with SMTP
 id w10-20020a056902100a00b00de5a7a4ebd6mr3186117ybt.12.1714398027303; Mon, 29
 Apr 2024 06:40:27 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:40:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429134025.1233626-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] net: three additions to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series moves three fast path sysctls to net_hotdata.

To avoid <net/hotdata.h> inclusion from <net/sock.h>,
create <net/proto_memory.h> to hold proto memory definitions.

Eric Dumazet (5):
  net: move sysctl_max_skb_frags to net_hotdata
  net: move sysctl_skb_defer_max to net_hotdata
  tcp: move tcp_out_of_memory() to net/ipv4/tcp.c
  net: add <net/proto_memory.h>
  net: move sysctl_mem_pcpu_rsv to net_hotdata

 include/linux/skbuff.h     |  2 -
 include/net/hotdata.h      |  3 ++
 include/net/proto_memory.h | 83 ++++++++++++++++++++++++++++++++++++++
 include/net/sock.h         | 78 -----------------------------------
 include/net/tcp.h          | 10 +----
 net/core/dev.c             |  1 -
 net/core/dev.h             |  1 -
 net/core/hotdata.c         |  7 +++-
 net/core/skbuff.c          |  7 +---
 net/core/sock.c            |  2 +-
 net/core/sysctl_net_core.c |  7 ++--
 net/ipv4/proc.c            |  1 +
 net/ipv4/tcp.c             | 14 ++++++-
 net/ipv4/tcp_input.c       |  1 +
 net/ipv4/tcp_output.c      |  1 +
 net/mptcp/protocol.c       |  3 +-
 net/sctp/sm_statefuns.c    |  1 +
 17 files changed, 117 insertions(+), 105 deletions(-)
 create mode 100644 include/net/proto_memory.h

-- 
2.44.0.769.g3c40516874-goog


