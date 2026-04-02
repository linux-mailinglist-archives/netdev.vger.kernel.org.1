Return-Path: <netdev+bounces-274384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EOSC8YMzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:29:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 819FE384798
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 08:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9D6430B8279
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BD237FF76;
	Thu,  2 Apr 2026 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/l3eTPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1037F72E
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111076; cv=none; b=eLiGEoq7PudMDfBp3NjC7RR7nSDRCm8qwAR29o6WBMV7fMalM8rMroxzHr6TR1g/hBudoS7LQbaQpdiyxELEx1y8VTxc/UFhBw/7RurdqoeFNHjC7k1Blxng+HHuI8ZS9Ml1q6Olfm3opvwcjP+cgCbnGEcHy5reAwdTPdpXtxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111076; c=relaxed/simple;
	bh=hQyAafXwfvclv1praLESWjnpnN1FJSrHoMT32xvYXEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IXbLIQ3wswezVrOgByBUyiADNMk4lCys7r74V0h4TOF10qXB5shjHAOQrzpQ01sVQLrtLtUgLCUPR8blExC/0q2HjI8JZGAKROX4Ihvc6+C8EI0OK+OMWCO5+8EUXn7TUUso4ZKDcf3dZxT+rWGb5VIZNScBuy26776TaPP8axk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/l3eTPQ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so885713c88.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775111074; x=1775715874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn/zFHSnD52wLKA/jhKTIedusd6T1QUhMICqYQwpj2U=;
        b=W/l3eTPQaf4p4PiUCYQb/e0CKnGtkLB4lEN0q3RwXtJo0zkThp5HKwmVmJCWoULacV
         PdBNeX6sdZHaUNKcZby0mf3FMN6+1NYeFbgkl5k5E5aG3ziix2nrl5NCrlfAUMR9HsjB
         Z2bGoE9PtAjFukifutQJBPb0wVhqaqzSxlgtFez5g4dC//iVapkgpJBCvecacVPccY7I
         RZ1pP6LUuwuqHkRT6qvKLYuFz3aLj0NXGWn1eDDuHFoTO+U8wM36sJeXW1TOrvl9y/L+
         HiIUw5oa41jk0m1nYfqscB0YK5WOOHYnHPaM9lX6F/18urnPB5Tgs3qizicRHm0lszTr
         XWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111074; x=1775715874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn/zFHSnD52wLKA/jhKTIedusd6T1QUhMICqYQwpj2U=;
        b=lrN9pUMRWHqVQ0ncrJGDh8IDqoptMIE8PaTUdg3LoQ7r/SKcgXGuIh1E9czo5z6Bl9
         erMCs1lXagK6cMo0HaiXgB+KVv4vpEFbparJtrzez9xEc4+RXv6FTsbGjGv9CZuvU9oJ
         JYf/IBLjr3vpRRfby8SbaIMIZsW3/6Uv8laIxkjhXMB43lnY0JzfoLzm+AZHgncpwnGc
         RUHzg71Ul5M2OQaRbDT6rwaU7/J8kioFjllU0fZ8xPQxvA/yeW1fBcXeXloUEvJwShsQ
         Al18OzARMZgoPL3snYzDACeQ+0NnzqoAsnvsrJJMIKizsqJmeJb09nBYX0ym8Pu7Khv7
         IjAg==
X-Gm-Message-State: AOJu0Ywb5llj8SDaeWbV+goBxSZJ3zlf0oUmLi8TP3Z9qe/ZPs1YcmyL
	fjtwCcRLYS1rp/8mhk8/z7IuWW9OnTGv5Fu8bIdPH3I0bpdfwKyUkAfEvFpRXjcjG1KKNruw/rN
	1MAL7l9/D36Sc/IYLPNdKeA==
X-Received: from dlae2.prod.google.com ([2002:a05:701b:2302:b0:128:cff2:6560])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:171c:b0:12b:ee92:a60e with SMTP id a92af1059eb24-12bee92a6a0mr566583c88.8.1775111074277;
 Wed, 01 Apr 2026 23:24:34 -0700 (PDT)
Date: Thu, 02 Apr 2026 06:24:15 +0000
In-Reply-To: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775111069; l=1435;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=hQyAafXwfvclv1praLESWjnpnN1FJSrHoMT32xvYXEs=; b=uSJdDKf70qhFB82v+W3HK5hU8cu23biKM6MOjmheDadzn6X17KpL/XkNWi286FPSNwd48DGFW
 NEVSRyl3+xmDfMXh3C4AkN3M71o1QF8fZcDlPs+7Dz/8AHDWE6+1Xb7
X-Mailer: b4 0.14.3
Message-ID: <20260402-teaming-driver-internal-v3-2-e8cfdec3b5c2@google.com>
Subject: [PATCH net-next v3 2/7] net: team: Remove unused team_mode_op, port_enabled
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
	TAGGED_FROM(0.00)[bounces-274384-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 819FE384798
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team_mode_op wasn't used by any of the team modes, so remove it.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
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


