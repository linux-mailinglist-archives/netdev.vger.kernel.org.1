Return-Path: <netdev+bounces-276815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCOOO2oW12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:00:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B23C5D66
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FA343018D7F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF5D3502A6;
	Thu,  9 Apr 2026 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/sazC7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E9213E89
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703583; cv=none; b=VAc2KNA+dQPKvPFL5oXrRwVB0rU6fj9sexv+Y/0ljMv7WsxViTD02o8t2x2XDIjf+mZZH511JW6cVE07dsgJxgmxuT3It9nUjcJGw+1uMqmSUZQjOzYPdSaEZeXzeKXijffyewvce7PuQhSMscxIcCXjLeg3LfMXegVsClmTBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703583; c=relaxed/simple;
	bh=Xc9JIcJ5tZ/hkJqVabouvK2yaEMKFNhceFeC8ZkDcNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g8d5zjQsSMY8YgvN5y1nPBayd9uoFkVe0ss7o0FxSxTG7PfkTaWQ66P5fBYKyRa5Zh/yy0dE5FQIo3rRMLrXUduVEOvMpQqhtSPWTp6j8XszhT17Gh4iy5JVDPiVSP8SltbPfKUS6iZV1ouEGZZyZVBcQ+9V/V1HiblpymdjVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/sazC7+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so304646eec.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 19:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775703581; x=1776308381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2f0Yof1DLXmda+Ua8QZmvkVah9DOsLozAWk9vmUBRA=;
        b=C/sazC7+jIZKg7lu+wzCybHPCGEElizET0FMufXI1H82P9sRhrLKBpxGhfyO8CKGux
         X56zO9bARTt8mLrt1L0MdfKaawUEBjmvLDrKLijB/t1MClMufcsrBJ21KU9bx0U928a8
         5YZW0lLIer1VxNgCENDEGIqJXfjMj9V/I9mV40yoUQu0GTiui5auZNF35+65pAgx09LL
         dqNRxl4tW9zAHg19YI2Ntk0+LpSqDxeXgQ8kYwDrUENhCIdjzJ4QcLtxowLsSFRtRNAt
         STnijBUHoW7BPAWs+YyW385/8DtIwaIMg3VQZlRAPbM2bNraMLf9qo0uOiTgzGFJHxWo
         nD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775703581; x=1776308381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2f0Yof1DLXmda+Ua8QZmvkVah9DOsLozAWk9vmUBRA=;
        b=ngUjfp56IDqVvT6VeVjCXuNvL6p++EOiZ09AhKUVGWnj2wImDQH5TI1eQdkv7gPdPU
         ou0Tp0QYFKTwplDwep7D9TRKiddNoA8cQyDAeUG/FAIXyvaxAyHakbfODlc7F5OH4JYB
         oikg0VlTTJ8gu6kkiahPzE+R5GgBNuERSqagn2c9P2OeD6j/jYFD8FQNIGStQDHQoRBK
         NHqD6iePQZtTcPLJpB5Nr+CPZxoEQcpd0GnnluCWiQA05T+4Vh215KVwsDFuMwdcEKiT
         YJPNWpnMzkAZo+e3Q+lGmieD9dv3Uic7uNFl+8ILVFVfgXdD+upuzZelpoNNxAqe9R0F
         /kSw==
X-Gm-Message-State: AOJu0YxnHcMIEinkDwfxVMCIswk4LWKQlDg24rBjhTMGoHcchM/Hd4mH
	DnRuUMMhAMyWJYr6D5gny8KEw7ztPW5GAjTi3u9OsSMz+h+GVkeJBnM4oM8e6ekN6saqvx4oxi2
	19MXF4PXMcMVAwSIAv/NsRw==
X-Received: from dybb3.prod.google.com ([2002:a05:693c:6083:b0:2c1:14f7:5dce])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:128a:b0:2c7:31b2:44ad with SMTP id 5a478bee46e88-2d40efe9181mr1009203eec.31.1775703581227;
 Wed, 08 Apr 2026 19:59:41 -0700 (PDT)
Date: Thu, 09 Apr 2026 02:59:23 +0000
In-Reply-To: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775703578; l=3679;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=Xc9JIcJ5tZ/hkJqVabouvK2yaEMKFNhceFeC8ZkDcNI=; b=Qzfoc1UhcNP9VdkzktVkL290Rg0+5GHuvxE0qARgNlVoHVMAoO7IkAkS3fRO2PQrVOnA7H7WB
 dQVF7Vz0Yc7D+h6OV+E+Yl6i4Pxm0NP7YNrEkIc5znzUUMhrpdiqVsI
X-Mailer: b4 0.14.3
Message-ID: <20260409-teaming-driver-internal-v7-1-f47e7589685d@google.com>
Subject: [PATCH net-next v7 01/10] net: team: Annotate reads and writes for
 mixed lock accessed values
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Marc Harvey <marcharvey@google.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276815-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 543B23C5D66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The team_port's "index" and the team's "en_port_count" are read in
the hot transmit path, but are only written to when holding the rtnl
lock.

Use READ_ONCE() for all lockless reads of these values, and use
WRITE_ONCE() for all writes.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
---
 drivers/net/team/team_core.c        | 11 ++++++-----
 drivers/net/team/team_mode_random.c |  2 +-
 include/linux/if_team.h             |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 566a5d102c23..becd066279a6 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -938,7 +938,8 @@ static void team_port_enable(struct team *team,
 {
 	if (team_port_enabled(port))
 		return;
-	port->index = team->en_port_count++;
+	WRITE_ONCE(port->index, team->en_port_count);
+	WRITE_ONCE(team->en_port_count, team->en_port_count + 1);
 	hlist_add_head_rcu(&port->hlist,
 			   team_port_index_hash(team, port->index));
 	team_adjust_ops(team);
@@ -958,7 +959,7 @@ static void __reconstruct_port_hlist(struct team *team, int rm_index)
 	for (i = rm_index + 1; i < team->en_port_count; i++) {
 		port = team_get_port_by_index(team, i);
 		hlist_del_rcu(&port->hlist);
-		port->index--;
+		WRITE_ONCE(port->index, port->index - 1);
 		hlist_add_head_rcu(&port->hlist,
 				   team_port_index_hash(team, port->index));
 	}
@@ -973,8 +974,8 @@ static void team_port_disable(struct team *team,
 		team->ops.port_disabled(team, port);
 	hlist_del_rcu(&port->hlist);
 	__reconstruct_port_hlist(team, port->index);
-	port->index = -1;
-	team->en_port_count--;
+	WRITE_ONCE(port->index, -1);
+	WRITE_ONCE(team->en_port_count, team->en_port_count - 1);
 	team_queue_override_port_del(team, port);
 	team_adjust_ops(team);
 	team_lower_state_changed(port);
@@ -1245,7 +1246,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		netif_addr_unlock_bh(dev);
 	}
 
-	port->index = -1;
+	WRITE_ONCE(port->index, -1);
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
 	netdev_compute_master_upper_features(dev, true);
diff --git a/drivers/net/team/team_mode_random.c b/drivers/net/team/team_mode_random.c
index 53d0ce34b8ce..169a7bc865b2 100644
--- a/drivers/net/team/team_mode_random.c
+++ b/drivers/net/team/team_mode_random.c
@@ -16,7 +16,7 @@ static bool rnd_transmit(struct team *team, struct sk_buff *skb)
 	struct team_port *port;
 	int port_index;
 
-	port_index = get_random_u32_below(team->en_port_count);
+	port_index = get_random_u32_below(READ_ONCE(team->en_port_count));
 	port = team_get_port_by_index_rcu(team, port_index);
 	if (unlikely(!port))
 		goto drop;
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index ccb5327de26d..06f4d7400c1e 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -77,7 +77,7 @@ static inline struct team_port *team_port_get_rcu(const struct net_device *dev)
 
 static inline bool team_port_enabled(struct team_port *port)
 {
-	return port->index != -1;
+	return READ_ONCE(port->index) != -1;
 }
 
 static inline bool team_port_txable(struct team_port *port)
@@ -272,7 +272,7 @@ static inline struct team_port *team_get_port_by_index_rcu(struct team *team,
 	struct hlist_head *head = team_port_index_hash(team, port_index);
 
 	hlist_for_each_entry_rcu(port, head, hlist)
-		if (port->index == port_index)
+		if (READ_ONCE(port->index) == port_index)
 			return port;
 	return NULL;
 }

-- 
2.53.0.1213.gd9a14994de-goog


