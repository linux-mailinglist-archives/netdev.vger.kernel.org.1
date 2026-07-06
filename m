Return-Path: <netdev+bounces-305061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ii4jJLO3S2qTZAEAu9opvQ
	(envelope-from <netdev+bounces-305061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:12:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23581711CA2
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:12:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=P5zsbP1R;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305061-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305061-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16ABC311C062
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F3841613B;
	Mon,  6 Jul 2026 13:40:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E5373BE9
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:40:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345250; cv=none; b=EAkJsm7umkBaluceObc8LhWDclSPhfXAqzKzwbO0g0zni68nMx3vDk5X+5og3ntA8iQoSxXXP4Fqnpbnw5238PMXeWYjYuKgkt2UjXguLmUQJHtjg4stUFMM/cF98zf6T1ugEcgjh7V2jrbBrZOApB4UIr/niGSQ5yer0QDK9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345250; c=relaxed/simple;
	bh=2viZWvH6/+46Pl78pc14Y4zP+oD7vA7rv2Yat9sU6W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2pznPxjcGWI0cUWADEOIWoBeQd569in8ExTlYcJMSRs7kv1KB8wTPT36HIx2OUz3E6RSTp0DUyEvtsyqSCvEXAtM7Q9DS3AsUSW73qM3G4mxNM971hyRRpBhJsT8cFal5VJZXczk4EF+i1dyE4T/uI7LhmG2yXe71n4P2s+w4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P5zsbP1R; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b7612475so28422295e9.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783345247; x=1783950047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAtyS+TPO1WR/0zgU9PmtjKVpg47XvcTOZ7PAzXPVhc=;
        b=P5zsbP1RmXMQZnFuOjKlFxnOj4MiKe8c3H5tJ/SU2VYnNwRNoXbhoFJcMNSSyWUdTd
         qAmi02P7MFCe8gRBzYsmI9DJt+wDp/GKRD58yGm/oZDj9IRI2tcvdkH/poG0TYPeFEwx
         xu49ARapyE9Ep1adV4HC93x7+mS/tIXOvQs02ZOUT92GbtSR7jSqXS20VqFkJ+sW7+22
         9ocZIIQYkjD9yYKZZ2xdgxEkEnVyaLwa/Ofc58WJRhldFTXj7EDhsCwj5gPpdXwoBrEY
         EM9kaNFQFImhpliGjtgvCbvDSX9A/hvIBrDATWY4NtRR8ZU+N9j96r2Gxryi2mvIOyE2
         fWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345247; x=1783950047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAtyS+TPO1WR/0zgU9PmtjKVpg47XvcTOZ7PAzXPVhc=;
        b=tCKKnrhECd+SwpyhWrV8bPpC2VuNV/MvD0nAbSQrCeub7z3WLrFYuWTTYYcqSsSkaP
         3yfFh3G/tIHm+KLkMffvCbrprRpeHr+tWCfb5ofKHQeoVxkQ4c1sgjXyDcJ2q+MF25vo
         noQlpVmykRNIa9DuxoQtrb1hdlf6HwLQoyHQ2CwHdjYtgLUeehcIRnISR9w9iA4K4/p0
         QjE+meBjn/GW0l1ifioBUXcfcUQSs3UX+0FGNTYjHimyTFafxpzW87fKPWQWmEYCaGCU
         /KuIhIa02kDtln5N+WEK7/naJ1dGluxPVf00Upb3MOA+gfE5jJHEq+gufwoSrlgAgTbD
         J7BA==
X-Forwarded-Encrypted: i=1; AHgh+RpGJhLfb47GXXnLknDT6Z2b42HytwI4C9s+N1IAHLXa1NUCjBiiSyowH2v++tG2nQpJwHtji6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdwbl+K9Wlc0CzhOTcDq/hOk9Q7HkaZpr/FoC2fgbYqVkkmOW
	X7cdKHW53y+WfhInaxCQgbmDzvUbjAdgVhUfnOnxPNuuR372ANIl0ChASYr2M/iiLPA=
X-Gm-Gg: AfdE7cni9AFRxN/X1O0zeJHRk+UaAJuaPOrNlLudVwgAZ2br768+uAhppl1Xg/IdolD
	DgdOHY06tkRtHb4iPr/keZPeLC36JABS+mToazDjn7LbLv032fV/HeAb15FoeMLftMLAZ4ObV4q
	NL+CiPNlXc9/F48X/j34ZIHENb4/AxP6BGna4GratLFuid/T/8G/7qqI+TkNuYRhTgNrEH/jjvF
	uj0H3uh0JsywCWNEVz0NDqfUu926sH6YVHPJwSpstQT9Xybv84uhWkM243glCc7CibN4tp7EIXq
	L9KGiA7rjs12Gn/qRVbk2HeQnNZgutdzcM21AiqJLH4Klo6zMYTxE3sjY4KzSuOExZqjzC9w41f
	zyGKzWj7uu9by1JYpC6dgoAn6fItK6CZaN5Agg7PVFNrWNF3TNcSBT5QoptstWtzeHe8t+MMOpu
	NZUkRIuemT6J3DNqmPmd7TqykEarXJNTWHZYJ77BPh1hdRZA==
X-Received: by 2002:a05:600c:1909:b0:493:cfe8:5b36 with SMTP id 5b1f17b1804b1-493df062b57mr7704775e9.8.1783345246965;
        Mon, 06 Jul 2026 06:40:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm24424868f8f.33.2026.07.06.06.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:40:46 -0700 (PDT)
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
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH net-next v2 5/5] net: usb: r8152: Move long delayed work on system_dfl_long_wq
Date: Mon,  6 Jul 2026 15:40:28 +0200
Message-ID: <20260706134033.244295-6-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706134033.244295-1-marco.crivellari@suse.com>
References: <20260706134033.244295-1-marco.crivellari@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305061-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:marco.crivellari@suse.com,m:mhocko@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:enelsonmoore@gmail.com,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23581711CA2

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/usb/r8152.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..f6af66f294db 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -7072,7 +7072,8 @@ static void rtl_hw_phy_work_func_t(struct work_struct *work)
 
 		/* Delay execution in case request_firmware() is not ready yet.
 		 */
-		queue_delayed_work(system_long_wq, &tp->hw_phy_work, HZ * 10);
+		queue_delayed_work(system_dfl_long_wq, &tp->hw_phy_work,
+				   HZ * 10);
 		goto ignore_once;
 	}
 
@@ -8840,7 +8841,7 @@ static int rtl8152_reset_resume(struct usb_interface *intf)
 	clear_bit(SELECTIVE_SUSPEND, &tp->flags);
 	rtl_reset_ocp_base(tp);
 	tp->rtl_ops.init(tp);
-	queue_delayed_work(system_long_wq, &tp->hw_phy_work, 0);
+	queue_delayed_work(system_dfl_long_wq, &tp->hw_phy_work, 0);
 	set_ethernet_addr(tp, true);
 	return rtl8152_resume(intf);
 }
@@ -10295,7 +10296,7 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	/* Retry in case request_firmware() is not ready yet. */
 	tp->rtl_fw.retry = true;
 #endif
-	queue_delayed_work(system_long_wq, &tp->hw_phy_work, 0);
+	queue_delayed_work(system_dfl_long_wq, &tp->hw_phy_work, 0);
 	set_ethernet_addr(tp, false);
 
 	usb_set_intfdata(intf, tp);
-- 
2.54.0


