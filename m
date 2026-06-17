Return-Path: <netdev+bounces-300010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Bo8D/IUMmoZugUAu9opvQ
	(envelope-from <netdev+bounces-300010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F06964CF
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 05:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KVHvngjt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300010-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300010-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3187330BF5A8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F12E7376;
	Wed, 17 Jun 2026 03:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025D13B293
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:30:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667055; cv=none; b=JHf/LM50OahUjqtyZLnDKrwp5Z2Z3X7xiB845Bgp5rscH6rGNvm1gQslIznTWO6oK7nxUCmcCMR6msdzYFj5EbHwoY9oIX6Tf+YyA9WluGGCMqcQbtZw+hIwFFa8GTMJEkUQEdBpPLGjnozDf6n9y1n7mXESMDa9RA/u+B33BqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667055; c=relaxed/simple;
	bh=NFnFlbcyxgOZywpT3BjLvJ8JrCtG76tJtj/M+sOw20w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tDwhSzzvZp6TeMsONL5YZ+OB0+uV85OjwEWtMT++OqP1bz3QWoU6gl2RnimrT5AuOdhtd2SdETVJrg+OeDz33dEvXLrpz5yxLGDN2etgT/RZ7+NDjFEjZsXJZ0BBGlGyhhTxhE2l6qyp157R1vJ1Hu5OFXypDABcfNuwwYzmkos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVHvngjt; arc=none smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c85a2ca7bf7so1953969a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 20:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781667054; x=1782271854; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNRRDdQAg6OTo/rPWnE2gKXvJ32DvRz3h1z/Jd46StI=;
        b=KVHvngjt/LKTtuJKioFCOfI+YXaB8O6k7ZasQqnBzkaSzO5Il5kkW4XdCTRSBQQUgP
         4UNkAWmJYoFOSysl39tbu2OWXn1LaUzR1eUcZlyBAH9QTbwtsBkvGhQlmnE2Bd54lwfi
         H6e4FWuOPupVdqpxLsR0w1BlVntUIF3B9V3pTZ1VmUYq6bpNxYR7w7/5vhgvo1uQKKlP
         Uf/IXImgxOm8fjsx3YiCCjEO/1qK/G1mabNC+JMkUHG31WqlEblpNTOoxe/Y/ic6hQc5
         4XemWybYJqSgJvfTqHR3Oa8QNASlq57SAlMQ1hxghzgkakgOkB8ZUUvbXUNuxUJQxHP+
         o4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781667054; x=1782271854;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNRRDdQAg6OTo/rPWnE2gKXvJ32DvRz3h1z/Jd46StI=;
        b=Kv9H0mr6skZu6N1+5GmXRfoTmOU6u/rCZ9MIW+VMqdzoGIyfAIfTTcmKUSNZQcyBK6
         GNGcUy6OkuC5DlTLJDqfNDXOPdSKj2Uc2PY0HuJPbpeRbTO1WMOzvYbcwZLvYQ/rGSYG
         4gjRwgMfMfK0pxlS57LjCRyVDwhQw1eTXTsZhp43vl3Wx32QW68gjDlwes9QN4RY0Ju+
         j3BVTSMQ70KhN45UVDZK7B4viwxxolUCv3iSTEhUI5eTd9O33EaRWP/Ne1QPaoaL81Iy
         RoIT+2hpxyhnb49k0QqfrSsEUG9qlQZRuj3I+EzDaW7gy54VRur5+O6XzXLrCophpgxp
         G+dg==
X-Gm-Message-State: AOJu0Ywm/SWSdrWXr9nK2SMYhwEBANoCEzjr/twcoLXl3oIP5kjIwOMb
	uTyIj0WwAKsJ15NuqAD8z4BWkb4ZLoVET4mHpp/ABlXzPWAoHVqdCFknkDBsaIR32rS4+Q==
X-Gm-Gg: Acq92OFePofH+uNJS0sZli/dHqq7wJ6EjABuE4HM7KMZRXdlvNI3HoNgU1HvyRJCb0C
	VsueaR09QiNLn0YgMjepMjUFD3JXbxhg7rS9J56mdxC7iftP94lOWm5nPMAEAM/5fd90YF2S+J8
	xM0w7l/1i47q8jA5fGNkHe5zTjbILRa9+jnYikjPOrYcJD+oyr6usZMkxnZu2Ii8VWOQgJu3bdh
	6kbz38mOZuxU/2rlIRL5BCZ7kdkYnu08qW4V9oq4MWBLHTTLNwt4A4Y8mvfnahqctdQtPPrihnt
	j2I23R9Dk7ajK9xRG067VkrF+SCQ0Ydrk57uNVBxSBfyEJPSjQxnubkY1u4RsqePQCBcVNTMJUs
	0v1rrJCfsHmnq8DlwnrqulNUSQLPViFNl8yLbxai8ypNHZhUhD4EsBMGGaWbNsTsmrjiywbDSlz
	6D8UVjIQ==
X-Received: by 2002:a05:6a21:4903:b0:3b4:870e:6f44 with SMTP id adf61e73a8af0-3b8be9b197cmr1944323637.35.1781667053893;
        Tue, 16 Jun 2026 20:30:53 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5ccafsm13070205a12.2.2026.06.16.20.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 20:30:53 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: airoha: Fix TX scheduler queue mask loop upper bound
Date: Wed, 17 Jun 2026 11:20:10 +0800
Message-ID: <178166704952.2212140.11002626760717132754@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300010-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B0F06964CF

In airoha_qdma_set_chan_tx_sched(), the loop clearing queue mask was
using AIROHA_NUM_TX_RING (32) instead of AIROHA_NUM_QOS_QUEUES (8).

Each channel has 8 queues, and TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i)
computes BIT(i + (channel * 8)). With i ranging 0..31, this causes:
- channel 0: clears bit 0..31 (all 4 channels) instead of 0..7
- channel 1: clears bit 8..31 (channels 1-3) instead of 8..15
- channel 2: clears bit 16..31 (channels 2-3) instead of 16..23
- channel 3: clears bit 24..31 (channel 3 only) - correct by accident

While BIT(32+) on arm64 produces 64-bit values truncated to 0 in u32
mask parameter, the loop still incorrectly clears queues within the
same channel beyond queue 7.

Fix by using AIROHA_NUM_QOS_QUEUES (8) as the loop upper bound.

Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..a1eda13400 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2217,7 +2217,7 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *dev,
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	int i;
 
-	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
+	for (i = 0; i < AIROHA_NUM_QOS_QUEUES; i++)
 		airoha_qdma_clear(port->qdma, REG_QUEUE_CLOSE_CFG(channel),
 				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
 
-- 
2.51.0



