Return-Path: <netdev+bounces-131257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E19698DE84
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088CB1F216D3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9111D04A8;
	Wed,  2 Oct 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXabvUvF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34011D0493
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881944; cv=none; b=rUn7ZnoVjRlkqPtqS/XEfF7TrhNIq2Iujt3LU6hpK6dQPF8OF7SOh0RSxy0zPU8cB0LHWY0xgDBA8kuu5Jtj3aJYRcZ9OTi8D9K3tIubOqhZ2i61zk+3tk6Fzy7mScohy/sAwWRbeiaTtKih4KDPTUtzCN+5FwHvrOIz8Xg1S3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881944; c=relaxed/simple;
	bh=WNToeL92DAf/oMJWTk4/mjIodrQRw3ESOu7iSXHXBqs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XCYYVogcQKi4qtpBKkmKCcaAWJohzaFjk5fRiaiLiPWH+CXy2NzHlHm6txDk+DFHCQGitowX8AUHNJU13MxRVBPR03e6hSZDH+9T7ZIwihay/cWaYJ2A5S1N3FiLquVd7NxqvhUXjneGxpp/tyQHILHA4EOH+ybU4gBwWuOA9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXabvUvF; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-458353d3635so19139191cf.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727881941; x=1728486741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eWKtyFw6J+/jTqB56CuYeiR6QuknNml4caFcNma8IoA=;
        b=EXabvUvFyNlUxg21Ihaout4WxoM9yMraNcBAMdUhj6+yyZzj3uSVqDQsJ1RC2TYBGR
         T+TlKLMd0mR7meDvQJvmftJ0J+SQczTrt4zEB9RlrPwUATpsSHWJxaFnF9sBfXes68mA
         Vni2LYMOF95lfoPIV8l0qkOrf6+SqNuQ8umfnbySygyBObVROHOSDteimhIDWDL7yhte
         M4OBGeDgQD41ungn2YmDPFcc0n7Iqamyl0qDb+YNOmuHz8ipDQsGOfoVgcZVfHx5I8OG
         4y+1V9I0QXyPiho715qCW+4gH2LrUgqfGk8WPS9F2HoJLbPrc/ytVqyIKxxMTulKHPKA
         fV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881941; x=1728486741;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWKtyFw6J+/jTqB56CuYeiR6QuknNml4caFcNma8IoA=;
        b=dR4vygVbm5AdIvY6z1QZH0oHRXYfQKWhB04dSWdCIW4bDY7chIlhDloCFgp0WobozR
         QACDRAGIW2gWjB+X5XsDXDdDwWp8S2tOGww/CHcHyttsEgWQNGib6fi8di9rWcXw7MQe
         df1g1VtjtDhdS6kDerIwIvavThdkbU3vWncXF4SSD4GrozlsJcJUnwGZhCFr+ZB0qWRg
         clOy1aDTl3osCL5ty3R29pxJDc5LSUJyv4x8K6LnXMKdaeiudzKHysi8DOC9PEwcg8WB
         iumUuj6FDyteOEX0vCNYaV6JFFvvmKgZ0IeHeugEXeLCrFWcyiZM4u1Ns18DFDZ2NJhk
         ojAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHwnPxm5NxeSZz9UrtsI/zN/1SSrTTJsmViGWrEE0799p3IUpg10HhtIfnkix/0STfT+NITD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzC3Fzpz1ktX03HWHxJ6prR002PkBHSYIbuyet9l6ff4A3splH
	jpMcQcPnVLBPtrqmJ2zKYkp5cqxDEaEf1NFNVb6HdmlYwe4i2aaghrQKppZkcQ4E8z9c3LPa47Y
	hbWpPAri93A==
X-Google-Smtp-Source: AGHT+IHiyZtNZup5mbZpHOZriifupw4SWe2rP2W2S83D0DR44jvpdybD3z+o3Ofjd4Yic02ObYMY4V0sdC5mNw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:622a:190e:b0:447:dd07:8410 with SMTP
 id d75a77b69052e-45d73b0fd11mr69431cf.6.1727881941574; Wed, 02 Oct 2024
 08:12:21 -0700 (PDT)
Date: Wed,  2 Oct 2024 15:12:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002151220.349571-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/2] net: prepare pacing offload support
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jeffrey Ji <jeffreyji@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some network devices have the ability to offload EDT (Earliest
Departure Time) which is the model used for TCP pacing and FQ
packet scheduler.

Some of them implement the timing wheel mechanism described in
https://saeed.github.io/files/carousel-sigcomm17.pdf
with an associated 'timing wheel horizon'.

In order to upstream the NIC support, this series adds :

1) timing wheel horizon as a per-device attribute.

2) FQ packet scheduler support, to let paced packets
   below the timing wheel horizon be handled by the driver.

v2: addressed Jakub feedback
   ( https://lore.kernel.org/netdev/20240930152304.472767-2-edumazet@google.com/T/#mf6294d714c41cc459962154cc2580ce3c9693663 )

Eric Dumazet (1):
  net: add IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute

Jeffrey Ji (1):
  net_sched: sch_fq: add the ability to offload pacing

 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  4 +++
 include/uapi/linux/if_link.h                  |  1 +
 include/uapi/linux/pkt_sched.h                |  2 ++
 net/core/rtnetlink.c                          |  4 +++
 net/sched/sch_fq.c                            | 33 +++++++++++++++----
 tools/include/uapi/linux/if_link.h            |  1 +
 7 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


