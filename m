Return-Path: <netdev+bounces-305059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mxAVEc3AS2rZZgEAu9opvQ
	(envelope-from <netdev+bounces-305059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:50:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A15271233D
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:50:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=aqet4J9g;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305059-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305059-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D2C3243EF5
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84C03B71D9;
	Mon,  6 Jul 2026 13:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D71A37F728
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:40:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345247; cv=none; b=Hgu/Z8LwDoLtgz/WnyW5xwsojuGJZUWRUb2gW7UiaAF42eVItroNZhCQaXrWIhv4/apFd3tvbuKq91favjDdLeDfL08yAlkVEf+6qSm/b3NaCqpZVDKZVSgl5twO/3vsBjCKzBoSEbRyMaIQFqY/JNUk6h/FYIABhzNDQXqOPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345247; c=relaxed/simple;
	bh=MzHFCd0Tz4e+Edg/Bq9oVoskUFiz7gl+EF8d1HofN4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qT9/8BhcAKZ3cOfGSCj/AOnQZDmP5NsUTzE2RBNd7HT2vh66tq5R9N4gf31hG1zMAVTBKzPtwgvdIMO0y7wZ8QzLHSGwEH/+1ULl7PPjHClyXRV8AJTAIgWnZoO1cUdyUI+7V8cgzqDlZ8lmWWwREiR4hDC/rHXc9bjtPHfCCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aqet4J9g; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-474560436c3so2996740f8f.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783345245; x=1783950045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPb++nNOUKaZMzssqqTK7VRW9BEodDg7l0QT3ply1Lg=;
        b=aqet4J9gZ8veBocO9/+al8eTmA68Od+SxRXY0LbEY6P4Nrj3yDFVvttG6t/shM8Rr5
         /HsxvCKFKTFDW+EArNTyFOEXmMXn/fpIzx1xtEBYRMV5JvU/Xc1ITDn0hbUUwOzUo8pp
         WCNy7wRoC0zyNYlDwEE9dkJu2adwu0lPIu7gTtmYI1kEtmSOUTdAN02bwSsEWkVFu5NQ
         PD8xPZ/ucx+kVJ95ugVWyagrYNy2DglsJ01aQ8nuXykEZKDQz0eFTkp2oVUUvFTS36FJ
         k/n4tN6/L97hHUB/zo/D5BHYgLHOOGfnv/37raBUMOAupHXJCo5G7p6XrmdLg6Rzskj3
         wIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345245; x=1783950045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPb++nNOUKaZMzssqqTK7VRW9BEodDg7l0QT3ply1Lg=;
        b=fjwGmBPKBobIBVw5CTr0b7wI8YYglHyd53TCjr/FFbeaMkCqU2HschzFsZRXqD7ydU
         GQ5wmwdZdIYgCDChP5OvxdK+BSmrJyMw3EL+J/vv1oJu56E/iEBkhTXebLYBfrk4fz1w
         odESkh4RKviqaWIdeO90XiJeORaYQEEYjo+HVoFPlAI2BcQvUB4DfOCRzbsRbu8GyYmO
         WsqMhJ5pIjzePrhXUqcz7eJyTNd1zFKvfExVz//LYtfB9zpPJzIO2saQpHp9lVqsmuZs
         AGO0ogxMPPD9k4aYkawes2UHoLG6DPdn6xbZhvZDxHQMDGBgTCin7Ym/ocT0IuN8g5sm
         n5Xg==
X-Forwarded-Encrypted: i=1; AHgh+Rqjwzf6CZloKZJ8HuRwkqEvXKbbz8EEMDGHvueB88ORJGnqB/1NbrNXYhzJO0Nbh/y5kS7nnFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6EmWWJq0i1VEQssPV0uq/kMkhhPm7xiuuhF1tIq3GC2oa1+dL
	KDMPcTIGSJC82P8mXOIRReNmOscgrBfxQRMfS7RTgVH9Yj1EYhn7IXCiSFkKOaAMF1E=
X-Gm-Gg: AfdE7ckriIWkHUlivuHkebmGfIsDinDq2BQylq5mtnZE4oapR6VWMr6R8zwDGqM3NW3
	/ZszB0kiLhu9mSQmrfVGBevSHdJW+82AadKqpYoBAVzvSLJZoui9iV9yp4o0n/A85VDJQLOP9Vs
	gdMjHa0MwyTEd4n2fc2ab6L/difRivG4ER2bm0C4qtPUmWPiA1PHm6H0FAZN3vh6av91ydmb7g9
	Gau62S+LI3FVQ3B2MITQbE/8uAhonxlHLbunikcROoaFx4UjwfiM7EbZ2ll0DTh1G18BPgY49g2
	zcJkCxGRzqJVuUXqrdpHpfW2Z1CfxO9HUyCIPONEQx+hg/OINwmnbyTTnk/r2Tk/low/uEbHo67
	chQOLRdizl2goum9Hh8FkrWWJ+0VB8gEX061X125Tqvw3O9CnYBtfOMsfNmgf9ND/lALca0wTRb
	93rCQV09rVH4Jp6EwHTikSU5y2CjYC4q9KYKc=
X-Received: by 2002:a5d:4108:0:b0:46f:f12b:e457 with SMTP id ffacd0b85a97d-47de669c22bmr236646f8f.21.1783345244677;
        Mon, 06 Jul 2026 06:40:44 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm24424868f8f.33.2026.07.06.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:40:44 -0700 (PDT)
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
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH net-next v2 3/5] net: thunderbolt: Move long delayed work on system_dfl_long_wq
Date: Mon,  6 Jul 2026 15:40:26 +0200
Message-ID: <20260706134033.244295-4-marco.crivellari@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,lunn.ch,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-305059-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:marco.crivellari@suse.com,m:mhocko@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:westeri@kernel.org,m:YehezkelShB@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A15271233D

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

Cc: Mika Westerberg <westeri@kernel.org>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Acked-by: Mika Westerberg <westeri@kernel.org>
---
 drivers/net/thunderbolt/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 02a91650561a..be27972bed18 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -316,7 +316,7 @@ static void start_login(struct tbnet *net)
 	net->login_received = false;
 	mutex_unlock(&net->connection_lock);
 
-	queue_delayed_work(system_long_wq, &net->login_work,
+	queue_delayed_work(system_dfl_long_wq, &net->login_work,
 			   msecs_to_jiffies(1000));
 }
 
@@ -460,7 +460,7 @@ static int tbnet_handle_packet(const void *buf, size_t size, void *data)
 			if (net->login_retries >= TBNET_LOGIN_RETRIES ||
 			    !net->login_sent) {
 				net->login_retries = 0;
-				queue_delayed_work(system_long_wq,
+				queue_delayed_work(system_dfl_long_wq,
 						   &net->login_work, 0);
 			}
 			mutex_unlock(&net->connection_lock);
@@ -700,7 +700,8 @@ static void tbnet_login_work(struct work_struct *work)
 		netdev_dbg(net->dev, "sending login request failed, ret=%d\n",
 			   ret);
 		if (net->login_retries++ < TBNET_LOGIN_RETRIES) {
-			queue_delayed_work(system_long_wq, &net->login_work,
+			queue_delayed_work(system_dfl_long_wq,
+					   &net->login_work,
 					   delay);
 		} else {
 			netdev_info(net->dev, "ThunderboltIP login timed out\n");
-- 
2.54.0


