Return-Path: <netdev+bounces-276248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFFXBw/E1Wkx9gcAu9opvQ
	(envelope-from <netdev+bounces-276248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:57:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B5A3B6631
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7096F3038AE8
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E80E375F89;
	Wed,  8 Apr 2026 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIniq80d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C5374731
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616756; cv=none; b=BbzoX52i8obAt2Ts+2xTa269hyx0GW8jXjag6lUBswgmzJkzWtB2dsQgpQVe3FZI/8ak10o5nqHVgSkz87vncq/vheXX4k9BKbSyO3q4Y9bIjC9gnkx/TlR8V8PYgGblJ0bSkWM43VOt/HCxow/xk3wLwE1MK9NjTLjf6sLFQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616756; c=relaxed/simple;
	bh=tLf1bkN9uV/Iw7z58TBlDPGRsvBgwjwEW1soOYNlMng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLPGwZsWnP3fv9horTJvsQ+55LL1Ggds+okpjO+fUXtZxvarUmWrmZcPbzcrPbg9jEW1ZSh+hfM4aoiSmNXICJi7ZbmVyJMtM2GqZIL17BRGCtDc+BIrPCmG5PLL4WZdYcEmoAWisBHbY/j7UdTMmDvJPA+1MjPwyTadWqBbzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JIniq80d; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12776bebeb3so23241216c88.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775616754; x=1776221554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax5N/AY2QUWPAPxLLKbm2VOEjrgk/KSItcsgBYVbAAY=;
        b=JIniq80dsUrGfsTfWzz4U55SmKvVKLk42s63/BSktf9VN9Wyou01H7xbAg0HNlcxRk
         2Y5yeaemp3ab7FNU2AOg92odKPikfWocm8qvFVcNt+45aqnukO777NY438nlhqLNSSV6
         gWTBoIlPNx8vvXCm2BJe3wkRYT1woIj7l04nlJo9Pd91nTGF0PaIu7beurvT9NeuWQuR
         m9a+wI3l4NosNxItKOOL7Mu2jBf36vgC56VujgF8zKC/gWQrTpjRreSql2WpiYhpA9nz
         Pdjydd8EAXBaUnlxglirDNnod/qt90XsqxvWTaE1pJ3R8wr6nsvmUQmmD5UZipWs2TpV
         7pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775616754; x=1776221554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax5N/AY2QUWPAPxLLKbm2VOEjrgk/KSItcsgBYVbAAY=;
        b=Ee+R7KB5+zOLUBqpCMnp2Y1a4vC9q7jt0jElRq0KMGrp+hTXHX5g1efPGUPDXgW4hq
         IJYzV282gPqSX05BmK9JXEbGI83YbJxDUL/XUJGc3r90LUgBKW9cVsOOjDTwuBYT3F9C
         9EBerBOGBVbp8CdKnTWqRGDOrFpaIcMP9Iq42N9LDKQwcE1RHFbhKEYBCfJBJwo0avNA
         Xmw+jmsIm3NkWw/hkNQFEOpiu8TIG4TUZpCdHnKgaeCTKYVah+EXmMqlhM/p5ybcqJk7
         Wesvywez4QXU5TsDXOoDda79DdNMyu05C6qD7uCV8YuDmYBAkR10qoD0OCQ1j8C2asM8
         g01g==
X-Gm-Message-State: AOJu0Yz619i1hlVAte9bCkY02/f1AVw/D0ukSlSwGsa7JdrRKJ1E5cnV
	YcU6dxDvx+RsLf3hwUE1sbVDcxYf35dkxbkkBTFWonFOszmsNwePQ1loq2Z7dUP1B4lfNbHyRYa
	I0GqWDcklxAR7FmDpScL5hg==
X-Received: from dlaj20.prod.google.com ([2002:a05:701b:2814:b0:12a:6c32:ffce])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:4396:b0:128:d2a5:709c with SMTP id a92af1059eb24-12bfb76f887mr9974725c88.33.1775616753732;
 Tue, 07 Apr 2026 19:52:33 -0700 (PDT)
Date: Wed, 08 Apr 2026 02:52:22 +0000
In-Reply-To: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775616747; l=2504;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=tLf1bkN9uV/Iw7z58TBlDPGRsvBgwjwEW1soOYNlMng=; b=z/hty/splzkDAHFuVlNKIT9qqTuMq3/lMpSVznb6sXy8z5QUeqtOlQ20UqrB5K3Trejhd+ocB
 MFSJECD/SaeC90xQho4F/lLItmaTaC2pShaV/vS6BFWsZVL4j3cDZof
X-Mailer: b4 0.14.3
Message-ID: <20260408-teaming-driver-internal-v6-3-e5bcdcf72504@google.com>
Subject: [PATCH net-next v6 03/10] net: team: Rename port_disabled team mode
 op to port_tx_disabled
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
	TAGGED_FROM(0.00)[bounces-276248-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 87B5A3B6631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team mode op is only used by the load balance mode, and it only
uses it in the tx path.

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


