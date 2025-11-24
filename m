Return-Path: <netdev+bounces-241190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CADC8134F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4733A1C22
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFE42857F6;
	Mon, 24 Nov 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VstQoGm4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUcXaltJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D45168BD
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996448; cv=none; b=Xzwgfy2n92q0scXzosHLofHNQ8yZtgZaP4Npx2tOifilPPfmWrYfJrqG83cBIcFMLKj6FFW4Gej/q3c3GwdS/sY11GRZWRbOBgcAuNZzp5eMYlm7XfWwFZ3CahLUORT1kBQnbckpU+/Ed+g3MoulEytfVBgY83DQ/KkQN4bZZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996448; c=relaxed/simple;
	bh=sLVnETKE2CF5JNQhQKghnZ0w7GPsaVrRa8OCyb9bTJc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FdZy2ezoE7TNFyUfTOAYP4XHm5qbqN9YVPsG0Hq7T6PZ70eWAX34GJvfhlQXyxbh08m8vTeyu/zbRrpxtR7qzj+VwuQOTSObPMwB6hsFRFx1hnQheUiuQ3u3UG7zhAef0aqNjiXfblDO0ejG/kYqso+ajSnadnTZE4LMfN5uIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VstQoGm4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUcXaltJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763996445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=El6SYBg6qd6iWN4m7MYZIFgs+1l8f50f5tCtkjW7g5A=;
	b=VstQoGm4VEEFe40pxxuxxohOK6kB5218F91JrEov/MsUpiJAzwDNnq1Pz21R5c8jRFM8ir
	+49OhjyglfWXIBUUUjP5T8mjJwdUDEe5vlKyEmgASsdqKvqtEvyjR7MnINuZLzkg1s6KTY
	bbTSoSaq7psXsP62j+LaK1tBaMkuskI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-imxssUdMMx2XiNWNIE3wKg-1; Mon, 24 Nov 2025 10:00:44 -0500
X-MC-Unique: imxssUdMMx2XiNWNIE3wKg-1
X-Mimecast-MFC-AGG-ID: imxssUdMMx2XiNWNIE3wKg_1763996443
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b70bca184ccso586268066b.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763996442; x=1764601242; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=El6SYBg6qd6iWN4m7MYZIFgs+1l8f50f5tCtkjW7g5A=;
        b=BUcXaltJ8VDNUFeeMgg/DV7vI1HQiNNK5i5J9QRc7QtjX0XGdaa5fBF3QuFQqsmpIq
         wSu7OiBehbVjcr8srqsj2rHgFueXzR7tG8LWMG4pgwTFjJC0bARujjrQVNuTKxKRlQ8o
         dXYRIpfk5IYn6wKmJLenc5bN+C+cqsxNF/1RTW09szToqjh+bQF/ZQr3QhgLeZHn+85m
         H536X9rAPk0Zlz+EJyYJLTrBEYaEUHDe7ebjKor4i8E7lIsnT4cekafhqN0Is8NsxYQR
         iel6Xs4/Fv9lakeomuORZXav21gAKRDo+Nt4sQpENpHAkUNawSA7Ae2YENlt7rY2YhDW
         P8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996442; x=1764601242;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El6SYBg6qd6iWN4m7MYZIFgs+1l8f50f5tCtkjW7g5A=;
        b=O+mjCbZAvuim0QnC5s/ZZ7xauW0boliwwZHQpzoEjNS39mIT95iYAi5BNEBIWIECj4
         C7APKFz5Mer5gZhyD2imPU7CFfoX3xRVdTK9fXjF1wsYbpOi3UC1KQwHcvR9m5fqIkr2
         O+HINX5L2V5LlgJtHvkxj5MIo6Nf8yTinAcNiNeZVR0QZE113Js8uAGewWlb/envVOiJ
         cKm0uvpUZtVSg9MSykiG4MAXRmMVvGa2N05LV+FHBL0opbjrONXPUThIoal6wiWZ6SKH
         DX17a9FlREYshEVx5Kbo/gSdx3wwj6SYMrifJn+rZhsPAK6FCcTFzB8jT0QX7SGi2kvl
         3j6w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+7wzzBBHkAV8R5oYP5wBpkC50l3smN5lHq9KJ3ZzKwkIhYYZoc0w+G3LnnDkUAa6FbWnnFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyepXXlp/d3f9HQ6sI/dtyEZ6qNluoN73PVcfgEuz5JUtMEj+4
	jg2/gUvtrcYq0b6mMz8gcAgTQc7s1tDMeZVbcF302nw46CoMEr9jTMTUaEJOzp1FNhLY9YmWdwp
	8qZkaq3nGKUalf0uBC7B/n54IyuwAMX7VVNCKt4xcntZMtkPpi8tcVe3ZrXvjdr0Cjw==
X-Gm-Gg: ASbGnctW+1MaLrr7xhDsZkpo6v6I7Jlob7bFz10/aV5cZT5bsDHcokrkyt6JUkCBWkV
	T/E6wIen60YWTuIFWBPCFt7nusQZsj+zmBLG5QF2lS93IEuBZ1FQLhbjsTaRnfDmblF7k/oDApK
	OwMlPBaCBdaYJ/W4feEP2h+/ochpo9dWHPq33/AFl2AXIl52c/7qxF22fBhwuLoqFtn8A3Ap3g2
	3n85egzZUh5YaXH7tasipyero85JAbLyzbHnR0GHCxaQKYdC21KldE4BDWS9iq6XdUykArXFssI
	nnLQ/yWQs3AGjcogv7duDDkEwk0JdoJfQEP6Lh8TtlJWn2Ryay9ifdwIVnqmMrLRMl1KIn9IPbG
	52jdmmEOv/n7x9qtWHGGZ9N6xmZ12KDSkxSih
X-Received: by 2002:a17:906:a3c3:b0:b76:b921:d961 with SMTP id a640c23a62f3a-b76b9221db3mr114878766b.2.1763996440802;
        Mon, 24 Nov 2025 07:00:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5vmM5u+rlyhmXKD5DCgsBRHL1yjP6OiBGpiq/nnRCU4NCgpLN6BRViklpa4+O08204QTrzw==
X-Received: by 2002:a17:906:a3c3:b0:b76:b921:d961 with SMTP id a640c23a62f3a-b76b9221db3mr114872566b.2.1763996439876;
        Mon, 24 Nov 2025 07:00:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76550512d2sm1315316566b.67.2025.11.24.07.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:00:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 479F432A7FD; Mon, 24 Nov 2025 16:00:37 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next 0/4] Multi-queue aware sch_cake
Date: Mon, 24 Nov 2025 15:59:31 +0100
Message-Id: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANNyJGkC/22NQQ6CMBBFr0Jm7ZhpBRNceQ/CorSDTAxF2kowh
 Lvb4Nbly8t/f4PIQTjCrdgg8CJRJp9BnQqwg/EPRnGZQZOuqCaN44zWPBnju8PZSbRoXU9dVTv
 dcwV59wrcy3o0G/Cc0POaoM1mkJim8DnOFnX4X1eXf7qLQsLyYuhKTimlzT2wG0w622mEdt/3L
 51Cmfu9AAAA
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

Doing things this way does incur a bit of code duplication (reusing the
'mq' qdisc code), but it simplifies user configuration by centralising
all configuration through the cake_mq qdisc (which also serves as an
obvious way of opting into the multi-queue aware behaviour). The cake_mq
qdisc takes all the same configuration parameters as the cake qdisc.

An earlier version of this work was presented at this year's Netdevconf:
https://netdevconf.info/0x19/sessions/talk/mq-cake-scaling-software-rate-limiting-across-cpu-cores.html

The patch series is structured as follows:

- Patch 1 factors out the sch_cake configuration variables into a
  separate struct that can be shared between instances.

- Patch 2 adds the basic cake_mq qdisc, based on the mq code

- Patch 3 adds configuration sharing across the cake instances installed
  under cake_mq

- Patch 4 adds the shared shaper state that enables the multi-core rate
  shaping

A patch to iproute2 to make it aware of the cake_mq qdisc is included as
a separate patch as part of this series.

---
Changes since RFC:

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

Toke Høiland-Jørgensen (3):
      net/sched: sch_cake: Factor out config variables into separate struct
      net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
      net/sched: sch_cake: Share config across cake_mq sub-qdiscs

 Documentation/netlink/specs/tc.yaml |   3 +
 include/uapi/linux/pkt_sched.h      |   1 +
 net/sched/sch_cake.c                | 619 +++++++++++++++++++++++++++++-------
 3 files changed, 500 insertions(+), 123 deletions(-)
---
base-commit: e05021a829b834fecbd42b173e55382416571b2c
change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5


