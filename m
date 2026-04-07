Return-Path: <netdev+bounces-275902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WARfF9bB1GmWwwcAu9opvQ
	(envelope-from <netdev+bounces-275902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:35:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F03AB6A8
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BC4530067AA
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5339A07F;
	Tue,  7 Apr 2026 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOIM9gM4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C37399377
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550930; cv=none; b=gzaqdihqwPO/0OpT6hfCRza1hc1x0AsQUZ6nulrNjswRDocliJAsfv8gf0emyAxAiIPCwn6xkaLswZwKJw1wkLb4he6zoOObrfAqcjZRLaHiewVj9Lmd9QkSycvkt+kRoR2V108dCMpCVtNt7W/5aYsf5OwueXbYxThO89raRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550930; c=relaxed/simple;
	bh=dKTujzU/RT4gZ0YeCuNIiO3l8HTosq2qqb8WSt2cwZY=;
	h=From:To:Cc:Subject:Message-ID:Date:Content-Type:MIME-Version; b=ZmTjJSIQaCC0JGMm69Lubc0eubZQzfpmSJHcSFzB+Fj0ReKg46E7tWbeSSQkQoUccJz89S3hWcl6QGx9KdvPBQY4VI6m2TEQpcQipIIsCSPYWBWWkAAecVzsA6zUaQswfqrrWFQBIJTqBljzurJZfOEeb4NMrI9UnZapR+M8Qbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOIM9gM4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2066354a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550919; x=1776155719; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:date:message-id:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LkzOHxn7RTxz0GA1rTzNHX8XFNh7eSE/QKKRVQuNXEQ=;
        b=sOIM9gM4MNcwg4V3eeUPr6Z9rcLL2WuLqnJvoHTJxZPuCN2r8wlbl0dTigkD+Fl2qo
         Rv4U5OHgkEMr3znCP4O8bu/d1wQdCvnqXxQJDYvXc6luTmvAboFjKV+rt1V9e36tcHM7
         tHqyCcAFaQFG/xPvEY3PpjObDm+CykSVSBO3GIbBAicyQ8y+olKBkA7o0F5QbUxmMRdH
         Q7P07CSEAIwnF1Hj6HuhoVW9UHcfKIssHZg3J3Ftg+cqoej/GG1jdeoAmdE9EOY0WBTC
         Ar/sN5DGmBBT3DViFutrM3eDUZYLCuG//UI/Wg/LK/gS4f7sn8CKy/4fOLvpx1iMCLTB
         at5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550919; x=1776155719;
        h=mime-version:content-transfer-encoding:date:message-id:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkzOHxn7RTxz0GA1rTzNHX8XFNh7eSE/QKKRVQuNXEQ=;
        b=Lp6L6dpvrwPiwLRI1Nnr0BaJt8Zju+59YxNXcyLxk40Cus6+dfge0iUkLW2Q41O0/W
         tc6YlK9Y/RpocqWWKcqExqotTtTKS/YOsFQrTJzuxUPziOCyY8btzckhJuGJJvD/Bdlh
         FfPqzld77wUWiVrHFsT52BQksSwzH69PYCkxI9W9GqlENm/rLJrDvBlN5iA1nsZcHpV3
         JtqTURTQq79yA1NW80iH+Wo0NKhZukfLY3nNuJkvEBamxMz2D2RJFgcNh5r7dMLBz07J
         Buj/miomA83UWyWW0+x3xCWh2kTEzaPqI0gzPjjw2lpCMtC83krJq/CWyr4l1sSjO3Ap
         Pj2A==
X-Forwarded-Encrypted: i=1; AJvYcCXucBbOWjfaCAAN99dO4puXnfuyIwP9Jr7ZNAJrTOMpfK11i3yZk4I9vwYhManyIitER1dZ894=@vger.kernel.org
X-Gm-Message-State: AOJu0YybOpKvA/SfMPa1X4bj9ZexEFdWx3J/hFemvBeWP7b+Wmt8PrwM
	Ezg8ESbFwhfY5U49WH/ev/uygfZC1lzMfBejeoIn3UaITndmdpaETMXv
X-Gm-Gg: AeBDietr7jwW8RtCETaz4eEC1zi7DTPyRv9dMY9lVyXEwkVzpjGYwlhDClnSNV0kumY
	uv1w7trj2CD2MTFSbRZUud/oOY+gXfPXLslVOyhnpwCOhVltdilFVxlwb90tiF0S382YBLakwGQ
	Hm4aurs8ZImqpFCpWasJaoc1XASu/iPXaFhnCFEVGR8utQCrlg/+0poGSJseD8Ya7P3awPYOT//
	AODamf6Us20+F3pHl6hqKpJ+AaG4l5K+u2cBHWFMEQbAMHh1nskH3W9/sGK8vTovC9RrmveNPrq
	NCPqGT0dlqTuglvuLnL7tllmU57XVOYgof1I/PcmPhDNp0EmkbPtO+IZrCdNrbvuYSmF37FIywy
	AZhUaIbS8NEy0o9zbUWxlajFPN0OxUSal8r3Of1YuZnFtgWN+zSXu0+SaZQUfd5a6m7c6RszFsp
	cdbCth9xWta4/SPOszJ5crbyZL7TIewvSPc/Rxt5HtZleXKL0+D7Vrzy7tVc2wiqbNclyNlRYgN
	n3ME+9R7jQOROzVL2pNxw==
X-Received: by 2002:a05:6a20:4322:b0:39e:f994:f698 with SMTP id adf61e73a8af0-39f2f0cc6e0mr14883194637.48.1775550919424;
        Tue, 07 Apr 2026 01:35:19 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local ([103.10.28.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm16842931b3a.40.2026.04.07.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:35:19 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com
Subject: [PATCH net] atm: mpoa: fix mpc->dev refcount across mpoad restart
Message-ID: <177555091252.59118.13093904987038690781@gmail.com>
Date: Tue, 07 Apr 2026 14:20:12 +0545
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275902-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5ec223ccb83b24ef982f];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: F23F03AB6A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

atm: mpoa: fix mpc->dev refcount across mpoad restart

mpoad_close() drops the reference held in mpc->dev with dev_put(), but
the mpoa_client stays alive and keeps the same device pointer.

A later mpoad attach reuses the existing mpoa_client without
reacquiring that reference, so the next close can hit the netdevice
refcount warning. Keep the LEC device reference with the mpoa_client
until the device unregisters or the client is torn down.

Reported-by: syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com
Link: https://groups.google.com/g/syzkaller-bugs/c/qhZ5MJfLBOE/m/UnotmgRdAQAJ
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 net/atm/mpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index ce8e9780373b..1e9b9c633e8b 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -886,7 +886,6 @@ static void mpoad_close(struct atm_vcc *vcc)
 		struct lec_priv *priv = netdev_priv(mpc->dev);
 		priv->lane2_ops->associate_indicator = NULL;
 		stop_mpc(mpc);
-		dev_put(mpc->dev);
 	}
 
 	mpc->in_ops->destroy_cache(mpc);
@@ -1508,6 +1507,8 @@ static void __exit atm_mpoa_cleanup(void)
 			priv = netdev_priv(mpc->dev);
 			if (priv->lane2_ops != NULL)
 				priv->lane2_ops->associate_indicator = NULL;
+			dev_put(mpc->dev);
+			mpc->dev = NULL;
 		}
 		ddprintk("about to clear caches\n");
 		mpc->in_ops->destroy_cache(mpc);

-- 
2.50.0

