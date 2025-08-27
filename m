Return-Path: <netdev+bounces-217281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A2AB382E0
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5497B117A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DBC302742;
	Wed, 27 Aug 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAhyBVdb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4230CD81
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299233; cv=none; b=Kx+gOUhbRKLyjdU8qX4XMPi1CtUWHhU3Upc3TCuBYwMOxYa6iyxai/0cgKmV6g0qSI9dRMnd6WeO/7sUXyU1XjQhK54e4aLUDz3st0njEXxSThXAvEjpbO+M1C9U8mM4SKS2E5nqQX6xL/IL0NpzJ+77wUXddJ/eRx6bcVIuQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299233; c=relaxed/simple;
	bh=bPXTgcggDcmnNiNlCgJGT4E7YIfpPCYoI0R4kT1Z+8Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jn08OuMP6M3OIrdEFSmc6VIaHe1WSqXmy+cVVybV+ClzXjh1dL1y0xp+DVBhxbSavJcWPjg6eq0Qa+WiVhvElxd1+ETpqMQ4I2KhqdTOASormNTqJ0UOyHmcvS+Uiabgy8gZg9YqEzP2qghfLAfxlI2wNBYnnEPCwKchSRsYS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAhyBVdb; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7f7742e718eso66602085a.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756299231; x=1756904031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gsCZ+FPm5c1QBHnGecmGRNPDEYaXm0MsSxDxdgLZuv4=;
        b=HAhyBVdbAY2oxQbfn9vJ0qVHNihZW76nCKgQRRNqVWYIWU4Dc/2rsMr/GoAGsYtb7G
         3eFyL4X8l0nzo6atSdOBYEH2Kg/FjAQcnayVJo+8h9zeXoUmHYwJLV0MPm4V7P9Gpa1w
         QpAGuYC7AIUezD4jUBxcQGsJofe+5cA6c+ELXSgE/PrjMtMC86tu27hF39W3d+kfh/K3
         eZXzvqbZ1QH9tGEp7O33m1Ea/oqwjFL41duxT47Z7m8/qxyZ7Lq+6awE6Kb48TN2/36I
         /S+PIux32ihtFrrXWJnvj/s4KJD3PNN96mA3nGysFlhLLSaMxwy1y8PV4lNmLR1q54c7
         Lgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299231; x=1756904031;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsCZ+FPm5c1QBHnGecmGRNPDEYaXm0MsSxDxdgLZuv4=;
        b=IthDTvyWyrcATRDmTsX4DPM3Yqeg5fj5cN84Su75Lagmxha3eFQNL6qyNfJCMmj1xQ
         fFjj9wpcHHyj42GFDmvRwpFiB/gJzr6xKLAC4uF6tWTHtHtB3twcJBp6j+31SfAVWL9p
         6dgCYTqd+YtQKpyxjZumlE67N0bUjxXaoFf3zvf/BwTIV78GXIbaPJpP4VK7oyXKGplk
         tyatVDY3qAKcL5riw6s11cKbxsdmPYXMr/nrSSBKTbk+z4qu2L7usjv3LfG33Eat7P1I
         zfxy9GokXfdHNepETSIQCAitav79TIVHskKdOciLz+mJlUgOIykQwqKqHSqSWF3fcJe6
         Q3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFico9CVLegAFk+M7QBnTJUo2vyT91/etFxmM/jawDLF7hDwDKCbmJb5RmRqnanlU+pulB1J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHW0yqZuYChSXU12Y3SRE0bkypjx0E6G7U6dk3z1aWim7VhD8v
	0kbuZu7V59BCY+dVC9HB0HX1k72EvfbxEpgR8/WVIGQAsZDlFN4p0fnQTvJgcFnuh4POX3WE22r
	YEEmQcEmucKmtSQ==
X-Google-Smtp-Source: AGHT+IEmQlIKAcIBUeZaq9W2xqji1WWS+9qB3jCHQGHHQijo0zeIgAmO3FHxSjkSuqBPHbASrgbjijBaizgEig==
X-Received: from qknpb5.prod.google.com ([2002:a05:620a:8385:b0:7f8:9cef:49a8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:410b:b0:7e6:8bd4:8c70 with SMTP id af79cd13be357-7ea1104715cmr2322402485a.44.1756299231019;
 Wed, 27 Aug 2025 05:53:51 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:53:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827125349.3505302-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net_sched: extend RCU use in dump() methods (II)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Second series adding RCU dump() to three actions

First patch removes BH blocking on modules done in the first series.

Eric Dumazet (4):
  net_sched: remove BH blocking in eight actions
  net_sched: act_vlan: use RCU in tcf_vlan_dump()
  net_sched: act_tunnel_key: use RCU in tunnel_key_dump()
  net_sched: act_skbmod: use RCU in tcf_skbmod_dump()

 include/net/tc_act/tc_skbmod.h     |  1 +
 include/net/tc_act/tc_tunnel_key.h |  1 +
 include/net/tc_act/tc_vlan.h       |  1 +
 net/sched/act_connmark.c           |  4 ++--
 net/sched/act_csum.c               |  4 ++--
 net/sched/act_ct.c                 |  4 ++--
 net/sched/act_ctinfo.c             |  4 ++--
 net/sched/act_mpls.c               |  4 ++--
 net/sched/act_nat.c                |  4 ++--
 net/sched/act_pedit.c              |  4 ++--
 net/sched/act_skbedit.c            |  4 ++--
 net/sched/act_skbmod.c             | 26 ++++++++++++--------------
 net/sched/act_tunnel_key.c         | 20 +++++++++-----------
 net/sched/act_vlan.c               | 20 +++++++++-----------
 14 files changed, 49 insertions(+), 52 deletions(-)

-- 
2.51.0.261.g7ce5a0a67e-goog


