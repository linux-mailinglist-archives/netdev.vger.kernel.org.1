Return-Path: <netdev+bounces-256739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLQTGiNrg2m3mgMAu9opvQ
	(envelope-from <netdev+bounces-256739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:52:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9BDE982F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C58D3125F5B
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30895425CE5;
	Wed,  4 Feb 2026 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm9oZ6NW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1E425CF4
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218417; cv=none; b=XMTixwVREjp092m+f5aAV2aovHbC7dkDVhkCkrv6sovsaVaiWLMr++NCvoCNBAHlhJBUff8yWWHr9SyQXnr5w9jmjYRlAHy1FRtcYny8kEpO2+gUJb6nmZt+IxyA7OifbLWX9PKwNRFg/kpOdEjVCzLaTcvJhKIIftKRyca0f68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218417; c=relaxed/simple;
	bh=dUNNNkgwiKs0jJ3gqltiLi3w3ZESyBFOHecX2yXYAvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZO3YJ8KGKyQ1daoZTBKjRutn5Yz8V7EGSGgapa2OwZLkNy3Zb4XJvioA2uW0lMnKGeEwVqWsvlc4jSeoT0WdC9Q50yRWhqnmMpZKnqzVmDpmuKeA+tbW3mkONxWIDnMhg0KezN+ePaP1SzfAr4oUdkZevN/p6VbRqFM6yXVwhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm9oZ6NW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-793fdbb8d3aso66774157b3.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218416; x=1770823216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXQzycVLoUHsvmViNXRoUwIsMbZHmx/4dfU4u4ceWho=;
        b=Dm9oZ6NWXV6avRJpS8iAefZlsrT5NdaEN0ZDwZfsa3U4wABIEUfYK7LvhRsUNxE5Eg
         WWz865/68d97mVY7oMxwPdGI8+i5izjY3UCIQZTDVmBf70oscqeYJnE+H2x38MMDq7QW
         d22i8RpenYqSYWv5nHXmDzHykpGoTmDJ9zH9+c5K61YDWv70xIlFgjrWLDFsPRsNbZen
         pD9Pl++mrpOyYkysdFxNe3BAY506U49/ZwnVZ41kVPUcMGkcj2SdO5ZLkAEP0/LS606e
         h7AQ3P2wcgV8agQmSaNUQEikIjFxMhd2VK5kGbyjSnEHm7BXg1+ahvm4DobnNCTUAa84
         LMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218416; x=1770823216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IXQzycVLoUHsvmViNXRoUwIsMbZHmx/4dfU4u4ceWho=;
        b=kt3fjlUu+DzYU+cCfa3mKZa3QF3JSyylN0LRZYk2Rm+CevO4YRUcLCGaGE7JlZtA89
         NHOx7gxeXimQEjDcfPA9p7G3UACOZxAOQDq7fVR81BDE5Id+ESJJJCMTaxjceQGUmvSU
         RqUHe/wv4fb3zpmwFp6Q7iCm6dobQfXz+cNG55RvcRYrwn6oIWXCZpIZ4WJ62lh4m22d
         ufAAbONl6JQYKIy3HHqrMgD0nB4G3WW4YNQYs1ghxFhUfXfJ3Hjp4jITDIe020HPmBgq
         488MbLMry8A9xOmiM6S0gOe9LFXD6x1qGswEsImDw78lsIuDtDL0ls/lzJteKPTc+jiB
         0KHQ==
X-Gm-Message-State: AOJu0Yz/kGZ5b4L/KlCmfsFiWeKd5c3n3/3tQMDkh3mr0xJn+OwIt1VX
	5GhrGnLJBkd3KXSGIdmeDNiwmJWpmWNz7t1cKGbD20tSTel8WScGNdav
X-Gm-Gg: AZuq6aJYTZLl/eGfAG8TAXFUQjcV3xr/2/NckxG+Jv4NfEFA2dLHHQXjP9FVXjhTghC
	XntVbUVbKWXkGus/HnMlI9aJ1mcYyl7mW9TSzo7EzcjqZ0f3MV3idODm8e+Cwh+TtZ3fC3oYPZw
	7OoUO7lea7CM0MIh3uqiRfyh8nxVhd2QKcWCE+f3TlOsVvyARcW0SUVmaPd1hUNAMraSsSsdq9/
	VCkPyrTj/uk9d0SSWdSfC4hpWyo5Z226i/4O5xHpi8jK03R73fRL/TheswpFB0u0oQ7ISbClYAT
	sXG3mdfl8ItdPJYSgCTE8QwI5v/fnFutD3RLEjwmAFnf4/WdcXDS0RVbnpcZcFROe/6U0H6GRPg
	2X29nPC2cYm3wjNygbPk8XdnO96LXp70motilJH4DrAI2mq9p6Tnuabs+kdFlUQ5tqZhKy/6bmz
	4hwQThoRs=
X-Received: by 2002:a05:690e:424a:b0:649:da44:78b2 with SMTP id 956f58d0204a3-649db4c4ecdmr1915176d50.90.1770218415725;
        Wed, 04 Feb 2026 07:20:15 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc5e0b65sm2592932d50.21.2026.02.04.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:14 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 04 Feb 2026 07:20:10 -0800
Subject: [PATCH net-next 6/9] psp: add core tracked stats for deferred key
 deletion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-psp-v1-6-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256739-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC9BDE982F
X-Rspamd-Action: no action

It is useful to keep track of two stats related to deferred key
deletion:

- tx_key_cnt: the number of outstanding tx keys from the hw's
  perspective
- grace_periods: the number of grace periods that core has retired for
  this dev.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 Documentation/netlink/specs/psp.yaml | 14 ++++++++++++++
 include/net/psp/types.h              |  4 ++++
 include/uapi/linux/psp.h             |  2 ++
 net/psp/psp_main.c                   |  1 +
 net/psp/psp_nl.c                     |  3 +++
 net/psp/psp_sock.c                   |  9 ++++++++-
 6 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index f3a57782d2cf..efaf3f61e37a 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -153,6 +153,18 @@ attribute-sets:
         doc: |
           Number of PSP packets for transmission with errors.
           Device statistic (from the PSP spec).
+      -
+        name: tx-key-cnt
+        type: sint
+        doc: |
+          Current number of TX keys installed on the device.
+          Kernel statistic.
+      -
+        name: grace-periods
+        type: uint
+        doc: |
+          Number of TX key deletion grace periods completed.
+          Kernel statistic.
 
 operations:
   list:
@@ -267,6 +279,8 @@ operations:
             - dev-id
             - key-rotations
             - stale-events
+            - tx-key-cnt
+            - grace-periods
         pre: psp-device-get-locked
         post: psp-device-unlock
       dump:
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 280c7fdc713c..d790efd9d4bc 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -67,6 +67,8 @@ struct psp_dev_config {
  * @stats:	statistics maintained by the core
  * @stats.rotations:	See stats attr key-rotations
  * @stats.stales:	See stats attr stale-events
+ * @stats.tx_key_cnt:	See stats attr tx-key-cnt
+ * @stats.grace_periods:	See stats attr grace-periods
  *
  * @rcu:	RCU head for freeing the structure
  */
@@ -98,6 +100,8 @@ struct psp_dev {
 	struct {
 		unsigned long rotations;
 		unsigned long stales;
+		long tx_key_cnt;
+		unsigned long grace_periods;
 	} stats;
 
 	struct rcu_head rcu;
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index a3a336488dc3..208ab60e2c88 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -58,6 +58,8 @@ enum {
 	PSP_A_STATS_TX_PACKETS,
 	PSP_A_STATS_TX_BYTES,
 	PSP_A_STATS_TX_ERROR,
+	PSP_A_STATS_TX_KEY_CNT,
+	PSP_A_STATS_GRACE_PERIODS,
 
 	__PSP_A_STATS_MAX,
 	PSP_A_STATS_MAX = (__PSP_A_STATS_MAX - 1)
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 2fb886edc384..4a7b2ffa718e 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -215,6 +215,7 @@ static void psp_tx_del_work_fn(struct work_struct *work)
 		}
 
 		psd->tx_grace_active = false;
+		psd->stats.grace_periods++;
 	}
 
 start_grace:
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index a540a1e77694..f0006d2e85c8 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -526,6 +526,9 @@ psp_nl_stats_fill(struct psp_dev *psd, struct sk_buff *rsp,
 	    nla_put_uint(rsp, PSP_A_STATS_KEY_ROTATIONS,
 			 psd->stats.rotations) ||
 	    nla_put_uint(rsp, PSP_A_STATS_STALE_EVENTS, psd->stats.stales) ||
+	    nla_put_sint(rsp, PSP_A_STATS_TX_KEY_CNT, psd->stats.tx_key_cnt) ||
+	    nla_put_uint(rsp, PSP_A_STATS_GRACE_PERIODS,
+			 psd->stats.grace_periods) ||
 	    nla_put_uint(rsp, PSP_A_STATS_RX_PACKETS, stats.rx_packets) ||
 	    nla_put_uint(rsp, PSP_A_STATS_RX_BYTES, stats.rx_bytes) ||
 	    nla_put_uint(rsp, PSP_A_STATS_RX_AUTH_FAIL, stats.rx_auth_fail) ||
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index d038da122ebb..bf6d089657b6 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -80,12 +80,19 @@ static struct psp_assoc *psp_assoc_dummy(struct psp_assoc *pas)
 static int psp_dev_tx_key_add(struct psp_dev *psd, struct psp_assoc *pas,
 			      struct netlink_ext_ack *extack)
 {
-	return psd->ops->tx_key_add(psd, pas, extack);
+	int rc;
+
+	rc = psd->ops->tx_key_add(psd, pas, extack);
+	if (!rc)
+		psd->stats.tx_key_cnt++;
+
+	return rc;
 }
 
 void psp_dev_tx_key_del(struct psp_dev *psd, struct psp_assoc *pas)
 {
 	psd->ops->tx_key_del(psd, pas);
+	psd->stats.tx_key_cnt--;
 }
 
 static bool psp_dev_needs_defer(struct psp_dev *psd)

-- 
2.47.3


