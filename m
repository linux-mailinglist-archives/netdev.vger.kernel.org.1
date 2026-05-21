Return-Path: <netdev+bounces-290159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP3rBWJPDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:18:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7632D59D3E4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DD6530E0F7C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BD821ADC7;
	Thu, 21 May 2026 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihcHIOLS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0CD20299B
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322644; cv=none; b=RkQ5UsngxVkaqUm+emoQUnPLEttuPp/EjW0CzcqSgWOtfpvyCShs6nHX226BzDZ1oGVgdhk5HS6DGEpvh+xxup14TEQNxfMFFy16b5KoxLSY2SPpZm0Ly/Q4QxixpMTye1QRH2yxJpu8KhPQ3JctOCsj0PwT4OKnUBoBnA/0bas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322644; c=relaxed/simple;
	bh=sP88QMBkB5WFeA9rGvVYUSHloFGHJ5YYBpExVoA4Bog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDzi20XAzYxjYOIYSEPVWga34vvEeTBCqkQwLuCxrThrWCfrGV8XSbWvakIyRvQXaaGEHZkDdjti77TMODEDPTWkrH0l5TEAP83+qIf99sgVkOaUzlPiHgxWwvS966OtHTHxw4Wl+Cowiool2BhbWNrzPiFBPGLbNUejp+6TK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihcHIOLS; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-132d1b2519eso12615076c88.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779322643; x=1779927443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaqSbH53nnDwnuyvIsMb4KYjYHN14JziBMff4wFVy4A=;
        b=ihcHIOLShAJ5VRGdP6shONr03aDJs/VwhoA3NiBu6GaO1KFyn6Pkmxv15Q+CaYgavw
         BHh2JDnsgvH3MuOlAz7tVPjMHZ+gu2d3WLYETCFJEYG+pyz/hFaL1iA9o8ste8t0zMM6
         +/JM09gj0ANOu/Cu5vpA7Kion7DKa5WCfcZTJJ/sOagKqy401quHbLZ6SvwhxvC4+inJ
         h5jHvAbwjFbMzKWuWoM9GJwpaNBvQjbEkqrD6rASuZAIYmp+7WtrEAjKj/QCoauBXN9a
         oBqB0xTfAiScpu5KHggReK/zBzyNMQKwOAT0xEs/qliGPnjWJAQGjrjtrT/Nz2zMGpdu
         TIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779322643; x=1779927443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DaqSbH53nnDwnuyvIsMb4KYjYHN14JziBMff4wFVy4A=;
        b=kglbZDSuN/8vupw26IqDd39KyzP8xh5BlrOJzpCeoML49kjlLsaY/q2Ivi3/YASgqs
         PAyr/4wuEVIgW8hRRyBLdwsNrUlDwPTz9mB3Ye0faeZ9azu1h2ZRzluA2MNkZi1yqKh2
         PTKtrsydqMX4tle68zpIfine7su5OJP8NWcijmsi3zprQPlInhPvJQXqjA2q5r+T2z1o
         +tRM4zplWCRd4Dptq2DHyERT5AFPkqTyzOQZUCp3JksXKkb13ebQpHpw8lQPA1IwUi6t
         gDwS3ly36iFYHE9lFlCzzTJE9hamWZZX/PwK6bk4hu4h3E97puuAJ/+eF3TdvBbh5rHt
         aFIA==
X-Gm-Message-State: AOJu0YzPY2GG1DhglI94FQWmZCmlCLOMI8eehh0x0r/oZuEiD8HL8Wer
	oV3rIFenPFqWo0swvl0ikEqbWSGVxmFjSHfwBIyQulE27ItbvqYOtoE8shSMoyYcsnM=
X-Gm-Gg: Acq92OFcXRcVhdZV/rtEFMIG7lwfqb7XpMOF3/RI38OP6YZDz40QyrFSIFlWDgWl1u0
	fByZAOG0ohFDvj6JjNyIg/BzbYUV/JE38FYApwWbrN/FhPp020evjjBVS9mWtzzMaPIDw98KrAv
	c5Y86QOsYZ+kHOOt7UraoKl7Lr6eh7R4GC9qNm6/Noj8nAORhX2K74Nm1lCd27WCpVV84nSALCn
	injANWlmj98jr96JoX9rahzIXG/JvyuDujVmEDbsI9s4EPTZjEIwcRxtsjuCBYI/7QBBfh1PyMR
	aiWL/ixrN4xHt80d9lyNZcIo+bTkd6pBZcVrovWh3uTcGYJFudqr6dDRINR3e2xfJZiekVSLvB9
	+bxWvkEePKw+N2byCi73L0zFX61JYnQer8+vjxkFYlupPCrFZx6N8NBbJazWC6xIz+S1rm9HmPX
	jwV5MnEJbbgP1s6RvZO/umhrE5ghCotXAwOfyvMOSwk81Uebe72EKoSDJAbh6k0nf5U63g/TWnh
	OpYiq78Oc8TmJAL7fR5fOktMbDm6EKmyFukg+g0GHxpO8Kz6RGe+bp1JLgEGNaPD/1yvPmSezhv
	rF3p+uPpmpaTKMDE9g==
X-Received: by 2002:a05:7022:42b:b0:130:aa42:167b with SMTP id a92af1059eb24-13632f57034mr409453c88.36.1779322642665;
        Wed, 20 May 2026 17:17:22 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm28444410c88.1.2026.05.20.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:17:22 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH v2 1/7] net: arcnet: com20020: remove misleading references to multicast
Date: Wed, 20 May 2026 17:16:13 -0700
Message-ID: <20260521001631.45434-2-enelsonmoore@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290159-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7632D59D3E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ARCnet does not support multicast, only unicast and broadcast. In spite
of this, the com20020 driver contains several references to multicast
in a comment and a function name, including a FIXME that it should be
implemented. Adjust the comment to make the lack of multicast support
clear and rename com20020_set_mc_list to com20020_set_rx_mode.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/com20020.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index b8526805ffac..f2fa26626a06 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -56,7 +56,7 @@ static void com20020_copy_to_card(struct net_device *dev, int bufnum,
 				  int offset, void *buf, int count);
 static void com20020_copy_from_card(struct net_device *dev, int bufnum,
 				    int offset, void *buf, int count);
-static void com20020_set_mc_list(struct net_device *dev);
+static void com20020_set_rx_mode(struct net_device *dev);
 static void com20020_close(struct net_device *);
 
 static void com20020_copy_from_card(struct net_device *dev, int bufnum,
@@ -194,7 +194,7 @@ const struct net_device_ops com20020_netdev_ops = {
 	.ndo_start_xmit = arcnet_send_packet,
 	.ndo_tx_timeout = arcnet_timeout,
 	.ndo_set_mac_address = com20020_set_hwaddr,
-	.ndo_set_rx_mode = com20020_set_mc_list,
+	.ndo_set_rx_mode = com20020_set_rx_mode,
 };
 
 /* Set up the struct net_device associated with this card.  Called after
@@ -362,14 +362,8 @@ static void com20020_close(struct net_device *dev)
 	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 }
 
-/* Set or clear the multicast filter for this adaptor.
- * num_addrs == -1    Promiscuous mode, receive all packets
- * num_addrs == 0       Normal mode, clear multicast list
- * num_addrs > 0        Multicast mode, receive normal and MC packets, and do
- *                      best-effort filtering.
- *      FIXME - do multicast stuff, not just promiscuous.
- */
-static void com20020_set_mc_list(struct net_device *dev)
+/* ARCnet does not support multicast, only unicast and broadcast */
+static void com20020_set_rx_mode(struct net_device *dev)
 {
 	struct arcnet_local *lp = netdev_priv(dev);
 	int ioaddr = dev->base_addr;
-- 
2.43.0


