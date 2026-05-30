Return-Path: <netdev+bounces-293330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKoPMDPCGmrf8AgAu9opvQ
	(envelope-from <netdev+bounces-293330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:55:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEDF60C4A5
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB427307D7C5
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679C3A5443;
	Sat, 30 May 2026 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+CiORB4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE037AA83
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138317; cv=none; b=STpIn3cVk2rpf5dDR4lSLvKwFqmRVMOmpK2DJkyJRiAdMWEzcAxluQ5/HMqmy5h39um29GYtacYJxIknFCtbpdeBb7vpX+2hLoS8HkruyMS3+y7UK1zhUxBRi0fqt/jFacEUxuyMdwoCnvU/2VLrka1BK12dpzqSkn/WNGeHRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138317; c=relaxed/simple;
	bh=36XMk2k2Fl/t7QP9Bqz24fQRkYSOVQHJH4oxIRIgBrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7elC7aqVhKZB3GgaC7zvxel1xINnFmijyeixgYt+wftT19LxGUmzTAfIm7QNq+Ze0v97F/EZGYsx/lqwLgREmZrGD5WLk/fc5EMROdVJsyqH4Qu5ZJJ1psczpDoWeul/aKVx1mnOMkG87yZUcpUWqMxmRSrS5xbl4NAxJKTEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+CiORB4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dbd25309f7so34963277b3.2
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780138314; x=1780743114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozA/ZpsGC4M1Jr3f58tsEBgX6Dr0vSgjMtMPt46Upe0=;
        b=j+CiORB4mudnvy4yWJMX5PlSZL4mYSUNFi4k1SrRNlkOTFNju+pK3SG46bWZYMwtyB
         YcwtN6h48Q/5r3n3etV74lU5xzPQQCF36hicsM4Mop8gsnNdFxI6DOKznj8CmWWN8DRd
         3pMoquQ2mhukVlT+gGOK5wcU4hgJbxsW4MKIlCqzoF/DFJxLWZS950G8+VZ2ABkrcSxy
         vxrYP4N7VfuoDBmn4w/75onw0GrCik5nhwOwp4yCSKv7Dfifh9Y7A5aTAGqmhTZOzoms
         nhyllxCDOkabWpHGUBFiMbFKqd0mDbvwulrEH7g6pjjvtGhxyHOEAfwwvfXlqOA3rM9l
         v2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780138314; x=1780743114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ozA/ZpsGC4M1Jr3f58tsEBgX6Dr0vSgjMtMPt46Upe0=;
        b=mKCcFe1GWiecxn6+5bE1Tq4W5Mp8klbpS5M2vCsJm3qnAYYOEkB5qOc1hNrxllvWEr
         +TUpDVgxuUON0JSsJlULJwAITZIvGCS8oqjueJs1dmtmil31Il4mSckvDPaWQi0trb3W
         vGPCtOnH/A0ukqlTySq8aq2X51FuLldTK2zk9i+E50pc60JM8fIkMbMzF+JOKVQWJJ/k
         XZZw7hC31pQvmNoxhNxVxt31mKB7Y4952/igettD2pXSkmD3pO1KTWXmHLQE/nu1nNeA
         sLBfqgNQGVTflzMaXGkxUVrJy3Wa4Adj4V2+Zo2uTSthv3CNDtJWpfOR0aGldzYHpcCt
         f0UA==
X-Gm-Message-State: AOJu0YwzYb8WCC3A0X4AySzJb952rrHKtL3/iFczwPLw2O8U7VHR0B6g
	TX6B1G/6WdreicXxxcpTE2qHFBmdHohiY2oKZEE+54yONouXnILIfdbj
X-Gm-Gg: Acq92OFVKjATVFU6RYyoDBZtzIMOtY0UJiNFi1AHbgUzdAab6T6uM4qZYsCKHJB7stC
	29/gF7W+/onxJ7jJSr5UpFuKyRwIX4zPUtRdVfXESdG8PM1QEQbhvDSJ8RFUnW3fULRWDcwgJei
	D9PDNa9WKCvvAo6nRxi0aTQXcb7lAqtzGi9zfF2n2Ek0HhRogp9DPdxwcY64Itz8ZXFMXiIwWNl
	FyE4SNjFyjV5QGr8n8nbcVTb+UkNjmJLmHesz2MZ8jFkTNphQYsxdbLa3qMUzDBluawktiAc5aG
	Cpmbi/hrGGJdMNH9UIOdMOVSQ2vWQNWcs4KlhTpEVCGEUeL3sc6hSvmfQqRtAUx+21JSZlg9Z6V
	/UkjV2EYmKQ/GwSq+S1+HLeZrpOj0bssbiT5q/TDJJQUkL7u2aJUiQ3B2MDDbXs78r9yN81FKEQ
	ofYSi9NCbn2T3QO9wfKah6BCE2vz8Oo0qrmHnV3CRqmmPZzoWIC5sX1sXh23CY
X-Received: by 2002:a05:690c:7088:b0:7dd:1616:4559 with SMTP id 00721157ae682-7e05c94fc7bmr30614357b3.22.1780138314585;
        Sat, 30 May 2026 03:51:54 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e176d6ff86sm5579357b3.16.2026.05.30.03.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 03:51:53 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 30 May 2026 07:51:07 -0300
Subject: [net-next PATCH v10 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-realtek_forward-v10-2-d14b51e6a69d@gmail.com>
References: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
In-Reply-To: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293330-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5BEDF60C4A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
cascade links (-EOPNOTSUPP) during setup to prevent silent failures.

These topologies were already non-functional. Without a CPU port, the
driver does not activate CPU tagging. Additionally, the switch hardware
was not designed to be cascaded, and DSA links never worked because
CPU tagging is not enabled for them.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 2637884fe472..a1641378fcbb 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1999,6 +1999,13 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 			cpu->trap_port = cpu_dp->index;
 	}
 	cpu->enable = cpu->mask > 0;
+
+	if (!cpu->enable) {
+		dev_err(priv->dev, "no upstream (CPU, Link) port defined\n");
+		ret = -EINVAL;
+		goto out_teardown_irq;
+	}
+
 	ret = rtl8365mb_cpu_config(priv);
 	if (ret)
 		goto out_teardown_irq;
@@ -2010,6 +2017,18 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		if (dsa_is_unused_port(ds, i))
 			continue;
 
+		if (dsa_is_dsa_port(ds, i)) {
+			/* Cascading (DSA links) is not supported yet.
+			 * Historically, the driver has always been broken
+			 * without a dedicated CPU port because CPU tagging
+			 * would be disabled, rendering the switch entirely
+			 * non-functional for DSA operations.
+			 */
+			dev_err(ds->dev, "Cascading (DSA link) not supported\n");
+			ret = -EOPNOTSUPP;
+			goto out_teardown_irq;
+		}
+
 		/* Forward only to the CPU */
 		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
 		if (ret)

-- 
2.54.0


