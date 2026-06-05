Return-Path: <netdev+bounces-295623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +1uiEedXImorVQEAu9opvQ
	(envelope-from <netdev+bounces-295623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90883645171
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:00:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Fxo59hRy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295623-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295623-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F36B303CD2B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 04:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A243B2D38;
	Fri,  5 Jun 2026 04:56:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B663B1EFC
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 04:56:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635406; cv=none; b=LWnR1wpDGtl+7tni+BYCqiGLWjbyRO3kIzemj818am3NkRz+4DvwaYvO6mV2rt0UdYk2wNQESNCfLl7jkflyY27NSZ6aUxwLsCmHvz5AxjmExbUPZXgc2je8dlZe4HPP7zCJm7gs41IfMNzTD2ofICHWlAGuSHHYLtOwRAa7gVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635406; c=relaxed/simple;
	bh=LJI1mTt5T0OFZe90AgpOUo9cgLT4qEmmXzwTeVD1xZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OK2meNAR53vSDFkPPjcNkqZxw6OX+40YvH+on/N3X0AD4AYLb2/SDuUGZRWHrXYbB2F/YRGfOvMAvRit29oxGTSkuVaGX6iTV5il1l4n3+NPBtK+Gi9fsZjboe+ysIGvhKLC9da/5cbvRm/J/legrzAumNd+Bl2dWrJC/lwyoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxo59hRy; arc=none smtp.client-ip=209.85.128.169
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e16f05fd79so16954317b3.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 21:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780635404; x=1781240204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vFn2mXy1vj757WZPxDW+LyElp0xHloQfyO3c1ZOegg=;
        b=Fxo59hRyysel366nC+klsgx6eu5vhridrgLsf2Xm4jLX2Hn8Dxt1xzsidHRhCNUlVb
         cYuYfZZQD5/NBo96pXSTR5dMu6wn3zvVey1e9qQIY5qD5HoBd2idYokoF9HO/7uRsFlx
         SjRssGcHKXYd/hMPjzqnuJUKktBxJRS/Q4MLfsXRjz41ELBO23fRIfdeTcVlxb2+nU7j
         YICc2mtK90JO3TZ4PWRBhp7+WHM856SkhmkpCA8qJf+Nck1EdM5K0cQ6ah5rwNSthpQJ
         g4mqv9IQAOAIGuI69FRrpxYNoZF3U3VpAYwexhXsuM/tAcQQ0WpAI7wTMmfHYSLUq99U
         oX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780635404; x=1781240204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vFn2mXy1vj757WZPxDW+LyElp0xHloQfyO3c1ZOegg=;
        b=qqSigWaCZtC5hivhA1e7zAIE3tbJp92BinFyuewSDD6HZ+c1Og5pzQFcxIqRVyK8ZF
         NHCivVuZQcXMn0+5/13v1eLfeqoP7aWK2ZphNufcvogP47PXWzXazI2zswMPv9Pns1KB
         +4nrIkryXAx4AdVxXY0JrBA8QitJ/cRJPYlOe4sAzXRhQqTnfeHrilKtb8+mgk83bHvS
         p0zK8aFeMwoay7GHhGvSpUSV6hbkvhBc4/mJBVR++toOAHf9vojxU/RBQ9ZLE4MLpKYO
         A6RAd4qgnr9RbkIE5aXIibwQof8tQue9xA4G0NGaIrJkJu/wxxd/ZFdoMS7nN3uLcuLr
         dshA==
X-Gm-Message-State: AOJu0YyW0mLf1odLfy2dWU/fiefnWSBRmMg3uVAFly42qdNutiSEbxxR
	oY5e62CRND8YofY5yTznx4Cd906w8pf8HJz58shPNBPMbLW4d2NgOWyy
X-Gm-Gg: Acq92OFba9YePeH0zOzcEHt2Z3d1QxXwKMDknnppReZdcA79TVAwntNKmWYCPBGYYDL
	IQ0JeJjZxF11rKi1rqe+/JbGWIhu9KbHP97IWMxnGV+91mLE+Cz92sYUdhJHBTlzSukin8iEoMj
	YyDNcPoHYYfMq/uwzgcVahOx3rQKi57Xf85iA9iiSpG7jknl1TqHdW43C//bHOy79OumkwJiQti
	uR2RPySTJMhVeNeHNmSzoipW0Y3Xalbk0Rb/jtZ1pphds+pRTztQ8P36ldFXMY6qzCmyIWVN/sV
	AS/Q0a9yLAaGluzLweHXfXBuNQCcJfC+jgE4VmGNUqeJ/Wbe2Yc2WsqWJvRaPwgya/lKBD+wnEI
	ZeuUHGWoc7nFsrVWkPWi2ouOSfIruq/KXf0Xj/JUL4RD0xVfPcGcdPTk5xVFdW4FVTVGmWyUzBu
	qKLeP5VpfJRyN4OymH8UPxsvCT6LO2ozFUywNU6bbesooariDCoyagkSuKk8BM
X-Received: by 2002:a05:690c:ed3:b0:7c0:82ec:fe82 with SMTP id 00721157ae682-7ed0ec54fddmr20452407b3.11.1780635404624;
        Thu, 04 Jun 2026 21:56:44 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea215825d2sm45840207b3.16.2026.06.04.21.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 21:56:43 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 05 Jun 2026 01:56:10 -0300
Subject: [net-next PATCH v12 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-realtek_forward-v12-2-78eb7b31df72@gmail.com>
References: <20260605-realtek_forward-v12-0-78eb7b31df72@gmail.com>
In-Reply-To: <20260605-realtek_forward-v12-0-78eb7b31df72@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295623-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90883645171

Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
cascade links (-EOPNOTSUPP) during setup to prevent silent failures.

These topologies were already non-functional. Without a CPU port, the
driver does not activate CPU tagging. Additionally, the switch hardware
was not designed to be cascaded, and DSA links never worked because
CPU tagging is not enabled for them.

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 2637884fe472..37e1d7654b1d 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1991,6 +1991,20 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	else if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
+	for (i = 0; i < priv->num_ports; i++) {
+		/* Cascading (DSA links) is not supported yet.
+		 * Historically, the driver has always been broken
+		 * without a dedicated CPU port because CPU tagging
+		 * would be disabled, rendering the switch entirely
+		 * non-functional for DSA operations.
+		 */
+		if (dsa_is_dsa_port(ds, i)) {
+			dev_err(priv->dev, "Cascading (DSA link) not supported\n");
+			ret = -EOPNOTSUPP;
+			goto out_teardown_irq;
+		}
+	}
+
 	/* Configure CPU tagging */
 	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
 		cpu->mask |= BIT(cpu_dp->index);
@@ -1999,6 +2013,13 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 			cpu->trap_port = cpu_dp->index;
 	}
 	cpu->enable = cpu->mask > 0;
+
+	if (!cpu->enable) {
+		dev_err(priv->dev, "no CPU port defined\n");
+		ret = -EINVAL;
+		goto out_teardown_irq;
+	}
+
 	ret = rtl8365mb_cpu_config(priv);
 	if (ret)
 		goto out_teardown_irq;

-- 
2.54.0


