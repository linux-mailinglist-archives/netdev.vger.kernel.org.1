Return-Path: <netdev+bounces-286562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCE7JLqkAWq+hAEAu9opvQ
	(envelope-from <netdev+bounces-286562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:43:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9925150B2C8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FDF6301ADB9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDCA3BD63D;
	Mon, 11 May 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WfiYQNAi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A73B9D9F
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491740; cv=none; b=U42HteUd+ydvghHav7QoH3qza6hgGmrwE9PMdzMamrWb5TWy9QueVLqWXu46jGCeFxeMNs6+nfM9nEwMvLQQLeEuuJdtk+6d3OaGnNR3nzWsntug6bcwbiEfjR3eN1cu1IhUfKU9mAmQ9mswExGEMPzbmpQ2sHa/fYwqaEOAau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491740; c=relaxed/simple;
	bh=1iE0KxkHqOHOmUaBdxFzx30RUnoGkOPdUPCC8zY2qWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g7jwQiUVrGSxNKfFss4NWqs5+Jq8Qh3dllpGv+PW0egRtrF6Va14YSaCif/0UHENJBzqt9FMBBbLp9g9G2+vcvNwtQwT28B0roIgyLmLyZ8KqZWkBT3iL+HJ1gb0mzbddhamyNvT126Ccl0gDTqqf+cF65ttOxcE2kErGBx5YEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WfiYQNAi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so40151485e9.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778491737; x=1779096537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zm1633wFLnkrneV2WvzS0oBtJ0Em/RfGVMdTUWbdPDU=;
        b=WfiYQNAiJAGw/8GrrgI1NSoYaqgqYntn5SHLOyHXdEWjx6cpZAQVoHqI4I2AEsPzrq
         TkxVfYxESArCt4rlSz2zmHrBH+xyaxppjFrN/csuyiw7AYVNGHgzTsk0yaW9wGx6bSgU
         MSMrXE6jK8FrqLxFkiuwXJ2IbbA49A1ccevD0GlahZlPFD6CgbnpMTaOQoRXmBZEBu+A
         +f0lN6yqXfjyGAcyWwB1kqo6gPcFiP7p/ebOqTe7VF5BEZsreMSRZVRslVXk2kcTYIgA
         Q3GZEwDr5/qkqzfMFpXNUtwuiQtG+MybKBWs5m0XnoK0EqGtoeUYrKLR3U1a762O+jgg
         9HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491737; x=1779096537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm1633wFLnkrneV2WvzS0oBtJ0Em/RfGVMdTUWbdPDU=;
        b=Fzjgnyuk8XoYI2M6h0nJcZu/SwT4IZQYHsSNS8Ou33t7bXS0nRn9U0U7Bo+Svqq6ir
         6i+kI174M2bJLAKaMKgPo0KEkSOmkBrDryeSUdYKiLAY89U+jAZBIiF7P494C1RsNT1w
         xviF74aEkXsymNfLdfVhy64LXaS0YDlTaECExdcbGgPEDhz8p7j2NnP30hKAAwg9/SzR
         ANNztK+95fJMcv8VeSR3goyJzkV3zZu/fGcCjQOOxtNgHwK73ZRp5UhNdWYyo20Gyke+
         prazC0DsdWOacihUGyQ5hXAaGGjj1+N2SX0PWw+1DKNfjhpNzLMKdiLKEXeZEOnAjVz+
         Pbtw==
X-Forwarded-Encrypted: i=1; AFNElJ8c6FxslWxwiftHPiLbT4wzVsQYWqMnzyd1EdxY8veSwcc7/nuhleSKoKickd7leAbrJpurszo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOSWR9iJZ0mpTj59sZT7qwgFH0HIbfQa+0YanT8GSxmWoEPdxe
	JXXtNSgsk+DEtKS/21JcO1wS2/ZgUN3Ju2p/m0pkJsB+SsLIzTrmNiQhmvE3BXVBkwo=
X-Gm-Gg: Acq92OEQ81WJmI3zb0YkgwENQCtrnhfUXV6BZV9rA8mHcN1OS3UGj0Xl4ScRdmbcgox
	LuyB/Vyv3BvTdoeQizF1SfHijyEwPcgP1wSqmtgMhortI6Pt9Sw6l2CakOSunB9KuCTySLj6TOs
	FRzDsn69cSkt6NBugyzPf6l6RaiiKIm+4QfBWlbUQIwGxOWeqz1MAU2HyOXxKcPZOSUGYaVaQJK
	TheLaRSq0A8cTRhazlvCxjh9/9oCSzzuiaGEjjbCgx4Crm92PhPGNB6vjp0acwJVxBkF3PZXW4c
	zD1FMh6ktvMjoZIYVnn/PdXM+W5jEiiTpcq7QjDuMahr6tXYnbTiwYlzzdH56pgxaXf9DJCheLj
	mmc2DwNprl5vCNexMHpqMF432l8vBaGESEW5ACJn2yVcHvJiM9XTGL0youucCotSAJhLH6QSYHr
	5gKcVLVh9skd1hHnsORJyArjo5+Q9TwXp+f6NR3P92Sozsuag=
X-Received: by 2002:a05:600c:b8d:b0:48e:706b:53e3 with SMTP id 5b1f17b1804b1-48e706b556bmr144977005e9.1.1778491736872;
        Mon, 11 May 2026 02:28:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e701e89fbsm157606675e9.4.2026.05.11.02.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:28:56 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mika Westerberg <westeri@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Roger Quadros <rogerq@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [RFC PATCH net-next 0/5] net: Move system_long_wq to system_dfl_long_wq
Date: Mon, 11 May 2026 11:28:35 +0200
Message-ID: <20260511092846.120141-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9925150B2C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.ibm.com,ti.com,ellerman.id.au,nucleusys.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

Hello,

Currently the code uses the per-cpu workqueue system_long_wq to schedule
long running works.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Another good reason to have this unbound,
is the "queue_delayed_work()" function, used to enqueue the work item.
More details on this will follow in the next section.

Recently, a new unbound workqueue specific for long running work has been
added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

~~~ Details about queue_delayed_work ~~~

system_long_wq is a per-cpu workqueue and it is used as a parameter of
queue_delayed_work(). This function schedule an item that it will later
be enqueued (once the timer will fire). __queue_delayed_work() does the job
receiving as "cpu" WORK_CPU_UNBOUND:

    if (housekeeping_enabled(HK_TYPE_TIMER)) {
    //      [....]
    } else {
            if (likely(cpu == WORK_CPU_UNBOUND))
                    add_timer_global(timer);
            else
                    add_timer_on(timer, cpu);
    }

The timer is global, so can fire everywhere, and the work item will be
enqueued where the timer fired.

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change the
workqueue with the new system_dfl_long_wq, so that the used workqueue is
now unbound and can benefit from scheduler task placement.

Thanks!

Marco Crivellari (5):
  ibmvnic: Move long delayed work on system_dfl_long_wq
  net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
  net: thunderbolt: Move long delayed work on system_dfl_long_wq
  net: usb: pegasus: Move long delayed work on system_dfl_long_wq
  r8152: Move long delayed work on system_dfl_long_wq

 drivers/net/ethernet/ibm/ibmvnic.c          | 4 ++--
 drivers/net/ethernet/ti/icssg/icssg_stats.c | 2 +-
 drivers/net/thunderbolt/main.c              | 7 ++++---
 drivers/net/usb/pegasus.c                   | 9 +++++----
 drivers/net/usb/r8152.c                     | 7 ++++---
 5 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.54.0


