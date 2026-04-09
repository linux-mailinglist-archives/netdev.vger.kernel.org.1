Return-Path: <netdev+bounces-276816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GMzKqMW12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:01:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 481453C5D8C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFD6F303FF2D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8E36E495;
	Thu,  9 Apr 2026 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/D7PpXj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4F36F437
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703585; cv=none; b=pLeo/5n8JQiUEweLCDcL6ySc0gBauPJIue0Fc+20MJ2nJ71lX5r1UZOUmq7s88GhPBKILRuX8hksWjP+PtrepnCkWN5cc/QYEgzSc1hHQNebXUZQOr7jyHgRwqM8h02cwpVW7wFzBzGtTh8mPO1bV+Nxt/gxJqeDxWfuJ9qVZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703585; c=relaxed/simple;
	bh=ABDDARZ3LBRa/K2R4lTmrc2M2fscQVtdq2vQFlp7tVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a10VWs2Moj4sIbXUlSOp3l5MkfqrCWb/Uar/13DSOH6JrVwgGSsMh/cxL8uFMyIkDffXKvef+2TYdgbOu125SBrGWZJqlVL+WwZcCRUq/NUYH7+oKsXzHa/qHy3/c9qIldEOd5prbSyyT3TLn2Sipokf9+w1i6+3oVI8/vDXlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/D7PpXj; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12734af2ca4so226335c88.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775703583; x=1776308383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItnT3gTeM/wZiruuzHdFs4ZevuvK/cu62n/SK5ptp+Q=;
        b=G/D7PpXj0z2beIgF2jrcLp1H8hs+xGXaFevWAoV4xMrSj2s53TSdhucHH8iZCUapa3
         pq9smiKuRh3fhP4zixBvJgClwYGqOfYsrAN6Thz7BoIQrn3mUoheHd0ONj+6g5UI1hmg
         ONv1d9jT1LF3nVEucjhiy7RIDiau9NcRSdDdUZu84uTiqEkvdDMJPtsr5TTwVAq3FiQH
         KDhA36bmuycJ7JhSyFw7+S7HrHmugtYY3bXK8mSkKFPfAOYYL72jAXqBFO9JXrzDuuTe
         mPaZeK89UsrzG5sk/+DQDJ+08NHa379PhSKxROF+Lwyx/g8JuGalS88Y4y7PGZRjaldj
         2a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775703583; x=1776308383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItnT3gTeM/wZiruuzHdFs4ZevuvK/cu62n/SK5ptp+Q=;
        b=MeJw3HayK6x5ICuZNIoW5TbBozyBvY0LO5JQEbEUGMSEW96WNzRNAwg9Csi2dUTwwD
         YlO9DkQA3zOe9iJgFnNsks9riv6K3XVCbfGIqb6STlkxp+Jxq5sFtJIkGxRQmfFb1J+P
         +ochTO6a/P3fPvs8t2TX2VBGZvSC/iMeoTHJCszgMIcfULi/omL+iOiIgGC1Ck0XKrSQ
         t3y5ZHewTz5NYkRaoUm7O98vgqjSXwthnasJ+4QGuoyvVzVcz4N3I7paeEkCUfIxL+bH
         eyPqxXQy8uxwgjGKRjJZ27kSmyVB0vIkbDrcnalM6YW7KdJutHQIXsRGMSpIMLvpUq+Q
         iB7Q==
X-Gm-Message-State: AOJu0YxtcyIMnyKTdXU4E581GXfHATzZiMKKneiXviwa/dnM3WAj0/B1
	ezSawjpkq3pqil42Cy7JmowYQ/lFQWanY3U2a2d17mVp6p1SDRmHEjkLacD96YUPUtXSVvz1+3V
	kGPe4bezBJL8RDOinjROv1A==
X-Received: from dlae27.prod.google.com ([2002:a05:701b:231b:b0:128:d5fb:9499])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:62a7:b0:12a:6b26:8618 with SMTP id a92af1059eb24-12c28bfb94bmr758498c88.2.1775703582932;
 Wed, 08 Apr 2026 19:59:42 -0700 (PDT)
Date: Thu, 09 Apr 2026 02:59:24 +0000
In-Reply-To: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775703578; l=1423;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=ABDDARZ3LBRa/K2R4lTmrc2M2fscQVtdq2vQFlp7tVs=; b=kdcsT5XJnAHHE62BM3HFqfoIp2uMAM96Q2vOeaY75PNPu8Eckb2aCFnN2JVpfBr2VIEbIG/mt
 pl2VaAbKNe7BLgKvRvRf0bTj3iIk4dKhfDB9MRhgUin+1OzQnF2LVuH
X-Mailer: b4 0.14.3
Message-ID: <20260409-teaming-driver-internal-v7-2-f47e7589685d@google.com>
Subject: [PATCH net-next v7 02/10] net: team: Remove unused team_mode_op, port_enabled
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
	TAGGED_FROM(0.00)[bounces-276816-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 481453C5D8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team_mode_op wasn't used by any of the team modes, so remove it.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
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
2.53.0.1213.gd9a14994de-goog


