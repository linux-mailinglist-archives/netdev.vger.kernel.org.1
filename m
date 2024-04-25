Return-Path: <netdev+bounces-91175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8368B1946
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24070288A17
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721A10A3D;
	Thu, 25 Apr 2024 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRIxvp60"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC420332;
	Thu, 25 Apr 2024 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014831; cv=none; b=uX01Q83GOLFqzbTitw5aJsSDFw7IwNgWRZJ+yD5hi+LGLDpsZzSG3QBZO6hyHwiVj4qqcd7zwFyYzYe03OqAXh2ODRf8dAbkpWI/mqUx5iRKSop3wO6115lkKUhPNS9MRx2A8e4jbdVRbE7Q2F/bk6qIz23E0OTPbMknYXCwR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014831; c=relaxed/simple;
	bh=mKqjmUikE+ekZ2nHCfZBGZ9KkiZHK3bCyq4mAZ5KJcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6MshxtIFH45S+NYGG+Id6YOVcDxPJxSxT4dGwR6OPoa/UTw0KHA4LX2V9UlB+cQTVIqvHERzCIXBbCD1bAj3IsVR3G65m3FNCinSE0imRm6wsKVkGwfVSWHoMqzkz7NN4TIEHRv+gVXFH7YMUdKbA6yJwXtaMz7zv2spE8UacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRIxvp60; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c709e5e4f9so357840b6e.3;
        Wed, 24 Apr 2024 20:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014829; x=1714619629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YU0p2fRlMOT6Bl735bxG6/yrExlNwYwLzjYxhr0d7ww=;
        b=cRIxvp60Es7v+SAIfZFkRNAK3yRSFrAIwUlqncepnbxR4fqJk/jo0OvK8RN6KevwtW
         BxJmgdC9f4uktM6lU1OSa7ePP/tMOKq1PSqAaBQGg2lLx8UtMImyn7jnhudeDeJwP8v9
         nYGBhev2oZpxnpMAMS7uMHUlnvYGnQlhTjJs8gapLOWtV8xd5iIU7t5AJpCGlEFWwTps
         FXm025a1KLf5pNnIh1p0LU40vKbSjdBM0GwOLmgVY/SEYceYyCdg6avzA0jrSPqP7rSp
         jzAxZGNfM4zDGg+G1rCEuOt7qv3bcGfNQ6ns9Au//4q0AhK4oENMCZ82aOXmVl3b23Pg
         ypYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014829; x=1714619629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YU0p2fRlMOT6Bl735bxG6/yrExlNwYwLzjYxhr0d7ww=;
        b=fZ7B3XJdqS0nVdi22TqpZ35zroIPnVBEvoRYjQHIE7G5kkQ6k9VIWb0+hrCtzgZ7lN
         NmFAQk7C8NuuJOvtCoYDNuU66M1129K6lTvPTCZbtFHbH6o040M0p77blMhHkc504+N6
         i9I2iNTyH3rp3LfAISfGGIMsotFtYtj6z7N5+RgQwpKw10C14uuUew8+adEjnJaEr68D
         oTsIKQt4B9ukkXm5PITO34nUSy2bJ0imRIAU86lydTF3CIiR0/QdwaIAFaE6q4TZKstW
         UERKMAziihc9b+n7zEedyZQtwYdNKTVBth7ympTSH7io79NVjWXPQBpowTJUWMl/vgqE
         CYLg==
X-Forwarded-Encrypted: i=1; AJvYcCV0nN5ycgQhI2nPR0kJCihAR+zst4RiTacuHYqvzmdBVIejojkJCE4T6QnuzNR/SQQ6j/7wIij+GhqZVokJ5UVJQZNCu00VtTSkKH0pOPzW5L+kNvU63hjR3wciSsXv890kMT8XS+MR9nTC
X-Gm-Message-State: AOJu0Yzry/yaJRBlQ7/Ir8aAyfg3ykxMYEGn99WALsMz/7aYYwngm5Hx
	Rj+uRAr5hknFsGI91J62UP7yTyR67jyqE0r6sRizJJWM0ycoAouy
X-Google-Smtp-Source: AGHT+IGjfiExtw33rrrC11Yt5tBIGWUOyp3yGY+NBZGXjs4C061scjD5jlJBgO1Me22gOPgihGfsSQ==
X-Received: by 2002:a05:6808:6291:b0:3c7:2d96:a385 with SMTP id du17-20020a056808629100b003c72d96a385mr4529784oib.6.1714014829390;
        Wed, 24 Apr 2024 20:13:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id gm8-20020a056a00640800b006e740d23674sm12588884pfb.140.2024.04.24.20.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:13:48 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v9 0/7] Implement reset reason mechanism to detect
Date: Thu, 25 Apr 2024 11:13:33 +0800
Message-Id: <20240425031340.46946-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In production, there are so many cases about why the RST skb is sent but
we don't have a very convenient/fast method to detect the exact underlying
reasons.

RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
and active kind (like tcp_send_active_reset()). The former can be traced
carefully 1) in TCP, with the help of drop reasons, which is based on
Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
RFC 8684. The latter is relatively independent, which should be
implemented on our own, such as active reset reasons which can not be
replace by skb drop reason or something like this.

In this series, I focus on the fundamental implement mostly about how
the rstreason mechanism works and give the detailed passive part as an
example, not including the active reset part. In future, we can go
further and refine those NOT_SPECIFIED reasons.

Here are some examples when tracing:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NO_SOCKET

[1]
Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com/

v9
Link: https://lore.kernel.org/all/20240423072137.65168-1-kerneljasonxing@gmail.com/
1. address nit problem (Matt)
2. add acked-by and reviewed-by tags (Matt)

v8
Link: https://lore.kernel.org/all/20240422030109.12891-1-kerneljasonxing@gmail.com/
1. put sk reset reasons into more natural order (Matt)
2. adjust those helper position (Matt)
3. rename two convert function (Matt)
4. make the kdoc format correct (Simon)

v7
Link: https://lore.kernel.org/all/20240417085143.69578-1-kerneljasonxing@gmail.com/
1. get rid of enum casts which could bring potential issues (Eric)
2. use switch-case method to map between reset reason in MPTCP and sk reset
reason (Steven)
3. use switch-case method to map between skb drop reason and sk reset
reason

v6
1. add back casts, or else they are treated as error.

v5
Link: https://lore.kernel.org/all/20240411115630.38420-1-kerneljasonxing@gmail.com/
1. address format issue (like reverse xmas tree) (Eric, Paolo)
2. remove unnecessary casts. (Eric)
3. introduce a helper used in mptcp active reset. See patch 6. (Paolo)

v4
Link: https://lore.kernel.org/all/20240409100934.37725-1-kerneljasonxing@gmail.com/
1. passing 'enum sk_rst_reason' for readability when tracing (Antoine)

v3
Link: https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@gmail.com/
1. rebase (mptcp part) and address what Mat suggested.

v2
Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
1. rebase against the latest net-next tree


Jason Xing (7):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  mptcp: introducing a helper into active reset logic
  rstreason: make it work in trace world

 include/net/request_sock.h |   4 +-
 include/net/rstreason.h    | 121 +++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |   3 +-
 include/trace/events/tcp.h |  26 ++++++--
 net/dccp/ipv4.c            |  10 +--
 net/dccp/ipv6.c            |  10 +--
 net/dccp/minisocks.c       |   3 +-
 net/ipv4/tcp.c             |  15 +++--
 net/ipv4/tcp_ipv4.c        |  17 ++++--
 net/ipv4/tcp_minisocks.c   |   3 +-
 net/ipv4/tcp_output.c      |   5 +-
 net/ipv4/tcp_timer.c       |   9 ++-
 net/ipv6/tcp_ipv6.c        |  20 +++---
 net/mptcp/protocol.c       |   2 +-
 net/mptcp/protocol.h       |  38 ++++++++++++
 net/mptcp/subflow.c        |  27 ++++++---
 16 files changed, 266 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3


