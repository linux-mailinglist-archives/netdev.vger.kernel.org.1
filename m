Return-Path: <netdev+bounces-274385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEIQOg8NzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:30:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8AA3847BE
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5478530D3E7C
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DA381B12;
	Thu,  2 Apr 2026 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHslOeID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF737F007
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111078; cv=none; b=QU5JdKlBHdvVhE79bOXqsVvcvgT2Y3yuUkiHDlwJpzF2FHx8C9ydXiVhWWiU66kHVdmMkGDWW0ROjyN8dvEzv5cm2M6Nb7OqbmWLgbD+zip5aB5us1OhQHfp6Q+bsyXIs8jdSrsOej3dn/4K7y8koiCi3Pq14xS6QsLKtFZCaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111078; c=relaxed/simple;
	bh=HQjOdpWVp0pioXC2IZRDM9wty7V0fQbV6ok41MLNUd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VDNG3EcBWLaqDkqPpQklB4bQYq+1/8z1bJuhtN/NvhJOcD44oSIET9eZnuIjWvWqMJZ8dcqdgoUCbCLVQpt7lTZpnAOK1aaZoohwbz6PBhVYCkWJf03EQGg31ouolplCnHS3Isl6WAakGFpuBnvjgryL6DmpMQUyZW5c4R67ymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHslOeID; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so521142eec.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775111076; x=1775715876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgsfKORANRJz+p1LPldcLkTl0RXQtetjHTccrdSgIh4=;
        b=fHslOeID+NKCsI8e1KfyRYhIHOty+ic0GZx/UUlKtSky63kOOmDyj+5QuPA+uEfU8C
         uEsaFP8MhHA4ETFYj59Ac47cEaAPNpgy24npIQp7gLfAlDWYoeug+V2LonH0IH8K5O3Z
         g2XU7ZJWNktiY5vxePzZ9Euds5B3Pw4z6ORWtzYQLTyMgJJ2iUzSF7vU5kzbGfyHFUiP
         Yicl8Lyw484kvadpWJP35aHa7OxGpu+BTu4F9XE94J86e2La8p6KteyMhzqPr8g2Rp6B
         23trA1+ayUzx9uiUmSxcfoDUwYK3O23/0Cv6fncES9yRzrV1mE5/e3NL0rBluraqUtnm
         Fkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111076; x=1775715876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgsfKORANRJz+p1LPldcLkTl0RXQtetjHTccrdSgIh4=;
        b=d8Qmqg1umPrfkizcT7Kw/EqE/fPkDE7WVd1sM6O/NXX19P8WcuqVczS30gHgcwbC6c
         YMRZxgqxPGNHSZjY8gt30gMQHR7OLqk5BkLL1o+1P1IUHlcjTJFrxZzkQwcvxeANTLpM
         H/YN8i9Jin0Sf0qa1jccfK/wTndpipNanO0Cnv8ij3Bf3s+3kZWU2VO4cqbY38eO1pBG
         Co64HjR1gNkdEwooGitwNNHGMBjRrbNEKnfDavixGM6edDbPfZpwmWitnjUqWBj1sPUT
         nwX8/CwKe4NJOFTiFc+PaIlmIdOwVNCq0mQyO/oorloPXYU5V5Ainj0snO8J7IwiHJjY
         x+iw==
X-Gm-Message-State: AOJu0YzJbQo+K9HmP0GcfaO7FCzBfYWZ/Kui7ryp9al2K6ljH++9xvP6
	j9YuviGeRj3vESIWGef29g3H88W5RIG2ZW6WT9QLxYWnqJ18O/GgnoH62sm3XB0bdCg5hFIy/Gq
	LhmuX5hERYOvmuivVVp+Mvw==
X-Received: from dybmd43.prod.google.com ([2002:a05:7301:182b:b0:2ca:4c73:9998])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:2c14:b0:2be:ca4:e114 with SMTP id 5a478bee46e88-2cad6fca9dfmr478824eec.9.1775111075992;
 Wed, 01 Apr 2026 23:24:35 -0700 (PDT)
Date: Thu, 02 Apr 2026 06:24:16 +0000
In-Reply-To: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775111069; l=2559;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=HQjOdpWVp0pioXC2IZRDM9wty7V0fQbV6ok41MLNUd0=; b=1EaJAA4bTmSBIRbv9Jbm0RlvkzzUF+Xp1V4ol+DxjjYozQyx+p/QF7F3rAJ0nYKWhUewTiuOU
 GFyrIj6olI7B4rq/DWW6kTIixrdSjtWCm1i929UMQ+0MwoyJZYInHn2
X-Mailer: b4 0.14.3
Message-ID: <20260402-teaming-driver-internal-v3-3-e8cfdec3b5c2@google.com>
Subject: [PATCH net-next v3 3/7] net: team: Rename port_disabled team mode op
 to port_tx_disabled
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
	TAGGED_FROM(0.00)[bounces-274385-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 4A8AA3847BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team mode op is only used by the load balance mode, and it only
uses it in the tx path.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v3:
- None

Changes in v2:
- None
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
2.53.0.1185.g05d4b7b318-goog


