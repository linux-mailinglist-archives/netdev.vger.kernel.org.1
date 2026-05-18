Return-Path: <netdev+bounces-288793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJbPLLpmCmq60wQAu9opvQ
	(envelope-from <netdev+bounces-288793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:09:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF5A564AF3
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C73C301EB64
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 01:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B61EB5C2;
	Mon, 18 May 2026 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL2cObdB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1FB1E376C
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066522; cv=none; b=rZUM3LkiktMBSKqE9bWqF0GQX4Ujv9BZOsqMmrrUjmHdhHsR5SW88eVtdoVLahK19/i0qabFlw9+GPnnV34VHRgKPyt7GkwhNhvRCTA5AMJO5rSsuAcZjxjSs+5F4kgKha1Sc8QYTUOtBoy1W+W8VUgaxMf8DtZWaMprgA9abKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066522; c=relaxed/simple;
	bh=EGbaGXm1KEh7bRVRYdO+IOFneWGsvqaUFKX8qeLpD3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFq2onjDsYSdvVH81RLeZjaKgnPOVyxpHbcn1SNTL6lQ0d2S7yIDRCR+K/aicsGHIaKw/sIxkyTWmIWfpgCI3XmN7duwZh+eku4DZ+n+ZiqdNBwqzL4vqn8qyd8XaqF3lTseTd68kJJ4kTXMGa9ZI7BT8uNTwhPX557D6hVv6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL2cObdB; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12c1a170a50so1910287c88.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 18:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779066520; x=1779671320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAKq7HDrzn6e0Uev+H/X2iXbpfpwJvQ1xxnMc0EwXS4=;
        b=AL2cObdBzHZwh38g3MACH8AS68WmiSu3/Zlv7xQ3kY0PvZ42nK8v7Dxw/O0dBXF2w5
         fQCnFfEC7gOcdvTf7CMLW2Ya375z8UxUyCwvC3aFOawgmFDdzHxcrC9kfelFF21w8nCs
         kOtf7y+y3a7YyaAMHFv1kePmmj/Xkug3/bjorYO09pmRdt08UJdb1UKM26VW4jA7+bj9
         NI6lvq9DWloL4c3Vek6CRKFSlY1UTJXQRFD+T5vcQcErXmQa4eLHegXIhEaOMPuNT+Bd
         71o+rsP0VB7iNCGaOR+pgO4+LbwCAKiqqX2WMM4qknqnaqsJ+UskOL48wheMSiaDeHJr
         LEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779066520; x=1779671320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAKq7HDrzn6e0Uev+H/X2iXbpfpwJvQ1xxnMc0EwXS4=;
        b=h447L98Oe51dwgvPSMYtzjN6uyZkeO/RPmHjDy9f8OaEvbORDHIl5H8ULdxa2z7IPr
         zUpK71iKtg8jbE+P6Y4cjRJh/7zqB6XzqWcROn4WI9WdxqAjU+qxv0zfGs99rA0k5Iwl
         upU8X3M7qy1t8gb7ysUkvZYnJNTmcY7hPMT/qRzIu9gqg2rpfxIn0QzOhMXSx3UGpRyU
         sR5hHAfHk5Y151GFXfS4cLsXGWhx2PjmIf068n8+gHBnquhqXCHDg9PB2FlSMBxDRPBh
         Zvri0GEXqQXwImUb2lAapn0vMKjmOsMEvzsPB+dlx3Ky9CtQzqjZGpbaVK1wrEe2LE3P
         BrTw==
X-Gm-Message-State: AOJu0YwmHN1qPi9KsNcbIVU066FJfniNgsgeZzgqDV1ul03eYnLQktCf
	hTE5pviH48xsA/ZJY+OQqQjpf5k2XbJPxPvDzmr560+HgP7I82bPkGadTK3f1SZpA68=
X-Gm-Gg: Acq92OHVo46E6L7ghOQ8Bqf1rPlolS56Gu1bfwpEZSRtfFX4XO9rLxxCR95sEfS9kqr
	1xWmswe95ENihvK7cSeKkD72Y/3kpSGKkkxJsJWa0Jx1gtMJpuErfgBpVpE1RXZWdjrjh2rUMaR
	2Tf+qrlTv61xM6J1pUNL4VRhPJGCQznNyKixJY3VjVFKM4C7U6rgf/4BioFS4Abf5zm8j15Zbp4
	nmW1INOiqpPXmfRfX1pUdiIRWmQcDMURm3secy8okhIdE3X7qOrCh8KkH0OvNHozPhz2mZSz4ZO
	iwIyM1pWnyL7QjUv96Bu4F/2Lognxuz8OBRmM58aL99PuPaRjTpGVnP2RJoAN+eOATNyC+nY6ZR
	n7/0FigmXjNWCxJaYX+z60+Aub2Ya7AY+9lb2fzQzrsjOoXgI91/2+TrO67qXz5bjp3VSzuwjQr
	1/zL1xj4nEOfvKjdGqAq9TpPPv7d1Gyv18DdYAEBHod70RuEBmpkJbBsrs14WifRGLQv5Q+yZ6b
	5ecioDmzzM83gyNKo14NsrhmF+JSTTbgiKdE9x3yFH+Ii4vNwUMBNmDtU67huKIhT5hUWo+qiaA
	NNDCY5r5WxCnBwPTtg==
X-Received: by 2002:a05:7022:68a4:b0:12d:de3f:f3e8 with SMTP id a92af1059eb24-13504a4a249mr5174545c88.40.1779066520250;
        Sun, 17 May 2026 18:08:40 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm18891372c88.0.2026.05.17.18.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 18:08:40 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RESEND 3/7] net: arcnet: remove code depending on nonexistent config option
Date: Sun, 17 May 2026 18:07:23 -0700
Message-ID: <20260518010739.80979-4-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010739.80979-1-enelsonmoore@gmail.com>
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BF5A564AF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288793-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The CONFIG_SA1100_CT6001 option has never existed in the kernel. Remove
code in arcdevice.h referring to it. This allows the
arcnet_(in|out)(s|)b macros to be simplified by removing the BUS_ALIGN
macro.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/arcdevice.h | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index f1947342d67f..c870b8e21d44 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -374,24 +374,16 @@ static inline void arcnet_set_addr(struct net_device *dev, u8 addr)
 
 /* I/O equivalents */
 
-#ifdef CONFIG_SA1100_CT6001
-#define BUS_ALIGN  2  /* 8 bit device on a 16 bit bus - needs padding */
-#else
-#define BUS_ALIGN  1
-#endif
-
-/* addr and offset allow register like names to define the actual IO  address.
- * A configuration option multiplies the offset for alignment.
- */
+/* addr and offset allow register like names to define the actual IO address */
 #define arcnet_inb(addr, offset)					\
-	inb((addr) + BUS_ALIGN * (offset))
+	inb((addr) + (offset))
 #define arcnet_outb(value, addr, offset)				\
-	outb(value, (addr) + BUS_ALIGN * (offset))
+	outb(value, (addr) + (offset))
 
 #define arcnet_insb(addr, offset, buffer, count)			\
-	insb((addr) + BUS_ALIGN * (offset), buffer, count)
+	insb((addr) + (offset), buffer, count)
 #define arcnet_outsb(addr, offset, buffer, count)			\
-	outsb((addr) + BUS_ALIGN * (offset), buffer, count)
+	outsb((addr) + (offset), buffer, count)
 
 #define arcnet_readb(addr, offset)					\
 	readb((addr) + (offset))
-- 
2.43.0


