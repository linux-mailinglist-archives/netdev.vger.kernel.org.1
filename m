Return-Path: <netdev+bounces-296080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QgiNF4naI2rjzgEAu9opvQ
	(envelope-from <netdev+bounces-296080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:30:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E657764CED6
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:30:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="XGlwp/Kr";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296080-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296080-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2703730215AD
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 08:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A32316199;
	Sat,  6 Jun 2026 08:29:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F9524F
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 08:29:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780734598; cv=none; b=TrOA8hJLGeUyFdICigjxPk5chpU46Fa4O7Y53d2LTx+6MygE1CpvU+ctTtHOfkA4px17qqMNhhkt4qT29+3yqke8+Qg+wNBybCRj8kV28egTbzjv9aulpBkRpn2o2xBMTt7LGuPr8iIhmVCv2EC2s/qgrEw61UngC3dD7zGCgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780734598; c=relaxed/simple;
	bh=LJI1mTt5T0OFZe90AgpOUo9cgLT4qEmmXzwTeVD1xZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=naK6hcHtX7HjnufjnaCK/0UDZdrov7hk60p3s/rBHMuc49BDB0xlzJgLxaDn6Mm7KRPGIzFgprxhR4AHfIYPTx2Kl2Er3QY7BGx2/6BvO3Znv5W7TmW/Ou9maw8hPzpsDKloIVCiw/uq84+Ct/Vk305nBvzNcutc35N3T8r/YA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGlwp/Kr; arc=none smtp.client-ip=209.85.221.170
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59f8a140a51so1724049e0c.3
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780734597; x=1781339397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vFn2mXy1vj757WZPxDW+LyElp0xHloQfyO3c1ZOegg=;
        b=XGlwp/KrlluG/Ad8IR2EZx50xgggj1QB6IIgVwFRL/ArHGFvaDtMX81ElIuEhcmBYp
         ZYa+A3SflsqTOPhbIfhJXNoUNunrgCuMyrN4K9/S98N7us30pIG+bQ60vJfxz3vU83dC
         k73ez4/uappDXTZAjAMRBE4iR1Yk6qNojXq9neeDdYT+GA41oxcmXll6OO1CRL15zXUo
         EaHgCNnPSUabfZXsDCyVuY3iKWYhnntvirDG4fwVeAf/0/JvC1wIpIL2UKIxNNJU041m
         l8nzm/jYP9oZ8WiaUV5MurT+oxIb9W8TMhOS4ycWjZLhW5+d0joRXLEGxoMxm8RGBqC8
         eHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780734597; x=1781339397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vFn2mXy1vj757WZPxDW+LyElp0xHloQfyO3c1ZOegg=;
        b=PSrWLHWzWk2SlWYR0jGF7VyIRT+t/LBnobV/9nRe1rtpjFwEfoS9fDfRSB7a4+1Tq8
         ftJPYmuIBNJ0BaNCEgylyMrZb2ZAg3K+SKFUffWHHN2BkVOkJw5ClFAo9v76Iun2CHIe
         u8127Ky0jUkFVYGXmdVKAIrbJuz6MnFeBJtlz7c1AcNPYSnoJMHcF3wvY0b9fFa5wSln
         hrm4mqSzs1CHd2P9G0yxuwlBYPYmc6NzTI0Hw2OYJbIado9wDueG88Ro8M+cc4EG9SBv
         UOfE9+V1XCu3r0MfZ++PAxGuosOvkF7f76Pymm7sdng/Rtfqk+FzM6Qo33U8zA1My/hC
         s5/g==
X-Gm-Message-State: AOJu0YzvPujLYSCf2uVaEa1OtqjxZE8WiEZXj56tWG1oNnxcPJL6gKlU
	EnEeKJ0q46t3Py9AzANbRRRBY+8MYLx7Z8Qdnpb+kW2nb3B2d64VNzCvroIZ3J8U5nM=
X-Gm-Gg: Acq92OFKV7DDIi56w4VVh7dG5TVetk4ndadJr+WengVbA9NdKG47B19kzKkLm9JfDAE
	o9gGl6p9K6PMj+R8ptBZzUrzoBKH7QrT+3UVZEb+8oZurFJj+FXZge8p2L5QyF0QVlIkP8ltJ91
	C7mcXQHCzSC0mmKsaVL8JARccXqS6zXJaxQOg+lKNMilFzkjkbbaXFVsXygA3iQYSM5oPzoesjF
	UQaFmN+UVBLvI6gtCs4Q3GW0i9BnjOa8kgrLsjs2PAdZA61Dl2oCP7qN5cmFOgxA1KJOm7x56qM
	08e1gaC6rJYefm6d2mKAvVZ31zvsEeIktXxDHLuYcsI49mtyZQxrBIgEopktLljd+HKMffvtH2v
	8w50A4UjCfKhybRQLUqlEeOzeGqnTUf1Ob3EdDTlCIbGpUWlreQ89lQJWyl4glwjuF4cgwfxDmD
	hv1Ix5KXyRKdq2rc01CjPAletk9TNamzfOKeUszVkDHDfixk7JLyBeCXgzuOUk
X-Received: by 2002:a05:6122:45a8:b0:5a4:3c79:f5a8 with SMTP id 71dfb90a1353d-5ac477d7f60mr3843787e0c.0.1780734596716;
        Sat, 06 Jun 2026 01:29:56 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44d233sm9630281e0c.10.2026.06.06.01.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 01:29:55 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 06 Jun 2026 05:29:26 -0300
Subject: [net-next PATCH v13 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-realtek_forward-v13-2-b9e409687cbe@gmail.com>
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
In-Reply-To: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296080-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E657764CED6

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


