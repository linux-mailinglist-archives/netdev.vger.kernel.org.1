Return-Path: <netdev+bounces-295625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Us/GIztYImo0VQEAu9opvQ
	(envelope-from <netdev+bounces-295625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:01:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE82E64517E
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:01:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Qxb2EMvh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295625-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295625-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1CB43073721
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 04:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692F03B2FD0;
	Fri,  5 Jun 2026 04:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EBE3B2FDC
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 04:57:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635421; cv=none; b=F25ofe75JGRoJjfAztdWQc2C4SxdkxxO0P2X0BWhl9Op87dq4ha0SJ+dt3QxQyPXgQWsKpu/lFo0YaYqFfx6rA4g2Ko5e0t3mApXraPZYGJNdDHPti+4Rb5TMQlVtPN93DlahEsSIo6NDL+04niXeej0DpemDCAZH15IZKDxXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635421; c=relaxed/simple;
	bh=uaVDHzjUs+dokQ3wPGoMZge3lrsY5L04UHdr+iWbJn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSlGLzWZQa0pc3Wk5t5wfIkv2bYB1xtgWvWooVJt0GRGZKBtJOivmcYrfzvRiIH4Mya91K5CP4oHL44JJI1Un7HE6GPYdoINwW1x103O9jedTE77ErKQOV4msE/pdhECrAUwxnvEzUziEhXk6U/5Q30mp6AGnunXXv1VAUfn4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxb2EMvh; arc=none smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7defee656dcso10921207b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 21:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780635419; x=1781240219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=Qxb2EMvhCFELLX/7K6orIDs4+3iqx1ulKZ5kXK/t3Z6dI7NBg3sGSKmjGippCLQdhJ
         8QweYvnHbUQMUtoyqwGfUEx2vSAflIGBeq4G6Gt1EC7fENDCct8DQ8xyFYrzHMrrpGIv
         0PNbMn+1BXlJEHKQ0Dor8t3ItCXAQ0XFNKZsV75K1/D0+MhiTiPJ4yINs6g+9Q1Jyoml
         BvMkCZKmzfOX3qn/OQZdGokAiUOubdBxgzeKd+lnbzm4RWp3CxjvYUzqzbFMrdxX/rwO
         Roihx6tT08D//YsHQS/kuAg1paHA/bD3OsgD2szMR1js7KZBEzlmorAGmeb4q74FE9K/
         5VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780635419; x=1781240219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=lREHHYAgtLRqpLp33jxRQsPkY9Y02TfGsg/6yVcbRZby1YoMcIprse7X4e/QA/fwdm
         jnESIsbBGZYPU028sJ1zK3Y1Bg8PHN0mZ/d/dgr2/TlcyV7sed2FpVSpv6l0L0ZBd31y
         0uQJDo8VBjV6RL3yy45ptQinl9oSUqiGqPh1KWNNTSMubL0ENtLL2yjBhQ33IZaWUQkC
         UYhnvHXk2r2g0wU8U8DrUl+jsIXzkV6mnzzIy1vmElQUIc4FclHCWvshEY9A8AmOhsMk
         e0vr5dOH8RXiZNoXi9XKoRwFXfEp8rXbiyDXvzoaQUbwFncUsvE7hCLS7GsOa7DX131e
         KTaQ==
X-Gm-Message-State: AOJu0YzrJuvDcWzgSMWHwxmo0riHj6bO3GIyd9TGRPr4+alhFfjURKLk
	WbYaZP/rRbEMb02/Zot+cC6P8l7jF7vz2PNaCLSYiY4rKdgWQGnhk1Kw
X-Gm-Gg: Acq92OHlk/WtdMbXAfirBSTV6Yvq+HKs1Xu+CghfPvzyeKnqZj3ekkLYSqATEX9OVkp
	d1hvTz0ENbcBvFC9c5hXrAKHiKb65YrX+//dRnwgVgnjKKpvUU7twGTUKPbrtWjuyQ/NNB3SOtv
	crgdBQzMLSZgPs0iqyJSMn52HhA9GZP/UNLKO55x5Ft8MHbD7NXFK+ofDhkx3aGHto88+joo0ta
	kieU+TCL/3IM1JP8j0lrbHpSkQK5ceGfFKVmSbCBFv2J0eLgO8T9clSIw2VCrVBUHvUCC6/D1ZX
	LW036kFsdbQu7qXGKtnqDUjdqsqJWxTdepa7lNzYPSpnRFCyvDHFf8FIPZzS69CAhx6hVM+mkkL
	iiSmkDsmqzsatQr0ZP4/VPoccW7n3zBBb9VL9J7iHv+EBPWYP529xYj6pkjy7w0y0eorVvLM2ki
	A9oa4QCetGUv4EKB5WSD9EWSUbiNJgLIQ9lBWkBf+78eYFBevifw==
X-Received: by 2002:a05:690c:6187:b0:7e8:a091:90ab with SMTP id 00721157ae682-7ed0c61a105mr19443887b3.7.1780635419364;
        Thu, 04 Jun 2026 21:56:59 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea215825d2sm45840207b3.16.2026.06.04.21.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 21:56:57 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 05 Jun 2026 01:56:12 -0300
Subject: [net-next PATCH v12 4/9] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-realtek_forward-v12-4-78eb7b31df72@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-295625-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE82E64517E

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Rename rtl8365mb.c to rtl8365mb_main.c in preparation for subsequent
commits which add additional source files to the driver.

The trailing backslash in the Makefile is deliberate. It allows for new
files to be added without clobbering git history.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile                          | 1 +
 drivers/net/dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c} | 0
 2 files changed, 1 insertion(+)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 17367bcba496..3f986e04912f 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -16,3 +16,4 @@ ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
 rtl8366-objs 				+= rtl8366rb-leds.o
 endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
+rtl8365mb-objs := rtl8365mb_main.o \
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
similarity index 100%
rename from drivers/net/dsa/realtek/rtl8365mb.c
rename to drivers/net/dsa/realtek/rtl8365mb_main.c

-- 
2.54.0


