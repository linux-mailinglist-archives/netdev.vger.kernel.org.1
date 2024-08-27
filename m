Return-Path: <netdev+bounces-122099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD395FE87
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6A9282B44
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB91DB674;
	Tue, 27 Aug 2024 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbzFvHeR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9D8F58
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723574; cv=none; b=O3iDuxHdHmvzbjBMOm/bKrKj3pJ05+NzzAhGTOx4ThvuE36rIsCjrJgEKj50+4AKn+54Njum/Lcm9z/W51oIoN8YMn9FG859WWxT6Uo41RzodDOvqbZM+V9QGFdx0u9g0n2A9ZusmRCr+RaRMtXo2Z1bUHjj07s0lA15Fwt87qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723574; c=relaxed/simple;
	bh=+0ZNhwhMcADXpClWxCvYqUrm56kpIWAFmcyHmtslGhU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o9q4wM0z2c5nrN+qm85xAg5rnTjmJ4vSzQMiGwStTMPLi2+/sFhUhlzjOZ7SzHr9sgsM3M03Wk/PAZvSyXlmFEAq1dRh2t4j/BiMCYJ0Tvz4DXOcRdmyYBrrkgzh1iH5ssARSQeec4wIXDxk48J7e8X/NVrJD1PSeUjdnrdxuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BbzFvHeR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b1adbdbec9so97675057b3.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724723572; x=1725328372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p6ALWt+rf7PODfokfpuaXCHvvINFZzcvRgI6jvWvQDs=;
        b=BbzFvHeRdY2iBHybCvEe826/C8+FYRXYG2i5TnZIqAj56djGaQ+H/BMFgS1zvkdjbQ
         H7wMlAs7YqOZy0iGguYQ1h2C9zaJl5DpixD006Z3GBxLq5Dtb0J8F42Hf9MXB5atpS64
         ddv7ppFBcqmqbglp5+IFdz6MxBeEmOEUv0kZUhD8hVjxc7zRfb8UPfDFz5RJQflVhcRP
         5wa5QeZT1yJ5npuhlL5Fj0kDiXFnH4JRIqXOOJspNABlBcfTVSXB/lFspXU1Zoo61n6N
         yTNRj7U1zjD2/jziYaQ5iZDzBYJS8k/D60ERQIIFIiWuzlNB0AOBWHcEsrx/S+xL3jFm
         sBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724723572; x=1725328372;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6ALWt+rf7PODfokfpuaXCHvvINFZzcvRgI6jvWvQDs=;
        b=fnUDJ+T4YVSHZ+3XDXkEWeuWcix9I0IqkeCz/ZOLEFuGpfGoXx1o+I+dDTDT1APSX5
         9roTKeiTmNq530yY1UCHcu9G7X+OYQnINKiVN6k/Ahb3g5TNruF8n0hTUSpXtpouOqoq
         ahBMAZNWyztBorHTmtziaI56PYUKt1hDCOWcFreGVt+wt8k5Ha5PtN1gGbB2LSMO7YnI
         xrDm+fsDqvxYp1xmTZHA4hh2SSZDvvwWZ976mFyGcqz2r7+5ohetU5+8VVO60TvCOCqQ
         0EsFn9pPRbaE1gkuGri8XBtaBluZ3E1FHYoBZCuP+FhJzXqrVWlMXPg40wNkZyjEHkzL
         PDDA==
X-Gm-Message-State: AOJu0Yz5PDnvvZaiEcrrFbRONjMT2vnsA4UaUDt54r4TltiLCIVPOscC
	PHAIg3v+I9ZtGmkQhTIChGpLV9Vtw18QfTXCHvmUa+waG2ZpQFExWsta2uK3Ow1Ps3HZTSfM3EN
	9ChPvWb+/MA==
X-Google-Smtp-Source: AGHT+IGVgz7aQu6j39+zPAQrhv9Kc98WnDUXhDp1pynZPoVnKQbYz+5UC06LUl2yOvtwTssYi8sIbUSN8M1n7g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:1d0:0:b0:e16:67c4:5cd4 with SMTP id
 3f1490d57ef6-e17bbff7379mr16757276.4.1724723572117; Mon, 26 Aug 2024 18:52:52
 -0700 (PDT)
Date: Tue, 27 Aug 2024 01:52:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827015250.3509197-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: take better care of tw_substate and tw_rcv_nxt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While reviewing Jason Xing recent commit (0d9e5df4a257 "tcp: avoid reusing
FIN_WAIT2 when trying to find port in connect() process") I saw
we could remove the volatile qualifier for tw_substate field,
and I also added missing data-race annotations around tcptw->tw_rcv_nxt.

Eric Dumazet (2):
  tcp: remove volatile qualifier on tw_substate
  tcp: annotate data-races around tcptw->tw_rcv_nxt

 include/net/inet_timewait_sock.h |  2 +-
 net/ipv4/inet_diag.c             |  4 ++--
 net/ipv4/tcp_ipv4.c              |  6 +++---
 net/ipv4/tcp_minisocks.c         | 31 +++++++++++++++++--------------
 net/ipv6/tcp_ipv6.c              |  5 +++--
 5 files changed, 26 insertions(+), 22 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog


