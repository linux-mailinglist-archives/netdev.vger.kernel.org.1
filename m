Return-Path: <netdev+bounces-276247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GooJtrD1Wkx9gcAu9opvQ
	(envelope-from <netdev+bounces-276247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:56:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FE23B6613
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6391930851C7
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04BD374166;
	Wed,  8 Apr 2026 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNGo464d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34676364937
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616754; cv=none; b=h0PCMvqs9zMu9j1oS3x5GehfN8pr2Z0Z5vFZ1UeFFl05MLai5WMT/ZUIjXaV9Xrim6LocuI9Jl/AMU4exuCttdRU9YIfBCrEPejavFXGzEQEgesSKv8VV4DrsdjNix0IgKKPy9Lrru2Cnddv0tEM/bY+nmyoWqbEsmOqJv+IEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616754; c=relaxed/simple;
	bh=ABDDARZ3LBRa/K2R4lTmrc2M2fscQVtdq2vQFlp7tVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/qqNpuHR7AnkXKTyaSVoneEU1Kzi5ItRZkmmDv2+R56pYAtcDtQGCJbsjjzj9hSBAHNJ5OcM1absf1nieKSScvLm3kWYnJBsni38uEfqEcXY7+nFHWGJ/qo415Xrm0wsuMgOLHA7vZElLyJ6IQ1gFwf6JQKpK0G8vlL8HpDdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNGo464d; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ceef8e793fso10244155eec.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775616752; x=1776221552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItnT3gTeM/wZiruuzHdFs4ZevuvK/cu62n/SK5ptp+Q=;
        b=RNGo464dwhE9MNdS9B8R5Fas3/YW0m6G6Pm2fQsC//Kf3jQX3gbuVzngG5uhuRP4v8
         H11N0T/HdKUN6e8oB/kEj9B1rJwW75UOIbj2XCvzhfmzCQw/Y6izhcXLjibXyurD0FiJ
         RGUw9Bd07YA/vuXQ+ku8y+It3iYchTJMlOes4Ia2cuPlHoBB+sIafemDTL4JqtJK4B9v
         DMVxjWsbvixGvEzZsTwsOmhuPbPu7xKptbtTHQR8taEy4F+2GSMW7KHOdNCrZfirYYFR
         4EScjjX0qeKtT5/BCBTJC89VpS1zcedoj4wcQ7/qTxT8efIvEnEEVIgPcXPlXLAucqLy
         Speg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775616752; x=1776221552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItnT3gTeM/wZiruuzHdFs4ZevuvK/cu62n/SK5ptp+Q=;
        b=NmXQQtOt8Cui8EtgGsCVV8KSGEvtpK+sETrKu3rjBOpT/ZMx1YKcEU6xJFSjbDyoAF
         N2pfrMfHWlkyz80SNHx/MADTuClUb3RZU0gQA2Q2lYKhEVnOr1OYDdvBatIiHh16XE6x
         5tGpeId2k/FetEtrxww34Aa75BL3mVa0k0l/YL3AbD2D5zAF/SWQG7V6gfy9VlCZKL1m
         BiKCSnsknZM/yVgp+pCltGF/VLbHC3wiv97RsRy0oUHCzYHXm/tLkVFB6a1Toz5FKO8g
         dePro1XqC0oJFolV1N0XQlo1TqZv3nHIXd1EwlMIgkwQF34nVgHNkGHV5q0MmYAlhqYr
         vSbg==
X-Gm-Message-State: AOJu0Yx9QNDsfmtUjpfAN+LKmsJ8KY7x1yFGhFhZ77Y+DyXrdtf+fAIe
	ZmF1Yw/QQPaw8dSUKYQ+8go9nS3RSxxESuybzwEXj2QtcjPotv0Cp2GOuqUOSrwy8qUlOYAx3Jn
	cY16raCVTfNzbB7hHU+eySg==
X-Received: from dybma11.prod.google.com ([2002:a05:7301:168b:b0:2cc:9049:2bf6])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:3c9b:b0:2d3:d3f:2429 with SMTP id 5a478bee46e88-2d30d3f2ce0mr394310eec.0.1775616752127;
 Tue, 07 Apr 2026 19:52:32 -0700 (PDT)
Date: Wed, 08 Apr 2026 02:52:21 +0000
In-Reply-To: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775616747; l=1423;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=ABDDARZ3LBRa/K2R4lTmrc2M2fscQVtdq2vQFlp7tVs=; b=r8cB68lfooR/1QW4AS+aBeHw0DbnRNjdO87i6cEXF/Acqd5qIrPf4eNSGhRzdGV/Z/oo96MIo
 yIGXIDlBRm6C+KwLRmMIBbs9OW0KXroMNL8Rxs6JMfMBHs1L3lun8yT
X-Mailer: b4 0.14.3
Message-ID: <20260408-teaming-driver-internal-v6-2-e5bcdcf72504@google.com>
Subject: [PATCH net-next v6 02/10] net: team: Remove unused team_mode_op, port_enabled
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>, 
	Jiri Pirko <jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-276247-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
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
X-Rspamd-Queue-Id: 06FE23B6613
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


