Return-Path: <netdev+bounces-275512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBh7Fhsj02n1ewcAu9opvQ
	(envelope-from <netdev+bounces-275512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:06:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B667C3A13A0
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CA00301DCD2
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A532ED29;
	Mon,  6 Apr 2026 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvIBkvrK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC78329C6D
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775444694; cv=none; b=fc3EIq4NQpfk67v1Xw/PcXHvv1Gt4zQjFivChMenFz8QPJszIscfq85+tFQtjaU3CCjjSxeqKgawRnIjqRKqTFklr3xKwA+uDl3NzVif5dF55jKFUGjcMav7g2pYFum7Iulb8yDMIAbNrucRBGg6kNh6Ygl6TPKPd5GpQU5fqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775444694; c=relaxed/simple;
	bh=dDEsjk6lTezLXsoeUbs9k8ZxA3nYUDwshHj9esC4o5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVUEL8yf/73rhwRr7thQBRgIOklAqNz9aDwXD5jgZ7o+D2kswlY86cJdHGx5WxX8HD9H11PMKOyRTfXGU+pe5Jy0cbavZEiOxHIVUqAEwNPgeVfm4dN3zCcTQxqfTp9f/P0qxH/CQZ6AGYQAYU1WojvCMSuZ2Xbu/Sm2FZWmKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvIBkvrK; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127337c8e52so16792573c88.1
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775444692; x=1776049492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pDnUicyot0V41/RigwjoadTUASPAO7D8CjiFKP3m/g=;
        b=KvIBkvrKTQyokCEmr56h53+LAvhO7EFoIPskqdf+ZPYEA6I7lAOatr6TCf1FHyhsmx
         CnfuISs8OmoBGe+iG7+cvFJjAqUlOdDcPDcBy3IgXO1DYiq9EB02RKOIoPp6xNzI6YX/
         mSo3YGo++QLU6VK+zKrSstgd6iLXsUWQfhImr/r3gLZAIHKdTNdhiFw6H/WeP/IyDHt/
         jRv8q4TQyd8d2UrLxk5+u63tjS7fH52/8qlb/sVE2mCTZiFqFrNhMEbFp4xyV+RLPVN7
         Csclv7O+QqKtvoowMa4uc2StDjFomTW3/VOUVYKluTXPEe2jJI68jsn1RjJC62P0BAdU
         80hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775444692; x=1776049492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pDnUicyot0V41/RigwjoadTUASPAO7D8CjiFKP3m/g=;
        b=ql1Ps+zK/1q0Ob3RY1ogFnqBn3Azr69MSLpQnLdSXy4FsWEGu78vlwnYQYX4GIOyXc
         AnV9hEdGS14MAzv/4CWhaWU4fFaczAT/8opPfBtWeqrkf36mvzBOV4Y95AYUfpeEq3d4
         kPBfyuc6jCHLa4R4hVjgyVcEdKj11bcf+g4+u0eWFk/gTep+6wr9GQwvRbixTxw3PNoN
         s5QDPPvkLMIud+Nn7UcD4CTbZPcd3n6aaKTFDuiXkUeQXXSvMn/0g07kok5zVB2wG+wu
         /L6ZzkjtGJi4zK29MY0Lp/QplaeiNbdbrxaIJz1IdAAvRdJZABp9oQR1uCO2CJkD4SbL
         eQmA==
X-Gm-Message-State: AOJu0Yz0N/Ofq6lXZAD7u9ls+A4ZtqjqwPI9mbVVsY/MBLKkQm6+SL/F
	l89wUwTYSrX6b6LznBDIAE5EkG51YsNfEYOda0AG5njLEAmcuGQpdnU+0CPsZyMr/Un7ysioWAk
	73I8+h/cHSyYlLwdBxr1eRA==
X-Received: from dlbrl19.prod.google.com ([2002:a05:7022:f513:b0:12a:c3aa:1a1e])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ec14:b0:128:bae0:e03c with SMTP id a92af1059eb24-12bfb765c2emr5877606c88.30.1775444692085;
 Sun, 05 Apr 2026 20:04:52 -0700 (PDT)
Date: Mon, 06 Apr 2026 03:03:38 +0000
In-Reply-To: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775444686; l=1487;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=dDEsjk6lTezLXsoeUbs9k8ZxA3nYUDwshHj9esC4o5k=; b=+vEU6Ba3XhmzULJa0Fkia7jJUI2tfFYs2cBvO+aA2ci9u60lkgE8aUNl8IiZ1mwAsf8l4WkWA
 0hG6WAKgNUEAmJBIYy4YBNd61LW2J2gXcOQcYYnW+me3tJQa8XCZ5JQ
X-Mailer: b4 0.14.3
Message-ID: <20260406-teaming-driver-internal-v5-2-e8a3f348a1c5@google.com>
Subject: [PATCH net-next v5 02/10] net: team: Remove unused team_mode_op, port_enabled
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275512-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B667C3A13A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team_mode_op wasn't used by any of the team modes, so remove it.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v5:
- None

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


