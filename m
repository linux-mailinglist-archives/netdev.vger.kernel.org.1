Return-Path: <netdev+bounces-286099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHNpL/+r/mkyuwAAu9opvQ
	(envelope-from <netdev+bounces-286099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:37:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EAD4FDECA
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 05:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4118C301A719
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 03:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7BC2773CC;
	Sat,  9 May 2026 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV5AdORR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E526F2AF
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297651; cv=none; b=AG5XmatU3BAkiCO6l9rdv1QFJ0VdMm9/FEE4LIG1RGFORBxGEV1zuKK6cinQpIcaD+cmmy/oa0soE/LTJ7XvEv0chpaZUEnCTnvgEd58+vkdXQdeAbuuhIxyajgHGkdSWsS6VfKyajjXfcG18UAvllK5nYM+gC8bICSynEfm97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297651; c=relaxed/simple;
	bh=cXevIfbUSHqn716AiDdT7MaouEyfEA0qJBNM8IlSrPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UvdmQj42rAYC1OxybRd7lNEUF0pUob+klkyN+W2Ka2ZsN3q1HG9i/Qt7mgN0u+r84QYsSCLZb+wryIaDp4WzE1ml2ThrbC/RBCRUMAnDX7adSAr7ZG+ry5NeLprDvCrH40WyIjVvwmN9B40WTV2/DAjCJc/jkxRa2MZrRA3Xb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV5AdORR; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12db2e415a7so1910507c88.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 20:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778297649; x=1778902449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIMe968W1nU8utrDNXsU9iMxX8qEy/PIhdpRfidl2gs=;
        b=PV5AdORR4tDbdpEzFy0OITbed9dh94KQNo0oM3ZJf94QX01dl4ENvwF7jiaHAyx6kU
         ft9zkKsj61Ygixwf9yJyndO1XHHK8ILplZpl1p0ovItAz9qDX9pQwUSDGyAhBNJqDHiL
         ENEno0FCH6raNEKpoZ1SVEh2phzdakoQeHgpoAFKHD/At2mpp/isjmuA1nWgALenJ+fK
         ELtq0WABZvwhrVqVy3lT0dAcpe9KxCIumvcHYfAGUK5uLgNVo+bUyOlIwkB/Iu4W0i6f
         M5UDATAUwekw7VINNmUx6HdY5iJ4NGElWb/2QWIoBkBvyjv3jmaf4ifnqUtgTPHPHwac
         p7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778297649; x=1778902449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIMe968W1nU8utrDNXsU9iMxX8qEy/PIhdpRfidl2gs=;
        b=cfFz1Gs4uuKdfYWNp2ss5F8k6YFHf4Z5jNBSARfe+Hl7vwev5BidtXcX6uTqHpTfbZ
         80mvxwocLN/+PTCTKYqPoonsg+VY888Fe/C+ichXv5KgI9+ChBp6TXTu7fT3iRUq4Btd
         0ZNu3XgsqFkxJiU9sw+QI2CMEdVqpteaAa3v+tgqJ9581E2FpS6Wzk3v7jH69M0pmKo4
         ujsgTL1xAutPeL8KsGrBW4go1r7cSZm1RL3kKhtaismGquZZI7VUfaXNuJheBR9Nhv/B
         r1cmX+NEGW+HOBTj5X8IJITgXO7G5T2bh4Sl29SV0pRbzzA0mmJKg0f9skDOuC9MqHpa
         31zg==
X-Gm-Message-State: AOJu0Ywr+sGtTgla7JvUploPXRM5xWACgM1oGLrIJhO8Zxq267RDwry6
	6sG4GvXJIOBGFA+QHDWrfaALMBIDiBticNtqTO1TOFUdbgM99fzfbIrp
X-Gm-Gg: AeBDiev7+yBEQ7Nhh+53GBQgyl9xtnlNimtwIxPRb19sAyssG7MGaktiWDQZJfZiJNB
	ZkgW53aS9tIzn7mtcqFCkhy91qSp3mDLv0rWNVlWxECuUcYR+Zi+xvdPhjHCXpwdkb0KFcRK1Ua
	07rttO8o3wcww7uob9TMEBvLIkmPTdwd4LV+dqSuG+q1cmUMbJV0fI1U4ngHoKptRQo7KLDGFfe
	kd7tzQSxynPm1OTAXmPicVrorFYN7ce6+MJvlRc69ZlhxWApagcPICK9lssw5bJuaAbAwNHWGaq
	jh0bhPGh/DitZkiI4JDOOy0Hv+xtPNwm0rlrX8zy3QWGiLVFDh+vTSOXavNmt6sldnbNshi3ZPD
	Kx/jypyh8KDghpPwfbcmLkQP4V2kSRnasl6NFDzSZ7tvz9fXddq4XeVvpDDXqIRzHZXndC+0+yK
	MlZKPaKfjS4yWR3kQyhJBPd+BJjTnmQGrFLPel23tPnUFuhw==
X-Received: by 2002:a05:7022:50f:b0:127:366f:8bb7 with SMTP id a92af1059eb24-1319cf570a0mr7697097c88.25.1778297648923;
        Fri, 08 May 2026 20:34:08 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fc59sm5500989c88.7.2026.05.08.20.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 20:34:08 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hannes@stressinduktion.org,
	albinwyang@tencent.com,
	shenyangyang4@huawei.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH net v3 0/3] macsec: use rcu_work to fix crypto cleanup in softirq context
Date: Sat,  9 May 2026 11:33:44 +0800
Message-ID: <20260509033353.1814289-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20EAD4FDECA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286099-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

From: Jinliang Zheng <alexjlzheng@tencent.com>

crypto_free_aead() can internally call vunmap() (e.g. via dma_free_attrs()
in hardware crypto drivers like hisi_sec2), which must not be invoked from
softirq context. Both free_rxsa() and free_txsa() are RCU callbacks that
run in softirq, causing a kernel crash on affected hardware.

This series fixes the issue by deferring the actual cleanup to a workqueue
using rcu_work, which combines the RCU grace period and workqueue dispatch
into a single primitive.

Two design decisions worth noting:

1. rcu_work instead of schedule_work() + synchronize_rcu()

   An alternative would be to call schedule_work() directly from
   macsec_rxsa_put()/macsec_txsa_put(), then call synchronize_rcu() at
   the start of the work handler to replace the grace period previously
   provided by call_rcu(). However, synchronize_rcu() blocks the worker
   thread for the duration of a full RCU grace period. Under high SA
   churn (e.g. tearing down an interface with many SAs), each SA would
   occupy a worker thread while waiting, and multiple concurrent calls
   cannot share the same grace period — leading to unnecessary latency
   and resource waste.

   rcu_work uses call_rcu_hurry() internally, which is fully asynchronous:
   the worker thread is only dispatched after the grace period has elapsed,
   and multiple concurrent queue_rcu_work() calls naturally batch under the
   same grace period via the RCU subsystem's existing coalescing mechanism.

2. Dedicated workqueue instead of system_wq

   Using a dedicated workqueue (macsec_wq) allows macsec_exit() to drain
   exactly the work items belonging to this module — by calling
   destroy_workqueue() after rcu_barrier(). If system_wq were used,
   flush_scheduled_work() would drain all pending work items across the
   entire system, creating unnecessary coupling with unrelated subsystems
   and potentially causing unexpected delays. The dedicated workqueue
   provides a clean, contained teardown path.

Changes in v3:
- Add rcu_barrier() before destroy_workqueue() in the error path of
  macsec_init() as a precaution, mirroring macsec_exit() to stay safe
  if work ever becomes queueable earlier (suggested by Jakub Kicinski)
- Rename error labels in macsec_init() from resource-named style
  (rtnl:, notifier:, wq:) to err_xxx: style (suggested by Jakub Kicinski)
- Add kdoc for the new destroy_work field in struct macsec_rx_sa and
  struct macsec_tx_sa (suggested by Jakub Kicinski)

Changes in v2:
- Use rcu_work instead of work_struct to avoid the manual RCU callback
  wrapper (suggested by Kuniyuki Iwashima)
- Introduce a dedicated workqueue and drain it properly in macsec_exit()
  to prevent potential crash on module unload (noted by Sabrina Dubroca)
- Extend the fix to TX SAs, which suffer from the same issue
  (noted by Sabrina Dubroca)
- Add Fixes tag (noted by Sabrina Dubroca)
- Split into three patches

Thanks to Jakub Kicinski, Kuniyuki Iwashima, and Sabrina Dubroca for
the review.

Link: https://lore.kernel.org/netdev/20260506100107.388184-1-alexjlzheng@tencent.com/T/#u
Link: https://lore.kernel.org/netdev/20260509020054.1792674-1-alexjlzheng@tencent.com/T/#u

Jinliang Zheng (3):
  macsec: introduce dedicated workqueue for SA crypto cleanup
  macsec: use rcu_work to defer RX SA crypto cleanup out of softirq
  macsec: use rcu_work to defer TX SA crypto cleanup out of softirq

 drivers/net/macsec.c | 39 ++++++++++++++++++++++++++++-----------
 include/net/macsec.h |  7 +++++--
 2 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.39.3


