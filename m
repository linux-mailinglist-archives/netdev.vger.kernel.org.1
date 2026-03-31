Return-Path: <netdev+bounces-273468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DpnCBNdy2lJGwYAu9opvQ
	(envelope-from <netdev+bounces-273468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:35:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4440D36428C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FDEE300BCA2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6736D51F;
	Tue, 31 Mar 2026 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMyFCEBZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEAD36C0D2
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935310; cv=none; b=IYNTog2Q47fRn3EIsvERy+by1YVANQsujFnWOGot7AVqvDN7btm3MqOoWenxrqc08+pQupkfXtI31nkGqJvQY7P/tgKVGcUu/06jY4yr7CWOV16zDOJy/DInYT2FMuW8HTr4bKkyU8QoSbsxe/4HXg12js5Ko2dQZ4Vi8KO9TuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935310; c=relaxed/simple;
	bh=R94majz8mV0atvThgTkdKQEuUKBPnraEojIwhia5cJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TO6ENqT/uUmGRjZ3WfaKwts9g30EU93iVfIk2jit5J+qBu8Xp4+mo67HHx7srF+XOknKwogHVYTTaa2JeQkkOd6Wm+c8Y28AOy1GqBkv2qDjVrFY2RWgGEpxvZLAJGjQKQ1p/5jQJTpQyVChjZRyJIdYoedxxCDCPdNACNlbbZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMyFCEBZ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1275c6fc58aso6654709c88.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774935308; x=1775540108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iI1ZGUI+LB9nzNnETr8lTsBK4ItFfJAr3/iqDBBl74E=;
        b=PMyFCEBZB/Uiu+QcR+j27A+DVGRwIg04QFSeNb2riRqpjZKwd98OYBsaLy2g0PgpZx
         +vX8SVOzJ22kYy59IK5YPgoYds1FUh3kU8hB93XvuTZQlhul5HyVUlmhijkqaso+UiNA
         mqPvJOH1vbwvvExgftoou//yvrinuT/9E0RZ/Uy+RVCJaLeGOwRtrCofl8q+XyVZDeKi
         tvI6dXxda4K28AWdp/hu8QRAYcWpwDBeoRbRbyl8rolCXQbC4uCWPyjfGN5xxz/3a9Jv
         3PapEbnGdMjKkt184kXHJg3h0GLnHvkh0kcODpnBprLZDC4h8rAKirNB+I7FPr3x/AC2
         7Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774935308; x=1775540108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI1ZGUI+LB9nzNnETr8lTsBK4ItFfJAr3/iqDBBl74E=;
        b=Vjf8mtXm59BczLLRzlqSHvNW0fWtmKfgzH3XlUfTLYik4E2/G7WJxCC0J5+AeeH6wY
         /jNSRWlfaWypHnHr2z265fKJ02g1L7anydL3lYBIWmRzMJSg5d55p5pFHhZst2aaX4w+
         L8BEUECKacZPwK49JabPYR8/nan3IZYsuPINPAhgAhFZZS3wv7rgaBEvpwaA3iBBqEaa
         HpOg0VBPIpr12K1QagfTrHmChwKrHAEsNQFyherzLQF26LsYKStVjLtnxIVz+FDk9d0t
         4Z3S3HDxpmAYLsxlsOTwsf9ZAbxb/y1BFuv0Q+icfgm4agonxSXpniZgv5LICHDnD7hz
         RfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt7av9/uOXtkd5azA/63SwJL1DPa6Z5wpA4dezrewkiaSNTPx11XsD/Tk3BKBuHHEoKoLVjRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8GlixWLKgOZE99TqH0lDLJa+IbWzdhnEtB5l3edp4cjY3v70
	OBLEttXUsRtU3yb2+GDBjUMpOU/klzXB2TmAXyTV85vXcXfvZJfCl3Q6jUQM9ktGilV2GSEjw9B
	muwYFWv1KtzMAcLYdUceY0A==
X-Received: from dlbrx13.prod.google.com ([2002:a05:7022:170d:b0:12a:8225:c504])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:3d01:b0:12a:91fe:f5c0 with SMTP id a92af1059eb24-12ab28e58f6mr8027760c88.32.1774935307472;
 Mon, 30 Mar 2026 22:35:07 -0700 (PDT)
Date: Tue, 31 Mar 2026 05:33:49 +0000
In-Reply-To: <20260331053353.2504254-1-marcharvey@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331053353.2504254-1-marcharvey@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331053353.2504254-4-marcharvey@google.com>
Subject: [PATCH net-next 3/7] net: team: Rename port_disabled team mode op to port_tx_disabled
From: Marc Harvey <marcharvey@google.com>
To: jiri@resnulli.us, andrew+netdev@lunn.ch
Cc: willemb@google.com, maheshb@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273468-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4440D36428C
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
2.53.0.1018.g2bb0e51243-goog


