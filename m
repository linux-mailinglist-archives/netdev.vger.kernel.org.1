Return-Path: <netdev+bounces-306024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YOFiNkz+TmpvYgIAu9opvQ
	(envelope-from <netdev+bounces-306024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:50:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C9772BC2D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:50:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=I6YXr1c5;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306024-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306024-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E958305D36A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 01:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ED12571C0;
	Thu,  9 Jul 2026 01:48:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202A2EAB72
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 01:48:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561713; cv=none; b=AmCPNdjFDWP8Ups7CZFmz6qkfzHI9MWJwKm0C0FofPFdvkAM1ec4RWx/N4Fsy+ZB+eTGLK0yYF0UNaxbk+WtmthcORoW60+RObeDLHvSpNc1QAlQtWyI0pLwzDiBSCcuw0DXimpSpcVR+OaZjAtmJqoz9mvybnX/sOChykrt0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561713; c=relaxed/simple;
	bh=mVtBwVZyArQ0bhCJCcWF3zOmScZQqVquoXNBpOG3HVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRA+znMFyiLLxB+W31cTGArc4mN2YgkvT6IWhYM1rWIFd9QB0mqfg4DvCu4IsUFCrOyof8afeTSar4mypL8CVCVvU2/GR6RdJI/iXCn6kzgAI3nopwOqKsgaklGKjDm43+EMt2pj+U3OG0nmJVlX4+hLf6akOIYSICjlvM7Er4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6YXr1c5; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-847917c3678so283792b3a.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 18:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783561711; x=1784166511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgwoXYPeH8zLNs0z7+G37QoZ0VyUG0HqO/r1pL5e7z8=;
        b=I6YXr1c5S6JTTi0t09evDJK4bEWwl98vPHkCw9j6JUmxvPLIqMxdmZrwhTFgUv25vt
         +fOZB3QTRVgzk1GKDU8cfBRYyJsLDUvZtbRxwoxgUBnEiKLcgH38O3MYzH39zdgEhftz
         +ZHTFP4DKEoLLYrTMZ5rkrpGl2CwrIWSVq6FZUZ+SW5Z3Rv+7jV6s4nAyTdIeXLC/3N/
         Ru6AIMLFtq45/U+jTMYNcjRP8ae2lEYNzJwcNGM0hO9HLFQvKK66jpAIgZRoMI48OmOd
         +Rgp2M8r261GrYp+CdjBD4/INEXppVeEI2dM0QnKrMSZlMJGCfzsJfMWkCJGcGD37q1k
         KKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783561711; x=1784166511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qgwoXYPeH8zLNs0z7+G37QoZ0VyUG0HqO/r1pL5e7z8=;
        b=rr2tD6ixR4OhHnpxoZP9gR7VxLNcR2G/9RhK1fYcsqWwy5k2qocHKVPRW6KHS6lXVM
         QtUay7goMpG9znjU18IHkIwP1YjPQ2gnQ47kxRojFKoGp151l3ixTZZ0bVrjn3IlVRud
         jPDGdWbvc3hzWWGc7qJXew0FOONBp1WwY1NCzkiAZ5CkzSgvhHlvurYyRiCnuZUaxmYh
         DGFouAoWn6REf5kjh67htDoA+P+MEwmIOAcerMsOH0zTm3gpYcldgbF2AiWvJcUsAFRl
         IQIMCKNaOGEHqQjUsk9K38+yg1CoEFYIxiGtrz2UkdVtebZ1KsHIw6lT1IJg3w6ShokC
         dVpw==
X-Gm-Message-State: AOJu0YzV0pIxKScqw8Knl54revcOkuPYgzPAcRIie1z4lNdABof5l9Xd
	sjdTsztUQ2YUeGtVj4GRHbRBPNBCMZhmar169SUH7uYJ2Cmr8oRVdBGmG3wRuwSf
X-Gm-Gg: AfdE7cmm/8yrEYsQ4FqPxf4Yb2NnfhPikpt0N55brZlFb6MCXPdNl/+/2yqjBxKvei5
	VWp7fGC+x9LB5oEaVhaJP0FlieQtsaQMOjFlUTnbOLixAxtZGuLlTKC7d9Epv1UESqRI2Xw5cYR
	R0g8DwJIAhV5V0cP9rAWGSSbu+ESs/P1lN3pTpllvyB88cKEgAMDcW3YlT1n4q0aBTk7QuP7RW+
	Sl/nkjKAhxp9NagUQ/E1tV4stSjcSMsVt7nUpPsnmPhbm/D9NstOH+w1x8KZu00JF9e6ZoeUx82
	HRUBFYJaRRfu/pMplJg1g9NgAtIeOrCbK1gc73zGUlXOaf5VEBKE94LPBRBCuZbQXcTZ/+/FM6r
	pEX3zUK0//6nUV5CnT471JaOYW98r0rfIu+6xKAPGtHKrzD9Byzmcn8gdBD433iy/16vLVj9zFj
	c5h2dEjxzxaC5bobdyMDn9eHvQJR+iOIliFw3Ep8Wm6vr8fxF9Vg==
X-Received: by 2002:a05:6a00:2e28:b0:847:8791:f54f with SMTP id d2e1a72fcca58-8485ab7c6d2mr792367b3a.29.1783561710920;
        Wed, 08 Jul 2026 18:48:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:3046::4cf:38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b97bbesm8072434b3a.17.2026.07.08.18.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:48:30 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/3] net: dsa: motorcomm: Move to subdirectory
Date: Thu,  9 Jul 2026 09:47:45 +0800
Message-ID: <20260709014812.1158178-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709014812.1158178-1-mmyangfl@gmail.com>
References: <20260709014812.1158178-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306024-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34C9772BC2D

yt921x is already the longest single-file DSA driver, so it's time to
split it into parts.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 MAINTAINERS                                    |  2 +-
 drivers/net/dsa/Kconfig                        | 10 ++--------
 drivers/net/dsa/Makefile                       |  2 +-
 drivers/net/dsa/motorcomm/Kconfig              |  8 ++++++++
 drivers/net/dsa/motorcomm/Makefile             |  3 +++
 drivers/net/dsa/{yt921x.c => motorcomm/chip.c} |  2 +-
 drivers/net/dsa/{yt921x.h => motorcomm/chip.h} |  0
 7 files changed, 16 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (99%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06df1171f4cf..b007f20b2763 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18039,7 +18039,7 @@ M:	David Yang <mmyangfl@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
-F:	drivers/net/dsa/yt921x.*
+F:	drivers/net/dsa/motorcomm/
 F:	net/dsa/tag_yt921x.c
 
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 4ab567c5bbaf..98e9bbe47de7 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -72,6 +72,8 @@ config NET_DSA_MV88E6060
 
 source "drivers/net/dsa/microchip/Kconfig"
 
+source "drivers/net/dsa/motorcomm/Kconfig"
+
 source "drivers/net/dsa/mv88e6xxx/Kconfig"
 
 source "drivers/net/dsa/mxl862xx/Kconfig"
@@ -158,12 +160,4 @@ config NET_DSA_VITESSE_VSC73XX_PLATFORM
 	  This enables support for the Vitesse VSC7385, VSC7388, VSC7395
 	  and VSC7398 SparX integrated ethernet switches, connected over
 	  a CPU-attached address bus and work in memory-mapped I/O mode.
-
-config NET_DSA_YT921X
-	tristate "Motorcomm YT9215 ethernet switch chip support"
-	select NET_DSA_TAG_YT921X
-	select NET_IEEE8021Q_HELPERS if DCB
-	help
-	  This enables support for the Motorcomm YT9215 ethernet switch
-	  chip.
 endmenu
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index d2975badffc0..138225baa4d5 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -14,11 +14,11 @@ obj-$(CONFIG_NET_DSA_SMSC_LAN9303_MDIO) += lan9303_mdio.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX) += vitesse-vsc73xx-core.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM) += vitesse-vsc73xx-platform.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_SPI) += vitesse-vsc73xx-spi.o
-obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 obj-y				+= b53/
 obj-y				+= hirschmann/
 obj-y				+= lantiq/
 obj-y				+= microchip/
+obj-y				+= motorcomm/
 obj-y				+= mv88e6xxx/
 obj-y				+= mxl862xx/
 obj-y				+= netc/
diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
new file mode 100644
index 000000000000..1fddd386f866
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: ISC
+config NET_DSA_YT921X
+	tristate "Motorcomm YT9215 ethernet switch chip support"
+	select NET_DSA_TAG_YT921X
+	select NET_IEEE8021Q_HELPERS if DCB
+	help
+	  This enables support for the Motorcomm YT9215 ethernet switch
+	  chip.
diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
new file mode 100644
index 000000000000..afd03be9fa35
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: ISC
+obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
+yt921x-objs := chip.o
diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/motorcomm/chip.c
similarity index 99%
rename from drivers/net/dsa/yt921x.c
rename to drivers/net/dsa/motorcomm/chip.c
index 159b16606f6c..f070732845eb 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -26,7 +26,7 @@
 #include <net/ieee8021q.h>
 #include <net/pkt_cls.h>
 
-#include "yt921x.h"
+#include "chip.h"
 
 struct yt921x_mib_desc {
 	unsigned int size;
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/motorcomm/chip.h
similarity index 100%
rename from drivers/net/dsa/yt921x.h
rename to drivers/net/dsa/motorcomm/chip.h
-- 
2.53.0


