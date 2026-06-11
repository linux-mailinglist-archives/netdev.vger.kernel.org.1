Return-Path: <netdev+bounces-298355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hSk8JQEjK2qd3AMAu9opvQ
	(envelope-from <netdev+bounces-298355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:05:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6826755C5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:05:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=tRywnoMC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298355-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298355-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4AE933DD658
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50C636AB4D;
	Thu, 11 Jun 2026 20:59:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4A4D9918
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:58:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211542; cv=none; b=CSyRDCOf3k3HfZTXMUiVof6CBeCZs/pSmL0sH7P9KOMSm8y/hnxecIsKrQZTueANaa0aSzJMKGRDtiJia36atcMdVRDtAXPtmOF9SIWsIkyUqE7h8MMT6QEizQBfz0KcRN+E/YC9UpKDPYOIc48hJI9JkYNaHZPY51Nniz17zOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211542; c=relaxed/simple;
	bh=sdkhi5mCiI3LOB5y3kC+kgbtHzaZQzQL66f//4D1jnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtQJVl/G4ksQsnWKWM+6MPF2khkXOYP+VGBJ0VdhrRt/U5QWD3r2RCzuqJJkCVgr0cNBajlpWkPPJR0Lh099LbcTS2/XMYFXhelIT4j294TWNfpIHgL8cePEZ6mQGTxh0SFZHt/3FXyxKyVZ1KLmo5yEr4QkjXG+Li1EOIgAPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=tRywnoMC; arc=none smtp.client-ip=209.85.221.172
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59d541955f8so95450e0c.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781211536; x=1781816336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrKYbID4XIPTKf7nR5OQfk5SuCTXK3HRXAL7EVjxsB4=;
        b=tRywnoMCrqUVmQkPq6uj3Xfdh6wsvydNi+Or+7p+MTzy2HWpOZsxlMqE7da09TCXad
         M1RW/B+JqNYfcG7fW8N6VYgpNwf5axEyO2+RXyUUWj43sa63pdh404wFojn1favj+g2v
         r8nQ4YMs4X55Evieb/rfqVOx9EP2KGSqQHK4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781211536; x=1781816336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrKYbID4XIPTKf7nR5OQfk5SuCTXK3HRXAL7EVjxsB4=;
        b=VF2ZqN0yhJdKuNtPH+/QkzFsoy+AjwTQDlcaQxyBIaU//SNS+9ONr5iyS5gnTfdppE
         V63fmkDy+n8k8MdI36EsZngreHWfQsZZPebmeRKoHoEsdilCAqEvN1zPL480IAzindWf
         +4Nckt40dJGIM/KhqDQBqM2Dj7un4OV7DGkyme73Ib8L2SBnb9AkoATKJ3J7AXnWJrOO
         sRzwG1bVrKFjGq5Mujj/sTDjoIb5h3QIlmc8Xocy0WCCJjEUddK6PctMY7wxX8n7WI5J
         9hbMjUGJUtnkArUY0O7rJDkCKdSyjik0QM17g5iEQz5DtuRtR+l79DysFRQZ8AbJus+/
         sm4A==
X-Gm-Message-State: AOJu0YyKXO/7R9/tvLdIdIXFadPSpwNOehNksTFjx9Ed5ObgCQbatOxH
	7YBm0QM8osTjSluME2dIcz59zu5WRTuE4BDR3TxFLWt3SQCtgT1BWB4CyU+JjDXSQQ==
X-Gm-Gg: Acq92OHmPSj78i4n3jA2AL7lx1OT5i6niMoht3r5dkdwwCK5DnEd/5YHsyo+gbdY+kM
	Noy+5xxYygQTyMLUQyUnwar8SiVFIQtORJi1IOYaMBZIWJAKh6miUZQktPBb+dT8vRRhJOXQToJ
	nF32jPS2fQCWEYvGwRdn3tLZnLN3vr3c7QedyOeKORPCYr7qMTbJAvqZuVnPFWBAuGfgOcyvcUa
	uQqk6HT2dzGpw1DdJyUFcgBUv0G6ydY2ulzPTCbfc+GMoYP9tqkyxniL6VZqfcelSyF4fwwCAA/
	lExgw+iNtzJhVNL664KyHjIVJRWbDJ5LAzl2wAdcSKOVTlCLs6RK5F0QnEjJ7CsbLwZCNb8WUCT
	F9LX85Sc0dZd5B0cHJCcsD3NFOmM0VZlI2VFlfpLLDDsOR71EFD8nd4aIonqhFxjoTzwo2bqzuF
	Ah1CIPVpp3l2mwUJOGJE61/WI=
X-Received: by 2002:a05:6122:169a:b0:5a4:5605:c681 with SMTP id 71dfb90a1353d-5baf7629d7cmr3058191e0c.0.1781211535930;
        Thu, 11 Jun 2026 13:58:55 -0700 (PDT)
Received: from exu-caveira ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb69270443sm476271e0c.17.2026.06.11.13.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:58:55 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	pctammela@mojatatu.com,
	chia-yu.chang@nokia-bell-labs.com
Subject: [PATCH net] net/sched: sch_dualpi2: Add missing module alias
Date: Thu, 11 Jun 2026 17:58:49 -0300
Message-ID: <20260611205849.3287640-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:horms@kernel.org,m:netdev@vger.kernel.org,m:pctammela@mojatatu.com,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298355-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB6826755C5

When a qdisc is added by name, the kernel tries to autoload its module
via request_qdisc_module(), which calls:

request_module(NET_SCH_ALIAS_PREFIX "%s", name);

i.e. it asks modprobe to resolve the "net-sch-<kind>" alias (e.g.
"net-sch-dualpi2") rather than the module's file name. Since dualpi2
was shipped without this alias, the autoload fails:

tc qdisc add dev lo root handle 1: dualpi2
Error: Specified qdisc kind is unknown.

Fix this by adding the missing alias so the qdisc is autoloaded on demand
like the others.

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_dualpi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index a22489c14458..65d0f4036efa 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -1174,6 +1174,7 @@ static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
 	.dump_stats	= dualpi2_dump_stats,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("dualpi2");
 
 static int __init dualpi2_module_init(void)
 {
-- 
2.54.0


