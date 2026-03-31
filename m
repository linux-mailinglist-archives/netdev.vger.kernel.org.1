Return-Path: <netdev+bounces-273467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P6KJNhdy2lJGwYAu9opvQ
	(envelope-from <netdev+bounces-273467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:38:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 058A13642DF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 343F93063D69
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1EB36D517;
	Tue, 31 Mar 2026 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYoScwCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CF1A9F91
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774935299; cv=none; b=X+FEjWEcYPgWQPyXZGJVuomduRGmezXEsKez5iKQ8fPXn6nikYx44H3fhYjEXZtbpdMukVrJQ7yP/Zzecekq/yt9JlowSfQqv9Ivfdzwx4zEAS7qHXLvf7UeUZva8E0+uS4vbfeorElOzT+Ob87pQ1RQLtD8DHiFMFVZrcmmH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774935299; c=relaxed/simple;
	bh=HWY6RyNiDvHQLuF3ImSLICWRLWpkafCxRt+OD3tVgyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ICJtfrS8zz7rUgOesONEngX5F4kBlEKu1DQnoIemQ56IgHIuTwu5hiMkoHGZ9oWnu55SuYy472NIpQ3ANqQI8A4qiYD3Mx7hgNsf6632jDbaDHhH7nP9aYxoTydE2Zr1lNExdduMkE1VV/IPozkBspQAp8ZPftAYnf6w8FXjwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYoScwCv; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so6607833eec.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774935298; x=1775540098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tl2OATA8Qg3HWeAwYs7IcUb/e5eYAIR3FP8Q3rgg4s=;
        b=MYoScwCv/7tEQxnJfpztbs7UTx5vFeipkMsX+oz5HYJLV/VSrkm9sLKzWxkDXgEyf9
         9Nlu8qYptb55HBSxEhE8Wto1ohefMIUCOmzPsd4IRle9vtUmN8+OAqdUvesenLhw+KHX
         4tWRR6sD+Dd9P7Ejx2e7HL/SRfAZo+JCcGjbxfX3cM3r/GSsLbBgQKROrYaCDOLpMlQd
         DinZ+JndIjwJixo0Rs4AfLNPUgYSALj2GcLlIAmD0jobs/x+/kBntC9jSwobt22N7xxD
         d4Yn2wZSKMCWIt5VJXDg98eiFY0iFfjg/R+yfIt8yZlrAOdKnzq4NYSPbwLIKqS9szU/
         siuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774935298; x=1775540098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tl2OATA8Qg3HWeAwYs7IcUb/e5eYAIR3FP8Q3rgg4s=;
        b=qMmaYq/47WA4ZjuLZLoAetcqEbJmyjx4ePSy3YjeeYRLHZw6pYSrnNdZZxp4lKYzwz
         vl3RS+aIX4ixv00vz5o9oaqsWUz042sG9vYW4Zi7ZAvsIbu//hU828OCLtZokqo/9V9v
         no2s2dAc2YzYJIZjZNp/nK0abJYf3HAvDsBTGuFyC0eUPFOQb4/IcFte24fg4dQcQUSO
         xGZoHFJ3DStczChKuD6rtdPoBf410uRiSeG4OfWshzTBWCTqnSU4HmavAmrmC/0+l3JI
         wSSZPpX0I0edqOPSi8ou+JBiqL5+tTikK9q/ymq04JveeJgF4Ybw+NvT6NX0pY5jmRg/
         0C8w==
X-Forwarded-Encrypted: i=1; AJvYcCX8Z7JJTG91ZNcJSRB3l/v1RmYmdXE/DDqDw/jkUp+onUfhBe76c6WZPK2CgdIrj94giUm+S7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4dLKwXScLxYJtW1cL8uBl4m//rBTGTH+uNPRWQGxcVP96g28S
	Ct6/QZE4mj7flFlWjerhrntJw5tTSs9jAlPrff7WOBoVI6nKhaVYqiJUrfD8ExOxVusHmHWrBxf
	MM4hty654bwWucPI/Yl+WoA==
X-Received: from dycpp5.prod.google.com ([2002:a05:7301:dd85:b0:2c6:7749:1784])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:2a2f:b0:2c5:d833:a4fe with SMTP id 5a478bee46e88-2c5d833c6a4mr3715418eec.10.1774935297306;
 Mon, 30 Mar 2026 22:34:57 -0700 (PDT)
Date: Tue, 31 Mar 2026 05:33:48 +0000
In-Reply-To: <20260331053353.2504254-1-marcharvey@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331053353.2504254-1-marcharvey@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331053353.2504254-3-marcharvey@google.com>
Subject: [PATCH net-next 2/7] net: team: Remove unused team_mode_op, port_enabled
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273467-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 058A13642DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team_mode_op wasn't used by any of the team modes, so remove it.

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
2.53.0.1018.g2bb0e51243-goog


