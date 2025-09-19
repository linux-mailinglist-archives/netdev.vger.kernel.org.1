Return-Path: <netdev+bounces-224693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49825B88707
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED34517D716
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C8E2F7465;
	Fri, 19 Sep 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nY8kfQkL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1652E7162
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271031; cv=none; b=Hyex0MbZLPivChxJUMLPypIOOEc9zcu5efAQQd7lJGPZbLY4pPEILF1IVwIfibElVGh9zHj1CCsw5InX95SWGo+qsEsJ8Tb6M/n6fi/UJJsItC7r5aqspZTh2LDfrOfZsbLFDZe/7nlTg3zoSxVnMieC53t8CLIBAa7kdxKc3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271031; c=relaxed/simple;
	bh=0cg3mKxxucZg2tTtUJEVaAqYc4z5KgD63C6j21sNkos=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tO5hM9SQ961ZngJK/Te3xvq0P0yxVgcaD53C0hNvDFkmO3a5eWCOG61hyQDIAxC0sGCGKxXCe/qkhtOiuhz02kDrz+Kuu9ts6byQZdOQSmaZTVXUIrjrm0q56UbbVTizzkqsFjvQ8OvVo9XnyYWHXS22dE3BM49cNroSO3sJFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nY8kfQkL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b551ca103d8so304100a12.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758271029; x=1758875829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MSbx0f9u4d1H2lhYV5fqSFWdGSPAEqDAev98V2+3eBI=;
        b=nY8kfQkLrNpR/MLf4vs5jx7QzoAza1zimX0kR3a3vc5OkIPXvG9Eqmsh4xyTKd4vGA
         UHhmLtoAkVe98RE1YoqpuciN3YsGOgQDDFsGuiX6XTDyj8KsbXfAQKtj+AovOH98nHpj
         1W33laXmp635ntd6DEoRxMm/KeL3FiDumpSW+yBmCfiw4lDFlUYFyz8Sxk26ET5jU5IN
         KmFypaJSEvqm4v8XT3oRKSVRYVUmNz8wZBKl1rhAH6MKPdAgEWzyP1Me2KakIZlX+9vi
         ALV8p/tjOG927Q6wvysLv2cVtLOfBenInprsf5N/fxXHZGgxamd5F57CutfIPq6GnNXj
         z1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758271029; x=1758875829;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSbx0f9u4d1H2lhYV5fqSFWdGSPAEqDAev98V2+3eBI=;
        b=xOcuRgFR2OYavYBSKVn4GOdceEFPG5GumNKjUn62SJdWJM8Qn4CtZ1TLUeTf2ZrnIM
         SXI4XE6m9YPqJH34ICNA783rj85bNuKT/hfp6A8W+8+6FC9BFXZ/2mMaI8edSqwVicZ/
         WG42v8Jj8iLaI+xx7r7UkiN/04iidEeAoL2ASlC8ixayXw4/QP/aP4/vyJTHybjm8yEG
         IHSndJIk0KLg4eyT7btOJXo8QXSofQWPri6jyvo9i/sDH+t1eutdje1YbOCHZBcu/2rw
         0jNaPsNooHIATJ7tR9mS4J2/cR8Rk8z7TftPnc1qL/2PqHgfHf4jXjoWJ29dWQ2gGOgy
         KPMg==
X-Forwarded-Encrypted: i=1; AJvYcCUTKb2066K4zciUHRz0O+cMZw4M/OLPB91gmu6Xb3WMrTV6gsrAcWp8YpHQB5Xxtb5ALxtuk2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1NgkPMPLC4Th1ialJYeoXneHmTwIeBpRdiS6rl9UyS9CCyLL
	0+0WvIRLNFJ30ycVBVw+HCNCEYmiBF2jSk4Je+Y18ph8bzGMTwDt7MlLXSFpHW2KKCdfkU7s8cl
	BpPvS3w==
X-Google-Smtp-Source: AGHT+IEO0T2oFW7L0PInIA0k4zngwmgCNIVUY/30NkhHIwAXWh3GWU0aZ/lpuf4ifgKKyhlvZK6fyjTT24I=
X-Received: from pgei10.prod.google.com ([2002:a05:6a02:526a:b0:b52:3791:5a32])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4314:b0:262:d303:38ab
 with SMTP id adf61e73a8af0-2926ec19908mr3576205637.33.1758271028863; Fri, 19
 Sep 2025 01:37:08 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:35:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919083706.1863217-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/3] tcp: Clean up inet_hash() and inet_unhash().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Xuanqiang Luo <xuanqiang.luo@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While reviewing the ehash fix series from Xuanqiang Luo [0],
I noticed that inet_twsk_hashdance_schedule() checks the
retval of __sk_nulls_del_node_init_rcu(), which looks confusing.

The test exists from the pre-git era:

  $ git blame -L:tcp_tw_hashdance net/ipv4/tcp_minisocks.c e48c414ee61f4~

Patch 3 is to clarify that the retval check is unnecessary in
inet_twsk_hashdance_schedule(), but I'll delegate its removal
to the Xuanqiang's series.

Patch 1 & 2 are minor cleanups.


[0]: https://lore.kernel.org/netdev/20250916103054.719584-4-xuanqiang.luo@linux.dev/


Kuniyuki Iwashima (3):
  tcp: Remove osk from __inet_hash() arg.
  tcp: Remove inet6_hash().
  tcp: Remove redundant sk_unhashed() in inet_unhash().

 include/net/inet6_hashtables.h |  2 --
 include/net/inet_hashtables.h  |  1 -
 net/ipv4/inet_hashtables.c     | 28 ++++++----------------------
 net/ipv6/inet6_hashtables.c    | 11 -----------
 net/ipv6/tcp_ipv6.c            |  2 +-
 5 files changed, 7 insertions(+), 37 deletions(-)

-- 
2.51.0.470.ga7dc726c21-goog


