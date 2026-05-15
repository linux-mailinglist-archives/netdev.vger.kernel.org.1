Return-Path: <netdev+bounces-288346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIlyEW47B2ottwIAu9opvQ
	(envelope-from <netdev+bounces-288346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:27:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086A5521E9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29DD33002917
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233049553C;
	Fri, 15 May 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EnfFGrzH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9103B6371
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858855; cv=none; b=XtZ/AyPbkELJtEdn6sSR6r1SfkbHT2S0almnaMhwZvyCeQAYl4AtfLg70WwJl5lztGHNFKOgD4Fy0BXff9To/7KOPVbdJ5C8Sb8tuQhRCnILImd45HmJ4R/3aLaNtPHhGYPQxbs5jt3ndSqAvRTa4bfQr9fFBtzTCfj7FekIzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858855; c=relaxed/simple;
	bh=fi76CKak6ECRmebrkvfSXR4merewC08i+gXXn2It1Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9i8SuoTpAL4hCrJnDfSY8yuecaZuQznEbIS1QXI7S2chS5jFF2nYaT7cxa8MyjlncaYh7rLFXqYTqHqJ47DPwPk1flF2kY7oPW2miLgnk9VB5PiMqO7T15NmJF5Vh+UWOs74tY/jhLrX7PkRQpSMp0iuf0rl7v5Ljso5E86GPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EnfFGrzH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso81585395e9.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778858852; x=1779463652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1mVnrFaglNDW2vBnNpYd1p6VJ2gDs8dA3EdHkOtYwt8=;
        b=EnfFGrzHtNVLJh5RNtHl39HG8qXgmBU5wHvNccAdTUlZvj1vNY04lsWSTK4GYYGDds
         O8OcypA2hhkJyTCLipD7viPSj2pSLplxKnyNmTPYalKJb4+OFgtVZa+765jdDC69qviU
         iWmrE1wOi/OoS07A2tmM3Vz9rCktojSd7Dz1yq6FX6294xFMz6mIgOT5k+NLis+wCwvx
         z/OpSjFChpBSHEbS5NMDIc1f52G/dnUJfkUDGPIcM4g+s3Lll71/4WfuHPzjvGnSypIw
         HdtxDZ9zhzzQNCdpreLkU3r6GsRYCmk9IJcuDuu3TRFWqqueH+TWhiOODMy3waJuNll2
         +H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858852; x=1779463652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mVnrFaglNDW2vBnNpYd1p6VJ2gDs8dA3EdHkOtYwt8=;
        b=gARyKB928OrC+bNBQh5Ar1+qifmVf3Qgxq+6QWBtnpDFyUckO90a8IB/xkZ5HWCOtA
         3VropkojJFoLDFF8fea+/ISpno89asVVamt7aE9DAbaH/GBsO5io4s2e9zdBFXTDaQ/b
         7I2uhY8IYMR9g21x2CEbEiyTHP/22Vh9HdQb6OnLeI0JEKpwDMs33H5fD2Sv0Qazdyhd
         IYnI/DkfUEU8oDdQ6ZQbEgXHoRb/RXzJouNxNwn8/Uvbs4lkBLqC4+e5X+HU3x2RPwQf
         wypooVKysnqDG840/lOiOun/B+zGWCM0Qkv1HzsUJP7C5MBz4RjP0TyeplPGdi2h/zEz
         k89Q==
X-Forwarded-Encrypted: i=1; AFNElJ8MuIqTV/ZQdnbzjPz2yphVWoXbXYZnxqcZGUR6Omg3j7hj5q82eYkpW16OAvba3TwOysmJLmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2kIYMfFedfS6TzpOa46GGfmp7og2NsqWJdfVvSNlvitkfj9+
	Z/xf7O8q6AATKo+O+hFmUyQHM14Zi7xO95jVtJ+oXmmSKXu+FFaIepfAeOnyQGrx6mU=
X-Gm-Gg: Acq92OFhTSUg4EOJA/Hf4iIKkkM3B+y9ocyky6oDtKKKFR0wgtrKmby+BV4r2Oci3fd
	gBc0lIhY7e6S8Btd8WrhjYWygG7uoCWNewk65E6VVi7tSBM+6iLsxWku7f3Mb94/F5URZLXDUHg
	2dNegpqMiy+HzdPjPiOvs/oJ6wgJ1XeRWFgOy7XmJytJJzmpXbB7juYGhbsWSJCAdjnoUcGvsrO
	Znsbnv6VQzIBo9t6XBQi9XiVgzElE+VNE/SsCdawmjJsDmEOA1K4ekmwiA4GKDn5CRiDwESLqro
	F2UXemTtYQZ6GcHxPWdEc66MbIkdlEFdSlOvpn8FI6mX+KQBMPcBUm4dlOncn6Ew4V+ZyvnonTf
	6XiPLIDBK0A7UabLwYscIZIcWTqDKKDcdGBxLrMmlTZjH6NmUByaQgnPn7S0BRoL//1Xj7DgBXD
	TSZC55qzMrVecANVuJy88OZjfa5g==
X-Received: by 2002:a05:600c:4e02:b0:48a:906a:9050 with SMTP id 5b1f17b1804b1-48fe5fdb076mr66546385e9.10.1778858852345;
        Fri, 15 May 2026 08:27:32 -0700 (PDT)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6aff4sm16079945e9.25.2026.05.15.08.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:27:32 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH net-next] net: macb: Move delayed work on system_dfl_wq
Date: Fri, 15 May 2026 17:27:21 +0200
Message-ID: <20260515152721.344380-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4086A5521E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288346-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_wq, which will be deprecated soon and replaced by
system_percpu_wq.

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

The function(s) mentioned earlier, end up calling __queue_delayed_work(),
which set a global timer that could fire anywhere, enqueuing the work
where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption.

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_wq with system_dfl_wq so that the work may benefit from
scheduler task placement.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a12aa21244e8..42328b5ca403 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -672,7 +672,7 @@ static void macb_tx_lpi_work_fn(struct work_struct *work)
 static void macb_tx_lpi_schedule(struct macb *bp)
 {
 	if (bp->eee_active)
-		mod_delayed_work(system_wq, &bp->tx_lpi_work,
+		mod_delayed_work(system_dfl_wq, &bp->tx_lpi_work,
 				 usecs_to_jiffies(bp->tx_lpi_timer));
 }
 
@@ -724,7 +724,7 @@ static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	/* Defer initial LPI entry by 1 second after link-up per
 	 * IEEE 802.3az section 22.7a.
 	 */
-	mod_delayed_work(system_wq, &bp->tx_lpi_work, msecs_to_jiffies(1000));
+	mod_delayed_work(system_dfl_wq, &bp->tx_lpi_work, msecs_to_jiffies(1000));
 
 	return 0;
 }
-- 
2.54.0


