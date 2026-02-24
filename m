Return-Path: <netdev+bounces-260304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBSADxcHnWk7MgQAu9opvQ
	(envelope-from <netdev+bounces-260304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:04:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90166180CE0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DBBD30FD77C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F271A9FBC;
	Tue, 24 Feb 2026 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxqvkppu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BA1EB9F2
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898564; cv=none; b=e1SKnjbA6srj4T5+P8xTj0GrbCrow3Wk3FBcuq5MeqNX+ayOH3Y0ZMDy35esuUiwbrQgh+9GQZauLPr+mhL4Usx7ha/1eHvkd8/tMD13cHeOGNrsvu0AsfbmHsLEKv3eUPuur4zTuX/JYBogsHB/kf7sJAqmmdGPMLmnVktrJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898564; c=relaxed/simple;
	bh=jKl+rLgdOYg8KJEmtscbBU/VJIkevqTIWnLMTVACJwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhdbRDRVOtXCKR89u8inrfZ5MuS/Tmyfll4l0irEBkZnx2iUqv0EeEIuXgn+uO+hCpGV/G1J6lXzNBVBmSahIr8ZRliYyHqE3yfHux3eS5ClRnJka5GXEgXZyJhSPpMOjR92zZyK//QxRdn9gQxNP6HNZKH/cB5GphmR+XSfHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxqvkppu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aad1dc8856so36070265ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771898563; x=1772503363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk572Rvhfjk0oj9QGnDog3MM+v9kEr3Zu/TrV5s9IUw=;
        b=cxqvkppu3rUHbvEVSBOmTWqGqAn137MF1cNZ4tvnqAa1UoYV+IL2gPofthlKdGd0Co
         R12Ny0sqzoZcYxQ1QLLMBaF4A98ZjbXxXR1pkvob8xxlf9BMnTf1KwxnN7LHmXQVOLEL
         C8ypUc3YRZriL7TOwU5JB8YfCrvvV69xAV/pMFseM3w3vfFzB7Pc1SB9WNqXy7fPzVZL
         dbltN+fK6qEOtBXpMJaoHlsFS+w7zllfbtNNEZ+cPgchw6rjIPgoFUPpUopszw1tEBy+
         jIF6txhINf6DubHocmZGzxYmsaS0sFQd7+FXIyR/qX7V3eUs0soHO2WhwbWbYfubrqjD
         bsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771898563; x=1772503363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bk572Rvhfjk0oj9QGnDog3MM+v9kEr3Zu/TrV5s9IUw=;
        b=rhKcDUKRxs//pQkGc7jECuZiBKL5ir7Gn0VpyKgkjzXc4DjuefyqBlJQeKi7zxj/VT
         cKZm+Mw4mB4+IRj/tdxUIqtDhvkLR1fZ00I4/NuZhXipiQ/Vgb3F1oNv6NVfH/aqZ6yl
         fNNStntomIauLszmzM0SeSTVNob6ea3crbjwJNdx4lUMY2ZySbv23p4zdbFeHOpScYfs
         ettPbDUS9Hp3wEcpwAimlwMsIO/1WjKmm2diPMMvzTvJ2uab+fIZ2XV7I8r4F7L7DN9t
         x/Ay3MIHz8vTVLW6bHX/HJNSwYGkB+MapWkt+VYaCBnf9r5rzHCoA80u4zxj0AkcIXhC
         e15A==
X-Gm-Message-State: AOJu0Yz4ZPnw3ZjgApfULJ20amksraI2ALZd1VBXGCbR+R6djmhcm35H
	YiN5JBYEARzEWqm0wGgAnG3s93PQR5p9EUNMk8FgxoTUOaweJm7Pjbw/0L81y8Ko
X-Gm-Gg: ATEYQzxpDCK8UztQAIZUlpkjQ/EAQVaRJOwntrs7/gmq27BaNHMsQmtEneHlWkZRBWb
	ncGa/134Nk3Q7Sr/CFR6aVciYL8DsSvux1oDPZ5O/09JO6Y2YjzHfYXszVaUCladoFU/SU9XWCU
	8ET6BWYvmpRyHtazeL3llZDSx+CroJDyIvBz4iqFQS6BAgi8iS6Y1BhPIxU+utkZhe4wTzJ1svr
	BmMhlPX0ZkyPkXRSqR+d/Ld0NxNP/VxkzODTJMKdkM16FdP9juYgqJSEhUdYjJY4JGBRP+uQjOr
	a7OoMkp5U6X3gz6XVK2Ja1w7mGU1mEmrm6y36i6w0WmIoJayYI1PfgNortFM+NrEP/zC585+fx2
	M9zAUSY72pPPmwVoE1DawkLP+eZ18Po3uimNl+Pe9NT43bXdPNVPq4b/YnXr/nsAJM7H9UCX+YR
	8/oGi2IgeLAfHDwT2SLB+1g+hJNls=
X-Received: by 2002:a17:902:ecc6:b0:2aa:d7fe:8603 with SMTP id d9443c01a7336-2ad74419e3emr102184315ad.8.1771898562636;
        Mon, 23 Feb 2026 18:02:42 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd6c30dfsm8802099b3a.27.2026.02.23.18.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 18:02:42 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH iproute2-next] iplink: bond_slave: print actor and partner churn state
Date: Tue, 24 Feb 2026 02:02:15 +0000
Message-ID: <20260224020215.6012-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224020215.6012-1-liuhangbin@gmail.com>
References: <20260224020215.6012-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260304-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90166180CE0
X-Rspamd-Action: no action

Add ability to print both actor and partner port churn states
(MONITOR/CHURN/NO_CHURN) via netlink attributes. This provides
visibility into the LACP churn detection state for bond slaves.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 ip/iplink_bond_slave.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/ip/iplink_bond_slave.c b/ip/iplink_bond_slave.c
index c88100e248dd..5dfe2970941e 100644
--- a/ip/iplink_bond_slave.c
+++ b/ip/iplink_bond_slave.c
@@ -86,6 +86,12 @@ static void print_slave_oper_state(FILE *fp, const char *name, __u16 state)
 	close_json_array(PRINT_ANY, "> ");
 }
 
+static const char *port_churn_state[] = {
+	"MONITOR",
+	"CHURN",
+	"NO_CHURN",
+};
+
 static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 {
 	SPRINT_BUF(b1);
@@ -148,6 +154,26 @@ static void bond_slave_print_opt(struct link_util *lu, FILE *f, struct rtattr *t
 		print_slave_oper_state(f, "ad_partner_oper_port_state_str", state);
 	}
 
+	if (tb[IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE]) {
+		__u8 state = rta_getattr_u8(tb[IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE]);
+
+		if (state >= ARRAY_SIZE(port_churn_state))
+			print_int(PRINT_ANY, "churn_actor_state", "churn_actor_state %u ", state);
+		else
+			print_string(PRINT_ANY, "churn_actor_state", "churn_actor_state %s ",
+				     port_churn_state[state]);
+	}
+
+	if (tb[IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE]) {
+		__u8 state = rta_getattr_u8(tb[IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE]);
+
+		if (state >= ARRAY_SIZE(port_churn_state))
+			print_int(PRINT_ANY, "churn_partner_state", "churn_partner_state %u ", state);
+		else
+			print_string(PRINT_ANY, "churn_partner_state", "churn_partner_state %s ",
+				     port_churn_state[state]);
+	}
+
 	if (tb[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO])
 		print_int(PRINT_ANY,
 			  "actor_port_prio",
-- 
2.50.1


