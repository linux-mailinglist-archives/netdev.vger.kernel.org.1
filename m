Return-Path: <netdev+bounces-269287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPE1DSBtu2nGjwIAu9opvQ
	(envelope-from <netdev+bounces-269287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:27:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C88732C57A1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C882D30B55DF
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3936CE03;
	Thu, 19 Mar 2026 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAVbR31M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B925369997
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890819; cv=none; b=FWmzp3Jonv5mhAgl23ORfi7UbO/UAuU+HrkeeR7SiKGrhY/M8v6JdTWUtIgq/liC2q7JFJtjhdpA8l5YWxHaoKDT+kD35mPjNf8IhRQ2kD/hZgMPeskddyC4cvdCZ7MO9TvOek7z/z9vq953MVFtLPC+AH7w3BXVnCLEJfrBDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890819; c=relaxed/simple;
	bh=YylRe5YxHrIFAHYA2sA8dXc43/jAqb167pOwafJJe+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H2VnG0g18DC6YN4FcgJkbhqCjuW2WFRkOIAPlMGEPFjTO36JA2TW6Fa+yJw4eiqDGYFCL4xEJ7WGqo3Fqy0SU6u2lT8GvfFl7E4QSdbCKvCuHbCH+/tIdnudRzF4VZys59EyCS+vjcJ6Xh/46/YweUWalsxU9hVt5m8OwkAhPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAVbR31M; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso219378a12.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 20:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773890817; x=1774495617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJa0hR/irIUiusrwe3oMLmqKlCXFbsoEt4pwhDPj6/4=;
        b=FAVbR31MA4oEtuvYazCe80xG5zthBPKZnp9I/vGHpXpHiUVyio1BOf0/ee4s8J19lS
         D95pNy5Z6slUiOiZp+B5NMZS10yvw4IpcQmK7d2EMVtHaLKbgnc+Yqi8n7cYzxfNZQX9
         BKxrcsCrEE8XzUDtI7Wf1NCV6FztOG6iwH2p5lCHH2gGt8ZgihXi0i8H0I5MqB2hhLcg
         DfeZUAY1ec6x0+qGjMwRHX6cncdcICO61dvgOtocJZ3XRrrstrKN2E/4LzewKSqo0BF5
         OmloqRTfUNV6kt22X9xy7GQmu6ZVHmb2ucruez4XQli9yqYHz6oGkY8BMfNXkJKU6YYG
         UHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773890817; x=1774495617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJa0hR/irIUiusrwe3oMLmqKlCXFbsoEt4pwhDPj6/4=;
        b=CttV4MyYw7dVbZigNpHRkf2srz2O6VpsaQ4le2IPiotbAdTamQTcrHucBlDmSBWMdJ
         DrhnZDbBhEraame7iQCIGMIlncU9rraIo3NSGX0/VaH0eJ/hvw3J9BswwCMg3SKlPYee
         heBlNUp5qZh2dSbm5ymVhvsy+MiK2IlfVCpyXGfb8Wg/t75fS17B4PWx+NeYMqmWnDYy
         RVv5xP8djUbyA0Pwfyb9KB4Bzgyo1dGnsLnbiQ01S8NN2G4+R8cChyBpPc46UfkkDXV1
         8jx3Om9TR/hO5FZ3DEb9ceSu+azb6pPOKdCXIgls6lG8qC4bFkQhimdKpwuSZqqSTLB6
         tMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWedv6gLTTeUjEiFe5Lf24MjqxiIg943aYIFjcJJtxAnCbZB6FMI7+2GKiSbLZ5kOIRNrTUUjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg0dyHvoNNZrdSEswGZBPvWjN9AnsC9suYP9/hYhiuqjWMq09b
	b14koOGNgvzWifQQyaWF+kRxVgXu8SlvA5sErfAynIrUHk9qLVlNEuvQmy2BqywJ94Q=
X-Gm-Gg: ATEYQzwKa233q6c2tH5MAX+S/yMGDwKQkNlNkypoOTIQu5YsMuqy5qYN+SuATLuRH9a
	yE3/y7pSgrRQlsaFAexpKGkB1maReZB9+SdW7AulhWuZmwMX3Rk0T3iQCMjaFdOvgQnPwN9ueUe
	e2YmpFkb55n5c5dubr+Cy1TIoNtUkcUY9l/4JDwahv6qwkVI0+RwbTvpNIbRV0VfovehLNNXCpn
	Xj8FJHd/TG4enpuY83YWUsdTXTokkdaPjbeJOstVDO48HZUDMRTxsKikAHjmSo3DlIEbZnVVxbw
	TxwObhRIHbeAMizgQYISEFh2aS58MRLUXHm/qWwB6w0osgwvBLkbr8Vc1iGvVHXpZU5Kyyex/O9
	iMK59uyYeYTt8y4Eob8Uai6dbUVFmZpmIMO87iXPKuvR3rFpR66OVywLA5j+KlB8kQxXgWxbKVN
	SEfm8=
X-Received: by 2002:a05:6402:5cd:b0:65b:edef:40b6 with SMTP id 4fb4d7f45d1cf-667b1880976mr3907686a12.6.1773890816443;
        Wed, 18 Mar 2026 20:26:56 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e22:2e3c::49b:45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667af38d891sm3059684a12.9.2026.03.18.20.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:26:55 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH net] net: airoha: add RCU lock around dev_fill_forward_path
Date: Thu, 19 Mar 2026 11:26:49 +0800
Message-ID: <20260319032649.337812-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269287-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.867];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C88732C57A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since 0417adf367a0 ("ppp: fix race conditions in ppp_fill_forward_path")
dev_fill_forward_path() should be called with RCU read lock held. This
fix was applied to net, while the Airoha flowtable commit was applied to
net-next, so it hadn't been an issue until net was merged into net-next.

Fixes: a9af709fda7e ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index ec5ce41dad80..02deb739a1c7 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -227,7 +227,9 @@ static int airoha_ppe_get_wdma_info(struct net_device *dev, const u8 *addr,
 	if (!dev)
 		return -ENODEV;
 
+	rcu_read_lock();
 	err = dev_fill_forward_path(dev, addr, &stack);
+	rcu_read_unlock();
 	if (err)
 		return err;
 
-- 
2.43.0


