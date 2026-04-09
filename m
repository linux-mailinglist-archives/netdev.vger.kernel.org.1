Return-Path: <netdev+bounces-276817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFdFEdgW12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:02:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E26C73C5DB9
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47BBD3056178
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A2371CE6;
	Thu,  9 Apr 2026 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tECTorDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9C36EAB8
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703587; cv=none; b=eaIPVOW03rRF3d7KxMego8sEMaYOLUJgqrK/R35roncZ1KmriQpfCuLmo6PVw9+EPodQG64R0Vg9Efsu7HqLMuGXI4LkieF3Y6Lfkh4QTBHqOXY9OjrlR/u+PhEyEaDL1wXdDZWV/AwqtD9hZ8XApHMqf3Ign7cfAgvvbpWontY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703587; c=relaxed/simple;
	bh=mvIKouX7KYTHJExe4K1Q5Tx8rBXxuO1bORlEsN8SGgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qX63mOGS3pTf0DUN8pkw9v/cS9+KWUepb01Zy8AqiZl3BBm7ci9nnO3TLjQ6XgY42jsuDYVkAeB+sTn78H2ZtZ3vVur7yu+GR7CChNXj47dsI7h8m1J0YbZ5XNa/yhDr5ZK+3vL8pfsC2BGjAkD2z8C+AZgYu9STWbfhJBB4X2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tECTorDJ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2cc9118dc2eso878710eec.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 19:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775703585; x=1776308385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXYB66NwxcPzX46bA+O/27ztBCdQojz/GNMLhd0Du4E=;
        b=tECTorDJlEp2j51cfEBxxQoW+LW24ojnOsd6eJ6+4l6FC9jbe01GltVvx4OX5j59JH
         avyNGAaOHW68GnvMhLOBuN9U0kluvxf0ZV+eXDIt7i/rRjNlmr8s+FESQ7FaNeJXAa1N
         a2by4KBJrN1axhgXfvmCRBvKNxmmGVDg+g6yYJTsz/OhfW6Ax9BToTXrBe2IoyUZMq86
         V1yrKfz1aekHWkyfVuN4gL1sRgFSNiUVT2vYgsT4ct1t0382COf6qtjc7FRMS7sNOX0S
         2l9yf7SdNCU99jZdgrtoCrHDQHohkkIG5FOk+/6vh9/OTU7lYtnt+SWfdL1ES/pPwrT1
         x7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775703585; x=1776308385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXYB66NwxcPzX46bA+O/27ztBCdQojz/GNMLhd0Du4E=;
        b=WtnZ6MN6gtZHpkfmoMdFksM15T1OukEX7EIVy6ZsySMWICLXGjCfmtaFDtf7PIdNHB
         O9FQCLGmljhMv7yj5wrM45WBsytKr2tE1CmQBF4nzGMLOX81CIk9fsA/TJGW0UoeSTQC
         WmoMqJYK8ttoGimBBmFGN7lP8L4mzBl0xORRtu11R1zW5AGnb9SXywabkP54M5hddONm
         HbZGlE1QxwSIlE0hxaOmNIuFrY6ebY4CN6SyaGcBE7eumsYfT6PP6zwrOREmn1RVT/1u
         PTZN5C1F7XZvV/pNHm8H5N9nUMKPXzKyqiieEUXAkR20sbkPr44ddmEWhnOblt+CfcGf
         4oRg==
X-Gm-Message-State: AOJu0YzB3/v4AhAgQravvQZV2EqMRgtyCQAlp3LRPqLhDpgWD7fYkTmV
	/j/8pDj6nRc/e/LT0119rKCukcDODavnjCD0RrXz6ccA25je67bowvsU8Rhpi7xFHFUabu8wvRd
	L8wsOdeCcj0XWZsJ2qEdkKQ==
X-Received: from dycou11.prod.google.com ([2002:a05:7300:dc8b:b0:2c6:8e1:498d])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:a599:b0:2d2:2314:416d with SMTP id 5a478bee46e88-2d223147249mr4380849eec.1.1775703585001;
 Wed, 08 Apr 2026 19:59:45 -0700 (PDT)
Date: Thu, 09 Apr 2026 02:59:25 +0000
In-Reply-To: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775703578; l=2547;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=mvIKouX7KYTHJExe4K1Q5Tx8rBXxuO1bORlEsN8SGgM=; b=eUR/GnAQwcnDgAmgr22eGlNjGnbAJHKopfBqd2GGLtNNKz65335Igi69o1fnXyRQaB5nRTZX4
 he+U6edFAcQA+kwbO6fGpjgK8mJY7l8f3iR3UtSbW1UlCsRdOFNpevs
X-Mailer: b4 0.14.3
Message-ID: <20260409-teaming-driver-internal-v7-3-f47e7589685d@google.com>
Subject: [PATCH net-next v7 03/10] net: team: Rename port_disabled team mode
 op to port_tx_disabled
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
	TAGGED_FROM(0.00)[bounces-276817-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E26C73C5DB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team mode op is only used by the load balance mode, and it only
uses it in the tx path.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
---
 drivers/net/team/team_core.c             | 4 ++--
 drivers/net/team/team_mode_loadbalance.c | 4 ++--
 include/linux/if_team.h                  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index e54bd21bd068..2ce31999c99f 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -968,8 +968,8 @@ static void team_port_disable(struct team *team,
 {
 	if (!team_port_enabled(port))
 		return;
-	if (team->ops.port_disabled)
-		team->ops.port_disabled(team, port);
+	if (team->ops.port_tx_disabled)
+		team->ops.port_tx_disabled(team, port);
 	hlist_del_rcu(&port->hlist);
 	__reconstruct_port_hlist(team, port->index);
 	WRITE_ONCE(port->index, -1);
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 684954c2a8de..840f409d250b 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -655,7 +655,7 @@ static void lb_port_leave(struct team *team, struct team_port *port)
 	free_percpu(lb_port_priv->pcpu_stats);
 }
 
-static void lb_port_disabled(struct team *team, struct team_port *port)
+static void lb_port_tx_disabled(struct team *team, struct team_port *port)
 {
 	lb_tx_hash_to_port_mapping_null_port(team, port);
 }
@@ -665,7 +665,7 @@ static const struct team_mode_ops lb_mode_ops = {
 	.exit			= lb_exit,
 	.port_enter		= lb_port_enter,
 	.port_leave		= lb_port_leave,
-	.port_disabled		= lb_port_disabled,
+	.port_tx_disabled	= lb_port_tx_disabled,
 	.receive		= lb_receive,
 	.transmit		= lb_transmit,
 };
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index a761f5282bcf..740cb3100dfc 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -121,7 +121,7 @@ struct team_mode_ops {
 	int (*port_enter)(struct team *team, struct team_port *port);
 	void (*port_leave)(struct team *team, struct team_port *port);
 	void (*port_change_dev_addr)(struct team *team, struct team_port *port);
-	void (*port_disabled)(struct team *team, struct team_port *port);
+	void (*port_tx_disabled)(struct team *team, struct team_port *port);
 };
 
 extern int team_modeop_port_enter(struct team *team, struct team_port *port);

-- 
2.53.0.1213.gd9a14994de-goog


