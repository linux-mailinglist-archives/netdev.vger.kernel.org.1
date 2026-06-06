Return-Path: <netdev+bounces-296082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xhw/NBzbI2oFzwEAu9opvQ
	(envelope-from <netdev+bounces-296082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:32:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0164CF04
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:32:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=koeu5mpi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296082-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296082-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9085D304EA0A
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB33317158;
	Sat,  6 Jun 2026 08:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83F3148D9
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 08:30:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780734613; cv=none; b=VMvv8W1wkML6ZsMdnD0vfNTOc480GYExNH3Nur9joaN739Y/NeVPTWycXPFUSQ3ZFRq+e0/GpdKhaQgMa08loLOGXRZfIZVtBE8RfHP3GJGgDbwbjUK6lShPDHwKEl3S6ZjhIqTq5fsnjS99sF2C9IV2H7+A9KwiZBvn1/7e4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780734613; c=relaxed/simple;
	bh=f96ni18UCQo8W54HCO3lR2sfVtmlObi17Vh+XDoXVgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5A2DxfJdckzvP5pSTuUoFyesWo2XG2BWfBbSWZzMYhHO2U6ki1L6jKYzxhlirAdleaZTxqeNqk4Mhm1iZRhFnM66uFPofuVjomrqi80zd5Q/pw+ypqhHEyM6EVpNc9YCM8vt/0mBhY3b3NUPEhXa9VFhqHwgqskeAZwSTtj2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koeu5mpi; arc=none smtp.client-ip=209.85.221.182
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59c2a81ca92so1607399e0c.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780734611; x=1781339411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb5xCGFoP2O1++/MEWDcoaTxcJNsam+IAW5mpFnC00I=;
        b=koeu5mpiZenADcC/H2SGUugdIlKYa2VGI4GsEeefaWTrWVrmrd532jYTrTgtwQm6Fs
         mQcnI0fXeVc1Bb+F3kk9OXoqWh76KlgazsWAcfb0miNIx2Y13CMZPyPtQoSHQ0Mc+5Fm
         fECJi1aEYMJa8xmykTaDpwISzexZsMHS8nXyBiwRj2RP1HMJIWTzaW9izw2mc8YMoD+s
         sY/oqOUch78Ms0av0DSU2ic/ZjZNOBY2J++x2juAVYUW4vZVYWvu42c8zXhtFgjCUGLc
         n6zmwehAkqhhdmGlvjwKTl/NxIy8DANzhhk0A6JiYAPzxiE3n14yJKkEVYdoq8H78DSo
         qRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780734611; x=1781339411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mb5xCGFoP2O1++/MEWDcoaTxcJNsam+IAW5mpFnC00I=;
        b=L4NjVQVcTSJ3Xlq7l1zWJIT0kI3T0HUqEdNlf3imDX1G2vRqj4mywxJdjxS/jyK6w0
         6m/itEu2xzmPEQ9gZCHLrxL6cfEc07hQFqqgsGGYHR/0A1cpBL+cv7587ZILf/A5fR4U
         kexWKe/7iZvGyAknmPH65iDZ8XBsGkAlegV4lEXVkS0oyHA/jnIiaVRNtlGmDXgkVvQt
         M1aYpE9C2Sou3gqoWwxiIkymFxf4xSfxYGmRMQfdHtVTZJkb+bFlRw8gHuf+0sRI1ph8
         e8z8pUpM8SBo+LZQJmiElNn8Vj002hr+tJuO87ChYhGMs8aylOlygRg9Z+HUo8HmJ7bx
         nODQ==
X-Gm-Message-State: AOJu0Yy4XoohTAL12qHtr5M56dWy0E70clJ7d7tbLtvgTyjRDfhS3S9a
	Xegpp1mhEzYgUjbzf+/vuuWN6CBPxYNQV00N/6MUlaNGT2O8MNmusS4NuoOkmgvLcyE=
X-Gm-Gg: Acq92OHUONMxJOPjAtoPGHx/lqBrya+YTfz+RDGk7fwKkbLLvC3LhldueCiNanAyKOh
	7JGQ8v6g17yHVH0B0CViaonAnX0L9oANbb6a8itcO6g+yI4sGK2o5dFLrvDH1XaDDzbpDxV4siH
	KfZzPFWeqvWtjVBLSv8hbPgm+S0U7CL3OdQTQ9Zyg7LSHWHXVNYU9I1DFQjb/UeYxhDtjW42AUn
	8mLwPJyZFG4Zjih3Wu8PQhWbQe8ue9rL4DNfuD8wSeJGDA8svF7a1bQUL54VnKjywUEfLWjxHYa
	4A+1H08DEvwmFxeyTNAs1KhgaXfj/Ar9KNnkWY4UWN/kCzIuVpyTaqy8TOQROFYVNKKTBRB7x/L
	TX8D0AVGj1181Iq+oPsiFCTnsGCtV51RdpfCCKXSBCYBBEFMeHWzlMT/cyoBKxbAH/rK4lf+bAk
	EGvTxcQDaWKCaQ/NnSXf9+ImV0kfzw0dO/WCXDvdGWn+/2mgeGBw==
X-Received: by 2002:a05:6122:134c:b0:59e:71df:c64a with SMTP id 71dfb90a1353d-5ac56d63fe1mr3705329e0c.10.1780734610782;
        Sat, 06 Jun 2026 01:30:10 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44d233sm9630281e0c.10.2026.06.06.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 01:30:10 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 06 Jun 2026 05:29:28 -0300
Subject: [net-next PATCH v13 4/9] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-realtek_forward-v13-4-b9e409687cbe@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296082-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CF0164CF04

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
 drivers/net/dsa/realtek/Makefile                          | 2 ++
 drivers/net/dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c} | 0
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 17367bcba496..a1486e7edbc4 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -16,3 +16,5 @@ ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
 rtl8366-objs 				+= rtl8366rb-leds.o
 endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
+rtl8365mb-objs := rtl8365mb_main.o \
+# end of rtl8365mb-objs
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
similarity index 100%
rename from drivers/net/dsa/realtek/rtl8365mb.c
rename to drivers/net/dsa/realtek/rtl8365mb_main.c

-- 
2.54.0


