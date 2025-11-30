Return-Path: <netdev+bounces-242839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF437C954AB
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 21:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC8B3A2452
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505F62C21E5;
	Sun, 30 Nov 2025 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHNLoidb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="odq9Ib0+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF321E098
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764535054; cv=none; b=bJmgNBKKqCsPmcuTi0OYS39excepyaabifaRhjiA59bWbguhoDF/7a4m591MfDkrkL5brahtnqDE1y+Gzk7Y/b/0TzNhLpNp4iO9AbdpmtuEGdmadAMcLvvRoA6gHK2P/h9vm/bA2DEDa2GdVvq05PqzJSPGIFXJhPqbfbYoYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764535054; c=relaxed/simple;
	bh=YwvRLmvf8g4chDxRz9C6auQvbO+2SRo81WRaUQE6B6Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lh/aqqSQXhwUvgf6xT7qC31wzK0GbTKODwpmRwYRQ8yyW34BG4Q/hNrvwVvw0xSQZHhviCPO9aA3uH8CHC5A3lOSDhHwqLGQP/g3r4s7GO6/u6141swziCoB55PTHaydaAx3CCTFHfIVrFEbw3URB5v/fdFfitCrsgqRB3mmUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHNLoidb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=odq9Ib0+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764535051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+aQZT4b2Nu/IBd7NvYkGdOpZxCNL6++4JZQfNH7Vtno=;
	b=QHNLoidb4Jtq723F342Fnefgrg1wNgHmQjqJ0jQ2ErlLzcd9FzVPzO3cHXgHptbbuXxUf6
	IkB8mWMl1+7XegPtHrMsOPgzLiWSeLhXRvOeL0gEzqqyHlz9h2Tlo0sdPUcwGbgjrOg2GM
	0IATcUtiI7Xo5XkOHs2aPdOTDjiD0qs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-8iObUitgOaeLlJugkbtyKQ-1; Sun, 30 Nov 2025 15:37:30 -0500
X-MC-Unique: 8iObUitgOaeLlJugkbtyKQ-1
X-Mimecast-MFC-AGG-ID: 8iObUitgOaeLlJugkbtyKQ_1764535049
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6409f6d6800so5177741a12.0
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 12:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764535049; x=1765139849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aQZT4b2Nu/IBd7NvYkGdOpZxCNL6++4JZQfNH7Vtno=;
        b=odq9Ib0+21xZEaWV+onF712ivlUUo8A0d4svl0MYa7qzBNKbwMINu8rQWtDh6y+iWB
         JCE+XMKQ37BF7RhiQtJR+Qq3w+SBYkI+qtIuee1WVC59xM5AmvgPXwbsPt7CPEdn+KZC
         7Ye3CuV0lz6v4SnmB2Bh9wfIbFm2K+84d3SU7ScjmqzqU+hyEB+aZ0QbD+CUbmPYuHaM
         xe1+q0FOEyHrTPnsLWvEaHgXw3ZXYDRS+zksAbh7nOKkjKUUoH6YbEf1RO/GVHCONsuv
         yeEJkvRlFgY1RXJPqOqG4O4hRcck7p/7QQBsCbWgxtKPxzCct8SQFz2Qn4h/CHFxVVr1
         UIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764535049; x=1765139849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aQZT4b2Nu/IBd7NvYkGdOpZxCNL6++4JZQfNH7Vtno=;
        b=Nv0rbnOdHQX+stnH5wuamm1syMnuEcR0HP42JYxNJuc2MF5mq8WZPO0TaqabP1luKG
         vWAEp8DZJe4v2uXGyWepDiuZ+utzVrUT90OlNxQPGNU6bCIXKlK4oIXrLwPi1ktmkH4Q
         Jw8CGA30mYFOzjjWPl0d1ErrG/Vm8q3GQxLZscec2URDGwXvMf5tFKV5y7/L2YTfs+zZ
         9vcJDQCittq3R3CWpn9M2hM/JJ3Aef+7otKc9PvA2UBosBhiJC6D0pAmsX/NbHZlQBkd
         HH1nTA4LQe1bv//EqNHg48tLtqihi+j2pZ6Vgb4QQ2Q9Aaxdl1DEDS8dv5C+JltjtmjP
         0dbg==
X-Forwarded-Encrypted: i=1; AJvYcCWck4BHSlpdnzQIX82N3/e663S5g/DHj8IetsGS7toOi7apdSRQDI8JeS1ioYDAZ9hIl8MNJtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEL0sUDHYMuVEibT+yYd/Y3L3FVAjk28F1QefC4hUj1ZvAUOAw
	C9RnRml3eBl7+omDgc8DOxPCLeTT27KQPVdUrT1zacHe5tve4jXLroB54RjvlIVeAk2M79Swdzq
	n4BArPMtG46gjAJOakHBmc06wjkq+aX/4ACA7HbLpgPT0bL+JYp6xv4g1Rg==
X-Gm-Gg: ASbGncvPPP5Fbt/FC1pu6QDbmeMP24GMkOVTUuFZovCbZTmPjH9CCqzSl0AbvOuURfQ
	vhfCSW+bTHNwytSSFA0JCKCcj18yQakjaNKh7lCEbIYkTv0I2ecPaTo8FM8RiW+O5OUJgKBLLlw
	i72+DPI3FlSvclWalo6kbcxjqoxGTAgqmQz0v5w9gNsqYHUpujS92W70jr1q9TN+MMBiBsKbcU4
	bcKqzk/3RoBnpdrukagUg6onYZ1bxqwpfabCE3Fw2rd/NHjZvZ8M6dCnUlCSiOwNXNIKmVk4ECp
	HR4S/fghAOzhuCEYd7iNK01Ejx8CKBbMUgFd+/5AgCZGksmJ3m6BrEDPKxGVT33aWoYtLEvvydO
	l8ktHiDmJSb74BwdIoJCMA1eVaIf3dcX+ig==
X-Received: by 2002:a05:6402:5246:b0:62f:8274:d6bd with SMTP id 4fb4d7f45d1cf-64555b965e5mr31799458a12.8.1764535048858;
        Sun, 30 Nov 2025 12:37:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+MHlVb+HXR1Syt7OiQv3LYgQRsQyXTTIn3F85nqKzPRN8lUMKxM5xLTDLbFxEpo1vxAa8mA==
X-Received: by 2002:a05:6402:5246:b0:62f:8274:d6bd with SMTP id 4fb4d7f45d1cf-64555b965e5mr31799443a12.8.1764535048454;
        Sun, 30 Nov 2025 12:37:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751062709sm10284515a12.35.2025.11.30.12.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 12:37:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 390B2395C21; Sun, 30 Nov 2025 21:37:26 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v3 0/5] Multi-queue aware sch_cake
Date: Sun, 30 Nov 2025 21:37:17 +0100
Message-Id: <20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP2qLGkC/3XNQQrCMBAF0KtI1o4kY6rWlSB4ALfiIs1MbJC2m
 tSiSO9uqCCKuvz8+W/uInLwHMVydBeBOx99U6cwHY+ELU19YPCUskCJmcwlQnUGa44M8VLAmXy
 0YMnJIssJHWci7U6Bnb8O5k7U3ELN11bsU1P62DbhNjzbbtbDwRNG/QPuFEjQUyNnkpRSaFaBq
 TTtxDbV4HXqRaT6L2HQOUWm0IuF+yLwnZj/IjARqClnQ1LPi/yD6Pv+AVGxSYlEAQAA
X-Change-ID: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.3

This series adds a multi-queue aware variant of the sch_cake scheduler,
called 'cake_mq'. Using this makes it possible to scale the rate shaper
of sch_cake across multiple CPUs, while still enforcing a single global
rate on the interface.

The approach taken in this patch series is to implement a separate qdisc
called 'cake_mq', which is based on the existing 'mq' qdisc, but differs
in a couple of aspects:

- It will always install a cake instance on each hardware queue (instead
  of using the default qdisc for each queue like 'mq' does).

- The cake instances on the queues will share their configuration, which
  can only be modified through the parent cake_mq instance.

Doing things this way simplifies user configuration by centralising
all configuration through the cake_mq qdisc (which also serves as an
obvious way of opting into the multi-queue aware behaviour). The cake_mq
qdisc takes all the same configuration parameters as the cake qdisc.

An earlier version of this work was presented at this year's Netdevconf:
https://netdevconf.info/0x19/sessions/talk/mq-cake-scaling-software-rate-limiting-across-cpu-cores.html

The patch series is structured as follows:

- Patch 1 exports the mq qdisc functions for reuse.

- Patch 2 factors out the sch_cake configuration variables into a
  separate struct that can be shared between instances.

- Patch 3 adds the basic cake_mq qdisc, reusing the exported mq code

- Patch 4 adds configuration sharing across the cake instances installed
  under cake_mq

- Patch 5 adds the shared shaper state that enables the multi-core rate
  shaping

A selftest, and a patch to iproute2 to make it aware of the cake_mq
qdisc, will be submitted separately.

---
Changes in v3:
- Export the functions from sch_mq and reuse them instead of copy-pasting
- Dropped Jamal's reviewed-by on the patches that changed due to the above
- Fixed a crash if cake_mq_init is called with a NULL opt parameter
- Link to v2: https://lore.kernel.org/r/20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com

Changes in v2:
- Rebase on top of net-next, incorporating Eric's changes
- Link to v1: https://lore.kernel.org/r/20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com

Changes in v1 (since RFC):
- Drop the sync_time parameter for now and always use the 200 us value.
  We are planning to explore auto-configuration of the sync time, so
  this is to avoid committing to a UAPI. If needed, a parameter can be
  added back later.
- Keep the tc yaml spec in sync with the new stats member
- Rebase on net-next
- Link to RFC: https://lore.kernel.org/r/20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com

---
Jonas Köppeler (1):
      net/sched: sch_cake: share shaper state across sub-instances of cake_mq

Toke Høiland-Jørgensen (4):
      net/sched: Export mq functions for reuse
      net/sched: sch_cake: Factor out config variables into separate struct
      net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
      net/sched: sch_cake: Share config across cake_mq sub-qdiscs

 Documentation/netlink/specs/tc.yaml |   3 +
 include/net/sch_generic.h           |  19 ++
 include/uapi/linux/pkt_sched.h      |   1 +
 net/sched/sch_cake.c                | 476 ++++++++++++++++++++++++++----------
 net/sched/sch_mq.c                  |  69 ++++--
 5 files changed, 422 insertions(+), 146 deletions(-)
---
base-commit: f93505f35745637b6d94efe8effa97ef26819784
change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5


