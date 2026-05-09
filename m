Return-Path: <netdev+bounces-286094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI38DQOe/mkVuAAAu9opvQ
	(envelope-from <netdev+bounces-286094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:37:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE06E4FDAD2
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD63A3004925
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E265A331A66;
	Sat,  9 May 2026 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky0MIEg/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0733374F
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294272; cv=none; b=E2/Ajk9xzScvrvb/OvRwOhDOgdw7YjmDHOnOZOyCS5vaJzuRQoTcjNuToP4NLm2Jz+BCqwkqN8aDL2PvFGBG+fE+r7xJBdNEpNKVJEcTGfLq56ZGjISMyzKkxT3l7UpYl0acBn0igWh4t1tVRm8tWr0vmgq/hravHFljee5bWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294272; c=relaxed/simple;
	bh=OrrBWBBsxVt40ESfvxDp4fYu4sB+aY1+BiFrwGQrwxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjVN0oJQsxJioQ9kAsi3ZAN67jA9JdUKU84sj7nfQZHEUitD9qFAfN1Y9KBy0kQc/DSkkes+N+XLNamziBEyJBe5kCLmyMvsWTI1IxKPVjSLZ9SptBeC/kzgo9UqPvervAmAtCDnhNjEhqppBTn7GUpHKD/mqH8bPexQp7Q9Nss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky0MIEg/; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2f00a567cfaso2277121eec.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778294270; x=1778899070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ni1tZOZf60NuZfdoJF6J/0gev8lFnicQU/0S4esZy8=;
        b=Ky0MIEg/lh7vHW2RzT0g5+m1R1tyzobhHDJqtwOBdoU/cy7cmnbZDeJdEYZJRM55No
         U4ZSlRoSGoA854bCdGI2M9zBQQtwYWzYrddOgOiZOWDU9AZ6PU0VYWbffn3UAxSvC3e1
         ZqTztW12dnuO9yBkHXvCHn54EIzcXoVkj3dRO/C1FRT4lVB5QyphtEcjPSSHy4jIu2rs
         yiD86cqbHl9FMJgy/3faBfOY+tLpI6nssMpfOf/TLWOvipoZC5Utcf0HgGvGi4alrfZc
         rXNOGKUj7Vb13JCICDxx9jQ/hDNlbYp1zNXW8I8MpyWx2uxzU8v3lSiF3pXXQXymVxw/
         D5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778294270; x=1778899070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ni1tZOZf60NuZfdoJF6J/0gev8lFnicQU/0S4esZy8=;
        b=GsyEJRYtSy1M9XcSeKvUx5VbuABSqg0Tjozmc46/D4a86Bmd7qIEOdzVorEfxl2pvu
         9LSCCKDBbvHSd1h/lm/MxII1+zDFF5iTE5giI04stm2943qA+i1NE45oNPVnTXE0V1Ff
         aKzEtBlcK44g3WW6/l0fZjVcUxBie5xe1HHGYX5TPSP7BhHc1WQwb1g2H9FROef/VdtA
         a1lUOV7zi1mWoL1tYL7Xa/xyBtkrXud+m7RO4iQBcgnfCndUmpdAvySneyxU/CpsQf3W
         joVZHclm7sFrC3XD3PLFzv/eL5nIrQKY0UU6vtEXWC6+e/Qnxp1sr5q3IZmlRt15fx+0
         WqyA==
X-Forwarded-Encrypted: i=1; AFNElJ/rwZZmjLmQ8+5UTZcnCLSCXAgNEM9fzM7MLX5/CZaUO2QfmPn7rnM8FXMgiPYl4PW4w7DARCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKUqbaME+5XzKLV0zbwVmQPtmRE2/EdRotPU2W8D7ujCiA1jj
	Z+YFqTDT/O4juqn5iM6I0SXqqH/KqdIjNzG4TG0YYRah+lyPpwgYOpjq
X-Gm-Gg: Acq92OEvGrMKdpH+kkTzrUe5oaCNyUKgFhCq5Gws8INa3wQ3MAEQvC/oDBghxlGtU8e
	Ame7KriWf9dGisHhUS8+uXWs00Z8Vp+1CvdiDulcaCzm8JFxQJ2KqVd9ADpKmbzwEQvnj9HfWe9
	ck3v6fgoLcoVGiSG99hG3q9q8406cl6NLTf6NFieftzoXwKWmECWTiGtYPdebImKUdPJbCP6787
	fqfcPxjFi1Iybp5ho4oFZGzp1bgwqQ2JoTooQgCpFGYuwkqbhdOByhnwmis8E3Oh7fxgoM0Urzc
	pMbZqIk8BjLSaaBgIMnzb0vhC7eupujYaNxxSE17t+UOwmx+htivuHfa5JCFNAK+A0kvrwveHzD
	yfESUt8LkGsCBLyMRPq5B6S0LevdIZkrxDfZKlXFU78sDruxXnkQpt5kr9uLXXcQPce44tVFReK
	dmn4yzcEZL5j13TRI3JJEqc7qlPUHnk7klCCD5JUdfBiPfjoui0p1yHJlyYK4E4jXzYeQRir6EW
	oNMzARZTB0uA70ZaIiMM4v1QyKRm4pIlNhykTtsZDseKcmx9217HzQel3lZqJ/qMcpVmuO6STit
	XMX8v39PwcLlRVdSgA==
X-Received: by 2002:a05:7300:7f9f:b0:2f4:d190:37bf with SMTP id 5a478bee46e88-2f6e4563223mr3912893eec.16.1778294270296;
        Fri, 08 May 2026 19:37:50 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847502fsm5510395eec.14.2026.05.08.19.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:37:49 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference
Date: Fri,  8 May 2026 19:37:28 -0700
Message-ID: <20260509023732.42256-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE06E4FDAD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286094-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The legacy ARM board file for MACH_MX31ADS was removed in commit
c93197b0041d ("ARM: imx: Remove i.MX31 board files"), but a reference
to it remained in the cs89x0 driver. Drop this unused code.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
I found this issue while working on updating arch/arm/tools/mach-types
to remove entries for board files that are not in the kernel - this
reference caused my script to consider MACH_MX31ADS to be present in
the kernel.

 drivers/net/ethernet/cirrus/cs89x0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
index fa5857923db4..b4bfd6c174e7 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -1271,7 +1271,6 @@ static const struct net_device_ops net_ops = {
 
 static void __init reset_chip(struct net_device *dev)
 {
-#if !defined(CONFIG_MACH_MX31ADS)
 	struct net_local *lp = netdev_priv(dev);
 	unsigned long reset_start_time;
 
@@ -1298,7 +1297,6 @@ static void __init reset_chip(struct net_device *dev)
 	while ((readreg(dev, PP_SelfST) & INIT_DONE) == 0 &&
 	       time_before(jiffies, reset_start_time + 2))
 		;
-#endif /* !CONFIG_MACH_MX31ADS */
 }
 
 /* This is the real probe routine.
-- 
2.43.0


