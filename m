Return-Path: <netdev+bounces-297973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gx8hLzNfKmpLoQMAu9opvQ
	(envelope-from <netdev+bounces-297973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96366F41F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ECbXOFKd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297973-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297973-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D363F30104BE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D13A5E98;
	Thu, 11 Jun 2026 07:09:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A058341068
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:09:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161773; cv=none; b=GRITbMbXlYE0NjWaun5a94r8R904zSOmPmT6fHEgQ3RcGt8k2cHGK9ifDu3Vv5Krd7MaRe+AJ5HoyPx5HUXAcKSrsCKMmgTr7MZ8AjobgAHpXp8XS/clX/cEvb1xD3eoicDdBU0thUlmVwYIvBaRNnZbLY2rVOjKKLO8EDSxyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161773; c=relaxed/simple;
	bh=2J4WkPWd6zkpCf4t9Fjo5QKjJMCMO93KNXQsdQROUds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWRuX0reNPoD11jcteUiFsMVEFZDdDKee6VH7iA13OYO0Qo3tfSdfP0DCECv1PlHrkRDdvB2357K1/TI6aXtBo4rP3hAZazwBTGVyr8KPKw+D7AsxbYD59Ei9qHGh1MvWuDzDkspPpeDsrHccViAcs4Mq3yfTynWSKzmLSlEjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECbXOFKd; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf30d530bdso75822785ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161772; x=1781766572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mw+VThKrTwLJnTXbmUk1gxzfi3lKyUFtaKcOb9+K7J4=;
        b=ECbXOFKd6EyZ0hgQcwqtiXff+91eK0GnID9c0vjATHRC+8no5LbTtMWOLHPMIbvEZh
         fP9yWhrEFTtvcKn3hovVuroZBoUINYoB9zJlTMc8qq9hEg25PY4U55LNr+PSRWLRHSwH
         3SynBZaY29zNrZ1iwN3lRG4X53AwGieCGreEvt7bnVF/cI97ysBQgyJtf5cNZfAp8F3J
         GcMVOAlk8ir0QJ+CCgK+aIufarusjE7wjJeqIiiwuEL+lzeST6Qpnha1jTJWe1Pv8BPM
         wiDDG0m/C+eC34MRMVxCuUnjJZhO8RM84WTvu7rt6vY00DFOXi9/TDaKnOIHCqF4dGXb
         KkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161772; x=1781766572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mw+VThKrTwLJnTXbmUk1gxzfi3lKyUFtaKcOb9+K7J4=;
        b=UfE4VahLISHpIyNFD5rRDNFqt3NTkgbUpC2ty8X92uojla9Bn/n2RSMW0KlFs0c1WU
         OaWhoiAYgAn73iwkIiay3WmPAskAlIghmrVxAox5z3m4+L+qmRBe0d+4Sb29QlHz33wj
         m1Zaw1zu5HTcXHDkszW7E9IPsF6wV5m7afvor8u3gxrIsnL2ONJmf9q2OQ2qZRM37GLn
         FMDerApuvHs/h+r3h0i2k4Juo798Fv4UPxFWEZ27d65xRQxdE+zZ8mjQxLGSwFLKe4Ff
         I07pge2Vqct/j0Idi4WbF21hOKi6EyT/krAb9DAJGGGcXIgD+vUpB3z+ZL1Dl/Az/qF6
         o1ow==
X-Gm-Message-State: AOJu0YyeKdCd2K8CQgnP/hCxEFJor/vVPJmgYWSmxkzQfzQ5QlyoK3G3
	NKhuFi5PDJ4suf5lwnECK2qr1M8WPn42tOQvXJP3G73bPNsZIng6EhnaPPPYQoI6
X-Gm-Gg: Acq92OE31IiyAmEl0FtKuxVQnAtsUesnsth1dgqXjid7uTadTHnTqoZYLu/RN3+Gz0P
	B7M2zr1U0/bUASmLk83lLOwLSOTl+f18UfzxSk3JLj/RkhfKsMNSPsp2BW/v8q9/czgKn5KEx41
	Q252K8lu1FwAufVPnC4DTxTrHDARlp6QetlaRTrPNczyNGs6LdvDxBZVoEB6SqEZGmWkcJ5WXn3
	iaCdBUYdHkdGAq88FHm/R7ie9AHvXgOcs+rXfaNo6Yoi/YEiuN5cxPTBtq195sjrv+0MBQN8ynC
	NcpFCiTU86I2ymWdm/QyRjy2q38WEYM5nIHw30kopra+CFjmhSpdqMPWGkCETfyaAnYoGUxqwDB
	IVAX6RweJY3wxuGWDcG+0BWrhM17DmpI08KB4VsQgjEkuzT0yaENCg3TQLHjXBYjZ9ZdVLRmzem
	F6COZ7mb7BFK4UGG9sDDoSzywPCHljdpSn6+OLQmfzDZOWnRod6z+R6HoIeyGf
X-Received: by 2002:a17:903:2b0f:b0:2c0:b932:8680 with SMTP id d9443c01a7336-2c2f23a9446mr18843875ad.10.1781161771855;
        Thu, 11 Jun 2026 00:09:31 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3046::4cf:39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm18818975ad.77.2026.06.11.00.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:09:31 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/5] net: dsa: b53: avoid devlink resource IDs collision with PARENT_TOP
Date: Thu, 11 Jun 2026 15:08:48 +0800
Message-ID: <20260611070856.889700-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611070856.889700-1-mmyangfl@gmail.com>
References: <20260611070856.889700-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297973-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,resnulli.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kurt@linutronix.de,m:jiri@resnulli.us,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E96366F41F

This might not cause real problems, but the b53 devlink resource ID
collides with the sentinel DEVLINK_RESOURCE_ID_PARENT_TOP (0). Avoid it
by keeping the real resource IDs starting at 1.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 06b8be8dc4db..3f5b9592794d 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1225,6 +1225,7 @@ int b53_get_sset_count(struct dsa_switch *ds, int port, int sset)
 EXPORT_SYMBOL(b53_get_sset_count);
 
 enum b53_devlink_resource_id {
+	B53_DEVLINK_PARAM_ID_NONE,  /* DEVLINK_RESOURCE_ID_PARENT_TOP */
 	B53_DEVLINK_PARAM_ID_VLAN_TABLE,
 };
 
-- 
2.53.0


