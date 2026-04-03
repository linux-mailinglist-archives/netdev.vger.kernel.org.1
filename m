Return-Path: <netdev+bounces-274908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LsKFW5pz2lPwAYAu9opvQ
	(envelope-from <netdev+bounces-274908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA23391A3E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A6F23065F3D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B396C365A11;
	Fri,  3 Apr 2026 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hW9gkIYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B623793C6
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200475; cv=none; b=g17uG0rhvaaON9PZle75u3QsoNFKQAvXl1tSDMR2Z3W/m4hcSwMI1jZu4s9DPUtioYKi70NsEjP7sKe6D6oJwUDSWX86x1BJdox4TP1IAsrKCjc8EoNPs9EDk1J7Sx7phMkRbjBCM3rhYrBOBDM3t25vywC+qEi+7DEN/W6x+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200475; c=relaxed/simple;
	bh=JjS6MuWrzLQ484r+Wytp35TgT78rt/ZzACL6KUmL0o0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLKzel0/I7i/tQZqUdLX90RSxbbI3mWwTX1GUWK7RGr9gwEcCItKMrz3VHjmlu+xz7S//9TY0ePlV4TvDRycJmMmo8gA47H5u38wCybua75tPioOex2XmrJSlASS5w6wEDDJFMrBnHoL8IeYe1Om28LgelHJkdxkkR80wG6+p10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hW9gkIYJ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so2255590eec.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775200473; x=1775805273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sH3+awQ2VJG9FRCmCvGcnPpepbVJPLxWI2KeuMcmXiQ=;
        b=hW9gkIYJtQ1qvaWk91pKISPu5N/MRg+yxakbe/DC1Q20i6sfRhqnZtqGuBJDubtg0k
         QwEbI39QKGeQceEPGiouhSNFOi6ttMid79GpiVhN9g6e13sNx7+Wcgu/IilKJvmKIcpS
         j51QBLPmdWy0Y6Un5u7sSKHLTctEQ5KuvcilrlzDLgqdRsXVNiE3GroOq6i4EP2HggP1
         yl5IpYq3hbQo6nJVknO8AHBuh7xFSQE8l7iAOaesWlu0rYe3G63c4maOgyXJESJc43Xl
         h4ZlVtAvFuMRjqD+ZLMQM8Ws0F/BZzbFdJiVTcze1kA+8P0iiavinX95F1EmpfiuozKh
         l6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775200473; x=1775805273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sH3+awQ2VJG9FRCmCvGcnPpepbVJPLxWI2KeuMcmXiQ=;
        b=dUJWh2eIyzuXvJ8Tw9itqDmCcBReraqfzI6JmvAvbzH9nwRR+1PSOQfNTX/4WzS//1
         MoPgRGhxqx87fcKM3viCeh6gnmXPvEgWvra0+4vIC0K/zBucWmhoNqkYpzRQaA7NttTz
         cTqSzGhO3thCqMlD06yTWatkDiJQnGEVZxg5i0Yvu8qbymrvcuaSiZlqbbc1mzce5y1Q
         hT3/SHZxsXcb15nowTKcWvMuglIv4+kv8gZuA187bkoitzHd6UoVnVkkd+N9XZ6kQ5Uc
         35pJYDvh7+AzlVaFGWf243hI+D1nwzGBkiaULA62+29kkRmFU87NZi6MdECf5kTfU3jB
         gdvQ==
X-Gm-Message-State: AOJu0Yw5KvSPuM4rMhlrWfzm+zs4GjTR0TgqBuJRfEzWiCYtYh8OpTZ2
	xymvAc618nKdFfUpf0Wp18s7EJzJ8/8ceUv9/y5ppVflMwxwI6PofPyhFW9qFkxiAoR0Mge9ywl
	05SvOZFSJSN5/7lr/92T7Mw==
X-Received: from dyaf11-n1.prod.google.com ([2002:a05:693c:838b:10b0:2cb:735c:182c])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:2b14:b0:2c5:d833:a4fe with SMTP id 5a478bee46e88-2cbfa5bf117mr923062eec.10.1775200472427;
 Fri, 03 Apr 2026 00:14:32 -0700 (PDT)
Date: Fri, 03 Apr 2026 07:14:23 +0000
In-Reply-To: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403-teaming-driver-internal-v4-0-d3032f33ca25@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775200467; l=1461;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=JjS6MuWrzLQ484r+Wytp35TgT78rt/ZzACL6KUmL0o0=; b=WaaKcCy6jw5XvMICkOKbYOhzmRWQdzj3dQmC//JznTNilpSYDLyMIPk7NU2fYSUCfczxIf585
 TUniz+tRtmCD+2aGkmk5rkyxA2PpoukSRZ62kUhqm0Eqbv4u7F5dDR4
X-Mailer: b4 0.14.3
Message-ID: <20260403-teaming-driver-internal-v4-2-d3032f33ca25@google.com>
Subject: [PATCH net-next v4 02/10] net: team: Remove unused team_mode_op, port_enabled
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274908-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0AA23391A3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team_mode_op wasn't used by any of the team modes, so remove it.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- None
---
 drivers/net/team/team_core.c | 2 --
 include/linux/if_team.h      | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index becd066279a6..e54bd21bd068 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -944,8 +944,6 @@ static void team_port_enable(struct team *team,
 			   team_port_index_hash(team, port->index));
 	team_adjust_ops(team);
 	team_queue_override_port_add(team, port);
-	if (team->ops.port_enabled)
-		team->ops.port_enabled(team, port);
 	team_notify_peers(team);
 	team_mcast_rejoin(team);
 	team_lower_state_changed(port);
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 06f4d7400c1e..a761f5282bcf 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -121,7 +121,6 @@ struct team_mode_ops {
 	int (*port_enter)(struct team *team, struct team_port *port);
 	void (*port_leave)(struct team *team, struct team_port *port);
 	void (*port_change_dev_addr)(struct team *team, struct team_port *port);
-	void (*port_enabled)(struct team *team, struct team_port *port);
 	void (*port_disabled)(struct team *team, struct team_port *port);
 };
 

-- 
2.53.0.1185.g05d4b7b318-goog


