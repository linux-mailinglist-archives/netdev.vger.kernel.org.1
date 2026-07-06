Return-Path: <netdev+bounces-305056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VwIFNY3LS2qiaQEAu9opvQ
	(envelope-from <netdev+bounces-305056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:36:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A2712AEF
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:36:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=BeB2Gime;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305056-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305056-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33D2A3127A55
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62B33A9E9;
	Mon,  6 Jul 2026 13:40:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE24637206E
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:40:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345244; cv=none; b=deiDdurOalM/lYVd1nOWz6vBUnjsSW5xv5Z/hfbWRhjBNOJJarJZdNqmXsMjTQs9AqrOjEd/fJPcgfMVvBz7A3NbC0Ee813SjbZIjNdDx/HnhF9vRky8W84XBgMeqi+dhp5lfU0/Z3X7L4NCkdFkLgX+7MmaNbOsUFpzNeD6h9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345244; c=relaxed/simple;
	bh=0+RWQWSA13FX6pe7N5CQ3naJhVnVEXib4aGb8pU1d0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKjLV0ll3Xw9/s60Zc9UnASWKMHfH8cCo89bnBbMKFaPsnsvTbE6kDennz7Uwm+B+OqusNaSA+uWUURGv/fI4aepD0SvXcsYbPXZ9N2JaVF03XZbhaSaIwXquILosdMo5gLoB8AcNI4t97CkMIgZlaXCy3VU77ElcIrqEKP6tEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BeB2Gime; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4759b4f0897so1286227f8f.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783345241; x=1783950041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hm+LDMnXUOOt907y7W2ahajiogOgrWflUu1E8MxtMXI=;
        b=BeB2GimepWEc8U+PhLgJKNJUYkRg/Lh3dYjc4S9m/EJGMd09hU2Saok48yr5/d8yHm
         dvz+TzcZ6bZu7I4TnUazdoBqEOOF0L4B9FcfHd4jg+mLyIN1oDvYD6mcDbdJ5zv7B3w8
         Tust4SmDKCkSz6N9c6W+dr5A8fsX+gOmKuF24zN+ucyfcq6FlYj7jaJM83KnWKZnz9cb
         pNgJ3EEmnavlcIKG6y3YHhPEDv3lbjbR7wvl6ZG9m4Pl8d4eOKBWA1sMBoKtSZ1Lc++T
         0J0iE72CAobRIwR3BFQH2mpKXttebpWsWiIg4XOHJxfX1jq4cxtblpabrvIjdgwpiUOv
         kxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345241; x=1783950041;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hm+LDMnXUOOt907y7W2ahajiogOgrWflUu1E8MxtMXI=;
        b=PwscFUsnXqecqIDXPtbQBnPbWZ1xGy0Tb3M4n0aSzpb0NCauVgZOuHhFHcl3UnM7CC
         3TP3RY4xNmlzrFkHKevKJJoDxlW7kgBQByENyDPCSzo82VhI8IjM49lUvWGBCsn4oCdi
         vkngZOV79+tPv/gSBBWJdqIQKJAFfFIESd8XhJ/LZ/nmMarXEBLgzkEzDu4kV8iI3uyJ
         5dPJ9agPqYecwN+jaDWUStnY/taPlv4zzPrYypndzm7k0RqCil9ANeiB39chhQvXeAe6
         kBn3i1QpoEiTzZ1LXBjbXCz9Z7m0yZpiExm8ZUVdh5NLMc+onmtQEgxRf4tEoVlypony
         haLg==
X-Forwarded-Encrypted: i=1; AHgh+RoakVcV5hu6edQlpTHcJzhzqvIOoBRGwxKp3+qF+GPcJE78/iDJ8rLFJe5A16mYtCGegaASkTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1Z5ujWUEy5C/XftDcO0gkrpjl1UfBOIwdZM9qakhqFBPMKL1
	ME+ZhYP/lZchMdN212cDy+7hEelSZV2jAXPJ+EwS1qF2hYqm55PbbYMRtht3kMnLqBe0RH35a8l
	+SY85KwM=
X-Gm-Gg: AfdE7clnWDGFXZ8o0KAKiEZ7WpjpnHozqpDTTVuPImkm5Vhf7G/SKft9STknRU0qxTt
	KS5XaPikvZU2jllYcr2XeXCduw4zPlFoHZ0zyeoiCaX4mHFtdtPh89mKR3wVLtiYjBm0Z4+1kv8
	BsGIPr6dwL3EVQp859FrtkwO2pCRvDDOlp5bjFF6G0bmwk75siSYhy9CiPuj0xKQ9Bhm1NgFfj/
	vNd8v2owntodQ0v9FM1LQWFiebr/j84vOlm794jivAIrkcPkSE6oVQLqEvuJsFSG2Fg3rPGsAbQ
	FGFP+xlRWxhYeqMQQVeA/SvRb8a/yqTNCyAKkO32w0/4c96UkOacK0CAvuRCWBI91+ZlLy/A804
	pklxjeD6GackAtutOOexZEFzgGETHrhRzuhwzdETkiYbGw3OUT9JSlk/k2G+GDgAzmggcGLQwuu
	A+CdeDDTFbJB01mvH2EsphvQVKtP4yUsyYooo=
X-Received: by 2002:adf:e003:0:10b0:475:f0f0:9ece with SMTP id ffacd0b85a97d-47de6723b2emr155297f8f.57.1783345241288;
        Mon, 06 Jul 2026 06:40:41 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm24424868f8f.33.2026.07.06.06.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:40:41 -0700 (PDT)
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
	Richard Cheng <icheng@nvidia.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Roger Quadros <rogerq@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH net-next v2 0/5] net: Move system_long_wq to system_dfl_long_wq
Date: Mon,  6 Jul 2026 15:40:23 +0200
Message-ID: <20260706134033.244295-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.ibm.com,ti.com,ellerman.id.au,nucleusys.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-305056-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:marco.crivellari@suse.com,m:mhocko@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:enelsonmoore@gmail.com,m:haren@linux.ibm.com,m:maddy@linux.ibm.com,m:danishanwar@ti.com,m:mpe@ellerman.id.au,m:westeri@kernel.org,m:npiggin@gmail.com,m:nnac123@linux.ibm.com,m:petkan@nucleusys.com,m:icheng@nvidia.com,m:ricklind@linux.ibm.com,m:rogerq@kernel.org,m:YehezkelShB@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:dkim,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 542A2712AEF

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

---
Changes in v2:
- rebased on v7.2-rc2

- dropped the RFC prefix, kept Ack and review tags

Link to v1: https://lore.kernel.org/all/20260511092846.120141-1-marco.crivellari@suse.com/

Marco Crivellari (5):
  ibmvnic: Move long delayed work on system_dfl_long_wq
  net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
  net: thunderbolt: Move long delayed work on system_dfl_long_wq
  net: usb: pegasus: Move long delayed work on system_dfl_long_wq
  net: usb: r8152: Move long delayed work on system_dfl_long_wq

 drivers/net/ethernet/ibm/ibmvnic.c          | 4 ++--
 drivers/net/ethernet/ti/icssg/icssg_stats.c | 2 +-
 drivers/net/thunderbolt/main.c              | 7 ++++---
 drivers/net/usb/pegasus.c                   | 9 +++++----
 drivers/net/usb/r8152.c                     | 7 ++++---
 5 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.54.0


