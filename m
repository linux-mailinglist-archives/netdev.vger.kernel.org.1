Return-Path: <netdev+bounces-271295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLVoG2j3wmklngQAu9opvQ
	(envelope-from <netdev+bounces-271295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:43:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEF331C764
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECB03305846B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B34354AE3;
	Tue, 24 Mar 2026 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwp2MvlY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7E355F36
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384892; cv=none; b=Jgns+MQCKBgyTShoz/PIwh534dUbN011TyGtQe7OdYtPuts/JG6dG4t+jdVYDoQolwpSZ8hj2TN07jledfT0zyA/3YwPkzoAsOsgfg7gU4raH8ukF1dGloj74lDIOXrzkreq9k1y4PlqMw/hwIISb982P32csK8YD+cQVbbvH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384892; c=relaxed/simple;
	bh=JST0wXweMblcvbScw9Mq0yslegnTNej/ZY8bqddZfTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X79vWR4bWFzGvOBDg/czqySXM3wQPZGU3JQltDHDUVfkWOwO8iKL4PRS5GPIdPWRDThYNKojb9tcwMXUgbt2XjL1ZyiYmm6ndd5q1i61oWPilBMUCFhm27S1/oD24JfXMDHqQ4orHroxFR7jM5mC2EtpHbapelufkQNaiH2Rf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwp2MvlY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso15630145e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774384890; x=1774989690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUoxypdfQgAMyIah8TMnPeb4KQBvT5cjozWxWchgdfs=;
        b=Kwp2MvlYjBPeV7omWDQ3PzTV/oqb/w2aKiE9f927+sUFTFntXw/muApuK5UunGe+8d
         svIjFyc3vraclWTTILt/eAjU6LENkAARTzMGw5K0k88mK1AJ0rqYvJsd6/Qi9GsDWshH
         JEwrH2Xbw/+/1w5HFupyUyZeUn7bSh5RfdgmMmxvxucnOASIAwA1kL9zziG1J1XH5lxz
         /5a1+YAtGrpyMOPfUwVpxCrBUTAhGivaPaIoAlZrY33F+BD1Pq7WQk/ereh94LXXq40e
         WYAEN2P0SNSE05H7jCtQ5aQwiEI7j2MYirZsRaqQhssQ5GrDq2YFlaL+K5qcEVfzGc4m
         3VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384890; x=1774989690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUoxypdfQgAMyIah8TMnPeb4KQBvT5cjozWxWchgdfs=;
        b=PXoGyHgCimauztgp6lPPWxDsevxnSI2MwGg01tzHeiMI8n9dhKXVeguyM3Z4T33zYI
         tGemGzkhVl6qZnmuZnrrFVWvbleXB1WYadLUTYUDmR7+YdxwgtDxXsguMz+0TGjIgRos
         /lS1g41Y3uacZBu7cqWd6K1gHuXsNxPXYd83vjNjDJMXlfW+uAiCGKNekZ1YdiVCQUZT
         YprPehf8SvwuxwY1gKvnCY5rNFPeRK8XssHOh0fDtJQc/SwIFNJxpG+6i9n6hSbwSODA
         dLMJOQBDaNJEuAgHwYcg1p4mzdAzyNwJ7W7AcPBu1qQzJYpJ+RzisxS4aJuwDdMUAeOj
         eOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVfAqwz3hsV8TZw63nU1mNviHbv0ux+AjmeJe8KzSu5oiMQg2zbr+vVJUnb8TVRvjcjBYlFoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPe52Q+Upc6RvlPqoRDmxqOauevufK0sU5cxLRDsskWyM2pyy
	/fsgv1V7gO74EUBpajkEZq6Xx2dXf02FasnFtdzo6waXk6WVUuJNH2IU
X-Gm-Gg: ATEYQzxah6yBvmtZ+h+inaLkStIZJvLfArRu/OLg745oCHeY75oJCe7Kn9iDFNS1qK4
	XiWXHLiJ+RYvu02bCXAwUjVTllLQYEI9C6rTNRk3W7Ezmpg6L63zZxLDlIuEruowcfPLQE2ue6V
	5KaVg4XPsf+b8l6cZvszX7yQDBK7QIsRrHq+9UQ8N+J65/2edNuchSU6GEsQ5axD7/lmFA9WkAT
	q9MwUBdNLwC+5rOwtbAKngNJGc2I42BOJPB2mxsMOjg5TXRFInZw/qnAm3aAWsRDMdTwFm6Idnj
	bFPFcegv0l44Ht3eg+SG6XxApDjj68rvDVcclv/oUxAU2Mu7DWGGRydBuX6vuR4l/Ie2Oaa3smb
	ikOSPcoN4xd0UcQGMHY3liWaZh5VYJWk4DZzi95sAlZV8U2x/0h/qgbCh0xKwHmcX1U63DKJ5ou
	l9oylpuvA/1aCHCQSNU3mL
X-Received: by 2002:a05:600c:a0a:b0:487:288:1198 with SMTP id 5b1f17b1804b1-4871605ce9fmr17884155e9.22.1774384889809;
        Tue, 24 Mar 2026 13:41:29 -0700 (PDT)
Received: from azaki-desk1.. ([41.234.201.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716658352sm3686825e9.13.2026.03.24.13.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:41:29 -0700 (PDT)
From: Ahmed Zaki <anzaki@gmail.com>
To: netfilter-devel@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	pablo@netfilter.org,
	fw@strlen.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH nf-next v2 2/2] net: dsa: update net_device stats with HW offloaded flows stats
Date: Tue, 24 Mar 2026 14:40:16 -0600
Message-ID: <20260324204016.2089193-3-anzaki@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324204016.2089193-1-anzaki@gmail.com>
References: <20260324204016.2089193-1-anzaki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271295-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,gmail.com,netfilter.org,strlen.de,kernel.org,redhat.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anzaki@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2FEF331C764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set the new net_device flag flow_offload_via_parent to update the
user net_device TX/RX stats with the HW offloaded traffic.

Signed-off-by: Ahmed Zaki <anzaki@gmail.com>
---
 net/dsa/user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index c4bd6fe90b45..331bc581bce7 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2807,6 +2807,7 @@ int dsa_user_create(struct dsa_port *port)
 
 	p = netdev_priv(user_dev);
 	user_dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	user_dev->flow_offload_via_parent = true;
 
 	ret = gro_cells_init(&p->gcells, user_dev);
 	if (ret)
-- 
2.43.0


