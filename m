Return-Path: <netdev+bounces-248498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE59D0A666
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C11E304EF4F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEA135C1A7;
	Fri,  9 Jan 2026 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggpgnk+q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nGwC/org"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9CB35BDBF
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964546; cv=none; b=VQt5mLonqnAUOq/OO3IHm94XsmwTuyvB7/f2OhGRY+g/WgkqD3MmuQiAl8m/OkXhl5p5kx8BOnkJIptYkP08vZ/3R24Ikw4IdNZ1AJSp/WlJxy+FznhgFE8e1XfbTsaXbjZKXumEXIkX83n+/nHRjiOJPUxatX6od/XZJBJpo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964546; c=relaxed/simple;
	bh=SaDOvD86LLv7c/iSJyHwBOYgTk0Ktp2/QVNS1nuUjKk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dDLzImQv7NkZ/dk8GHYgm8/u8gt64o4ZXThg6DLCSKru/6OBooVuizyqCnpP4z7uh8wtrcBF+XXBSH4ZDi45lfBlSPYnQlcBwfnpjNjkmdQ/zAjGAjIUxNj/QAE++c3kvwJN+9eh7b7vuJKOEdR8N1Fm1djMjaqZAbbM/PBY7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggpgnk+q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nGwC/org; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767964543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=15JyQ+VnqINRMwrw8AIegPn8BzaxzgODQQRF2S98B5Y=;
	b=ggpgnk+q2DDf81K/CUrCccRN52YY7U8YqTElLhCW8r1WNxL+XKaHZbDjftmmJT7+ZGNRlI
	bZWXddKREB3DtuGAfN25LIAj/Txer1kjmjmxNYkveDyqfznUfYakswJu93qJ5aS1Mn45Uu
	nII8HjNa2uVB82wGXieuMCAADZJGMq0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-SsZAqdv5PrG1FFcNwJZiww-1; Fri, 09 Jan 2026 08:15:42 -0500
X-MC-Unique: SsZAqdv5PrG1FFcNwJZiww-1
X-Mimecast-MFC-AGG-ID: SsZAqdv5PrG1FFcNwJZiww_1767964541
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b802d6ed5b0so901616366b.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 05:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767964541; x=1768569341; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15JyQ+VnqINRMwrw8AIegPn8BzaxzgODQQRF2S98B5Y=;
        b=nGwC/orgqNt9zs7LKPPMUtRbLfx5hJsmty0nGr84XUyw07cwB+eSKZCl4LhfIkw7sr
         VLd6XXKRUZevI6yAUOyd3MwH64t7R5Y3l/AbQH1n2zpv+l7F2iwFx2arAPdQgddMp4nf
         ASxAGcJZUTom7VEhr/PgpIv7lS5vJo9AEQmtGCMVfZ6wUsJZO6Pb8jWaOQh9I7eQYOXT
         51eY/y7NafBmEatRFAocDVFApMHibAY0RZa2CtNCgwWZBxUs5WZuPrpWqUA5AC0Pzu8Z
         5Qpv02e/5sUtBGiZm5/bJe4Z0uVdZBqcDJIZG2G8rllamlP/D8cdMCW4uEvDaR2KT+4a
         qwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964541; x=1768569341;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15JyQ+VnqINRMwrw8AIegPn8BzaxzgODQQRF2S98B5Y=;
        b=JMN0lfTlUEGcHl18VNaLg0xWUdZIi4NX8B29XJ7jK0MbkFBK22sVdnxUlVQZcNwp+Z
         hxn/jgWr73eIzZAiT8ZCVu2hNhoc68DtlEcYRACem2rAj3eLN1tMxc04IwPPUNBW+1Iy
         fdX/4RDM/IUENUictp2bSbeQoCyyB4KPLAY6OpruSwovLzC8aTFWBFYEwDNyO0VHHXUC
         2/6r/PIJ/MjjbRDnLpkglem0aLgO2O8qlexX7I3tTKCx6MTQSjlvfK5nUP+LapozEKQy
         C82bY/+cuusvLZD7jDn7mlnfRy0LJDJUcnv/pwf3Ux4+2XM4o0lt4YzinfccUshe6lz/
         hyfA==
X-Forwarded-Encrypted: i=1; AJvYcCUf8miDeShUeb2EL+JdVjxIXRTmkDlYPmrYOirGgcXWdIJab8P+4q0/X/ij4G6o9Rs0z6qPH64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFu3fc9pFf3AT6z9nq6DoeBSu9/tpoWVEMWegVhWRr1JJ/Tr4
	6B17tIXXt063jFYa8DCTI33vqmq8ebkmUdYq2lhUhMkIig1N1hDoh9BVX30Jc6rxmRdMGOrr+DS
	gzviiJirBAxpOL5kogVNtvblPdVT2fN8HDsWPil3FdsNktgYg2qbWdPAg/Q==
X-Gm-Gg: AY/fxX7TxvP/yAUvNUW+nDSX7hWrydt836678j9ri03dnfx5NDlG8QslP1jifqEBppU
	O7eyzb6gYzs9/+gq23o0hYPq4Zby+744crAPKP65xa1mKCnSbFfKtyCqnpYSdJDmwcWXsCUx4yb
	pRcDBiS+L4UfKp/CSOFa/HqZN5Bm81Y3gCkIFX8UWOqPczJaVN6BxT/icu2ct92ggyGXlaxGwNa
	6kOYGPLwfVJXjrW2iqn+a89i3thdiVukp4I58YcuVb1KS/GpmYBaS3X50Or0XZc91R586am+WEj
	f+v+RxEC4rK5V0EXE8Cn/3JF7Nzk5inB1ul1ZxPhTPQ5HoU593Q6BxMFboJiLRXg8FDhyRCl/f+
	l+i7GowBwCSyDAOBtrgrU/b5zbvkGG278e2/u
X-Received: by 2002:a17:907:7801:b0:b73:1b97:5ddd with SMTP id a640c23a62f3a-b84298aaaf7mr977871666b.8.1767964540825;
        Fri, 09 Jan 2026 05:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXfD6hIS3yvZXrfPZ431q2UaPCz5Fvv5DwOUzo2N/PV5cXgjJXOX9oac+kNdKm+4+4JtHfjA==
X-Received: by 2002:a17:907:7801:b0:b73:1b97:5ddd with SMTP id a640c23a62f3a-b84298aaaf7mr977868166b.8.1767964540306;
        Fri, 09 Jan 2026 05:15:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a563f73sm1162052666b.61.2026.01.09.05.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:15:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1FAFE40862B; Fri, 09 Jan 2026 14:15:38 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v8 0/6] Multi-queue aware sch_cake
Date: Fri, 09 Jan 2026 14:15:29 +0100
Message-Id: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHH/YGkC/3XRwU7DMAwG4FdBORNkp0nacEJC4gG4Ig5J7LAIr
 WNtmYamvTtZEVDUcLR++7Nkn8TIQ+ZR3F6dxMCHPOZdX4ru+krEje9fWGYqtVCgDDhQcruX0b+
 yHN+D3FMeo4yUIBhHKrERZe5t4JSPs/kkep5kz8dJPJdkk8dpN3zMyx4f7ueGL1jpCnxACVI3H
 iwQIip/NzBt/HQTd9vZO+APUeJ/Ca9SQvJBd11aEWpJtDVCFUJpcuwJdBvcimgWRAM1oimESdZ
 GozuOFFeE/iUUYI3QFwKIGoXoMdoVYb4JCwimRphCdN654CiA4TVhl4StEbYQzIrBBuSA64+0S
 6KrEe3lqRysNgk0ur+3OJ/Pn0cBkXeTAgAA
X-Change-ID: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Victor Nogueira <victor@mojatatu.com>
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

- Patch 6 adds selftests for cake_mq

A patch to iproute2 to make it aware of the cake_mq qdisc were submitted
separately with a previous patch version:

https://lore.kernel.org/r/20260105162902.1432940-1-toke@redhat.com

---
Changes in v8:
- Use right attribute in netlink extact error
- Use kzalloc(sizeof(*q)) instead of kzalloc(sizeof(struct cake_sched_config))
- Link to v7: https://lore.kernel.org/r/20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com

Changes in v7:
- Use kzalloc() instead of kvcalloc(1, ...)
- Add missing SoB to last patch
- Add new include/linux/sch_priv.h header file to MAINTAINERS entry for TC
- Link to v6: https://lore.kernel.org/r/20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com

Changes in v6:
- Add missing teardown command in last selftest
- Link to v5: https://lore.kernel.org/r/20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com

Changes in v5:
- Disallow using autorate-ingress with cake_mq
- Lock each child in cake_mq_change() instead of the parent
- Move mq exports into its own header file and export them with EXPORT_SYMBOL_NS_GPL
- Add selftests
- Link to v4: https://lore.kernel.org/r/20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com

Changes in v4:
- A bunch of bot nits:
 - Fix null pointer deref in cake_destroy()
 - Unwind qdisc registration on failure
 - Use rcu_dereference() instead of rtnl_dereference() in data path
 - Use WRITE_ONCE() for q->last_active
 - Store num_active_qs to stats value after computing it
- Link to v3: https://lore.kernel.org/r/20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com

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
Jonas Köppeler (2):
      net/sched: sch_cake: share shaper state across sub-instances of cake_mq
      selftests/tc-testing: add selftests for cake_mq qdisc

Toke Høiland-Jørgensen (4):
      net/sched: Export mq functions for reuse
      net/sched: sch_cake: Factor out config variables into separate struct
      net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
      net/sched: sch_cake: Share config across cake_mq sub-qdiscs

 Documentation/netlink/specs/tc.yaml                |   3 +
 MAINTAINERS                                        |   1 +
 include/net/sch_priv.h                             |  27 +
 include/uapi/linux/pkt_sched.h                     |   1 +
 net/sched/sch_cake.c                               | 514 ++++++++++++++-----
 net/sched/sch_mq.c                                 |  71 ++-
 .../tc-testing/tc-tests/qdiscs/cake_mq.json        | 559 +++++++++++++++++++++
 7 files changed, 1018 insertions(+), 158 deletions(-)
---
base-commit: 76de4e1594b7dfacba549e9db60585811f45dbe5
change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5


