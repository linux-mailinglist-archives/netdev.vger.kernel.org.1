Return-Path: <netdev+bounces-273898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC0THTW2zGnMVwYAu9opvQ
	(envelope-from <netdev+bounces-273898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:07:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 065013750C2
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 936C03091FF9
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 06:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB02332ED3;
	Wed,  1 Apr 2026 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VELglNZW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344032D0F9
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023545; cv=none; b=d/BrXpwRYKZC/PN+X4CkDhfd7qQByPvLQqZy5IYzB+2BebtDupEJAkprbz0ndR8RU1c5OqLiz04czJZ6Mr9LDao/QDyCgHmowjdNLO4p0n0fj4xKvdvERxkuYPSYMRcPHvRILZsKE+lO9z/IuibQ71EuxzQ0RVTR+iQAjmcUMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023545; c=relaxed/simple;
	bh=Hm9mnvA6yzszUb9UPKy4/znjWQa9nsZzvg20i+LSm88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N7L4eGLq+YX3K2oyhAc75N2i48PAu6rgWvapNsNOBu7tu+It3yIlg+B63AmzzHQ9WuJzY7yc8OIZvH0XTp0+AiHJBX+jGy54Q2O8+b9KtKffIpvHJGUyNCq+UiMTlQjvQ4ICMiBhOhJ7sPzNb5uNKnoCKpW+Q8yADvGUOaTuCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VELglNZW; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so5915668eec.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775023543; x=1775628343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8f3bpIAlrLMkYfB3Cdp7u2bS9D/CifmKNaY3dz1IRE=;
        b=VELglNZWfDoEmVabndzq3FaZxzz2+uDt6Vm2ijfrdTyjQ53e1x1yUpDJCXxzvg6Fgm
         DPRbYnOnzNMPUhqCQq40M0pZB64JW0DElKt7WlqGZtDZO2W/ZN/JZxNsLiY/mmM//IN5
         f2bk4oqwFEKTMi9Cosg9MRlgs4cSZhqJGpCUMsq3dKJJ3+0kKbAB9HehkcaNRIUenE8e
         zJHzr99hgDVujIfJB+SD+m6OY0Ze11i1f2FPYtRDwbcq/y9BL6CmrPoH+IdEEIbBX+ru
         7aW4Op8lYaewUJu4nfCsMBUlqHPSbgrbSdN7sHesv4M6OBOmThdTWOxUMjwYGoLhSDzB
         Ek2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023543; x=1775628343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8f3bpIAlrLMkYfB3Cdp7u2bS9D/CifmKNaY3dz1IRE=;
        b=f/alyLmV38oZHcROes/qQsYptMrDtGE1dnwyHPVqlxfTpdf+zb4jyxpFNWDWb0VaW1
         UTBDEwfNmqpxXi32TKCI+VuujOeYHaJNxW725v8y41fqmghqThXtiy1I1kjiNjQpxS51
         MmYVSWAkIJ0fDQoQXDOypU4ElOJi+xqEI2k+7Nrxvm1jlFQ3qUuLBy0ZZwRqaZuLd6Mp
         BzYqoCWiUiBkKRoI0+tkAn1BiyCYJT7D1pjhUh+VkUHsmB0QBoIUfJPvmZX2zCK6byyB
         T/iJMKCdPYXylQJWGrQrB3St5+sWQwwq5mqdkXh6PYNR29f1IXYUNccs/Ni7UL5HcFPx
         9Cxw==
X-Gm-Message-State: AOJu0YwhV4Dp6WGRucVLQlD4bMGqalU/siBOo2B46RTCndUg/4JHDKFy
	K/LyTw2GlSe+qQFL6TF+bAYD5qfwtKbaMQOWNDO3mS3Un0neZcSuh0wOzKMZ6UGtmrl1mtFnZKn
	YRX82krF1hwR1F9gxG3jzSw==
X-Received: from dyz19.prod.google.com ([2002:a05:693c:4093:b0:2c0:d207:5bbf])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:aa8c:b0:2c1:60fa:ec48 with SMTP id 5a478bee46e88-2c9333bb027mr1286180eec.31.1775023542808;
 Tue, 31 Mar 2026 23:05:42 -0700 (PDT)
Date: Wed, 01 Apr 2026 06:05:26 +0000
In-Reply-To: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775023538; l=1409;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=Hm9mnvA6yzszUb9UPKy4/znjWQa9nsZzvg20i+LSm88=; b=9Z692FgipJSllZ9p+NhMxC92vUYcczJe6jzeJD1OyRrO0Ex7dhfwstKEVwSsB+4PIIyxzSLSO
 bMCxJtBVRxIAO+1XP294H7yeO1MQCbvA1PIyK819e9diBlkrt2uLEbe
X-Mailer: b4 0.14.3
Message-ID: <20260401-teaming-driver-internal-v2-2-f80c1291727b@google.com>
Subject: [PATCH net-next v2 2/7] net: team: Remove unused team_mode_op, port_enabled
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273898-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 065013750C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team_mode_op wasn't used by any of the team modes, so remove it.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
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
2.53.0.1118.gaef5881109-goog


