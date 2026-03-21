Return-Path: <netdev+bounces-270220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL1yFNSovmmJVwMAu9opvQ
	(envelope-from <netdev+bounces-270220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:19:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B282E5C00
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2556B304302F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9632238BF92;
	Sat, 21 Mar 2026 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYd7EU0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5738C402
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102541; cv=none; b=iEM63vv7EP4Wml9dPlfe5t+nY0lxsebmSXfhzTQ+OboyxExJiiPhrFn5/iLxwDbSvdrFeRkFrEizh33wp1aeEngiYyhOy+yrAlyCWSYdoNaE+ZE6HFsy8vZktA5IxBb3Y/0tHoy3PNQSk1jAjwEpC5a3ehWCobQkjlpONjFomIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102541; c=relaxed/simple;
	bh=jzPZdf7Og6HeFXO/l7pOiaD9NwH4pg2nD16c3hH6gys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=euAPwa18AnpTXLWKMQpg/iVPOoXeFUSsdaI1lLQ9fk0kO+fOTA+cYRE+gNg4xNZ9pyaj1VlPoFErwYBQYg9ak/782yOORKjR1puIqdZsuPBTtEb2fXaXLFux8TvTG7dLeWqus0OKWUwWp4q3LADFDVl/785gO/5NfefYDFD3k5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYd7EU0c; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b06d33e84cso18081525ad.3
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102540; x=1774707340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAJIY1DIMzupbpUoUnEua+5LFL/m08GzQPtpfspcCIA=;
        b=NYd7EU0cfP1gufCqrBWKH/v4MgXV1XbX+CRwp1a2WHdh+LjcQrZ94YP1y4JBVVlFGh
         Mf6JidkQekGIFXYITEZcj2H/q0BVHJKs7ysTtL102OfQLP54EGH2l8iJIn7yxnJQZTB2
         dj9RPGmAP02c4ctaZfJUeGIIjuicHHA0NAxwly8bsJniA8ghDz6upbvPhhBJRq2q/Qg6
         CJ5ndGdvpvt7n7UwH9qhXXfgpa53eTivUyWC2XXKcfwvEVAokmpydT+u5PzCKA1UluHZ
         FAPkUNjyniz/YWogBvZgEjgTzZdvfhiMPyjQ2tafxGykxHWBWD+piLMsAKPi8TLme0Ze
         FQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102540; x=1774707340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uAJIY1DIMzupbpUoUnEua+5LFL/m08GzQPtpfspcCIA=;
        b=R6d5W3dmiwoLEBBAtvwDS3hWb7wbQb0sTZ0aS0W991ekt3+R/IqPl6e8rcVQqWpAQp
         iH/xWqJ+4GPC/ZcyPm45PP7GLcz6vimh6goovWLs/t9LFwrgM1dndYMfY7dkI+fbdjyA
         EyRjmOEqdt8pYrp3fRCHrOGK7jgDQBqM2S9lkzEiXnzu2XU3Yc7+qJHmuxMe+58yKoR4
         Oi8U2KfUXTgRSix7x/avJZT0rQ9FOs13Xl4KvLU9jIqZj41faKj0WfTMG+unH9K3sLWS
         yUkdvu8TiMQtQ8awAso5AXFkAnNIjjKX+11/FHt5DgBcGg7uZ9b8RUnxZkccVGAofBI1
         XgUA==
X-Gm-Message-State: AOJu0YwCuM983ebiTV8tH+2P6sdHUEXerjOQw9lTnV0HwY5SukLI4rzA
	42Lzy1LIEL8/XyO7ca0HFfRiSVLzPUCPIMbhwDkq0SCCer3HqSfQq3f7
X-Gm-Gg: ATEYQzyit5vdGUQeRqI6bTYKiSI8okboqfUZ+a12tzhWTWcCd+vfjSzm9BU4+qav17y
	UIZOwtgUofveisM0ZSPZoO0PRYQG/OcHzP8xz5+mWjSv33jNQ8N9QhBTjvzVE1JLuYnfKvrajAd
	jH6l8iy3oLroPjkhHM1wI4m7gPZM2DZMtc199H+6Tof9XvGNYmqw1tcTOejf9YZrkvL3u8us9Sg
	TUwe9EGHKcpSSMuQ3hjYkbtdjQTBd2HF5lfQNoxIJgKQexaZPvpxbcj+hg1XBVYQ/NydosUvt8V
	vXlHW6DTEoiupmUDT7PKVSFwpY6Gktrvg+JNsj1/o+LhF0w/SZo1KC1qlY2LCO8yIx1OcgenH4l
	2MuMqkLvf1WAYVQ7n/kPVyvMjf7hqhm/PQH/NedCXBQHtFxTjCUtLKdlHIanzDcs82bMYnBm0x+
	gt9BZ+ypekFm7UUskjmaHsI3AwfRZtyZy3uqQS5nkAiqTfGBPG5H5z/GZrZwVzXXuRx5VjRdA=
X-Received: by 2002:a17:902:db03:b0:2b0:669d:3a68 with SMTP id d9443c01a7336-2b0826f36a2mr64480885ad.19.1774102539735;
        Sat, 21 Mar 2026 07:15:39 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:39 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v5 5/5] Revert "nfsd: Mark variable __maybe_unused to avoid W=1 build break"
Date: Sat, 21 Mar 2026 22:15:10 +0800
Message-Id: <20260321141510.68214-6-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321141510.68214-1-seanwascoding@gmail.com>
References: <20260321141510.68214-1-seanwascoding@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270220-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4B282E5C00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit ebae102897e760e9e6bc625f701dd666b2163bd1.

The __maybe_unused attributes are no longer needed because dprintk()
now uses no_printk(), which ensures variables are referenced by the
compiler even when debugging is disabled.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfsd/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 8fdbba7cad96..8116e5bcbe00 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1025,7 +1025,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 {
 	struct svc_export	*exp;
 	struct path		path;
-	struct inode		*inode __maybe_unused;
+	struct inode		*inode;
 	struct svc_fh		fh;
 	int			err;
 	struct nfsd_net		*nn = net_generic(net, nfsd_net_id);
-- 
2.34.1


