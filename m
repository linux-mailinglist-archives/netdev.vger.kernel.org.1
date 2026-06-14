Return-Path: <netdev+bounces-299229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hUeLEA63Lmpy2AQAu9opvQ
	(envelope-from <netdev+bounces-299229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 16:13:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645568142F
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 16:13:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KgFcwz8Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299229-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299229-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4009730057BE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D5396D1A;
	Sun, 14 Jun 2026 14:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA223921D0
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 14:13:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781446411; cv=none; b=r5LmdowNvHtkJX6DgT8hSBGh71HQaAgpi4IJG0x8tvP6AyU42jolGEopsS+r6PnQzq+sh9leCV/MN63QSHZiNfWWvntYXn9MwkB1UqmS4nH8wUyBaSgi7wS4xr2/EC+DQBWFDkg7iZzmB7ntyHzUESxDwZL0mMtwtgIW7K5xQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781446411; c=relaxed/simple;
	bh=1EnSJ9odQybN4ZDG4xjDMRU3zKCUMkDnSi9NiD1dRVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fpt7j4tfEGzA26KlCdVtofQNfnMbo3X23HuEGQwSBw8lGxS8P8TyHS4lhmUw+ou+2JKVSgnMOeg+mqRj0haXYr9fpH0pL3SxlhtqNH7Rpu0wKyvToATxVj+LPmtd/FZzcIIozR25+Et+UOH3oBVPCIOYgqUFbkmGroQsCXuM5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgFcwz8Q; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423efd76c8so1845727b3a.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781446410; x=1782051210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dVFa0NBOPMIaKgnaB0wmCOUTYLULOo0Dzdm+ng/srEc=;
        b=KgFcwz8QRVwVMvb7uo8un34DVVH62C9tQQtO2hcQH4iFjUeK4kwwa21JGRuja+3vXR
         1H/zeprZYNEPipHGqv3udyZ+SDbPO1O6pzSui9EY6QslS24dwV1+51oBDQ03zabD3MIW
         8TTnnmDL8I3MtIdr4ProrCh0++/RG0LQtaHkEX3iIGO/XBObUbxqaIWxbPoROCUaXfFl
         KlE6lB0kurpQ84pb5Ze2cgjqL1zd1ph4PEqDTmv98H/Ig38baBTrFl3co1eX7RV4Q+EJ
         5X/8HGy8D+oBLyHoGKlDYE4IGqaSXskH9z0bQztXqGh2Wj7dMo/+75cI9DwLF/gIj23i
         5W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781446410; x=1782051210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVFa0NBOPMIaKgnaB0wmCOUTYLULOo0Dzdm+ng/srEc=;
        b=M81DOCblrKYY4azfMFxo27HEi0iTNISEfCfaYQqk8u+5VD5ixBFXX7xeCX82Ghv3kb
         J0dfvTEaFyozcELFVave8oyGHfrp5NeFzrsWvIgHgynbQgCG8o5r6FhL39evZ84QJaFn
         EEBq3DHKSb5zgW1YvKcn1A0AEaL+GY8p2tvqJIdaX6Y2yQgyWZgG6wpdESUN0CBrBulp
         vwKTeH5Mh6558jDoa5ZeJ58xI9vm3liPmRsuONrXdXTUmnwc+cda6jZWYSMfDb7nQgnb
         ZcAPTpkNBkibRaFr464HTc21ZpGGHE6OVxmzEPkkLxVvb5mq1uGNgc2f0++Yp+tO+Cx6
         zjNA==
X-Gm-Message-State: AOJu0Ywa0UYMQOK40LuTqDr9SVZSwcMieIVubaW1bCfujyNJDYT6oUs/
	xTLj46Xzm5h/ZCxZm0a1+RnBgtJ8tlBhc797Nayy0M/wLshNzP/jW8Dh/tOyw5uf70k=
X-Gm-Gg: Acq92OHKgHVNmp0n52bycJS8Ka3AUI6HgqWELceGXfybG7iy2pITpyDPsGwys53xQVf
	B1cy03FX4wS7ZxDLdaN+oTvQP5iuVFI6AD4aIiARsalKhZWZxKMYbblX10E74kxooeMLmK0mcDf
	c2L0DzuSC7+NDwuVI79LmcBffRjIF9FbsOPeW+vlCP8yf5VnI/VnZ1xq6nNmlm3c9B4+nmqZAYA
	td2TNv0IIru8MBj+GAo3DOviYNmTBinvYzSFCXE6vBv1G6/D2zV6nT/7u4OWbXD074f13w6LP1i
	TE25tvCAepE/6awAsX0ult3xT39JBVXPHa1GkpJuU5USTFH9/VKnmnwRvEnG9PWPO07h38IP78L
	geYWc7EMCxn4Kk68dEkrCm9ZuC6y6gl1knPqDIQueaOegVCuXvJBGC9zrhEh3W/yTLIqTbPQtnX
	4+9HeJ/dULaNJ4hfKcQhA4kTb4INYwcQ0XocuHqjH6OdhCrhR2
X-Received: by 2002:a05:6a00:17a4:b0:82c:9e00:f958 with SMTP id d2e1a72fcca58-8434c9ce62cmr10965777b3a.0.1781446410064;
        Sun, 14 Jun 2026 07:13:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm7561589b3a.0.2026.06.14.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:13:29 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: sja1105: fix lastused timestamp in flower stats
Date: Sun, 14 Jun 2026 22:13:16 +0800
Message-ID: <20260614141320.1133321-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299229-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:olteanv@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9645568142F

flow_stats_update() takes an absolute timestamp for lastused, not delta.
Fix that.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/sja1105/sja1105_vl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_vl.c b/drivers/net/dsa/sja1105/sja1105_vl.c
index 0ae9cb5ea8d1..e6ba9d4f8d1e 100644
--- a/drivers/net/dsa/sja1105/sja1105_vl.c
+++ b/drivers/net/dsa/sja1105/sja1105_vl.c
@@ -791,8 +791,7 @@ int sja1105_vl_stats(struct sja1105_private *priv, int port,
 	pkts = timingerr + unreleased + lengtherr;
 
 	flow_stats_update(stats, 0, pkts - rule->vl.stats.pkts, 0,
-			  jiffies - rule->vl.stats.lastused,
-			  FLOW_ACTION_HW_STATS_IMMEDIATE);
+			  jiffies, FLOW_ACTION_HW_STATS_IMMEDIATE);
 
 	rule->vl.stats.pkts = pkts;
 	rule->vl.stats.lastused = jiffies;
-- 
2.53.0


