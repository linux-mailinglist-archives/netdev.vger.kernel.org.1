Return-Path: <netdev+bounces-290161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP0RLoBQDmpe9wUAu9opvQ
	(envelope-from <netdev+bounces-290161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:23:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10559D455
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AE14302E924
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854F1FC7C5;
	Thu, 21 May 2026 00:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH3eK+J4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE01E5B88
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322664; cv=none; b=ZjSfpLaKuYYDVlFT9dT85uujTNdv0hT7HYUlfdl49WuDfAzjqwVbTZnnhESEHoWz2Bhjj6qGHflPIBqxVFVAepqQpE3KvW9Zg28kihJNq/GJO+7lRMThRPFxto5j/0KwIUyjVRTdhReofiyc53jaGxcC/DVE6qViDzk2mORf7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322664; c=relaxed/simple;
	bh=EGbaGXm1KEh7bRVRYdO+IOFneWGsvqaUFKX8qeLpD3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2EJLCSIGnsf1himSJnOgr0KOSDd5EN2ZdOGFurwV2rwm6BCx7NfddErvaa1xTBJ+EbwYtQJ4AQg9jUAIVkUiPCvRbAZZSF8NsQFsygaLB7UQ+bAZKuXVh2+ImcKG86XOYoHAwKUlnxH1YvE3dIe28/LLndiZ4or0V4W7Jgvnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH3eK+J4; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2f7020a928eso7946971eec.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779322662; x=1779927462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAKq7HDrzn6e0Uev+H/X2iXbpfpwJvQ1xxnMc0EwXS4=;
        b=VH3eK+J45/s32uKgXkLx4OvtoqcE+BKe+a9Py1wEnd6jTnegNAJ4oT+jt+4KVhp8IX
         bIS6A2SrFOeI7c7Pea/XgVqa9qP8F/HU2ZQYiYcx9tSRncYW1B+/T3sy3mJ2PnMwOv1u
         jw8/aop++veR39imSc+fGiDgbGYIAQ3F6ZR8n/fgDarXdnayIqi2q6Bz1jZDBYKBaAjU
         +5DW7oep2i4vhdAlUI5mfQpTVf5h4oZ3xAKvutzNhE4bhJSq4TAallQ1DtffEKSopRrZ
         2Z/YJkxlv9HiFr7ZHsx0qt7UC6lusfGL4R9BPxhzHDDwSMmQvuSY8+3ANaGYwiTaio9U
         teMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779322662; x=1779927462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAKq7HDrzn6e0Uev+H/X2iXbpfpwJvQ1xxnMc0EwXS4=;
        b=MZuFrX1TymPImoqnf7L8RNHeY/JSjl91xoUzU2wcC55DyhpY6R4SEnVeJgPK4c84co
         vWtcQah4MZkh0J+47cCQTUocU5ybI0KMukzSIAUWJSu+oKOHbxACYdNYHGNIQuy0jBwV
         FgySPOFkNALLGqxHZ7HoQtZanMB1sMM8W4GEnC/OjEMk5DyEZc+9WmiEznRJZoPBqHvD
         tY8MsxFArRCDr1STatHFRsiYy/esmMaspa1uTZ4EzP7Nt4K9mgjnO8hKxU5nSKjeGr/n
         rRfh1bO41/Lmw+us/AoCtBMjI4MRhPOj5THgjbTZt2Uu49mriQP8EoKKfswsDxg3N1yz
         zong==
X-Gm-Message-State: AOJu0YyffbwZEaOk8wbMbPsQKcx9KUMRUTMPcyjXo+PnrE1icfIuqtZo
	h6vnipRNAjPc5NTpXVK6Z45vOAhWCuJUVTaolSBiNt5FNX6/vIhK40o7EgaCyUdVpa4=
X-Gm-Gg: Acq92OHNqYc0cqt+PuNi5zvvNufgMhhQyD7yNbGX+0yPfo/zh7gH/ghZeAqmx+ola5B
	9Tsf+rAQpwB2qvfV1Ul1U3v9DwrMEYUva7R8TvsnCu75Ncudz62g6H/kfNUn9jRud5HZHb3GK0Q
	xeyh6kyyOuRFRx1ew2C+RnOS8Q64N0CzOqr3MhFXPcrr714/KHnclMBvcBLeYG8HmV0DkXfZwWm
	7udy8McJdymer//5HOrIyMIDSB1+vxTM2yCc8hcP6m+yUXcVrzYu6QNzTQISyFWLMXxV8+lzTkX
	aC93LTNbt+MVYQ7Ce4WZOJNctGO5h53H4cyLuwmJCTv/KzzYybCXBRtTSOfWfJ2AC4qqU75VIwC
	QU/moGujsaLwCmw/6j/qzZSCnETxEMTtdmDbJ5TNPA0gWwsztzRv2wdHZ5ls2qU8JeEQEWjQ55M
	JQyAl2nlsHOVpGklsBhn0syG566uilqXw3g6Zl/mO2TV/rhlskcm0yIw/9E9GEWUJ7lf+zwlvid
	4FctO4f2IapC+GpmpQq6KbYgX8cqxwOQYUhWkiDxXHmjsp7yCufIQbFNdQ878bnZyXOVud4rxxT
	4AaoBh0bg7IXFl0cQw==
X-Received: by 2002:a05:7300:e787:b0:2de:cc07:e8b with SMTP id 5a478bee46e88-3042f476cb5mr480574eec.1.1779322662061;
        Wed, 20 May 2026 17:17:42 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm28444410c88.1.2026.05.20.17.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:17:41 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH v2 4/7] net: arcnet: remove code depending on nonexistent config option
Date: Wed, 20 May 2026 17:16:16 -0700
Message-ID: <20260521001631.45434-5-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521001631.45434-1-enelsonmoore@gmail.com>
References: <20260521001631.45434-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290161-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C10559D455
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


